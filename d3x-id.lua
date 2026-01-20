local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local THEME = {
    Bg = Color3.fromRGB(15, 15, 20),
    Sidebar = Color3.fromRGB(10, 10, 15),
    Accent = Color3.fromRGB(170, 0, 255),
    Secondary = Color3.fromRGB(0, 255, 255),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(150, 150, 160),
    ItemBg = Color3.fromRGB(25, 25, 30),
    MacRed = Color3.fromRGB(255, 95, 87),
    MacYellow = Color3.fromRGB(255, 189, 46),
    MacGreen = Color3.fromRGB(39, 201, 63)
}

local State = { NoAnim = false, FpsKiller = false, IsMinimized = false, ItemEspActive = false, FpsBoostActive = false, PlayerEspActive = false }
local SIZES = { Full = UDim2.new(0, 550, 0, 320), Mini = UDim2.new(0, 140, 0, 320) }

local function executePlayerEsp()
    if State.PlayerEspActive then return end
    State.PlayerEspActive = true
    local function applyESP(character)
        if not character or character:FindFirstChild("ESP_HIGHLIGHT") then return end
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_HIGHLIGHT"
        hl.Adornee = character
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 0, 0)
        hl.FillTransparency = 0.6
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = character
    end
    local function onPlayer(player)
        if player == Player then return end
        if player.Character then applyESP(player.Character) end
        player.CharacterAdded:Connect(function(char) task.wait(1) applyESP(char) end)
    end
    for _, p in pairs(Players:GetPlayers()) do onPlayer(p) end
    Players.PlayerAdded:Connect(onPlayer)
end

local function executeFpsBoost()
    if State.FpsBoostActive then return end
    State.FpsBoostActive = true
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then v:Destroy() end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Material = Enum.Material.Plastic obj.CastShadow = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then obj.Enabled = false end
    end
end

local function executeItemEsp()
    if State.ItemEspActive then return end
    State.ItemEspActive = true
    local ESPs = {}
    local LastTool = {}
    local function getToolImage(tool)
        if tool.TextureId and tool.TextureId ~= "" then return tool.TextureId end
        local handle = tool:FindFirstChild("Handle")
        if handle then
            local mesh = handle:FindFirstChildOfClass("SpecialMesh")
            if mesh and mesh.TextureId ~= "" then return mesh.TextureId end
        end
        return nil
    end
    RunService.Heartbeat:Connect(function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Player then
                local char = plr.Character
                local tool = char and char:FindFirstChildOfClass("Tool")
                if tool and LastTool[plr] ~= tool then
                    if ESPs[plr] then ESPs[plr]:Destroy() end
                    local head = char:FindFirstChild("Head")
                    local imgId = getToolImage(tool)
                    if head and imgId then
                        local bb = Instance.new("BillboardGui")
                        bb.Adornee = head bb.Size = UDim2.new(0, 60, 0, 60) bb.StudsOffset = Vector3.new(0, 3, 0) bb.AlwaysOnTop = true bb.Parent = head
                        local img = Instance.new("ImageLabel")
                        img.Size = UDim2.new(1, 0, 1, 0) img.BackgroundTransparency = 1 img.Image = imgId img.Parent = bb
                        ESPs[plr] = bb LastTool[plr] = tool
                    end
                elseif not tool and ESPs[plr] then
                    ESPs[plr]:Destroy() ESPs[plr] = nil LastTool[plr] = nil
                end
            end
        end
    end)
end

if PlayerGui:FindFirstChild("D3X_V4") then PlayerGui.D3X_V4:Destroy() end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "D3X_V4" ScreenGui.ResetOnSpawn = false ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = SIZES.Full MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = THEME.Bg MainFrame.Active = true MainFrame.Draggable = true MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50) ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
ToggleBtn.BackgroundColor3 = THEME.Sidebar ToggleBtn.Text = "D3X" ToggleBtn.TextColor3 = THEME.Accent ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, 0) Sidebar.BackgroundColor3 = THEME.Sidebar Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Text = "D3X HUB" Title.Size = UDim2.new(1, 0, 0, 40) Title.TextColor3 = THEME.Secondary Title.BackgroundTransparency = 1 Title.Parent = Sidebar

local function createBtn(text, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 35) b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = THEME.ItemBg b.Text = text b.TextColor3 = Color3.new(1,1,1) b.Parent = MainFrame
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
end

createBtn("PLAYER ESP", 50, executePlayerEsp)
createBtn("ITEM ESP", 95, executeItemEsp)
createBtn("FPS BOOST", 140, executeFpsBoost)

MainFrame.Visible = true
