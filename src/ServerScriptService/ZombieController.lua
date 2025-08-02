-- ZombieController.lua
-- Контроллер зомби на сервере

local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Загружаем модули
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))
local ZombieData = require(ReplicatedStorage.Modules:WaitForChild("ZombieData"))
local Utilities = require(ReplicatedStorage.Modules:WaitForChild("Utilities"))
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))

local ZombieController = {}

-- Состояние контроллера
ZombieController.ActiveZombies = {}
ZombieController.SpawnPoints = {}
ZombieController.BasePosition = nil
ZombieController.IsSpawning = false
ZombieController.CurrentWaveConfig = nil

-- События
local zombieSpawnedEvent = RemoteEvents.GetRemoteEvent("ZombieSpawned")
local zombieDiedEvent = RemoteEvents.GetRemoteEvent("ZombieDied")
local zombieDamagedEvent = RemoteEvents.GetRemoteEvent("ZombieDamaged")

-- Инициализация контроллера
function ZombieController.Initialize()
    Utilities.Debug("Инициализация ZombieController")
    
    -- Находим точки спавна зомби
    ZombieController.FindSpawnPoints()
    
    -- Находим базу игроков
    ZombieController.FindPlayerBase()
    
    if #ZombieController.SpawnPoints == 0 then
        warn("Не найдены точки спавна зомби! Создайте объекты с именами 'ZombieSpawn1', 'ZombieSpawn2', и т.д.")
    end
    
    if not ZombieController.BasePosition then
        warn("Не найдена база игроков! Создайте объект с именем 'PlayerBase'")
        -- Используем точку спавна игроков как базу
        local spawn = workspace:FindFirstChild("SpawnLocation")
        if spawn then
            ZombieController.BasePosition = spawn.Position
        else
            ZombieController.BasePosition = Vector3.new(0, 5, 0)
        end
    end
end

-- Поиск точек спавна зомби
function ZombieController.FindSpawnPoints()
    ZombieController.SpawnPoints = {}
    
    -- Ищем объекты с именами ZombieSpawn*
    for _, obj in ipairs(workspace:GetChildren()) do
        if string.find(obj.Name, "ZombieSpawn") then
            local position = obj.Position
            if obj:IsA("Model") and obj.PrimaryPart then
                position = obj.PrimaryPart.Position
            end
            
            table.insert(ZombieController.SpawnPoints, position)
            Utilities.Debug("Найдена точка спавна зомби: " .. obj.Name)
        end
    end
    
    -- Если не найдены точки спавна, создаем их автоматически
    if #ZombieController.SpawnPoints == 0 then
        Utilities.Debug("Создание автоматических точек спавна зомби")
        
        local basePos = ZombieController.BasePosition or Vector3.new(0, 5, 0)
        local spawnRadius = 50
        
        for i = 1, 4 do
            local angle = (i - 1) * (math.pi * 2 / 4)
            local spawnPos = basePos + Vector3.new(
                math.cos(angle) * spawnRadius,
                0,
                math.sin(angle) * spawnRadius
            )
            
            table.insert(ZombieController.SpawnPoints, spawnPos)
        end
    end
end

-- Поиск базы игроков
function ZombieController.FindPlayerBase()
    local base = workspace:FindFirstChild("PlayerBase")
    if base then
        ZombieController.BasePosition = base.Position
        if base:IsA("Model") and base.PrimaryPart then
            ZombieController.BasePosition = base.PrimaryPart.Position
        end
        Utilities.Debug("Найдена база игроков: " .. base.Name)
    end
end

-- Запуск волны зомби
function ZombieController.StartWave(waveNumber)
    if ZombieController.IsSpawning then
        Utilities.Debug("Волна уже идет, пропускаем запуск")
        return
    end
    
    Utilities.Debug("Запуск волны зомби " .. waveNumber)
    
    ZombieController.IsSpawning = true
    ZombieController.CurrentWaveConfig = ZombieData.WaveConfigs.GenerateWave(waveNumber)
    
    -- Запускаем спавн зомби
    spawn(function()
        ZombieController.SpawnWave(waveNumber, ZombieController.CurrentWaveConfig)
    end)
end

