--[[

this runs some commands for the main script

]]--

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

            percents[i] = 1

        end
    end

    return percents 
    
end

function setInjectionRate(port, value)

    port.setInjectionRate(setRate)

end

function getBasicData(port)

    

end