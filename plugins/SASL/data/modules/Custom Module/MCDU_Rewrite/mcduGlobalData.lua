include("MCDU_Rewrite/pages/mcdu_menu.lua")
include("MCDU_Rewrite/pages/init.lua")
include("MCDU_Rewrite/pages/data.lua")
include("MCDU_Rewrite/pages/printaoc.lua")
include("MCDU_Rewrite/pages/gps.lua")
include("MCDU_Rewrite/pages/FPLAN/fplan.lua")
include("MCDU_Rewrite/pages/FPLAn/latrev.lua")


MCDU_FONT = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")
BLANK_FONT = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")
MCDU_FONT_BOLD = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")

MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
MCDU_GREEN = {0.0, 1.0, 0.1, 1.0}


-- MCDU GENERAL DATAREFS
MCDU_CURRENT_PAGE = createGlobalPropertyi("A318/cockpit/mcdu2/current_page", 0)
MCDU_CURRENT_KEY = createGlobalPropertyi("A318/cockpit/mcdu2/current_key")
MCDU_CURRENT_BUTTON = createGlobalPropertyi("A318/cockpit/mcdu2/current_button")

hours = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours")
minutes = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
seconds = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_seconds")

--MCDU GLOBAL VARIABLES
DEPARTURE_AIRPORT = " "
DESTINATION_AIRPORT = " "
--======================================--
--           INPUT HANDLER              --
--======================================--

function update()
    set(MCDU_CURRENT_KEY, -1)
    set(MCDU_CURRENT_BUTTON, -1)
    local keyStorage = checkForPress(keys)
    local buttonStorage = checkForPress(buttons)
    if keyStorage ~= -1 then
        set(MCDU_CURRENT_KEY, keyStorage)
        set(keys[keyStorage], 0)
        keyStorage = -1
    end
    if keysDecoder[get(MCDU_CURRENT_KEY)] ~= nil and get(MCDU_CURRENT_KEY) < 38 then
        if scratchpad == "ERROR" then
            scratchpad = ""
        end
        scratchpad = scratchpad .. keysDecoder[get(MCDU_CURRENT_KEY)]
        set(MCDU_CURRENT_KEY, -1)
    elseif keysDecoder[get(MCDU_CURRENT_KEY)] == "c" then
        scratchpad = ""
        set(MCDU_CURRENT_KEY, -1)
    end
    if buttonStorage ~= -1 then
        set(MCDU_CURRENT_BUTTON, buttonStorage)
        set(buttons[buttonStorage], 0)
        buttonStorage = -1
    end
    pageButtons(buttons)
    switchDataPage()
    switchPrintAOCPage()
    switchInitPage()

    -- REMOVE SCRATCHPAD ERRORS
end

function pageButtons(button)
    if get(MCDU_CURRENT_BUTTON) == 15 then
        set(MCDU_CURRENT_PAGE, 1)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 22 then
        set(MCDU_CURRENT_PAGE, 0)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 16 then
        set(MCDU_CURRENT_PAGE, 2)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 17 then
        if checkForAirports() == true then
            set(MCDU_CURRENT_PAGE, 3)
        else
            scratchpad = "ERROR: INITALIZE ROUTE"
        end

    end
end

function checkTextInput(field)
    for i=0, 11 do
        if get(MCDU_CURRENT_BUTTON) == i-1 and string.len(scratchpad) == field[i+1].size then
            set(MCDU_CURRENT_BUTTON, -1)
            clearScratch(scratchpad)
            return scratchpad
        end
    end
end


--MCDU PAGES:
mcduPages = {
    [0] = {drawMCDUMenu},
    [1] = {drawInit},
    [12] = {drawCoRte},
    --[11] = {initB},
    --[111] = {drawClimbWind},
    --[112] = {drawDescentWind},
    [2] = {drawDataA},
    [22] = {drawDataB},
    --[221] = {drawPositionMonitor},
    --[222] = {drawIRSMonitor},
    [223] = {drawGPSMonitor},
    --[224] = {drawACStatus},
    [225] = {drawPrintA},
    [2251] = {drawPrintB},
    [226] = {drawAOCA},
    [2261] = {drawAOCB},
    [3] = {drawFPlan},
    [4] = {drawInitialLatRev}
}

