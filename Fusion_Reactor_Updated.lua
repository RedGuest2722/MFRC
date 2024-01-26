--[[

main script for the fusion reactor.

]]--

-- Varibles

local AdvanceAPI = nil
local InterfaceAPI = nil

if fs.exists("/Moduals/AdvanceFuisionAPI.lua") then 
    AdvanceAPI = os.loadAPI("/Moduals/AdvanceFuisionAPI.lua")
end

if fs.exists("/Moduals/InterfaceAPI.lua") then
    InterfaceAPI = os.loadAPI("/Moduals/InterfaceAPI.lua")
end

local fusionLogicPort = peripheral.wrap("fusionReactorLogicAdapter_0")
local monitor         = peripheral.wrap("left")

