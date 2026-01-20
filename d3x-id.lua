local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local lp = Players.LocalPlayer

-- // Nettoyage
if CoreGui:FindFirstChild("D3X_CyberID") then CoreGui.D3X_CyberID:Destroy() end

-- // UI Principale
local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "D3X_CyberID"

local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 0, 0, 0) -- Animation d'ouverture
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 255, 255)
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- // Dégradé sur le contour
local Gradient = Instance.new("UIGradient", Stroke)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255))
})

-- // Titre
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "D3X // IDENTITY"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16

-- // Ligne de séparation
local Line = Instance.new("Frame", Main)
Line.Size = UDim2.new(0.8, 0, 0, 1)
Line.Position = UDim2.new(0.1, 0, 0, 35)
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 0.8

-- // ID Affichage
local DisplayID = Instance.new("TextLabel", Main)
DisplayID.Size = UDim2.new(1, 0, 0, 40)
DisplayID.Position = UDim2.new(0, 0, 0.4, 0)
DisplayID.BackgroundTransparency = 1
DisplayID.Text = lp.UserId
DisplayID.TextColor3 = Color3.fromRGB(200, 200, 200)
DisplayID.Font = Enum.Font.Code
DisplayID.TextSize = 25

-- // Bouton de Copie
local Btn = Instance.new("TextButton", Main)
Btn.Size = UDim2.new(0.8, 0, 0, 40)
Btn.Position = UDim2.new(0.1, 0, 0.7, 0)
Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Btn.Text = "GRAB ID"
Btn.TextColor3 = Color3.fromRGB(0, 255, 255)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 14
Btn.AutoButtonColor = false

local BtnCorner = Instance.new("UICorner", Btn)
local BtnStroke = Instance.new("UIStroke", Btn)
BtnStroke.Color = Color3.fromRGB(0, 255, 255)
BtnStroke.Thickness = 1

-- // Animation d'ouverture
TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 280, 0, 180)}):Play()

-- // Logique de Drag
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

-- // Clique et Effets
Btn.MouseButton1Click:Connect(function()
    setclipboard(tostring(lp.UserId))
    
    -- Animation Flash
    Btn.Text = "ID COPIED TO CLIPBOARD"
    Btn.TextColor3 = Color3.new(1,1,1)
    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 255)}):Play()
    TweenService:Create(Btn, TweenInfo.new(0.2), {TextColor3 = Color3.new(0,0,0)}):Play()
    
    task.wait(1.5)
    
    Btn.Text = "GRAB ID"
    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
    TweenService:Create(Btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(0, 255, 255)}):Play()
end)

-- Animation rotation du dégradé pour le style
task.spawn(function()
    while task.wait() do
        Gradient.Rotation = Gradient.Rotation + 2
    end
end)
