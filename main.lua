-- // Z-HUB V6.0 LITE (ANTI-LAG & STABLE)
-- // EDUCATIONAL PURPOSE ONLY
-- // NO RUSSIAN CHARACTERS IN CODE

local _cg = game:GetService("CoreGui")
local _uis = game:GetService("UserInputService")
local _lp = game:GetService("Players").LocalPlayer

-- Cleanup
if _cg:FindFirstChild("zHub_Lite") then _cg.zHub_Lite:Destroy() end

local _sg = Instance.new("ScreenGui", _cg)
_sg.Name = "zHub_Lite"

-- Simple Draggable
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

-- Minimalist Icon
local _ic = Instance.new("TextButton", _sg)
_ic.Size = UDim2.new(0, 50, 0, 50)
_ic.Position = UDim2.new(0, 10, 0.5, 0)
_ic.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_ic.Text = "Z"
_ic.TextColor3 = Color3.fromRGB(0, 255, 150)
_ic.Font = Enum.Font.GothamBold
Instance.new("UICorner", _ic).CornerRadius = UDim.new(1, 0)
_drag(_ic)

-- Main Frame
local _mf = Instance.new("Frame", _sg)
_mf.Size = UDim2.new(0, 220, 0, 150)
_mf.Position = UDim2.new(0.5, -110, 0.5, -75)
_mf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_mf.Visible = false
Instance.new("UICorner", _mf).CornerRadius = UDim.new(0, 10)
_drag(_mf)

-- Simple Spy Output (Floating Label)
local _spyBox = Instance.new("TextBox", _sg)
_spyBox.Size = UDim2.new(0, 300, 0, 100)
_spyBox.Position = UDim2.new(0.5, -150, 0.8, 0)
_spyBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_spyBox.TextColor3 = Color3.fromRGB(0, 255, 255)
_spyBox.TextSize = 12
_spyBox.ClearTextOnFocus = false
_spyBox.TextEditable = false
_spyBox.TextWrapped = true
_spyBox.Text = "Waiting for Remote..."
_spyBox.Visible = false
Instance.new("UICorner", _spyBox).CornerRadius = UDim.new(0, 5)
_drag(_spyBox)

local _upg = false
local _spy = false

local function _createBtn(txt, y, callback)
    local b = Instance.new("TextButton", _mf)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = txt .. ": OFF"
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    b.MouseButton1Click:Connect(function()
        local s = callback()
        b.Text = txt .. ": " .. (s and "ON" or "OFF")
        b.BackgroundColor3 = s and Color3.fromRGB(0, 100, 50) or Color3.fromRGB(30, 30, 30)
    end)
end

_createBtn("MOD LOGIC", 45, function() _upg = not _upg return _upg end)
_createBtn("SPY NETWORK", 90, function() _spy = not _spy _spyBox.Visible = _spy return _spy end)

_ic.MouseButton1Click:Connect(function() _mf.Visible = not _mf.Visible end)

-- // ULTRA LIGHTWEIGHT HOOK // --
local _old
_old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if (method == "FireServer" or method == "InvokeServer") then
        local name = tostring(self.Name)
        
        -- Check if it's related to the upgrade
        if name:lower():find("upgrade") or name:lower():find("craft") or name:lower():find("nft") then
            
            -- Minimal Spy Output
            if _spy then
                _spyBox.Text = "REMOTE: " .. name .. "\nARGS: " .. tostring(#args) .. " (check F9 console)"
                print("--- zHub Lite Spy ---")
                print("Remote Name:", name)
                for i, v in pairs(args) do print("Arg " .. i .. ":", v) end
            end

            -- Lite Logic Injection
            if _upg then
                for _, a in pairs(args) do
                    if type(a) == "table" then
                        if rawget(a, "Chance") then a.Chance = 100 end
                        if rawget(a, "Success") ~= nil then a.Success = true end
                    end
                end
            end
        end
    end
    return _old(self, unpack(args))
end))

