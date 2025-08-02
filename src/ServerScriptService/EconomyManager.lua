-- EconomyManager.lua
-- Менеджер экономики на сервере

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Загружаем модули
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))
local WeaponData = require(ReplicatedStorage.Modules:WaitForChild("WeaponData"))
local Utilities = require(ReplicatedStorage.Modules:WaitForChild("Utilities"))

local EconomyManager = {}

-- События
local purchaseWeaponEvent = RemoteEvents.GetRemoteEvent("PurchaseWeapon")
local upgradeWeaponEvent = RemoteEvents.GetRemoteEvent("UpgradeWeapon")
local coinsChangedEvent = RemoteEvents.GetRemoteEvent("CoinsChanged")

-- Функции Remote Functions
local canPurchaseWeaponFunction = RemoteEvents.GetRemoteFunction("CanPurchaseWeapon")
local canUpgradeWeaponFunction = RemoteEvents.GetRemoteFunction("CanUpgradeWeapon")
local getWeaponDataFunction = RemoteEvents.GetRemoteFunction("GetWeaponData")

-- Обработка покупки оружия
purchaseWeaponEvent.OnServerEvent:Connect(function(player, weaponId)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        warn("Данные игрока не найдены: " .. player.Name)
        return
    end
    
    local weapon = WeaponData.Weapons[weaponId]
    if not weapon then
        warn("Неизвестное оружие: " .. tostring(weaponId))
        return
    end
    
    -- Проверяем возможность покупки
    local canPurchase, reason = canPurchaseWeaponFunction:InvokeClient(player, weaponId)
    if not canPurchase then
        Utilities.Debug("Покупка отклонена для " .. player.Name .. ": " .. reason)
        return
    end
    
    -- Проверяем условия еще раз на сервере
    if weapon.UnlockLevel > playerData.Level then
        warn("Недостаточный уровень для покупки " .. weaponId)
        return
    end
    
    if playerData.Coins < weapon.Price then
        warn("Недостаточно монет для покупки " .. weaponId)
        return
    end
    
    -- Проверяем, есть ли уже это оружие
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            warn("Оружие уже куплено: " .. weaponId)
            return
        end
    end
    
    -- Совершаем покупку
    playerData.Coins = playerData.Coins - weapon.Price
    table.insert(playerData.Weapons, weaponId)
    playerData.WeaponLevels[weaponId] = 1
    
    -- Уведомляем игрока
    coinsChangedEvent:FireClient(player, playerData.Coins, -weapon.Price)
    gameManager.SendPlayerDataUpdate(player)
    
    Utilities.Debug(player.Name .. " купил оружие: " .. weapon.Name .. " за " .. weapon.Price .. " монет")
    
    -- Отправляем сообщение об успешной покупке
    local updateUIEvent = RemoteEvents.GetRemoteEvent("UpdateUI")
    updateUIEvent:FireClient(player, "WeaponPurchased", {
        WeaponId = weaponId,
        WeaponName = weapon.Name,
        Price = weapon.Price
    })
end)

-- Обработка улучшения оружия
upgradeWeaponEvent.OnServerEvent:Connect(function(player, weaponId)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        warn("Данные игрока не найдены: " .. player.Name)
        return
    end
    
    local weapon = WeaponData.Weapons[weaponId]
    if not weapon then
        warn("Неизвестное оружие: " .. tostring(weaponId))
        return
    end
    
    local currentLevel = playerData.WeaponLevels[weaponId] or 1
    
    -- Проверяем возможность улучшения
    local canUpgrade, reason = canUpgradeWeaponFunction:InvokeClient(player, weaponId)
    if not canUpgrade then
        Utilities.Debug("Улучшение отклонено для " .. player.Name .. ": " .. reason)
        return
    end
    
    -- Проверяем условия еще раз на сервере
    if currentLevel >= weapon.MaxUpgradeLevel then
        warn("Максимальный уровень оружия: " .. weaponId)
        return
    end
    
    local upgradeCost = WeaponData.GetUpgradeCost(weaponId, currentLevel)
    if not upgradeCost then
        warn("Нельзя улучшить оружие: " .. weaponId)
        return
    end
    
    if playerData.Coins < upgradeCost then
        warn("Недостаточно монет для улучшения " .. weaponId)
        return
    end
    
    -- Проверяем, есть ли это оружие у игрока
    local hasWeapon = false
    for _, ownedWeapon in ipairs(playerData.Weapons) do
        if ownedWeapon == weaponId then
            hasWeapon = true
            break
        end
    end
    
    if not hasWeapon then
        warn("У игрока нет этого оружия: " .. weaponId)
        return
    end
    
    -- Совершаем улучшение
    playerData.Coins = playerData.Coins - upgradeCost
    playerData.WeaponLevels[weaponId] = currentLevel + 1
    
    -- Уведомляем игрока
    coinsChangedEvent:FireClient(player, playerData.Coins, -upgradeCost)
    gameManager.SendPlayerDataUpdate(player)
    
    Utilities.Debug(player.Name .. " улучшил оружие: " .. weapon.Name .. " до уровня " .. (currentLevel + 1) .. " за " .. upgradeCost .. " монет")
    
    -- Отправляем сообщение об успешном улучшении
    local updateUIEvent = RemoteEvents.GetRemoteEvent("UpdateUI")
    updateUIEvent:FireClient(player, "WeaponUpgraded", {
        WeaponId = weaponId,
        WeaponName = weapon.Name,
        NewLevel = currentLevel + 1,
        Cost = upgradeCost
    })
end)

