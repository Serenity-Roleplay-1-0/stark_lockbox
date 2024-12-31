local QBCore = exports['qb-core']:GetCoreObject()

-- The Following Methods Are For Debugging Purposes
local qbRadialState = GetResourceState('qb-radialmenu')
local oxLibState = GetResourceState('ox_lib')

local qbInvState = GetResourceState('qb-inventory')
local psInvState = GetResourceState('ps-inventory')
local oxInvState = GetResourceState('ox_inventory')

if Config.debug == 'true' then

    if Config.radial == 'qb' and qbRadialState == 'started' then
        print("qb-radialmenu was started succesfully!")
    elseif Config.radial == 'ox' and oxLibState == 'started' then
        print("ox_lib was started succesfully!")
    elseif Config.inventory == 'qb' and qbInvState == 'started' then
        print("qb-inventory was started succesfully!")
    elseif Config.inventory == 'ps' and psInvState == 'started' then
        print("ps-inventory was started succesfully!")
    elseif Config.inventory == 'ox' and oxInvState == 'started' then
        print("ox_inventory was started succesfully!")
    else
        print("One or more resources are missing/not started!")
    end

end

local ox_inventory = exports.ox_inventory

if Config.inventory == 'ox' and oxInvState == 'started' then

    -- Define Stash
    local lockbox = {
        id = 'leo_lockbox', -- Unique Name to ID stash in Database
        label = 'LEO Lockbox', -- Display Name
        slots = Config.lockboxSlots, -- User Defined Slots
        weight = Config.lockboxWeight, -- User Defined Weight
        owner = true, -- Gives each player their own unique stash
    }

    -- Sets Up The Custom Stash Outside of the Ox Inventory Resource
    AddEventHandler('onServerResourceStart', function(resourceName)
        if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
            ox_inventory:RegisterStash(lockbox.id, lockbox.label, lockbox.slots, lockbox.weight, lockbox.owner)
        end
    end)

end

-- Additonal Method To Open The Lockbox
QBCore.Commands.Add("lockbox", "Opens The Secured LEO Lockbox (LEOs Only)", {}, false, function(source)
    TriggerClientEvent('stark_lockbox:client:openLockBox', source)
end)

lib.versionCheck('AdamaStarkN7/stark_lockbox')