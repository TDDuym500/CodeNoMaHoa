-- Hiệu ứng mờ + Script By Duy + Loading + Done cùng màu, cùng font

-- Tạo hiệu ứng mờ
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 30
blurEffect.Enabled = false
blurEffect.Parent = game.Lighting

-- Tạo GUI
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptByDuyGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- "Script By Duy"
local mainText = Instance.new("TextLabel")
mainText.Parent = gui
mainText.Size = UDim2.new(1, 0, 1, 0)
mainText.Position = UDim2.new(0, 0, 0, 0)
mainText.BackgroundTransparency = 1
mainText.Text = "NomDom Hub Loader"
mainText.TextColor3 = Color3.fromRGB(255, 255, 255)
mainText.TextStrokeTransparency = 0.5
mainText.Font = Enum.Font.GothamBlack
mainText.TextScaled = true
mainText.TextTransparency = 1

-- "Loading Script..."
local loadingText = Instance.new("TextLabel")
loadingText.Parent = gui
loadingText.Size = UDim2.new(1, 0, 0.1, 0)
loadingText.Position = UDim2.new(0, 0, 0.65, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading Script... 0%"
loadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingText.TextStrokeTransparency = 0.7
loadingText.Font = Enum.Font.Gotham
loadingText.TextScaled = true
loadingText.TextTransparency = 1

-- "Done!" (cùng màu & font với loading)
local doneText = Instance.new("TextLabel")
doneText.Parent = gui
doneText.Size = loadingText.Size
doneText.Position = loadingText.Position
doneText.BackgroundTransparency = 1
doneText.Text = "Done!"
doneText.TextColor3 = Color3.fromRGB(200, 200, 200)
doneText.TextStrokeTransparency = 0.7
doneText.Font = Enum.Font.Gotham
doneText.TextScaled = true
doneText.TextTransparency = 1

-- Bật blur
blurEffect.Enabled = true

-- Fade in "Script By Duy" và "Loading Script..."
for i = 1, 0, -0.02 do
	mainText.TextTransparency = i
	loadingText.TextTransparency = i
	task.wait(0.03)
end

-- Loading từ 0% → 100%
for i = 0, 100 do
	loadingText.Text = "Loading Script... " .. i .. "%"
	task.wait(0.02)
end

-- Ẩn Loading
for i = 0, 1, 0.05 do
	loadingText.TextTransparency = i
	task.wait(0.03)
end

-- Hiện Done!
for i = 1, 0, -0.05 do
	doneText.TextTransparency = i
	task.wait(0.03)
end

-- Giữ lại chút cho ngầu
task.wait(1.5)

-- Fade out tất cả
for i = 0, 1, 0.05 do
	mainText.TextTransparency = i
	doneText.TextTransparency = i
	task.wait(0.03)
end

-- Tắt blur
for blur = 30, 0, -1 do
	blurEffect.Size = blur
	task.wait(0.01)
end

-- Xoá GUI
task.wait(0.5)
gui:Destroy()
blurEffect:Destroy()

-- Load thư viện Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local window = Fluent:CreateWindow({
    Title = "NomDom Hub | Loader",
    SubTitle = "by Duy",
    TabWidth = 160,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.End
})

-- Tạo các Tab
local tabs = {
    Infor = window:AddTab({ Title = "Infor" }),
    General = window:AddTab({ Title = "Script General" }),
    Bf = window:AddTab({ Title = "BLox Fruit" }),
    Other = window:AddTab({ Title = "Other scripts" }),
}

-- Nút Discord
tabs.Infor:AddButton({
    Title = "Discord",
    Description = "Giao Lưu",
    Callback = function()
        setclipboard("https://discord.gg/")
    end
})tabs.General:AddButton({
    Title = "Script General",
    Description = "Lots of scripts here",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/CodeNoMaHoa/refs/heads/main/NomDomHubFluent.lua"))()
    end
})tabs.Other:AddButton({
    Title = "Script Fly",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/NomDomFly"))()
    end
})tabs.Other:AddButton({
    Title = "Test Unc",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/UncTest"))()
    end
})

-- Nút Bounty
tabs.Bf:AddButton({
    Title = "Main Blox Fruit",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/CodeNoMaHoa/refs/heads/main/MainBloxFruit"))()
    end
})
tabs.Bf:AddButton({
    Title = "Fast Attack Blox Fruit",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/FastAttack.lua"))()
    end
})tabs.Bf:AddButton({
    Title = "Kaitun Blox Fruit",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/KaiTunNomDom"))()
    end
})
-- Nút Bounty
tabs.Bf:AddButton({
    Title = "Suport Bounty HunterBounty",
    Description = "",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer  
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDom/refs/heads/main/BountyBloxFruit"))()
    end
})

-- Giao diện Nút Mở UI (đẹp hơn, có particle, xoay, animation)
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "ToggleUIFluent"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game:GetService("CoreGui")

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 50, 0, 50)
button.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Image = "http://www.roblox.com/asset/?id=138569547227924"
button.Draggable = true
button.Parent = gui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- Particle hiệu ứng
local particle = Instance.new("ParticleEmitter")
particle.Parent = button
particle.LightEmission = 1
particle.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0) })
particle.Lifetime = NumberRange.new(0.5, 1)
particle.Rate = 0
particle.Speed = NumberRange.new(5, 10)
particle.SpreadAngle = Vector2.new(360, 360)
particle.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255))

-- Khi bấm nút
button.MouseButton1Down:Connect(function()
    particle.Rate = 100

    -- Reset sau 1s
    task.delay(1, function()
        particle.Rate = 0
    end)


    -- Gửi phím End để bật/tắt UI
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
end)

-- Xoá hiệu ứng chết/respawn nếu có
local effectContainer = game:GetService("ReplicatedStorage"):FindFirstChild("Effect") and game:GetService("ReplicatedStorage").Effect:FindFirstChild("Container")
if effectContainer then
    if effectContainer:FindFirstChild("Death") then
        effectContainer.Death:Destroy()
    end
    if effectContainer:FindFirstChild("Respawn") then
        effectContainer.Respawn:Destroy()
    end
end

-- Thông báo khi tải xong
Fluent:Notify({
    Title = "Script : ",
    Content = "Done",
    Duration = 10
})
