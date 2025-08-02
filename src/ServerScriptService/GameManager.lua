-- GameManager.lua
-- Основной менеджер игры на сервере

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Загружаем модули
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))
local Utilities = require(ReplicatedStorage.Modules:WaitForChild("Utilities"))

local GameManager = {}

-- Состояние игры
GameManager.CurrentState = GameData.GameStates.WAITING
GameManager.CurrentWave = 0
GameManager.PlayersData = {}
GameManager.CountdownTime = 0
GameManager.BaseHealth = GameData.Settings.BaseHealth
GameManager.ActiveZombies = {}

-- События
local gameStateChangedEvent = RemoteEvents.GetRemoteEvent("GameStateChanged")
local waveStartedEvent = RemoteEvents.GetRemoteEvent("WaveStarted")
local waveCompletedEvent = RemoteEvents.GetRemoteEvent("WaveCompleted")
local gameOverEvent = RemoteEvents.GetRemoteEvent("GameOver")
local coinsChangedEvent = RemoteEvents.GetRemoteEvent("CoinsChanged")
local baseDamagedEvent = RemoteEvents.GetRemoteEvent("BaseDamaged")
local updateUIEvent = RemoteEvents.GetRemoteEvent("UpdateUI")

-- Функции Remote Functions
local getPlayerDataFunction = RemoteEvents.GetRemoteFunction("GetPlayerData")
local canPurchaseWeaponFunction = RemoteEvents.GetRemoteFunction("CanPurchaseWeapon")
local canUpgradeWeaponFunction = RemoteEvents.GetRemoteFunction("CanUpgradeWeapon")

-- Инициализация игрока
function GameManager.InitializePlayer(player)
    Utilities.Debug("Инициализация игрока: " .. player.Name)
    
    -- Загружаем данные игрока
    local playerData = Utilities.LoadPlayerData(player)
    
    GameManager.PlayersData[player.UserId] = {
        Player = player,
        Coins = playerData.Coins or GameData.Settings.StartingCoins,
        Experience = playerData.Experience or 0,
        Level = playerData.Level or 1,
        Weapons = playerData.Weapons or {"Glock"},
        WeaponLevels = playerData.WeaponLevels or {Glock = 1},
        UnlockedWeapons = playerData.UnlockedWeapons or {"Glock"},
        CurrentWeapon = "Glock",
        IsAlive = true,
        Kills = 0,
        DamageDealt = 0
    }
    
    -- Отправляем начальные данные клиенту
    GameManager.SendPlayerDataUpdate(player)
    GameManager.SendGameStateUpdate(player)
end

-- Удаление игрока
function GameManager.RemovePlayer(player)
    Utilities.Debug("Удаление игрока: " .. player.Name)
    
    -- Сохраняем данные игрока
    if GameManager.PlayersData[player.UserId] then
        Utilities.SavePlayerData(player, GameManager.PlayersData[player.UserId])
        GameManager.PlayersData[player.UserId] = nil
    end
end

-- Отправка обновления данных игрока
function GameManager.SendPlayerDataUpdate(player)
    local playerData = GameManager.PlayersData[player.UserId]
    if playerData then
        updateUIEvent:FireClient(player, "PlayerData", {
            Coins = playerData.Coins,
            Experience = playerData.Experience,
            Level = playerData.Level,
            Weapons = playerData.Weapons,
            WeaponLevels = playerData.WeaponLevels,
            CurrentWeapon = playerData.CurrentWeapon,
            Kills = playerData.Kills,
            DamageDealt = playerData.DamageDealt
        })
    end
end

-- Отправка обновления состояния игры
function GameManager.SendGameStateUpdate(player)
    local gameState = {
        State = GameManager.CurrentState,
        Wave = GameManager.CurrentWave,
        CountdownTime = GameManager.CountdownTime,
        BaseHealth = GameManager.BaseHealth,
        MaxBaseHealth = GameData.Settings.BaseHealth,
        AliveZombies = #GameManager.ActiveZombies,
        PlayersAlive = GameManager.GetAlivePlayers()
    }
    
    if player then
        updateUIEvent:FireClient(player, "GameState", gameState)
    else
        updateUIEvent:FireAllClients("GameState", gameState)
    end
