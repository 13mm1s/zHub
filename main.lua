-- // Z-HUB V5.1 SAFE INTEGRATED (LOGIC + SPY)
-- // EDUCATIONAL PURPOSE ONLY
-- // NO RUSSIAN CHARACTERS IN CODE

local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _ts = game:GetService("TweenService")
local _lp = game:GetService("Players").LocalPlayer

-- Cleanup
if _cg:FindFirstChild("zHub_Safe") then _cg.zHub_Safe:Destroy() end

local _sg = Instance.new("ScreenGui", _cg)
_sg.Name = "zHub_Safe"

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

-- Floating Z
local _ic = Instance.new("TextButton", _sg)
_ic.Size = UDim2.new(0, 55, 0, 55)
_ic.Position = UDim2.new(0, 10, 0.4, 0)
_ic.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 150)
_ic.Font = Enum.Font.GothamBold
_ic.TextSize = 28
Instance.new("UICorner", _ic).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _ic).Color = Color3.fromRGB(0, 255, 150)
_drag(_ic)

-- Main Menu
local _mf = Instance.new("Frame", _sg)
_mf.Size = UDim2.new(0, 260, 0, 180)
_mf.Position = UDim2.new(0.5, -130, 0.5, -90)
_mf.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_mf.Visible = false
Instance.new("UICorner", _mf).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", _mf).Color = Color3.fromRGB(50, 50, 50)
_drag(_mf)

-- Spy Log (Transparent Draggable Container)
local _spyCont = Instance.new("Frame", _sg)
_spyCont.Size = UDim2.new(0, 320, 0, 180)
_spyCont.Position = UDim2.new(0.5, 140, 0.5, -90)
_spyCont.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
_spyCont.Visible = false
Instance.new("UICorner", _spyCont).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", _spyCont).Color = Color3.fromRGB(0, 120, 255)
_drag(_spyCont)

local _scroll = Instance.new("ScrollingFrame", _spyCont)
_scroll.Size = UDim2.new(0.9, 0, 0.8, 0)
_scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
_scroll.BackgroundTransparency = 1
_scroll.CanvasSize = UDim2.new(0, 0, 10, 0)
_scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", _scroll).SortOrder = Enum.SortOrder.LayoutOrder

-- Logic State
local _upgOn = false
local _spyOn = false

local function _btn(txt, pos, callback)
    local b = Instance.new("TextButton", _mf)
    b.Size = UDim2.new(0.85, 0, 0, 35)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.Text = txt .. ": OFF"
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        local s = callback()
        b.Text = txt .. ": " .. (s and "ON" or "OFF")
        _ts:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = s and Color3.fromRGB(0, 120, 80) or Color3.fromRGB(25, 25, 25)}):Play()
    end)
end

_btn("FORCE 100%", UDim2.new(0.075, 0, 0.25, 0), function() _upgOn = not _upgOn return _upgOn end)
_btn("REMOTE SPY", UDim2.new(0.075, 0, 0.55, 0), function() _spyOn = not _spyOn _spyCont.Visible = _spyOn return _spyOn end)

_ic.MouseButton1Click:Connect(function() _mf.Visible = not _mf.Visible end)

-- // SAFE LOGGING FUNCTION // --
local function _log(name, args)
    if not _spyOn then return end
    local l = Instance.new("TextLabel", _scroll)
    l.Size = UDim2.new(1, 0, 0, 18)
    l.BackgroundTransparency = 1
    l.TextColor3 = Color3.fromRGB(0, 200, 255)
    l.TextSize = 10
    l.Text = "Remote: " .. tostring(name)
    l.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Silent console log
    print("--- zHub Spy ---")
    print("Call:", name)
    for i, v in pairs(args) do print("Arg"..i..":", v) end
end

-- // ULTRA SAFE HOOK // --
local _oldNc
_oldNc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local _args = {...}
    local _method = getnamecallmethod()
    
    -- Essential: Check if it's a valid remote call
    if (_method == "FireServer" or _method == "InvokeServer") and self:IsA("RemoteEvent") or self:IsA("RemoteFunction") then
        
        -- Use pcall to prevent freezing the game if something goes wrong
        pcall(function()
            if self.Name:lower():find("upgrade") or self.Name:lower():find("craft") or self.Name:lower():find("nft") then
                
                -- Passive Spy (Does not block)
                if _spyOn then _log(self.Name, _args) end
                
                -- Conditional Modification
                if _upgOn then
                    for _, a in pairs(_args) do
                        if type(a) == "table" then
                            if rawget(a, "Chance") then a.Chance = 100 end
                            if rawget(a, "Success") ~= nil then a.Success = true end
                        end
                    end
                end
            end
        end)
    end
    
    -- ALWAYS return the original call to prevent UI freeze
    return _oldNc(self, unpack(_args))
end))

