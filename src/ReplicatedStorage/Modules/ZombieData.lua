-- ZombieData.lua
-- ModuleScript с данными всех типов зомби

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))

local ZombieData = {}

-- Базовые характеристики зомби по типам
ZombieData.Stats = {
    [GameData.ZombieTypes.BASIC] = {
        Name = "Обычный зомби",
        Health = 100,
        Speed = 12,
        Damage = 10,
        CoinReward = 25,
        Experience = 10,
        Size = Vector3.new(4, 6, 2),
        Color = Color3.fromRGB(139, 69, 19), -- Коричневый
        SpawnWeight = 10, -- Вес при спавне (больше = чаще спавнится)
        MinWave = 1, -- Минимальная волна для спавна
        Description = "Медленный но живучий противник"
    },
    
    [GameData.ZombieTypes.FAST] = {
        Name = "Быстрый зомби",
        Health = 50,
        Speed = 20,
        Damage = 8,
        CoinReward = 30,
        Experience = 15,
        Size = Vector3.new(3, 5, 1.5),
        Color = Color3.fromRGB(255, 0, 0), -- Красный
        SpawnWeight = 7,
        MinWave = 3,
        Description = "Быстрый но слабый враг"
    },
    
    [GameData.ZombieTypes.TANK] = {
        Name = "Зомби-танк",
        Health = 300,
        Speed = 8,
        Damage = 25,
        CoinReward = 75,
        Experience = 25,
        Size = Vector3.new(6, 8, 3),
        Color = Color3.fromRGB(64, 64, 64), -- Серый
        SpawnWeight = 3,
        MinWave = 5,
        Description = "Очень медленный но невероятно живучий"
    },
    
    [GameData.ZombieTypes.BOSS] = {
        Name = "Зомби-босс",
        Health = 1000,
        Speed = 10,
        Damage = 50,
        CoinReward = 200,
        Experience = 100,
        Size = Vector3.new(8, 10, 4),
        Color = Color3.fromRGB(128, 0, 128), -- Фиолетовый
        SpawnWeight = 1,
        MinWave = 10,
        Description = "Мощный босс с огромным здоровьем"
    }
}

-- Модификаторы характеристик по волнам
ZombieData.WaveModifiers = {
    -- Множители здоровья по волнам
    HealthMultiplier = {
        [1] = 1.0,   [2] = 1.1,   [3] = 1.2,   [4] = 1.3,   [5] = 1.5,
        [6] = 1.7,   [7] = 1.9,   [8] = 2.1,   [9] = 2.4,   [10] = 2.7,
        [11] = 3.0,  [12] = 3.3,  [13] = 3.7,  [14] = 4.1,  [15] = 4.5,
        [16] = 5.0,  [17] = 5.5,  [18] = 6.0,  [19] = 6.6,  [20] = 7.2,
        [21] = 8.0,  [22] = 8.8,  [23] = 9.7,  [24] = 10.7, [25] = 11.8,
        [26] = 13.0, [27] = 14.3, [28] = 15.8, [29] = 17.4, [30] = 19.2
    },
    
    -- Множители скорости (более осторожные)
    SpeedMultiplier = {
        [1] = 1.0,   [2] = 1.0,   [3] = 1.05,  [4] = 1.05,  [5] = 1.1,
        [6] = 1.1,   [7] = 1.15,  [8] = 1.15,  [9] = 1.2,   [10] = 1.2,
        [11] = 1.25, [12] = 1.25, [13] = 1.3,  [14] = 1.3,  [15] = 1.35,
        [16] = 1.35, [17] = 1.4,  [18] = 1.4,  [19] = 1.45, [20] = 1.45,
        [21] = 1.5,  [22] = 1.5,  [23] = 1.55, [24] = 1.55, [25] = 1.6,
        [26] = 1.6,  [27] = 1.65, [28] = 1.65, [29] = 1.7,  [30] = 1.75
    },
    
    -- Множители наград
    RewardMultiplier = {
        [1] = 1.0,   [2] = 1.0,   [3] = 1.1,   [4] = 1.1,   [5] = 1.2,
        [6] = 1.2,   [7] = 1.3,   [8] = 1.3,   [9] = 1.4,   [10] = 1.5,
        [11] = 1.6,  [12] = 1.7,  [13] = 1.8,  [14] = 1.9,  [15] = 2.0,
        [16] = 2.2,  [17] = 2.4,  [18] = 2.6,  [19] = 2.8,  [20] = 3.0,
        [21] = 3.3,  [22] = 3.6,  [23] = 4.0,  [24] = 4.4,  [25] = 4.8,
        [26] = 5.3,  [27] = 5.8,  [28] = 6.4,  [29] = 7.0,  [30] = 7.7
    }
}

