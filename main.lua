-- 404


































local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer

-- Positions TP
local locations = {
    Vector3.new(107.68, 3.23, 141.31),
    Vector3.new(215.24, 95.87, 177.57),
    Vector3.new(985.55, 129.82, 239.75),
    Vector3.new(4015.00, 14.95, 240.65),
    Vector3.new(4034.26, -2.77, 62.42)
}

-- États
local espActive = false
local jumpActive = false

-- // 1. CRÉDIT X77 // --
if CoreGui:FindFirstChild("X77Credit") then CoreGui.X77Credit:Destroy() end
local CreditGui = Instance.new("ScreenGui", CoreGui)
CreditGui.Name = "X77Credit"

local X77Label = Instance.new("TextLabel", CreditGui)
X77Label.Size = UDim2.new(0, 200, 0, 30)
X77Label.Position = UDim2.new(0.5, -100, 0, 10)
X77Label.BackgroundTransparency = 1
X77Label.Text = "DEV BY X77"
X77Label.TextColor3 = Color3.fromRGB(255, 0, 0)
X77Label.Font = Enum.Font.GothamBlack
X77Label.TextSize = 18

-- // 2. PANEL PRINCIPAL // --
if CoreGui:FindFirstChild("LamanittaEliteV7") then CoreGui.LamanittaEliteV7:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "LamanittaEliteV7"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 240, 0, 320)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(255, 0, 0)
Stroke.Thickness = 3

-- Effet de points qui volent DANS le panel
for i = 1, 20 do
    local p = Instance.new("Frame", MainFrame)
    p.Size = UDim2.new(0, 2, 0, 2)
    p.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    p.BackgroundTransparency = 0.4
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    task.spawn(function()
        local speedX = math.random(-10, 10) / 1000
        local speedY = math.random(-10, 10) / 1000
        while RunService.RenderStepped:Wait() do
            p.Position = p.Position + UDim2.new(speedX, 0, speedY, 0)
            if p.Position.X.Scale > 1 then p.Position = UDim2.new(0, 0, p.Position.Y.Scale, 0) end
            if p.Position.X.Scale < 0 then p.Position = UDim2.new(1, 0, p.Position.Y.Scale, 0) end
            if p.Position.Y.Scale > 1 then p.Position = UDim2.new(p.Position.X.Scale, 0, 0, 0) end
            if p.Position.Y.Scale < 0 then p.Position = UDim2.new(p.Position.X.Scale, 0, 1, 0) end
        end
    end)
end

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "LAMANITTA ELITE V7"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 15
Title.BackgroundTransparency = 1

local function CreateBtn(text, pos)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 200, 0, 38)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBlack
    btn.TextSize = 10
    Instance.new("UICorner", btn)
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(60, 0, 0)
    return btn
end

local TP1 = CreateBtn("TP ZONE | CÉLESTE", UDim2.new(0.5, -100, 0.15, 0))
local TP2 = CreateBtn("TP ZONE | YOUR BASE", UDim2.new(0.5, -100, 0.3, 0))
local ESPBtn = CreateBtn("ESP JOUEURS : OFF", UDim2.new(0.5, -100, 0.45, 0))
local JumpBtn = CreateBtn("INF JUMP : OFF", UDim2.new(0.5, -100, 0.6, 0))
local LuckBtn = CreateBtn("LUCK MACHINE", UDim2.new(0.5, -100, 0.75, 0))

-- // 3. LOGIQUE LUCK MACHINE (SUR BOUTON) // --
LuckBtn.MouseButton1Click:Connect(function()
    local oldText = LuckBtn.Text
    local msgs = {"CONNEXION...", "INJECTION...", "BYPASS...", "LUCK x999!"}
    LuckBtn.Active = false
    for _, m in pairs(msgs) do
        LuckBtn.Text = m
        task.wait(0.8)
    end
    LuckBtn.Text = oldText
    LuckBtn.Active = true
end)

-- // 4. LOGIQUE INFINITE JUMP (FIXED) // --
JumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    JumpBtn.Text = jumpActive and "INF JUMP : ON" or "INF JUMP : OFF"
    JumpBtn.BackgroundColor3 = jumpActive and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(20, 20, 20)
end)

UserInputService.JumpRequest:Connect(function()
    if jumpActive and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- // 5. LOGIQUES TP & ESP // --
local function runPath(reverse)
    local char = lp.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local list = reverse and {} or locations
    if reverse then for i = #locations, 1, -1 do table.insert(list, locations[i]) end end
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.new(0,0,0)
    for _, pos in ipairs(list) do
        local dist = (hrp.Position - pos).Magnitude
        TweenService:Create(hrp, TweenInfo.new(dist/600, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
        task.wait(dist/600 + 0.1)
    end
    bv:Destroy()
end

TP1.MouseButton1Click:Connect(function() runPath(false) end)
TP2.MouseButton1Click:Connect(function() runPath(true) end)

ESPBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    ESPBtn.Text = espActive and "ESP JOUEURS : ON" or "ESP JOUEURS : OFF"
    ESPBtn.BackgroundColor3 = espActive and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(20, 20, 20)
end)

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local esp = head:FindFirstChild("LamanittaESP")
            if espActive then
                if not esp then
                    local bbg = Instance.new("BillboardGui", head)
                    bbg.Name = "LamanittaESP"
                    bbg.AlwaysOnTop = true
                    bbg.Size = UDim2.new(0, 100, 0, 50)
                    bbg.StudsOffset = Vector3.new(0, 3, 0)
                    local lbl = Instance.new("TextLabel", bbg)
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = player.Name
                    lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextSize = 14
                end
            elseif esp then esp:Destroy() end
        end
    end
end)
