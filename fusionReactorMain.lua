--[[

main script for the fusion reactor.

]]--

-- Varibles

    -- Name set

local logicPort     = "fusionReactorLogicAdapter_0" -- please find the peripheral name of the Fusion Reactor Port.
local monitorName   = "monitor" -- please find the peripheral name of the monitor.


local mekanismAPI   = require("mekanismFuisionAPI")
local interfaceAPI  = require("interface")
local advancedAPI   = nil

local fusionLogicPort  = peripheral.find(logicport)
local monitor          = peripheral.find(monitorName)

local advanced      = false
local monitorSize   = nil

if fs.exists("/Moduals/advancedFusionAPI.lua") then

    advancedAPI = require("advancedFusionAPI")
    advanced = true

end

monitorSize = interfaceAPI.Initialisation(monitor)

if advanced == false then



else



end

print("here")