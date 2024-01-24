--[[
    Commands
        .getEfficiency()
        .getErrorLevel()
        .adjustReactivity()
]]--

local interupt = false

local logicPort = peripheral.wrap("fusionReactorLogicAdapter_0")

local lastEfficiency = 0

local adjustment = 1


while interupt == false do

    local adjustment_negative = true

    local curEfficiency = logicPort.getEfficiency()

    if curEfficiency > 0 then

      if lastEfficiency > curEfficiency then

        adjustment_negative = false

      end

      if curEfficiency == 100 then

        logicPort.adjustReactivity(0)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 0")
      
      elseif curEfficiency > 95 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.01)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -0.01")

      elseif curEfficiency > 95 and adjustment_negative == false then

        logicPort.adjustReactivity(0.01)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 0.01")
      
      elseif curEfficiency > 90 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.05)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -0.05")

      elseif curEfficiency > 90 and adjustment_negative == false then

        logicPort.adjustReactivity(0.05)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 0.05")

      elseif curEfficiency > 80 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.1)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -0.1")

      elseif curEfficiency > 80 and adjustment_negative == false then

        logicPort.adjustReactivity(0.1)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 0.1")

      elseif curEfficiency > 70 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.5)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -0.5")

      elseif curEfficiency > 70 and adjustment_negative == false then

        logicPort.adjustReactivity(0.5)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 0.5")

      elseif curEfficiency > 60 and adjustment_negative == true then

        logicPort.adjustReactivity(-1)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -1")

      elseif curEfficiency > 60 and adjustment_negative == false then

        logicPort.adjustReactivity(1)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 1")

      elseif curEfficiency > 50 and adjustment_negative == true then

        logicPort.adjustReactivity(-5)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -5")

      elseif curEfficiency > 50 and adjustment_negative == false then

        logicPort.adjustReactivity(5)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 5")

      elseif curEfficiency > 40 and adjustment_negative == true then

        logicPort.adjustReactivity(-10)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -10")

      elseif curEfficiency > 40 and adjustment_negative == false then

        logicPort.adjustReactivity(10)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 10")

      elseif curEfficiency < 30 or curEfficiency > 30 and adjustment_negative == true then

        logicPort.adjustReactivity(-15)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: -15")

      elseif curEfficiency < 30 or curEfficiency > 30 and adjustment_negative == false then

        logicPort.adjustReactivity(15)
        print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: 15")

      end

      lastEfficiency = curEfficiency

    end

    local timerID = os.startTimer(5)

    local event = os.pullEvent()

    if event == "terminate" then

        term.clear()

        os.print("Closing.")

        os.sleep(3)
    
    end

    print("loop end.")
end