mcdu_font_colors = {
    [1] = {1, 1, 1, 1},
    [2] = {52/255, 207/255, 21/255, 1.0},
    [3] = {0, 227/255, 223/255, 1.0},
    [4] = {1, 153/255, 0, 1},
    [5] = {1, 1, 1/10, 1},
    [6] = {255, 165, 0, 1.0},
}

-- POSITIONS AND SIZING
title_location = {
    x = 239,
    y = 360,
    font_size = 28
}

option_heading_font_size = 18
option_heading_locations = {
    [1] = 353,
    [2] = 300,
    [3] = 247,
    [4] = 194,
    [5] = 141,
    [6] = 88
}

mcdu_positions = {
    [1] = 322,
    [2] = 269,
    [3] = 216,
    [4] = 163,
    [5] = 110,
    [6] = 55
}

mcdu_option_size = 24

mcdu_font_colors = {
    [1] = {1, 1, 1, 1},
    [2] = {52/255, 207/255, 21/255, 1.0},
    [3] = {0, 227/255, 223/255, 1.0},
    [4] = {1, 153/255, 0, 1}
}

function drawTextFieldBoxes(chars, color, x, y, side)
    y = y + 24
    if side == 1 then
        sasl.gl.drawLine(x, y, (option_heading_font_size*chars), y, color)
        for i=0, chars do
            sasl.gl.drawLine(x+(i*option_heading_font_size), y, x+(i*option_heading_font_size), y-option_heading_font_size, color)
        end
        sasl.gl.drawLine(x, (y)-option_heading_font_size, (option_heading_font_size*chars), (y)-option_heading_font_size, color)
    elseif side == 2 then
        sasl.gl.drawLine(x, y, x-(option_heading_font_size*chars), y, color)
        for i=0, chars do
            sasl.gl.drawLine(x-(i*option_heading_font_size), y, x-(i*option_heading_font_size), y-option_heading_font_size, color)
        end
        sasl.gl.drawLine(x, (y)-option_heading_font_size, x-(option_heading_font_size*chars), (y)-option_heading_font_size, color)
    end
end


