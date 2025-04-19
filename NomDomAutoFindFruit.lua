-- ✅ Tự gia nhập phe từ cấu hình
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--Auto Gia Nhập Phe
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ✅ Cấu hình
local Config = {
    SpeedTween = 325,
    Fixlag = true,
    Screen = true,
    EspFruit = true,
    RandomFruit = true,
    AutoStoreFruit = true,
    CheckFruitInterval = 0.2,
    MaxStoreErrorsBeforeHop = 1,
    AutoTeleport = true,
    NoClip = true,
}

--Auto Gia Nhập Phe
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🔹 Kiểm tra nếu có chức năng chuyển team trong game
if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
    -- 🔹 Gửi yêu cầu chuyển sang Hải Quân (Marines)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")

    -- 🔹 Thông báo đã chuyển team
    print("✅ Đã tự động gia nhập Hải Quân!")
else
    print("⚠ Không tìm thấy Remote chuyển team, thử lại sau!")
end

wait(1)

-- ✅ Fix Lag
if Config.FixLag then
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/SuperFixLag"))()
        end)
    end)
end

-- ✅ NoClip
local RunService = game:GetService("RunService")
local NoClipConnection
if Config.NoClip then
    NoClipConnection = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- ✅ Hiệu ứng làm mờ
local blurEffect = Instance.new("BlurEffect")
blurEffect.Parent = game.Lighting
blurEffect.Size = 30
blurEffect.Enabled = false

-- ✅ UI NomDom Hub
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NomDomHubUI"

local NomDomLabel = Instance.new("TextLabel")
NomDomLabel.Name = "NomDomLabel"
NomDomLabel.Parent = ScreenGui
NomDomLabel.AnchorPoint = Vector2.new(0.5, 0)
NomDomLabel.Position = UDim2.new(0.5, 0, 0.22, 0)
NomDomLabel.Size = UDim2.new(0, 300, 0, 40)
NomDomLabel.BackgroundTransparency = 1
NomDomLabel.Text = "NomDom Hub"
NomDomLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NomDomLabel.TextSize = 24
NomDomLabel.Font = Enum.Font.GothamBold

-- ✅ UI trạng thái
local statusGui = Instance.new("ScreenGui", game.CoreGui)
statusGui.Name = "FruitStatus"
local status = Instance.new("TextLabel", statusGui)
status.Size = UDim2.new(0, 400, 0, 80)
status.Position = UDim2.new(0.5, -200, 0.1, 0)
status.BackgroundTransparency = 1
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = "Status : Checking fruit"

-- ✅ ESP trái cây
local fruitsESP = {}
if Config.EspFruit then
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
end

-- ✅ Tween đến trái cây
local TweenService = game:GetService("TweenService")
local function tweenTo(pos)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - pos).Magnitude
        local tweenTime = dist / Config.SpeedTween
        local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        return tween
    end
end

-- ✅ Tìm trái cây
local function findFruit()
    local fruits = {}
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") and v:FindFirstChild("Handle") then
            table.insert(fruits, v)
        end
    end
    return #fruits > 0 and (Config.RandomFruit and fruits[math.random(1, #fruits)] or fruits[1])
end

-- ✅ Server hop
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local isHopping = false

local function hopServer()
    if isHopping then return end
    isHopping = true
    


    -- Show "No Fruit Spawn" first
    status.Text = "Status : No Fruit Spawn"
    wait(1) -- Wait 1 second to show the message
    
    status.Text = "Status : Hopping Server..."

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
    else
        task.delay(1, hopServer)
    end
end

-- Chức năng Random Fruit (Mua ngẫu nhiên trái cây)
spawn(function()
    pcall(function()
        while task.wait() do
            if _G.Random_Auto then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
            end 
        end
    end)
end)


-- Chức năng Auto Store Fruit
spawn(function()
    while task.wait(0.1) do
        if _G.AutoStoreFruit then
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local character = player.Character
                local backpack = player.Backpack
                local remote = game:GetService("ReplicatedStorage").Remotes.CommF_
                
                for fruitName, fruitID in pairs(Fruits) do
                    local fruit = character:FindFirstChild(fruitName) or backpack:FindFirstChild(fruitName)
                    if fruit then
                        remote:InvokeServer("StoreFruit", fruitID, fruit)
                    end
                end
            end)
        end
    end
end)

-- Cấu hình mặc định cho các tính năng (true = bật, false = tắt)
_G.Config = {
    AutoStoreFruit = true,  -- Mặc định bật chức năng Auto Store Fruit
    Random_Auto = true,     -- Mặc định bật chức năng Random Auto Fruit
}

