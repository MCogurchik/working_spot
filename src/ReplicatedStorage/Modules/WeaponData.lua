-- WeaponData.lua
-- ModuleScript с данными всех видов оружия

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))

local WeaponData = {}

-- Базовые характеристики оружия
WeaponData.Weapons = {
    -- ПИСТОЛЕТЫ
    ["Glock"] = {
        Name = "Glock 17",
        Category = GameData.WeaponCategories.PISTOL,
        Damage = 35,
        FireRate = 0.3, -- секунд между выстрелами
        MagazineSize = 17,
        ReloadTime = 2.5,
        Range = 100,
        Accuracy = 0.85,
        Price = 0, -- Стартовое оружие
        UnlockLevel = 1,
        MaxUpgradeLevel = 5,
        Description = "Надежный стартовый пистолет",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = false
    },
    
    ["Deagle"] = {
        Name = "Desert Eagle",
        Category = GameData.WeaponCategories.PISTOL,
        Damage = 80,
        FireRate = 0.8,
        MagazineSize = 7,
        ReloadTime = 3.0,
        Range = 120,
        Accuracy = 0.75,
        Price = 2500,
        UnlockLevel = 3,
        MaxUpgradeLevel = 5,
        Description = "Мощный пистолет с высоким уроном",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = false
    },
    
    -- ВИНТОВКИ
    ["AK47"] = {
        Name = "AK-47",
        Category = GameData.WeaponCategories.RIFLE,
        Damage = 45,
        FireRate = 0.12,
        MagazineSize = 30,
        ReloadTime = 3.5,
        Range = 150,
        Accuracy = 0.7,
        Price = 3500,
        UnlockLevel = 4,
        MaxUpgradeLevel = 5,
        Description = "Классическая штурмовая винтовка",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = true
    },
    
    ["M4A1"] = {
        Name = "M4A1",
        Category = GameData.WeaponCategories.RIFLE,
        Damage = 40,
        FireRate = 0.1,
        MagazineSize = 30,
        ReloadTime = 3.0,
        Range = 160,
        Accuracy = 0.8,
        Price = 4000,
        UnlockLevel = 5,
        MaxUpgradeLevel = 5,
        Description = "Точная штурмовая винтовка",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = true
    },
    
    -- ДРОБОВИКИ
    ["Shotgun"] = {
        Name = "Дробовик",
        Category = GameData.WeaponCategories.SHOTGUN,
        Damage = 120,
        FireRate = 1.2,
        MagazineSize = 6,
        ReloadTime = 4.0,
        Range = 50,
        Accuracy = 0.6,
        Price = 2000,
        UnlockLevel = 2,
        MaxUpgradeLevel = 5,
        Description = "Мощное оружие ближнего боя",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = false,
        Pellets = 6 -- Количество дробинок
    },
    
    ["DoubleShotgun"] = {
        Name = "Двустволка",
        Category = GameData.WeaponCategories.SHOTGUN,
        Damage = 200,
        FireRate = 2.0,
        MagazineSize = 2,
        ReloadTime = 3.5,
        Range = 40,
        Accuracy = 0.5,
        Price = 3000,
        UnlockLevel = 6,
        MaxUpgradeLevel = 5,
        Description = "Разрушительная двустволка",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = false,
        Pellets = 8
    },
    
    -- СНАЙПЕРСКИЕ ВИНТОВКИ
    ["AWP"] = {
        Name = "AWP",
        Category = GameData.WeaponCategories.SNIPER,
        Damage = 300,
        FireRate = 2.5,
        MagazineSize = 5,
        ReloadTime = 4.0,
        Range = 300,
        Accuracy = 0.95,
        Price = 8000,
        UnlockLevel = 8,
        MaxUpgradeLevel = 5,
        Description = "Мощная снайперская винтовка",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = false
    },
    
    -- СПЕЦИАЛЬНОЕ ОРУЖИЕ
    ["RocketLauncher"] = {
        Name = "Гранатомёт",
        Category = GameData.WeaponCategories.SPECIAL,
        Damage = 500,
        FireRate = 3.0,
        MagazineSize = 1,
        ReloadTime = 5.0,
        Range = 200,
        Accuracy = 0.8,
        Price = 15000,
        UnlockLevel = 10,
        MaxUpgradeLevel = 3,
        Description = "Взрывное оружие массового поражения",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = false,
        ExplosionRadius = 15,
        ExplosionDamage = 300
    },
    
    ["Minigun"] = {
        Name = "Миниган",
        Category = GameData.WeaponCategories.SPECIAL,
        Damage = 25,
        FireRate = 0.05,
        MagazineSize = 200,
        ReloadTime = 8.0,
        Range = 120,
        Accuracy = 0.6,
        Price = 12000,
        UnlockLevel = 9,
        MaxUpgradeLevel = 5,
        Description = "Скорострельное оружие с большой ёмкостью",
        Sound = "rbxassetid://131961136",
        MuzzleFlash = true,
        AutoFire = true,
        SpinUpTime = 1.0 -- Время раскрутки
    }
}

