local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "wasd club",
	LoadingTitle = "code:Destroy()",
	LoadingSubtitle = "by unkn00wn_guy",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "EWEWEWEWEWEWEWEWEWEW(wasd club ESP)",
		FileName = "grrrrrrrrrrrrrrrrrrrrrrr(wasd club cfg)"
	},
	KeySystem = false, -- Set this to true to use their key system
	KeySettings = {
		Title = "Sirius Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/sirius)",
		SaveKey = true,
		Key = "ABCDEF"
	}
})

local your_local_INFO_guy = {
	chamsColor = Color3.fromRGB(255,0,0)
}

local detect = Instance.new("Folder")

local pt = game.Players.LocalPlayer
spawn(function()
	local chams = {}
	local function addChams(player_model)
		local chamsItem = Instance.new("Highlight", player_model)
		chamsItem.Adornee = player_model
		chamsItem.Name = "Chams"
		chamsItem.FillColor = your_local_INFO_guy.chamsColor
		chamsItem:SetAttribute("User", player_model.Name)
		table.insert(chams, chamsItem)
	end
	local function removeChams()
		for i,v in pairs(chams) do
			v:Destroy()
		end
	end
	local function configure_Character(char)
		if detect:GetAttribute("Chams") then
			addChams(char)
		end
		if detect:GetAttribute("not1") then
			pcall(function()
				local hum = char:WaitForChild("Humanoid")
				hum.Died:Connect(function()
					local p1 = ""
					if char.Name == pt.Name then
						p1 = "you"
					elseif char.Name ~= pt.Name then
						p1 = char.Name
					end
					
					Rayfield:Notify({Title = "Die Notification", Content = string.format("%s died!", p1), Image = 4483362458}) -- Notfication -- Title, Content, Image
				end)
			end)
		end
	end
	detect:GetAttributeChangedSignal("Chams"):Connect(function()
		local e = detect:GetAttribute("Chams")
		if e then
			removeChams()
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Character then
					configure_Character(v.Character)
				end
			end
		elseif not e then
			removeChams()
		end
	end)
	
	for i,v in pairs(game.Players:GetPlayers()) do
		v.CharacterAdded:Connect(function(char)
			configure_Character(char)
		end)
	end
	game.Players.PlayerAdded:Connect(function(pt)
		pt.CharacterAdded:Connect(function(char)
			configure_Character(char)
		end)
	end)
	game["Run Service"].RenderStepped:Connect(function()
		if detect:GetAttribute("AutoAim") then
			local closest_thing = nil
			local closest_d = math.huge
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Character and pt.Character and v.Name ~= pt.Name then
					if v.Character:FindFirstChild("Head") then
						local h1 = v.Character.Head
						local dist = (h1.Position - pt.Character.PrimaryPart.Position).Magnitude 
						if dist < 50 and dist < closest_d then
							closest_d = dist
							closest_thing = v.Character.Head
						end
					end
				end
			end
			if closest_thing ~= nil  then
				local cam = workspace.CurrentCamera
				cam.CFrame = CFrame.lookAt(cam.CFrame.Position, closest_thing.Position)
			end
		end
	end)
end)
local Visual = Window:CreateTab("Visual", 4483362458) -- Title, Image
local Aim = Window:CreateTab("Aim", 4483362458) -- Title, Image
local Other = Window:CreateTab("Other", 4483362458) -- Title, Image
local Not1 = Other:CreateToggle({
	Name = "Die notification",
	CurrentValue = false,
	Flag = "DieNotification", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		detect:SetAttribute("not1", Value)
	end,
})
local Chams = Visual:CreateToggle({
	Name = "Chams",
	CurrentValue = false,
	Flag = "Chams", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		detect:SetAttribute("Chams", Value)
	end,
})

local AutoAim = Aim:CreateToggle({
	Name = "Auto Aim",
	CurrentValue = false,
	Flag = "AutoAim", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		detect:SetAttribute("AutoAim", Value)
	end,
})