-- Спавн волны зомби
function ZombieController.SpawnWave(waveNumber, waveConfig)
    Utilities.Debug("Спавн " .. waveConfig.TotalZombies .. " зомби для волны " .. waveNumber)
    
    for i, zombieType in ipairs(waveConfig.ZombieTypes) do
        -- Получаем случайную точку спавна
        local spawnPoint = ZombieController.SpawnPoints[math.random(#ZombieController.SpawnPoints)]
        
        -- Создаем зомби
        local zombie = ZombieController.CreateZombie(zombieType, waveNumber, spawnPoint)
        if zombie then
            table.insert(ZombieController.ActiveZombies, zombie)
            
            -- Регистрируем зомби в GameManager
            local gameManager = require(script.Parent:WaitForChild("GameManager"))
            gameManager.RegisterZombie(zombie)
            
            zombieSpawnedEvent:FireAllClients(zombie, zombieType)
        end
        
        -- Ждем перед спавном следующего зомби
        if i < #waveConfig.ZombieTypes then
            wait(waveConfig.SpawnInterval)
        end
    end
    
    ZombieController.IsSpawning = false
    Utilities.Debug("Спавн волны " .. waveNumber .. " завершен")
end

-- Создание зомби
function ZombieController.CreateZombie(zombieType, wave, spawnPosition)
    local zombieStats = ZombieData.GetZombieStats(zombieType, wave)
    if not zombieStats then
        return nil
    end
    
    -- Создаем модель зомби
    local zombieModel = ZombieData.CreateZombieModel(zombieStats)
    zombieModel.Parent = workspace
    
    -- Позиционируем зомби
    if zombieModel.PrimaryPart then
        zombieModel:SetPrimaryPartCFrame(CFrame.new(spawnPosition + Vector3.new(0, zombieStats.Size.Y / 2, 0)))
    end
    
    -- Создаем полосу здоровья
    local healthBar = Utilities.CreateHealthBar(zombieModel.PrimaryPart, zombieStats.Health)
    
    -- Добавляем данные зомби в модель
    local zombieDataValue = Instance.new("ObjectValue")
    zombieDataValue.Name = "ZombieData"
    zombieDataValue.Value = zombieStats
    zombieDataValue.Parent = zombieModel
    
    -- Добавляем полосу здоровья в модель
    local healthBarValue = Instance.new("ObjectValue")
    healthBarValue.Name = "HealthBar"
    healthBarValue.Value = healthBar
    healthBarValue.Parent = zombieModel
    
    -- Настраиваем поведение зомби
    ZombieController.SetupZombieBehavior(zombieModel, zombieStats, healthBar)
    
    Utilities.Debug("Создан зомби: " .. zombieStats.Name .. " (Волна " .. wave .. ")")
    return zombieModel
end

-- Настройка поведения зомби
function ZombieController.SetupZombieBehavior(zombie, stats, healthBar)
    local humanoid = zombie:FindFirstChild("Humanoid")
    if not humanoid then
        return
    end
    
    -- Переменные для поведения
    local currentHealth = stats.Health
    local lastPathUpdate = 0
    local pathUpdateInterval = 2 -- Обновляем путь каждые 2 секунды
    local isMovingToBase = true
    local targetPlayer = nil
    local lastDamageTime = 0
    local damageInterval = 1 -- Урон раз в секунду
    
    -- Обработка смерти зомби
    humanoid.Died:Connect(function()
        ZombieController.OnZombieDied(zombie, stats)
    end)
    
    -- Обработка получения урона
    humanoid.HealthChanged:Connect(function(health)
        local damage = currentHealth - health
        if damage > 0 then
            currentHealth = health
            healthBar:UpdateHealth(currentHealth)
            
            -- Эффект получения урона
            Utilities.CreateParticleEffect(zombie.PrimaryPart, GameData.Effects.BloodSplat, 1)
            
            zombieDamagedEvent:FireAllClients(zombie, damage)
            
            if health <= 0 then
                ZombieController.OnZombieDied(zombie, stats)
            end
        end
    end)
    
    -- Основной цикл поведения зомби
    local behaviorConnection
    behaviorConnection = RunService.Heartbeat:Connect(function()
        if not zombie.Parent or not zombie.PrimaryPart then
            behaviorConnection:Disconnect()
            return
        end
        
        local currentTime = tick()
        local zombiePosition = zombie.PrimaryPart.Position
        
        -- Обновляем цель движения
        if currentTime - lastPathUpdate > pathUpdateInterval then
            lastPathUpdate = currentTime
            
            -- Ищем ближайшего игрока
            local closestPlayer = nil
            local closestDistance = math.huge
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character.PrimaryPart then
                    local distance = Utilities.GetDistance(zombiePosition, player.Character.PrimaryPart.Position)
                    if distance < closestDistance and distance < 30 then -- Радиус агро
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
            
            -- Выбираем цель
            if closestPlayer and closestPlayer.Character and closestPlayer.Character.PrimaryPart then
                targetPlayer = closestPlayer
                isMovingToBase = false
                ZombieController.MoveZombieToPosition(zombie, targetPlayer.Character.PrimaryPart.Position)
            else
                targetPlayer = nil
                isMovingToBase = true
                ZombieController.MoveZombieToPosition(zombie, ZombieController.BasePosition)
            end
        end
        
        -- Проверяем атаку
        if currentTime - lastDamageTime > damageInterval then
            local attackTarget = nil
            local attackDistance = 6 -- Дистанция атаки
            
            if targetPlayer and targetPlayer.Character and targetPlayer.Character.PrimaryPart then
                local distance = Utilities.GetDistance(zombiePosition, targetPlayer.Character.PrimaryPart.Position)
                if distance <= attackDistance then
                    attackTarget = targetPlayer
                end
            elseif isMovingToBase then
                local distanceToBase = Utilities.GetDistance(zombiePosition, ZombieController.BasePosition)
                if distanceToBase <= attackDistance then
                    attackTarget = "base"
                end
            end
            
            -- Наносим урон
            if attackTarget then
                lastDamageTime = currentTime
                
                if attackTarget == "base" then
                    -- Урон по базе
                    local gameManager = require(script.Parent:WaitForChild("GameManager"))
                    gameManager.DamageBase(stats.Damage)
                    
                    Utilities.Debug("Зомби нанес урон базе: " .. stats.Damage)
                    Utilities.PlaySound(GameData.Sounds.BaseDamage)
                else
                    -- Урон по игроку (пока что просто сообщение)
                    Utilities.Debug("Зомби атакует игрока: " .. attackTarget.Name)
                    
                    -- Здесь можно добавить урон игроку
                    if attackTarget.Character and attackTarget.Character:FindFirstChild("Humanoid") then
                        attackTarget.Character.Humanoid:TakeDamage(stats.Damage)
                    end
                end
                
                -- Анимация атаки (простая)
                ZombieController.PlayZombieAttackAnimation(zombie)
            end
        end
    end)
end

-- Движение зомби к позиции
function ZombieController.MoveZombieToPosition(zombie, targetPosition)
    local humanoid = zombie:FindFirstChild("Humanoid")
    if not humanoid or not zombie.PrimaryPart then
        return
    end
    
    local startPosition = zombie.PrimaryPart.Position
    
    -- Создаем путь
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = false,
        WaypointSpacing = 4
    })
    
    local success, errorMessage = pcall(function()
        path:ComputeAsync(startPosition, targetPosition)
    end)
    
    if success and path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        
        for i, waypoint in ipairs(waypoints) do
            if not zombie.Parent or not humanoid.Parent then
                break
            end
            
            humanoid:MoveTo(waypoint.Position)
            
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                humanoid.Jump = true
            end
            
            -- Ждем достижения точки или таймаут
            local moveTimeout = 5
            local moveStartTime = tick()
            
            repeat
                wait(0.1)
            until (zombie.PrimaryPart.Position - waypoint.Position).Magnitude < 3 
                  or tick() - moveStartTime > moveTimeout
                  or not zombie.Parent
        end
    else
        -- Простое движение напрямую, если pathfinding не сработал
        humanoid:MoveTo(targetPosition)
    end
