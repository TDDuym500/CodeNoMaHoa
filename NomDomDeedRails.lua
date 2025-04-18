-- 📦 Khởi tạo Services và biến toàn cục
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local speaker = LocalPlayer

-- 🖼️ Tạo UI Fluent
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/UiHack/refs/heads/main/Fluent"))()
local window = Fluent:CreateWindow({
    Title = "NomDom | Deed Rails",
    SubTitle = "by Duy",
    TabWidth = 230,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(700, 490),
    MinimizeKey = Enum.KeyCode.End
})

local tabs = {
    Infor = window:AddTab({ Title = "Infor" }),
    Main = window:AddTab({ Title = "Main" }),
    Fram = window:AddTab({ Title = "Fram" }),
    Localplayer = window:AddTab({ Title = "Local Player" }),
    Esp = window:AddTab({ Title = "Esp" }),
}

-- 📦 Section Aimbot
local Aimbot = tabs.Main:AddSection("Aimbot")

-- ⚙️ Dịch vụ & biến
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local Camera         = workspace.CurrentCamera
local LocalPlayer    = Players.LocalPlayer
local Mouse          = LocalPlayer:GetMouse()

local AimbotEnabled  = false
local FOVRadius      = 100
local AimFOVEnabled  = false  -- Biến kiểm tra AimFOV

-- 🎮 UI: Toggle & Input
Aimbot:AddToggle("AimbotNPC", {
    Title    = "Aimbot NPC",
    Default  = false,
    Callback = function(state)
        AimbotEnabled = state
    end
})

Aimbot:AddToggle("AimFOV", {
    Title    = "Aim FOV",
    Default  = false,
    Callback = function(state)
        AimFOVEnabled = state
    end
})

Aimbot:AddInput("FOVSizeInput", {
    Title       = "FOV Size",
    Placeholder = "100",
    Numeric     = true,
    Callback    = function(value)
        FOVRadius = tonumber(value) or 100
    end
})

-- 🔵 Vẽ vòng FOV
local fovCircle = Drawing.new("Circle")
fovCircle.Color        = Color3.fromRGB(255, 0, 0)
fovCircle.Thickness    = 1.5
fovCircle.Transparency = 0.6
fovCircle.Filled       = false
fovCircle.Visible      = false

-- 🔄 Cập nhật vòng FOV mỗi frame
RunService.RenderStepped:Connect(function()
    fovCircle.Radius   = FOVRadius
    fovCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
    fovCircle.Visible  = AimFOVEnabled and AimbotEnabled  -- Chỉ hiển thị nếu AimFOV được bật
end)

-- 📏 Tính khoảng cách 2D từ chuột
local function get2DDistance(worldPos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)
    if not onScreen then return math.huge end
    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
    return (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
end

-- 🔍 Tìm NPC gần nhất trong FOV (ưu tiên Head)
local function getClosestNPC()
    local closest, minDist = nil, FOVRadius
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model")
        and npc:FindFirstChild("Head")
        and npc:FindFirstChildOfClass("Humanoid")
        and not Players:GetPlayerFromCharacter(npc)
        and npc ~= LocalPlayer.Character
        and npc.Humanoid.Health > 0 then

            local dist = get2DDistance(npc.Head.Position)
            if dist < minDist then
                minDist = dist
                closest = npc
            end
        end
    end
    return closest
end

-- 🎯 Aimbot logic
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = getClosestNPC()
        if target and target:FindFirstChild("Head") then
            -- Nếu AimFOVEnabled bật thì chỉ aim vào NPC trong vòng FOV
            if AimFOVEnabled then
                if get2DDistance(target.Head.Position) <= FOVRadius then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Head.Position)
                end
            else
                -- Nếu AimFOVEnabled tắt, aim vào NPC bất kỳ
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Head.Position)
            end
        end
    end
end)



local Hitbox = tabs.Main:AddSection("Hitbox")

