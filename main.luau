-- Delta 2.720.1167 Hook: RemoteFunction Override
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Инициализация GUI (Draggable + Toggle)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 80); Frame.Position = UDim2.new(0.8, 0, 0.2, 0); Frame.Active = true; Frame.Draggable = true
local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(1, 0, 1, 0); Toggle.Text = "FORCE SUCCESS: OFF"; Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local forceSuccess = false
Toggle.MouseButton1Click:Connect(function()
    forceSuccess = not forceSuccess
    Toggle.Text = forceSuccess and "FORCE SUCCESS: ON" or "FORCE SUCCESS: OFF"
    Toggle.BackgroundColor3 = forceSuccess and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
end)

-- Перехват RemoteFunction (Server Side Interaction)
local oldInvoke
oldInvoke = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if forceSuccess and method == "InvokeServer" and self:IsA("RemoteFunction") then
        -- Подмена данных: перехватываем аргументы, которые отвечают за проверку зоны
        -- Обычно это таблица или булево значение (success/zone_hit)
        for i, v in pairs(args) do
            if v == false or v == "Miss" or v == 0 then
                args[i] = true -- Форсируем успешный статус
            end
        end
        return oldInvoke(self, unpack(args))
    end
    return oldInvoke(self, ...)
end)