-- Функция для получения модификатора по волне
local function getWaveModifier(modifierTable, wave)
    local maxWave = 30
    if wave <= maxWave then
        return modifierTable[wave] or modifierTable[maxWave]
    else
        -- Для волн выше 30 увеличиваем экспоненциально
        local baseModifier = modifierTable[maxWave]
        local extraWaves = wave - maxWave
        return baseModifier * (1.1 ^ extraWaves)
    end
end

-- Функция для получения характеристик зомби с учетом волны
function ZombieData.GetZombieStats(zombieType, wave)
    local baseStats = ZombieData.Stats[zombieType]
    if not baseStats then
        warn("Неизвестный тип зомби: " .. tostring(zombieType))
        return nil
    end
    
    local healthMult = getWaveModifier(ZombieData.WaveModifiers.HealthMultiplier, wave)
    local speedMult = getWaveModifier(ZombieData.WaveModifiers.SpeedMultiplier, wave)
    local rewardMult = getWaveModifier(ZombieData.WaveModifiers.RewardMultiplier, wave)
    
    return {
        Name = baseStats.Name,
        Health = math.floor(baseStats.Health * healthMult),
        MaxHealth = math.floor(baseStats.Health * healthMult),
        Speed = baseStats.Speed * speedMult,
        Damage = baseStats.Damage,
        CoinReward = math.floor(baseStats.CoinReward * rewardMult),
        Experience = math.floor(baseStats.Experience * rewardMult),
        Size = baseStats.Size,
        Color = baseStats.Color,
        Type = zombieType,
        Wave = wave,
        Description = baseStats.Description
    }
end

-- Конфигурация волн зомби
ZombieData.WaveConfigs = {
    -- Функция для генерации конфигурации волны
    GenerateWave = function(waveNumber)
        local config = {
            TotalZombies = math.min(10 + waveNumber * 2, 50), -- Максимум 50 зомби
            SpawnInterval = math.max(2 - waveNumber * 0.05, 0.5), -- Минимум 0.5 секунды
            ZombieTypes = {}
        }
        
        -- Определяем доступные типы зомби для этой волны
        local availableTypes = {}
        for zombieType, stats in pairs(ZombieData.Stats) do
            if waveNumber >= stats.MinWave then
                table.insert(availableTypes, {Type = zombieType, Weight = stats.SpawnWeight})
            end
        end
        
        -- Генерируем список зомби для волны
        for i = 1, config.TotalZombies do
            local totalWeight = 0
            for _, typeData in pairs(availableTypes) do
                totalWeight = totalWeight + typeData.Weight
            end
            
            local randomWeight = math.random() * totalWeight
            local currentWeight = 0
            
            for _, typeData in pairs(availableTypes) do
                currentWeight = currentWeight + typeData.Weight
                if randomWeight <= currentWeight then
                    table.insert(config.ZombieTypes, typeData.Type)
                    break
                end
            end
        end
        
        -- Особые волны (каждая 5-я волна - волна боссов)
        if waveNumber % 5 == 0 and waveNumber >= 10 then
            config.TotalZombies = math.ceil(config.TotalZombies * 0.3) -- Меньше зомби
            config.ZombieTypes = {}
            for i = 1, config.TotalZombies do
                table.insert(config.ZombieTypes, GameData.ZombieTypes.BOSS)
            end
            config.SpawnInterval = config.SpawnInterval * 2 -- Больше времени между спавнами
        end
        
        return config
    end
}

