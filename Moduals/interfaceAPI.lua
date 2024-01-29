--[[

    API for Fusion Reactor interface.

    Monitor Size: 2x2 (36, 24)
    
]]--

---@param num number Number for rounding.
---@param decimalPlace integer Number of decimal places.
---@return number
---@nodiscard
local function round(num, decimalPlace) -- Rounds number values to specified number of decimal places.

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

---@param monitor string String name of monitor
---@param sizes table Monitor size and positions
---@param advanced boolean If the mod 'Better Fusion Reactor for Mekanism Plus' is Installed
local function drawBorder(monitor, sizes, advanced) -- Draws borders for the display.

    monitor.setBackgroundColor(colors.gray)

    -- Drawing of Borders

        -- Top & Bottem Borders

    for i = 1, sizes[1] do
        
        monitor.setCursorPos(i, 1)
        monitor.write(" ")
        monitor.setCursorPos(i, sizes[2])
        monitor.write(" ")
        
    end

        -- Left & Right Borders 
    
    for i = 2, sizes[2] do
    
        monitor.setCursorPos(1, i)
        monitor.write(" ")
        monitor.setCursorPos(sizes[1], i)
        monitor.write(" ")
        
    end
    
        -- Middle Border

    for i = 1, (sizes[2] - 1) do

        monitor.setCursorPos(sizes[3], (1 + i))
        monitor.write(" ")

    end

        -- Top Middle Border

    for i = 2, (sizes[1] - 1) do

        monitor.setCursorPos(i, 3)
        monitor.write(" ")
    
    end

    -- Tank Boundaries

    monitor.setBackgroundColor(colors.black)

        -- Vertical

    for i = 1, 13 do

        monitor.setCursorPos(3, (4 + i))
        monitor.write(" ")
        monitor.setCursorPos((sizes[3] - 2), (4 + i))
        monitor.write(" ")

    end

        -- Horizontal

    for i = 1, 7 do

        for o = 1, (sizes[3] - 5) do

            monitor.setCursorPos((3 + o), (3 + (i * 2)))
            monitor.write(" ")

        end
    end

    if advanced then

        -- Horizontal Right Middle Border

        monitor.setBackgroundColor(colors.gray)

        for i = 1, (sizes[1] - (sizes[3] + 1)) do

            monitor.setCursorPos((sizes[3] + i), (3 + ((sizes[2] - 4) / 2)))
            monitor.write(" ")

        end
    end
end

---@param monitor string String name of monitor
---@param sizes table Monitor size and positions
local function drawBackground(monitor, sizes) -- Draws Background for the display.

    monitor.setBackgroundColor(colors.lightGray)

    for i = 1, sizes[2] do

        for o = 1, sizes[1] do

            monitor.setCursorPos(o, i)
            monitor.write(" ")

        end
    end
end

---@param monitor string String name of monitor
---@param sizes table Monitor size and positions
---@param DTHere boolean If DT Fuel is used to power Fusion reactor
local function drawTextInit(monitor, sizes, DTHere) -- Writes text on monitor.

    -- Program name

    monitor.setCursorPos((math.floor((sizes[3] - 2) / 2) - 5), 2)
    monitor.setTextColor(colors.black)
    monitor.setBackgroundColor(colors.lightGray)
    monitor.write("Fusion Reactor")

    -- Mekanism Names

    monitor.setBackgroundColor(colors.lightGray)
    monitor.setTextColor(colors.black)

    monitor.setCursorPos((sizes[3] + 2), 5)
    monitor.write("Status:")

    monitor.setCursorPos((sizes[3] + 2), 6)
    monitor.write("Gen Rate:")

    monitor.setCursorPos((sizes[3] + 2), 7)
    monitor.write("Inj Rate:")

    -- Tank Names

    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.white)

    local tankNames = {"Plasma Temp.", "Case Temp.", "Water Level", "Steam Level", "DT Level", "Tritium", "Deutirium"}

    local text = nil
    local textLength = nil

    for i = 1, 4 do

        text = tankNames[i]
        textLength = string.len(text)

        monitor.setCursorPos(((0.5 * (sizes[3] - textLength)) + 1), (3 + (2 * i)))
        monitor.write(text)

    end

    if DTHere then

        monitor.setCursorPos(((0.5 * (sizes[3] - string.len(tankNames[5]))) + 1), 13)
        monitor.write(tankNames[5])

        monitor.setBackgroundColor(colors.lightGray)

        for i = 1, 2 do
            for o = 1, (sizes[3] - 3) do

                monitor.setCursorPos((o + 2), (15 + i))
                monitor.write(" ")
            
            end
        end

    else

        for i = 1, 2 do

            text = tankNames[i + 5]
            textLength = string.len(text)

            monitor.setCursorPos(((0.5 * (sizes[3] - textLength)) + 1), (11 + (2 * i)))
            monitor.write(text)
        
        end
    end
end



---@class interfaceAPI
local interfaceAPI = {

    monitor = "monitor_0",
    sizes = {50, 19, 25},
    DTHere = false,
    advanced = false
}