function drawOptionHeadings(field)
    for i=1, 6 do
        sasl.gl.drawText(MCDU_FONT, 0, option_heading_locations[i],field[i],option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end
    for j = 7, 12 do
         sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[j-6],field[j],option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    end
end

function drawDashSeparated(position, num1, num2, side)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 5+(num1*12)+(num1*1), position+2, "/",option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=1, num2 do
            local x = 0+(num1*12)+(num1*1)+10+(12*i)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i = 0, (num1-1) do
            local x = 480 - (num2*12)-(num2*1)-10-(12*i)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 480-(num2*12)-(num2*1), position+2, "/",option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function drawDashDotSeparated (position, num1, num2, side)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 3+(num1*12)+(num1*1), position+2, ".",25, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 0+(num1*12)+(num1*1)+10+(12*i)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i = 0, (num1-1) do
            local x = 480 - (num2*12)-(num2*1)-10-(12*i)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 483-(num2*12)-(num2*1), position+2, ".",25, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function drawDashField(position, side, num1)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i=0, (num1-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function clearScratch(scratchpad)
    local scratchpad = ""
    return scratchpad
end

function isEmpty(input)
    if input[5] == " " then
        return true
    else
         return false
    end
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function getAiracCycle()
    -- don't loop through file if value already exists
    if AIRAC_CYCLE == "" then
        local path = getXPlanePath() --gets the xplane path
        local file = io.open(path.."/Custom Data/cycle_info.txt", "r")
        local result = ""
        if file ~= nil  then
            for line in file:lines() do
                if string.match(line, "AIRAC") then
                    for token in string.gmatch(line, "[^%s]+") do
                        result = token
                    end
                    break
                end
            end
            if result ~= nil then
                AIRAC_CYCLE = result
                return AIRAC_CYCLE
            end
        end
        file = io.open(path.."/Resources/default data/earth_nav.dat", "r")
        isFound = false
        for line in file:lines() do
            if string.match(line, "cycle") then
                for token in string.gmatch(line, "[^%s]+") do
                    result = token
                    if isFound then
                        break
                    end
                    if result == "cycle" then
                        isFound = true
                    end
                end
            end
        end
        AIRAC_CYCLE = result:sub(1, 4)
        return AIRAC_CYCLE
    else
        -- if we have found the airac cycle before then don't look it up again
        return AIRAC_CYCLE
    end
end

function checkICAO(icao)
    local path = getXPlanePath() --gets the xplane path
    local file = io.open(path.."/Custom Data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        file:close()
        return true
    end
    print("not found in og directory")
    file = io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        file:close()
        return true
    end
    return false
end

function checkForAirports()
    if DEPARTURE_AIRPORT ~= " " and DESTINATION_AIRPORT ~= " " then
        return true
    else
        return false
    end
end

function calculateDistance(lat1, lon1, lat2, lon2)

    --This function returns great circle distance between 2 points.
    --Found here: http://bluemm.blogspot.gr/2007/01/excel-formula-to-calculate-distance.html
    --lat1, lon1 = the coords from start position (or aircraft's) / lat2, lon2 coords of the target waypoint.
    --6371km is the mean radius of earth in meters. Since X-Plane uses 6378 km as radius, which does not makes a big difference,
    --(about 5 NM at 6000 NM), we are going to use the same.
    --Other formulas I've tested, seem to break when latitudes are in different hemisphere (west-east).  
    local distance = math.acos(math.cos(math.rad(90-lat1))*math.cos(math.rad(90-lat2))+math.sin(math.rad(90-lat1))*math.sin(math.rad(90-lat2))*math.cos(math.rad(lon1-lon2))) * (6378000/1852)
    return distance
end

function createTokens(str, separator)
    local tokens = {}
    for token in string.gmatch(str, "[^%"..separator.."]+") do
        table.insert(tokens, token)
    end
    return tokens
end

function getBasicLatLong(icao)
    local path = getXPlanePath()
--    if isFileExists(path.."/Resources/default data/CIFP/"..icao..".dat", "r") then
    local file = assert(io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r"))
    local str = ""
    io.input(file)
    for line in io.lines() do
        if string.match(line, "RWY") then
            str = line
            break
        end
    end
        local firstTokenSet = createTokens(str, ";")[2]
        local secondTokenSet = createTokens(firstTokenSet, ",")
        file:close()
        if string.sub(tostring(secondTokenSet[1]),1,1) == "S" then
            secondTokenSet[1] = -1 * (tonumber(string.sub(tostring(secondTokenSet[1]),2,-1)))*(10^(-6))
        else
            secondTokenSet[1] = tonumber(string.sub(tostring(secondTokenSet[1]),2,-1))*(10^(-6))
        end
        if string.sub(tostring(secondTokenSet[2]),1,1) == "W" then
            secondTokenSet[2] = -1 * (tonumber(string.sub(tostring(secondTokenSet[2]),2,-1)))*(10^(-6))
        else
            secondTokenSet[2] = (tonumber(string.sub(tostring(secondTokenSet[2]),2,-1)))*(10^(-6))
        end
        return {secondTokenSet[1], secondTokenSet[2]}
 --   else
--        print("DIABETES")
 --       return "0"
   -- end
end

function calculateAirportDistance(icao1, icao2)
    local apt1 = getBasicLatLong(icao1)
    local apt2 = getBasicLatLong(icao2)
    local nmDist = calculateDistance(apt1[1],apt1[2],apt2[1],apt2[2])
    return nmDist
end

function calcTimeToDest(dist)
    local m = dist/(453.564/60)
    local h = m%60
    m = m-h*60
    return h,m
end
