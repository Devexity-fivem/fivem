RegisterNetEvent('vehicle:client:repairVehicle')
AddEventHandler('vehicle:client:repairVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle and vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehiclePetrolTankHealth(vehicle, 1000.0)
        TriggerEvent('QBCore:Notify', "Your vehicle has been repaired!", "success")
    else
        TriggerEvent('QBCore:Notify', "You are not in a vehicle.", "error")
    end
end)
