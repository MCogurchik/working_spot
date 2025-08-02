-- RemoteEvents.lua
-- ModuleScript для управления Remote Events между клиентом и сервером

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создаем папку для Remote Events если её нет
local remoteEventsFolder = ReplicatedStorage:FindFirstChild("RemoteEvents")
if not remoteEventsFolder then
    remoteEventsFolder = Instance.new("Folder")
    remoteEventsFolder.Name = "RemoteEvents"
    remoteEventsFolder.Parent = ReplicatedStorage
end

-- Создаем папку для Remote Functions если её нет
local remoteFunctionsFolder = ReplicatedStorage:FindFirstChild("RemoteFunctions")
if not remoteFunctionsFolder then
    remoteFunctionsFolder = Instance.new("Folder")
    remoteFunctionsFolder.Name = "RemoteFunctions"
    remoteFunctionsFolder.Parent = ReplicatedStorage
end

local RemoteEvents = {}

-- Функция для создания RemoteEvent
function RemoteEvents.CreateRemoteEvent(name)
    local existingEvent = remoteEventsFolder:FindFirstChild(name)
    if existingEvent then
        return existingEvent
    end
    
    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = name
    remoteEvent.Parent = remoteEventsFolder
    return remoteEvent
end

-- Функция для создания RemoteFunction
function RemoteEvents.CreateRemoteFunction(name)
    local existingFunction = remoteFunctionsFolder:FindFirstChild(name)
    if existingFunction then
        return existingFunction
    end
    
    local remoteFunction = Instance.new("RemoteFunction")
    remoteFunction.Name = name
    remoteFunction.Parent = remoteFunctionsFolder
    return remoteFunction
end

-- Функция для получения RemoteEvent
function RemoteEvents.GetRemoteEvent(name)
    return remoteEventsFolder:WaitForChild(name)
end

-- Функция для получения RemoteFunction
function RemoteEvents.GetRemoteFunction(name)
    return remoteFunctionsFolder:WaitForChild(name)
end

-- Создаем основные Remote Events
local events = {
    -- Игровые события
    "GameStateChanged",
    "WaveStarted",
    "WaveCompleted",
    "GameOver",
    
    -- Зомби события
    "ZombieSpawned",
    "ZombieDied",
    "ZombieDamaged",
    
    -- Оружие события
    "WeaponFired",
    "WeaponReloaded",
    "WeaponSwitched",
    "WeaponUpgraded",
    
    -- Экономика
    "CoinsChanged",
    "PurchaseWeapon",
    "UpgradeWeapon",
    
    -- База
    "BaseDamaged",
    "BaseRepaired",
    
    -- UI события
    "UpdateUI",
    "ShowShop",
    "HideShop"
}

local functions = {
    -- Функции покупки
    "CanPurchaseWeapon",
    "CanUpgradeWeapon",
    "GetPlayerData",
    "GetWeaponData",
    "GetZombieData"
}

-- Создаем все события
for _, eventName in ipairs(events) do
    RemoteEvents.CreateRemoteEvent(eventName)
end

-- Создаем все функции
for _, functionName in ipairs(functions) do
    RemoteEvents.CreateRemoteFunction(functionName)
end

return RemoteEvents