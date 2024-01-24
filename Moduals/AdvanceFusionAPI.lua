--[[

Program for Better Fusion Reactor by igentuman.

This program will include all the interface and logic control of the fusion reactor.

Additional commands: 

    Port.adjustReactivity
    Port.getEfficiency
    Port.getErrorLevel

]]--

-- Local varibles 

local setReact = 0
local lastEffi = 0
local logicPort = peripheral.wrap("fusionReactorLogicAdapter_0")
local roundCounter = 0

local function round(num)
    return math.floor(num * 100 + 0.5) / 100
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

local function ramping(port, lastEffi, rC, setReact) -- this allows the program to by pass the stable reaction logic.

    changeNegative = false
    firstRun = true

    while round(port.getEfficiency()) < 80 do

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
            setReact = setReact + levelChange
            print("\nRound: ".. rC .."  - Ramping\nEfficiency: " .. curEffi " " .. chaEffi .. "\nReactivity: " .. setReact .. "   +" .. levelChange) -- Debug

        else

            port.adjustReactivity(-levelChange)
            setReact = setReact - levelChange
            print("\nRound: ".. rC .."  - Ramping\nEfficiency: " .. curEffi " " .. chaEffi .. "\nReactivity: " .. setReact .. "   -" .. levelChange) -- Debug

        end

        lastEffi = curEffi
        rC = rC + 1

        os.sleep(2)
    end

    return lastEffi, rC, setReact
end

local function stable(port, lastEffi, rC, setReact)

    changeNegative = false
    firstRun = true

    while round(port.getEfficiency()) > 80 do

        curEffi, chaEffi, errLev = check(port, lastEffi)
        
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
            setReact = setReact + levelChange
            print("\nRound: ".. rC .."  - Stable\nEfficiency: " .. curEffi " " .. chaEffi .. "\nReactivity: " .. setReact .. "   +" .. levelChange) -- Debug

        else

            port.adjustReactivity(-levelChange)
            setReact = setReact - levelChange
            print("\nRound: ".. rC .."  - Stable\nEfficiency: " .. curEffi " " .. chaEffi .. "\nReactivity: " .. setReact .. "   -" .. levelChange) -- Debug

        end

        lastEffi = curEffi
        rC = rC + 1

        os.sleep(4)
    end

    return lastEffi, rC, setReact
end

while true do
    
    if round(logicPort.getEfficiency()) > 80 then
        
        lastEffi, roundCounter, setReact = stable(logicPort, lastEffi, roundCounter, setReact)

    else

        lastEffi, roundCounter, setReact = ramping(logicPort, lastEffi, roundCounter, setReact)

    end
end
