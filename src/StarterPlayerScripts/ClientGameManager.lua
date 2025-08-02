-- ClientGameManager.lua
-- Клиентский менеджер игры

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Загружаем модули
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))
local Utilities = require(ReplicatedStorage.Modules:WaitForChild("Utilities"))

local ClientGameManager = {}

-- Состояние клиента
ClientGameManager.PlayerData = {}
ClientGameManager.GameState = {}
ClientGameManager.CurrentWeapon = nil
ClientGameManager.WeaponAmmo = {}
ClientGameManager.IsReloading = false
ClientGameManager.LastShotTime = 0
ClientGameManager.ShopOpen = false

-- События
local gameStateChangedEvent = RemoteEvents.GetRemoteEvent("GameStateChanged")
local waveStartedEvent = RemoteEvents.GetRemoteEvent("WaveStarted")
local waveCompletedEvent = RemoteEvents.GetRemoteEvent("WaveCompleted")
local gameOverEvent = RemoteEvents.GetRemoteEvent("GameOver")
local coinsChangedEvent = RemoteEvents.GetRemoteEvent("CoinsChanged")
local baseDamagedEvent = RemoteEvents.GetRemoteEvent("BaseDamaged")
local updateUIEvent = RemoteEvents.GetRemoteEvent("UpdateUI")
local weaponFiredEvent = RemoteEvents.GetRemoteEvent("WeaponFired")
local weaponReloadedEvent = RemoteEvents.GetRemoteEvent("WeaponReloaded")
local weaponSwitchedEvent = RemoteEvents.GetRemoteEvent("WeaponSwitched")
local showShopEvent = RemoteEvents.GetRemoteEvent("ShowShop")
local hideShopEvent = RemoteEvents.GetRemoteEvent("HideShop")

-- Функции Remote Functions
local getPlayerDataFunction = RemoteEvents.GetRemoteFunction("GetPlayerData")
local getWeaponDataFunction = RemoteEvents.GetRemoteFunction("GetWeaponData")

-- Обработчики событий
gameStateChangedEvent.OnClientEvent:Connect(function(newState)
    ClientGameManager.GameState.State = newState
    ClientGameManager.UpdateGameStateUI()
    
    if newState == GameData.GameStates.PREPARING then
        ClientGameManager.ShowNotification("Подготовка к следующей волне!", Color3.fromRGB(255, 255, 0))
    elseif newState == GameData.GameStates.WAVE_ACTIVE then
        ClientGameManager.ShowNotification("Волна началась!", Color3.fromRGB(255, 100, 100))
    elseif newState == GameData.GameStates.WAVE_COMPLETE then
        ClientGameManager.ShowNotification("Волна завершена!", Color3.fromRGB(100, 255, 100))
    end
end)

waveStartedEvent.OnClientEvent:Connect(function(waveNumber)
    ClientGameManager.ShowNotification("Волна " .. waveNumber .. " началась!", Color3.fromRGB(255, 0, 0))
    Utilities.PlaySound(GameData.Sounds.WaveStart, 0.7)
end)

waveCompletedEvent.OnClientEvent:Connect(function(waveNumber)
    ClientGameManager.ShowNotification("Волна " .. waveNumber .. " завершена!", Color3.fromRGB(0, 255, 0))
    Utilities.PlaySound(GameData.Sounds.Victory, 0.5)
end)

gameOverEvent.OnClientEvent:Connect(function(result)
    if result == "victory" then
        ClientGameManager.ShowNotification("ПОБЕДА! Все волны отбиты!", Color3.fromRGB(255, 215, 0), 5)
        Utilities.PlaySound(GameData.Sounds.Victory, 1.0)
    else
        ClientGameManager.ShowNotification("ПОРАЖЕНИЕ! База разрушена!", Color3.fromRGB(255, 0, 0), 5)
        Utilities.PlaySound(GameData.Sounds.GameOver, 1.0)
    end
end)

