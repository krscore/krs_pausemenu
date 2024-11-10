local ESX = exports['es_extended']:getSharedObject()
local Framework = {}

function Framework.GetPlayerData(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return nil end

    return {
        balance = xPlayer.getAccount("bank").money,
        wallet = xPlayer.getAccount("money").money,
        dirtyMoney = xPlayer.getAccount("black_money").money,
        playerName = xPlayer.getName(),
        jobName = xPlayer.job.name,
        sex = xPlayer.get('sex')
    }
end

return Framework