-- Функция получения данных оружия
getWeaponDataFunction.OnServerInvoke = function(player, weaponId, upgradeLevel)
    return WeaponData.GetWeaponStats(weaponId, upgradeLevel)
end

-- Функция для получения магазина оружия для игрока
function EconomyManager.GetWeaponShop(player)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return {}
    end
    
    local shopItems = {}
    
    -- Получаем все доступные оружия
    local availableWeapons = WeaponData.GetAvailableWeapons(playerData.Level)
    
    for _, weaponInfo in ipairs(availableWeapons) do
        local weaponId = weaponInfo.Id
        local weapon = WeaponData.Weapons[weaponId]
        
        -- Проверяем, есть ли уже это оружие у игрока
        local isOwned = false
        for _, ownedWeapon in ipairs(playerData.Weapons) do
            if ownedWeapon == weaponId then
                isOwned = true
                break
            end
        end
        
        local currentLevel = playerData.WeaponLevels[weaponId] or 1
        local maxLevel = weapon.MaxUpgradeLevel
        local upgradeCost = WeaponData.GetUpgradeCost(weaponId, currentLevel)
        
        local shopItem = {
            Id = weaponId,
            Name = weapon.Name,
            Category = weapon.Category,
            Description = weapon.Description,
            Price = weapon.Price,
            UnlockLevel = weapon.UnlockLevel,
            IsOwned = isOwned,
            CurrentLevel = isOwned and currentLevel or 0,
            MaxLevel = maxLevel,
            UpgradeCost = upgradeCost,
            CanPurchase = not isOwned and playerData.Level >= weapon.UnlockLevel and playerData.Coins >= weapon.Price,
            CanUpgrade = isOwned and currentLevel < maxLevel and upgradeCost and playerData.Coins >= upgradeCost,
            Stats = WeaponData.GetWeaponStats(weaponId, isOwned and currentLevel or 1)
        }
        
        table.insert(shopItems, shopItem)
    end
    
    -- Сортируем по категории и цене
    table.sort(shopItems, function(a, b)
        if a.Category == b.Category then
            return a.Price < b.Price
        end
        return a.Category < b.Category
    end)
    
    return shopItems
end

-- Функция для получения рекомендаций оружия
function EconomyManager.GetWeaponRecommendations(player)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return {}
    end
    
    local recommendations = {}
    local playerLevel = playerData.Level
    local playerCoins = playerData.Coins
    
    -- Получаем рекомендуемый набор для уровня игрока
    local recommendedLoadout = nil
    for level = playerLevel, 1, -1 do
        if WeaponData.RecommendedLoadouts[level] then
            recommendedLoadout = WeaponData.RecommendedLoadouts[level]
            break
        end
    end
    
    if recommendedLoadout then
        for _, weaponId in ipairs(recommendedLoadout) do
            local weapon = WeaponData.Weapons[weaponId]
            if weapon then
                -- Проверяем, есть ли уже это оружие у игрока
                local isOwned = false
                for _, ownedWeapon in ipairs(playerData.Weapons) do
                    if ownedWeapon == weaponId then
                        isOwned = true
                        break
                    end
                end
                
                if not isOwned and weapon.UnlockLevel <= playerLevel then
                    table.insert(recommendations, {
                        Id = weaponId,
                        Name = weapon.Name,
                        Category = weapon.Category,
                        Description = weapon.Description,
                        Price = weapon.Price,
                        CanAfford = playerCoins >= weapon.Price,
                        Reason = "Рекомендовано для уровня " .. playerLevel
                    })
                end
            end
        end
    end
    
    -- Добавляем рекомендации по улучшениям
    for _, weaponId in ipairs(playerData.Weapons) do
        local weapon = WeaponData.Weapons[weaponId]
        local currentLevel = playerData.WeaponLevels[weaponId] or 1
        
        if weapon and currentLevel < weapon.MaxUpgradeLevel then
            local upgradeCost = WeaponData.GetUpgradeCost(weaponId, currentLevel)
            if upgradeCost then
                table.insert(recommendations, {
                    Id = weaponId,
                    Name = weapon.Name .. " (Улучшение)",
                    Category = "Upgrade",
                    Description = "Улучшить до уровня " .. (currentLevel + 1),
                    Price = upgradeCost,
                    CanAfford = playerCoins >= upgradeCost,
                    Reason = "Улучшение существующего оружия",
                    IsUpgrade = true,
                    CurrentLevel = currentLevel
                })
            end
        end
    end
    
    -- Сортируем по доступности и цене
    table.sort(recommendations, function(a, b)
        if a.CanAfford ~= b.CanAfford then
            return a.CanAfford and not b.CanAfford
        end
        return a.Price < b.Price
    end)
    
    return recommendations
