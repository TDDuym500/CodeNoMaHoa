local ScreenGui = Instance.new("ScreenGui")
local DiscordButton = Instance.new("TextButton")
local InfoLabel = Instance.new("TextLabel")

-- Thiết lập ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

-- Thiết lập DiscordButton
DiscordButton.Parent = ScreenGui
DiscordButton.Position = UDim2.new(0.5, -100, 0.1, 0)
DiscordButton.Size = UDim2.new(0, 200, 0, 30)
DiscordButton.BackgroundColor3 = Color3.new(1, 1, 0) -- Màu vàng
DiscordButton.Text = "Copy Discord Link"
DiscordButton.TextColor3 = Color3.new(0, 0, 0)
DiscordButton.Font = Enum.Font.SourceSansBold
DiscordButton.TextSize = 14

-- Thiết lập InfoLabel (văn bản thông báo)
InfoLabel.Parent = ScreenGui
InfoLabel.Position = UDim2.new(0.5, -250, 0.8, 0)
InfoLabel.Size = UDim2.new(0, 500, 0, 50)
InfoLabel.BackgroundTransparency = 1 -- Làm trong suốt
InfoLabel.Text = "English: Script Down Join Discord To Get New Scripts\nViệt: Script Đã Lỗi Thời Vui Lòng Vào Discord Để Nhận Script Mới"
InfoLabel.TextColor3 = Color3.new(1, 1, 1)
InfoLabel.Font = Enum.Font.SourceSansBold
InfoLabel.TextSize = 14
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center
InfoLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Chức năng sao chép liên kết Discord
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/Ehst9eee") -- Thay "YOUR_DISCORD_LINK" bằng liên kết Discord của bạn
end)

-- Biến kiểm soát hiệu ứng mờ
local Buoi = true

-- Tạo hiệu ứng mờ
local blurEffect = Instance.new("BlurEffect")
blurEffect.Parent = game.Lighting
blurEffect.Size = 30  -- Điều chỉnh độ mờ (giá trị càng lớn thì mờ càng mạnh)

-- Vòng lặp kiểm tra trạng thái của Buoi để bật/tắt hiệu ứng mờ
spawn(function()
    while task.wait() do
        if Buoi then
            blurEffect.Enabled = true  -- Bật hiệu ứng mờ khi Buoi = true
        else
            blurEffect.Enabled = false  -- Tắt hiệu ứng mờ khi Buoi = false
        end
    end
end)
