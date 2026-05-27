local lp = game:GetService("Players").LocalPlayer

-- UI не трогаю, только логика перехвата
local function log(msg)
    print("zHub Spy: " .. tostring(msg))
end

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    
    if method == "FireServer" or method == "InvokeServer" or method == "fireServer" then
        log("NAME: " .. self.Name .. " | CLASS: " .. self.ClassName)
    end
    
    return old(self, ...)
end)

setreadonly(mt, true)
log("Spy Active. Press Upgrade in game.")

