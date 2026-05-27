-- // EDUCATIONAL PURPOSE ONLY
-- // MODERATION BYPASS — DO NOT DEPLOY

local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _ts = game:GetService("TweenService")

-- Cleanup
if _cg:FindFirstChild("zHub_Final") then _cg.zHub_Final:Destroy() end

local _sg = Instance.new("ScreenGui")
_sg.Name = "zHub_Final"
_sg.Parent = _cg
_sg.ResetOnSpawn = false

-- Icon Button (Z)
local _ic = Instance.new("TextButton")
_ic.Name = "ic"
_ic.Size = UDim2.new(0, 60, 0, 60)
_ic.Position = UDim2.new(0.05, 0, 0.4, 0)
_ic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 150)
_ic.Font = Enum.Font.GothamBold
_ic.TextSize = 28
_ic.Parent = _sg
local _icC = Instance.new("UICorner", _ic)
_icC.CornerRadius = UDim.new(0, 18)

-- Main Frame
local _mf = Instance.new("Frame")
_mf.Name = "mf"
_mf.Size = UDim2.new(0, 300, 0, 160)
_mf.Position = UDim2.new(0.5, -150, 0.5, -80)
_mf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_mf.Visible = false
_mf.Parent = _sg
local _mfC = Instance.new("UICorner", _mf)
_mfC.CornerRadius = UDim.new(0, 14)

-- Title and Credits
local _tl = Instance.new("TextLabel", _mf)
_tl.Text = "zHub - EXPERIMENTAL"
_tl.Size = UDim2.new(1, 0, 0, 40)
_tl.BackgroundTransparency = 1
_tl.TextColor3 = Color3.new(1, 1, 1)
_tl.Font = Enum.Font.GothamBold

local _cr = Instance.new("TextLabel", _mf)
_cr.Text = "made by eou"
_cr.Position = UDim2.new(0, 0, 1, -25)
_cr.Size = UDim2.new(1, 0, 0, 20)
_cr.BackgroundTransparency = 1
_cr.TextColor3 = Color3.fromRGB(100, 100, 100)
_cr.TextSize = 12

-- Toggle
local _tg = Instance.new("TextButton", _mf)
_tg.Name = "tg"
_tg.Size = UDim2.new(0.8, 0, 0, 45)
_tg.Position = UDim2.new(0.1, 0, 0.35, 0)
_tg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
_tg.Text = "100% SUCCESS: OFF"
_tg.TextColor3 = Color3.new(1, 1, 1)
_tg.Font = Enum.Font.GothamMedium
local _tgC = Instance.new("UICorner", _tg)
_tgC.CornerRadius = UDim.new(0, 10)

-- Global State
local _act = false

-- Improved Draggable Logic
local function _drag(obj)
    local dragToggle = nil
    local dragStart = nil
    local startPos = nil

    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    _uis.InputChanged:Connect(function(input)
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

_drag(_mf)
_drag(_ic)

-- Interaction
_ic.MouseButton1Click:Connect(function()
    _mf.Visible = not _mf.Visible
end)

_tg.MouseButton1Click:Connect(function()
    _act = not _act
    _tg.Text = _act and "100% SUCCESS: ON" or "100% SUCCESS: OFF"
    _tg.BackgroundColor3 = _act and Color3.fromRGB(0, 120, 60) or Color3.fromRGB(40, 40, 40)
end)

-- Advanced Reverse Engineering Module
-- EDUCATIONAL PURPOSE ONLY
local _oldNc
_oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local _args = {...}
    local _method = getnamecallmethod()
    local _consent = true
    
    if _consent == true and _act and (_method == "FireServer" or _method == "InvokeServer") then
        if self.Name:lower():find("upgrade") or self.Name:lower():find("craft") then
            -- Search and modify chance values in tables
            for _, v in pairs(_args) do
                if type(v) == "table" then
                    if rawget(v, "Chance") or rawget(v, "Probability") then
                        v.Chance = 100
                        v.Probability = 1
                    end
                end
            end
        end
    end
    return _oldNc(self, unpack(_args))
end))

-- GC Scanner (Memory Hijack)
task.spawn(function()
    while task.wait(0.5) do
        if _act then
            local _objects = getgc(true)
            for i = 1, #_objects do
                local _v = _objects[i]
                if type(_v) == "table" then
                    if rawget(_v, "Chance") and type(_v.Chance) == "number" then
                        _v.Chance = 100
                    end
                end
            end
        end
    end
end)

