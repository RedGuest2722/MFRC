--[[

main script for the fusion reactor.

]]--

-- Varibles

local AdvanceAPI = nil
local InterfaceAPI = nil


if fs.exists("/Moduals/AdvanceFuisionAPI.lua") then 
    AdvanceAPI = os.loadAPI("/Moduals/AdvanceFuisionAPI.lua")

else

    print("Do you have the mod 'Better Fusion Reactor for Mekanism PLUS' installed? (y/n): ")
    local choice1 = io.read()

    if choice1 == "y" then

        print("You can install an additional Program to auto control the reactivity and monitor it.")
        print("Would you like to install this? (y/n):")

        local choice2 = io.read()

        if choice2 == "y" then

            print("installing additional API.")

            -- Get file from repo
            local handle = http.get(repo_main .. file)
            local content = handle.readAll()
            handle.close()

            -- Save file locally in the correct directory
            local fileHandle = fs.open(file, "w")
            fileHandle.write(content)
            fileHandle.close()



end

if fs.exists("/Moduals/InterfaceAPI.lua") then
    InterfaceAPI = os.loadAPI("/Moduals/InterfaceAPI.lua")
end

local fusionLogicPort = peripheral.find("fusionReactorLogicAdapter_0")
local monitor         = peripheral.find("monitor")

