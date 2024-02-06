--[[

Program for Better Fusion Reactor PLUS by igentuman.

This program will include all the interface and logic control of the fusion reactor.

Additional commands: 

    .adjustReactivity()
    .getEfficiency()
    .getErrorLevel()

]]--


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


---@param currentEffi number Current Efficiency of the Fusion Reactor.
---@return number -- Returns number to have the sign decided for
function CRNum(currentEffi)
    
    local RNum = round((1 - currentEffi), 2) * 5 -- may need to change this multiple

    return RNum
end


---@class advancedFusionAPI
local advancedFusionAPI = {}


---@param port string String peripheral name of the Fusion Reactor Logic Port.
---@return table self Returns a tableto be used by advancedFusionAPI
function advancedFusionAPI.init(port, monitor)

    local self = setmetatable({}, advancedFusionAPI)

    self.port = port
    self.monitor = monitor
    self.lastEfficiency = 0
    self.lastSign = 1

    return self
end


---@param currentEffi number Current Efficiency of the Fusion Reactor.
---@return number -- Returns value for the Fusion reactor to be changed by.
function advancedFusionAPI:changeCR(currentEffi)
    
    local changeReactivity = CRNum(currentEffi)
    local changeEffi = self.lastEfficiency - currentEffi

    if changeEffi < 0 then
        
        changeReactivity = changeReactivity * (-1) * self.lastSign
        self.lastSign = (-1) * self.lastSign

    else

        changeReactivity = changeReactivity * self.lastSign

    end

    return changeReactivity
end


return advancedFusionAPI