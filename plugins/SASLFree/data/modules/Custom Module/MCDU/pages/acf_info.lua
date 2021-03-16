-- PAGE KEY: 2

local inputs = {
    chg_code = {"", 'l', 5, 3}
}

local function drawStaticTitles()
    sasl.gl.drawText(MCDU_FONT, 17, option_heading_locations[1], "ENG", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 17, option_heading_locations[2], "ACTIVE DATA BASE", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 17, option_heading_locations[3], "SECOND DATA BASE", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 17, option_heading_locations[5], "CHG CODE", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 17, option_heading_locations[6], "IDLE/PERF", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[1], ENG_TYPE, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[2])
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[2], "AIRAC CYCLE "..getAiracCycle(), mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[3], "NONE", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[6], "+0.0/+0.0", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[2])
end

local function drawInputs()
    for k, v in pairs(inputs) do
        if v[1] == "" then
            drawBrackets(v[2], v[3], v[4])
        else
            sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[v[3]], "["..v[1].."]", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
        end
    end
end

function acf_info_key_input(side, key)
    if side == 'l' and key == 5 then
        if SCRATCHPAD ~= "ARM" then
            SCRATCHPAD = "INVALID INPUT"
        else
            inputs.chg_code[1] = SCRATCHPAD
            clearScratchpad()
        end
    end
end

function draw_acf_info()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "A318-100", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawStaticTitles()
    drawInputs()
end