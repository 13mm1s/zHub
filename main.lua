-- EDUCATIONAL PURPOSE ONLY
-- MODERATION BYPASS — DO NOT DEPLOY

local s = game:GetService("CoreGui")
local u = game:GetService("UserInputService")

local g = Instance.new("ScreenGui")
g.Name = "zHub_UI"
g.Parent = s

local f = Instance.new("Frame", g)
f.Size = UDim2.new(0, 300, 0, 150)
f.Position = UDim2.new(0.5, -150, 0.5, -75)
f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
f.Visible = false
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 16)

local t = Instance.new("TextLabel", f)
t.Text = "100% Upgrade"
t.Size = UDim2.new(0.5, 0, 0, 40)
t.Position = UDim2.new(0.05, 0, 0.4, 0)
t.BackgroundTransparency = 1
t.TextColor3 = Color3.new(1, 1, 1)

local b = Instance.new("Frame", f)
b.Size = UDim2.new(0.8, 0, 0, 40)
b.Position = UDim2.new(0.1, 0, 0.4, 0)
b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 20)

local sw = Instance.new("TextButton", b)
sw.Size = UDim2.new(0.4, 0, 1, 0)
sw.Position = UDim2.new(0, 0, 0, 0)
sw.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
sw.Text = ""
Instance.new("UICorner", sw).CornerRadius = UDim.new(0, 20)

local i = Instance.new("TextButton", g)
i.Size = UDim2.new(0, 50, 0, 50)
i.Position = UDim2.new(0, 10, 0.5, -25)
i.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
i.Text = "Z"
i.TextColor3 = Color3.new(1, 1, 1)
i.Font = Enum.Font.GothamBold
i.TextSize = 25
Instance.new("UICorner", i).CornerRadius = UDim.new(0, 12)

local m = false
i.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
sw.MouseButton1Click:Connect(function()
    m = not m
    sw:TweenPosition(m and UDim2.new(0.6, 0, 0, 0) or UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2)
    sw.BackgroundColor3 = m and Color3.fromRGB(75, 181, 67) or Color3.fromRGB(150, 150, 150)
end)

local _dragging, _dragInput, _dragStart, _startPos
f.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragging = true
        _dragStart = input.Position
        _startPos = f.Position
    end
end)

u.InputChanged:Connect(function(input)
    if _dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local _delta = input.Position - _dragStart
        f.Position = UDim2.new(_startPos.X.Scale, _startPos.X.Offset + _delta.X, _startPos.Y.Scale, _startPos.Y.Offset + _delta.Y)
    end
end)

u.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragging = false
    end
end)

local o
o = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local a = {...}
    if m and getnamecallmethod() == "InvokeServer" then
        if self.Name:lower():find("upgrade") then
            a[#a + 1] = "FORCE_SUCCESS"
        end
    end
    return o(self, unpack(a))
end))