end

-- Получение количества живых игроков
function GameManager.GetAlivePlayers()
    local count = 0
    for _, playerData in pairs(GameManager.PlayersData) do
        if playerData.IsAlive then
            count = count + 1
        end
    end
    return count
end

-- Изменение состояния игры
function GameManager.ChangeGameState(newState)
    if GameManager.CurrentState ~= newState then
        Utilities.Debug("Изменение состояния игры: " .. GameManager.CurrentState .. " -> " .. newState)
        GameManager.CurrentState = newState
        gameStateChangedEvent:FireAllClients(newState)
        GameManager.SendGameStateUpdate()
    end
end

-- Начало новой игры
function GameManager.StartNewGame()
    Utilities.Debug("Начало новой игры")
    
    GameManager.CurrentWave = 0
    GameManager.BaseHealth = GameData.Settings.BaseHealth
    GameManager.ActiveZombies = {}
    
    -- Сброс статистики игроков
    for _, playerData in pairs(GameManager.PlayersData) do
        playerData.IsAlive = true
        playerData.Kills = 0
        playerData.DamageDealt = 0
    end
    
    GameManager.ChangeGameState(GameData.GameStates.PREPARING)
    GameManager.StartCountdown(GameData.Settings.PrepareTime)
end

-- Запуск следующей волны
function GameManager.StartNextWave()
    GameManager.CurrentWave = GameManager.CurrentWave + 1
    Utilities.Debug("Запуск волны " .. GameManager.CurrentWave)
    
    if GameManager.CurrentWave > GameData.Settings.MaxWaves then
        GameManager.Victory()
        return
    end
    
    GameManager.ChangeGameState(GameData.GameStates.WAVE_ACTIVE)
    waveStartedEvent:FireAllClients(GameManager.CurrentWave)
    
    -- Запускаем спавн зомби через ZombieController
    local zombieController = require(script.Parent:WaitForChild("ZombieController"))
    zombieController.StartWave(GameManager.CurrentWave)
end

-- Завершение волны
function GameManager.CompleteWave()
    Utilities.Debug("Волна " .. GameManager.CurrentWave .. " завершена")
    
    GameManager.ChangeGameState(GameData.GameStates.WAVE_COMPLETE)
    waveCompletedEvent:FireAllClients(GameManager.CurrentWave)
    
    -- Награждаем игроков за завершение волны
    local waveBonus = 50 + (GameManager.CurrentWave * 10)
    for _, playerData in pairs(GameManager.PlayersData) do
        if playerData.IsAlive then
            GameManager.AddCoins(playerData.Player, waveBonus)
        end
    end
    
    -- Запускаем обратный отсчет до следующей волны
    GameManager.StartCountdown(GameData.Settings.WaveCountdown)
end

-- Поражение
function GameManager.GameOver()
    Utilities.Debug("Игра окончена - поражение")
    
    GameManager.ChangeGameState(GameData.GameStates.GAME_OVER)
    gameOverEvent:FireAllClients("defeat")
    
    -- Очищаем зомби
    GameManager.ClearAllZombies()
    
    -- Перезапуск через некоторое время
    wait(GameData.Settings.GameOverDelay)
    GameManager.StartNewGame()
end

-- Победа
function GameManager.Victory()
    Utilities.Debug("Игра окончена - победа!")
    
    GameManager.ChangeGameState(GameData.GameStates.VICTORY)
    gameOverEvent:FireAllClients("victory")
    
    -- Большой бонус за победу
    local victoryBonus = 1000
    for _, playerData in pairs(GameManager.PlayersData) do
        GameManager.AddCoins(playerData.Player, victoryBonus)
    end
    
    -- Очищаем зомби
    GameManager.ClearAllZombies()
    
    -- Перезапуск через некоторое время
    wait(GameData.Settings.GameOverDelay * 2)
    GameManager.StartNewGame()
