-- local Config = lib.require('config')

if Config.framework == 'qb' then

    local QBCore = exports['qb-core']:GetCoreObject()

    local function addRadialLeoLockboxOption()
        local player = PlayerPedId()
        MenuItemId = exports['qb-radialmenu']:AddOption({
            id = 'open_lock_box',
            title = 'Open Lockbox',
            icon = 'lock',
            type = 'client',
            event = 'stark_lockbox:client:openLockBox',
            shouldClose = true
        }, MenuItemId)
    end

    local function updateRadial()
        local player = PlayerPedId()
        if qbCheckValidPoliceJob() or qbCheckValidAmbulanceJob() then
            if IsPedInAnyVehicle(player, false) then
                local vehicle = GetVehiclePedIsIn(player, false)
                local vehicleType = GetVehicleClass(vehicle)
                if vehicleType == 18 then
                    addRadialLeoLockboxOption()
                elseif MenuItemId ~= nil then
                    exports['qb-radialmenu']:RemoveOption(MenuItemId)
                    MenuItemId = nil
                end
            elseif MenuItemId ~= nil then
                exports['qb-radialmenu']:RemoveOption(MenuItemId)
                MenuItemId = nil
            end
        elseif MenuItemId ~= nil then
            exports['qb-radialmenu']:RemoveOption(MenuItemId)
            MenuItemId = nil
        end
    end

    RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
        updateRadial()
    end)

    function openLockBoxInventory()

        local Vehicle = GetVehiclePedIsIn(player, false)
        local id = GetVehicleNumberPlateText(Vehicle)

        if Config.inventory == 'qb' then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "DPS Lockbox " .. id, {
                maxweight = Config.lockboxWeight,
                slots = Config.lockboxSlots
            })
            TriggerEvent("inventory:client:SetCurrentStash", "DPS Lockbox " .. id)

        elseif Config.inventory == 'ps' then
            TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", "DPS Lockbox " .. id {
                maxweight = Config.lockboxWeight,
                slots = Config.lockboxSlots
            })
            TriggerEvent("ps-inventory:client:SetCurrentStash", "DPS Lockbox " ..  id)

        elseif Config.inventory == 'ox' then
            local ox_inventory = exports.ox_inventory
            ox_inventory:openInventory('stash', 'dps_lockbox')

        else
            if Config.notify == 'qb' then
                QBCore.Functions.Notify("Your inventory script is not currently supported!", 'error', 5000)
            elseif Config.notify == 'ox' then
                lib.notify({
                    description = 'Your inventory script is not currently supported!',
                    duration = 5000,
                    position = 'top-right',
                    type = 'error',
                })
            end
        end
    end

    RegisterNetEvent('stark_lockbox:client:openLockBox', function()
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleType = GetVehicleClass(vehicle)
            if vehicleType == 18 then
                if qbCheckValidPoliceJob() or qbCheckValidAmbulanceJob() then
                    if Config.progress.enabled == 'true' then

                        if Config.progress.type == 'qb' then

                            QBCore.Functions.Progressbar("open_lock_box", "Opening Lockbox...", Config.progress.duration, false,
                            true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true
                            }, {}, {}, {}, function()
                                openLockBoxInventory()
                            end, function()
                                if Config.notify == 'qb' then
                                    QBCore.Functions.Notify("Cancelled Opening Lockbox!", 'error', 5000)
                                elseif Config.notify == 'ox' then
                                    lib.notify({
                                        description = 'Cancelled Opening Lockbox!',
                                        duration = 5000,
                                        position = 'top-right',
                                        type = 'error',
                                    })
                                end
                            end)

                        elseif Config.progress.type == 'ox' then

                            -- Customizable: lib.progressBar or lib.progressCircle
                            if lib.progressCircle({
                                duration = Config.progress.duration,
                                position = 'bottom',
                                label = 'Opening Lockbox...',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    car = true,
                                    mouse = false,
                                    combat = true
                                }
                            }) then openLockBoxInventory()
                            end

                        end

                    else
                        -- Progress Not Enabled
                        openLockBoxInventory()
                    end

                else
                    -- Fails One or Both Job Check(s)
                    if Config.notify == 'qb' then
                        QBCore.Functions.Notify("You do not have the correct job!", 'error', 5000)
                    elseif Config.notify == 'ox' then
                        lib.notify({
                            description = 'You do not have the correct job!',
                            duration = 5000,
                            position = 'top-right',
                            type = 'error',
                        })
                    end
                end

            else
                -- Fails Emergency Vehicle Check
                if Config.notify == 'qb' then
                    QBCore.Functions.Notify("You're not in an emergency vehicle!", 'error', 5000)
                elseif Config.notify == 'ox' then
                    lib.notify({
                        description = 'You\'re not in an emergency vehicle!',
                        duration = 5000,
                        position = 'top-right',
                        type = 'error',
                    })
                end
            end

        else
            -- Fails IsPedInAnyVehicle() Check
            if Config.notify == 'qb' then
                QBCore.Functions.Notify("You're not currently in any vehicle!", 'error', 5000)
            elseif Config.notify == 'ox' then
                lib.notify({
                    description = 'You\'re not currently in any vehicle!',
                    duration = 5000,
                    position = 'top-right',
                    type = 'error',
                })
            end
        end

    end)

