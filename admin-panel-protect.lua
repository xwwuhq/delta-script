local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.IgnoreGuiInset = true

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.fromScale(0.35, 0.22)
panel.Position = UDim2.fromScale(0.325, 0.39)
panel.BackgroundColor3 = Color3.fromRGB(20,20,25)
panel.BorderSizePixel = 0
Instance.new("UICorner", panel).CornerRadius = UDim.new(0,20)
local stroke = Instance.new("UIStroke", panel)
stroke.Thickness = 2

local title = Instance.new("TextLabel", panel)
title.Size = UDim2.fromScale(1,0.45)
title.Position = UDim2.fromScale(0,0.05)
title.BackgroundTransparency = 1
title.Text = "X77UHQ"
title.Font = Enum.Font.Arcade
title.TextScaled = true

local subtitle = Instance.new("TextLabel", panel)
subtitle.Size = UDim2.fromScale(1,0.2)
subtitle.Position = UDim2.fromScale(0,0.5)
subtitle.BackgroundTransparency = 1
subtitle.Text = "CHARGEMENT..."
subtitle.Font = Enum.Font.Gotham
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(220,220,220)

local barBg = Instance.new("Frame", panel)
barBg.Size = UDim2.fromScale(0.8,0.08)
barBg.Position = UDim2.fromScale(0.1,0.8)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0,10)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.fromRGB(255,0,0)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,10)

spawn(function()
	while gui.Parent do
		local c = Color3.fromHSV((tick()*0.15)%1,1,1)
		title.TextColor3 = c
		bar.BackgroundColor3 = c
		stroke.Color = c
		RunService.RenderStepped:Wait()
	end
end)

local totalTime = 25
local steps = 100
local stepTime = totalTime / steps

for i = 1, steps do
	bar:TweenSize(UDim2.fromScale(i/steps,1), "Out", "Sine", stepTime, true)
	wait(stepTime)
end

wait(0.3)
gui:Destroy()

Lighting.Brightness = 3
Lighting.GlobalShadows = true
Lighting.Ambient = Color3.fromRGB(215,215,215)
Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)

local bloom = Instance.new("BloomEffect", Lighting)
bloom.Intensity = 0.25
bloom.Size = 18
bloom.Threshold = 1.2

local color = Instance.new("ColorCorrectionEffect", Lighting)
color.Brightness = 0.04
color.Contrast = 0.01
color.Saturation = 0.05
color.TintColor = Color3.fromRGB(255,255,255)

local sun = Instance.new("SunRaysEffect", Lighting)
sun.Intensity = 0.05
sun.Spread = 0.8

pcall(function()
	sethiddenproperty(Lighting,"Technology",Enum.Technology.Future)
end)

-- ADMIN PANEL FLOTTANT
local adminGui = Instance.new("ScreenGui")
adminGui.Parent = game.CoreGui
adminGui.IgnoreGuiInset = true

local adminPanel = Instance.new("Frame", adminGui)
adminPanel.Size = UDim2.fromOffset(300,120)
adminPanel.Position = UDim2.fromScale(0.35,0.35)
adminPanel.BackgroundColor3 = Color3.fromRGB(25,25,30)
Instance.new("UICorner", adminPanel).CornerRadius = UDim.new(0,15)
local stroke2 = Instance.new("UIStroke", adminPanel)
stroke2.Thickness = 2

local adminTitle = Instance.new("TextLabel", adminPanel)
adminTitle.Size = UDim2.fromScale(1,0.4)
adminTitle.Position = UDim2.fromScale(0,0)
adminTitle.BackgroundTransparency = 1
adminTitle.Text = "Admin Panel Protection Your Base"
adminTitle.TextScaled = true
adminTitle.Font = Enum.Font.GothamBold
adminTitle.TextColor3 = Color3.fromRGB(255,255,255)

local toggleBtn = Instance.new("TextButton", adminPanel)
toggleBtn.Size = UDim2.fromScale(0.6,0.3)
toggleBtn.Position = UDim2.fromScale(0.2,0.6)
toggleBtn.Text = "OFF"
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,10)

local enabled = false
toggleBtn.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		toggleBtn.Text = "ON"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
	else
		toggleBtn.Text = "OFF"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
	end
end)

-- DRAG FUNCTION
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
adminPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = adminPanel.Position
	end
end)
adminPanel.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		local delta = input.Position - dragStart
		adminPanel.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
adminPanel.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)