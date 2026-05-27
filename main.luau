-- Delta 2.720.1167: Dynamic Target Override
local UIS = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100); Frame.Position = UDim2.new(0.5, -100, 0.5, -50); Frame.Active = true; Frame.Draggable = true
local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(1, 0, 1, 0); Toggle.Text = "AUTO-TARGET: OFF"; Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local active = false
local lastSelectedTarget = nil -- Переменная для динамического отслеживания цели

Toggle.MouseButton1Click:Connect(function()
    active = not active
    Toggle.Text = active and "AUTO-TARGET: ON" or "AUTO-TARGET: OFF"
    Toggle.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if active then
        -- 1. Перехват выбора: запоминаем, на что кликнули (цель)
        if method == "FireServer" and tostring(self):lower():find("select") then
            lastSelectedTarget = args[1] -- Сохраняем ID/Имя предмета, который ты выбрал
        end

        -- 2. Перехват апгрейда: подменяем цель на последнюю выбранную и форсируем успех
        if method == "InvokeServer" and tostring(self):lower():find("upgrade") then
            if lastSelectedTarget then
                for i, v in pairs(args) do
                    -- Если аргумент похож на ID предмета, подменяем его на тот, что мы запомнили
                    if v ~= true and v ~= false and v ~= 0 then 
                        args[i] = lastSelectedTarget 
                    end
                    -- Форсируем успех (если сервер принимает булево значение)
                    if v == false or v == "Miss" then args[i] = true end
                end
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