-- Модификаторы улучшений
WeaponData.UpgradeModifiers = {
    Damage = {1.0, 1.2, 1.4, 1.6, 1.8, 2.0}, -- +20% за уровень
    FireRate = {1.0, 0.9, 0.8, 0.7, 0.6, 0.5}, -- -10% времени (быстрее)
    MagazineSize = {1.0, 1.15, 1.3, 1.45, 1.6, 1.75}, -- +15% за уровень
    ReloadTime = {1.0, 0.9, 0.8, 0.7, 0.6, 0.5}, -- -10% времени
    Range = {1.0, 1.1, 1.2, 1.3, 1.4, 1.5}, -- +10% за уровень
    Accuracy = {1.0, 1.05, 1.1, 1.15, 1.2, 1.25} -- +5% за уровень (макс 1.0)
}

-- Стоимость улучшений
WeaponData.UpgradeCosts = {
    [GameData.WeaponCategories.PISTOL] = {500, 750, 1000, 1500, 2000},
    [GameData.WeaponCategories.RIFLE] = {750, 1125, 1500, 2250, 3000},
    [GameData.WeaponCategories.SHOTGUN] = {600, 900, 1200, 1800, 2400},
    [GameData.WeaponCategories.SNIPER] = {1000, 1500, 2000, 3000, 4000},
    [GameData.WeaponCategories.SPECIAL] = {2000, 3000, 4000, 6000, 8000}
}

-- Функция для получения характеристик оружия с учетом улучшений
function WeaponData.GetWeaponStats(weaponId, upgradeLevel)
    local baseWeapon = WeaponData.Weapons[weaponId]
    if not baseWeapon then
        warn("Неизвестное оружие: " .. tostring(weaponId))
        return nil
    end
    
    upgradeLevel = math.max(1, math.min(upgradeLevel or 1, baseWeapon.MaxUpgradeLevel))
    
    local stats = {}
    for key, value in pairs(baseWeapon) do
        stats[key] = value
    end
    
    -- Применяем модификаторы улучшений
    local modifiers = WeaponData.UpgradeModifiers
    stats.Damage = math.floor(baseWeapon.Damage * modifiers.Damage[upgradeLevel])
    stats.FireRate = baseWeapon.FireRate * modifiers.FireRate[upgradeLevel]
    stats.MagazineSize = math.floor(baseWeapon.MagazineSize * modifiers.MagazineSize[upgradeLevel])
    stats.ReloadTime = baseWeapon.ReloadTime * modifiers.ReloadTime[upgradeLevel]
    stats.Range = baseWeapon.Range * modifiers.Range[upgradeLevel]
    stats.Accuracy = math.min(1.0, baseWeapon.Accuracy * modifiers.Accuracy[upgradeLevel])
    
    -- Специальные характеристики для определенных типов оружия
    if baseWeapon.Pellets then
        stats.Pellets = baseWeapon.Pellets
    end
    
    if baseWeapon.ExplosionRadius then
        stats.ExplosionRadius = baseWeapon.ExplosionRadius * modifiers.Range[upgradeLevel]
        stats.ExplosionDamage = math.floor(baseWeapon.ExplosionDamage * modifiers.Damage[upgradeLevel])
    end
    
    if baseWeapon.SpinUpTime then
        stats.SpinUpTime = baseWeapon.SpinUpTime * modifiers.FireRate[upgradeLevel]
    end
    
    stats.UpgradeLevel = upgradeLevel
    stats.WeaponId = weaponId
    
    return stats
