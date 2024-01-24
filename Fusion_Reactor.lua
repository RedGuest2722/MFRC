--[[
    Commands
        .getEfficiency()
        .getErrorLevel()
        .adjustReactivity()
]]--

local interupt = false

local logicPort = peripheral.wrap("fusionReactorLogicAdapter_0")

local lastEfficiency = 0

local countNegative = 0


while interupt == false do

    local adjustment_negative = false

    local curEfficiency = logicPort.getEfficiency()

    local changeInEfficiency = curEfficiency - lastEfficiency

    if curEfficiency > 0 then

      if changeInEfficiency < 0 then

        countNegative = countNegative + 1

      end

      if lastEfficiency > curEfficiency and countNegative < 3 then

        adjustment_negative = true

      end

      if curEfficiency == 100 then

        logicPort.adjustReactivity(0)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 0")
      
      elseif curEfficiency > 95 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.01)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -0.01")

      elseif curEfficiency > 95 and adjustment_negative == false then

        logicPort.adjustReactivity(0.01)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 0.01")
      
      elseif curEfficiency > 90 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.05)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -0.05")

      elseif curEfficiency > 90 and adjustment_negative == false then

        logicPort.adjustReactivity(0.05)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 0.05")

      elseif curEfficiency > 80 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.1)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -0.1")

      elseif curEfficiency > 80 and adjustment_negative == false then

        logicPort.adjustReactivity(0.1)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 0.1")

      elseif curEfficiency > 70 and adjustment_negative == true then

        logicPort.adjustReactivity(-0.5)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -0.5")

      elseif curEfficiency > 70 and adjustment_negative == false then

        logicPort.adjustReactivity(0.5)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 0.5")

      elseif curEfficiency > 60 and adjustment_negative == true then

        logicPort.adjustReactivity(-1)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -1")

      elseif curEfficiency > 60 and adjustment_negative == false then

        logicPort.adjustReactivity(1)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 1")

      elseif curEfficiency > 50 and adjustment_negative == true then

        logicPort.adjustReactivity(-5)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -5")

      elseif curEfficiency > 50 and adjustment_negative == false then

        logicPort.adjustReactivity(5)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 5")

      elseif curEfficiency > 40 and adjustment_negative == true then

        logicPort.adjustReactivity(-10)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -10")

      elseif curEfficiency > 40 and adjustment_negative == false then

        logicPort.adjustReactivity(10)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 10")

      elseif curEfficiency < 40 and adjustment_negative == true then

        logicPort.adjustReactivity(-15)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: -15")

      elseif curEfficiency < 40 and adjustment_negative == false then

        logicPort.adjustReactivity(15)
        print("\nChange = " .. changeInEfficiency .. "\nEfficiency = " .. curEfficiency .. "\nAdjustment: 15")

      end

      lastEfficiency = curEfficiency

    end

    if countNegative < 3 then

      os.sleep(5)

      local checkEfficiency = logicport.getEfficiency()

      if checkEfficiency < curEfficiency then

        exit()

    end

    local timerID = os.startTimer(5)

    print("loop end.")

    local event = os.pullEvent()

    if event == "terminate" then

        term.clear()

        os.print("Closing.")

        os.sleep(3)
    
    end
end