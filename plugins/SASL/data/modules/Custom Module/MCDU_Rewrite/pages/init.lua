local optionLables = {
    [1] = "CO RTE",
    [2] = "ALTN/CO RTE",
    [3] = "FLT NUMBER",
    [4] = "LAT",
    [5] = "COST INDEX",
    [6] = "CRZ FL/TEMP",
    [7] = "FROM/TO",
    [8] = "",
    [9] = "",
    [10] = "LONG",
    [11] = "TROPO",
    [12] = "GND TEMP"
}
local MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}

local inputs = {
    -- Format = {side, position, field length, color, message}
    CO_RTE = {1, 1, 10, MCDU_WHITE, " "},
    ALTN_CO_RTE = {1, 2, 15, MCDU_WHITE, " "},
    FLT_NBR = {1, 3, 8, MCDU_WHITE, " "},
    LAT = {1, 4, 6, MCDU_WHITE, " "},
    COST_INDEX = {1, 5, 3, MCDU_WHITE, " "},
    CRZ_FL_TEMP = {1, 6, 9, MCDU_WHITE, " "},
    FROM_TO = {2, 1, 9, MCDU_WHITE, " "},
    LONG = {2, 4, 6, MCDU_WHITE, " "},
    WIND = {2, 5}
}
function processCoRte()
    if string.len(scratchpad) == inputs.CO_RTE[3] and get(MCDU_CURRENT_BUTTON) == 0 then
        inputs.CO_RTE[5] = scratchpad
        set(MCDU_CURRENT_BUTTON, -1)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 0 and string.len(scratchpad) ~= inputs.CO_RTE[3] then
        scratchpad = "ERROR"
    end
end

function processAltnCoRte()
    if string.len(scratchpad) == inputs.ALTN_CO_RTE[3]and get(MCDU_CURRENT_BUTTON) == 1 and string.sub(scratchpad,5,5) == "/"then
        inputs.ALTN_CO_RTE[5] = scratchpad
        set(MCDU_CURRENT_BUTTON,-1)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 1 and (string.len(scratchpad) ~= inputs.ALTN_CO_RTE[3] or string.sub(scratchpad, 5,6) ~= "/") then
        print(string.sub(scratchpad, 5,5))
        scratchpad = "ERROR"
    end
end

function processFltNbr()
    if string.len(scratchpad) <= inputs.FLT_NBR[3] and string.len(scratchpad) >= 3 and get(MCDU_CURRENT_BUTTON) == 2 then
        inputs.FLT_NBR[5] = scratchpad
        set(MCDU_CURRENT_BUTTON,-1)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 2 and (string.len(scratchpad) > inputs.ALTN_CO_RTE[3] or string.len(scratchpad) < 3)  then
        scratchpad = "ERROR"
    end
end



function drawInit()
    processCoRte()
    if inputs.CO_RTE[5] == " " then
        drawTextFieldBoxes(10, MCDU_ORANGE, 0, mcdu_positions[1],1)
    else
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], inputs.CO_RTE[5], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end

    processAltnCoRte()
    if inputs.ALTN_CO_RTE[5] == " " then
        drawDashSeparated(mcdu_positions[2], 4, 10,1)
    else
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], inputs.ALTN_CO_RTE[5], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end

    processFltNbr()
    if inputs.FLT_NBR[5] == " " then
        drawTextFieldBoxes(8, MCDU_ORANGE, 0, mcdu_positions[3],1)
    else
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], inputs.FLT_NBR[5], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end

    --STATIC DRAWINGS
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "INIT", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[2], "INIT", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[2], "INOP*", mcdu_option_size, false, true, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(MCDU_FONT, 490, mcdu_positions[4], "WIND>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    drawTextFieldBoxes(9, MCDU_ORANGE, 490, mcdu_positions[1],2)
    drawOptionHeadings(optionLables)
    drawDashDotSeparated(mcdu_positions[4], 4, 1, 1)
    drawDashField(mcdu_positions[5], 1, 3)
    drawDashSeparated(mcdu_positions[6], 5, 3,1)
    drawDashField(mcdu_positions[6], 2, 3)
end
