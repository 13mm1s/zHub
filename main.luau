local lp = game:GetService("Players").LocalPlayer
local ts = game:GetService("TweenService")

local zhub = Instance.new("ScreenGui", lp.PlayerGui)
zhub.Name = "zHub_V3"

local main = Instance.new("Frame", zhub)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Size = UDim2.new(0, 200, 0, 150)
main.Position = UDim2.new(0.5, -100, 0.5, -75)
main.Active = true
Instance.new("UICorner", main)

local togglebtn = Instance.new("TextButton", main)
togglebtn.Size = UDim2.new(0, 160, 0, 40)
togglebtn.Position = UDim2.new(0, 20, 0, 50)
togglebtn.Text = "100% SUCCESS: OFF"
togglebtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
togglebtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", togglebtn)

local enabled = false

-- Оптимизированный визуал без лагов
task.spawn(function()
    while task.wait(0.5) do -- Проверка раз в полсекунды вместо спама
        if enabled then
            local gui = lp.PlayerGui:FindFirstChild("MainGui") -- Проверь имя своего основного гуи игры
            if gui then
                for _, v in pairs(gui:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Text:find("%%") then
                        v.Text = "100%"
                    end
                end
            end
        end
    end
end)

togglebtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    togglebtn.Text = enabled and "100% SUCCESS: ON" or "100% SUCCESS: OFF"
    togglebtn.BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
end)

-- Умный перехват RemoteFunction
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if enabled and self.Name == "Upgrade" and method == "InvokeServer" then
        -- Вызываем оригинал, но пытаемся подменить ответ сервера
        local result = old(self, unpack(args))
        
        -- Если сервер вернул таблицу с результатом (успех/провал)
        if type(result) == "table" then
            if result.Success ~= nil then result.Success = true end
            if result.Status ~= nil then result.Status = "Success" end
        elseif type(result) == "boolean" then
            return true -- Принудительный успех для клиента
        end
        
        return result
    end

    return old(self, ...)
end)

setreadonly(mt, true)

