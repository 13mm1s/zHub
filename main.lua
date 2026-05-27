-- // Z-HUB V5.0 INTEGRATED SYSTEM (LOGIC + SPY)
-- // NO RUSSIAN CHARACTERS IN CODE

local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _ts = game:GetService("TweenService")
local _lp = game:GetService("Players").LocalPlayer

-- Cleanup
if _cg:FindFirstChild("zHub_Integrated") then _cg.zHub_Integrated:Destroy() end

local _sg = Instance.new("ScreenGui")
_sg.Name = "zHub_Integrated"
_sg.Parent = _cg
_sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Draggable Logic
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
local _ic = Instance.new("TextButton", _sg)
_ic.Size = UDim2.new(0, 60, 0, 60)
_ic.Position = UDim2.new(0, 20, 0.4, 0)
_ic.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 150)
_ic.Font = Enum.Font.GothamBold
_ic.TextSize = 32
Instance.new("UICorner", _ic).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _ic).Color = Color3.fromRGB(0, 255, 150)
_drag(_ic)

-- Main Menu
local _mf = Instance.new("Frame", _sg)
_mf.Size = UDim2.new(0, 280, 0, 200)
_mf.Position = UDim2.new(0.5, -140, 0.5, -100)
_mf.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_mf.Visible = false
Instance.new("UICorner", _mf).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", _mf).Color = Color3.fromRGB(40, 40, 40)
_drag(_mf)

local _title = Instance.new("TextLabel", _mf)
_title.Size = UDim2.new(1, 0, 0, 40)
_title.Text = "zHub Integrated"
_title.TextColor3 = Color3.new(1, 1, 1)
_title.Font = Enum.Font.GothamBold
_title.BackgroundTransparency = 1

-- Remote Spy Container (The Text Box)
local _spyFrame = Instance.new("Frame", _sg)
_spyFrame.Size = UDim2.new(0, 350, 0, 200)
_spyFrame.Position = UDim2.new(0.5, 150, 0.5, -100)
_spyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_spyFrame.Visible = false
Instance.new("UICorner", _spyFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", _spyFrame).Color = Color3.fromRGB(0, 150, 255)
_drag(_spyFrame)

local _spyLabel = Instance.new("TextLabel", _spyFrame)
_spyLabel.Size = UDim2.new(1, 0, 0, 30)
_spyLabel.Text = "Network Logs"
_spyLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
_spyLabel.Font = Enum.Font.GothamBold
_spyLabel.BackgroundTransparency = 1

local _scroll = Instance.new("ScrollingFrame", _spyFrame)
_scroll.Size = UDim2.new(0.9, 0, 0.75, 0)
_scroll.Position = UDim2.new(0.05, 0, 0.2, 0)
_scroll.BackgroundTransparency = 1
_scroll.CanvasSize = UDim2.new(0, 0, 10, 0)
Instance.new("UIListLayout", _scroll).SortOrder = Enum.SortOrder.LayoutOrder

-- Toggles State
local _activeUpgrade = false
local _activeSpy = false

local function _createToggle(name, pos, callback)
    local _btn = Instance.new("TextButton", _mf)
    _btn.Size = UDim2.new(0.85, 0, 0, 40)
    _btn.Position = pos
    _btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    _btn.Text = name .. ": OFF"
    _btn.TextColor3 = Color3.new(1, 1, 1)
    _btn.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", _btn).CornerRadius = UDim.new(0, 8)
    
    _btn.MouseButton1Click:Connect(function()
        local state = callback()
        _btn.Text = name .. ": " .. (state and "ON" or "OFF")
        _ts:Create(_btn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(20, 20, 20)}):Play()
    end)
end

_createToggle("100% UPGRADE", UDim2.new(0.075, 0, 0.25, 0), function()
    _activeUpgrade = not _activeUpgrade
    return _activeUpgrade
end)

_createToggle("REMOTE SPY", UDim2.new(0.075, 0, 0.5, 0), function()
    _activeSpy = not _activeSpy
    _spyFrame.Visible = _activeSpy
    return _activeSpy
end)

_ic.MouseButton1Click:Connect(function() _mf.Visible = not _mf.Visible end)

-- // LOGIC & SPY CORE // --

local function _log(name, method, args)
    if not _activeSpy then return end
    local _l = Instance.new("TextLabel", _scroll)
    _l.Size = UDim2.new(1, 0, 0, 20)
    _l.BackgroundTransparency = 1
    _l.TextColor3 = Color3.new(1, 1, 1)
    _l.TextSize = 10
    _l.TextXAlignment = Enum.TextXAlignment.Left
    _l.Text = "[" .. method .. "] " .. name
    
    print("--- zHub Spy Log ---")
    print("Remote:", name)
    for i, v in pairs(args) do
        print("  Arg["..i.."]:", v)
        if type(v) == "table" then
            for k, val in pairs(v) do print("    - "..tostring(k)..":", val) end
        end
    end
end

-- Hooking
local _oldNc
_oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local _args = {...}
    local _method = getnamecallmethod()
    
    if _method == "InvokeServer" or _method == "FireServer" then
        if self.Name:lower():find("upgrade") or self.Name:lower():find("craft") then
            -- Remote Spy Action
            _log(self.Name, _method, _args)
            
            -- Upgrade Injection Action
            if _activeUpgrade then
                for _, arg in pairs(_args) do
                    if type(arg) == "table" then
                        arg.Chance = 100
                        arg.Success = true
                    end
                end
            end
        end
    end
    return _oldNc(self, unpack(_args))
end))

-- Visuals Loop
task.spawn(function()
    while task.wait(0.3) do
        if _activeUpgrade then
            pcall(function()
                for _, v in pairs(_lp.PlayerGui:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Text:find("%%") then
                        v.Text = "100%"
                    end
                    if v:IsA("ImageLabel") and (v.Name:lower():find("fill") or v.Name:lower():find("progress")) then
                        pcall(function() v.FillAmount = 1 end)
                    end
                end
            end)
        end
    end
end)

