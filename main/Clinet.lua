ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


if config.debug then 
    print("Clinet.lua loaded")
end


Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local playerPed = PlayerPedId()
      local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
      
      
      if DoesEntityExist(vehicle) then
        local model = GetEntityModel(vehicle)
        if IsVehicleInArray(model, config.policeVehicles) then
          if ESX.PlayerData.job.name ~= config.JobNameCanSitOnCarOnList then
            ESX.ShowNotification(config.Mesg)
            ClearPedTasksImmediately(playerPed)
          end
        end
      end
    end
  end)

  function IsVehicleInArray(model, array)
    for i=1, #array do
      if GetHashKey(array[i]) == model then
        return true
      end
    end
    return false
  end

  
  
  