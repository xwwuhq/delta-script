local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.IgnoreGuiInset = true

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.35, 0.2)
frame.Position = UDim2.fromScale(0.325, 0.4)
frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,20)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1,0.4)
title.BackgroundTransparency = 1
title.Text = "X77UHQ LOADING"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)

local barBg = Instance.new("Frame", frame)
barBg.Size = UDim2.fromScale(0.8,0.15)
barBg.Position = UDim2.fromScale(0.1,0.65)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0,10)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.fromRGB(0,200,255)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,10)

local tween = TweenService:Create(
	bar,
	TweenInfo.new(30, Enum.EasingStyle.Linear),
	{Size = UDim2.fromScale(1,1)}
)

tween:Play()
tween.Completed:Wait()

gui:Destroy()

loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/bbc3ea0dde107fad93f71c4a20b96040.lua"))()