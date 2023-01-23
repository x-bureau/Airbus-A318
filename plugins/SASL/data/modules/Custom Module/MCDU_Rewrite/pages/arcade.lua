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
    elseif get(MCDU_CURRENT_PAGE) == -2 and get(MCDU_CURRENT_BUTTON) == 2 then
        set(MCDU_CURRENT_PAGE, -23)
    end
end

function drawArcadeMenu()
    processArcadeMenuInput()
    drawText("X-BUREAU ARCADE", 5, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("<PONG", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<SIMON", 1, 10, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<SNAKE", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
end