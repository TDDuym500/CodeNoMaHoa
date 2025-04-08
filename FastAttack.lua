local module = {
    NextAttack = 0,
    AttackCooldown = 0.01, -- Thời gian chờ giữa các đòn đánh
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

    -- 🟢 Tấn công kẻ địch (Mobs)
    if module.attackMobs then
        for _, Enemy in ipairs(Workspace.Enemies:GetChildren()) do
            if Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") then
                local RootPart = Enemy.HumanoidRootPart
                local Humanoid = Enemy.Humanoid

                if (PlayerRoot.Position - RootPart.Position).Magnitude <= module.Distance and Humanoid.Health > 0 then
                    table.insert(BladeHits, RootPart)
                end
            end
        end
    end

    -- 🔴 Tấn công người chơi khác
    if module.attackPlayers then
        for _, Player in ipairs(Players:GetPlayers()) do
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
        for _, Hit in ipairs(BladeHits) do
            ReplicatedStorage.Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(Hit)
        end
    end
end

-- Sử dụng RunService để tối ưu thay vì spawn()
RunService.RenderStepped:Connect(function()
    module:attack()
end)