-- Функция для создания модели зомби
function ZombieData.CreateZombieModel(zombieStats)
    local model = Instance.new("Model")
    model.Name = zombieStats.Name
    
    -- Основная часть (тело)
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = zombieStats.Size
    torso.Material = Enum.Material.Plastic
    torso.BrickColor = BrickColor.new(zombieStats.Color)
    torso.TopSurface = Enum.SurfaceType.Smooth
    torso.BottomSurface = Enum.SurfaceType.Smooth
    torso.Parent = model
    
    -- Голова
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(zombieStats.Size.X * 0.8, zombieStats.Size.Y * 0.3, zombieStats.Size.Z * 0.8)
    head.Material = Enum.Material.Plastic
    head.BrickColor = BrickColor.new(zombieStats.Color)
    head.TopSurface = Enum.SurfaceType.Smooth
    head.BottomSurface = Enum.SurfaceType.Smooth
    head.Parent = model
    
    -- Позиционируем голову
    local headWeld = Instance.new("WeldConstraint")
    headWeld.Part0 = torso
    headWeld.Part1 = head
    headWeld.Parent = torso
    head.CFrame = torso.CFrame * CFrame.new(0, zombieStats.Size.Y * 0.65, 0)
    
    -- Humanoid для движения
    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = zombieStats.Health
    humanoid.Health = zombieStats.Health
    humanoid.WalkSpeed = zombieStats.Speed
    humanoid.JumpPower = 0 -- Зомби не прыгают
    humanoid.Parent = model
    
    -- PrimaryPart для позиционирования
    model.PrimaryPart = torso
    
    -- Humanoid Root Part
    local rootPart = Instance.new("Part")
    rootPart.Name = "HumanoidRootPart"
    rootPart.Size = Vector3.new(2, 2, 1)
    rootPart.Transparency = 1
    rootPart.CanCollide = false
    rootPart.Parent = model
    
    local rootWeld = Instance.new("WeldConstraint")
    rootWeld.Part0 = torso
    rootWeld.Part1 = rootPart
    rootWeld.Parent = torso
    
    -- Простые руки
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = i == 1 and "Left Arm" or "Right Arm"
        arm.Size = Vector3.new(zombieStats.Size.X * 0.3, zombieStats.Size.Y * 0.8, zombieStats.Size.Z * 0.3)
        arm.Material = Enum.Material.Plastic
        arm.BrickColor = BrickColor.new(zombieStats.Color)
        arm.Parent = model
        
        local armWeld = Instance.new("WeldConstraint")
        armWeld.Part0 = torso
        armWeld.Part1 = arm
        armWeld.Parent = torso
        
        local xOffset = i == 1 and -zombieStats.Size.X * 0.65 or zombieStats.Size.X * 0.65
        arm.CFrame = torso.CFrame * CFrame.new(xOffset, 0, 0)
    end
    
    -- Простые ноги
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = i == 1 and "Left Leg" or "Right Leg"
        leg.Size = Vector3.new(zombieStats.Size.X * 0.3, zombieStats.Size.Y * 0.8, zombieStats.Size.Z * 0.3)
        leg.Material = Enum.Material.Plastic
        leg.BrickColor = BrickColor.new(zombieStats.Color)
        leg.Parent = model
        
        local legWeld = Instance.new("WeldConstraint")
        legWeld.Part0 = torso
        legWeld.Part1 = leg
        legWeld.Parent = torso
        
        local xOffset = i == 1 and -zombieStats.Size.X * 0.25 or zombieStats.Size.X * 0.25
        leg.CFrame = torso.CFrame * CFrame.new(xOffset, -zombieStats.Size.Y * 0.7, 0)
    end
    
    return model
end

return ZombieData