--[[

    This program starts the main program.

]]

-- Varibles Initialisation:

local exists = {
    false, -- Main Program 
    false, -- Interface API
    false, -- Mekanism API
    false, -- Advanced API
}

local files = {"/Startup.lua", "/fusionReactorMain.lua", "/Moduals/interfaceAPI.lua", "/Moduals/mekanismFusionAPI.lua", "/Moduals/advancedFusionAPI.lua"}


for i = 1, 4 do
    if fs.exists(files[1 + i]) then

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

        event = os.pullEvent()
    
        if event == "key" then
    
            keyNotPressed = false
            term.clear()
            exit()
    
        end
    end

elseif exists[4] == false then

    print("\nWarning!: following API not installed:")
    print("\n" .. files[5])
    print("\nIf the API above is needed, please close this program (Ctrl + T).\nThen run Stetup.lua .")

    os.sleep(5)

end

os.run({}, files[2])
error("Exited program")