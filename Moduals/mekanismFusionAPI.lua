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
    local deutirium = port.getDeuteriumFilledPercentage
    
    local fuel = {DTfuel, tritium, deutirium}

    local filledCapacities = {plasma, case, water, steam, fuel}

    return filledCapacities
    
end