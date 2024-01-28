--[[

    API for Fusion Reactor interface.

    Monitor Size: 2x2 (36, 24)
    
]]--


function time(monitor, maxSize)

    monitor.setBackgroundColor(colors.lightGray)
    monitor.setTextColor(colors.black)

    local time1 = textutils.formatTime(os.time(), true)
    local day1 = tostring(os.day())

    local time2 = nil
    local day2 = nil

    if string.len(time1) == 4 then

        time2 = "0" .. time1

    else

        time2 = time1

    end

    if string.len(day1) == 1 then

        day2 = "00" .. day1

    elseif string.len(day1) == 2 then

        day2 = "0" .. day1

    else

        day2 = day1

    end

    day_time = "Day: " .. day2 .. " Time: " .. time2

    monitor.setCursorPos((maxSize[1] - string.len(day_time)), 2)
    monitor.write(day_time)
    monitor.setCursorPos((maxSize[1] - 12), 2)
    monitor.setBackgroundColor(colors.gray)
    monitor.write(" ")

    for i = 1, (maxSize[1] - (19 + maxSize[3])) do

        monitor.setCursorPos(((maxSize[3] - 2) + i), 2)
        monitor.write(" ")

    end
end

local function drawBorder(monitor, maxSize)

    monitor.setBackgroundColor(colors.gray)

    -- Drawing of Borders

        -- Top & Bottem Borders

    for i = 1, maxSize[1] do
        
        monitor.setCursorPos(i, 1)
        monitor.write(" ")
        monitor.setCursorPos(i, maxSize[2])
        monitor.write(" ")
        
    end

        -- Left & Right Borders 
    
    for i = 2, maxSize[2] do
    
        monitor.setCursorPos(1, i)
        monitor.write(" ")
        monitor.setCursorPos(maxSize[1], i)
        monitor.write(" ")
        
    end
    
        -- Middle Border

    for i = 1, (maxSize[2] - 1) do

        monitor.setCursorPos(maxSize[3], (1 + i))
        monitor.write(" ")

    end

        -- Top Middle Border

    for i = 2, (maxSize[1] - 1) do

        monitor.setCursorPos(i, 3)
        monitor.write(" ")
    
    end

    -- Tank Boundaries

    monitor.setBackgroundColor(colors.black)

        -- Vertical

    for i = 1, 13 do

        monitor.setCursorPos(3, (4 + i))
        monitor.write(" ")
        monitor.setCursorPos((maxSize[3] - 2), (4 + i))
        monitor.write(" ")

    end

        -- Horizontal

    for i = 1, 7 do

        for o = 1, (maxSize[3] - 5) do

            monitor.setCursorPos((3 + o), (3 + (i * 2)))
            monitor.write(" ")

        end
    end

    return (maxSize[3] - 5)
end

local function drawBackground(monitor, maxSize)

    monitor.setBackgroundColor(colors.lightGray)

    for i = 1, maxSize[2] do

        for o = 1, maxSize[1] do

            monitor.setCursorPos(o, i)
            monitor.write(" ")

        end
    end
end

local function drawTextInit(monitor, maxSize, DTPercent)

    -- Program name

    monitor.setCursorPos((math.floor((maxSize[3] - 2) / 2) - 5), 2)
    monitor.setTextColor(colors.black)
    monitor.setBackgroundColor(colors.lightGray)
    monitor.write("Fusion Reactor")

    -- Tank Names

    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.white)

    local tankNames = {"Plasma Temp.", "Case Temp.", "Water Level", "Steam Level", "DT Level", "Tritium", "Deutirium"}
    local  tankWidth = maxSize[3] - 5

    local text = nil
    local textLength = nil

    for i = 1, 4 do

        text = tankNames[i]
        textLength = string.len(text)

        monitor.setCursorPos(((0.5 * (maxSize[3] - textLength)) + 1), (3 + (2 * i)))
        monitor.write(text)

    end

    if DTPercent > 0 then

        monitor.setCursorPos(((0.5 * (maxSize[3] - string.len(tankNames[5]))) + 1), 13)
        monitor.write(tankNames[5])

        monitor.setBackgroundColor(colors.lightGray)

        for i = 1, 2 do
            for o = 1, (maxSize[3] - 3) do

                monitor.setCursorPos((o + 2), (15 + i))
                monitor.write(" ")
            
            end
        end

    else

        for i = 1, 2 do

            text = tankNames[i + 5]
            textLength = string.len(text)

            monitor.setCursorPos(((0.5 * (maxSize[3] - textLength)) + 1), (11 + (2 * i)))
            monitor.write(text)
        
        end
    end
