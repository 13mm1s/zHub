local lp = game:GetService("Players").LocalPlayer
local ts = game:GetService("TweenService")

local zhub = Instance.new("ScreenGui", game:GetService("CoreGui"))
local main = Instance.new("Frame", zhub)
local icon = Instance.new("ImageButton", zhub)
local logframe = Instance.new("Frame", zhub)

-- [настройки иконок и меню те же, сокращаю для чистоты кода логики]
-- ... (весь UI код из прошлого скрипта оставляем) ...
-- [ниже критическая часть для перехвата]

local spy_enabled = false

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

-- перехват через hookfunction
local oldFire
oldFire = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)
    local args = {...}
    if spy_enabled then
        task.spawn(function()
            local info = "Remote: " .. tostring(self.Name)
            if args[1] then info = info .. " | Arg1: " .. tostring(args[1]) end
            log(info)
        end)
    end
    return oldFire(self, ...)
end))

-- если это RemoteFunction
local oldInvoke
oldInvoke = hookfunction(Instance.new("RemoteFunction").InvokeServer, newcclosure(function(self, ...)
    local args = {...}
    if spy_enabled then
        task.spawn(function()
            log("RF: " .. tostring(self.Name) .. " | Arg1: " .. tostring(args[1]))
        end)
    end
    return oldInvoke(self, ...)
end))

