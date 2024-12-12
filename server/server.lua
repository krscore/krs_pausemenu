

lib.callback.register('krs_pausemenu:getPlayerData', function(source)
    local function getESXPlayerData(source)
        local ESX = exports.es_extended:getSharedObject()
        if not ESX then return nil, 'ESX non avviato' end
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return nil, 'Player non trovato in ESX con ID ' .. source end
        local dirtyMoney = exports.ox_inventory:Search(source, 'count', 'black_money')
        local wallet = exports.ox_inventory:Search(source, 'count', 'money')

        return {
            balance = xPlayer.getAccount("bank").money,
            wallet = wallet,
            dirtyMoney = dirtyMoney,
            playerName = xPlayer.getName(),
            jobName = xPlayer.job.name,
            sex = xPlayer.get('sex') and "male" or "female"
        }
    end

    local function getQBXPlayerData(source)
        local Player = exports.qbx_core:GetPlayer(source)
        if not Player then return nil, 'Player non trovato in QBX con ID ' .. source end
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

    if GetResourceState('es_extended'):find('start') then
        local data, err = getESXPlayerData(source)
        if not data then
            print(err)
            return nil
        end
        return data
    elseif GetResourceState('qbx_core'):find('start') then
        local data, err = getQBXPlayerData(source)
        if not data then
            print(err)
            return nil
        end
        return data
    else
        print('Errore: Nessun framework compatibile rilevato.')
        return nil
    end
end)

RegisterNetEvent("krs_pausemenu:exitGame", function()
    local player = source
    DropPlayer(player, '[Krs Scripts │ \nGoodbye!]')
end)
