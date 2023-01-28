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
    drawText("GPS MONITOR", 7, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    --Dynamic ALT/Time
    local time1 = formatTime(get(hours),get(minutes),get(seconds))
    local time2 = formatTime(get(hours),get(minutes),get(seconds))
    drawText(time1, 8, 10, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText(tostring(math.floor(get(altitude))), 10, 8, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText(time2, 8, 4, MCDU_BLUE, SIZE.OPTION, false, "L")
    --drawText(tostring(math.floor(get(altitude))), 10, 6, MCDU_GREEN, SIZE.OPTION, false, "L")

    --Static Alt/Time Lables
    drawText("UTC", 11, 11, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("GPS ALT", 9, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("UTC", 11, 5, MCDU_WHITE, SIZE.HEADER, false, "L")
    --MCDU OPTION TEXT
    local newLongLat = tostring(generateLongLat(get(longitude),get(latitude)))
    drawText(newLongLat, 1, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText(newLongLat, 1, 6, MCDU_GREEN, SIZE.OPTION, false, "L")
end
