--DRAW THE MCDU MENU
-- PAGE ID: 0

local GREEN_COLOR = {0.0, 1.0, 0.1, 1.0} -- Custom Green Color

function processMenuInput()
    if get(MCDU_CURRENT_BUTTON) == 11 then
        set(MCDU_CURRENT_PAGE, 2)
    elseif get(MCDU_CURRENT_BUTTON) == 9 then
        set(MCDU_CURRENT_PAGE, -2)
    elseif get(MCDU_CURRENT_BUTTON) == 1 then
        set(MCDU_CURRENT_PAGE, 10)
    end
end

function drawMCDUMenu()
    processMenuInput()
    drawText("MCDU MENU", 9, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("<FMGC", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<ATSU", 1, 10, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("<ACMS", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<SAT", 1, 4, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("ARCADE>", 24, 6, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("RETURN>", 24, 2, MCDU_WHITE, SIZE.OPTION, false, "R")
end