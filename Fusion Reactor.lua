--[[
    Commands
        .getEfficiency()
        .getErrorLevel()
        .adjustReactivity()
]]--

local interupt = false

local logicPort = peripheral.wrap("fusionReactorLogicAdapter_0")

local lastEfficiency = logicPort.getEfficiency()


while interupt == false then

    curEfficiency = logicPort.getEfficiency()

    if curEfficiency > 0 then

      if lastEfficiency > curEfficiency then

        adjustment = -adjustment

      end

      logicPort.adjustReactivity(adjustment)
    
      print("Efficiency = " .. curEfficiency .. "\n" .. "Adjustment: " ..adjustment)

      lastEfficiency = curEfficiency

    end

    local timerID = os.startTimer(1)

    local event = os.pullEvent()

    if event == "terminate" then

        term.clear()

        os.print("Closing.")

        os.sleep(3)

end