-- GameUI.lua
-- Пользовательский интерфейс игры

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Загружаем модули
local RemoteEvents = require(ReplicatedStorage:WaitForChild("RemoteEvents"))
local GameData = require(ReplicatedStorage:WaitForChild("GameData"))
local WeaponData = require(ReplicatedStorage.Modules:WaitForChild("WeaponData"))
local Utilities = require(ReplicatedStorage.Modules:WaitForChild("Utilities"))

local GameUI = {}

-- UI элементы
GameUI.MainFrame = nil
GameUI.StatsFrame = nil
GameUI.WeaponFrame = nil
GameUI.ShopFrame = nil
GameUI.GameStateFrame = nil

-- Данные
GameUI.PlayerData = {}
GameUI.GameState = {}
GameUI.WeaponAmmo = {}

-- События
local updateUIEvent = RemoteEvents.GetRemoteEvent("UpdateUI")
local purchaseWeaponEvent = RemoteEvents.GetRemoteEvent("PurchaseWeapon")
local upgradeWeaponEvent = RemoteEvents.GetRemoteEvent("UpgradeWeapon")

-- Функции Remote Functions
local canPurchaseWeaponFunction = RemoteEvents.GetRemoteFunction("CanPurchaseWeapon")
local canUpgradeWeaponFunction = RemoteEvents.GetRemoteFunction("CanUpgradeWeapon")

-- Создание основного UI
function GameUI.CreateMainUI()
    -- Создаем основной фрейм
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GameUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    GameUI.MainFrame = screenGui
    
    -- Создаем компоненты UI
    GameUI.CreateStatsUI()
    GameUI.CreateWeaponUI()
    GameUI.CreateGameStateUI()
    GameUI.CreateShopUI()
    
    Utilities.Debug("UI создан")
end

-- Создание UI статистики игрока
function GameUI.CreateStatsUI()
    local frame = Instance.new("Frame")
    frame.Name = "StatsFrame"
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0, 20, 0, 20)
    frame.BackgroundColor3 = GameData.Colors.Dark
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = GameUI.MainFrame
    
    -- Скругленные углы
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Монеты
    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Name = "CoinsLabel"
    coinsLabel.Size = UDim2.new(0.5, -5, 0.5, -5)
    coinsLabel.Position = UDim2.new(0, 10, 0, 10)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Text = "💰 Монеты: 0"
    coinsLabel.TextColor3 = GameData.Colors.Light
    coinsLabel.TextScaled = true
    coinsLabel.Font = Enum.Font.SourceSansBold
    coinsLabel.Parent = frame
    
    -- Уровень
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Name = "LevelLabel"
    levelLabel.Size = UDim2.new(0.5, -5, 0.5, -5)
    levelLabel.Position = UDim2.new(0.5, 5, 0, 10)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Text = "⭐ Уровень: 1"
    levelLabel.TextColor3 = GameData.Colors.Light
    levelLabel.TextScaled = true
    levelLabel.Font = Enum.Font.SourceSansBold
    levelLabel.Parent = frame
    
    -- Опыт
    local expLabel = Instance.new("TextLabel")
    expLabel.Name = "ExpLabel"
    expLabel.Size = UDim2.new(1, -20, 0.3, 0)
    expLabel.Position = UDim2.new(0, 10, 0.5, 5)
    expLabel.BackgroundTransparency = 1
    expLabel.Text = "📈 Опыт: 0/100"
    expLabel.TextColor3 = GameData.Colors.Experience
    expLabel.TextScaled = true
    expLabel.Font = Enum.Font.SourceSans
    expLabel.Parent = frame
    
    -- Статистика
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "StatsLabel"
    statsLabel.Size = UDim2.new(1, -20, 0.2, 0)
    statsLabel.Position = UDim2.new(0, 10, 0.8, 0)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Text = "🎯 Убийств: 0 | 💥 Урона: 0"
    statsLabel.TextColor3 = GameData.Colors.Light
    statsLabel.TextScaled = true
    statsLabel.Font = Enum.Font.SourceSans
    statsLabel.Parent = frame
    
    GameUI.StatsFrame = frame
end

