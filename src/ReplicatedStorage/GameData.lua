-- GameData.lua
-- ModuleScript с основными данными и конфигурацией игры

local GameData = {}

-- Основные настройки игры
GameData.Settings = {
    MaxPlayers = 8,
    StartingCoins = 500,
    BaseHealth = 100,
    WaveCountdown = 30, -- секунд между волнами
    PrepareTime = 15, -- время подготовки перед первой волной
    MaxWaves = 50,
    GameOverDelay = 5 -- секунд до перезапуска после поражения
}

-- Состояния игры
GameData.GameStates = {
    WAITING = "Waiting",
    PREPARING = "Preparing", 
    WAVE_ACTIVE = "WaveActive",
    WAVE_COMPLETE = "WaveComplete",
    GAME_OVER = "GameOver",
    VICTORY = "Victory"
}

-- Типы зомби
GameData.ZombieTypes = {
    BASIC = "Basic",
    FAST = "Fast", 
    TANK = "Tank",
    BOSS = "Boss"
}

-- Категории оружия
GameData.WeaponCategories = {
    PISTOL = "Pistol",
    RIFLE = "Rifle", 
    SHOTGUN = "Shotgun",
    SNIPER = "Sniper",
    SPECIAL = "Special"
}

-- Система очков опыта и уровней
GameData.LevelSystem = {
    ExperiencePerKill = {
        [GameData.ZombieTypes.BASIC] = 10,
        [GameData.ZombieTypes.FAST] = 15,
        [GameData.ZombieTypes.TANK] = 25,
        [GameData.ZombieTypes.BOSS] = 100
    },
    LevelUpRequirements = {
        [1] = 0,
        [2] = 100,
        [3] = 300,
        [4] = 600,
        [5] = 1000,
        [6] = 1500,
        [7] = 2100,
        [8] = 2800,
        [9] = 3600,
        [10] = 4500
    }
}

-- Награды за уровни
GameData.LevelRewards = {
    [2] = {Coins = 100, Message = "Уровень 2! +100 монет"},
    [3] = {Coins = 200, Message = "Уровень 3! +200 монет"},
    [4] = {Coins = 300, Message = "Уровень 4! +300 монет"},
    [5] = {Coins = 500, UnlockWeapon = "M4A1", Message = "Уровень 5! Разблокирована винтовка M4A1!"},
    [6] = {Coins = 600, Message = "Уровень 6! +600 монет"},
    [7] = {Coins = 700, Message = "Уровень 7! +700 монет"},
    [8] = {Coins = 800, UnlockWeapon = "AWP", Message = "Уровень 8! Разблокирована снайперская винтовка AWP!"},
    [9] = {Coins = 900, Message = "Уровень 9! +900 монет"},
    [10] = {Coins = 1500, UnlockWeapon = "RocketLauncher", Message = "Уровень 10! Разблокирован гранатомёт!"}
}

-- Звуки игры
GameData.Sounds = {
    ZombieSpawn = "rbxassetid://131961136", -- Звук спавна зомби
    ZombieDeath = "rbxassetid://131961136", -- Звук смерти зомби
    WeaponShot = "rbxassetid://131961136", -- Звук выстрела
    WeaponReload = "rbxassetid://131961136", -- Звук перезарядки
    CoinPickup = "rbxassetid://131961136", -- Звук получения монет
    WaveStart = "rbxassetid://131961136", -- Звук начала волны
    GameOver = "rbxassetid://131961136", -- Звук поражения
    Victory = "rbxassetid://131961136", -- Звук победы
    BaseDamage = "rbxassetid://131961136" -- Звук урона базе
}

-- Эффекты частиц
GameData.Effects = {
    BloodSplat = "rbxassetid://241650934", -- Эффект крови при попадании
    MuzzleFlash = "rbxassetid://241650934", -- Эффект вспышки выстрела
    Explosion = "rbxassetid://241650934", -- Эффект взрыва
    CoinEffect = "rbxassetid://241650934" -- Эффект получения монет
}

-- Цвета интерфейса
GameData.Colors = {
    Primary = Color3.fromRGB(41, 128, 185),     -- Основной синий
    Secondary = Color3.fromRGB(39, 174, 96),   -- Зеленый для успеха
    Danger = Color3.fromRGB(231, 76, 60),      -- Красный для опасности
    Warning = Color3.fromRGB(243, 156, 18),    -- Оранжевый для предупреждений
    Dark = Color3.fromRGB(44, 62, 80),         -- Темный для фона
    Light = Color3.fromRGB(236, 240, 241),     -- Светлый для текста
    Health = Color3.fromRGB(46, 204, 113),     -- Зеленый для здоровья
    Armor = Color3.fromRGB(52, 152, 219),      -- Синий для брони
    Experience = Color3.fromRGB(155, 89, 182)  -- Фиолетовый для опыта
}

-- Функция для получения данных о следующем уровне
function GameData.GetNextLevelData(currentLevel)
    if currentLevel >= 10 then
        return nil -- Максимальный уровень
    end
    
    local nextLevel = currentLevel + 1
    local currentExp = GameData.LevelSystem.LevelUpRequirements[currentLevel] or 0
    local nextLevelExp = GameData.LevelSystem.LevelUpRequirements[nextLevel] or 0
    local expNeeded = nextLevelExp - currentExp
    
    return {
        NextLevel = nextLevel,
        ExperienceNeeded = expNeeded,
        TotalExperience = nextLevelExp,
        Reward = GameData.LevelRewards[nextLevel]
    }
end

-- Функция для получения уровня по опыту
function GameData.GetLevelFromExperience(experience)
    local level = 1
    for lvl = 1, 10 do
        local requiredExp = GameData.LevelSystem.LevelUpRequirements[lvl] or 0
        if experience >= requiredExp then
            level = lvl
        else
            break
        end
    end
    return level
end

-- Функция для форматирования времени
function GameData.FormatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    return string.format("%02d:%02d", minutes, remainingSeconds)
end

-- Функция для форматирования больших чисел
function GameData.FormatNumber(number)
    if number >= 1000000 then
        return string.format("%.1fM", number / 1000000)
    elseif number >= 1000 then
        return string.format("%.1fK", number / 1000)
    else
        return tostring(number)
    end
end

return GameData