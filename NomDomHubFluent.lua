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
mainText.Text = "Script By Duy"
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

-- Load thư viện Fluent
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local window = Fluent:CreateWindow({
    Title = "NomDom General",
    SubTitle = "by Duy",
    TabWidth = 160,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.End
})

-- Tạo các Tab
local tabs = {
    Infor = window:AddTab({ Title = "Infor" }),
    Main = window:AddTab({ Title = "Main" }),
    Localplayer = window:AddTab({ Title = "Local Player" }),
    Joinid = window:AddTab({ Title = "Join server, game" }),
    Bloxfruit = window:AddTab({ Title = "Blox Fruit" }),
    Kaitunbf = window:AddTab({ Title = "Kaitun Blox Fruit" }),
    Bluelock = window:AddTab({ Title = "Blue Lock" }),
    Fisch = window:AddTab({ Title = "Fisching" }),
    Petgo = window:AddTab({ Title = "Pet Go" }),
    Deedrails = window:AddTab({ Title = "Deed Rails" }),
}

-- Nút Discord
    tabs.Infor:AddButton({
    Title = "Discord",
    Description = "Giao Lưu",
    Callback = function()
        setclipboard("https://discord.gg/AdvrEXqB")
    end
})    tabs.Main:AddButton({
    Title = "Wait Update",
    Description = "Wait",
    Callback = function()
        
    end
})    tabs.Localplayer:AddButton({
    Title = "Wait Update",
    Description = "Wait",
    Callback = function()
        
    end
})    tabs.Joinid:AddButton({
    Title = "Wait Update",
    Description = "Wait",
    Callback = function()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "W azure",
    Description = "",
    Callback = function()   
        getgenv().Team = "Marines" --Marines Pirates
getgenv().AutoLoad = true --Will Load Script On Server Hop
getgenv().SlowLoadUi  = false
getgenv().ForceUseSilentAimDashModifier = false --Force turn on silent aim , if error then executor problem
getgenv().ForceUseWalkSpeedModifier = true --Force turn on Walk Speed Modifier , if error then executor problem
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Redz Hub",
    Description = "",
    Callback = function()  
        local Settings = {
            JoinTeam = "Pirates"; -- Pirates/Marines
            Translator = true; -- true/false
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))()
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Xero Hub",
    Description = "",
    Callback = function()
        getgenv().Team = "Marines"
    getgenv().Hide_Menu = false
    getgenv().Auto_Execute = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Teddy Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/Teddy-FREMIUM"))() 
    end
})    tabs.Bloxfruit:AddButton({
    Title = "CutTay Hub Auto Pull Lever",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a1498369f289af2671cca90085f23fb8.lua"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Zenith Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Bapred Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Astral Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Overgustx2/Main/refs/heads/main/BloxFruits_%E2%80%8B25.html"))()   
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Omg Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Volcano Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wpisstestfprg/Volcano/refs/heads/main/VolcanoLocal.lua", true))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Kncrypt Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/BloxFruit.lua"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Hiru Hub",
    Description = "Need Key",
    Callback = function()
        getgenv().Team = "Pirates"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NGUYENVUDUY1/Source/main/HiruHub.lua"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Hiru Hub",
    Description = "Need Key",
    Callback = function()
        getgenv().Team = "Pirates"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NGUYENVUDUY1/Source/main/HiruHub.lua"))()  
    end
})    tabs.Bloxfruit:AddButton({
    Title = "HoHo Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})    tabs.Bloxfruit:AddButton({
    Title = "BlueX Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()      
    end
})    tabs.Bloxfruit:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()    
    end
})    tabs.Kaitunbf:AddButton({
    Title = "Kaitun Xero Hub",
    Description = "Need Key",
    Callback = function()
        -- Max level, godhuman, cdk, sgt
script_key = "" -- premium only, u can leave it blank if ur not
getgenv().Shutdown = false -- Turn on if u are farming bulk accounts
getgenv().Configs = {
    ["Team"] = "Marines",
    ["FPS Boost"] = {
        ["Enable"] = true,
        ["FPS Cap"] = 30,
    },
    ["Farm Boss Drops"] = {
        ["Enable"] = false,
        ["When x2 Exp Expired"] = false
    },
    ["Hop"] = { -- premium only
        ["Enable"] = true,
        ["Hop Find Tushita"] = true,
        ["Hop Find Valkyrie Helm"] = true,
        ["Hop Find Mirror Fractal"] = true,
        ["Hop Find Darkbeard"] = true, -- For skull guitar
        ["Hop Find Soul Reaper"] = true, -- For CDK
        ["Hop Find Mirage"] = true, -- For pull lever
        ["Find Fruit"] = true, -- Will find 1m+ fruit to unlock swan door to access third sea
    },
    ["Farm Mastery"] = {
        ["Enable"] = true,
        ["Farm Mastery Weapons"] = {"Sword", "Gun", "Blox Fruit"}, -- Blox Fruit, Gun (left -> right: High -> Low Priority)
        ["Swords To Farm"] = {"Cursed Dual Katana"},
        ["Guns To Farm"] = {"Skull Guitar"},
        ["Mastery Health (%)"] = 40 -- For Blox Fruit, Gun
    },
    ["Farm Config"] = {
        ["First Farm At Sky"] = true,
        ["Farm Bone Get x2 Exp"] = true
    },
    ["Trackstat"] = {
        ["Enable"] = false,
        ["Key"] = "", -- Get from xerohub.click
        ["Device"] = "test" -- u can put any name here
    },
    ["Auto Spawn rip_indra"] = true,
    ["Auto Spawn Dough King"] = true,
    ["Auto Pull Lever"] = true,
    ["Auto Collect Berry"] = true,
    ["Auto Evo Race"] = true,
    ["Awaken Fruit"] = true,
    ["Rainbow Haki"] = true,
    ["Hop Player Near"] = true,
    ["Skull Guitar"] = true,
    ["Cursed Dual Katana"] = true,
    ["Switch Melee"] = true,
    ["Eat Fruit"] = "", -- leave blank for none, put the fruit name like this example: Smoke Fruit, T-Rex Fruit, ...
    ["Snipe Fruit"] = "", -- leave blank for none, put the fruit name like this example: Smoke Fruit, T-Rex Fruit, ...
    ["Lock Fragment"] = 30000,
    ["Buy Stuffs"] = true -- buso, geppo, soru, ken haki, ...
}
repeat task.wait() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/kaitun.lua"))() end) until getgenv().Check_Execute  
    end
})    tabs.Kaitunbf:AddButton({
    Title = "Kaitun RoyX Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/RoyX%20Kaitun"))()    
    end
})    tabs.Kaitunbf:AddButton({
    Title = "Kaitun Simple Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/RoyX%20Kaitun"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Alchemy Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Bill Dev",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/selciawashere/screepts/refs/heads/main/BLRTBDMOBILEKEYSYS",true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
          
    end
})    tabs.Bluelock:AddButton({
    Title = "Lunor",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("loadstring(game:HttpGet('https://raw.githubusercontent.com/Just3itx/Lunor-Loadstrings/refs/heads/main/Loader'))()"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Omg Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/UPD-Blue-Lock:-Rivals-OMG-Hub-29091"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Arbix",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet(('https://pastefy.app/O3F7JYSF/raw'),true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Tbao Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/game/refs/heads/main/TbaoHubBlueLockRivals"))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Style Need Reo",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/D1M2PLua", true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Inf Stamina",
    Description = "",
    Callback = function()
        local args = {
            [1] = 0/0
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StaminaService"):WaitForChild("RE"):WaitForChild("DecreaseStamina"):FireServer(unpack(args))  
    end
})    tabs.Bluelock:AddButton({
    Title = "Auto Slide, Dribble",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Maybie/BlueLock/refs/heads/main/BLR.lua',true))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Sterling",
    Description = "",
    Callback = function()
        local GuiService = game:GetService("GuiService")
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer
    local function onerrorMessageChanged(errorMessage)
        if errorMessage and errorMessage ~= "" then
            print("Error detected: " .. errorMessage)
            if player then
                wait()
                TeleportService:Teleport(game.PlaceId, player)
            end
        end
    end
    GuiService.ErrorMessageChanged:Connect(onerrorMessageChanged)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zayn31214/name/refs/heads/main/SterlingNew"))()  
    end
})    tabs.Bluelock:AddButton({
    Title = "Over Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://api.overhub.xyz/keys/script/overhub'))()
    end
})    tabs.Bluelock:AddButton({
    Title = "Imp Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/alan11ago/Hub/refs/heads/main/ImpHub.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Ronix Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4d72046eb884e9c01333d3e704fc2d7.lua"))()
    end
})    tabs.Fisch:AddButton({
    Title = "Krcrypt Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/Fisch.lua"))()
    end
})    tabs.Petgo:AddButton({
    Title = "NS Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/go/refs/heads/main/is"))()
    end
})    tabs.Petgo:AddButton({
    Title = "Zap Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet('https://zaphub.xyz/Exec'))()
    end
})    tabs.Petgo:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Increase Hitbox + Aim lock",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/o4SV2jjx/raw"))()  
    end
})    tabs.Deedrails:AddButton({
    Title = "No Clip + Esp",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Auto Fram Bond",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/refs/heads/ok/dead%20rails"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Skull Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet('https://skullhub.xyz/loader.lua'))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Deed Rails",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/Bringall"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Speed Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Solix Hub",
    Description = "Need Key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Neox Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", true))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Spider Hub",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
    end
})    tabs.Deedrails:AddButton({
    Title = "Auto Bond Fake",
    Description = "",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Emplic/deathrails/refs/heads/main/bond"))()
    end
})