-- Создание UI оружия
function GameUI.CreateWeaponUI()
    local frame = Instance.new("Frame")
    frame.Name = "WeaponFrame"
    frame.Size = UDim2.new(0, 350, 0, 120)
    frame.Position = UDim2.new(1, -370, 1, -140)
    frame.BackgroundColor3 = GameData.Colors.Dark
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = GameUI.MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Название оружия
    local weaponName = Instance.new("TextLabel")
    weaponName.Name = "WeaponName"
    weaponName.Size = UDim2.new(1, -20, 0, 30)
    weaponName.Position = UDim2.new(0, 10, 0, 5)
    weaponName.BackgroundTransparency = 1
    weaponName.Text = "🔫 Glock 17"
    weaponName.TextColor3 = GameData.Colors.Light
    weaponName.TextScaled = true
    weaponName.Font = Enum.Font.SourceSansBold
    weaponName.Parent = frame
    
    -- Патроны
    local ammoLabel = Instance.new("TextLabel")
    ammoLabel.Name = "AmmoLabel"
    ammoLabel.Size = UDim2.new(0.5, -5, 0, 25)
    ammoLabel.Position = UDim2.new(0, 10, 0, 35)
    ammoLabel.BackgroundTransparency = 1
    ammoLabel.Text = "📦 17/17"
    ammoLabel.TextColor3 = GameData.Colors.Light
    ammoLabel.TextScaled = true
    ammoLabel.Font = Enum.Font.SourceSans
    ammoLabel.Parent = frame
    
    -- Урон
    local damageLabel = Instance.new("TextLabel")
    damageLabel.Name = "DamageLabel"
    damageLabel.Size = UDim2.new(0.5, -5, 0, 25)
    damageLabel.Position = UDim2.new(0.5, 5, 0, 35)
    damageLabel.BackgroundTransparency = 1
    damageLabel.Text = "💥 35"
    damageLabel.TextColor3 = GameData.Colors.Light
    damageLabel.TextScaled = true
    damageLabel.Font = Enum.Font.SourceSans
    damageLabel.Parent = frame
    
    -- Статус
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0, 65)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Готов к стрельбе"
    statusLabel.TextColor3 = GameData.Colors.Secondary
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.SourceSans
    statusLabel.Parent = frame
    
    -- Инструкции
    local instructionsLabel = Instance.new("TextLabel")
    instructionsLabel.Name = "InstructionsLabel"
    instructionsLabel.Size = UDim2.new(1, -20, 0, 15)
    instructionsLabel.Position = UDim2.new(0, 10, 0, 90)
    instructionsLabel.BackgroundTransparency = 1
    instructionsLabel.Text = "F - Стрелять | R - Перезарядка | 1-5 - Смена оружия"
    instructionsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    instructionsLabel.TextScaled = true
    instructionsLabel.Font = Enum.Font.SourceSans
    instructionsLabel.Parent = frame
    
    GameUI.WeaponFrame = frame
end

