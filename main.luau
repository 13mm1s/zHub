local lp = game:GetService("Players").LocalPlayer
local ts = game:GetService("TweenService")

-- ГУИ (оставляем твой стиль)
local zhub = Instance.new("ScreenGui", lp.PlayerGui)
zhub.Name = "zHub_Ultimate"

local main = Instance.new("Frame", zhub)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.25
main.Position = UDim2.new(0.5, -100, 0.5, -75)
main.Size = UDim2.new(0, 200, 0, 150)
main.Visible = false
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "zHub PRO"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Code
title.TextSize = 18
title.BackgroundTransparency = 1

local icon = Instance.new("ImageButton", zhub)
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0.05, 0, 0.1, 0)
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 12)

local iconz = Instance.new("TextLabel", icon)
iconz.Size = UDim2.new(1, 0, 1, 0)
iconz.Text = "Z"
iconz.TextColor3 = Color3.fromRGB(50, 255, 50)
iconz.Font = Enum.Font.GothamBold
iconz.TextSize = 30
iconz.BackgroundTransparency = 1

local enabled = false
local togglebtn = Instance.new("TextButton", main)
togglebtn.Size = UDim2.new(0, 150, 0, 30)
togglebtn.Position = UDim2.new(0.5, -75, 0.4, 0)
togglebtn.Text = "ULTRA UPGRADE: OFF"
togglebtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
togglebtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", togglebtn)

-- ФУНКЦИЯ ВИЗУАЛЬНОГО ОБМАНА (для круга и текста)
local function fakeVisuals()
    task.spawn(function()
        while task.wait(0.1) do
            if enabled then
                -- Ищем текст с процентами в интерфейсе игры
                for _, v in pairs(lp.PlayerGui:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Text:find("%%") then
                        v.Text = "100%"
                    end
                    -- Попытка закрасить прогресс-бар апгрейда в синий
                    if v:IsA("Frame") and (v.Name:lower():find("progress") or v.Name:lower():find("bar")) then
                        v.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                    end
                end
            end
        end
    end)
end
fakeVisuals()

togglebtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    togglebtn.Text = enabled and "ULTRA UPGRADE: ON" or "ULTRA UPGRADE: OFF"
    togglebtn.BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
end)

icon.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

-- ХУК НА СЕРВЕРНУЮ ЧАСТЬ
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if enabled and self.Name == "Upgrade" and method == "InvokeServer" then
        -- NFT Battle может проверять 'Success' в аргументах или множитель
        -- Мы форсируем все числа на 100 и булевые значения на true
        for i, v in pairs(args) do
            if type(v) == "number" then
                args[i] = 100 -- Шанс 100%
            elseif type(v) == "boolean" then
                args[i] = true -- Флаг успеха
            end
        end
        return old(self, unpack(args))
    end
    
    return old(self, ...)
end)

setreadonly(mt, true)