-- Giao diện Nút Mở UI (đẹp hơn, có particle, xoay, animation)
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "ToggleUIFluent"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game:GetService("CoreGui")

local button = Instance.new("ImageButton")
button.Size = UDim2.new(0, 50, 0, 50)
button.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 0
button.Image = "http://www.roblox.com/asset/?id=138569547227924"
button.Draggable = true
button.Parent = gui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- Particle hiệu ứng
local particle = Instance.new("ParticleEmitter")
particle.Parent = button
particle.LightEmission = 1
particle.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0) })
particle.Lifetime = NumberRange.new(0.5, 1)
particle.Rate = 0
particle.Speed = NumberRange.new(5, 10)
particle.SpreadAngle = Vector2.new(360, 360)
particle.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255))

-- Khi bấm nút
button.MouseButton1Down:Connect(function()
    particle.Rate = 100

    -- Reset sau 1s
    task.delay(1, function()
        particle.Rate = 0
    end)


    -- Gửi phím End để bật/tắt UI
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
end)

-- Xoá hiệu ứng chết/respawn nếu có
local effectContainer = game:GetService("ReplicatedStorage"):FindFirstChild("Effect") and game:GetService("ReplicatedStorage").Effect:FindFirstChild("Container")
if effectContainer then
    if effectContainer:FindFirstChild("Death") then
        effectContainer.Death:Destroy()
    end
    if effectContainer:FindFirstChild("Respawn") then
        effectContainer.Respawn:Destroy()
    end
end

-- Thông báo khi tải xong
Fluent:Notify({
    Title = "Script : ",
    Content = "Done",
    Duration = 10
})