-- 📦 Hitbox mở rộng
local function applyHitbox()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(npc) then
            local root = npc:FindFirstChild("HumanoidRootPart")
            if root then
                if HitboxEnabled then
                    if not root:FindFirstChild("OriginalSize") then
                        local attr = Instance.new("NumberValue")
                        attr.Name = "OriginalSize"
                        attr.Value = root.Size.X
                        attr.Parent = root
                    end

                    root.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                    root.Transparency = 0.4
                    root.CanCollide = true
                    root.Massless = true
                    root.Color = Color3.fromRGB(180, 180, 180)

                    if not root:FindFirstChild("HitboxVisual") then
                        local adorn = Instance.new("BoxHandleAdornment")
                        adorn.Name = "HitboxVisual"
                        adorn.Adornee = root
                        adorn.AlwaysOnTop = true
                        adorn.ZIndex = 5
                        adorn.Size = root.Size
                        adorn.Transparency = 0.6
                        adorn.Color3 = Color3.fromRGB(180, 180, 180)
                        adorn.Parent = root
                    end
                else
                    local original = root:FindFirstChild("OriginalSize")
                    if original then
                        root.Size = Vector3.new(original.Value, original.Value, original.Value)
                        original:Destroy()
                    end
                    local vis = root:FindFirstChild("HitboxVisual")
                    if vis then vis:Destroy() end
                end
            end
        end
    end
end

Hitbox:AddToggle("HitboxToggle", {
    Title = "Increases NPC Hitbox",
    Default = false,
    Callback = function(state)
        HitboxEnabled = state
        applyHitbox()
    end
})

Hitbox:AddInput("HitboxSizeInput", {
    Title = "Hitbox size",
    Placeholder = "Enter Hitbox",
    Callback = function(text)
        local n = tonumber(text)
        if n then
            HitboxSize = n
            if HitboxEnabled then applyHitbox() end
        end
    end
})

