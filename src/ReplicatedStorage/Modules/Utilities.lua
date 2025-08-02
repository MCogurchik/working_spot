-- Utilities.lua
-- ModuleScript с утилитарными функциями

local Utilities = {}

-- Функция для безопасного получения ребенка объекта
function Utilities.SafeWaitForChild(parent, childName, timeOut)
    timeOut = timeOut or 5
    local child = parent:FindFirstChild(childName)
    if child then
        return child
    end
    
    local startTime = tick()
    while not child and (tick() - startTime) < timeOut do
        child = parent:FindFirstChild(childName)
        if not child then
            wait(0.1)
        end
    end
    
    if not child then
        warn("Не удалось найти " .. childName .. " в " .. parent.Name)
    end
    
    return child
end

-- Функция для создания Tween анимации
function Utilities.CreateTween(object, info, properties)
    local TweenService = game:GetService("TweenService")
    local tween = TweenService:Create(object, info, properties)
    return tween
end

-- Функция для интерполяции между двумя цветами
function Utilities.LerpColor(color1, color2, alpha)
    return Color3.new(
        color1.R + (color2.R - color1.R) * alpha,
        color1.G + (color2.G - color1.G) * alpha,
        color1.B + (color2.B - color1.B) * alpha
    )
end

-- Функция для получения цвета здоровья (зеленый -> желтый -> красный)
function Utilities.GetHealthColor(currentHealth, maxHealth)
    local healthPercent = currentHealth / maxHealth
    
    if healthPercent > 0.5 then
        -- Зеленый -> Желтый
        local t = (healthPercent - 0.5) * 2
        return Utilities.LerpColor(Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0), t)
    else
        -- Желтый -> Красный
        local t = healthPercent * 2
        return Utilities.LerpColor(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0), t)
    end
end

-- Функция для вычисления расстояния между двумя позициями
function Utilities.GetDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

-- Функция для вычисления расстояния в 2D (игнорируя Y)
function Utilities.GetDistance2D(pos1, pos2)
    local diff = pos1 - pos2
    return Vector2.new(diff.X, diff.Z).Magnitude
end

-- Функция для нормализации вектора
function Utilities.NormalizeVector(vector)
    if vector.Magnitude > 0 then
        return vector.Unit
    else
        return Vector3.new(0, 0, 0)
    end
end

-- Функция для получения случайной позиции в радиусе
function Utilities.GetRandomPositionInRadius(center, radius)
    local angle = math.random() * math.pi * 2
    local distance = math.random() * radius
    
    return center + Vector3.new(
        math.cos(angle) * distance,
        0,
        math.sin(angle) * distance
    )
end

-- Функция для создания эффекта частиц
function Utilities.CreateParticleEffect(parent, effectId, duration)
    duration = duration or 2
    
    local attachment = Instance.new("Attachment")
    attachment.Parent = parent
    
    local particles = Instance.new("ParticleEmitter")
    particles.Texture = effectId
    particles.Parent = attachment
    particles.Enabled = true
    
    -- Удаляем эффект через некоторое время
    game:GetService("Debris"):AddItem(attachment, duration)
    
    return particles
end

-- Функция для воспроизведения звука
function Utilities.PlaySound(soundId, volume, parent)
    volume = volume or 0.5
    parent = parent or workspace
    
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume
    sound.Parent = parent
    sound:Play()
    
    -- Удаляем звук после окончания воспроизведения
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    return sound
end