-- ✅ Lưu trái cây
local Fruits = {
    ["Kilo Fruit"] = "Kilo-Kilo",
    ["Spin Fruit"] = "Spin-Spin",
    ["Rocket Fruit"] = "Rocket-Rocket",
    ["Chop Fruit"] = "Chop-Chop",
    ["Spring Fruit"] = "Spring-Spring",
    ["Bomb Fruit"] = "Bomb-Bomb",
    ["Smoke Fruit"] = "Smoke-Smoke",
    ["Spike Fruit"] = "Spike-Spike",
    ["Flame Fruit"] = "Flame-Flame",
    ["Ice Fruit"] = "Ice-Ice",
    ["Sand Fruit"] = "Sand-Sand",
    ["Dark Fruit"] = "Dark-Dark",
    ["Revive Fruit"] = "Ghost-Ghost",
    ["Diamond Fruit"] = "Diamond-Diamond",
    ["Light Fruit"] = "Light-Light",
    ["Love Fruit"] = "Love-Love",
    ["Rubber Fruit"] = "Rubber-Rubber",
    ["Creation Fruit"] = "Barrier-Barrier",
    ["Eagle Fruit"] = "Bird-Bird: Falcon",
    ["Magma Fruit"] = "Magma-Magma",
    ["Portal Fruit"] = "Portal-Portal",
    ["Quake Fruit"] = "Quake-Quake",
    ["Human-Human: Buddha Fruit"] = "Human-Human: Buddha",
    ["Spider Fruit"] = "Spider-Spider",
    ["Bird: Phoenix Fruit"] = "Bird-Bird: Phoenix",
    ["Rumble Fruit"] = "Rumble-Rumble",
    ["Paw Fruit"] = "Pain-Pain",
    ["Gravity Fruit"] = "Gravity-Gravity",
    ["Dough Fruit"] = "Dough-Dough",
    ["Shadow Fruit"] = "Shadow-Shadow",
    ["Venom Fruit"] = "Venom-Venom",
    ["Control Fruit"] = "Control-Control",
    ["Spirit Fruit"] = "Spirit-Spirit",
    ["Dragon Fruit"] = "Dragon-Dragon",
    ["Leopard Fruit"] = "Leopard-Leopard",
}


-- Cập nhật giá trị từ cấu hình vào các chức năng
_G.AutoStoreFruit = _G.Config.AutoStoreFruit
_G.Random_Auto = _G.Config.Random_Auto

local function storeFruit()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return false end
    
    for _, tool in pairs(backpack:GetChildren()) do
        if Fruits[tool.Name] then
            local result = ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", Fruits[tool.Name])
            if result == "Success" then
                return true
            end
        end
    end
    return false
end

-- ✅ Quản lý hiệu ứng mờ
local function manageBlur()
    while true do
        blurEffect.Enabled = Config.Screen and not findFruit()
        task.wait(0.5)
    end
end
task.spawn(manageBlur)

-- ✅ Luồng chính
task.spawn(function()
    while true do
        local fruit = findFruit()
        if fruit then
            status.Text = "Status : Fruit "..fruit.Name
            
            local tween = tweenTo(fruit.Handle.Position)
            local distanceConnection
            distanceConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if fruit and fruit:FindFirstChild("Handle") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - fruit.Handle.Position).Magnitude
                    status.Text = string.format("Status: %s | Distance: %d", fruit.Name, math.floor(distance))
                else
                    distanceConnection:Disconnect()
                end
            end)
            
            repeat task.wait() until not fruit or not fruit:IsDescendantOf(workspace)
            
            if distanceConnection then
                distanceConnection:Disconnect()
            end
        else
            if Config.AutoTeleport then
                hopServer()
            else
                status.Text = "Status : No Fruits Spawn"
                task.wait(5)
            end
        end
        task.wait(Config.CheckFruitInterval)
    end
end)

-- UI đếm thời gian chơi
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TimeCounter"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- TextLabel
local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(0, 350, 0, 40)
label.Position = UDim2.new(0.5, -175, 1, -60) -- Dưới giữa màn hình một chút
label.BackgroundTransparency = 1
label.TextScaled = true
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.SourceSansBold
label.Text = "Time : 00 Hour | 00 Minute | 00 Second"

-- Timer logic
local seconds = 0

task.spawn(function()
    while true do
        wait(1)
        seconds += 1
        local minutes = math.floor(seconds / 60)
        local hours = math.floor(minutes / 60)
        local displaySeconds = seconds % 60
        local display = string.format("Time : %02d Hour | %02d Minute | %02d Second", hours, minutes % 60, displaySeconds)
        label.Text = display
    end
end)
