local lp = game:GetService("Players").LocalPlayer
local ts = game:GetService("TweenService")

-- создание интерфейса
local zhub = Instance.new("ScreenGui")
zhub.Name = "zHub_Spy"
try { zhub.Parent = game:GetService("CoreGui") } catch { zhub.Parent = lp.PlayerGui }

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
title.Font = Enum.Font.Code
title.TextSize = 18
title.BackgroundTransparency = 1

local closebtn = Instance.new("TextButton", main)
closebtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closebtn.Position = UDim2.new(0, 10, 0, 8)
closebtn.Size = UDim2.new(0, 12, 0, 12)
closebtn.Text = ""
Instance.new("UICorner", closebtn).CornerRadius = UDim.new(1, 0)

local icon = Instance.new("ImageButton", zhub)
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0.05, 0, 0.1, 0)
icon.Draggable = true
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 12)

local iconz = Instance.new("TextLabel", icon)
iconz.Size = UDim2.new(1, 0, 1, 0)
iconz.Text = "Z"
iconz.TextColor3 = Color3.fromRGB(50, 255, 50)
iconz.Font = Enum.Font.GothamBold
iconz.TextSize = 30
iconz.BackgroundTransparency = 1

local spy_enabled = false
local logframe = Instance.new("Frame", zhub)
logframe.Size = UDim2.new(0, 250, 0, 200)
logframe.Position = UDim2.new(0.5, 110, 0.5, -75)
logframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
logframe.BackgroundTransparency = 0.25
logframe.Visible = false
Instance.new("UICorner", logframe)

local scroll = Instance.new("ScrollingFrame", logframe)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local layout = Instance.new("UIListLayout", scroll)

local togglebtn = Instance.new("TextButton", main)
togglebtn.Size = UDim2.new(0, 150, 0, 30)
togglebtn.Position = UDim2.new(0.5, -75, 0.4, 0)
togglebtn.Text = "Remote Spy: OFF"
togglebtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
togglebtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", togglebtn)

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
    l.Text = txt
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
end

togglebtn.MouseButton1Click:Connect(function()
    spy_enabled = not spy_enabled
    togglebtn.Text = spy_enabled and "Remote Spy: ON" or "Remote Spy: OFF"
    togglebtn.BackgroundColor3 = spy_enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
    logframe.Visible = spy_enabled
end)

icon.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

closebtn.MouseButton1Click:Connect(function() zhub:Destroy() end)

-- Самый простой хук
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if spy_enabled and (method == "FireServer" or method == "InvokeServer") then
        task.spawn(function() log(tostring(self.Name)) end)
    end
    return old(self, ...)
end)
setreadonly(mt, true)

print("zHub Loaded")