-- Функция для создания 3D текста над объектом
function Utilities.Create3DText(text, position, color, size, duration)
    color = color or Color3.fromRGB(255, 255, 255)
    size = size or 2
    duration = duration or 2
    
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.Transparency = 1
    part.CanCollide = false
    part.Anchored = true
    part.Position = position
    part.Parent = workspace
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = part
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = color
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = billboardGui
    
    -- Анимация движения вверх
    local TweenService = game:GetService("TweenService")
    local moveInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local moveTween = TweenService:Create(part, moveInfo, {
        Position = position + Vector3.new(0, 5, 0)
    })
    
    local fadeInfo = TweenInfo.new(duration * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeTween = TweenService:Create(textLabel, fadeInfo, {
        TextTransparency = 1
    })
    
    moveTween:Play()
    wait(duration * 0.5)
    fadeTween:Play()
    
    game:GetService("Debris"):AddItem(part, duration)
    
    return part
end

-- Функция для создания полосы здоровья над объектом
function Utilities.CreateHealthBar(parent, maxHealth)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 20)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = parent
    
    -- Фон полосы здоровья
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    background.BorderSizePixel = 2
    background.BorderColor3 = Color3.fromRGB(0, 0, 0)
    background.Parent = billboardGui
    
    -- Полоса здоровья
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(1, -4, 1, -4)
    healthBar.Position = UDim2.new(0, 2, 0, 2)
    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = background
    
    -- Текст здоровья
    local healthText = Instance.new("TextLabel")
    healthText.Size = UDim2.new(1, 0, 1, 0)
    healthText.BackgroundTransparency = 1
    healthText.Text = maxHealth .. "/" .. maxHealth
    healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
    healthText.TextScaled = true
    healthText.Font = Enum.Font.SourceSansBold
    healthText.TextStrokeTransparency = 0
    healthText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    healthText.Parent = background
    
    return {
        GUI = billboardGui,
        HealthBar = healthBar,
        HealthText = healthText,
        MaxHealth = maxHealth,
        
        UpdateHealth = function(self, currentHealth)
            local healthPercent = math.max(0, currentHealth / self.MaxHealth)
            self.HealthBar.Size = UDim2.new(healthPercent, -4, 1, -4)
            self.HealthBar.BackgroundColor3 = Utilities.GetHealthColor(currentHealth, self.MaxHealth)
            self.HealthText.Text = math.max(0, math.floor(currentHealth)) .. "/" .. self.MaxHealth
        end,
        
        Destroy = function(self)
            if self.GUI then
                self.GUI:Destroy()
            end
        end
    }
end

-- Функция для проверки линии видимости между двумя точками
function Utilities.HasLineOfSight(startPos, endPos, ignoreList)
    ignoreList = ignoreList or {}
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = ignoreList
    
    local direction = endPos - startPos
    local result = workspace:Raycast(startPos, direction, raycastParams)
    
    return result == nil -- Если нет препятствий, возвращаем true
end

-- Функция для поиска ближайшего объекта из списка
function Utilities.FindClosestObject(position, objectList, maxDistance)
    maxDistance = maxDistance or math.huge
    
    local closestObject = nil
    local closestDistance = maxDistance
    
    for _, object in ipairs(objectList) do
        if object and object.Parent then
            local objectPos = object.Position
            if object:IsA("Model") and object.PrimaryPart then
                objectPos = object.PrimaryPart.Position
            end
            
            local distance = Utilities.GetDistance(position, objectPos)
            if distance < closestDistance then
                closestDistance = distance
                closestObject = object
            end
        end
    end
    
    return closestObject, closestDistance
end

-- Функция для создания взрыва
function Utilities.CreateExplosion(position, damage, radius, ignoreList)
    ignoreList = ignoreList or {}
    
    -- Визуальный эффект взрыва
    local explosion = Instance.new("Explosion")
    explosion.Position = position
    explosion.BlastRadius = radius
    explosion.BlastPressure = 0 -- Отключаем физику взрыва
    explosion.Parent = workspace
    
    -- Находим всех зомби в радиусе взрыва
    local objectsInRadius = {}
    for _, object in ipairs(workspace:GetChildren()) do
        if object:IsA("Model") and object:FindFirstChild("Humanoid") then
            local isIgnored = false
            for _, ignoredObject in ipairs(ignoreList) do
                if object == ignoredObject then
                    isIgnored = true
                    break
                end
            end
            
            if not isIgnored and object.PrimaryPart then
                local distance = Utilities.GetDistance(position, object.PrimaryPart.Position)
                if distance <= radius then
                    -- Урон уменьшается с расстоянием
                    local damageMultiplier = 1 - (distance / radius)
                    local finalDamage = damage * damageMultiplier
                    table.insert(objectsInRadius, {Object = object, Damage = finalDamage})
                end
            end
        end
    end
    
    return objectsInRadius
end

-- Функция для сохранения данных игрока (заглушка для будущего DataStore)
function Utilities.SavePlayerData(player, data)
    -- Здесь будет код для сохранения в DataStore
    print("Сохранение данных игрока " .. player.Name)
end

-- Функция для загрузки данных игрока (заглушка для будущего DataStore)
function Utilities.LoadPlayerData(player)
    -- Здесь будет код для загрузки из DataStore
    print("Загрузка данных игрока " .. player.Name)
    
    -- Возвращаем стандартные данные
    return {
        Coins = 500,
        Experience = 0,
        Level = 1,
        Weapons = {"Glock"},
        WeaponLevels = {Glock = 1},
        UnlockedWeapons = {"Glock"}
    }
end

-- Функция для дебага (выводит сообщение с временной меткой)
function Utilities.Debug(message, level)
    level = level or "INFO"
    local timestamp = os.date("%H:%M:%S")
    print("[" .. timestamp .. "] [" .. level .. "] " .. message)
end

return Utilities