end

-- Обратный отсчет
function GameManager.StartCountdown(duration)
    GameManager.CountdownTime = duration
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        GameManager.CountdownTime = GameManager.CountdownTime - 1/60
        
        if GameManager.CountdownTime <= 0 then
            connection:Disconnect()
            
            if GameManager.CurrentState == GameData.GameStates.PREPARING then
                GameManager.StartNextWave()
            elseif GameManager.CurrentState == GameData.GameStates.WAVE_COMPLETE then
                GameManager.StartNextWave()
            end
        end
        
        GameManager.SendGameStateUpdate()
    end)
end

-- Урон по базе
function GameManager.DamageBase(damage)
    GameManager.BaseHealth = math.max(0, GameManager.BaseHealth - damage)
    Utilities.Debug("База получила урон: " .. damage .. " (осталось: " .. GameManager.BaseHealth .. ")")
    
    baseDamagedEvent:FireAllClients(GameManager.BaseHealth, GameData.Settings.BaseHealth)
    
    if GameManager.BaseHealth <= 0 then
        GameManager.GameOver()
    end
    
    GameManager.SendGameStateUpdate()
end

-- Добавление монет игроку
function GameManager.AddCoins(player, amount)
    local playerData = GameManager.PlayersData[player.UserId]
    if playerData then
        playerData.Coins = playerData.Coins + amount
        coinsChangedEvent:FireClient(player, playerData.Coins, amount)
        GameManager.SendPlayerDataUpdate(player)
        
        Utilities.Debug(player.Name .. " получил " .. amount .. " монет (всего: " .. playerData.Coins .. ")")
    end
end

-- Добавление опыта игроку
function GameManager.AddExperience(player, amount)
    local playerData = GameManager.PlayersData[player.UserId]
    if playerData then
        playerData.Experience = playerData.Experience + amount
        
        -- Проверяем повышение уровня
        local newLevel = GameData.GetLevelFromExperience(playerData.Experience)
        if newLevel > playerData.Level then
            GameManager.LevelUp(player, newLevel)
        end
        
        GameManager.SendPlayerDataUpdate(player)
    end
end

-- Повышение уровня игрока
function GameManager.LevelUp(player, newLevel)
    local playerData = GameManager.PlayersData[player.UserId]
    if playerData then
        local oldLevel = playerData.Level
        playerData.Level = newLevel
        
        Utilities.Debug(player.Name .. " повысил уровень: " .. oldLevel .. " -> " .. newLevel)
        
        -- Выдаем награды за уровень
        local rewards = GameData.LevelRewards[newLevel]
        if rewards then
            if rewards.Coins then
                GameManager.AddCoins(player, rewards.Coins)
            end
            
            if rewards.UnlockWeapon then
                table.insert(playerData.UnlockedWeapons, rewards.UnlockWeapon)
                Utilities.Debug(player.Name .. " разблокировал оружие: " .. rewards.UnlockWeapon)
            end
            
            -- Отправляем сообщение о повышении уровня
            updateUIEvent:FireClient(player, "LevelUp", {
                NewLevel = newLevel,
                Message = rewards.Message or ("Уровень " .. newLevel .. "!")
            })
        end
        
        GameManager.SendPlayerDataUpdate(player)
    end
end

-- Регистрация убийства зомби
function GameManager.RegisterZombieKill(player, zombieType, damage)
    local playerData = GameManager.PlayersData[player.UserId]
    if playerData then
        playerData.Kills = playerData.Kills + 1
        playerData.DamageDealt = playerData.DamageDealt + damage
        
        -- Добавляем опыт
        local experience = GameData.LevelSystem.ExperiencePerKill[zombieType] or 10
        GameManager.AddExperience(player, experience)
        
        Utilities.Debug(player.Name .. " убил зомби типа " .. zombieType)
    end
