local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _ts = game:GetService("TweenService")
local _lp = game:GetService("Players").LocalPlayer

-- Cleanup
if _cg:FindFirstChild("zHub_Ultra") then _cg.zHub_Ultra:Destroy() end

local _sg = Instance.new("ScreenGui")
_sg.Name = "zHub_Ultra"
_sg.Parent = _cg
_sg.IgnoreGuiInset = true

-- Draggable Icon (Z)
local _ic = Instance.new("TextButton")
_ic.Size = UDim2.new(0, 65, 0, 65)
_ic.Position = UDim2.new(0, 50, 0.5, -32)
_ic.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 127)
_ic.Font = Enum.Font.GothamBold
_ic.TextSize = 30
_ic.Parent = _sg
local _icC = Instance.new("UICorner", _ic)
_icC.CornerRadius = UDim.new(0, 50)
local _icS = Instance.new("UIStroke", _ic)
_icS.Color = Color3.fromRGB(0, 255, 127)
_icS.Thickness = 2

-- Main Frame (Redesign)
local _mf = Instance.new("Frame")
_mf.Size = UDim2.new(0, 320, 0, 180)
_mf.Position = UDim2.new(0.5, -160, 0.5, -90)
_mf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_mf.Visible = false
_mf.Parent = _sg
Instance.new("UICorner", _mf).CornerRadius = UDim.new(0, 15)
local _mfS = Instance.new("UIStroke", _mf)
_mfS.Color = Color3.fromRGB(40, 40, 40)
_mfS.Thickness = 1

local _title = Instance.new("TextLabel", _mf)
_title.Size = UDim2.new(1, 0, 0, 45)
_title.Text = "zHub Professional"
_title.TextColor3 = Color3.new(1, 1, 1)
_title.Font = Enum.Font.GothamBold
_title.TextSize = 18
_title.BackgroundTransparency = 1

-- Toggle Background
local _tBg = Instance.new("Frame", _mf)
_tBg.Size = UDim2.new(0, 260, 0, 50)
_tBg.Position = UDim2.new(0.5, -130, 0.4, 0)
_tBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", _tBg).CornerRadius = UDim.new(0, 10)

local _tLab = Instance.new("TextLabel", _tBg)
_tLab.Size = UDim2.new(0.6, 0, 1, 0)
_tLab.Position = UDim2.new(0.05, 0, 0, 0)
_tLab.Text = "100% SUCCESS"
_tLab.TextColor3 = Color3.new(0.8, 0.8, 0.8)
_tLab.Font = Enum.Font.GothamMedium
_tLab.TextXAlignment = Enum.TextXAlignment.Left
_tLab.BackgroundTransparency = 1

-- Modern Switch
local _swB = Instance.new("TextButton", _tBg)
_swB.Size = UDim2.new(0, 50, 0, 26)
_swB.Position = UDim2.new(0.75, 0, 0.24, 0)
_swB.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
_swB.Text = ""
Instance.new("UICorner", _swB).CornerRadius = UDim.new(1, 0)

local _dot = Instance.new("Frame", _swB)
_dot.Size = UDim2.new(0, 20, 0, 20)
_dot.Position = UDim2.new(0.08, 0, 0.12, 0)
_dot.BackgroundColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", _dot).CornerRadius = UDim.new(1, 0)

local _cred = Instance.new("TextLabel", _mf)
_cred.Size = UDim2.new(1, 0, 0, 30)
_cred.Position = UDim2.new(0, 0, 0.85, 0)
_cred.Text = "made by eou"
_cred.TextColor3 = Color3.fromRGB(70, 70, 70)
_cred.BackgroundTransparency = 1

-- Dragging System (Advanced)
local function _enableDrag(obj)
    local dragToggle, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    _uis.InputChanged:Connect(function(input)
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    _uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = false
        end
    end)
end

_enableDrag(_mf)
_enableDrag(_ic)

-- Logic Handling
local _active = false
_swB.MouseButton1Click:Connect(function()
    _active = not _active
    _ts:Create(_dot, TweenInfo.new(0.25), {Position = _active and UDim2.new(0.52, 0, 0.12, 0) or UDim2.new(0.08, 0, 0.12, 0)}):Play()
    _ts:Create(_swB, TweenInfo.new(0.25), {BackgroundColor3 = _active and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(50, 50, 50)}):Play()
end)

_ic.MouseButton1Click:Connect(function() _mf.Visible = not _mf.Visible end)

-- Advanced Interception Logic
local _oldNamecall
_oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    if _active and (method == "FireServer" or method == "InvokeServer") then
        -- Attempting to intercept specific NFT Battle upgrade arguments
        for i, v in pairs(args) do
            if type(v) == "table" and (v.Chance or v.Probability or v.Rate) then
                v.Chance = 100
                v.Probability = 1
                v.Rate = 100
            end
        end
    end
    return _oldNamecall(self, unpack(args))
end))

-- GUI Chance Spoofer
task.spawn(function()
    while task.wait(0.3) do
        if _active then
            pcall(function()
                for _, v in pairs(_lp.PlayerGui:GetDescendants()) do
                    if v:IsA("TextLabel") and (v.Text:find("%%")) then
                        local num = tonumber(v.Text:match("%d+%.?%d*"))
                        if num and num < 100 then
                            v.Text = "100%"
                        end
                    end
                end
            end)
        end
    end
end)

