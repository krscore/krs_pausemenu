local pauseMenuActive = false

local function openPauseMenu()
    TriggerEvent('ox_inventory:closeInventory')
    local data = lib.callback.await('krs_pausemenu:getPlayerData', 100)
    if data then
        print('Received data: ', json.encode(data))
        SendNUIMessage({
            action = 'openPauseMenu',
            balance = data.balance,
            wallet = data.wallet,
            dirtyMoney = data.dirtyMoney,
            playerName = data.playerName,
            jobName = data.jobName,
            sex = data.sex
        })
        SetNuiFocus(true, true)
        TriggerScreenblurFadeIn(0)
        pauseMenuActive = true
    end
end

RegisterNUICallback('close', function(data)
    TriggerScreenblurFadeOut(0)
    SetNuiFocus(false, false)
    pauseMenuActive = false
end)

local function updatePauseMenu()
    while true do
        Wait(0)
        if pauseMenuActive then
            DisableControlAction(1, 200, true) 
            if IsPauseMenuActive() then
                TriggerScreenblurFadeOut(0)
                pauseMenuActive = false
            end
        end
    end
end

CreateThread(updatePauseMenu)

lib.addKeybind({
    name = 'PauseMenu',
    description = 'Toggle Pause Menu',
    defaultKey = 'ESCAPE',
    onPressed = function()
        if not pauseMenuActive then
            openPauseMenu()
        end
    end
})

RegisterNUICallback('map', function(data, cb)
    ActivateFrontendMenu("FE_MENU_VERSION_MP_PAUSE", true, -1)
    while not IsPauseMenuActive() do Wait(0) end
    PauseMenuceptionGoDeeper(0)
    PauseMenuceptionTheKick()
    SetNuiFocus(false, false)
    pauseMenuActive = false
    cb('ok')
end)

RegisterNUICallback('settings', function(data, cb)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
    SetNuiFocus(false, false)
    pauseMenuActive = false
    cb('ok')
end)

RegisterNUICallback('logout', function(data, cb)
    TriggerServerEvent("krs_pausemenu:exitGame")
    SetNuiFocus(false, false)
    pauseMenuActive = false
    cb('ok')
end)

RegisterNUICallback('relog', function(data, cb)
    ExecuteCommand('relog')
    TriggerScreenblurFadeOut(0)
    SetNuiFocus(false, false)
    pauseMenuActive = false
    cb('ok')
end)
