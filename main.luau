-- zHub | Advanced Loader by eou
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
screenGui.Name = "zHubLoader"

-- [ GUI ELEMENTS ]
local MainFrame = Instance.new("Frame", screenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Кнопка закрытия MacOS style
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 12, 0, 12)
CloseBtn.Position = UDim2.new(0, 10, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
CloseBtn.Text = ""
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- Функции: Speed, Kill Aura, ESP, Glass
local auraRadius = 15
local speedVal = 16

-- [ КИЛЛ АУРА С ВИЗУАЛИЗАЦИЕЙ ]
local ring = Instance.new("CylinderHandleAdornment", workspace)
ring.Radius = auraRadius
ring.Height = 0.2
ring.Color3 = Color3.fromRGB(255, 255, 255)
ring.Transparency = 0.5
ring.AlwaysOnTop = true
ring.Visible = false

RunService.Heartbeat:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        ring.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
        
        local tool = lp.Character:FindFirstChildOfClass("Tool")
        if tool and tool.Name == "Fork" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    if (lp.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude <= auraRadius then
                        tool:Activate()
                    end
                end
            end
        end
    end
end)

-- [ ЛОГИКА УВЕДОМЛЕНИЙ ]
local clicks = 0
CloseBtn.MouseButton1Click:Connect(function()
    clicks += 1
    if clicks == 1 then
        local Note = Instance.new("Frame", screenGui)
        Note.Size = UDim2.new(0, 300, 0, 60)
        Note.Position = UDim2.new(0.02, 0, 0.05, 0)
        Note.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        
        local T = Instance.new("TextLabel", Note)
        T.Text = "Are you sure?\nPress again to confirm exit"
        T.Size = UDim2.new(1, -20, 1, -20)
        T.TextColor3 = Color3.new(1,1,1)
        
        local Bar = Instance.new("Frame", Note)
        Bar.Size = UDim2.new(1, -20, 0, 2)
        Bar.Position = UDim2.new(0, 10, 1, -10)
        TweenService:Create(Bar, TweenInfo.new(3), {Size = UDim2.new(0, 0, 0, 2)}):Play()
        task.delay(3, function() Note:Destroy() clicks = 0 end)
    else
        screenGui:Destroy()
    end
end)

-- [ ИКОНКА ОТКРЫТИЯ ]
local ToggleIcon = Instance.new("TextButton", screenGui)
ToggleIcon.Size = UDim2.new(0, 40, 0, 40)
ToggleIcon.Position = UDim2.new(0.02, 0, 0.5, 0)
ToggleIcon.Text = "z"
ToggleIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleIcon.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [ CREDITS ]
local CreditLabel = Instance.new("TextLabel", MainFrame)
CreditLabel.Text = "Script created by @13mm1s (eou), all rights reserved"
CreditLabel.Position = UDim2.new(0, 0, 0.8, 0)
CreditLabel.Size = UDim2.new(1, 0, 0, 20)

