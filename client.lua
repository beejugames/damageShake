-- screen shake when taking damage

local ShakeIntensity = 0.2
local shakeWait = 50

function TakeDamage()
    local playerPed = GetPlayerPed(-1)

    if not IsEntityDead(playerPed) then
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", ShakeIntensity)
        Citizen.Wait(shakeWait)
        StopGameplayCamShaking(false)
    end
end

RegisterNetEvent("client:TakeDamage")
AddEventHandler("client:TakeDamage", function()
    TakeDamage()
end)

Citizen.CreateThread(function()
    local prevHealth = GetEntityHealth(GetPlayerPed(-1))
    while true do
        Citizen.Wait(0)

        local playerPed = GetPlayerPed(-1)
        local currentHealth = GetEntityHealth(playerPed)

        if prevHealth > currentHealth then
            prevHealth = currentHealth
            TriggerEvent('client:TakeDamage')
        else
            prevHealth = currentHealth
        end
    end
end)