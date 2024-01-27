--[[

main script for the fusion reactor.

]]--

-- Varibles

    -- Name set

local logicPort     = "fusionReactorLogicAdapter_0" -- please find the peripheral name of the Fusion Reactor Port.
local monitorName   = "monitor_0" -- please find the peripheral name of the monitor.


local mekanismAPI   = os.loadAPI("/Moduals/mekanismFusionAPI.lua")
local interfaceAPI  = os.loadAPI("/Moduals/interfaceAPI.lua")
local advancedAPI   = nil

local fusionLogicPort   = peripheral.wrap(logicport)
local monitor           = peripheral.wrap(monitorName)

local advanced      = false
local monitorSize   = nil
local reactorStatus = nil

if fs.exists("/Moduals/advancedFusionAPI.lua") then

    advancedAPI = os.loadAPI("/Moduals/advancedFusionAPI.lua")
    advanced = true

end


reactorStatus = mekanismAPI.getData(fusionLogicPort)
monitorSize = interfaceAPI.initialisation(monitor, reactorStatus[5][1])


if advanced == false then

    while true do

        reactorStatus = mekanismAPI.getData(fusionLogicPort)
        interfaceAPI.redrawBars(monitor, monitorSize, reactorStatus)
        interfaceAPI.time(monitor, monitorSize)
        os.sleep(0.05)

    end

else

    while true do

        reactorStatus = mekanismAPI.getData(fusionLogicPort)
        interfaceAPI.redrawBars(monitor, monitorSize, reactorStatus)
        interfaceAPI.time(monitor, monitorSize)
        os.sleep(0.05)

    end
end

print("here")