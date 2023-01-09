local optionLablesA = {
    [1] = "POSITION",
    [2] = "IRS",
    [3] = "GPS",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "PRINT",
    [12] = "AOC"
}


function switchDataPage()
    if get(MCDU_CURRENT_BUTTON) == 26 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 22)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 24 and get(MCDU_CURRENT_PAGE) == 22 then
        set(MCDU_CURRENT_PAGE, 2)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 10 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 225)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 11 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 226)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 2 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 223)
        set(MCDU_CURRENT_BUTTON, -1)
    end
end


function drawDataA()
    drawOptionHeadings(optionLablesA)
    -- [ STATIC DRAWINGS ] --
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "DATA INDEX", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 420, title_location.y+10, "1/2", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<MONITOR", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "<MONITOR", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "<MONITOR", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[4], "<A/C STATUS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[5], "FUNCTION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[6], "FUNCTION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
end

local optionLablesB = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "ACTIVE F-PLN",
    [6] = "SEC F-PLN",
    [7] = "PILOTS",
    [8] = "PILOTS",
    [9] = "PILOTS",
    [10] = "PILOTS",
    [11] = "",
    [12] = ""
}

function drawDataB()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "DATA INDEX", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 420, title_location.y+10, "2/2", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<WAYPOINTS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "<NAVAIDS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "<RUNWAYS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[4], "<ROUTES", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[5], "<WINDS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<WINDS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[1], "WAYPOINTS>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[2], "NAVAIDS>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[3], "RUNWAYS>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[4], "ROUTES>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    drawOptionHeadings(optionLablesB)
end