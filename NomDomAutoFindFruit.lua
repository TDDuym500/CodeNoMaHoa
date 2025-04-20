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
    CheckFruitInterval = 0.2,
    AutoTeleport = true,
    NoClip = true,
    AutoStoreFruit = true,  -- Mặc định bật chức năng Auto Store Fruit
    AutoRandomFruit = true,
    StoreFruitSpeed = 0,1,
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
blurEffect.Size = 15
blurEffect.Enabled = false

-- ✅ Quản lý hiệu ứng mờ
local function manageBlur()
    while true do
        blurEffect.Enabled = Config.Screen
        task.wait(0.5)
    end
end
task.spawn(manageBlur)


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
    status.Text = "Status : No Fruit"
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

-- ✅ Chức năng Random Fruit (Mua ngẫu nhiên trái cây)
spawn(function()
    pcall(function()
        while task.wait() do
            if Config.AutoRandomFruit then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
            end 
        end
    end)
end)


-- ✅ Tự động lưu trái cây
local function storeFruits()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local backpack = player.Backpack
    local remote = game:GetService("ReplicatedStorage").Remotes.CommF_

    for fruitName, fruitID in pairs(Fruits) do
        local fruit = character:FindFirstChild(fruitName) or backpack:FindFirstChild(fruitName)
        if fruit then
            remote:InvokeServer("StoreFruit", fruitID, fruit)
            print("Stored:", fruitName)
        end
    end
end

-- Tạo một hàm chính cho việc lưu trái cây liên tục
spawn(function()
    pcall(function()
        while task.wait(Config.StoreFruitSpeed) do  -- Sử dụng tốc độ lưu trái cây từ cấu hình
            if Config.AutoStoreFruit then
                storeFruits()
            end
        end
    end)
end)

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
    ["T-Rex Fruit"] = "T-Rex-T-Rex",
    ["Mammoth Fruit"] = "Mammoth-Mammoth",
    ["Blizzard Fruit"] = "Blizzard-Blizzard",
    ["Yeti Fruit"] = "Yeti-Yeti",
    ["Kitsune Fruit"] = "Kitsune-Kitsune",
}

-- ✅ Lưu trái cây với thông báo lỗi và chuyển server nếu quá nhiều lỗi
local function storeFruitsWithErrors()
    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            local fruitID = Fruits[tool.Name]
            if fruitID then
                local result = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", fruitID)
                if result == "Success" then
                    print("Stored:", tool.Name)
                else
                    storeErrorCount = (storeErrorCount or 0) + 1
                    print("Store failed:", tool.Name, "-", result)
                    if storeErrorCount >= Config.MaxStoreErrorsBeforeHop then
                        hopServer()  -- Chuyển server nếu gặp lỗi quá nhiều lần
                    end
                end
            end
        end
    end
end

-- Kiểm tra và lưu trái cây với điều kiện AutoStoreFruit
if Config.AutoStoreFruit then
    task.spawn(function()
        while task.wait(Config.StoreFruitSpeed) do  -- Sử dụng tốc độ lưu trái cây từ cấu hình
            storeFruitsWithErrors()  -- Gọi hàm lưu trái cây với lỗi
        end
    end)
end




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
                task.wait(2)
            end
        end
        task.wait(Config.CheckFruitInterval)
    end
end)


-- ✅ UI NomDom Hub
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "NomDomHubUI"

local NomDomLabel = Instance.new("TextLabel")
NomDomLabel.Name = "NomDomLabel"
NomDomLabel.Parent = ScreenGui
NomDomLabel.AnchorPoint = Vector2.new(0.5, 1)
NomDomLabel.Position = UDim2.new(0.5, 0, 1, -15)
NomDomLabel.Size = UDim2.new(0, 350, 0, 50) -- To hơn
NomDomLabel.BackgroundTransparency = 1
NomDomLabel.Text = "NomDom Hub"
NomDomLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NomDomLabel.TextSize = 30 -- Chữ to hơn
NomDomLabel.Font = Enum.Font.GothamBold

-- Cầu vồng màu
local colors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(238, 130, 238)
}

-- Tạo hiệu ứng tween màu chuyển mượt
local function smoothRainbow()
    local i = 1
    while true do
        local color = colors[i]
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local tween = TweenService:Create(NomDomLabel, tweenInfo, {TextColor3 = color})
        tween:Play()
        tween.Completed:Wait()
        i = i % #colors + 1
    end
end

spawn(smoothRainbow)





-- ✅ FPS Display UI
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPSDisplay"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Tạo TextLabel để hiện FPS
local FpsLabel = Instance.new("TextLabel")
FpsLabel.Name = "FpsLabel"
FpsLabel.Parent = ScreenGui
FpsLabel.AnchorPoint = Vector2.new(0, 0)
FpsLabel.Position = UDim2.new(0, 10, 0, 10) -- Góc trái trên, cách 10px
FpsLabel.Size = UDim2.new(0, 120, 0, 30)
FpsLabel.BackgroundTransparency = 1
FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsLabel.TextSize = 20
FpsLabel.Font = Enum.Font.GothamSemibold
FpsLabel.Text = "FPS: 0"

-- Cập nhật FPS mỗi giây
spawn(function()
	local frameCount = 0
	local lastTime = tick()
	while true do
		RunService.RenderStepped:Wait()
		frameCount = frameCount + 1
		local now = tick()
		if now - lastTime >= 1 then
			FpsLabel.Text = "FPS: " .. tostring(frameCount)
			frameCount = 0
			lastTime = now
		end
	end
end)

-- Hiệu ứng cầu vồng mềm mại cho FPS label
local colors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 165, 0),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(75, 0, 130),
	Color3.fromRGB(238, 130, 238)
}

spawn(function()
	local i = 1
	while true do
		local color = colors[i]
		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(FpsLabel, tweenInfo, {TextColor3 = color})
		tween:Play()
		tween.Completed:Wait()
		i = i + 1
		if i > #colors then
			i = 1
		end
	end
end)





-- UI đếm thời gian chơi (chỉ phần đồng hồ)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TimeCounter"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Text hiển thị
local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(0, 500, 0, 60)
label.Position = UDim2.new(0.5, -250, 1, -100) -- Giữa dưới, cao hơn một chút
label.BackgroundTransparency = 1 -- Không có nền
label.TextScaled = true
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.SourceSansBold
label.TextStrokeTransparency = 0.6
label.TextStrokeColor3 = Color3.new(0, 0, 0) -- Viền đen
label.Text = "Time : 00 Hour | 00 Minute | 00 Second"
label.BorderSizePixel = 0
label.ZIndex = 10

-- Đếm thời gian chính xác từng giây
local startTime = os.time()

task.spawn(function()
    while true do
        task.wait(1)
        local elapsed = os.time() - startTime
        local minutes = math.floor(elapsed / 60)
        local hours = math.floor(minutes / 60)
        local seconds = elapsed % 60
        local display = string.format("Time : %02d Hour | %02d Minute | %02d Second", hours, minutes % 60, seconds)
        label.Text = display
    end
end)