end

-- Функция для получения статистики экономики игрока
function EconomyManager.GetPlayerEconomyStats(player)
    local gameManager = require(script.Parent:WaitForChild("GameManager"))
    local playerData = gameManager.PlayersData[player.UserId]
    
    if not playerData then
        return nil
    end
    
    local stats = {
        Coins = playerData.Coins,
        Level = playerData.Level,
        Experience = playerData.Experience,
        WeaponsOwned = #playerData.Weapons,
        TotalWeaponsAvailable = 0,
        AverageWeaponLevel = 0,
        TotalSpentOnWeapons = 0,
        TotalSpentOnUpgrades = 0
    }
    
    -- Подсчитываем общее количество доступных оружий
    for _, weapon in pairs(WeaponData.Weapons) do
        if weapon.UnlockLevel <= playerData.Level then
            stats.TotalWeaponsAvailable = stats.TotalWeaponsAvailable + 1
        end
    end
    
    -- Подсчитываем средний уровень оружия и потраченные средства
    local totalLevels = 0
    for _, weaponId in ipairs(playerData.Weapons) do
        local weapon = WeaponData.Weapons[weaponId]
        local level = playerData.WeaponLevels[weaponId] or 1
        
        totalLevels = totalLevels + level
        
        -- Считаем потраченные средства
        if weapon then
            stats.TotalSpentOnWeapons = stats.TotalSpentOnWeapons + weapon.Price
            
            -- Считаем затраты на улучшения
            local costs = WeaponData.UpgradeCosts[weapon.Category]
            if costs then
                for i = 1, level - 1 do
                    stats.TotalSpentOnUpgrades = stats.TotalSpentOnUpgrades + (costs[i] or 0)
                end
            end
        end
    end
    
    if #playerData.Weapons > 0 then
        stats.AverageWeaponLevel = totalLevels / #playerData.Weapons
    end
    
    return stats
end

-- Функция для проверки достижений экономики
function EconomyManager.CheckEconomyAchievements(player)
    local stats = EconomyManager.GetPlayerEconomyStats(player)
    if not stats then
        return {}
    end
    
    local achievements = {}
    
    -- Достижения за монеты
    if stats.Coins >= 10000 then
        table.insert(achievements, {Name = "Миллионер", Description = "Накопить 10000 монет"})
    elseif stats.Coins >= 5000 then
        table.insert(achievements, {Name = "Богач", Description = "Накопить 5000 монет"})
    elseif stats.Coins >= 1000 then
        table.insert(achievements, {Name = "Накопитель", Description = "Накопить 1000 монет"})
    end
    
    -- Достижения за оружие
    if stats.WeaponsOwned >= 8 then
        table.insert(achievements, {Name = "Коллекционер", Description = "Собрать 8 видов оружия"})
    elseif stats.WeaponsOwned >= 5 then
        table.insert(achievements, {Name = "Арсенал", Description = "Собрать 5 видов оружия"})
    end
    
    -- Достижения за улучшения
    if stats.AverageWeaponLevel >= 5 then
        table.insert(achievements, {Name = "Перфекционист", Description = "Достичь среднего уровня оружия 5"})
    elseif stats.AverageWeaponLevel >= 3 then
        table.insert(achievements, {Name = "Модернизатор", Description = "Достичь среднего уровня оружия 3"})
    end
    
    return achievements
end

-- Инициализация EconomyManager
function EconomyManager.Initialize()
    Utilities.Debug("Инициализация EconomyManager")
    
    -- Здесь можно добавить дополнительную инициализацию
end

-- Запуск инициализации
EconomyManager.Initialize()

return EconomyManager