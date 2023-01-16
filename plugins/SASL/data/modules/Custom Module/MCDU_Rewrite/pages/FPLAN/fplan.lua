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


local function processFPLANInput()
    if get(MCDU_CURRENT_BUTTON) == 0 then
        set(MCDU_CURRENT_PAGE,4)
        CURRENT_LATREV = DEPARTURE_AIRPORT
    end
    if get(MCDU_CURRENT_BUTTON) == 25 and #(waypoints) > 1 and FPLAN_SHIFT > 0 then
        FPLAN_SHIFT = FPLAN_SHIFT - 1
        print(FPLAN_SHIFT)
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(waypoints) > 1 and FPLAN_SHIFT < #waypoints-1 then
        FPLAN_SHIFT = FPLAN_SHIFT + 1
        print(FPLAN_SHIFT)
    else
        FPLAN_SHIFT = FPLAN_SHIFT
    end
end

local function drawArrInfo(originUTC, arrDepDist, draw)
    if draw <= 6 and draw > 0 then
        --DESTINATION BAR
        sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[draw], "DEST", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[draw], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[draw], "DIST    EFOB", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
        drawDashField(mcdu_positions[draw], 2, 4)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[draw], DESTINATION_AIRPORT, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[draw], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, 370, mcdu_positions[draw], math.floor(arrDepDist), mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    end
end

local function drawDeptInfo(originUTC, draw)
    if draw <=6 and draw > 0 then
        sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[draw], "FROM", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[draw], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[draw], "SPD/ALT", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)

        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[draw], DEPARTURE_AIRPORT, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[draw], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        drawDashSeparated(mcdu_positions[draw], 3, 3, 2)
    end
end

function drawWpt(waypoint, originUTC, pos)
    if pos <= 6 and pos > 0 then
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[pos], waypoint, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[pos], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_BLUE)
        drawDashSeparated(mcdu_positions[pos], 3, 3, 2)
    end
end

local function drawEndLine(pos)
    if pos <= 6 and pos>0 then
        sasl.gl.drawText(MCDU_FONT, title_location.x+3, mcdu_positions[pos],"------ END OF F-PLN ------", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    end
end

function getFields(waypoints, originUTC, arrDepDist)
    local fields = {

    }
    table.insert(fields, 1, drawDeptInfo(originUTC, 1-FPLAN_SHIFT))
    local val = 1
    if FPLAN_SHIFT > 0 then
        val = 0
    end
    for i in ipairs(waypoints) do
        table.insert(fields, #fields+1, drawWpt(waypoints[i], originUTC, 1+i-FPLAN_SHIFT))
    end
    table.insert(fields, #fields+1, drawArrInfo(originUTC, arrDepDist, (#waypoints+2)-FPLAN_SHIFT))
    table.insert(fields, #fields+1, drawEndLine((#waypoints+3)-FPLAN_SHIFT))
    table.insert(fields, #fields+1, drawDeptInfo(originUTC, (#waypoints+4)-FPLAN_SHIFT))
    table.insert(fields, #fields+1, drawArrInfo(originUTC, arrDepDist, (#waypoints+5)-FPLAN_SHIFT))

    local FPLAN_SCREEN = {}

    for i = 1+FPLAN_SHIFT, 6+SHIFT do
        -- if i == 6 then
        --     table.insert(FPLAN_SCREEN, #fields+1, drawArrInfo(originUTC, arrDepDist, 6))
        -- else
            table.insert(FPLAN_SCREEN, #FPLAN_SCREEN, fields[i])
        -- end

    end
    return FPLAN_SCREEN
end

function drawFPlan()
    --TEMP
    processFPLANInput()
    --END TEMP
    local arrDepDist = calculateAirportDistance(DEPARTURE_AIRPORT, DESTINATION_AIRPORT)
    local FPLAN_TITLE = "FROM "..DEPARTURE_AIRPORT
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y+20, FPLAN_TITLE, title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    local originUTC = formatTime(get(hours),get(minutes))


    -- DRAW WAYPOINTS
 
    waypoints = {

    }

    for i in ipairs(FLIGHT_PLAN) do
        local wpt = string.sub(FLIGHT_PLAN[i], string.find(FLIGHT_PLAN[i], ",", 21)+1, string.find(FLIGHT_PLAN[i], ",", 24)-1)
        if not table.contains(waypoints, wpt) and wpt ~= " " then
            table.insert(waypoints, #waypoints+1, wpt)
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
        sasl.gl.drawText(MCDU_FONT, title_location.x+3, mcdu_positions[4], "------ END OF F-PLN ------", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
        drawDeptInfo(originUTC, 5)
        drawArrInfo(originUTC, arrDepDist, 6)
    end
end