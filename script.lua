if getgenv().HyzerLoaded then return end
getgenv().HyzerLoaded = true

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local VALID_KEY = "VIP_KEY_1767034872976"
local KeyValidated = false

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "HyzerLuxe"

local Panel = Instance.new("Frame", ScreenGui)
Panel.Size = UDim2.fromOffset(280, 360)
Panel.Position = UDim2.new(0, 20, 0, 20)
Panel.BackgroundColor3 = Color3.fromRGB(12, 14, 25)
Panel.BorderSizePixel = 0
Panel.Active = true

Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 18)
local Stroke = Instance.new("UIStroke", Panel)
Stroke.Color = Color3.fromRGB(0, 200, 255)
Stroke.Thickness = 2

-- Player Info
local PlayerFrame = Instance.new("Frame", Panel)
PlayerFrame.Size = UDim2.new(1, -20, 0, 50)
PlayerFrame.Position = UDim2.new(0, 10, 0, 10)
PlayerFrame.BackgroundTransparency = 1

local Headshot = Instance.new("ImageLabel", PlayerFrame)
Headshot.Size = UDim2.fromOffset(40,40)
Headshot.Position = UDim2.new(0,0,0.5,-20)
Headshot.BackgroundTransparency = 1
Headshot.Image = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

local Username = Instance.new("TextLabel", PlayerFrame)
Username.Size = UDim2.new(1, -50, 1, 0)
Username.Position = UDim2.new(0,50,0,0)
Username.BackgroundTransparency = 1
Username.Text = Player.Name
Username.Font = Enum.Font.GothamBold
Username.TextSize = 18
Username.TextColor3 = Color3.fromRGB(0,200,255)
Username.TextXAlignment = Enum.TextXAlignment.Left

-- Drag GUI
do
    local dragging, dragStart, startPos
    Panel.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = i.Position
            startPos = Panel.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - dragStart
            Panel.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Key input
local KeyBox = Instance.new("TextBox", Panel)
KeyBox.Size = UDim2.new(1, -20, 0, 30)
KeyBox.Position = UDim2.new(0, 10, 0, 70)
KeyBox.PlaceholderText = "Enter VIP Key"
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 22, 40)
KeyBox.BorderSizePixel = 0
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,10)

local KeyButton = Instance.new("TextButton", Panel)
KeyButton.Size = UDim2.new(1, -20, 0, 30)
KeyButton.Position = UDim2.new(0, 10, 0, 105)
KeyButton.Text = "VALIDATE KEY"
KeyButton.Font = Enum.Font.GothamBold
KeyButton.TextSize = 14
KeyButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
KeyButton.TextColor3 = Color3.new(1,1,1)
KeyButton.BorderSizePixel = 0
Instance.new("UICorner", KeyButton).CornerRadius = UDim.new(0,10)

KeyButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == VALID_KEY then
        KeyValidated = true
        KeyButton.Text = "KEY ACCEPTED"
        KeyButton.BackgroundColor3 = Color3.fromRGB(0,200,255)
    else
        KeyButton.Text = "INVALID KEY"
        KeyButton.BackgroundColor3 = Color3.fromRGB(200,60,60)
    end
end)

-- Scrolling frame pour toggles
local Scroll = Instance.new("ScrollingFrame", Panel)
Scroll.Size = UDim2.new(1, -20, 1, -150)
Scroll.Position = UDim2.new(0, 10, 0, 140)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0,0,0,300)
Scroll.ScrollBarThickness = 6
Scroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local UIList = Instance.new("UIListLayout", Scroll)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0,8)

-- DYCN, Speed, InfJump, NoClip, ESP toggles
local InfJump = false
local speedBV, speedConn
local NoClipConn
local ESP

pcall(function()
    ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/ESP.lua"))()
    ESP.Settings.Enabled = false
    ESP.Load()
end)

local function ExecuteDYCN()
    local FFlags = {
        GameNetPVHeaderRotationalVelocityZeroCutoffExponent = -5000,
        LargeReplicatorWrite5 = true,
        LargeReplicatorEnabled9 = true,
        AngularVelociryLimit = 360,
        TimestepArbiterVelocityCriteriaThresholdTwoDt = 2147483646
    }
    local player = Players.LocalPlayer
    local function respawnar(plr)
        local char = plr.Character
        local hum = char and char:FindFirstChildWhichIsA('Humanoid')
        if hum then hum:ChangeState(Enum.HumanoidStateType.Dead) end
        char:ClearAllChildren()
        local newChar = Instance.new('Model')
        newChar.Parent = workspace
        plr.Character = newChar
        task.wait()
        plr.Character = char
        newChar:Destroy()
    end
    for name, value in pairs(FFlags) do
        pcall(function() setfflag(tostring(name), tostring(value)) end)
    end
    pcall(function() respawnar(player) end)
end

local function CreateToggle(text, callback)
    local Holder = Instance.new("Frame", Scroll)
    Holder.Size = UDim2.new(1, 0, 0, 36)
    Holder.BackgroundColor3 = Color3.fromRGB(18, 20, 35)
    Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)

    local Label = Instance.new("TextLabel", Holder)
    Label.Size = UDim2.new(0.6,0,1,0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(220,220,220)

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(0.35,0,0.7,0)
    Button.Position = UDim2.new(0.63,0,0.15,0)
    Button.Text = "OFF"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.BackgroundColor3 = Color3.fromRGB(60,60,60)
    Button.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1,0)

    local state = false
    Button.MouseButton1Click:Connect(function()
        if not KeyValidated then return end
        state = not state
        Button.Text = state and "ON" or "OFF"
        Button.BackgroundColor3 = state and Color3.fromRGB(0,200,255) or Color3.fromRGB(60,60,60)
        callback(state)
    end)
end

CreateToggle("DYCN", function(v) if v then ExecuteDYCN() end end)
CreateToggle("Speed Boost", function(v)
    local char = Player.Character or Player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    if v then
        if speedBV then speedBV:Destroy() end
        speedBV = Instance.new("BodyVelocity", root)
        speedBV.MaxForce = Vector3.new(40000,0,40000)
        speedConn = RunService.RenderStepped:Connect(function()
            if speedBV and speedBV.Parent then
                speedBV.Velocity = char.Humanoid.MoveDirection * 55
            end
        end)
    else
        if speedBV then speedBV:Destroy() speedBV=nil end
        if speedConn then speedConn:Disconnect() speedConn=nil end
    end
end)
CreateToggle("Infinite Jump", function(v) InfJump = v end)
UserInputService.JumpRequest:Connect(function() if InfJump then local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end end)
CreateToggle("NoClip", function(v)
    local char = Player.Character or Player.CharacterAdded:Wait()
    local function ncLoop() for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = not v end end end
    if v then NoClipConn = RunService.RenderStepped:Connect(ncLoop)
    else if NoClipConn then NoClipConn:Disconnect() NoClipConn=nil end ncLoop() end
end)
CreateToggle("ESP", function(v) if ESP then ESP.Settings.Enabled = v end end)