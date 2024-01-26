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

        monitor.setCursorPos(i, maxSize[4])
        monitor.write(" ")
    
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

local function drawTextInit(monitor, maxSize)

    -- Program name

    monitor.setCursorPos((math.floor((maxSize[3] - 2) / 2) - 5), 2)
    monitor.setTextColor(colors.black)
    monitor.setBackgroundColor(colors.lightGray)
    monitor.write("Fusion Reactor")

end

local function redrawBars(monitor, maxSize, filledCapcities)

end

local function Init(monitor)

    monitor.setTextScale(1)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    monitor.setCursorPos(1, 1)

    local max_X, max_Y = monitor.getSize()
    
    local maxSize = {max_X, max_Y, math.ceil(max_X / 2), (max_Y - 16)}

    drawBackground(monitor, maxSize)
    drawBorder(monitor, maxSize)
    time(monitor, maxSize)
    drawTextInit(monitor, maxSize)

    return maxSize

end

local maxSize = Init(peripheral.wrap("left"))

while true do

    time(peripheral.wrap("left"), maxSize)
    redrawBars(monitor, maxSize, {10, 0.5, 10, 0.5, 10, 0.5, 10, 0.5, 10, 0.5})
    os.sleep(0.05)

end