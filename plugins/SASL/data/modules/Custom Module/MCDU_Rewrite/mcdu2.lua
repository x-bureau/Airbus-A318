include("MCDU_Rewrite/input.lua")
include("MCDU_Rewrite/mcduGlobalData.lua")

position = {1115, 2980, 500, 510}
size = {479, 400}


-- Custom Functions

scratchpad = ""

set(MCDU_CURRENT_PAGE,-22)

function draw()
    mcduPages[get(MCDU_CURRENT_PAGE)][1]() -- We draw the current page
    sasl.gl.drawText(MCDU_FONT, 10, 25, scratchpad, title_location.font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
end