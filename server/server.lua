

lib.callback.register('krs_pausemenu:getPlayerData', function(source)
    local function getESXPlayerData(source)
        local ESX = GetResourceState('es_extended'):find('start') and exports['es_extended']:getSharedObject() or nil
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return nil, 'Player not found with source ID ' .. source end

        return {
            balance = xPlayer.getAccount("bank").money,
            wallet = xPlayer.getAccount("money").money,
            dirtyMoney = xPlayer.getAccount("black_money").money,
            playerName = xPlayer.getName(),
            jobName = xPlayer.job.name,
            sex = xPlayer.get('sex') and "male" or "female"
        }
    end

    local function getQBXPlayerData(source)
        local Player = exports.qbx_core:GetPlayer(source)
        if not Player then return nil, 'Player not found with source ID ' .. source end
        local firstName = Player.PlayerData.charinfo.firstname or 'Firstname'
        local lastName = Player.PlayerData.charinfo.lastname or 'Lastname'
        local playerName = firstName .. ' ' .. lastName  
        local dirtyMoney = exports.ox_inventory:Search(source, 'count', 'black_money')
        local wallet = exports.ox_inventory:Search(source, 'count', 'money')

        return {
            balance = Player.Functions.GetMoney('bank'),
            wallet = wallet,
            dirtyMoney = dirtyMoney,
            playerName = playerName,
            jobName = Player.PlayerData.job.name,
            sex = Player.PlayerData.charinfo.gender == 0 and "male" or "female"
        }
    end

    if ESX then
        local data, err = getESXPlayerData(source)
        if not data then
            print(err)
            return nil
        end
        return data
    elseif exports.qbx_core then
        local data, err = getQBXPlayerData(source)
        if not data then
            print(err)
            return nil
        end
        return data
    else
        print('Error: No compatible framework detected.')
        return nil
    end
end)

RegisterNetEvent("krs_pausemenu:exitGame", function()
    local player = source
    DropPlayer(player, '[Krs Scripts │ \nGoodbye!]')
end)