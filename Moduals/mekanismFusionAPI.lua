--[[

this runs some commands for the main script

]]--

local function getData(port)

    plasmTemp = port.getPlasmaTemperature()
    PlasmMax  = port.getMaxPlasmaTemperature()
    
    plasma = {plasmaTemp, plasmaMax}


    caseTemp = port.getCaseTemperature()
    caseMax  = port.getMaxCasingTemperature

    case = {caseTemp, caseMax}


    water = port.getWaterFilledPercentage()
    steam = port.getSteamFilledPercentage()


    DTfuel    = port.getDTFuelFilledPercentage()
    tritium   = port.getTritiumFilledPercentage()
    deutirium = port.getDeuteriumFilledPercentage
    
    fuel = {DTfuel, tritium, deutirium}
    

    return {plasma, case, water, steam, fuel}
    
end