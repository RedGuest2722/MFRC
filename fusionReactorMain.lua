--[[

main script for the fusion reactor.

]]--

-- Varibles

    -- Name set

                                                    -- if they area a side please specify that
local logicPort     = "fusionReactorLogicAdapter_0" -- please find the peripheral name of the Fusion Reactor Port.
local monitorName   = "monitor_4"                        -- please find the peripheral name of the monitor.


local mekanismAPI = require("Moduals.mekanismFusionAPI")
local interfaceAPI = require("Moduals.interfaceAPI")
local advancedAPI = nil

local fusionLogicPort = peripheral.wrap(logicPort)
local monitor         = peripheral.wrap(monitorName)

local advanced      = false
local monitorSize   = nil
local reactorStatus = nil

if fs.exists("/Moduals/advancedFusionAPI.lua") then

    advancedAPI= require("Moduals.advancedFusionAPI")
    advanced = true

end

term.clear()

local reactorStatus = mekanismAPI.getData(fusionLogicPort)
local monitorSize, tankSize = interfaceAPI.initialisation(monitor, reactorStatus[5][1], advanced)


if advanced then

    while true do

        reactorStatus = mekanismAPI.getData(fusionLogicPort)
        mekanismStat = mekanismAPI.getBasicData(fusionLogicPort)
        interfaceAPI.redrawBars(monitor, monitorSize, tankSize, reactorStatus)
        interfaceAPI.updateText(monitor, maxSize, mekanismStat)
        interfaceAPI.time(monitor, monitorSize)
        os.sleep(0.05)

    end

else

    while true do

        reactorStatus = mekanismAPI.getData(fusionLogicPort)
        mekanismStat = mekanismAPI.getBasicData(fusionLogicPort)
        interfaceAPI.redrawBars(monitor, monitorSize, tankSize, reactorStatus)
        interfaceAPI.updateText(monitor, maxSize, mekanismStat)
        interfaceAPI.time(monitor, monitorSize)
        os.sleep(0.05)

    end
end