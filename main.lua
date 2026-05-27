-- // Z-HUB ULTIMATE INJECTION (FINAL VERSION)
-- // NO RUSSIAN CHARACTERS IN CODE

local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _ts = game:GetService("TweenService")
local _lp = game:GetService("Players").LocalPlayer

-- Cleanup
if _cg:FindFirstChild("zHub_Final_Ultra") then _cg.zHub_Final_Ultra:Destroy() end

local _sg = Instance.new("ScreenGui")
_sg.Name = "zHub_Final_Ultra"
_sg.Parent = _cg
_sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Draggable Logic Function
local function _makeDraggable(obj)
    local dragging, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    _uis.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    _uis.InputEnded:Connect(function(input) dragging = false end)
end

-- Floating Icon Z
local _ic = Instance.new("TextButton")
_ic.Size = UDim2.new(0, 60, 0, 60)
_ic.Position = UDim2.new(0, 50, 0.5, -30)
_ic.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 127)
_ic.Font = Enum.Font.GothamBold
_ic.TextSize = 30
_ic.Parent = _sg
Instance.new("UICorner", _ic).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _ic).Color = Color3.fromRGB(0, 255, 127)
_makeDraggable(_ic)

-- Main UI
local _mf = Instance.new("Frame")
_mf.Size = UDim2.new(0, 300, 0, 160)
_mf.Position = UDim2.new(0.5, -150, 0.5, -80)
_mf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_mf.Visible = false
_mf.Parent = _sg
Instance.new("UICorner", _mf).CornerRadius = UDim.new(0, 15)
_makeDraggable(_mf)

local _title = Instance.new("TextLabel", _mf)
_title.Size = UDim2.new(1, 0, 0, 50)
_title.Text = "zHub Professional"
_title.TextColor3 = Color3.new(1, 1, 1)
_title.Font = Enum.Font.GothamBold
_title.TextSize = 18
_title.BackgroundTransparency = 1

-- Toggle Background
local _tBg = Instance.new("Frame", _mf)
_tBg.Size = UDim2.new(0, 240, 0, 45)
_tBg.Position = UDim2.new(0.5, -120, 0.45, 0)
_tBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", _tBg).CornerRadius = UDim.new(0, 10)

local _tLab = Instance.new("TextLabel", _tBg)
_tLab.Size = UDim2.new(0.6, 0, 1, 0)
_tLab.Position = UDim2.new(0.05, 0, 0, 0)
_tLab.Text = "100% SUCCESS"
_tLab.TextColor3 = Color3.new(0.8, 0.8, 0.8)
_tLab.Font = Enum.Font.GothamMedium
_tLab.TextXAlignment = Enum.TextXAlignment.Left
_tLab.BackgroundTransparency = 1

local _swB = Instance.new("TextButton", _tBg)
_swB.Size = UDim2.new(0, 50, 0, 26)
_swB.Position = UDim2.new(0.75, 0, 0.22, 0)
_swB.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
_swB.Text = ""
Instance.new("UICorner", _swB).CornerRadius = UDim.new(1, 0)

local _dot = Instance.new("Frame", _swB)
_dot.Size = UDim2.new(0, 20, 0, 20)
_dot.Position = UDim2.new(0.08, 0, 0.12, 0)
_dot.BackgroundColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", _dot).CornerRadius = UDim.new(1, 0)

local _active = false
_swB.MouseButton1Click:Connect(function()
    _active = not _active
    _ts:Create(_dot, TweenInfo.new(0.2), {Position = _active and UDim2.new(0.52, 0, 0.12, 0) or UDim2.new(0.08, 0, 0.12, 0)}):Play()
    _ts:Create(_swB, TweenInfo.new(0.2), {BackgroundColor3 = _active and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(50, 50, 50)}):Play()
end)

_ic.MouseButton1Click:Connect(function() _mf.Visible = not _mf.Visible end)

-- // ADVANCED INJECTION LOGIC // --

task.spawn(function()
    while task.wait(0.1) do
        if _active then
            pcall(function()
                -- 1. Full Circle Fill & Visual Spoofing
                for _, v in pairs(_lp.PlayerGui:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Text:find("%%") then
                        v.Text = "100%"
                    end
                    -- Attempting to fill rotation/progress bars
                    if v.Name:lower():find("bar") or v.Name:lower():find("fill") or v.Name:lower():find("progress") then
                        if v:IsA("ImageLabel") or v:IsA("Frame") then
                            v.Size = UDim2.new(1, 0, 1, 0)
                        end
                    end
                end
                
                -- 2. Constant GC Memory Hijack
                for _, v in pairs(getgc(true)) do
                    if type(v) == "table" then
                        if rawget(v, "Chance") or rawget(v, "Rate") or rawget(v, "Success") then
                            v.Chance = 100
                            v.Success = true
                            v.Rate = 100
                        end
                    end
                    if type(v) == "function" and getfenv(v).script and getfenv(v).script.Name:lower():find("upgrade") then
                        -- Forcing internal game function results to true
                        setupvalue(v, 1, 100) 
                    end
                end
            end)
        end
    end
end)

-- 3. High-Level Networking Hook
local _oldNc
_oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local _args = {...}
    local _method = getnamecallmethod()
    
    if _active and (_method == "InvokeServer" or _method == "FireServer") then
        if self.Name:lower():find("upgrade") or self.Name:lower():find("craft") then
            -- Deep search for probability values in remote packets
            for i, arg in pairs(_args) do
                if type(arg) == "table" then
                    arg.Chance = 100
                    arg.Probability = 1
                    arg.Success = true
                    arg.Force = true
                end
            end
        end
    end
    return _oldNc(self, unpack(_args))
end))