end

-- Очистка всех зомби
function GameManager.ClearAllZombies()
    for _, zombie in ipairs(GameManager.ActiveZombies) do
        if zombie and zombie.Parent then
            zombie:Destroy()
        end
    end
    GameManager.ActiveZombies = {}
end

-- Регистрация зомби
function GameManager.RegisterZombie(zombie)
    table.insert(GameManager.ActiveZombies, zombie)
end

-- Удаление зомби из списка
function GameManager.UnregisterZombie(zombie)
    for i, activeZombie in ipairs(GameManager.ActiveZombies) do
        if activeZombie == zombie then
            table.remove(GameManager.ActiveZombies, i)
            break
        end
    end
    
    -- Проверяем завершение волны
    if #GameManager.ActiveZombies == 0 and GameManager.CurrentState == GameData.GameStates.WAVE_ACTIVE then
        GameManager.CompleteWave()
    end
end

-- Обработчики Remote Functions
getPlayerDataFunction.OnServerInvoke = function(player)
    return GameManager.PlayersData[player.UserId]
end

canPurchaseWeaponFunction.OnServerInvoke = function(player, weaponId)
    local playerData = GameManager.PlayersData[player.UserId]
    local WeaponData = require(ReplicatedStorage.Modules:WaitForChild("WeaponData"))
    local weapon = WeaponData.Weapons[weaponId]
    
    if not playerData or not weapon then
        return false, "Данные не найдены"
    end
    
    if weapon.UnlockLevel > playerData.Level then
        return false, "Недостаточный уровень"
    end
    
    if playerData.Coins < weapon.Price then
        return false, "Недостаточно монет"
    end
    
    -- Проверяем, есть ли уже это оружие
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            return false, "Оружие уже куплено"
        end
    end
    
    return true, "Можно купить"
end

canUpgradeWeaponFunction.OnServerInvoke = function(player, weaponId)
    local playerData = GameManager.PlayersData[player.UserId]
    local WeaponData = require(ReplicatedStorage.Modules:WaitForChild("WeaponData"))
    local weapon = WeaponData.Weapons[weaponId]
    
    if not playerData or not weapon then
        return false, "Данные не найдены"
    end
    
    local currentLevel = playerData.WeaponLevels[weaponId] or 1
    if currentLevel >= weapon.MaxUpgradeLevel then
        return false, "Максимальный уровень"
    end
    
    local upgradeCost = WeaponData.GetUpgradeCost(weaponId, currentLevel)
    if not upgradeCost then
        return false, "Нельзя улучшить"
    end
    
    if playerData.Coins < upgradeCost then
        return false, "Недостаточно монет"
    end
    
    return true, "Можно улучшить"
end

-- Обработчики событий подключения/отключения игроков
Players.PlayerAdded:Connect(function(player)
    GameManager.InitializePlayer(player)
    
    -- Если это первый игрок и игра в ожидании, начинаем игру
    if GameManager.CurrentState == GameData.GameStates.WAITING and GameManager.GetAlivePlayers() >= 1 then
        GameManager.StartNewGame()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    GameManager.RemovePlayer(player)
    
    -- Если игроков не осталось, переводим в режим ожидания
    if GameManager.GetAlivePlayers() == 0 then
        GameManager.ChangeGameState(GameData.GameStates.WAITING)
        GameManager.ClearAllZombies()
    end
end)

-- Инициализация GameManager
function GameManager.Initialize()
    Utilities.Debug("Инициализация GameManager")
    
    -- Инициализируем уже подключенных игроков
    for _, player in ipairs(Players:GetPlayers()) do
        GameManager.InitializePlayer(player)
    end
    
    -- Если есть игроки, начинаем игру
    if GameManager.GetAlivePlayers() >= 1 then
        GameManager.StartNewGame()
    end
end

-- Запускаем инициализацию
GameManager.Initialize()

return GameManager