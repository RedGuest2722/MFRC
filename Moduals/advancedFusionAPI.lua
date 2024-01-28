--[[

Program for Better Fusion Reactor by igentuman.

This program will include all the interface and logic control of the fusion reactor.

Additional commands: 

    Port.adjustReactivity
    Port.getEfficiency
    Port.getErrorLevel

]]--

-- Local varibles 

local lastEffi = 0
local curEffi = 0
local logicPort = peripheral.wrap("fusionReactorLogicAdapter_0")
local roundCounter = 0

---@class advancedFusionAPI
local advancedFusionAPI = {}

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

local function check(port, lE)

    eL = round(port.getErrorLevel()) -- find error level

    cuE = round(port.getEfficiency()) -- find current efficiency

    chE = round(cuE - lE) -- change in efficiency

    return cuE, chE, eL

end

local function efficiencyLevelChange(cE)

    if cE > 98 then

        change = 0.01

    elseif cE > 95 then

        change = 0.05

    elseif cE > 80 then
        
        change = 0.1

    elseif cE > 60 then

        change = 5

    elseif cE > 30 then

        change = 15

    else

        change = 20

    end

    return change

end

function advancedFusionAPI.ramping(port, lastEffi, rC) -- this allows the program to by pass the stable reaction logic.

    local changeNegative = false
    local firstRun = true

    while round(port.getEfficiency()) < 80 do

        local curEffi, chaEffi, errLev = check(port, lastEffi)
        
        if firstRun == false and chaEffi < 0 then

            if changeNegative == false then

                changeNegative = true

            else

                changeNegative = false

            end
        end

        local firstRun = false

        local levelChange = efficiencyLevelChange(curEffi)

        if changeNegative == false then

            port.adjustReactivity(levelChange)
            print("\n" .. time() .."\nReactor Status: Ramping\nEfficiency: " .. curEffi .. " " .. chaEffi .. "\nReactivity: +" .. levelChange) -- Debug

        else

            port.adjustReactivity(-levelChange)
            print("\n" .. time() .."\nReactor Status: Ramping\nEfficiency: " .. curEffi .. " " .. chaEffi .. "\nReactivity: -" .. levelChange) -- Debug

        end

        lastEffi = curEffi
        local rC = rC + 1

        os.sleep(2)
    end

    return lastEffi, rC
end

function advancedFusionAPI.stable(port, lastEffi, rC)

    local changeNegative = false
    local firstRun = true

    while round(port.getEfficiency()) > 80 do

        local curEffi, chaEffi, errLev = check(port, lastEffi)
        
        if chaEffi < 0 then

            if changeNegative == false then

                changeNegative = true

            else

                changeNegative = false

            end
        end

        levelChange = efficiencyLevelChange(curEffi)

        if changeNegative == false then

            port.adjustReactivity(levelChange)
            print("\n" .. time() .."\nReactor Status: Stable\nEfficiency: " .. curEffi .. " " .. chaEffi .. "\nReactivity: +" .. levelChange) -- Debug

        else

            port.adjustReactivity(-levelChange)
            print("\n" .. time() .."\nReactor Status: Stable\nEfficiency: " .. curEffi .. " " .. chaEffi .. "\nReactivity: -" .. levelChange) -- Debug

        end

        local lastEffi = curEffi
        local rC = rC + 1

        os.sleep(4)
    end

    return lastEffi, rC
end