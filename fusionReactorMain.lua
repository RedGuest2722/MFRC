--[[

main script for the fusion reactor.

]]--

-- Varibles

    -- Name set

                                                    -- if they area a side please specify that
local logicPort     = "fusionReactorLogicAdapter_0" -- please find the peripheral name of the Fusion Reactor Port.
local monitorName   = "left"                        -- please find the peripheral name of the monitor.


os.loadAPI("/Moduals/mekanismFusionAPI.lua")
os.loadAPI("/Moduals/interfaceAPI.lua")

local fusionLogicPort = peripheral.wrap(logicPort)
local monitor         = peripheral.wrap(monitorName)

local advanced      = false
local monitorSize   = nil
local reactorStatus = nil

if fs.exists("/Moduals/advancedFusionAPI.lua") then

    os.loadAPI("/Moduals/advancedFusionAPI.lua")
    advanced = true

end


local reactorStatus = mekanismFusionAPI.getData(fusionLogicPort)
local monitorSize, tankSize = interfaceAPI.initialisation(monitor, reactorStatus[5][1])


if advanced == false then

    while true do

        reactorStatus = mekanismFusionAPI.getData(fusionLogicPort)
        interfaceAPI.redrawBars(monitor, monitorSize, tankSize, reactorStatus)
        interfaceAPI.time(monitor, monitorSize)
        os.sleep(0.05)

    end

else

    while true do

        reactorStatus = mekanismFusionAPI.getData(fusionLogicPort)
        interfaceAPI.redrawBars(monitor, monitorSize, tankSize, reactorStatus)
        interfaceAPI.time(monitor, monitorSize)
        os.sleep(0.05)

    end
end