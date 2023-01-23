CURRENT_LATREV = ""
local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}
EXISTING_LATREVS = {
}
CURRENT_LATREV_INDEX = 0

local function generateLongLat(long, lat)
    local longD = math.floor(long)
    local latD = math.floor(lat)
    local longM = round((long-longD)*60,1)
    local latM = round((lat-latD)*60,1)
    local longlat = tostring(longD).."°"..tostring(longM).."N/"..tostring(latD).."°"..tostring(latM).."W"
    return longlat
end

local function processDptInput()
    if get(MCDU_CURRENT_BUTTON) == 0 then
        set(MCDU_CURRENT_PAGE, 41)
    elseif get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 3)
    end
end

function drawDepartureAirportLatRev()
    processDptInput()
    local coords = getBasicLatLong(DEPARTURE_AIRPORT)
    local dptLatLong = generateLongLat(coords[1],coords[2])
    drawText(dptLatLong, 3, 13, MCDU_GREEN, SIZE.HEADER, false, "L")
    drawText("<DEPARTURE", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("FIX INFO>", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("LL WING/INCR/NO", 24, 11, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("[] /[] /[]", 24, 10, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("NEXT WPT", 24, 9, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("[]", 24, 8, MCDU_BLUE, SIZE.OPTION, false, "R")
    drawText("<HOLD", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("NEW DEST", 24, 7, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("[]", 24, 6, MCDU_BLUE, SIZE.OPTION, false, "R")
    drawText("AIRWAYS>", 24, 4, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
end

function processLatRevInput()
    if get(MCDU_CURRENT_BUTTON) == 10 then
        set(MCDU_CURRENT_PAGE, 5)
    elseif get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 3)
    end
end

function drawLatRev()
    processLatRevInput()
    local coords = getBasicLatLong(DEPARTURE_AIRPORT)
    local dptLatLong = generateLongLat(coords[1],coords[2])
    drawText("FIX INFO>", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("LL WING/INCR/NO", 24, 11, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("[] /[] /[]", 24, 10, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("NEXT WPT", 24, 9, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("[]", 24, 8, MCDU_BLUE, SIZE.OPTION, false, "R")
    drawText("<HOLD", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("NEW DEST", 24, 7, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("[]", 24, 6, MCDU_BLUE, SIZE.OPTION, false, "R")
    drawText("AIRWAYS>", 24, 4, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
end



local function addAirway()
    local airways = EXISTING_LATREVS[CURRENT_LATREV_INDEX].airways
    local wpts = EXISTING_LATREVS[CURRENT_LATREV_INDEX].wpts
    if get(MCDU_CURRENT_BUTTON) == #airways + 1 then
        if validateAirway(scratchpad) then
            table.insert(airways, #airways+1, scratchpad)
            scratchpad = ""
        else
            scratchpad = "INVALID AIRWAY"
        end
    end
    if get(MCDU_CURRENT_BUTTON) == #airways+6 then
        if validateAirway(scratchpad) then
            table.insert(wpts, #wpts+1, scratchpad)
            scratchpad = ""
        else
            scratchpad = "INVALID WAYPOINT"
        end
    end
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 4)
    end
end

local function drawAirways()
    local airways = EXISTING_LATREVS[CURRENT_LATREV_INDEX].airways
    local wpts = EXISTING_LATREVS[CURRENT_LATREV_INDEX].wpts
    for i=1, #airways do -- we draw the airways
        drawText(airways[i],1,12-(2*i),MCDU_WHITE,SIZE.OPTION,false,"L")
    end

    for i=1, #wpts do -- We draw the waypoints
        drawText(wpts[i],24,12-(2*i),MCDU_WHITE,SIZE.OPTION,false,"R")
    end
    if #airways ~= #wpts then
        drawText("------",1,#airways+2,MCDU_WHITE,SIZE.OPTION,false,"L",true, "O")
        drawText("[]",24,#airways+1,MCDU_WHITE,SIZE.OPTION,false,"R",true, "O")
    end
    if #airways == #wpts then
        drawText("[]",1,#airways+2,MCDU_WHITE,SIZE.OPTION,false,"L",true, "O")
        drawText("[]",24,#wpts+2,MCDU_WHITE,SIZE.OPTION,false,"R",true, "O")
    end
end

function drawAirway()
    drawText("AIRWAYS FROM "..CURRENT_LATREV, 4, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("VIA", 1, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("TO", 24, 13, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText(SELECTED_DPT_SID, 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText(CURRENT_LATREV, 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")

    addAirway()
    drawAirways()
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
end



function drawInitialLatRev()
    drawText("LAT REV FROM "..CURRENT_LATREV, 4, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    if CURRENT_LATREV == DEPARTURE_AIRPORT then
        drawDepartureAirportLatRev()
    else
        drawLatRev()
    end
end