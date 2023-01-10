CURRENT_LATREV = ""
local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}

local function generateLongLat(long, lat)
    local longD = math.floor(long)
    local latD = math.floor(lat)
    local longM = round((long-longD)*60,1)
    local latM = round((lat-latD)*60,1)
    local longlat = tostring(longD).."°"..tostring(longM).."N/"..tostring(latD).."°"..tostring(latM).."W"
    return longlat
end

function drawDepartureAirportLatRev()
    local coords = getBasicLatLong(DEPARTURE_AIRPORT)
    local dptLatLong = generateLongLat(coords[1],coords[2])
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[1], dptLatLong, option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<DEPARTURE", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, mcdu_positions[1], "FIX INFO>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, option_heading_locations[2]-4, "LL WING/INCR/NO", option_heading_font_size+3, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, mcdu_positions[2], "[ ]°/[ ]°/[]", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 480, option_heading_locations[3]-4, "NEXT WPT", option_heading_font_size+3, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, mcdu_positions[3], "[ ]", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "<HOLD", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, option_heading_locations[4]-4, "NEW DEST", option_heading_font_size+3, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, mcdu_positions[4], "[ ]", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 480, mcdu_positions[5], "AIRWAYS>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)


    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
end


function drawInitialLatRev()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y+20, "LAT REV FROM "..CURRENT_LATREV, title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    if CURRENT_LATREV == DEPARTURE_AIRPORT then
        drawDepartureAirportLatRev()
    end
end