end

-- Анимация атаки зомби
function ZombieController.PlayZombieAttackAnimation(zombie)
    -- Простая анимация поворота
    if zombie.PrimaryPart then
        local originalCFrame = zombie.PrimaryPart.CFrame
        local targetCFrame = originalCFrame * CFrame.Angles(0, math.rad(15), 0)
        
        -- Поворот в одну сторону
        zombie:SetPrimaryPartCFrame(targetCFrame)
        
        wait(0.1)
        
        -- Возврат в исходное положение
        if zombie.Parent then
            zombie:SetPrimaryPartCFrame(originalCFrame)
        end
    end
end

-- Обработка смерти зомби
function ZombieController.OnZombieDied(zombie, stats)
    Utilities.Debug("Зомби умер: " .. stats.Name)
    
    -- Удаляем из списка активных зомби
    for i, activeZombie in ipairs(ZombieController.ActiveZombies) do
        if activeZombie == zombie then
            table.remove(ZombieController.ActiveZombies, i)
            break
        end
    end
    
    -- Создаем эффект смерти
    if zombie.PrimaryPart then
        Utilities.CreateParticleEffect(zombie.PrimaryPart, GameData.Effects.BloodSplat, 2)
        Utilities.PlaySound(GameData.Sounds.ZombieDeath, 0.3, zombie.PrimaryPart)
        
        -- Показываем награду
        Utilities.Create3DText("+" .. stats.CoinReward .. " монет", 
                             zombie.PrimaryPart.Position, 
                             Color3.fromRGB(255, 215, 0), 
                             2, 2)
    end
    
    -- Уведомляем клиентов
    zombieDiedEvent:FireAllClients(zombie, stats.Type)
    
    -- Награждаем игроков (это должен делать GameManager)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    
    -- Найдем игрока, который нанес последний урон (упрощенно - ближайший игрок)
    local killer = nil
    local closestDistance = math.huge
    
    if zombie.PrimaryPart then
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character.PrimaryPart then
                local distance = Utilities.GetDistance(zombie.PrimaryPart.Position, player.Character.PrimaryPart.Position)
                if distance < closestDistance and distance < 50 then -- Максимальная дистанция для получения награды
                    closestDistance = distance
                    killer = player
                end
            end
        end
    end
    
    if killer then
        gameManager.AddCoins(killer, stats.CoinReward)
        gameManager.RegisterZombieKill(killer, stats.Type, stats.MaxHealth)
    end
    
    -- Удаляем полосу здоровья
    local healthBarValue = zombie:FindFirstChild("HealthBar")
    if healthBarValue and healthBarValue.Value then
        healthBarValue.Value:Destroy()
    end
    
    -- Удаляем зомби из GameManager
    gameManager.UnregisterZombie(zombie)
    
    -- Удаляем модель зомби через некоторое время
    game:GetService("Debris"):AddItem(zombie, 2)
