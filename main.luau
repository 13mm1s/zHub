-- Delta 2.720.1167: Hard State Hijack + Draggable UI
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100); Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Frame.Active = true; Frame.Draggable = true

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0.8, 0, 0.4, 0); Toggle.Position = UDim2.new(0.1, 0, 0.3, 0)
Toggle.Text = "FORCE-SAVE: ON"; Toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

-- Logic
local active = true
Toggle.MouseButton1Click:Connect(function()
    active = not active
    Toggle.Text = active and "FORCE-SAVE: ON" or "FORCE-SAVE: OFF"
    Toggle.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if active and method == "InvokeServer" and tostring(self):lower():find("upgrade") then
        -- Попытка перехвата и принудительного возврата успеха
        local success, result = pcall(function()
            return oldNamecall(self, unpack(args))
        end)
        return true 
    end

    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