-- 🚀 Auto TP
local targetCFrame = CFrame.new(-423.95, 27.39, -49039.65)
tabs.Fram:AddToggle("AutoTP", {
    Title = "Auto TP To Win",
    Default = false,
    Callback = function(state)
        teleporting = state
        if teleporting then
            task.spawn(function()
                while teleporting do
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = targetCFrame
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

tabs.Fram:AddButton({
    Title = "Show Time",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/CodeNoMaHoa/refs/heads/main/NomDomTime"))()
    end
    })



-- 🧍 WalkSpeed & Jump
local Walkspeed = tabs.Localplayer:AddSection("WalkSpeed")
local tpwalking = false
local currentSpeed = 90
local overrideSpeed = nil
local heartbeatConnection = nil
local originalWalkSpeed = 16

local function startTeleportWalk(character)
    if not character then return end
    local hum = character:WaitForChild("Humanoid", 5)
    if not hum then return end

    hum.HealthChanged:Connect(function()
        local hpPercent = (hum.Health / hum.MaxHealth) * 100
        if not overrideSpeed then
            currentSpeed = hpPercent <= 30 and 190 or 90
        end
    end)

    if heartbeatConnection then heartbeatConnection:Disconnect() end
    heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
        if tpwalking and hum and hum.Parent then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                character:TranslateBy(moveDir * currentSpeed * dt)
            end
        end
    end)
end

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    if tpwalking then
        task.wait(1)
        startTeleportWalk(char)
    end
end)

if speaker.Character then
    startTeleportWalk(speaker.Character)
end

Walkspeed:AddToggle("tpwalk_toggle", {
    Title = "Walk speed",
    Default = false,
    Callback = function(state)
        tpwalking = state
        local char = speaker.Character
        if char then
            if tpwalking then
                startTeleportWalk(char)
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.WalkSpeed = currentSpeed end
            else
                local hum = char:WaitForChild("Humanoid", 5)
                if hum then hum.WalkSpeed = originalWalkSpeed end
                if heartbeatConnection then heartbeatConnection:Disconnect() end
            end
        end
    end
})

Walkspeed:AddInput("speed_input", {
    Title = "Speed",
    Placeholder = "Enter speed",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        local speed = tonumber(value)
        if speed then
            overrideSpeed = speed
            currentSpeed = speed
        else
            overrideSpeed = nil
        end
    end
})

-- 🦘 Jump Settings
local Jump = tabs.Localplayer:AddSection("Jump")
local infiniteJumpEnabled = false
local customJumpPowerEnabled = false
local jumpPowerOverride = nil

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

Jump:AddToggle("infinite_jump", {
    Title = "Infiniti Jump",
    Default = false,
    Callback = function(state) infiniteJumpEnabled = state end
})

Jump:AddToggle("custom_jump_toggle", {
    Title = "High Jump",
    Default = false,
    Callback = function(state)
        customJumpPowerEnabled = state
        local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = state and (jumpPowerOverride or 50) or 50
        end
    end
})

Jump:AddInput("jump_power", {
    Title = "Jump Power",
    Placeholder = "Enter jump height",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        jumpPowerOverride = tonumber(value)
        local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and customJumpPowerEnabled then
            humanoid.JumpPower = jumpPowerOverride or 50
        end
    end
})

-- 🚷 NoClip
local Noclip = tabs.Localplayer:AddSection("No Clip")

Noclip:AddToggle("NoClip", {
    Title = "NoClip",
    Default = false,
    Callback = function(state)
        NoClip = state
        if NoClip then
            NoClipConnection = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- Section Full Bright
local FullbrightSection = tabs.Localplayer:AddSection("Full Bright")

-- Biến kiểm soát trạng thái bật tắt
local isFullBright = false

-- Toggle Full Bright
FullbrightSection:AddToggle("FullBrightToggle", {
    Title = "Full Bright",
    Default = false,
    Callback = function(state)
        isFullBright = state

        -- Nếu tắt thì khôi phục lại Lighting mặc định
        if not state then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 1000
            Lighting.GlobalShadows = true
        end
    end
})

-- Hàm chạy mỗi frame
RunService.RenderStepped:Connect(function()
    if isFullBright then
        Lighting.Brightness = 10
        Lighting.ClockTime = 12
        Lighting.FogEnd = 1e10
        Lighting.GlobalShadows = false
    end
end)


-- 👁️ ESP NPC
local espFolder = Instance.new("Folder", CoreGui)
espFolder.Name = "NPC_ESP_Folder"

local function createBillboard(name, distance, alive)
    local label = Instance.new("BillboardGui")
    label.Name = "NPC_ESP"
    label.Size = UDim2.new(0, 100, 0, 25)
    label.AlwaysOnTop = true
    label.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel", label)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = alive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Text = name
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold

    return label
end

local function createDistanceAndStatus(npc, dist, alive)
    local label = Instance.new("BillboardGui")
    label.Name = "NPC_ESP_Status"
    label.Size = UDim2.new(0, 100, 0, 25)
    label.AlwaysOnTop = true
    label.StudsOffset = Vector3.new(0, -3, 0)

    local textLabel = Instance.new("TextLabel", label)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = alive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.Text = "[" .. math.floor(dist) .. "m] " .. (alive and "🟢" or "🔴")
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold

    return label
end

local function updateNPCESP()
    espFolder:ClearAllChildren()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(npc) then
            local hrp = npc.HumanoidRootPart
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            local alive = npc.Humanoid.Health > 0

            local billboard = createBillboard(npc.Name, dist, alive)
            billboard.Adornee = hrp
            billboard.Parent = espFolder

            local distanceStatus = createDistanceAndStatus(npc, dist, alive)
            distanceStatus.Adornee = hrp
            distanceStatus.Parent = espFolder
        end
    end
end

tabs.Esp:AddToggle("ESP_NPC", {
    Title = "ESP NPC",
    Default = false,
    Callback = function(state)
        espEnabled = state
        if not state then espFolder:ClearAllChildren() end
    end
})

task.spawn(function()
    while true do
        if espEnabled then pcall(updateNPCESP) end
        task.wait(1.5)
    end
end)
