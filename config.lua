Config = {}

Config.framework = 'qbx' -- supported: 'qb' or 'qbx'

Config.notify = 'ox' -- supported: 'qb' or 'ox'

Config.inventory = 'ox' -- supported: 'qb', 'ps', or 'ox' (QBCore Only)

Config.progress = {
    enabled = 'true', -- 'true' or 'false'

    type = 'ox', -- supported: 'qb' or 'ox'

    duration = 2500 -- How long, in ms, before the lockbox opens
}

Config.qbxProgress = {
    enabled = 'true',
    duration = 2500
}

Config.lockboxSlots = 5 -- Recommended Value, Could Be Higher or Lower Depending On Server Needs

Config.lockboxWeight = 120000 -- Recommended Value, Could Be Higher or Lower Depending On Server Needs

Config.leoJobs = {
    'police',
    'lssd',
    'bcso',
    'sasp',
    -- add your server's police job here as found in qb-core/shared/jobs.lua
}

Config.emsJobs = {
    'ambulance',
    -- add your server's ambulance job here as found in qb-core/shared/jobs.lua
}