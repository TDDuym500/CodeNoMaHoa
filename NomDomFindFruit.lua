-- 📌 Tự động vào team Hải Quân
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
    local success, result = pcall(function()
        return ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end)
    if success then
        print("✅ Đã tự động vào team Marines!")
    else
        warn("❌ Lỗi khi vào team:", result)
    end
else
    warn("⚠ Không tìm thấy remote SetTeam!")
end

wait(1)

-- THÔNG BÁO UI (ĐÃ SỬA ĐỂ HIỂN THỊ ICON)
local function notify(title, text, duration, icon)
    pcall(function()
        local notificationData = {
            Title = title,
            Text = text,
            Duration = duration or 5
        }
        if icon then
            notificationData.Icon = icon
        end
        game.StarterGui:SetCore("SendNotification", notificationData)
    end)
end

-- 🍎 Danh sách trái cây cần lưu
local Fruits = {
    ["Kilo Fruit"] = "Kilo-Kilo", ["Spin Fruit"] = "Spin-Spin", ["Rocket Fruit"] = "Rocket-Rocket",
    ["Chop Fruit"] = "Chop-Chop", ["Spring Fruit"] = "Spring-Spring", ["Bomb Fruit"] = "Bomb-Bomb",
    ["Smoke Fruit"] = "Smoke-Smoke", ["Spike Fruit"] = "Spike-Spike", ["Flame Fruit"] = "Flame-Flame",
    ["Ice Fruit"] = "Ice-Ice", ["Sand Fruit"] = "Sand-Sand", ["Dark Fruit"] = "Dark-Dark",
    ["Revive Fruit"] = "Ghost-Ghost", ["Diamond Fruit"] = "Diamond-Diamond", ["Light Fruit"] = "Light-Light",
    ["Love Fruit"] = "Love-Love", ["Rubber Fruit"] = "Rubber-Rubber", ["Creation Fruit"] = "Barrier-Barrier",
    ["Eagle Fruit"] = "Bird-Bird: Falcon", ["Magma Fruit"] = "Magma-Magma", ["Portal Fruit"] = "Portal-Portal",
    ["Quake Fruit"] = "Quake-Quake", ["Human-Human: Buddha Fruit"] = "Human-Human: Buddha",
    ["Spider Fruit"] = "Spider-Spider", ["Bird: Phoenix Fruit"] = "Bird-Bird: Phoenix",
    ["Rumble Fruit"] = "Rumble-Rumble", ["Paw Fruit"] = "Pain-Pain", ["Gravity Fruit"] = "Gravity-Gravity",
    ["Dough Fruit"] = "Dough-Dough", ["Shadow Fruit"] = "Shadow-Shadow", ["Venom Fruit"] = "Venom-Venom",
    ["Control Fruit"] = "Control-Control", ["Spirit Fruit"] = "Spirit-Spirit", ["Dragon Fruit"] = "Dragon-Dragon",
    ["Leopard Fruit"] = "Leopard-Leopard", ["T-Rex Fruit"] = "T-Rex-T-Rex", ["Mammoth Fruit"] = "Mammoth-Mammoth",
    ["Blizzard Fruit"] = "Blizzard-Blizzard", ["Yeti Fruit"] = "Yeti-Yeti", ["Kitsune Fruit"] = "Kitsune-Kitsune",
    ["Blaze Fruit"] = "Blaze-Blaze"  -- Đảm bảo tên chính xác của Blaze
}

-- 🧠 Hàm lưu trái cây
local function storeFruits()
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")

    if not remote then return end

    local function tryStore(tool)
        local fruitID = Fruits[tool.Name]
        if fruitID then
            local success, result = pcall(function()
                return remote:InvokeServer("StoreFruit", fruitID, tool)
            end)
            if success and result == "Success" then
                print("✅ Lưu:", tool.Name)
            else
                print("❌ Không thể lưu:", tool.Name)
            end
        else
            print("🚨 Không tìm thấy trong từ điển:", tool.Name)  -- Debug khi không tìm thấy tên trong từ điển
        end
    end

    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tryStore(tool)
            end
        end
    end

    if character then
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                tryStore(tool)
            end
        end
    end
end

-- 🧲 Hàm nhặt trái cây trong Workspace
local function hopFruit()
    local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for _, fruit in pairs(workspace:GetChildren()) do
        if fruit:IsA("Tool") and Fruits[fruit.Name] and fruit:FindFirstChild("Handle") then
            root.CFrame = fruit.Handle.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.1)
        end
    end
end

-- 🌀 Tự động lưu trái + nhặt mỗi 0.1 giây
task.spawn(function()
    while task.wait(0.1) do
        pcall(storeFruits)
        pcall(hopFruit)
    end
end)

-- ✅ ESP trái cây
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local fruitsESP = {}
game:GetService("RunService").Heartbeat:Connect(function()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
            local handle = v:FindFirstChild("Handle")
            if handle and not v:FindFirstChild("ESPBox") then
                local box = Instance.new("BoxHandleAdornment", v)
                box.Name = "ESPBox"
                box.Adornee = handle
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Size = Vector3.new(2, 2, 2)
                box.Transparency = 0.5
                box.Color3 = Color3.fromRGB(0, 255, 0)

                local billboard = Instance.new("BillboardGui", handle)
                billboard.Name = "ESPInfo"
                billboard.Size = UDim2.new(0, 200, 0, 70)
                billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                billboard.AlwaysOnTop = true

                local nameLabel = Instance.new("TextLabel", billboard)
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = v.Name
                nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                nameLabel.TextScaled = true
                nameLabel.Font = Enum.Font.SourceSansBold

                local timeLabel = Instance.new("TextLabel", billboard)
                timeLabel.Size = UDim2.new(1, 0, 0.5, 0)
                timeLabel.Position = UDim2.new(0, 0, 0.5, 0)
                timeLabel.BackgroundTransparency = 1
                timeLabel.TextColor3 = Color3.Yellow
                timeLabel.TextScaled = true
                timeLabel.Font = Enum.Font.SourceSansBold
                timeLabel.Text = os.date("%H:%M:%S")

                fruitsESP[v] = {Box = box, Billboard = billboard, TimeLabel = timeLabel}
            elseif fruitsESP[v] and handle then
                fruitsESP[v].TimeLabel.Text = os.date("%H:%M:%S")
            elseif fruitsESP[v] and not handle then
                fruitsESP[v].Box:Destroy()
                fruitsESP[v].Billboard:Destroy()
                fruitsESP[v] = nil
            end
        end
    end
end)

