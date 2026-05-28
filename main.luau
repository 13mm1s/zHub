-- zHub Loader by eou
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local lp = Players.LocalPlayer
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))

-- --- GUI КОНСТРУКТОР ---
local MainFrame = Instance.new("Frame", gui)
MainFrame.Name = "zHub"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true -- Позволяет передвигать окно

-- Кнопка закрытия (MacOS стиль)
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 15, 0, 15)
CloseBtn.Position = UDim2.new(0, 5, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
CloseBtn.Text = ""
CloseBtn.AutoButtonColor = false
local UICorner = Instance.new("UICorner", CloseBtn)
UICorner.CornerRadius = UDim.new(1, 0)

-- Заголовок и Футер
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "zHub"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1

local Footer = Instance.new("TextLabel", MainFrame)
Footer.Text = "Loader by zHub"
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.TextColor3 = Color3.new(0.5,0.5,0.5)

-- Функция уведомления с полосой
local function ShowNotify(title, text)
    local Note = Instance.new("Frame", gui)
    Note.Size = UDim2.new(0, 250, 0, 70)
    Note.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    local T = Instance.new("TextLabel", Note)
    T.Text = title .. "\n" .. text
    T.Size = UDim2.new(1, 0, 1, -2)
    
    local Bar = Instance.new("Frame", Note)
    Bar.Size = UDim2.new(1, 0, 0, 2)
    Bar.Position = UDim2.new(0, 0, 1, -2)
    Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    TweenService:Create(Bar, TweenInfo.new(3), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    task.wait(3)
    Note:Destroy()
end

CloseBtn.MouseButton1Click:Connect(function()
    ShowNotify("Are you sure?", "Нажмите еще раз, чтобы завершить работу")
end)

-- --- ЛОГИКА (Функции) ---
local auraRadius = 15
local ring = Instance.new("CylinderHandleAdornment", workspace)
ring.Radius = auraRadius
ring.Height = 0.2
ring.Color3 = Color3.new(1,1,1)
ring.AlwaysOnTop = true
ring.Adornee = lp.Character:FindFirstChild("HumanoidRootPart")

-- Kill Aura с учетом вилки
RunService.Heartbeat:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("Fork") then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if dist <= auraRadius then
                    char.Fork:Activate()
                end
            end
        end
    end
    -- Обновление визуального кольца
    if char and char:FindFirstChild("HumanoidRootPart") then
        ring.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
    end
end)

-- Credits
print("Скрипт был создан игроком @13mm1s (eou), все права защищены, использование кода без согласования владельца карается")

