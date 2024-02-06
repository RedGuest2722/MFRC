--[[

this runs some commands for the main script

]]--


---@param num number Number for rounding.
---@param decimalPlace integer Number of decimal places.
---@return number -- Returns rounded number
---@nodiscard
local function round(num, decimalPlace) -- Rounds number values to specified number of decimal places.

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

---@class mekanismFusionAPI

local mekanismFusionAPI = {}


---@param port string String peripheral name of the Fusion Reactor Logic Port.
---@param advanced boolean 
---@return boolean DTHere Returns true if DT Fuel is used by Fusion Reactor.
---@return table self Returns a table to be used by interfaceAPI.
function mekanismFusionAPI.init(port, advanced)

    local DTHere = false
    local self = setmetatable({}, mekanismFusionAPI) -- Meta table to be used by mekanismFusionAPI.

    self.port = port
    self.advanced = advanced

    DTPerc = port.getDTFuelFilledPercentage()

    if DTPerc > 0 then
        
        DTHere = true

    end

    return DTHere, self
end


---@return table -- Returns percents in table to be used
function mekanismFusionAPI:getData() -- Gets data from Fusion Logic port

    local plasmaTemp = self.port.getPlasmaTemperature()
    local PlasmaMax  = self.port.getMaxPlasmaTemperature(true)
    
    local plasma = (plasmaTemp / PlasmaMax)


    local caseTemp = self.port.getCaseTemperature()
    local caseMax  = self.port.getMaxCasingTemperature(true)

    local case = (caseTemp / caseMax)


    local water = self.port.getWaterFilledPercentage()
    local steam = self.port.getSteamFilledPercentage()


    local DTfuel    = self.port.getDTFuelFilledPercentage()
    local tritium   = self.port.getTritiumFilledPercentage()
    local deutirium = self.port.getDeuteriumFilledPercentage()
    
    local fuel = {DTfuel, tritium, deutirium} 

    local percents = {plasma, case, water, steam, fuel}

    for i in ipairs(percents) do

        if i == 5 then

            for o in ipairs(percents[5]) do

                if percents[5][o] > 1 then

                    percents[5][o] = 1
                
                end
            end

        else

            if percents[i] > 1 then

                percents[i] = 1
            
            end    
        end
    end

    return percents  
end


---@param value integer This value should be even and the value to set the injection rate to.
function mekanismFusionAPI:setInjectionRate(value)

    self.port.setInjectionRate(value)

end


---@return table -- Returns a table for values used by top right of the moitor.
function mekanismFusionAPI:getBasicData() -- Gets data used by the top right of the monitor.

    local hohlraum = false
    local powerGenStr = nil

    local powerGen = self.port.getPassiveGeneration(false)/10

    if powerGen > 10^(9) then

        powerGenStr = tostring(round(powerGen, -9)) .. " GFE"

    elseif powerGen > 10^(6) then

        powerGenStr = tostring(round(powerGen, -6)) .. " MFE"

    elseif powerGen > 10^(3) then

        powerGenStr = tostring(round(powerGen, -3)) .. " kFE"

    elseif powerGen > 10^(0) then

        powerGenStr = tostring(round(powerGen, 0)) .. " FE"

    else

        powerGenStr = "N/A or 0 FE"

    end

    local injRate = self.port.getInjectionRate()

    local hohlraumNum = self.port.getHohlraum()[1]

    if hohlraumNum == 1 then

        hohlraum = true

    end

    return {hohlraum, powerGenStr, injRate}
end


---@return table -- Returns current efficiency and error rate rounded to 2 d.p.
function mekanismFusionAPI:getAdvancedData()

    local efficiency = self.port.getEfficiency()
    local errorRate = self.port.getErrorLevel()

    return {round(efficiency, 2), round(errorRate, 2)}
end

---@param value number to change reactivity by
function mekanismFusionAPI:changeReactivity(value)
    
    self.port.adjustReactivity(value)

end

return mekanismFusionAPI
