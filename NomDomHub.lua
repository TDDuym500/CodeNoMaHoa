-----------------Version 8.0.0-----------------


-- Hiệu ứng load 
loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/CodeNoMaHoa/refs/heads/main/LoadingScript"))()

-- Kiểm tra tên người chơi
local playerName = game.Players.LocalPlayer.Name

-- Danh sách các tên đặc biệt
local specialNames = {
    "noxeldp",
    "boptrithuc",
    "acctesthacktuviet",
    -- Bạn có thể thêm các tên khác vào danh sách này
}

-- Hàm kiểm tra nếu tên có trong danh sách
local function isSpecialName(name)
    for _, specialName in ipairs(specialNames) do
        if name:lower() == specialName:lower() then
            return true
        end
    end
    return false
end

-- Kiểm tra và tải script tương ứng
if isSpecialName(playerName) then
    -- Nếu là tên đặc biệt thì tải NomDomHubPremium
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Sources/refs/heads/main/NomDomHubPremium.lua"))()
else
    -- Nếu không phải tên đặc biệt thì tải NomDomHubFreemium
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Sources/refs/heads/main/NomDomHubFreemium.lua"))()
end

---Wedbook
loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/CodeNoMaHoa/refs/heads/main/WedBookDonGian"))()




