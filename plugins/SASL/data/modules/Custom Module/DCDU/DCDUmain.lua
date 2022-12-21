-- A318 Created by X-Bureau --
position = {810, 3530, 720, 530}

-- position = {1, 5, 10, 25}
size = {720, 530}
local DCDU_WHITE = {1.0 , 1.0 , 1.0 , 1.0}
local DCDU_GREEN = {0.0, 1.0, 0.0, 1.0}
local AIRBUS_FONT = sasl.gl.loadFont("fonts/PanelFont.ttf")

-- Colors

function drawBkgnd()
    sasl.gl.drawRectangle(10,175,680,4,DCDU_WHITE)
    sasl.gl.drawRectangle(180,170,4,-165,DCDU_WHITE)
    sasl.gl.drawRectangle(520,170,4,-165,DCDU_WHITE)
end
function draw()
    drawBkgnd()
    sasl.gl.drawText(AIRBUS_FONT,30,400,"NO ACTIVE ATC",46,true,false,TEXT_ALIGN_LEFT,DCDU_GREEN)
end