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
local logicPort = peripheral.wrap("fusionReactorLogicAdapter_0")

local function round(num)
    mult = 10^(2)
    return math.floor(num * mult + 0.5) / mult
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

    end

    return change

end

local function ramping(port) -- this allows the program to by pass the stable reaction logic.

    ramp = 1

    changeNegative = false

    firstRun = true

    while ramp < 6 do

        curEffi, chaEffi, errLev = check(port, lastEffi)
        
        if firstRun == false and chaEffi < 0 then

            if changeNegative == false then

                changeNegative = true

            else

                changeNegative = false

            end
        end

        firstRun = false

        levelChange = efficiencyLevelChange(curEffi)

        if changeNegative == false then

            port.adjustReactivity(levelChange)
            print("Ramp Round: ".. ramp .."\nCurrent Efficiency: " .. curEffi .. "\nReactivity: +" .. levelChange) -- Debug

        else

            port.adjustReactivity(-levelChange)
            print("Ramp Round: ".. ramp .."\nCurrent Efficiency: " .. curEffi .. "\nReactivity: -" .. levelChange) -- Debug

        end

        os.sleep(5)
    end
end

ramping(logicPort)