-- Создание UI состояния игры
function GameUI.CreateGameStateUI()
    local frame = Instance.new("Frame")
    frame.Name = "GameStateFrame"
    frame.Size = UDim2.new(0, 400, 0, 80)
    frame.Position = UDim2.new(0.5, -200, 0, 20)
    frame.BackgroundColor3 = GameData.Colors.Dark
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = GameUI.MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Состояние игры
    local stateLabel = Instance.new("TextLabel")
    stateLabel.Name = "StateLabel"
    stateLabel.Size = UDim2.new(1, -20, 0, 25)
    stateLabel.Position = UDim2.new(0, 10, 0, 5)
    stateLabel.BackgroundTransparency = 1
    stateLabel.Text = "🎮 Ожидание игроков..."
    stateLabel.TextColor3 = GameData.Colors.Light
    stateLabel.TextScaled = true
    stateLabel.Font = Enum.Font.SourceSansBold
    stateLabel.Parent = frame
    
    -- Волна
    local waveLabel = Instance.new("TextLabel")
    waveLabel.Name = "WaveLabel"
    waveLabel.Size = UDim2.new(0.3, -5, 0, 20)
    waveLabel.Position = UDim2.new(0, 10, 0, 35)
    waveLabel.BackgroundTransparency = 1
    waveLabel.Text = "🌊 Волна: 0"
    waveLabel.TextColor3 = GameData.Colors.Light
    waveLabel.TextScaled = true
    waveLabel.Font = Enum.Font.SourceSans
    waveLabel.Parent = frame
    
    -- Зомби
    local zombieLabel = Instance.new("TextLabel")
    zombieLabel.Name = "ZombieLabel"
    zombieLabel.Size = UDim2.new(0.35, -5, 0, 20)
    zombieLabel.Position = UDim2.new(0.3, 5, 0, 35)
    zombieLabel.BackgroundTransparency = 1
    zombieLabel.Text = "🧟 Зомби: 0"
    zombieLabel.TextColor3 = GameData.Colors.Light
    zombieLabel.TextScaled = true
    zombieLabel.Font = Enum.Font.SourceSans
    zombieLabel.Parent = frame
    
    -- Здоровье базы
    local baseHealthFrame = Instance.new("Frame")
    baseHealthFrame.Name = "BaseHealthFrame"
    baseHealthFrame.Size = UDim2.new(0.35, -5, 0, 20)
    baseHealthFrame.Position = UDim2.new(0.65, 5, 0, 35)
    baseHealthFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    baseHealthFrame.BorderSizePixel = 0
    baseHealthFrame.Parent = frame
    
    local baseHealthCorner = Instance.new("UICorner")
    baseHealthCorner.CornerRadius = UDim.new(0, 4)
    baseHealthCorner.Parent = baseHealthFrame
    
    local baseHealthBar = Instance.new("Frame")
    baseHealthBar.Name = "BaseHealthBar"
    baseHealthBar.Size = UDim2.new(1, 0, 1, 0)
    baseHealthBar.Position = UDim2.new(0, 0, 0, 0)
    baseHealthBar.BackgroundColor3 = GameData.Colors.Health
    baseHealthBar.BorderSizePixel = 0
    baseHealthBar.Parent = baseHealthFrame
    
    local baseHealthBarCorner = Instance.new("UICorner")
    baseHealthBarCorner.CornerRadius = UDim.new(0, 4)
    baseHealthBarCorner.Parent = baseHealthBar
    
    local baseHealthText = Instance.new("TextLabel")
    baseHealthText.Name = "BaseHealthText"
    baseHealthText.Size = UDim2.new(1, 0, 1, 0)
    baseHealthText.Position = UDim2.new(0, 0, 0, 0)
    baseHealthText.BackgroundTransparency = 1
    baseHealthText.Text = "🏠 100/100"
    baseHealthText.TextColor3 = GameData.Colors.Light
    baseHealthText.TextScaled = true
    baseHealthText.Font = Enum.Font.SourceSansBold
    baseHealthText.Parent = baseHealthFrame
    
    -- Таймер
    local timerLabel = Instance.new("TextLabel")
    timerLabel.Name = "TimerLabel"
    timerLabel.Size = UDim2.new(1, -20, 0, 20)
    timerLabel.Position = UDim2.new(0, 10, 0, 55)
    timerLabel.BackgroundTransparency = 1
    timerLabel.Text = ""
    timerLabel.TextColor3 = GameData.Colors.Warning
    timerLabel.TextScaled = true
    timerLabel.Font = Enum.Font.SourceSansBold
    timerLabel.Parent = frame
    
    GameUI.GameStateFrame = frame
end

-- Создание UI магазина
function GameUI.CreateShopUI()
    local frame = Instance.new("Frame")
    frame.Name = "ShopFrame"
    frame.Size = UDim2.new(0, 600, 0, 400)
    frame.Position = UDim2.new(0.5, -300, 0.5, -200)
    frame.BackgroundColor3 = GameData.Colors.Dark
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = GameUI.MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Заголовок
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, -20, 0, 40)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🛒 МАГАЗИН ОРУЖИЯ"
    titleLabel.TextColor3 = GameData.Colors.Light
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 10)
    closeButton.BackgroundColor3 = GameData.Colors.Danger
    closeButton.Text = "✕"
    closeButton.TextColor3 = GameData.Colors.Light
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.BorderSizePixel = 0
    closeButton.Parent = frame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        GameUI.HideShop()
    end)
    
    -- Скролл фрейм для товаров
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, -20, 1, -70)
    scrollFrame.Position = UDim2.new(0, 10, 0, 55)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.Parent = frame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = scrollFrame
    
    GameUI.ShopFrame = frame
    GameUI.ShopScrollFrame = scrollFrame
