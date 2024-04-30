local players = game:GetService("Players")
local player = players.LocalPlayer
player.CharacterAdded:Wait()
local playerCharacter = player.Character

local replicatedStorage = game:GetService("ReplicatedStorage")
local config = require(replicatedStorage:WaitForChild("config"))

local events = replicatedStorage:WaitForChild("Events")
local keyPressed = events:WaitForChild("keyPressed")

local playerGui = player:WaitForChild("PlayerGui")
local interactionScreenGui = playerGui:WaitForChild("interactionsScreenGui")
local interactionGui = interactionScreenGui:WaitForChild("interactionGui")

local primaryInteractionPosition = interactionGui.Position

local TweenService = game:GetService("TweenService")

local currentWait = 0
local uiShown = false
local currentMarker = nil

local function showInteractionUi()
    interactionGui.Text = currentMarker.text
    interactionGui.Position = UDim2.fromScale(-primaryInteractionPosition.X.Scale, primaryInteractionPosition.Y.Scale)
    interactionGui.Visible = true
    local tweenAnimation = TweenService:Create(interactionGui, TweenInfo.new(0.15), {Position = UDim2.fromScale(primaryInteractionPosition.X.Scale, primaryInteractionPosition.Y.Scale)})
    tweenAnimation:Play()
end

local function hideInteractionUi()
    local tweenAnimation = TweenService:Create(interactionGui, TweenInfo.new(0.15), {Position = UDim2.fromScale(-primaryInteractionPosition.X.Scale, primaryInteractionPosition.Y.Scale)})
    tweenAnimation:Play()
    tweenAnimation.Completed:Wait()
    interactionGui.Visible = false
end

keyPressed.Event:Connect(function()
    if currentMarker ~= nil then
        currentMarker.onKeyPressed:Fire()
    end
end)

for k, v in pairs(config) do
    if v.debugSphere then
        local newSphere = Instance.new("Part")
        newSphere.Shape = Enum.PartType.Ball
        newSphere.Size = Vector3.new(v.distance, v.markerHeight, v.distance)
        newSphere.Transparency = 0.5
        newSphere.Color = Color3.fromRGB(255, 0, 0)
        newSphere.Anchored = true
        newSphere.Parent = game:GetService("Workspace")
        newSphere.Position = v.position
        newSphere.CanCollide = false
        newSphere.Material = Enum.Material.SmoothPlastic
    end

    local newMarker = v.markerType:Clone()
    newMarker.Parent = game:GetService("Workspace")
    newMarker.Position = v.markerPosition
    newMarker.Anchored = true
    newMarker.Size = Vector3.new(v.distance, v.markerHeight, v.distance)
end

while true do

    local found = false

    for k, v in pairs(config) do
        local distance = (v.position - playerCharacter:WaitForChild("HumanoidRootPart").Position).Magnitude
        if distance <= v.distance then
            found = k
        end
    end

    if found then
        currentWait = 0
        currentMarker = config[found]
        if not uiShown then
            uiShown = true
            showInteractionUi()
        end
    else
        if currentMarker ~= nil then
            if currentMarker.onMarkerExit then
                currentMarker.onMarkerExit:Fire()
            end
        end
        currentWait = .5
        currentMarker = nil
        if uiShown then
            uiShown = false
            hideInteractionUi()
        end
    end

    task.wait(currentWait)
end