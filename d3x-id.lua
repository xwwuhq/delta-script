local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer

-- // UI Création
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local Main = Instance.new("Frame", ScreenGui)
local Corner = Instance.new("UICorner", Main)
local Glow = Instance.new("UIStroke", Main)

Main.Size = UDim2.new(0, 250, 0, 150)
Main.Position = UDim2.new(0.5, -125, 0.5, -75)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0

Corner.CornerRadius = UDim.new(0, 15)
Glow.Thickness = 2
Glow.Color = Color3.fromRGB(170, 0, 255)

-- // Titre
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "D3X - ID COPY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- // Affichage ID
local IDLabel = Instance.new("TextLabel", Main)
IDLabel.Size = UDim2.new(1, 0, 0, 30)
IDLabel.Position = UDim2.new(0, 0, 0.35, 0)
IDLabel.BackgroundTransparency = 1
IDLabel.Text = "ID: " .. lp.UserId
IDLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
IDLabel.Font = Enum.Font.Gotham
IDLabel.TextSize = 16

-- // Bouton Copier
local CopyBtn = Instance.new("TextButton", Main)
CopyBtn.Size = UDim2.new(0, 180, 0, 35)
CopyBtn.Position = UDim2.new(0.5, -90, 0.7, 0)
CopyBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
CopyBtn.Text = "COPY MY ID"
CopyBtn.TextColor3 = Color3.new(1, 1, 1)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 14
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 8)

-- // Fonction Copie + Animation
CopyBtn.MouseButton1Click:Connect(function()
    setclipboard(tostring(lp.UserId))
    
    -- Animation Succès
    CopyBtn.Text = "COPIED ✅"
    TweenService:Create(CopyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 100)}):Play()
    TweenService:Create(Glow, TweenInfo.new(0.3), {Color = Color3.fromRGB(0, 255, 100)}):Play()
    
    task.wait(1.5)
    
    CopyBtn.Text = "COPY MY ID"
    TweenService:Create(CopyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(170, 0, 255)}):Play()
    TweenService:Create(Glow, TweenInfo.new(0.3), {Color = Color3.fromRGB(170, 0, 255)}):Play()
end)

-- // Draggable
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