end

-- Обновление UI статистики
function GameUI.UpdateStatsUI()
    if not GameUI.StatsFrame then return end
    
    local coinsLabel = GameUI.StatsFrame:FindFirstChild("CoinsLabel")
    local levelLabel = GameUI.StatsFrame:FindFirstChild("LevelLabel")
    local expLabel = GameUI.StatsFrame:FindFirstChild("ExpLabel")
    local statsLabel = GameUI.StatsFrame:FindFirstChild("StatsLabel")
    
    if coinsLabel then
        coinsLabel.Text = "💰 Монеты: " .. GameData.FormatNumber(GameUI.PlayerData.Coins or 0)
    end
    
    if levelLabel then
        levelLabel.Text = "⭐ Уровень: " .. (GameUI.PlayerData.Level or 1)
    end
    
    if expLabel then
        local currentLevel = GameUI.PlayerData.Level or 1
        local experience = GameUI.PlayerData.Experience or 0
        local nextLevelData = GameData.GetNextLevelData(currentLevel)
        
        if nextLevelData then
            local currentLevelExp = GameData.LevelSystem.LevelUpRequirements[currentLevel] or 0
            local expProgress = experience - currentLevelExp
            local expNeeded = nextLevelData.ExperienceNeeded
            expLabel.Text = "📈 Опыт: " .. expProgress .. "/" .. expNeeded
        else
            expLabel.Text = "📈 Опыт: МАКС УРОВЕНЬ"
        end
    end
    
    if statsLabel then
        local kills = GameUI.PlayerData.Kills or 0
        local damage = GameUI.PlayerData.DamageDealt or 0
        statsLabel.Text = "🎯 Убийств: " .. kills .. " | 💥 Урона: " .. GameData.FormatNumber(damage)
    end
end

-- Обновление UI оружия
function GameUI.UpdateWeaponUI()
    if not GameUI.WeaponFrame then return end
    
    local weaponName = GameUI.WeaponFrame:FindFirstChild("WeaponName")
    local ammoLabel = GameUI.WeaponFrame:FindFirstChild("AmmoLabel")
    local damageLabel = GameUI.WeaponFrame:FindFirstChild("DamageLabel")
    local statusLabel = GameUI.WeaponFrame:FindFirstChild("StatusLabel")
    
    local currentWeapon = GameUI.PlayerData.CurrentWeapon
    if not currentWeapon then return end
    
    local weaponLevel = GameUI.PlayerData.WeaponLevels and GameUI.PlayerData.WeaponLevels[currentWeapon] or 1
    local weaponStats = WeaponData.GetWeaponStats(currentWeapon, weaponLevel)
    
    if weaponStats then
        if weaponName then
            weaponName.Text = "🔫 " .. weaponStats.Name .. " (Ур." .. weaponLevel .. ")"
        end
        
        if damageLabel then
            damageLabel.Text = "💥 " .. weaponStats.Damage
        end
        
        -- Обновляем патроны из клиентского менеджера
        if ammoLabel and GameUI.WeaponAmmo[currentWeapon] then
            local ammo = GameUI.WeaponAmmo[currentWeapon]
            ammoLabel.Text = "📦 " .. ammo.Current .. "/" .. ammo.Max
            
            -- Меняем цвет в зависимости от количества патронов
            if ammo.Current == 0 then
                ammoLabel.TextColor3 = GameData.Colors.Danger
            elseif ammo.Current <= ammo.Max * 0.3 then
                ammoLabel.TextColor3 = GameData.Colors.Warning
            else
                ammoLabel.TextColor3 = GameData.Colors.Light
            end
        end
        
        if statusLabel then
            -- Статус будет обновляться из клиентского менеджера
        end
    end
end

