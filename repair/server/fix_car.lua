local QBCore = exports['qb-core']:GetCoreObject()

-- Config
local repairCommand = "repair" -- Command to fix the car
local repairCost = 1000 -- Cost to repair the vehicle

-- Function to check if the vehicle is moving
local function isVehicleMoving(vehicle)
    local velocity = GetEntityVelocity(vehicle)
    local speed = math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y + velocity.z * velocity.z)
    return speed > 0.5 -- Consider the vehicle moving if its speed is greater than 0.5 units
end

-- Command to repair the car
QBCore.Commands.Add(repairCommand, "Fix your car for $1000", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerPed = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle and vehicle ~= 0 then
        if isVehicleMoving(vehicle) then
            TriggerClientEvent('QBCore:Notify', source, "Your vehicle must be stationary to use this command.", "error")
            return
        end

        -- Check if player has enough money
        if Player.Functions.RemoveMoney('cash', repairCost, "vehicle-repair") or Player.Functions.RemoveMoney('bank', repairCost, "vehicle-repair") then
            TriggerClientEvent('vehicle:client:repairVehicle', source) -- Trigger the client-side repair event
            TriggerClientEvent('QBCore:Notify', source, "Your vehicle has been repaired!", "success")
        else
            TriggerClientEvent('QBCore:Notify', source, "You don't have enough money to repair your vehicle.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You are not in a vehicle.", "error")
    end
end)