coinsChangedEvent.OnClientEvent:Connect(function(newCoins, change)
    ClientGameManager.PlayerData.Coins = newCoins
    ClientGameManager.UpdateCoinsUI()
    
    if change > 0 then
        ClientGameManager.ShowFloatingText("+" .. change .. " монет", Color3.fromRGB(255, 215, 0))
        Utilities.PlaySound(GameData.Sounds.CoinPickup, 0.3)
    end
end)

baseDamagedEvent.OnClientEvent:Connect(function(currentHealth, maxHealth)
    ClientGameManager.GameState.BaseHealth = currentHealth
    ClientGameManager.GameState.MaxBaseHealth = maxHealth
    ClientGameManager.UpdateBaseHealthUI()
    
    Utilities.PlaySound(GameData.Sounds.BaseDamage, 0.8)
    ClientGameManager.ShowNotification("База получила урон!", Color3.fromRGB(255, 100, 100))
end)

updateUIEvent.OnClientEvent:Connect(function(updateType, data)
    if updateType == "PlayerData" then
        ClientGameManager.PlayerData = data
        ClientGameManager.UpdatePlayerDataUI()
    elseif updateType == "GameState" then
        ClientGameManager.GameState = data
        ClientGameManager.UpdateGameStateUI()
    elseif updateType == "LevelUp" then
        ClientGameManager.ShowLevelUpNotification(data)
    elseif updateType == "WeaponPurchased" then
        ClientGameManager.ShowNotification("Куплено: " .. data.WeaponName, Color3.fromRGB(100, 255, 100))
    elseif updateType == "WeaponUpgraded" then
        ClientGameManager.ShowNotification("Улучшено: " .. data.WeaponName .. " (Ур." .. data.NewLevel .. ")", Color3.fromRGB(100, 200, 255))
    end
end)

weaponFiredEvent.OnClientEvent:Connect(function(shooter, weaponId, targetPosition, targetZombie)
    if shooter ~= player then
        -- Показываем эффекты выстрела других игроков
        ClientGameManager.ShowOtherPlayerMuzzleFlash(shooter, weaponId)
    end
end)

weaponReloadedEvent.OnClientEvent:Connect(function(reloader, weaponId)
    if reloader == player then
        ClientGameManager.IsReloading = false
        ClientGameManager.ShowNotification("Перезарядка завершена", Color3.fromRGB(200, 200, 200))
    end
end)

weaponSwitchedEvent.OnClientEvent:Connect(function(switcher, weaponId)
    if switcher == player then
        ClientGameManager.CurrentWeapon = weaponId
        ClientGameManager.UpdateWeaponUI()
        ClientGameManager.InitializeWeaponAmmo()
    end
end)

-- Управление вводом
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        -- Стрельба
        ClientGameManager.FireWeapon()
    elseif input.KeyCode == Enum.KeyCode.R then
        -- Перезарядка
        ClientGameManager.ReloadWeapon()
    elseif input.KeyCode == Enum.KeyCode.Tab then
        -- Открыть/закрыть магазин
        ClientGameManager.ToggleShop()
    elseif input.KeyCode == Enum.KeyCode.One then
        ClientGameManager.SwitchWeapon(1)
    elseif input.KeyCode == Enum.KeyCode.Two then
        ClientGameManager.SwitchWeapon(2)
    elseif input.KeyCode == Enum.KeyCode.Three then
        ClientGameManager.SwitchWeapon(3)
    elseif input.KeyCode == Enum.KeyCode.Four then
        ClientGameManager.SwitchWeapon(4)
    elseif input.KeyCode == Enum.KeyCode.Five then
        ClientGameManager.SwitchWeapon(5)
    end
end)

