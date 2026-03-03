-- 404 Not Found 















































































































































local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- GUI
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

-- RGB animation
spawn(function()
	while gui.Parent do
		local c = Color3.fromHSV((tick()*0.15)%1,1,1)
		title.TextColor3 = c
		bar.BackgroundColor3 = c
		stroke.Color = c
		RunService.RenderStepped:Wait()
	end
end)

-- PROGRESSION SUR 25 SECONDES
local totalTime = 25
local steps = 100
local stepTime = totalTime / steps

for i = 1, steps do
	bar:TweenSize(UDim2.fromScale(i/steps,1), "Out", "Sine", stepTime, true)
	wait(stepTime)
end

wait(0.3)
gui:Destroy()

-- ===== BOOST QUALITÉ (contraste TRÈS BAS) =====
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
color.Contrast = 0.01 -- CONTRASTE TRÈS BAS
color.Saturation = 0.05
color.TintColor = Color3.fromRGB(255,255,255)

local sun = Instance.new("SunRaysEffect", Lighting)
sun.Intensity = 0.05
sun.Spread = 0.8

pcall(function()
	sethiddenproperty(Lighting,"Technology",Enum.Technology.Future)
end)

print("Chargement terminé + qualité appliquée")