end

function redrawBars(monitor, maxSize, tankSize, filledCapacities)

    local tankColors = {colors.white, colors.red, colors.blue, colors.lightGray, colors.purple, colors.lime}
    local tankPixels = {nil, nil, nil, nil, {nil, nil, nil}}

    local function round(num)

        local numWhole = math.floor(num)
        local numDecimal = (num - numWhole)
        local numRound = nil

        if numDecimal < 0.5 then

            numRound = math.floor(num)

        else

            numRound = math.ceil(num)

        end

        return numRound

    end

    for i in ipairs(filledCapacities) do

        if i == 5 then

            for o in ipairs(filledCapacities[i]) do

                local colored = nil
                local white = nil

                if tostring(filledCapacities[5][o]) ~= "?" then

                    colored = round(tankSize * filledCapacities[5][o])
                    white = (tankSize - colored)

                    tankPixels[5][o] = {white, colored}
                
                else

                    colored = 0
                    white = (tankSize - colored)

                    tankPixels[5][o] = {white, colored}
                
                end
            end

        else

            local colored = round(tankSize * filledCapacities[i])
            local white = (tankSize - colored)

            tankPixels[i] = {white, colored}

        end
    end

    for i = 1, 5 do
        
        if i == 5 then

            if filledCapacities[5][1] ~= 0 then

                monitor.setBackgroundColor(tankColors[1])

                for o = 1, tankPixels[5][1][1] do
                    
                    monitor.setCursorPos((3 + 0), 13)
                    monitor.write(" ")

                end

                monitor.setBackgroundColor(tankColors[5])

                for o = 1, tankPixels[5][1][2] do

                    monitor.setCursorPos((3 + (o + tankPixels[5][1][1])), 13)

                end

            else

                for o = 1, 2 do
                    
                    monitor.setBackgroundColor(tankColors[1])

                    for p = 1, tankPixels[5][1 + o][1] do
                        
                        monitor.setCursorPos((3 + p), (11 + (2 * o)))
                        monitor.write(" ")

                    end

                    if o == 1 then
                        
                        monitor.setBackgroundColor(tankColors[6])

                    else

                        monitor.setBackgroundColor(tankColors[2])

                    end

                    for p = 1, tankPixels[5][1 + 0][2] do

                        monitor.setCursorPos((3 + (p + tankPixels[5][1 + o][1])), (11 + (2 * p)))
                        monitor.write(" ")

                    end
                end
            end
            
        else

            monitor.setBackgroundColor(tankColors[1])

            for o = 1, tankPixels[i][1] do
                
                monitor.setCursorPos((3 + o), (3 + (2 * i)))
                monitor.write(" ")

            end

            if i == 1 or i == 2 then
                
                monitor.setBackgroundColor(tankColors[2])

            elseif i == 3 then

                monitor.setBackgroundColor(tankColors[3])

            else

                monitor.setBackgroundColor(tankColors[4])

            end

            for o = 1, tankPixels[i][2] do
                
                monitor.setCursorPos((3 + (o + tankPixels[i][1])), (3 + (2 * i)))
                monitor.write(" ")

            end
        end
    end
end

function initialisation(monitor, DTfuel)

    monitor.setTextScale(1)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    monitor.setCursorPos(1, 1)

    local max_X, max_Y = monitor.getSize()
    local midBorder = math.ceil(max_X / 2)
    local tankSize = {3, midBorder - 6}
    
    local maxSize = {max_X, max_Y, midBorder, tankSize}

    drawBackground(monitor, maxSize)
    local tankSize = drawBorder(monitor, maxSize)
    time(monitor, maxSize)
    drawTextInit(monitor, maxSize, DTfuel)

    return maxSize, tankSize

end