---@param monitor string String peripheral name of monitor
---@param DTHere boolean If DT Fuel is used to power Fusion reactor
---@param advanced boolean If the mod 'Better Fusion Reactor for Mekanism Plus' is Installed
---@return table self Returns a table to be used by interfaceAPI
function interfaceAPI.init(monitor, DTHere, advanced)

    local max_X, max_Y = monitor.getSize()
    local midBorder = math.ceil(max_X / 2)
    
    local sizes = {max_X, max_Y, midBorder}

    local self = setmetatable({}, interfaceAPI) -- Meta table to be used by interfaceAPI

    self.monitor = monitor
    self.sizes = sizes
    self.DTHere = DTHere
    self.advanced = advanced

    self.monitor.setTextScale(1)
    self.monitor.setBackgroundColor(colors.black)
    self.monitor.clear()
    self.monitor.setCursorPos(1, 1)

    drawBackground(monitor, sizes)
    drawBorder(monitor, sizes, advanced)
    drawTextInit(monitor, sizes, DTHere)

    return self   
end

function interfaceAPI:time() -- Displays time on monitor

    self.monitor.setBackgroundColor(colors.lightGray)
    self.monitor.setTextColor(colors.black)

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

    local day_time = "Day: " .. day2 .. " Time: " .. time2

    self.monitor.setCursorPos((self.sizes[1] - string.len(day_time)), 2)
    self.monitor.write(day_time)
    self.monitor.setCursorPos((self.sizes[1] - 12), 2)
    self.monitor.setBackgroundColor(colors.gray)
    self.monitor.write(" ")

    for i = 1, (self.sizes[1] - (20 + self.sizes[3])) do

        self.monitor.setCursorPos(((self.sizes[3] - 1) + i), 2)
        self.monitor.write(" ")

    end
end

---@param filledCapacities table Percent capacities of liquids, gases, temperatures of the Fusion Reactor
function interfaceAPI:redrawBars(filledCapacities) -- Redraws bars to show Levels of Fusion reactor

    local tankColors = {colors.white, colors.red, colors.blue, colors.lightGray, colors.purple, colors.green}
    local tankPixels = {nil, nil, nil, nil, {nil, nil, nil}}

    for i = 1, 5 do

        if i == 5 then

            for o in ipairs(filledCapacities[5]) do

                local colored = round((self.tankSize * filledCapacities[5][o]), 0)
                local white = (self.tankSize - colored)

                tankPixels[5][o] = {white, colored}
                
            end

        else

            local colored = round((self.tankSize * filledCapacities[i]), 0)
            local white = (self.tankSize - colored)

            tankPixels[i] = {white, colored}

        end
    end

    for i = 1, 5 do
        
        if i == 5 then

            if filledCapacities[5][1] ~= 0 then

                self.monitor.setBackgroundColor(tankColors[1])

                for o = 1, tankPixels[5][1][1] do
                    
                    self.monitor.setCursorPos((3 + o), 14)
                    self.monitor.write(" ")

                end

                self.monitor.setBackgroundColor(tankColors[5])

                for o = 1, tankPixels[5][1][2] do

                    self.monitor.setCursorPos((3 + (o + tankPixels[5][1][1])), 14)
                    self.monitor.write(" ")

                end

            else

                for o = 1, 2 do
                    
                    self.monitor.setBackgroundColor(tankColors[1])

                    for p = 1, tankPixels[5][1 + o][1] do

                        self.monitor.setCursorPos((3 + p), (12 + (2 * o)))
                        self.monitor.write(" ")

                    end            
                    
                    if o == 1 then
                        
                        self.monitor.setBackgroundColor(tankColors[6])

                    else

                        self.monitor.setBackgroundColor(tankColors[2])

                    end

                    for p = 1, tankPixels[5][1 + o][2] do

                        self.monitor.setCursorPos((3 + (p + tankPixels[5][1 + o][1])), (12 + (2 * o)))
                        self.monitor.write(" ")

                    end
                end
            end
            
        else

            self.monitor.setBackgroundColor(tankColors[1])

            for o = 1, tankPixels[i][1] do
                
                self.monitor.setCursorPos((3 + o), (4 + (2 * i)))
                self.monitor.write(" ")

            end

            if i == 1 or i == 2 then
                
                self.monitor.setBackgroundColor(tankColors[2])

            elseif i == 3 then

                self.monitor.setBackgroundColor(tankColors[3])

            else

                self.monitor.setBackgroundColor(tankColors[4])

            end

            for o = 1, tankPixels[i][2] do
                
                self.monitor.setCursorPos((3 + (o + tankPixels[i][1])), (4 + (2 * i)))
                self.monitor.write(" ")

            end
        end
    end
end

---@param text table Values from the mekanismFusionAPI.getBasicData()
function interfaceAPI:updateText(text) -- Update values on the monitor

    self.monitor.setBackgroundColor(colors.lightGray)
    self.monitor.setTextColor(colors.black)

    self.monitor.setCursorPos((self.sizes[2] - (2 + string.len(text[2]))), 6)
    self.monitor.write(text[2])

    self.monitor.setCursorPos((self.sizes[2] - (2 + string.len(tostring(text[3])))), 7)
    self.monitor.write(tostring(text[2]))

end

return interfaceAPI
