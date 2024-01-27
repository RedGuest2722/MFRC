--[[

    API for Fusion Reactor interface.

    Monitor Size: 2x2 (36, 24)
    
]]--


local function time(monitor, maxSize)

    monitor.setBackgroundColor(colors.lightGray)
    monitor.setTextColor(colors.black)

    time1 = textutils.formatTime(os.time(), true)
    day = "Day: " .. tostring(os.day())

    if string.len(time1) == 4 then

        time2 = "0" .. time1

    else

        time2 = time1

    end

    day_time = day .. " Time: " .. time2

    monitor.setCursorPos(maxSize[1] - string.len(day_time), 2)
    monitor.write(day_time)
    monitor.setCursorPos(maxSize[1] - 12, 2)
    monitor.setBackgroundColor(colors.gray)
    monitor.write(" ")

    for i = 1, (maxSize[1] - (19 + maxSize[3])) do

        monitor.setCursorPos((maxSize[3] + i), 2)
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

local function redrawBars(monitor, maxSize, filledCapcities)



end

local function Initialisation(monitor)

    monitor.setTextScale(1)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    monitor.setCursorPos(1, 1)

    local max_X, max_Y = monitor.getSize()
    local midBorder = math.ceil(max_X / 2)
    local tankSize = {3, midBorder - 6}
    
    local maxSize = {max_X, max_Y, midBorder, tankSize}

    drawBackground(monitor, maxSize)
    drawBorder(monitor, maxSize)
    time(monitor, maxSize)
    drawTextInit(monitor, maxSize, 0)

    return maxSize

end