local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- ============ CHARGEMENT 30s ============
local gui = Instance.new("ScreenGui")
gui.Parent = CoreGui
gui.IgnoreGuiInset = true

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.fromScale(0.35,0.22)
panel.Position = UDim2.fromScale(0.325,0.39)
panel.BackgroundColor3 = Color3.fromRGB(15,15,20)
panel.BorderSizePixel = 0
Instance.new("UICorner", panel).CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke", panel)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0,200,255)

local title = Instance.new("TextLabel", panel)
title.Size = UDim2.fromScale(1,0.45)
title.Position = UDim2.fromScale(0,0.05)
title.BackgroundTransparency = 1
title.Text = "X77UHQ"
title.Font = Enum.Font.Arcade
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,0,0)

local subtitle = Instance.new("TextLabel", panel)
subtitle.Size = UDim2.fromScale(1,0.2)
subtitle.Position = UDim2.fromScale(0,0.5)
subtitle.BackgroundTransparency = 1
subtitle.Text = "CHARGEMENT..."
subtitle.Font = Enum.Font.GothamBold
subtitle.TextScaled = true
subtitle.TextColor3 = Color3.fromRGB(255,255,255)

local barBg = Instance.new("Frame", panel)
barBg.Size = UDim2.fromScale(0.8,0.08)
barBg.Position = UDim2.fromScale(0.1,0.8)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0,10)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.fromRGB(0,200,255)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,10)

spawn(function()
	while gui.Parent do
		local c = Color3.fromHSV((tick()*0.2)%1,1,1)
		title.TextColor3 = c
		bar.BackgroundColor3 = c
		stroke.Color = c
		RunService.RenderStepped:Wait()
	end
end)

local totalTime = 30
local steps = 100
local stepTime = totalTime / steps

for i = 1, steps do
	bar:TweenSize(UDim2.fromScale(i/steps,1), "Out", "Sine", stepTime, true)
	wait(stepTime)
end

gui:Destroy()

-- ============ PANEL ESP PLAYERS ============
local adminGui = Instance.new("ScreenGui")
adminGui.Parent = CoreGui
adminGui.IgnoreGuiInset = true

local adminPanel = Instance.new("Frame", adminGui)
adminPanel.Size = UDim2.fromOffset(300,150)
adminPanel.Position = UDim2.fromScale(0.35,0.35)
adminPanel.BackgroundColor3 = Color3.fromRGB(25,25,30)
Instance.new("UICorner", adminPanel).CornerRadius = UDim.new(0,15)
local stroke2 = Instance.new("UIStroke", adminPanel)
stroke2.Thickness = 2
stroke2.Color = Color3.fromRGB(0,200,255)

-- TITRE
local adminTitle = Instance.new("TextLabel", adminPanel)
adminTitle.Size = UDim2.fromScale(1,0.3)
adminTitle.Position = UDim2.fromScale(0,0)
adminTitle.BackgroundTransparency = 1
adminTitle.Text = "ESP Players Panel"
adminTitle.TextScaled = true
adminTitle.Font = Enum.Font.GothamBold
adminTitle.TextColor3 = Color3.fromRGB(255,255,255)

-- BOUTON
local espBtn = Instance.new("TextButton", adminPanel)
espBtn.Size = UDim2.fromScale(0.6,0.3)
espBtn.Position = UDim2.fromScale(0.2,0.5)
espBtn.Text = "ESP PLAYERS"
espBtn.TextScaled = true
espBtn.Font = Enum.Font.GothamBold
espBtn.BackgroundColor3 = Color3.fromRGB(0,200,255)
espBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0,10)

-- ACTION DU BOUTON
espBtn.MouseButton1Click:Connect(function()
	espBtn.Text = "ESP ACTIVÉ !"
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