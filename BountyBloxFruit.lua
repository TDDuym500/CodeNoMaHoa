--// Dịch vụ cần thiết
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Hàm di chuyển UI
local function makeDraggable(guiElement)
   local dragToggle = nil
   local dragSpeed = 0.25
   local dragInput, mousePos, framePos

   guiElement.InputBegan:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 then
           dragToggle = true
           mousePos = input.Position
           framePos = guiElement.Position
       end
   end)

   guiElement.InputChanged:Connect(function(input)
       if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
           local delta = input.Position - mousePos
           guiElement.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
       end
   end)

   guiElement.InputEnded:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 then
           dragToggle = false
       end
   end)
end


--// Khung chọn người chơi
local Dropdown = Instance.new("Frame")
Dropdown.Parent = ScreenGui
Dropdown.Size = UDim2.new(0, 150, 0, 90)
Dropdown.Position = UDim2.new(0.05, 0, 0.1, 0)
Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local PlayerSelect = Instance.new("TextButton")
PlayerSelect.Parent = Dropdown
PlayerSelect.Size = UDim2.new(1, 0, 0, 40)
PlayerSelect.Text = "Chọn người chơi"
PlayerSelect.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
PlayerSelect.TextColor3 = Color3.fromRGB(255, 255, 255)

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = Dropdown
PlayerList.Size = UDim2.new(1, 0, 1, -40)
PlayerList.Position = UDim2.new(0, 0, 0, 40)
PlayerList.BackgroundTransparency = 1
PlayerList.Visible = false
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 200)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Nút Fly
local FlyButton = Instance.new("TextButton")
FlyButton.Parent = ScreenGui
FlyButton.Size = UDim2.new(0, 150, 0, 40)
FlyButton.Position = UDim2.new(0.05, 0, 0.35, 0)
FlyButton.Text = "Fly to Player"

--// Thanh chỉnh tốc độ
local SpeedSlider = Instance.new("TextBox")
SpeedSlider.Parent = ScreenGui
SpeedSlider.Size = UDim2.new(0, 150, 0, 40)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.45, 0)
SpeedSlider.Text = "Speed: 3"

--// Nút NoClip
local NoClipButton = Instance.new("TextButton")
NoClipButton.Parent = ScreenGui
NoClipButton.Size = UDim2.new(0, 150, 0, 40)
NoClipButton.Position = UDim2.new(0.05, 0, 0.55, 0)
NoClipButton.Text = "NoClip: OFF"

--// Nút Aimbot
local AimbotButton = Instance.new("TextButton")
AimbotButton.Parent = ScreenGui
AimbotButton.Size = UDim2.new(0, 150, 0, 40)
AimbotButton.Position = UDim2.new(0.05, 0, 0.65, 0)
AimbotButton.Text = "Aimbot: OFF"

--// Nút Hix Box
local HixBoxButton = Instance.new("TextButton")
HixBoxButton.Parent = ScreenGui
HixBoxButton.Size = UDim2.new(0, 150, 0, 40)
HixBoxButton.Position = UDim2.new(0.05, 0, 0.75, 0) -- Vị trí giữ nguyên
HixBoxButton.Text = "Hix Box: OFF"
HixBoxButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
HixBoxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HixBoxButton.Font = Enum.Font.Fantasy
HixBoxButton.TextScaled = true
HixBoxButton.TextSize = 20

--// Biến lưu trữ
local selectedPlayer = nil
local flySpeed = 3
local flying = false
local heightOffset = 10
local aimbotEnabled = false
local noClipEnabled = false
local flyConnection = nil
local aimbotConnection = nil
local noClipConnection = nil

--// Cập nhật danh sách người chơi
local function UpdatePlayerList()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Parent = PlayerList
            PlayerButton.Size = UDim2.new(1, 0, 0, 30)
            PlayerButton.Text = player.Name

            PlayerButton.MouseButton1Click:Connect(function()
                selectedPlayer = player
                PlayerSelect.Text = "▶ " .. player.Name
                PlayerList.Visible = false
            end)
        end
    end
end

PlayerSelect.MouseButton1Click:Connect(function()
    PlayerList.Visible = not PlayerList.Visible
    UpdatePlayerList()
end)

SpeedSlider.FocusLost:Connect(function()
    local newSpeed = tonumber(SpeedSlider.Text:match("%d+"))
    if newSpeed and newSpeed > 0 then
        flySpeed = newSpeed
        SpeedSlider.Text = "Speed: " .. flySpeed
    else
        SpeedSlider.Text = "Speed: " .. flySpeed
    end
end)

--// NoClip
local function EnableNoClip()
    noClipEnabled = true
    NoClipButton.Text = "NoClip: ON"
    noClipConnection = RunService.Stepped:Connect(function()
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

local function DisableNoClip()
    noClipEnabled = false
    NoClipButton.Text = "NoClip: OFF"
    if noClipConnection then
        noClipConnection:Disconnect()
        noClipConnection = nil
    end
end

--// Bay
local function FlyToPlayer()
    if flying then
        flying = false
        DisableNoClip()
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        return
    end

    if selectedPlayer and selectedPlayer.Character then
        local targetHRP = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            flying = true
            EnableNoClip()
            flyConnection = RunService.RenderStepped:Connect(function(deltaTime)
                local direction = (targetHRP.Position - HumanoidRootPart.Position).unit
                local moveDistance = flySpeed * deltaTime
                local newPosition = HumanoidRootPart.Position + direction * moveDistance
                newPosition = Vector3.new(newPosition.X, targetHRP.Position.Y + heightOffset, newPosition.Z)

                HumanoidRootPart.Velocity = Vector3.zero
                HumanoidRootPart.CFrame = CFrame.new(newPosition, targetHRP.Position)
            end)
        end
    end
end

FlyButton.MouseButton1Click:Connect(FlyToPlayer)

--// Aimbot
AimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotButton.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and selectedPlayer and selectedPlayer.Character then
        local targetHRP = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, targetHRP.Position)
        end
    end