-- Инициализация данных игрока
function ClientGameManager.InitializePlayerData()
    local playerData = getPlayerDataFunction:InvokeServer()
    if playerData then
        ClientGameManager.PlayerData = playerData
        ClientGameManager.CurrentWeapon = playerData.CurrentWeapon
        ClientGameManager.InitializeWeaponAmmo()
        ClientGameManager.UpdatePlayerDataUI()
    end
end

-- Инициализация боеприпасов оружия
function ClientGameManager.InitializeWeaponAmmo()
    ClientGameManager.WeaponAmmo = {}
    
    if ClientGameManager.PlayerData.Weapons then
        for _, weaponId in ipairs(ClientGameManager.PlayerData.Weapons) do
            local weaponLevel = ClientGameManager.PlayerData.WeaponLevels[weaponId] or 1
            local weaponStats = getWeaponDataFunction:InvokeServer(weaponId, weaponLevel)
            
            if weaponStats then
                ClientGameManager.WeaponAmmo[weaponId] = {
                    Current = weaponStats.MagazineSize,
                    Max = weaponStats.MagazineSize
                }
            end
        end
    end
end

-- Стрельба
function ClientGameManager.FireWeapon()
    if not ClientGameManager.CurrentWeapon or ClientGameManager.IsReloading then
        return
    end
    
    if not player.Character or not player.Character.PrimaryPart then
        return
    end
    
    local weaponLevel = ClientGameManager.PlayerData.WeaponLevels[ClientGameManager.CurrentWeapon] or 1
    local weaponStats = getWeaponDataFunction:InvokeServer(ClientGameManager.CurrentWeapon, weaponLevel)
    
    if not weaponStats then
        return
    end
    
    -- Проверяем скорострельность
    local currentTime = tick()
    if currentTime - ClientGameManager.LastShotTime < weaponStats.FireRate then
        return
    end
    
    -- Проверяем боеприпасы
    local ammo = ClientGameManager.WeaponAmmo[ClientGameManager.CurrentWeapon]
    if not ammo or ammo.Current <= 0 then
        -- Автоматическая перезарядка если кончились патроны
        ClientGameManager.ReloadWeapon()
        return
    end
    
    -- Находим ближайшего зомби
    local targetZombie, distance = ClientGameManager.FindClosestZombie(weaponStats.Range)
    
    if targetZombie then
        local targetPosition = targetZombie.PrimaryPart.Position
        
        -- Отправляем выстрел на сервер
        weaponFiredEvent:FireServer(ClientGameManager.CurrentWeapon, targetPosition, targetZombie)
        
        -- Уменьшаем боеприпасы
        ammo.Current = ammo.Current - 1
        ClientGameManager.LastShotTime = currentTime
        
        -- Обновляем UI
        ClientGameManager.UpdateWeaponUI()
        
        -- Создаем эффекты на клиенте
        ClientGameManager.CreateShootingEffects(targetPosition)
    else
        ClientGameManager.ShowNotification("Нет целей в радиусе!", Color3.fromRGB(255, 255, 100))
    end
end

-- Перезарядка
function ClientGameManager.ReloadWeapon()
    if not ClientGameManager.CurrentWeapon or ClientGameManager.IsReloading then
        return
    end
    
    local ammo = ClientGameManager.WeaponAmmo[ClientGameManager.CurrentWeapon]
    if not ammo or ammo.Current >= ammo.Max then
        return -- Магазин полный
    end
    
    local weaponLevel = ClientGameManager.PlayerData.WeaponLevels[ClientGameManager.CurrentWeapon] or 1
    local weaponStats = getWeaponDataFunction:InvokeServer(ClientGameManager.CurrentWeapon, weaponLevel)
    
    if not weaponStats then
        return
    end
    
    ClientGameManager.IsReloading = true
    ClientGameManager.ShowNotification("Перезарядка...", Color3.fromRGB(200, 200, 200))
    
    -- Отправляем на сервер
    weaponReloadedEvent:FireServer(ClientGameManager.CurrentWeapon)
    
    -- Ждем время перезарядки
    wait(weaponStats.ReloadTime)
    
    -- Восстанавливаем боеприпасы
    ammo.Current = ammo.Max
    ClientGameManager.IsReloading = false
    
    ClientGameManager.UpdateWeaponUI()
