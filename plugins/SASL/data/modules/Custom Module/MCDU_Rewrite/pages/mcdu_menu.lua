--DRAW THE MCDU MENU
-- PAGE ID: 0

local GREEN_COLOR = {0.0, 1.0, 0.1, 1.0} -- Custom Green Color

function drawMCDUMenu()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "MCDU MENU", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 0, mcdu_positions[1], "<FMGC", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, GREEN_COLOR)
    sasl.gl.drawText(MCDU_FONT, 0, mcdu_positions[2], "<ATSU", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 0, mcdu_positions[3], "<ACMS", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 0, mcdu_positions[5], "<SAT", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 500, mcdu_positions[6], "RETURN>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
end

--ADD SEPARATE INPUT HANDLER HERE