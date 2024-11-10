local Ox = require '@ox_core/lib/init'
local Framework = {}

local groups = {}
if GetResourceState('oxmysql') then
    local res = exports.oxmysql.query_async(
        nil, 'SELECT `name`, `label` FROM ox_groups WHERE `type` = ?', {"job"}
    )
    for _, group in pairs(res) do
        groups[group.name] = group.label
    end
end

function Framework.GetPlayerData(source)
    local player = Ox.GetPlayer(source)

    if not player then return nil end

    local money = exports.ox_inventory:GetItemCount(source, 'money')
    local dirtyMoney = exports.ox_inventory:GetItemCount(source, 'black_money')

    local account = player.getAccount()

    local group = "Unemployed"
    local groupList = player.getGroups()

    local count = {}
    for k, _ in pairs(groupList) do
        if groups[k] then count[#count+1] = k end
    end

    local activeGroup = player.get('activeGroup')
    if groups[activeGroup] then
        group = groups[activeGroup]
    elseif #count >= 1 then
        group = groups[count[1]]
    end

    return {
        balance = account?.balance or 0,
        wallet = money,
        dirtyMoney = dirtyMoney,
        playerName = player.get('name'),
        jobName = group,
        sex = player.get('gender')
    }
end

return Framework