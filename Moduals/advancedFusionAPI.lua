--[[

Program for Better Fusion Reactor by igentuman.

This program will include all the interface and logic control of the fusion reactor.

Additional commands: 

    .adjustReactivity()
    .getEfficiency()
    .getErrorLevel()

]]--

local interfaceAPI = require("interfaceAPI")
local mekanismAPI = require("mekanismFusionAPI")

---@param num number Number for rounding.
---@param decimalPlace integer Number of decimal places.
---@return number -- Returns rounded number
---@nodiscard
local function round(num, decimalPlace)

    local numDec = (num * 10^(decimalPlace))

    local numWhole = math.floor(numDec)
    local numDecimal = (numDec - numWhole)
    local numRound = nil

    if numDecimal < 0.5 then

        numRound = math.floor(numDec)

    else

        numRound = math.ceil(numDec)

    end

    return (numRound / 10^(decimalPlace))
end

---@class advancedFusionAPI
local advancedFusionAPI = {}


---@param port string String peripheral name of the Fusion Reactor Logic Port.
---@return table self Returns a tableto be used by advancedFusionAPI
---@return table interfaceAPI_table Returns table from interfaceAPI
function advancedFusionAPI.init(port, monitor)

    local interfaceAPI_table = interfaceAPI.init(monitor, false, false)

    local self = setmetatable({}, advancedFusionAPI)

    self.port = port
    self.monitor = monitor

    return self, interfaceAPI_table
end

function advancedFusionAPI:changeCR()
    


end


return advancedFusionAPI