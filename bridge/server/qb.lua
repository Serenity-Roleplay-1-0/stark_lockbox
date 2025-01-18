if GetResourceState('qb-core') ~= 'started' or GetResourceState('qbx_core') == 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

-- local Config = lib.require('config')

local oxInvState = GetResourceState('ox_inventory')

local ox_inventory = exports.ox_inventory

if Config.inventory == 'ox' and oxInvState == 'started' then
    local lockbox = {
        id = 'dps_lockbox',
        label = 'DPS Lockbox',
        slots = Config.lockboxSlots,
        weight = Config.lockboxWeight,
        owner = true,
    }

    AddEventHandler('onServerResourceStart', function(resourceName)
        if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
            ox_inventory:RegisterStash(lockbox.id, lockbox.label, lockbox.slots, lockbox.weight, lockbox.owner)
        end
    end)
end

QBCore.Commands.Add("lockbox", "Opens The Secured Vehicle Lockbox", {}, false, function(source)
    TriggerClientEvent('stark_lockbox:client:openLockBox', source)
end)