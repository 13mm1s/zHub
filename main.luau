local lp = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")

local zhub = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local uicorner = Instance.new("UICorner")
local title = Instance.new("TextLabel")
local closebtn = Instance.new("TextButton")
local toggleframe = Instance.new("Frame")
local switch = Instance.new("TextButton")
local switchcorner = Instance.new("UICorner")
local knob = Instance.new("Frame")
local knobcorner = Instance.new("UICorner")
local footer = Instance.new("TextLabel")
local icon = Instance.new("ImageButton")
local iconcorner = Instance.new("UICorner")
local iconz = Instance.new("TextLabel")

local enabled = false
local active = true

zhub.Name = "zHub"
zhub.Parent = game:GetService("CoreGui")

icon.Name = "Icon"
icon.Parent = zhub
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
icon.Position = UDim2.new(0.05, 0, 0.1, 0)
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Active = true
icon.Draggable = true

iconcorner.CornerRadius = UDim.new(0, 12)
iconcorner.Parent = icon

iconz.Parent = icon
iconz.Size = UDim2.new(1, 0, 1, 0)
iconz.Text = "Z"
iconz.TextColor3 = Color3.fromRGB(50, 255, 50)
iconz.TextSize = 30
iconz.Font = Enum.Font.GothamBold
iconz.BackgroundTransparency = 1

main.Name = "Main"
main.Parent = zhub
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.25
main.Position = UDim2.new(0.5, -100, 0.5, -75)
main.Size = UDim2.new(0, 200, 0, 150)
main.Visible = false
main.ClipsDescendants = true
main.Active = true
main.Draggable = true

uicorner.CornerRadius = UDim.new(0, 10)
uicorner.Parent = main

title.Parent = main
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "zHub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.Code
title.BackgroundTransparency = 1

closebtn.Parent = main
closebtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closebtn.Position = UDim2.new(0, 10, 0, 8)
closebtn.Size = UDim2.new(0, 12, 0, 12)
closebtn.Text = ""

Instance.new("UICorner", closebtn).CornerRadius = UDim.new(1, 0)

toggleframe.Parent = main
toggleframe.BackgroundTransparency = 1
toggleframe.Position = UDim2.new(0, 0, 0, 40)
toggleframe.Size = UDim2.new(1, 0, 0, 40)

local label = Instance.new("TextLabel", toggleframe)
label.Size = UDim2.new(0.6, 0, 1, 0)
label.Position = UDim2.new(0.1, 0, 0, 0)
label.Text = "100% Upgrade"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.TextXAlignment = Enum.TextXAlignment.Left

switch.Parent = toggleframe
switch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
switch.Position = UDim2.new(0.7, 0, 0.25, 0)
switch.Size = UDim2.new(0, 40, 0, 20)
switch.Text = ""

switchcorner.CornerRadius = UDim.new(1, 0)
switchcorner.Parent = switch

knob.Parent = switch
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.Position = UDim2.new(0, 2, 0.5, -8)
knob.Size = UDim2.new(0, 16, 0, 16)

knobcorner.CornerRadius = UDim.new(1, 0)
knobcorner.Parent = knob

footer.Parent = main
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.Text = "made by eou"
footer.TextColor3 = Color3.fromRGB(150, 150, 150)
footer.TextSize = 12
footer.BackgroundTransparency = 1

local function toggle()
	enabled = not enabled
	ts:Create(switch, TweenInfo.new(0.3), {BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)}):Play()
	ts:Create(knob, TweenInfo.new(0.3), {Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
end

switch.MouseButton1Click:Connect(toggle)

icon.MouseButton1Click:Connect(function()
	if main.Visible then
		main:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quart", 0.3, true, function() main.Visible = false end)
	else
		main.Size = UDim2.new(0, 200, 0, 0)
		main.Visible = true
		main:TweenSize(UDim2.new(0, 200, 0, 150), "Out", "Quart", 0.3, true)
	end
end)

local function promptexit()
	local p = Instance.new("Frame", zhub)
	p.Size = UDim2.new(0, 200, 0, 100)
	p.Position = UDim2.new(0.5, -100, 0.5, -50)
	p.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", p)
	
	local t = Instance.new("TextLabel", p)
	t.Size = UDim2.new(1, 0, 0, 50)
	t.Text = "Вы хотите завершить скрипт?"
	t.TextColor3 = Color3.fromRGB(255, 255, 255)
	t.BackgroundTransparency = 1
	
	local yes = Instance.new("TextButton", p)
	yes.Size = UDim2.new(0, 60, 0, 30)
	yes.Position = UDim2.new(0.2, 0, 0.6, 0)
	yes.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	yes.Text = "Да"
	Instance.new("UICorner", yes)
	
	local no = Instance.new("TextButton", p)
	no.Size = UDim2.new(0, 60, 0, 30)
	no.Position = UDim2.new(0.55, 0, 0.6, 0)
	no.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	no.Text = "Нет"
	Instance.new("UICorner", no)
	
	yes.MouseButton1Click:Connect(function() zhub:Destroy() active = false end)
	no.MouseButton1Click:Connect(function() p:Destroy() end)
end

closebtn.MouseButton1Click:Connect(promptexit)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
	local args = {...}
	local method = getnamecallmethod()
	
	if enabled and method == "FireServer" and self.Name == "UpgradeRemote" then 
		args[2] = true -- пример подмены флага удачи если он в аргументах
		return old(self, unpack(args))
	end
	
	return old(self, ...)
end)

setreadonly(mt, true)

