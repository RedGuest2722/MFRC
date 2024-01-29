--[[

main script for the fusion reactor.

]]--



-- Varibles

    -- Name set

                                                    -- if they area a side please specify that
local logicPort     = "fusionReactorLogicAdapter_0" -- please find the peripheral name of the Fusion Reactor Port.
local monitorName   = "monitor_4"                   -- please find the peripheral name of the monitor.


local mekanismAPI = require("Moduals.mekanismFusionAPI")
local interfaceAPI = require("Moduals.interfaceAPI")
local advancedAPI = nil

local fusionLogicPort = peripheral.wrap(logicPort)
local monitor         = peripheral.wrap(monitorName)

local advanced      = false
local mekanismStat  = nil
local reactorStatus = {}

if fs.exists("/Moduals/advancedFusionAPI.lua") then

    advancedAPI = require("Moduals.advancedFusionAPI")
    advanced = true

end

term.clear()

local DTFuel = mekanismAPI.init(fusionLogicPort)
      interfaceAPI.init(monitor, DTFuel, advanced)


if advanced then

    while true do

        reactorStatus = mekanismAPI:getData()
        mekanismStat = mekanismAPI:getBasicData()
        interfaceAPI:redrawBars(reactorStatus)
        interfaceAPI:updateText(mekanismStat)
        interfaceAPI:time()
        os.sleep(0.05)

    end

else

    while true do

        reactorStatus = mekanismAPI:getData()
        mekanismStat = mekanismAPI:getBasicData()
        interfaceAPI:redrawBars(reactorStatus)
        interfaceAPI:updateText(mekanismStat)
        interfaceAPI:time()
        os.sleep(0.05)

    end
end