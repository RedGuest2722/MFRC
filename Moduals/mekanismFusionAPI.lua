--[[

this runs some commands for the main script

]]--

local mekanismFusionAPI = {}

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

function getData(port)

    local plasmaTemp = port.getPlasmaTemperature()
    local PlasmaMax  = port.getMaxPlasmaTemperature(true)
    
    local plasma = (plasmaTemp / PlasmaMax)


    local caseTemp = port.getCaseTemperature()
    local caseMax  = port.getMaxCasingTemperature(true)

    local case = (caseTemp / caseMax)


    local water = port.getWaterFilledPercentage()
    local steam = port.getSteamFilledPercentage()


    local DTfuel    = port.getDTFuelFilledPercentage()
    local tritium   = port.getTritiumFilledPercentage()
    local deutirium = port.getDeuteriumFilledPercentage()
    
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

function setInjectionRate(port, value)

    port.setInjectionRate(setRate)

end

function getBasicData(port)

    local hohlraum = false
    local powerGenStr = nil

    local powerGen = port.getPassiveGeneration(false)/10

    if powerGen > 10^(9) then

        powerGenStr = tostring(round(powerGen), -9) .. " GFE"

    elseif powerGen > 10^(6) then

        powerGenStr = tostring(round(powerGen, -6)) .. " MFE"

    elseif powerGen > 10^(3) then

        powerGenStr = tostring(round(powerGen, -3)) .. " kFE"

    elseif powerGen > 10^(0) then

        powerGenStr = tostring(round(powerGen, 0)) .. " FE"

    else

        powerGenStr = "0 FE"

    end

    local injRate = port.getInjectionRate()

    local hohlraumNum = port.getHohlraum()[1]

    if hohlraumNum == 1 then

        hohlraum = true

    end

    return {hohlraum, powerGenStr, injRate}
end