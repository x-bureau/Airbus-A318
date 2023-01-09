------------------------------------------------------
--                MCDU WRITTEN BY:
--                  - FBI914
------------------------------------------------------


--Custom Colors
local MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
local MCDU_GREEN = {0.0, 1.0, 0.1, 1.0}
local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}

-- INPUT HANDLER
function switchPrintAOCPage()
    if get(MCDU_CURRENT_BUTTON) == 26 and get(MCDU_CURRENT_PAGE) == 225 then
        set(MCDU_CURRENT_PAGE, 2251)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 24 and get(MCDU_CURRENT_PAGE) == 2251 then
        set(MCDU_CURRENT_PAGE, 225)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 11 and get(MCDU_CURRENT_PAGE) == 225 then
        set(MCDU_CURRENT_PAGE,226)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 11 and get(MCDU_CURRENT_PAGE) == 226 then
        set(MCDU_CURRENT_PAGE, 225)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 26 and get(MCDU_CURRENT_PAGE) == 226 then
            set(MCDU_CURRENT_PAGE, 2261)
            set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 24 and get(MCDU_CURRENT_PAGE) == 2261 then
        set(MCDU_CURRENT_PAGE, 226)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 5 and (get(MCDU_CURRENT_PAGE) == 225 or get(MCDU_CURRENT_PAGE) == 2251 or get(MCDU_CURRENT_PAGE) == 226 or get(MCDU_CURRENT_PAGE == 2261)) then
        set(MCDU_CURRENT_PAGE, 2)
        set(MCDU_CURRENT_BUTTON, -1)
    end
end

local optionLablesA = {
    [1] = "AUTO",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "MANUAL",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "AOC"
}

local function processPrintInput()
    if get(MCDU_CURRENT_BUTTON) >= 6 and get(MCDU_CURRENT_BUTTON) <= 8 and get(MCDU_CURRENT_PAGE) == 225 then
        scratchpad = "PRINTER NOT AVAILABLE"
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) >= 6 and get(MCDU_CURRENT_BUTTON) <= 9 and get(MCDU_CURRENT_PAGE) == 2251 then
        scratchpad = "PRINTER NOT AVAILABLE"
        set(MCDU_CURRENT_BUTTON, -1)
    end
end

function drawPrintA()
    --STATIC DRAWINGS
    processPrintInput()
    drawOptionHeadings(optionLablesA)
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "PRINT FUNCTION", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 420, title_location.y+10, "1/2", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[1], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[2], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[3], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1], "F-PLN INIT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[2], "TO DATA", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[3], "WIND DATA", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[6], "FUNCTION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)

end

local optionLabelsB = {
    [1] = "AUTO",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "MANUAL",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "AOC"
}
function drawPrintB()
    --STATIC DRAWINGS
    processPrintInput()
    drawOptionHeadings(optionLabelsB)
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "PRINT FUNCTION", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 420, title_location.y+10, "2/2", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[1], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[2], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[3], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[4], "PRINT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[4], "*NO", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1], "PREFLIGHT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[2], "INFLIGHT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[3], "POSTFLIGHT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[4], "SEC F-PLN", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[6], "FUNCTION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
end

local optionLablesC = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "UPLINK",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "PRINT"
}

function drawAOCA()
    -- STATIC DRAWINGS
    drawOptionHeadings(optionLablesC)
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "AOC FUNCTION", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 420, title_location.y+10, "1/2", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[1], "REQ*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[2], "REQ*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[3], "REQ*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1], "F-PLN INIT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[2], "TO DATA", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[3], "WIND DATA", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[6], "FUNCTION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
end

local optionLablesD = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "REPORT",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "PRINT"
}

function drawAOCB()
    --STATIC DRAWINGS
    drawOptionHeadings(optionLablesD)
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "AOC FUNCTION", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 420, title_location.y+10, "2/2", option_heading_font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[1], "SEND*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[2], "SEND*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1], "F-PLN RPT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[2], "POSITION RPT", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[6], "FUNCTION>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
end