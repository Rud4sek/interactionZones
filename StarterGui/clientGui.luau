local replicatedStorage = game:GetService("ReplicatedStorage")
local events = replicatedStorage:WaitForChild("Events")
local keyPressed = events:WaitForChild("keyPressed")

local userInputService = game:GetService("UserInputService")

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        keyPressed:Fire()
    end
end)

-- Create UI

local players = game:GetService("Players")
local playerGui = players.LocalPlayer:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "interactionsScreenGui"
screenGui.Parent = playerGui

local interactionGui = Instance.new("TextLabel")
interactionGui.Parent = screenGui
interactionGui.Name = "interactionGui"
interactionGui.AnchorPoint = Vector2.new(.5, .5)
interactionGui.Position = UDim2.fromScale(0.065, .5)
interactionGui.Size = UDim2.fromScale(0.104, 0.042)
interactionGui.BackgroundColor3 = Color3.fromRGB(73, 36, 62)
interactionGui.TextColor3 = Color3.fromRGB(219, 175, 160)
interactionGui.Font = "FredokaOne"
interactionGui.TextScaled = true
interactionGui.Visible = false

local interactionCorner = Instance.new("UICorner")
interactionCorner.Name = "interactionCorner"
interactionCorner.Parent = interactionGui
interactionCorner.CornerRadius = UDim.new(.15, 0)

local interactionPadding = Instance.new("UIPadding")
interactionPadding.Name = "interactionPadding"
interactionPadding.Parent = interactionGui
interactionPadding.PaddingBottom = UDim.new(.1, 0)
interactionPadding.PaddingLeft = UDim.new(.1, 0)
interactionPadding.PaddingRight = UDim.new(.1, 0)
interactionPadding.PaddingTop = UDim.new(.1, 0)

local interactionTextSizeConstraint = Instance.new("UITextSizeConstraint")
interactionTextSizeConstraint.Name = "interactionTextSizeConstraint"
interactionTextSizeConstraint.Parent = interactionGui
interactionTextSizeConstraint.MaxTextSize = 24
interactionTextSizeConstraint.MinTextSize = 1