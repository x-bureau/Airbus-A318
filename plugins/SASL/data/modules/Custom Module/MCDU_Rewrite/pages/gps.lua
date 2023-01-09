--PAGE ID: 223
-- Custom colors
local MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
local MCDU_GREEN = {0.0, 1.0, 0.1, 1.0}
local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}

--DATAREFS
local longitude = globalPropertyf("sim/flightmodel/position/longitude")
local latitude = globalPropertyf("sim/flightmodel/position/latitude")
local altitude = globalProperty("A318/systems/ADIRS/1/air/altitude")


local optionLabels = {
    [1] = "GPS1 POSITION",
    [2] = "TTRK",
    [3] = "MERIT",
    [4] = "GPS2 POSITION",
    [5] = "TTRK",
    [6] = "MERIT",
    [7] = "",
    [8] = "GS",
    [9] = "MODE/SAT",
    [10] = "",
    [11] = "GS",
    [12] = "MODE/SAT"
}



local function generateLongLat(long, lat)
    local longD = math.floor(long)
    local latD = math.floor(lat)
    local longM = round((long-longD)*60,1)
    local latM = round((lat-latD)*60,1)
    local longlat = tostring(longD).."°"..tostring(longM).."N/"..tostring(latD).."°"..tostring(latM).."W"
    return longlat
end

local function formatTime(hours, mins, secs)
    local h0 = ""
    local m0 = ""
    local s0 = ''
    if hours <= 9 then
        h0 = "0"
    else
        s0 = ""
    end
    if mins <= 9 then
        m0 = "0"
    else
        s0 = ""
    end
    if secs <= 9 then
        s0 = "0"
    else
        s0 = ""
    end
    local UTC_TIME = h0..tostring(hours)..":"..m0..tostring(mins)..":"..s0..tostring(secs)
    return UTC_TIME
end

function drawGPSMonitor()
    --Static drawings
    drawOptionHeadings(optionLabels)
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y+13, "GPS MONITOR", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    --Dynamic ALT/Time
    local time1 = formatTime(get(hours),get(minutes),get(seconds))
    local time2 = formatTime(get(hours),get(minutes),get(seconds))
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[2], time1, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[3], math.floor(get(altitude)), mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[5], time2, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[6], math.floor(get(altitude)), mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    --Static Alt/Time Lables
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[2], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[3], "GPS ALT", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[5], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[6], "GPS ALT", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    --MCDU OPTION TEXT
    local newLongLat = generateLongLat(get(longitude),get(latitude))
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1]+4, newLongLat, 22, false, false, TEXT_ALIGN_LEFT, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[4]+4, newLongLat, 22, false, false, TEXT_ALIGN_LEFT, MCDU_GREEN)
end