end

-- Функция для получения стоимости улучшения
function WeaponData.GetUpgradeCost(weaponId, currentLevel)
    local weapon = WeaponData.Weapons[weaponId]
    if not weapon or currentLevel >= weapon.MaxUpgradeLevel then
        return nil
    end
    
    local costs = WeaponData.UpgradeCosts[weapon.Category]
    return costs[currentLevel] or 0
end

-- Функция для получения всех доступных оружий для уровня игрока
function WeaponData.GetAvailableWeapons(playerLevel)
    local available = {}
    for weaponId, weapon in pairs(WeaponData.Weapons) do
        if weapon.UnlockLevel <= playerLevel then
            table.insert(available, {
                Id = weaponId,
                Name = weapon.Name,
                Category = weapon.Category,
                Price = weapon.Price,
                Description = weapon.Description,
                UnlockLevel = weapon.UnlockLevel
            })
        end
    end
    
    -- Сортируем по категории и цене
    table.sort(available, function(a, b)
        if a.Category == b.Category then
            return a.Price < b.Price
        end
        return a.Category < b.Category
    end)
    
    return available
end

-- Функция для создания модели оружия
function WeaponData.CreateWeaponModel(weaponId)
    local weapon = WeaponData.Weapons[weaponId]
    if not weapon then
        return nil
    end
    
    local model = Instance.new("Model")
    model.Name = weapon.Name
    
    -- Основная часть оружия
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Parent = model
    
    -- Размер зависит от категории оружия
    local size = Vector3.new(0.2, 0.2, 1)
    if weapon.Category == GameData.WeaponCategories.RIFLE then
        size = Vector3.new(0.2, 0.2, 2)
    elseif weapon.Category == GameData.WeaponCategories.SHOTGUN then
        size = Vector3.new(0.3, 0.3, 1.5)
    elseif weapon.Category == GameData.WeaponCategories.SNIPER then
        size = Vector3.new(0.2, 0.2, 2.5)
    elseif weapon.Category == GameData.WeaponCategories.SPECIAL then
        size = Vector3.new(0.4, 0.4, 2)
    end
    
    handle.Size = size
    handle.Material = Enum.Material.Metal
    handle.BrickColor = BrickColor.new("Really black")
    handle.CanCollide = false
    
    -- Ствол
    local barrel = Instance.new("Part")
    barrel.Name = "Barrel"
    barrel.Size = Vector3.new(0.1, 0.1, size.Z * 0.6)
    barrel.Material = Enum.Material.Metal
    barrel.BrickColor = BrickColor.new("Dark stone grey")
    barrel.CanCollide = false
    barrel.Parent = model
    
    -- Крепим ствол к рукоятке
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = handle
    weld.Part1 = barrel
    weld.Parent = handle
    
    barrel.CFrame = handle.CFrame * CFrame.new(0, 0.05, size.Z * 0.3)
    
    -- Точка выстрела
    local firePoint = Instance.new("Attachment")
    firePoint.Name = "FirePoint"
    firePoint.Position = Vector3.new(0, 0, size.Z * 0.5)
    firePoint.Parent = handle
    
    model.PrimaryPart = handle
    
    return model
end

-- Рекомендуемые комбинации оружия по уровням
WeaponData.RecommendedLoadouts = {
    [1] = {"Glock"},
    [2] = {"Glock", "Shotgun"},
    [3] = {"Deagle", "Shotgun"},
    [4] = {"Deagle", "AK47"},
    [5] = {"M4A1", "Shotgun"},
    [6] = {"M4A1", "DoubleShotgun"},
    [8] = {"AWP", "M4A1"},
    [9] = {"Minigun", "AWP"},
    [10] = {"RocketLauncher", "Minigun", "AWP"}
}

return WeaponData