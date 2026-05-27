-- Delta 2.720.1167: Network Silencer & Force Success
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100); Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Frame.Active = true; Frame.Draggable = true
local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(0.8, 0, 0.4, 0); Toggle.Position = UDim2.new(0.1, 0, 0.3, 0)
Toggle.Text = "FORCE-SUCCESS: ON"; Toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)

local active = true
Toggle.MouseButton1Click:Connect(function()
    active = not active
    Toggle.Text = active and "FORCE-SUCCESS: ON" or "FORCE-SUCCESS: OFF"
    Toggle.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Перехватываем ответ сервера (OnClientEvent)
    -- Если сервер шлет сигнал "Fail", "False" или "Loss", мы просто блокируем его
    if active and method == "FireClient" then
        if args[1] == "Fail" or args[1] == false or tostring(args[1]):lower():find("fail") then
            return nil -- Игнорируем сигнал проигрыша
        end
    end

    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

