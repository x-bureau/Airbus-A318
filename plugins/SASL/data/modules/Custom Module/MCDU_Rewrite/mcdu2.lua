include("MCDU_Rewrite/input.lua")
include("MCDU_Rewrite/mcduGlobalData.lua")

position = {1120, 3010, 500, 510}
size = {505, 500}


-- Custom Functions

scratchpad = ""

set(MCDU_CURRENT_PAGE,3)

function draw()
    mcduPages[get(MCDU_CURRENT_PAGE)][1]() -- We draw the current page
    drawText(scratchpad, 1, 1, MCDU_WHITE, SIZE.TITLE, false, "L")
end