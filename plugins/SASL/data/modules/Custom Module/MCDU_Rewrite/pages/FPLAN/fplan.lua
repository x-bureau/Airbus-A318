--Custom Colors
local MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
local MCDU_GREEN = {0.0, 1.0, 0.1, 1.0}
local MCDU_BLUE = {0.0, 0.8, 1.0, 1.0}

FPLAN_SHIFT = 0
------------------------------
-- [ FLIGHT PLAN STRUCTURE] -- 
------------------------------

FLIGHT_PLAN = {
}

waypoints = {}

------------------------------
local function formatTime(hours, mins)
    local h0 = ""
    local m0 = ""
    if hours <= 9 then
        h0 = "0"
    else
        h0 = ""
    end
    if mins <= 9 then
        m0 = "0"
    else
        m0 = ""
    end
    local UTC_TIME = h0..tostring(hours)..m0..tostring(mins)
    return UTC_TIME
end

local function predictTime(wpt)
    local cords = getBasicLatLong(DEPARTURE_AIRPORT)
    local wptLat, wptLong = getWptCord(wpt)
    local distance = calculateDistance(cords[1], cords, wptLat, wptLong)

    -- Rate x Time = distance --> Distance/Rate = Time --> convert KTS 
    -- OUR (Temporary) Constant will be 7.5594, which is the standard economical cruising speed of an A320
    -- converted from 840 km/h to kts/minute
    local timeMINS = round(distance/7.5594,0)
    local hours = timeMINS%60
    local mins = timeMINS-hours*60
    return formatTime(hours, mins)
end

local function processFPLANInput()
    if get(MCDU_CURRENT_BUTTON) == 0 and FPLAN_SHIFT == 0 then
        set(MCDU_CURRENT_PAGE,4)
        CURRENT_LATREV = DEPARTURE_AIRPORT
    end
    if get(MCDU_CURRENT_BUTTON) == 25 and #(waypoints) > 1 and FPLAN_SHIFT > 0 then
        FPLAN_SHIFT = FPLAN_SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(waypoints) > 1 and FPLAN_SHIFT < #waypoints-1 then
        FPLAN_SHIFT = FPLAN_SHIFT + 1
    else
        FPLAN_SHIFT = FPLAN_SHIFT
    end
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 4)
        CURRENT_LATREV = DESTINATION_AIRPORT
    end
    if #waypoints == 0 and get(MCDU_CURRENT_BUTTON) == 2 then
        set(MCDU_CURRENT_PAGE, 4)
        CURRENT_LATREV = DESTINATION_AIRPORT
    end
end

local function drawArrInfo(originUTC, arrDepDist, draw)
    if draw <= 6 and draw > 0 then
        --DESTINATION BAR
        drawText("DEST", 1, draw, MCDU_WHITE, SIZE.HEADER, false, "L", true, "H")
        drawText("UTC", 10, draw, MCDU_WHITE, SIZE.HEADER, false, "L", true, "H")
        drawText("DIST EFOB", 24, draw, MCDU_WHITE, SIZE.HEADER, false, "R", true, "H")
        drawText("----", 24, draw, MCDU_WHITE, SIZE.OPTION, false, "R", true, "O")
        drawText(DESTINATION_AIRPORT, 1, draw, MCDU_WHITE, SIZE.OPTION, false, "L", true, "O")
        drawText(originUTC, 10, draw, MCDU_WHITE, SIZE.OPTION, false, "L", true, "O")
        drawText(tostring(math.floor(arrDepDist)), 16, draw, MCDU_WHITE, SIZE.OPTION, false, "L", true, "O")
    end
end

local function drawDeptInfo(originUTC, draw)
    if draw <=6 and draw > 0 then
        drawText("FROM", 1, draw, MCDU_WHITE, SIZE.HEADER, false, "L", true, "H")
        drawText("UTC", 10, draw, MCDU_WHITE, SIZE.HEADER, false, "L", true, "H")
        drawText("SPD/ALT", 24, draw, MCDU_WHITE, SIZE.HEADER, false, "R", true, "H")


        drawText(DEPARTURE_AIRPORT, 1, draw, MCDU_WHITE, SIZE.OPTION, false, "L", true, "O")
        drawText(originUTC, 10, draw, MCDU_WHITE, SIZE.OPTION, false, "L", true, "O")
        drawText("---/---", 24, draw, MCDU_WHITE, SIZE.OPTION, false, "R", true, "O")
    end
end

local function drawWpt(waypoint, utc, pos)
    local wpt = waypoint
    local awy = ""
    if string.find(waypoint, ":") then
        wpt = string.sub(waypoint, 0, string.find(waypoint, ":")-1)
        awy = string.sub(waypoint, string.find(waypoint, ":")+1)
    end
    if pos <= 5 and pos > 0 then
        if awy~="" then
            drawText(awy, 1, pos, MCDU_WHITE, SIZE.HEADER, false, "L", true, "H")
        end
        drawText(wpt, 1, pos, MCDU_GREEN, SIZE.OPTION, false, "L", true, "O")
        drawText(utc, 10, pos, MCDU_GREEN, SIZE.OPTION, false, "L", true, "O")
        drawText("---/---", 24, pos, MCDU_WHITE, SIZE.OPTION, false, "R", true, "O")
    end
end

