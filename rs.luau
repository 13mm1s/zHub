-- Шпион для перехвата данных от сервера
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Функция для прослушивания всех RemoteEvent'ов
local function spyOnRemote(remote)
    if remote:IsA("RemoteEvent") then
        remote.OnClientEvent:Connect(function(...)
            local args = {...}
            print("--- ПЕРЕХВАТ СОБЫТИЯ: " .. remote.Name .. " ---")
            for i, v in pairs(args) do
                print("Аргумент " .. i .. ": " .. tostring(v))
            end
        end)
    end
end

-- Сканируем ReplicatedStorage на наличие событий
for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
    spyOnRemote(obj)
end

