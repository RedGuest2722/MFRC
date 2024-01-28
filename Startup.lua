--[[

    This program starts the main program.

]]

-- Varibles Initialisation:

local keyNotPressed = true
local exists = {
    false, -- Main Program 
    false, -- Interface API
    false, -- Mekanism API
    false, -- Advanced API
}

local filePath = {shell.resolve("Startup.lua"), shell.resolve("fusionReactorMain.lua"), shell.resolve("interfaceAPI.lua"), shell.resolve("mekanismFusionAPI.lua"), shell.resolve("advancedFusionAPI.lua")}
local files = {"Startup.lua", "fusionReactorMain.lua", "interfaceAPI.lua", "mekanismFusionAPI.lua", "advancedFusionAPI.lua"}

for i = 1, 4 do
    if fs.exists(filePath[1 + i]) then

        exists[i] = true

    end
end

if exists[1] == false or exists[2] == false or exists[3] == false then

    print("\nMissing following programmes / APIs:\n")

    for i = 1, 3 do

        if exists[i] ~= true then

            print(files[1 + i])

        end
    end

    print("\nThe Program will now exit. Please run Setup.lua.\n\nPress any key to continue.")

    while keyNotPressed do

        local event = os.pullEvent()
    
        if event == "key" then
    
            keyNotPressed = false
            term.clear()
    
        end
    end

elseif exists[4] == false then

    print("\nWarning!: following API not installed:")
    print("\n" .. files[5])
    print("\nIf the API above is needed, please close this program (Ctrl + T).\nThen run Setup.lua .")

    os.sleep(5)

end

os.run({}, filePath[2])