local function drawEndLine(pos)
    if pos <= 6 and pos>0 then
        drawText("------END OF F-PLN------", 1, pos, MCDU_WHITE, SIZE.OPTION, false, "L", true, "O")
    end
end

function getFields(waypoints, originUTC, arrDepDist)
    fields = {}

    table.insert(fields, 1, drawDeptInfo(originUTC, 1-FPLAN_SHIFT))

    for i in ipairs(waypoints) do
        table.insert(fields, #fields+1, drawWpt(waypoints[i], originUTC, 1+i-FPLAN_SHIFT))
    end

    table.insert(fields, #fields+1, drawArrInfo(originUTC, arrDepDist, (#waypoints+2)-FPLAN_SHIFT))
    table.insert(fields, #fields+1, drawEndLine((#waypoints+3)-FPLAN_SHIFT))
    table.insert(fields, #fields+1, drawDeptInfo(originUTC, (#waypoints+4)-FPLAN_SHIFT))
    table.insert(fields, #fields+1, drawArrInfo(originUTC, arrDepDist, (#waypoints+5)-FPLAN_SHIFT))

    local FPLAN_SCREEN = {}

    for i = 1, 6 do
        if i == 6 and fields[i+FPLAN_SHIFT] < #fields-3 then
             table.insert(FPLAN_SCREEN, 6, drawArrInfo(originUTC, arrDepDist, 6))
        elseif i < 5 then
            table.insert(FPLAN_SCREEN, i, fields[i+FPLAN_SHIFT])
        end
    end
    return FPLAN_SCREEN
end

local function processCurrentLatrev()
    if get(MCDU_CURRENT_BUTTON) > -1 and get(MCDU_CURRENT_BUTTON) < 5 then
        if get(MCDU_CURRENT_BUTTON)+FPLAN_SHIFT~=0 and get(MCDU_CURRENT_BUTTON)+FPLAN_SHIFT < #fields-4 then
            CURRENT_LATREV = waypoints[get(MCDU_CURRENT_BUTTON)+FPLAN_SHIFT]
            local index = 0
            for i in ipairs(EXISTING_LATREVS) do
                if EXISTING_LATREVS[i][1] == CURRENT_LATREV then
                    index = i
                    break
                end
            end
            if index == 0 then
                table.insert(EXISTING_LATREVS, #EXISTING_LATREVS+1, {CURRENT_LATREV, 1+#EXISTING_LATREVS, airways = {}, wpts = {}})
            end

            CURRENT_LATREV_INDEX = #EXISTING_LATREVS
            set(MCDU_CURRENT_PAGE, 4)
        end
    end
end

function drawFPlan()
    -- TESTING AIRPORTS
    DEPARTURE_AIRPORT = "KMIA"
    DESTINATION_AIRPORT = "KDTW"
    --TEMP
    processFPLANInput()
    processCurrentLatrev()
    --END TEMP
    local arrDepDist = calculateAirportDistance(DEPARTURE_AIRPORT, DESTINATION_AIRPORT)
    local FPLAN_TITLE = "FROM "..DEPARTURE_AIRPORT
    drawText(FPLAN_TITLE, 8, 14, MCDU_WHITE, SIZE.TITLE, false, "L", false)
    local originUTC = formatTime(get(hours),get(minutes))


    if #EXISTING_LATREVS ~= 0 then
        for i in ipairs(EXISTING_LATREVS) do
            if #EXISTING_LATREVS[i].wpts ~= 0 then
                for j in ipairs(EXISTING_LATREVS[i].wpts) do
                    local wpt = EXISTING_LATREVS[i].wpts[j]
                    if EXISTING_LATREVS[i].airways[j] ~= "" then
                        wpt = wpt..":"..EXISTING_LATREVS[i].airways[j]
                    end
                    if not table.contains(FLIGHT_PLAN, EXISTING_LATREVS[i].wpts[j]) then
                        table.insert(FLIGHT_PLAN, #FLIGHT_PLAN+1, wpt)
                    end
                end
            end
        end
    end

    for i in ipairs(FLIGHT_PLAN) do
        if string.len(FLIGHT_PLAN[i]) > 7 then
            local wpt = string.sub(FLIGHT_PLAN[i], string.find(FLIGHT_PLAN[i], ",", 21)+1, string.find(FLIGHT_PLAN[i], ",", 24)-1)
            if not table.contains(waypoints, wpt) and wpt ~= " " then
                table.insert(waypoints, #waypoints+1, wpt)
            end
        elseif string.len(FLIGHT_PLAN[i]) < 7 then
            if not table.contains(waypoints, FLIGHT_PLAN[i]) then
                table.insert(waypoints, FLIGHT_PLAN[i])
            end
        end
    end


    if #waypoints ~= 0 then
        FLIGHT_PLAN_SCREEN = getFields(waypoints, originUTC, arrDepDist)
        wrap(FLIGHT_PLAN_SCREEN, FPLAN_SHIFT)

    end
    if #waypoints == 0 then
        drawDeptInfo(originUTC, 1)
        drawWpt("DECEL", originUTC, 2)
        drawArrInfo(originUTC, arrDepDist, 3)
        drawEndLine(4)
        drawDeptInfo(originUTC, 5)
        drawArrInfo(originUTC, arrDepDist, 6)
    end
end