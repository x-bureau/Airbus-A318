--Custom Colors
local MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
local MCDU_GREEN = {0.0, 1.0, 0.1, 1.0}
local MCDU_BLUE = {0.0, 0.8, 1.0, 1.0}


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
end


function drawFPlan()
    --TEMP
    DEPARTURE_AIRPORT = "KMIA"
    DESTINATION_AIRPORT = "KDTW"
    processFPLANInput()
    --END TEMP
    local arrDepDist = calculateAirportDistance(DEPARTURE_AIRPORT, DESTINATION_AIRPORT)
    local FPLAN_TITLE = "FROM "..DEPARTURE_AIRPORT
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y+20, FPLAN_TITLE, title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], DEPARTURE_AIRPORT, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    local originUTC = formatTime(get(hours),get(minutes))
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], DESTINATION_AIRPORT, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[3], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 370, mcdu_positions[3], math.floor(arrDepDist), mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)


    sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[1], "FROM", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[1], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[1], "SPD/ALT", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[3], "DEST", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[3], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[3], "DIST    EFOB", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)

    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "DECEL", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[2], "0000", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_BLUE)
    
    drawDashSeparated(mcdu_positions[1], 3, 3, 2)
    drawDashSeparated(mcdu_positions[2], 3, 3, 2)
    
    --DRAW END OF F-PLN LINE
    drawDashField(mcdu_positions[4], 1, 9)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[4], "END OF F-PLN", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    drawDashField(mcdu_positions[4], 2, 9)

    --DRAW HEADINGS
    sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[5], "FROM", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[5], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[5], "SPD/ALT", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)


    --DESTINATION BAR
    sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[6], "DEST", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[6], "UTC", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[6], "DIST    EFOB", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    drawDashField(mcdu_positions[6], 2, 4)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], DESTINATION_AIRPORT, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[6], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 370, mcdu_positions[6], math.floor(arrDepDist), mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    

    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[5], DEPARTURE_AIRPORT, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[5], originUTC, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    drawDashSeparated(mcdu_positions[5], 3, 3, 2)
end