end

-- Переключение оружия
function ClientGameManager.SwitchWeapon(slot)
    if not ClientGameManager.PlayerData.Weapons or not ClientGameManager.PlayerData.Weapons[slot] then
        return
    end
    
    local weaponId = ClientGameManager.PlayerData.Weapons[slot]
    if weaponId ~= ClientGameManager.CurrentWeapon then
        weaponSwitchedEvent:FireServer(weaponId)
    end
end

-- Поиск ближайшего зомби
function ClientGameManager.FindClosestZombie(maxRange)
    if not player.Character or not player.Character.PrimaryPart then
        return nil
    end
    
    local playerPosition = player.Character.PrimaryPart.Position
    local closestZombie = nil
    local closestDistance = maxRange or math.huge
    
    -- Ищем зомби в workspace
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("ZombieData") then
            if obj.PrimaryPart and obj.Humanoid.Health > 0 then
                local distance = Utilities.GetDistance(playerPosition, obj.PrimaryPart.Position)
                
                if distance < closestDistance then
                    -- Проверяем линию видимости
                    local hasLineOfSight = Utilities.HasLineOfSight(
                        playerPosition + Vector3.new(0, 5, 0),
                        obj.PrimaryPart.Position + Vector3.new(0, 3, 0),
                        {player.Character}
                    )
                    
                    if hasLineOfSight then
                        closestDistance = distance
                        closestZombie = obj
                    end
                end
            end
        end
    end
    
    return closestZombie, closestDistance
end

-- Создание эффектов стрельбы
function ClientGameManager.CreateShootingEffects(targetPosition)
    if not player.Character or not player.Character.PrimaryPart then
        return
    end
    
    local startPosition = player.Character.PrimaryPart.Position + Vector3.new(0, 1, 0)
    
    -- Создаем трассирующую линию
    local beam = Instance.new("Beam")
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Position = Vector3.new(0, 0, 0)
    attachment1.Parent = player.Character.PrimaryPart
    
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.Transparency = 1
    part.CanCollide = false
    part.Anchored = true
    part.Position = targetPosition
    part.Parent = workspace
    
    local attachment2 = Instance.new("Attachment")
    attachment2.Position = Vector3.new(0, 0, 0)
    attachment2.Parent = part
    
    beam.Attachment0 = attachment1
    beam.Attachment1 = attachment2
    beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 100))
    beam.Transparency = NumberSequence.new(0.5)
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.Parent = workspace
    
    -- Удаляем эффект
    game:GetService("Debris"):AddItem(part, 0.1)
    game:GetService("Debris"):AddItem(beam, 0.1)
end

-- Показ эффектов выстрела других игроков
function ClientGameManager.ShowOtherPlayerMuzzleFlash(shooter, weaponId)
    if shooter.Character and shooter.Character.PrimaryPart then
        local light = Instance.new("PointLight")
        light.Brightness = 1
        light.Color = Color3.fromRGB(255, 255, 100)
        light.Range = 5
        light.Parent = shooter.Character.PrimaryPart
        
        game:GetService("Debris"):AddItem(light, 0.1)
    end
end

-- Переключение магазина
function ClientGameManager.ToggleShop()
    if ClientGameManager.ShopOpen then
        hideShopEvent:FireServer()
        ClientGameManager.ShopOpen = false
    else
        showShopEvent:FireServer()
        ClientGameManager.ShopOpen = true
    end
end

-- Показ уведомления
function ClientGameManager.ShowNotification(message, color, duration)
    color = color or Color3.fromRGB(255, 255, 255)
    duration = duration or 3
    
    -- Создаем уведомление в StarterGui
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = message,
        Color = color,
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size18
    })
