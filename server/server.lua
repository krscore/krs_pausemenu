
lib.callback.register('krs_pausemenu:getPlayerData', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print('Error: Player not found with source ID ' .. source)
        return nil
    end

    local data = {
        balance = xPlayer.getAccount("bank").money,
        wallet = xPlayer.getAccount("money").money,
        dirtyMoney = xPlayer.getAccount("black_money").money,
        playerName = xPlayer.getName(),
        jobName = xPlayer.job.name,
        sex = xPlayer.get('sex') 
    }

    return data
end)

RegisterNetEvent("krs_pausemenu:exitGame", function()
    local player = source
    DropPlayer(player, '[Krs Scripts │ \nGoodbye!]')
end)