end

-- Получение зомби по модели
function ZombieController.GetZombieStats(zombieModel)
    local zombieDataValue = zombieModel:FindFirstChild("ZombieData")
    if zombieDataValue then
        return zombieDataValue.Value
    end
    return nil
end

-- Нанесение урона зомби
function ZombieController.DamageZombie(zombieModel, damage, attacker)
    local humanoid = zombieModel:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health > 0 then
        humanoid:TakeDamage(damage)
        
        -- Показываем урон
        if zombieModel.PrimaryPart then
            local color = Color3.fromRGB(255, 100, 100) -- Красный для урона
            Utilities.Create3DText("-" .. math.floor(damage), 
                                 zombieModel.PrimaryPart.Position + Vector3.new(math.random(-2, 2), 3, math.random(-2, 2)), 
                                 color, 1.5, 1.5)
        end
        
        return true
    end
    return false
end

-- Очистка всех зомби
function ZombieController.ClearAllZombies()
    for _, zombie in ipairs(ZombieController.ActiveZombies) do
        if zombie and zombie.Parent then
            zombie:Destroy()
        end
    end
    ZombieController.ActiveZombies = {}
    ZombieController.IsSpawning = false
end

-- Получение количества активных зомби
function ZombieController.GetActiveZombieCount()
    return #ZombieController.ActiveZombies
end

-- Получение всех активных зомби
function ZombieController.GetActiveZombies()
    return ZombieController.ActiveZombies
end

-- Инициализация при загрузке
ZombieController.Initialize()

return ZombieController