end

if Config.framework == 'qbx' then

    -- local function addRadialLeoLockboxOption()
    --     local player = PlayerPedId()
    --     MenuItemId = exports['qb-radialmenu']:addOption({
    --         id = 'open_lock_box',
    --         title = 'Open Lockbox',
    --         icon = 'lock',
    --         type = 'client',
    --         event = 'stark_lockbox:client:openLockBox',
    --         shouldClose = true
    --     }, MenuItemId)
    -- end

    -- local function updateRadial()
    --     local player = PlayerPedId()
    --     if qbxCheckValidPoliceJob() or qbxCheckValidAmbulanceJob() then
    --         if IsPedInAnyVehicle(player, false) then
    --             local vehicle = GetVehiclePedIsIn(player, false)
    --             local vehicleType = GetVehicleClass(vehicle)
    --             if vehicleType == 18 then
    --                 addRadialLeoLockboxOption()
    --             elseif MenuItemId ~= nil then
    --                 exports['qb-radialmenu']:removeOption(MenuItemId)
    --                 MenuItemId = nil
    --             end
    --         elseif MenuItemId ~= nil then
    --             exports['qb-radialmenu']:removeOption(MenuItemId)
    --             MenuItemId = nil
    --         end
    --     elseif MenuItemId ~= nil then
    --         exports['qb-radialmenu']:removeOption(MenuItemId)
    --         MenuItemId = nil
    --     end
    -- end

    -- RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    --     updateRadial()
    -- end)

    function openLockBoxInventory()

        if GetResourceState('ox_inventory') ~= 'started' then
            lib.notify({
                description = 'Ox Inventory was not started correctly!',
                duration = 5000,
                position = 'top-right',
                type = 'error',
            })
        else
            local ox_inventory = exports.ox_inventory
            ox_inventory:openInventory('stash', 'dps_lockbox')
        end

    end

    RegisterNetEvent('stark_lockbox:client:openLockBox', function()
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleType = GetVehicleClass(vehicle)
            if vehicleType == 18 then
                if qbxCheckValidPoliceJob() or qbxCheckValidAmbulanceJob() then
                    if Config.qbxProgress.enabled == 'true' then

                        -- Customizable: lib.progressBar or lib.progressCircle
                        if lib.progressCircle({
                            duration = Config.qbxProgress.duration,
                            position = 'bottom',
                            label = 'Opening Lockbox...',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                mouse = false,
                                combat = true
                            }
                        }) then openLockBoxInventory()
                        end
                    else
                        -- Progress Not Enabled
                        openLockBoxInventory()
                    end
                else
                    -- Fails One or Both Job Check(s)
                    lib.notify({
                        description = 'You do not have the correct job!',
                        duration = 5000,
                        position = 'top-right',
                        type = 'error',
                    })
                end
            else
                -- Fails Emergency Vehicle Check
                lib.notify({
                    description = 'You\'re not in an emergency vehicle!',
                    duration = 5000,
                    position = 'top-right',
                    type = 'error',
                })
            end
        else
            -- Fails IsPedInAnyVehicle() Check
            lib.notify({
                description = 'You\'re not currently in any vehicle!',
                duration = 5000,
                position = 'top-right',
                type = 'error',
            })
        end
    end)

end