-- Обновление UI состояния игры
function GameUI.UpdateGameStateUI()
    if not GameUI.GameStateFrame then return end
    
    local stateLabel = GameUI.GameStateFrame:FindFirstChild("StateLabel")
    local waveLabel = GameUI.GameStateFrame:FindFirstChild("WaveLabel")
    local zombieLabel = GameUI.GameStateFrame:FindFirstChild("ZombieLabel")
    local timerLabel = GameUI.GameStateFrame:FindFirstChild("TimerLabel")
    local baseHealthBar = GameUI.GameStateFrame:FindFirstChild("BaseHealthFrame"):FindFirstChild("BaseHealthBar")
    local baseHealthText = GameUI.GameStateFrame:FindFirstChild("BaseHealthFrame"):FindFirstChild("BaseHealthText")
    
    -- Состояние игры
    if stateLabel then
        local state = GameUI.GameState.State
        local stateText = ""
        local stateColor = GameData.Colors.Light
        
        if state == GameData.GameStates.WAITING then
            stateText = "🎮 Ожидание игроков..."
            stateColor = GameData.Colors.Light
        elseif state == GameData.GameStates.PREPARING then
            stateText = "⚡ Подготовка к волне..."
            stateColor = GameData.Colors.Warning
        elseif state == GameData.GameStates.WAVE_ACTIVE then
            stateText = "⚔️ БИТВА!"
            stateColor = GameData.Colors.Danger
        elseif state == GameData.GameStates.WAVE_COMPLETE then
            stateText = "✅ Волна завершена!"
            stateColor = GameData.Colors.Secondary
        elseif state == GameData.GameStates.GAME_OVER then
            stateText = "💀 ПОРАЖЕНИЕ"
            stateColor = GameData.Colors.Danger
        elseif state == GameData.GameStates.VICTORY then
            stateText = "🏆 ПОБЕДА!"
            stateColor = Color3.fromRGB(255, 215, 0)
        end
        
        stateLabel.Text = stateText
        stateLabel.TextColor3 = stateColor
    end
    
    -- Волна
    if waveLabel then
        waveLabel.Text = "🌊 Волна: " .. (GameUI.GameState.Wave or 0)
    end
    
    -- Зомби
    if zombieLabel then
        zombieLabel.Text = "🧟 Зомби: " .. (GameUI.GameState.AliveZombies or 0)
    end
    
    -- Здоровье базы
    if baseHealthBar and baseHealthText then
        local currentHealth = GameUI.GameState.BaseHealth or 0
        local maxHealth = GameUI.GameState.MaxBaseHealth or 100
        local healthPercent = currentHealth / maxHealth
        
        baseHealthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
        baseHealthBar.BackgroundColor3 = Utilities.GetHealthColor(currentHealth, maxHealth)
        baseHealthText.Text = "🏠 " .. currentHealth .. "/" .. maxHealth
    end
    
    -- Таймер
    if timerLabel then
        local countdown = GameUI.GameState.CountdownTime
        if countdown and countdown > 0 then
            timerLabel.Text = "⏱️ " .. GameData.FormatTime(math.ceil(countdown))
            timerLabel.Visible = true
        else
            timerLabel.Visible = false
        end
    end
end

-- Показ магазина
function GameUI.ShowShop()
    if GameUI.ShopFrame then
        GameUI.ShopFrame.Visible = true
        GameUI.UpdateShopUI()
        
        -- Анимация появления
        GameUI.ShopFrame.Size = UDim2.new(0, 0, 0, 0)
        local tween = TweenService:Create(GameUI.ShopFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 600, 0, 400)
        })
        tween:Play()
    end
end