end)

local module = {
    NextAttack = 0,
    AttackCooldown = 1, -- Thời gian chờ giữa các đòn đánh
    Distance = 55,
    attackMobs = true,
    attackPlayers = true
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

function module:GetBladeHits()
    local BladeHits = {}
    local LocalPlayer = Players.LocalPlayer
    local PlayerCharacter = LocalPlayer and LocalPlayer.Character

    if not PlayerCharacter or not PlayerCharacter:FindFirstChild("HumanoidRootPart") then
        return BladeHits
    end

    local PlayerRoot = PlayerCharacter.HumanoidRootPart

    -- 🟢 **Tấn công kẻ địch (Mobs)**
    if module.attackMobs then
        for _, Enemy in Workspace.Enemies:GetChildren() do
            if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") then
                local RootPart = Enemy.HumanoidRootPart
                local Humanoid = Enemy.Humanoid

                if (PlayerRoot.Position - RootPart.Position).Magnitude <= module.Distance and Humanoid.Health > 0 then
                    table.insert(BladeHits, RootPart)
                end
            end
        end
    end

    -- 🔴 **Tấn công người chơi khác**
    if module.attackPlayers then
        for _, Player in Players:GetPlayers() do
            if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local RootPart = Player.Character.HumanoidRootPart
                local Humanoid = Player.Character:FindFirstChild("Humanoid")

                if Humanoid and Humanoid.Health > 0 and (PlayerRoot.Position - RootPart.Position).Magnitude <= module.Distance then
                    table.insert(BladeHits, RootPart)
                end
            end
        end
    end

    return BladeHits
end

function module:attack()
    local CurrentTime = tick()
    if CurrentTime - module.NextAttack >= module.AttackCooldown then
        module.NextAttack = CurrentTime
        
        local BladeHits = self:GetBladeHits()

        -- Gửi lệnh tấn công
        ReplicatedStorage.Modules.Net:WaitForChild("RE/RegisterAttack"):FireServer(0)

        -- Gửi lệnh đánh từng mục tiêu hợp lệ
        for _, Hit in BladeHits do
            ReplicatedStorage.Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(Hit)
        end
    end
end

-- Sử dụng RunService để tối ưu thay vì spawn()
RunService.RenderStepped:Connect(function()
    module:attack()
end)




--// Khi nhân vật mới xuất hiện (tức là sau khi chết)
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    -- Nếu NoClip đã bật trước khi chết, tự động bật lại
    if noClipEnabled then
        EnableNoClip()
    end
end)

--// Hàm cập nhật nhân vật sau khi chết
local function UpdateCharacter()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

--// Hix Box
local function enableHixBox()
   isHixBoxEnabled = true
   HixBoxButton.Text = "Hix Box: ON"
   for _, v in next, Players:GetPlayers() do
       if v.Name ~= LocalPlayer.Name then
           local humanoidRootPart = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
           if humanoidRootPart then
               humanoidRootPart.Size = Vector3.new(30, 30, 30)
               humanoidRootPart.Transparency = 0.9
               humanoidRootPart.BrickColor = BrickColor.new("Really black")
               humanoidRootPart.Material = Enum.Material.Neon
               humanoidRootPart.CanCollide = false
           end
       end
   end
end

local function disableHixBox()
   isHixBoxEnabled = false
   HixBoxButton.Text = "Hix Box: OFF"
   for _, v in next, Players:GetPlayers() do
       if v.Name ~= LocalPlayer.Name then
           local humanoidRootPart = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
           if humanoidRootPart then
               humanoidRootPart.Size = Vector3.new(4, 4, 4)
               humanoidRootPart.Transparency = 1
               humanoidRootPart.BrickColor = BrickColor.new("Really black")
               humanoidRootPart.Material = Enum.Material.Neon
               humanoidRootPart.CanCollide = false
           end
       end
   end
end

local function toggleHixBox()
   if isHixBoxEnabled then
       disableHixBox()
   else
       enableHixBox()
   end
end

HixBoxButton.MouseButton1Click:Connect(toggleHixBox)

makeDraggable(FlyButton)
makeDraggable(NoClipButton)
makeDraggable(AimbotButton)
makeDraggable(HixBoxButton)


--// Kết nối sự kiện khi nhân vật respawn
LocalPlayer.CharacterAdded:Connect(UpdateCharacter)
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
UpdatePlayerList()

--// Cập nhật nhân vật lần đầu khi chạy code
UpdateCharacter()

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
UpdatePlayerList()
--// Cập nhật nhân vật lần đầu khi chạy code
UpdateCharacter()























