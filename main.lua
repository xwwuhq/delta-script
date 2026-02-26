-- 404

































local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local text = Instance.new("TextLabel")
text.Parent = gui
text.Size = UDim2.new(1, 0, 1, 0) -- plein écran
text.Position = UDim2.new(0, 0, 0, 0)
text.BackgroundTransparency = 1

text.Text = "SCAMEUR DEBAN MOI\nSINON T'AURA PAS DE SCRIPT"
text.TextColor3 = Color3.fromRGB(255, 0, 0)
text.TextStrokeTransparency = 0
text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

text.TextScaled = true
text.Font = Enum.Font.Arcade
text.TextWrapped = true

-- petit effet clignotant
while true do
	text.Visible = true
	wait(0.5)
	text.Visible = false
	wait(0.5)
end