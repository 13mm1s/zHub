local lp = game:GetService("Players").LocalPlayer
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

local zhub = Instance.new("ScreenGui")
zhub.Name = "zHub_Spy"
zhub.Parent = game:GetService("CoreGui")

local icon = Instance.new("ImageButton", zhub)
icon.Name = "Icon"
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
icon.Position = UDim2.new(0.05, 0, 0.1, 0)
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Active = true
icon.Draggable = true
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 12)

local iconz = Instance.new("TextLabel", icon)
iconz.Size = UDim2.new(1, 0, 1, 0)
iconz.Text = "Z"
iconz.TextColor3 = Color3.fromRGB(50, 255, 50)
iconz.TextSize = 30
iconz.Font = Enum.Font.GothamBold
iconz.BackgroundTransparency = 1

local main = Instance.new("Frame", zhub)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.25
main.Position = UDim2.new(0.5, -100, 0.5, -75)
main.Size = UDim2.new(0, 200, 0, 150)
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "zHub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.Code
title.BackgroundTransparency = 1

local closebtn = Instance.new("TextButton", main)
closebtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closebtn.Position = UDim2.new(0, 10, 0, 8)
closebtn.Size = UDim2.new(0, 12, 0, 12)
closebtn.Text = ""
Instance.new("UICorner", closebtn).CornerRadius = UDim.new(1, 0)

local spy_enabled = false
local toggleframe = Instance.new("Frame", main)
toggleframe.BackgroundTransparency = 1
toggleframe.Position = UDim2.new(0, 0, 0, 50)
toggleframe.Size = UDim2.new(1, 0, 0, 40)

local label = Instance.new("TextLabel", toggleframe)
label.Size = UDim2.new(0.6, 0, 1, 0)
label.Position = UDim2.new(0.1, 0, 0, 0)
label.Text = "Remote Spy"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.TextXAlignment = Enum.TextXAlignment.Left

local switch = Instance.new("TextButton", toggleframe)
switch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
switch.Position = UDim2.new(0.7, 0, 0.25, 0)
switch.Size = UDim2.new(0, 40, 0, 20)
switch.Text = ""
Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

local knob = Instance.new("Frame", switch)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.Position = UDim2.new(0, 2, 0.5, -8)
knob.Size = UDim2.new(0, 16, 0, 16)
Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

local logframe = Instance.new("Frame", zhub)
logframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
logframe.BackgroundTransparency = 0.25
logframe.Position = UDim2.new(0.5, 110, 0.5, -75)
logframe.Size = UDim2.new(0, 250, 0, 200)
logframe.Visible = false
Instance.new("UICorner", logframe).CornerRadius = UDim.new(0, 10)

local scroll = Instance.new("ScrollingFrame", logframe)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 2
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)

local footer = Instance.new("TextLabel", main)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.Text = "made by eou"
footer.TextColor3 = Color3.fromRGB(150, 150, 150)
footer.TextSize = 12
footer.BackgroundTransparency = 1

local function log(txt)
    local l = Instance.new("TextLabel", scroll)
    l.Size = UDim2.new(1, 0, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.TextSize = 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
end

switch.MouseButton1Click:Connect(function()
    spy_enabled = not spy_enabled
    ts:Create(switch, TweenInfo.new(0.3), {BackgroundColor3 = spy_enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)}):Play()
    ts:Create(knob, TweenInfo.new(0.3), {Position = spy_enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
    logframe.Visible = spy_enabled
end)

icon.MouseButton1Click:Connect(function()
    if main.Visible then
        main:TweenSize(UDim2.new(0, 200, 0, 0), "Out", "Quart", 0.3, true, function() main.Visible = false end)
    else
        main.Size = UDim2.new(0, 200, 0, 0)
        main.Visible = true
        main:TweenSize(UDim2.new(0, 200, 0, 150), "Out", "Quart", 0.3, true)
    end
end)

closebtn.MouseButton1Click:Connect(function()
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
    
    yes.MouseButton1Click:Connect(function() zhub:Destroy() end)
    no.MouseButton1Click:Connect(function() p:Destroy() end)
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if spy_enabled and (method == "FireServer" or method == "InvokeServer") then
        local firstArg = "none"
        if args[1] ~= nil then
            if type(args[1]) == "table" then
                firstArg = "{table}"
            else
                firstArg = tostring(args[1])
            end
        end
        task.spawn(function()
            log(self.Name .. " | " .. firstArg)
        end)
    end
    
    return old(self, ...)
end)
setreadonly(mt, true)

