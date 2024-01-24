--[[

Program for Better Fusion Reactor by igentuman.

This program will include all the interface and logic control of the fusion reactor.

Additional commands: 

    Port.adjustReactivity
    Port.getEfficiency
    Port.getErrorLevel

]]--

-- Local varibles 

local lastEffi

local ramp = true -- this allows the program to by pass the stable reaction logic

local function check(port, lE)

    Local eL = port.getErrorLevel() -- find error level

    local cuE = port.getEfficiency() -- find current efficiency

    local chE = cuE - lE -- change in efficiency

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

local function ramping(port)

    local timerID = os.startTimer(30)

    local changeNegative = false

    local firstRun = true

    while os.pullEvent("timer") == timerID do

        local curEffi, chaEffi, errLev = check(port, lastEffi)
        
        if firstRun == false and chaEffi < 0 then

            if changeNegative == false then

                changeNegative == true

            else

                changeNegative == false

            end
        end

        firstRun = false

        if changeNegative == false then

            port.adjustReactivity(efficiencyLevelChange(curEffi))

        else

            port.adjustReactivity(-efficiencyLevelChange(curEffi))

        end
    end
end

ramping("fusionReactorLogicAdapter_0")