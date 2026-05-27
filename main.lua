-- EDUCATIONAL PURPOSE ONLY
-- MODERATION BYPASS — DO NOT DEPLOY

local s = game:GetService("CoreGui")
local u = game:GetService("UserInputService")

local g = Instance.new("ScreenGui")
g.Name = "x" .. tostring(math.random(100, 999))
g.Parent = s

local f = Instance.new("Frame", g)
f.Size = UDim2.new(0, 200, 0, 150)
f.Position = UDim2.new(0.5, -100, 0.5, -75)
f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
f.Visible = false
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)

local b = Instance.new("TextButton", f)
b.Text = "100% UPGRADE: OFF"
b.Size = UDim2.new(0.8, 0, 0, 40)
b.Position = UDim2.new(0.1, 0, 0.3, 0)
b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

local i = Instance.new("ImageButton", g)
i.Size = UDim2.new(0, 50, 0, 50)
i.Position = UDim2.new(0, 10, 0.5, -25)
i.Image = "rbxassetid://16769938927"
Instance.new("UICorner", i).CornerRadius = UDim.new(0, 12)

local m = false
i.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)
b.MouseButton1Click:Connect(function()
    m = not m
    b.Text = m and "100% UPGRADE: ON" or "100% UPGRADE: OFF"
    b.BackgroundColor3 = m and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 50, 50)
end)

local l = Instance.new("TextLabel", f)
l.Text = "made by eou"
l.Size = UDim2.new(1, 0, 0, 20)
l.Position = UDim2.new(0, 0, 1, -25)
l.BackgroundTransparency = 1
l.TextColor3 = Color3.fromRGB(255, 255, 255)

local o
o = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local a = {...}
    local n = getnamecallmethod()
    if (n == "InvokeServer" or n == "FireServer") and m then
        if self.Name:lower():find("upgrade") or self.Name:lower():find("craft") then
            a[#a + 1] = "FORCE_SUCCESS"
        end
    end
    return o(self, unpack(a))
end))
