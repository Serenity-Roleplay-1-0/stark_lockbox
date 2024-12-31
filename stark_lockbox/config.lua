Config = {}

Config.debug = 'false' -- true or false

Config.notify = 'qb' -- supported: 'qb' or 'ox'

Config.radial = 'ox' -- supported: 'qb' or 'ox' -- default 'ox'

Config.inventory = 'ox' -- supported: 'qb', 'ps', or 'ox'

Config.progress = {
    enabled = 'true', -- 'true' or 'false'

    type = 'ox', -- supported: 'qb' or 'ox'

    duration = 2500 -- How long, in ms, before the lockbox opens
}

Config.lockboxSlots = 5 -- Recommended Value, Could Be Higher or Lower Depending On Server Needs

Config.lockboxWeight = 120000 -- Recommended Value, Could Be Higher or Lower Depending On Server Needs

Config.leoJobs = {
    'police',
    'lssd',
    -- add your server's police job here as found in qb-core/shared/jobs.lua
}

Config.emsJobs = {
    'ambulance',
    -- add your server's ambulance job here as found in qb-core/shared/jobs.lua
}