--[[

this runs some commands for the main script

]]--

function getData(port)

    local plasmTemp = port.getPlasmaTemperature()
    local PlasmMax  = port.getMaxPlasmaTemperature()
    
    local plasma = {plasmaTemp, plasmaMax}


    local caseTemp = port.getCaseTemperature()
    local caseMax  = port.getMaxCasingTemperature

    local case = {caseTemp, caseMax}


    local water = port.getWaterFilledPercentage()
    local steam = port.getSteamFilledPercentage()


    local DTfuel    = port.getDTFuelFilledPercentage()
    local tritium   = port.getTritiumFilledPercentage()
    local deutirium = port.getDeuteriumFilledPercentage
    
    local fuel = {DTfuel, tritium, deutirium}


    return {plasma, case, water, steam, fuel}
    
end