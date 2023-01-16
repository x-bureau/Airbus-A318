-- Load Custom Shit
-- local pongBG = sasl.gl.loadImage("MCDU_Rewrite/RickRoll.jpg")
-- local pongBounce = sasl.al.loadSample("MCDU_Rewrite/Custom Sounds/Never Gonna Give You Up Original.wav")
-- local x, y, z = sasl.al.getSamplePosition(pongBounce)
-- sasl.al.setSamplePosition(pongBounce, x, y, z)
-- sasl.al.setSampleEnv(pongBounce, SOUND_EVERYWHERE)
-- sasl.al.playSample(pongBounce)

local function processArcadeMenuInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 0)
    elseif get(MCDU_CURRENT_BUTTON) == 0 then
        set(MCDU_CURRENT_PAGE, -21)
    elseif get(MCDU_CURRENT_PAGE) == -21 and get(MCDU_CURRENT_BUTTON) == 6 then
        set(MCDU_CURRENT_PAGE, -2)
    elseif get(MCDU_CURRENT_PAGE) == -21 and get(MCDU_CURRENT_BUTTON) == 5 then
        --ADD RESET BALL FUNCTION HERE
    elseif get(MCDU_CURRENT_BUTTON) == 1 and get(MCDU_CURRENT_PAGE) == -2 then
        set(MCDU_CURRENT_PAGE, -22)
    end
end

function drawArcadeMenu()
    processArcadeMenuInput()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "X-BUREAU ARCADE", title_location.font_size, true, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<PONG", mcdu_option_size, true, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "<SIMON", mcdu_option_size, true, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, true, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
end