end

-- Показ плавающего текста
function ClientGameManager.ShowFloatingText(text, color)
    if player.Character and player.Character.PrimaryPart then
        local position = player.Character.PrimaryPart.Position + Vector3.new(0, 8, 0)
        Utilities.Create3DText(text, position, color, 2, 2)
    end
end

-- Показ уведомления о повышении уровня
function ClientGameManager.ShowLevelUpNotification(data)
    ClientGameManager.ShowNotification(data.Message, Color3.fromRGB(255, 215, 0), 5)
    
    -- Создаем специальный эффект
    if player.Character and player.Character.PrimaryPart then
        for i = 1, 5 do
            spawn(function()
                wait(i * 0.2)
                local position = player.Character.PrimaryPart.Position + Vector3.new(
                    math.random(-3, 3), 
                    8 + i, 
                    math.random(-3, 3)
                )
                Utilities.Create3DText("★ УРОВЕНЬ " .. data.NewLevel .. " ★", position, Color3.fromRGB(255, 215, 0), 3, 3)
            end)
        end
    end
end

-- Обновление UI
function ClientGameManager.UpdatePlayerDataUI()
    -- Эти функции будут вызывать соответствующие UI элементы
    -- Пока что просто выводим информацию в консоль
    if ClientGameManager.PlayerData.Coins then
        ClientGameManager.UpdateCoinsUI()
    end
    
    if ClientGameManager.PlayerData.Level then
        ClientGameManager.UpdateLevelUI()
    end
    
    if ClientGameManager.CurrentWeapon then
        ClientGameManager.UpdateWeaponUI()
    end
end

function ClientGameManager.UpdateCoinsUI()
    -- Здесь будет обновление UI монет
    -- print("Монеты: " .. (ClientGameManager.PlayerData.Coins or 0))
end

function ClientGameManager.UpdateLevelUI()
    -- Здесь будет обновление UI уровня
    -- print("Уровень: " .. (ClientGameManager.PlayerData.Level or 1))
end

function ClientGameManager.UpdateWeaponUI()
    -- Здесь будет обновление UI оружия
    if ClientGameManager.CurrentWeapon and ClientGameManager.WeaponAmmo[ClientGameManager.CurrentWeapon] then
        local ammo = ClientGameManager.WeaponAmmo[ClientGameManager.CurrentWeapon]
        -- print("Патроны: " .. ammo.Current .. "/" .. ammo.Max)
    end
end

function ClientGameManager.UpdateGameStateUI()
    -- Здесь будет обновление UI состояния игры
    -- print("Состояние игры: " .. (ClientGameManager.GameState.State or "Unknown"))
end

function ClientGameManager.UpdateBaseHealthUI()
    -- Здесь будет обновление UI здоровья базы
    if ClientGameManager.GameState.BaseHealth and ClientGameManager.GameState.MaxBaseHealth then
        local healthPercent = ClientGameManager.GameState.BaseHealth / ClientGameManager.GameState.MaxBaseHealth
        -- print("Здоровье базы: " .. math.floor(healthPercent * 100) .. "%")
    end
end

-- Инициализация
function ClientGameManager.Initialize()
    Utilities.Debug("Инициализация ClientGameManager")
    
    -- Ждем загрузки персонажа
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    
    -- Инициализируем данные
    ClientGameManager.InitializePlayerData()
    
    -- Показываем инструкции
    wait(2)
    ClientGameManager.ShowNotification("Добро пожаловать в Zombie Tower Defense!", Color3.fromRGB(100, 255, 100), 5)
    wait(1)
    ClientGameManager.ShowNotification("F - Стрелять | R - Перезарядка | Tab - Магазин | 1-5 - Смена оружия", Color3.fromRGB(200, 200, 200), 8)
end

-- Запуск инициализации
spawn(function()
    ClientGameManager.Initialize()
end)

return ClientGameManager