-- ✅ Teleport trực tiếp đến vị trí trái cây (ĐÃ SỬA ĐỂ HIỂN THỊ THÔNG BÁO)
local function teleportTo(pos, fruitName)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(pos)
        notify("NomDom Hub", "Tp " .. fruitName, 3, "rbxassetid://138569547227924")
    end
end

-- ✅ Server hop
local isHopping = false
local function hopServer()
    if isHopping then return end
    isHopping = true
    notify("NomDom Hub", "Hopping Server...", 5, "rbxassetid://138569547227924")
    local servers = {}
    local gamelink = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"

    local function serversearch(link)
        local res = HttpService:JSONDecode(game:HttpGet(link))
        for _, v in pairs(res.data) do
            if v.playing and v.id ~= game.JobId then
                table.insert(servers, v.id)
            end
        end
        if res.nextPageCursor then
            serversearch(gamelink.."&cursor="..res.nextPageCursor)
        end
    end

    pcall(serversearch, gamelink)

    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
        isHopping = false -- Đặt lại trạng thái sau khi hop thành công
    else
        task.wait(2)
        hopServer() -- Tiếp tục thử hop nếu không tìm thấy server phù hợp
    end
end

-- ✅ Tìm trái cây trong map
local function getFruits()
    local list = {}
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") and v:FindFirstChild("Handle") then
            table.insert(list, v)
        end
    end
    return list
end

-- ✅ Tự động nhặt trái rồi server hop nếu không có
task.spawn(function()
    while true do
        task.wait(1)
        local fruits = getFruits()
        if #fruits > 0 then
            for _, fruit in ipairs(fruits) do
                local handle = fruit:FindFirstChild("Handle")
                if handle then
                    -- Teleport trực tiếp đến trái cây và hiển thị thông báo
                    teleportTo(handle.Position, fruit.Name)
                    -- Tương tác với trái cây
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, handle, 0)
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, handle, 1)
                    task.wait(0.5)
                end
            end
            -- Đợi 0.1 giây sau khi nhặt xong một trái trước khi kiểm tra lại
            task.wait(0.3)
        else
            hopServer()
            break -- Thoát khỏi vòng lặp nhặt để thực hiện hop server liên tục
        end
    end
end)

-- KIỂM TRA TRÁI CÂY TRONG BALO
local function hasFruitInBackpack()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and string.find(tool.Name:lower(), "fruit") then
            return true
        end
    end
    return false
end

-- KIỂM TRA TRÁI CÂY TRONG MAP
local function hasFruitInMap()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") and v:FindFirstChild("Handle") then
            return true
        end
    end
    return false
end

-- KIỂM TRA & XỬ LÝ HOP
local lastHop = 0
local hopCooldown = 5 -- Thời gian chờ giữa các lần hop (giây)

local function checkHop()
    if tick() - lastHop < hopCooldown then return end
    lastHop = tick()

    if hasFruitInMap() then return end

    if not hasFruitInBackpack() then
        hopServer()
    end
end

-- VÒNG LẶP TỰ ĐỘNG KIỂM TRA HOP
task.spawn(function()
    while true do -- Chạy liên tục để đảm bảo hop khi cần
        task.wait(5) -- Kiểm tra mỗi 5 giây
        pcall(checkHop)
    end
end)

-- THÔNG BÁO HIỆN THÊM ẢNH KHI BẮT ĐẦU
notify("NomDom Hub", "Welcome " .. LocalPlayer.Name, 5, "rbxassetid://138569547227924")
wait(0.2)
notify("NomDom Hub", "Loading....", 5, "rbxassetid://138569547227924")
wait(0.2)
notify("NomDom Hub", "Done", 5, "rbxassetid://138569547227924")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DiscordLinkUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nút chính (gọn hơn)
local button = Instance.new("TextButton")
button.Name = "DiscordLinkButton"
button.Parent = gui
button.Text = "Copy Discord Link"
button.TextColor3 = Color3.new(1, 1, 1)
button.BackgroundTransparency = 0
button.BorderSizePixel = 0
button.Font = Enum.Font.GothamSemibold
button.TextSize = 20
button.AnchorPoint = Vector2.new(0.5, 1)
button.Position = UDim2.new(0.5, 0, 0.5, 0)
button.Size = UDim2.new(0, 250, 0, 40)
button.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
button.TextStrokeTransparency = 0.4
button.TextStrokeColor3 = Color3.new(0, 0, 0)
button.ClipsDescendants = true
button.ZIndex = 10
button.AutoButtonColor = false

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = button

-- Tween bay lên vị trí gọn hơn
local tweenUp = TweenService:Create(button, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, 0.22, 0)
})
tweenUp:Play()

-- Khi bấm
local clicked = false
button.MouseButton1Click:Connect(function()
	if not clicked then
		clicked = true
		setclipboard("https://discord.gg/3PpjA9Ts")
		button.Text = "Copied"
	end
end)
