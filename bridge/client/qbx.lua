if GetResourceState('qbx_core') ~= 'started' then return end

-- local Config = lib.require('config')

function qbxCheckValidPoliceJob()
    local currentJob = QBX.PlayerData.job
    if currentJob == nil then return false end
    for i, job in ipairs(Config.leoJobs) do
        if (currentJob.name == job) then
            return true
        end
    end
    return false
end

function qbxCheckValidAmbulanceJob()
    local currentJob = QBX.PlayerData.job
    if currentJob == nil then return false end
    for j, job in ipairs(Config.emsJobs) do
        if (currentJob.name == job) then
            return true
        end
    end
    return false
end