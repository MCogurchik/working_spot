-- WeaponController.lua
-- Контроллер оружия на сервере

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Загружаем модули
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))
local WeaponData = require(ReplicatedStorage.Modules:WaitForChild("WeaponData"))
local Utilities = require(ReplicatedStorage.Modules:WaitForChild("Utilities"))

local WeaponController = {}

-- События
local weaponFiredEvent = RemoteEvents.GetRemoteEvent("WeaponFired")
local weaponReloadedEvent = RemoteEvents.GetRemoteEvent("WeaponReloaded")
local weaponSwitchedEvent = RemoteEvents.GetRemoteEvent("WeaponSwitched")

-- Обработка выстрела оружия
weaponFiredEvent.OnServerEvent:Connect(function(player, weaponId, targetPosition, targetZombie)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local zombieController = require(script.Parent:WaitForChild("ZombieController"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData or not player.Character or not player.Character.PrimaryPart then
        return
    end
    
    -- Проверяем, есть ли у игрока это оружие
    local hasWeapon = false
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            hasWeapon = true
            break
        end
    end
    
    if not hasWeapon then
        warn("Игрок пытается стрелять из оружия, которого у него нет: " .. weaponId)
        return
    end
    
    -- Получаем характеристики оружия
    local weaponLevel = playerData.WeaponLevels[weaponId] or 1
    local weaponStats = WeaponData.GetWeaponStats(weaponId, weaponLevel)
    
    if not weaponStats then
        warn("Не удалось получить характеристики оружия: " .. weaponId)
        return
    end
    
    -- Проверяем дистанцию
    local playerPosition = player.Character.PrimaryPart.Position
    local distance = Utilities.GetDistance(playerPosition, targetPosition)
    
    if distance > weaponStats.Range then
        -- Цель слишком далеко
        return
    end
    
    -- Создаем визуальный эффект выстрела
    WeaponController.CreateMuzzleFlash(player, weaponStats)
    
    -- Воспроизводим звук выстрела
    Utilities.PlaySound(weaponStats.Sound, 0.5, player.Character.PrimaryPart)
    
    -- Обрабатываем попадание
    if targetZombie and targetZombie.Parent then
        WeaponController.ProcessWeaponHit(player, weaponStats, targetZombie, targetPosition)
    elseif weaponStats.ExplosionRadius then
        -- Обрабатываем взрывное оружие
        WeaponController.ProcessExplosiveWeapon(player, weaponStats, targetPosition)
    end
    
    -- Уведомляем всех клиентов о выстреле
    weaponFiredEvent:FireAllClients(player, weaponId, targetPosition, targetZombie)
end)

-- Обработка перезарядки оружия
weaponReloadedEvent.OnServerEvent:Connect(function(player, weaponId)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return
    end
    
    -- Проверяем, есть ли у игрока это оружие
    local hasWeapon = false
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            hasWeapon = true
            break
        end
    end
    
    if not hasWeapon then
        return
    end
    
    -- Получаем характеристики оружия
    local weaponLevel = playerData.WeaponLevels[weaponId] or 1
    local weaponStats = WeaponData.GetWeaponStats(weaponId, weaponLevel)
    
    if weaponStats and player.Character and player.Character.PrimaryPart then
        -- Воспроизводим звук перезарядки
        Utilities.PlaySound(GameData.Sounds.WeaponReload, 0.3, player.Character.PrimaryPart)
        
        -- Уведомляем всех клиентов о перезарядке
        weaponReloadedEvent:FireAllClients(player, weaponId)
    end
end)

-- Обработка смены оружия
weaponSwitchedEvent.OnServerEvent:Connect(function(player, weaponId)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return
    end
    
    -- Проверяем, есть ли у игрока это оружие
    local hasWeapon = false
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            hasWeapon = true
            break
        end
    end
    
    if hasWeapon then
        playerData.CurrentWeapon = weaponId
        gameManager.SendPlayerDataUpdate(player)
        
        -- Уведомляем всех клиентов о смене оружия
        weaponSwitchedEvent:FireAllClients(player, weaponId)
        
        Utilities.Debug(player.Name .. " переключился на оружие: " .. weaponId)
    end
end)

-- Создание эффекта вспышки выстрела
function WeaponController.CreateMuzzleFlash(player, weaponStats)
    if not player.Character or not player.Character.PrimaryPart or not weaponStats.MuzzleFlash then
        return
    end
    
    -- Создаем эффект вспышки
    local muzzleFlash = Instance.new("Explosion")
    muzzleFlash.Position = player.Character.PrimaryPart.Position + player.Character.PrimaryPart.CFrame.LookVector * 3
    muzzleFlash.BlastRadius = 0
    muzzleFlash.BlastPressure = 0
    muzzleFlash.Visible = false
    muzzleFlash.Parent = workspace
    
    -- Создаем световой эффект
    local light = Instance.new("PointLight")
    light.Brightness = 2
    light.Color = Color3.fromRGB(255, 255, 100)
    light.Range = 10
    light.Parent = player.Character.PrimaryPart
    
    -- Удаляем эффект через короткое время
    game:GetService("Debris"):AddItem(light, 0.1)
    
    -- Создаем эффект частиц
    Utilities.CreateParticleEffect(player.Character.PrimaryPart, GameData.Effects.MuzzleFlash, 0.5)
end

-- Обработка попадания оружия
function WeaponController.ProcessWeaponHit(player, weaponStats, targetZombie, hitPosition)
    local zombieController = require(script.Parent:WaitForChild("ZombieController"))
    
    -- Проверяем точность
    local hitChance = weaponStats.Accuracy
    if math.random() > hitChance then
        -- Промах
        Utilities.Debug("Промах игрока " .. player.Name)
        return
    end
    
    local damage = weaponStats.Damage
    
    -- Обрабатываем дробовики (несколько дробинок)
    if weaponStats.Pellets then
        local totalDamage = 0
        for i = 1, weaponStats.Pellets do
            local pelletHitChance = hitChance * 0.8 -- Каждая дробинка имеет чуть меньший шанс попадания
            if math.random() <= pelletHitChance then
                totalDamage = totalDamage + (damage / weaponStats.Pellets)
            end
        end
        damage = totalDamage
    end
    
    -- Наносим урон зомби
    local success = zombieController.DamageZombie(targetZombie, damage, player)
    
    if success then
        Utilities.Debug(player.Name .. " нанес " .. damage .. " урона зомби")
        
        -- Создаем эффект попадания
        if targetZombie.PrimaryPart then
            Utilities.CreateParticleEffect(targetZombie.PrimaryPart, GameData.Effects.BloodSplat, 1)
        end
    end
end

-- Обработка взрывного оружия
function WeaponController.ProcessExplosiveWeapon(player, weaponStats, targetPosition)
    local zombieController = require(script.Parent:WaitForChild("ZombieController"))
    
    -- Создаем взрыв
    local damagedObjects = Utilities.CreateExplosion(
        targetPosition, 
        weaponStats.ExplosionDamage or weaponStats.Damage, 
        weaponStats.ExplosionRadius
    )
    
    -- Наносим урон всем зомби в радиусе
    for _, objectData in ipairs(damagedObjects) do
        local zombie = objectData.Object
        local damage = objectData.Damage
        
        if zombie:FindFirstChild("Humanoid") then
            zombieController.DamageZombie(zombie, damage, player)
        end
    end
    
    Utilities.Debug(player.Name .. " использовал взрывное оружие, поражено объектов: " .. #damagedObjects)
end

-- Получение оружия игрока
function WeaponController.GetPlayerWeapon(player, weaponId)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return nil
    end
    
    -- Проверяем, есть ли у игрока это оружие
    local hasWeapon = false
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            hasWeapon = true
            break
        end
    end
    
    if not hasWeapon then
        return nil
    end
    
    local weaponLevel = playerData.WeaponLevels[weaponId] or 1
    return WeaponData.GetWeaponStats(weaponId, weaponLevel)
end

-- Получение текущего оружия игрока
function WeaponController.GetPlayerCurrentWeapon(player)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData or not playerData.CurrentWeapon then
        return nil
    end
    
    return WeaponController.GetPlayerWeapon(player, playerData.CurrentWeapon)
end

-- Получение всех оружий игрока
function WeaponController.GetPlayerWeapons(player)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return {}
    end
    
    local weapons = {}
    for _, weaponId in ipairs(playerData.Weapons) do
        local weaponLevel = playerData.WeaponLevels[weaponId] or 1
        local weaponStats = WeaponData.GetWeaponStats(weaponId, weaponLevel)
        
        if weaponStats then
            table.insert(weapons, weaponStats)
        end
    end
    
    return weapons
end

-- Создание модели оружия в руках игрока
function WeaponController.CreatePlayerWeapon(player, weaponId)
    if not player.Character then
        return nil
    end
    
    -- Удаляем существующее оружие
    local existingWeapon = player.Character:FindFirstChild("PlayerWeapon")
    if existingWeapon then
        existingWeapon:Destroy()
    end
    
    -- Создаем новую модель оружия
    local weaponModel = WeaponData.CreateWeaponModel(weaponId)
    if not weaponModel then
        return nil
    end
    
    weaponModel.Name = "PlayerWeapon"
    weaponModel.Parent = player.Character
    
    -- Крепим оружие к правой руке игрока
    local rightHand = player.Character:FindFirstChild("Right Arm") or player.Character:FindFirstChild("RightHand")
    if rightHand and weaponModel.PrimaryPart then
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = rightHand
        weld.Part1 = weaponModel.PrimaryPart
        weld.Parent = rightHand
        
        -- Позиционируем оружие
        weaponModel:SetPrimaryPartCFrame(rightHand.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), 0, 0))
    end
    
    return weaponModel
end

-- Автоматическое нацеливание на ближайшего зомби
function WeaponController.GetClosestZombie(player, maxDistance)
    if not player.Character or not player.Character.PrimaryPart then
        return nil
    end
    
    local playerPosition = player.Character.PrimaryPart.Position
    local zombieController = require(script.Parent:WaitForChild("ZombieController"))
    local activeZombies = zombieController.GetActiveZombies()
    
    local closestZombie = nil
    local closestDistance = maxDistance or math.huge
    
    for _, zombie in ipairs(activeZombies) do
        if zombie and zombie.Parent and zombie.PrimaryPart then
            local distance = Utilities.GetDistance(playerPosition, zombie.PrimaryPart.Position)
            
            -- Проверяем линию видимости
            if distance < closestDistance then
                local hasLineOfSight = Utilities.HasLineOfSight(
                    playerPosition + Vector3.new(0, 5, 0), -- Немного выше игрока
                    zombie.PrimaryPart.Position + Vector3.new(0, 3, 0), -- Центр зомби
                    {player.Character} -- Игнорируем самого игрока
                )
                
                if hasLineOfSight then
                    closestDistance = distance
                    closestZombie = zombie
                end
            end
        end
    end
    
    return closestZombie, closestDistance
end

-- Система автоматического огня
function WeaponController.StartAutoFire(player, weaponId)
    local weaponStats = WeaponController.GetPlayerWeapon(player, weaponId)
    if not weaponStats or not weaponStats.AutoFire then
        return
    end
    
    -- Здесь можно реализовать логику автоматического огня
    -- Например, создать цикл, который будет автоматически стрелять
    -- пока игрок удерживает кнопку
end

-- Остановка автоматического огня
function WeaponController.StopAutoFire(player)
    -- Остановка автоматического огня
end

-- Получение статистики использования оружия
function WeaponController.GetWeaponUsageStats(player)
    -- Здесь можно добавить статистику использования оружия
    -- Количество выстрелов, попаданий, убийств для каждого оружия
    return {}
end

-- Проверка доступности оружия для игрока
function WeaponController.IsWeaponAvailable(player, weaponId)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return false
    end
    
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            return true
        end
    end
    
    return false
end

-- Получение рекомендуемого оружия для ситуации
function WeaponController.GetRecommendedWeapon(player, situation)
    local weapons = WeaponController.GetPlayerWeapons(player)
    if #weapons == 0 then
        return nil
    end
    
    -- Простая логика рекомендаций
    if situation == "close_combat" then
        -- Для ближнего боя рекомендуем дробовики
        for _, weapon in ipairs(weapons) do
            if weapon.Category == GameData.WeaponCategories.SHOTGUN then
                return weapon
            end
        end
    elseif situation == "long_range" then
        -- Для дальнего боя рекомендуем снайперские винтовки
        for _, weapon in ipairs(weapons) do
            if weapon.Category == GameData.WeaponCategories.SNIPER then
                return weapon
            end
        end
    elseif situation == "crowd_control" then
        -- Для толпы рекомендуем автоматическое оружие
        for _, weapon in ipairs(weapons) do
            if weapon.AutoFire or weapon.Category == GameData.WeaponCategories.SPECIAL then
                return weapon
            end
        end
    end
    
    -- Возвращаем оружие с наибольшим уроном
    table.sort(weapons, function(a, b) return a.Damage > b.Damage end)
    return weapons[1]
end

-- Инициализация WeaponController
function WeaponController.Initialize()
    Utilities.Debug("Инициализация WeaponController")
    
    -- Здесь можно добавить дополнительную инициализацию
end

-- Запуск инициализации
WeaponController.Initialize()

return WeaponController