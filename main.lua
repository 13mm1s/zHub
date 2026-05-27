-- // Z-HUB ELITE EDITION (STRICT LOGIC INJECTION)
-- // NO RUSSIAN CHARACTERS IN CODE

local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _ts = game:GetService("TweenService")
local _lp = game:GetService("Players").LocalPlayer

-- Cleanup existing
if _cg:FindFirstChild("zHub_Logic") then _cg.zHub_Logic:Destroy() end

local _sg = Instance.new("ScreenGui")
_sg.Name = "zHub_Logic"
_sg.Parent = _cg
_sg.ResetOnSpawn = false

-- Draggable Function
local function _drag(obj)
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

-- Floating Z Icon
local _ic = Instance.new("TextButton")
_ic.Size = UDim2.new(0, 60, 0, 60)
_ic.Position = UDim2.new(0, 30, 0.5, 0)
_ic.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 150)
_ic.Font = Enum.Font.GothamBold
_ic.TextSize = 30
_ic.Parent = _sg
Instance.new("UICorner", _ic).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _ic).Color = Color3.fromRGB(0, 255, 150)
_drag(_ic)

-- Main Menu
local _mf = Instance.new("Frame")
_mf.Size = UDim2.new(0, 320, 0, 180)
_mf.Position = UDim2.new(0.5, -160, 0.5, -90)
_mf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_mf.Visible = false
_mf.Parent = _sg
Instance.new("UICorner", _mf).CornerRadius = UDim.new(0, 15)
_drag(_mf)

local _title = Instance.new("TextLabel", _mf)
_title.Size = UDim2.new(1, 0, 0, 50)
_title.Text = "zHub Logic Injector"
_title.TextColor3 = Color3.new(1, 1, 1)
_title.Font = Enum.Font.GothamBold
_title.TextSize = 20
_title.BackgroundTransparency = 1

-- Toggle System
local _act = false
local _tBtn = Instance.new("TextButton", _mf)
_tBtn.Size = UDim2.new(0.8, 0, 0, 50)
_tBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
_tBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_tBtn.Text = "FORCE 100% CHANCE: OFF"
_tBtn.TextColor3 = Color3.new(1, 1, 1)
_tBtn.Font = Enum.Font.GothamMedium
Instance.new("UICorner", _tBtn).CornerRadius = UDim.new(0, 10)

_ic.MouseButton1Click:Connect(function() _mf.Visible = not _mf.Visible end)

_tBtn.MouseButton1Click:Connect(function()
    _act = not _act
    _tBtn.Text = _act and "FORCE 100% CHANCE: ON" or "FORCE 100% CHANCE: OFF"
    _ts:Create(_tBtn, TweenInfo.new(0.3), {BackgroundColor3 = _act and Color3.fromRGB(0, 150, 70) or Color3.fromRGB(30, 30, 30)}):Play()
end)

-- // REAL LOGIC INJECTION // --

-- 1. Constant Memory Scanner (getgc)
task.spawn(function()
    while task.wait(0.5) do
        if _act then
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" then
                    -- Targeting common upgrade variables in game tables
                    if rawget(v, "Chance") or rawget(v, "SuccessRate") or rawget(v, "UpgradeChance") then
                        v.Chance = 100
                        v.SuccessRate = 100
                        v.UpgradeChance = 100
                    end
                end
            end
        end
    end
end)

-- 2. Visual Circle & UI Hijack
task.spawn(function()
    while task.wait(0.1) do
        if _act then
            pcall(function()
                for _, v in pairs(_lp.PlayerGui:GetDescendants()) do
                    -- Filling the progress circle
                    if v.Name:lower():find("progress") or v.Name:lower():find("circle") or v.Name:lower():find("fill") then
                        if v:IsA("ImageLabel") or v:IsA("Frame") then
                            -- Forcing visual to 100%
                            if v:IsA("ImageLabel") and v.ScaleType == Enum.ScaleType.Slice then
                                -- Do nothing special
                            else
                                v.Size = UDim2.new(1, 0, 1, 0)
                            end
                        end
                    end
                    -- Forcing all percentage labels
                    if v:IsA("TextLabel") and v.Text:find("%%") then
                        v.Text = "100%"
                    end
                end
            end)
        end
    end
end)

-- 3. Remote Namecall Hook
local _oldNamecall
_oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local _args = {...}
    local _method = getnamecallmethod()
    
    if _act and (_method == "FireServer" or _method == "InvokeServer") then
        if self.Name:lower():find("upgrade") or self.Name:lower():find("craft") then
            -- Injecting success flags into the request table
            for i, arg in pairs(_args) do
                if type(arg) == "table" then
                    arg.Chance = 100
                    arg.Success = true
                    arg.ForceSuccess = true
                end
            end
        end
    end
    return _oldNamecall(self, unpack(_args))
end))