-- Скрытие магазина
function GameUI.HideShop()
    if GameUI.ShopFrame then
        -- Анимация исчезновения
        local tween = TweenService:Create(GameUI.ShopFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tween:Play()
        
        tween.Completed:Connect(function()
            GameUI.ShopFrame.Visible = false
        end)
    end
end

-- Обновление UI магазина
function GameUI.UpdateShopUI()
    if not GameUI.ShopScrollFrame then return end
    
    -- Очищаем старые элементы
    for _, child in ipairs(GameUI.ShopScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Создаем элементы магазина
    -- Здесь будет код для получения данных о магазине с сервера
    -- Пока что создаем заглушку
    for i = 1, 5 do
        GameUI.CreateShopItem("Weapon" .. i, "Оружие " .. i, 1000 * i, true, false)
    end
    
    -- Обновляем размер содержимого
    GameUI.ShopScrollFrame.CanvasSize = UDim2.new(0, 0, 0, GameUI.ShopScrollFrame.UIListLayout.AbsoluteContentSize.Y)
end

-- Создание элемента магазина
function GameUI.CreateShopItem(weaponId, weaponName, price, canPurchase, isOwned)
    local frame = Instance.new("Frame")
    frame.Name = weaponId
    frame.Size = UDim2.new(1, -12, 0, 80)
    frame.BackgroundColor3 = GameData.Colors.Dark
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = GameUI.ShopScrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    -- Название оружия
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.6, -10, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = weaponName
    nameLabel.TextColor3 = GameData.Colors.Light
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = frame
    
    -- Цена
    local priceLabel = Instance.new("TextLabel")
    priceLabel.Size = UDim2.new(0.6, -10, 0.5, 0)
    priceLabel.Position = UDim2.new(0, 10, 0.5, 0)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = "💰 " .. GameData.FormatNumber(price)
    priceLabel.TextColor3 = GameData.Colors.Warning
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.SourceSans
    priceLabel.TextXAlignment = Enum.TextXAlignment.Left
    priceLabel.Parent = frame
    
    -- Кнопка покупки
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.3, -10, 0.6, 0)
    button.Position = UDim2.new(0.7, 0, 0.2, 0)
    button.Text = isOwned and "КУПЛЕНО" or (canPurchase and "КУПИТЬ" or "НЕТ ДЕНЕГ")
    button.TextColor3 = GameData.Colors.Light
    button.TextScaled = true
    button.Font = Enum.Font.SourceSansBold
    button.BorderSizePixel = 0
    button.Parent = frame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    if isOwned then
        button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        button.Text = "КУПЛЕНО"
    elseif canPurchase then
        button.BackgroundColor3 = GameData.Colors.Secondary
        button.Text = "КУПИТЬ"
        
        button.MouseButton1Click:Connect(function()
            purchaseWeaponEvent:FireServer(weaponId)
        end)
    else
        button.BackgroundColor3 = GameData.Colors.Danger
        button.Text = "НЕТ ДЕНЕГ"
    end
    
    return frame
end

-- Обновление статуса оружия
function GameUI.UpdateWeaponStatus(status)
    if not GameUI.WeaponFrame then return end
    
    local statusLabel = GameUI.WeaponFrame:FindFirstChild("StatusLabel")
    if statusLabel then
        statusLabel.Text = status
        
        if status == "Перезарядка..." then
            statusLabel.TextColor3 = GameData.Colors.Warning
        elseif status == "Готов к стрельбе" then
            statusLabel.TextColor3 = GameData.Colors.Secondary
        else
            statusLabel.TextColor3 = GameData.Colors.Light
        end
    end
end

-- Обработчики событий
updateUIEvent.OnClientEvent:Connect(function(updateType, data)
    if updateType == "PlayerData" then
        GameUI.PlayerData = data
        GameUI.UpdateStatsUI()
        GameUI.UpdateWeaponUI()
    elseif updateType == "GameState" then
        GameUI.GameState = data
        GameUI.UpdateGameStateUI()
    elseif updateType == "WeaponAmmo" then
        GameUI.WeaponAmmo = data
        GameUI.UpdateWeaponUI()
    elseif updateType == "WeaponStatus" then
        GameUI.UpdateWeaponStatus(data)
    elseif updateType == "ShowShop" then
        GameUI.ShowShop()
    elseif updateType == "HideShop" then
        GameUI.HideShop()
    end
end)

-- Управление клавишами
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Tab then
        if GameUI.ShopFrame.Visible then
            GameUI.HideShop()
        else
            GameUI.ShowShop()
        end
    elseif input.KeyCode == Enum.KeyCode.Escape then
        if GameUI.ShopFrame.Visible then
            GameUI.HideShop()
        end
    end
end)

-- Инициализация
function GameUI.Initialize()
    Utilities.Debug("Инициализация GameUI")
    
    -- Ждем загрузки персонажа
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    
    wait(1) -- Даем время другим скриптам загрузиться
    
    GameUI.CreateMainUI()
    
    -- Начальное обновление UI
    GameUI.UpdateStatsUI()
    GameUI.UpdateWeaponUI()
    GameUI.UpdateGameStateUI()
end

-- Запуск инициализации
spawn(function()
    GameUI.Initialize()
end)

return GameUI