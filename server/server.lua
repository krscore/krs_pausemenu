local Framework
if GetResourceState('es_extended') == 'started' then
    Framework = require 'server.bridge.esx'
elseif GetResourceState('ox_core') == 'started' then
    Framework = require 'server.bridge.ox'
end


lib.callback.register('krs_pausemenu:getPlayerData', function(source)
    local data = Framework.GetPlayerData(source)

    if not data then
        print('Error: Player not found with source ID ' .. source)
        return nil
    end

    return data
end)

RegisterNetEvent("krs_pausemenu:exitGame", function()
    local player = source
    DropPlayer(player, '[Krs Scripts │ \nGoodbye!]')
end)