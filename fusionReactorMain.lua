--[[

main script for the fusion reactor.

]]--

-- Varibles

    -- Name set

local logicPort     = "fusionReactorLogicAdapter_0" -- please find the peripheral name of the Fusion Reactor Port.
local monitorName   = "monitor" -- please find the peripheral name of the monitor.


local mekanismAPI   = os.loadAPI("/Moduals/mekanismFuisionAPI.lua")
local interfaceAPI  = os.loadAPI("/Moduals/interface.lua")
local advancedAPI   = nil

local fusionLogicPort  = peripheral.find(logicport)
local monitor          = peripheral.find(monitorName)

local advanced      = false
local monitorSize   = nil

if fs.exists("/Moduals/advancedFusionAPI.lua") then

    advancedAPI = os.loadAPI("/Moduals/advancedFusionAPI.lua")
    advanced = true

end

monitorSize = interfaceAPI.Initialisation(monitor)

if advanced == false then

    reactorStatus = mekanismAPI.getData(fusionLogicPort)
    monitorSize = interfaceAPI.initialisation(monitor, reactorStatus[5][1])

    while true do

        --

    end

else

    --

end

print("here")