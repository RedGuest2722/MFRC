--[[

    Program to install all APIs and the Main Program

]]--

repositoryMain = "https://raw.githubusercontent.com/RedGuest2722/Radioactivity/Development"

local files = {"/Startup.lua", "/fusionReactorMain.lua", "/Moduals/interfaceAPI.lua", "/Moduals/mekanismFusionAPI.lua", "/Moduals/advancedFusionAPI.lua"}


for i in ipairs(files) do
    if fs.exists(files[i]) then

        fs.delete(files[i])

    end
end

local Setup = {}

local function download(file)

    -- Get file from repo
    local handle = http.get(repositoryMain .. file)
    local content = handle.readAll()
    handle.close()

    -- Save file locally in the correct directory
    local fileHandle = fs.open(file, "w")
    fileHandle.write(content)
    fileHandle.close()

end

local function advanced()

    print("\nThe additional API will now be installed.")
    download(files[5])
    os.sleep(1)
    print("\nThe additional API has now been installed.")

end

-- Start

term.clear()

os.sleep(1)

print("This is the setup program for the Mekanism Fusion Reactor.\n\nThis will install the required APIs and the Main program.\n\nBefore the downloads begin, do you have the mod 'Better Fusion Reactor for Mekanism PLUS' installed? (y/n):")

local choice1 = io.read()

if choice1 == "n" then

    print("\nThe additional API will not be install.\nIf you do add it later just re-run this program.")

end

if http.checkURL(repositoryMain) then

    print("\nThe files will now begin to download.\n")

    for i = 1, 4 do 

        download(files[i])
        print("Downloaded: " .. files[i])
        os.sleep(1)

    end

    if choice1 == "y" then

        advanced()

    end

    print("\nAll files have been downloaded.\n\nWould you like to start the program? (y/n)")

    local choice2 = io.read()

    if choice2 == "y" then

        os.run({}, files[1])

    end

else

    print("\nCannot connect to the Repository to download the files.\nThis may be due to an internet connection or an unvalid link.")

    print("\nThis program will now end. Press any key to continue.")

    local keyNotPressed = true

    while keyNotPressed do

        event = os.pullEvent()

        if event == "key" then

            keyNotPressed = false
            term.clear()
            error("Exited program")

        end
    end  
end

