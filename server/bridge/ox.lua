local Ox = require '@ox_core/lib/init'
local Framework = {}

function Framework.GetPlayerData(source)
    local player = Ox.GetPlayer(source)

    if not player then return nil end

    local money = exports.ox_inventory:GetItemCount(source, 'money')
    local dirtyMoney = exports.ox_inventory:GetItemCount(source, 'black_money')

    local account = player.getAccount()

    return {
        balance = account?.balance or 0,
        wallet = money,
        dirtyMoney = dirtyMoney,
        playerName = player.get('name'),
        jobName = player.get('activeGroup') or "No active group",
        sex = player.get('gender')
    }
end

return Framework