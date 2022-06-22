--Hello World

--Load images
local mcduBackground = sasl.gl.loadImage("mcduBackground.png")

--Create Colors
local CLICK_REGION_GREEN = {0, 1.0, 0, 0.5}
local AIRBUS_BLACK_TEXT = {0.0, 0.0, 0.0, 1.0}
local AIRBUS_WHITE = {1.0, 1.0, 1.0, 1.0}

--Define custom variables
local SHOW_CLICK_REGIONS = 0

--custom functions
function draw_click_regions()
    sasl.gl.drawRectangle(173, 228, 30, 30, CLICK_REGION_GREEN) --A KEY
    sasl.gl.drawRectangle(216, 228, 30, 30, CLICK_REGION_GREEN) --B KEY
    sasl.gl.drawRectangle(258, 228, 30, 30, CLICK_REGION_GREEN) --C KEY
    sasl.gl.drawRectangle(301, 228, 30, 30, CLICK_REGION_GREEN) --D KEY
    sasl.gl.drawRectangle(344, 228, 30, 30, CLICK_REGION_GREEN) --E KEY
--[[KEYS ROW 2]]--
    sasl.gl.drawRectangle(173, 189, 30, 30, CLICK_REGION_GREEN) --F KEY
    sasl.gl.drawRectangle(216, 189, 30, 30, CLICK_REGION_GREEN) --G KEY
    sasl.gl.drawRectangle(258, 189, 30, 30, CLICK_REGION_GREEN) --H KEY
    sasl.gl.drawRectangle(301, 189, 30, 30, CLICK_REGION_GREEN) --I KEY
    sasl.gl.drawRectangle(343, 189, 30, 30, CLICK_REGION_GREEN) --J KEY
--[[KEYS ROW 3]]--
    sasl.gl.drawRectangle(173, 149, 30, 30, CLICK_REGION_GREEN) --K KEY
    sasl.gl.drawRectangle(216, 149, 30, 30, CLICK_REGION_GREEN) --L KEY
    sasl.gl.drawRectangle(258, 149, 30, 30, CLICK_REGION_GREEN) --M KEY
    sasl.gl.drawRectangle(301, 149, 30, 30, CLICK_REGION_GREEN) --N KEY
    sasl.gl.drawRectangle(343, 149, 30, 30, CLICK_REGION_GREEN) --O KEY
--[[KEYS ROW 4]]--
    sasl.gl.drawRectangle(173, 109, 30, 30, CLICK_REGION_GREEN) --P KEY
    sasl.gl.drawRectangle(216, 109, 30, 30, CLICK_REGION_GREEN) --Q KEY
    sasl.gl.drawRectangle(258, 109, 30, 30, CLICK_REGION_GREEN) --R KEY
    sasl.gl.drawRectangle(301, 109, 30, 30, CLICK_REGION_GREEN) --S KEY
    sasl.gl.drawRectangle(343, 109, 30, 30, CLICK_REGION_GREEN) --T KEY
--[[KEYS ROW 5]]--
    sasl.gl.drawRectangle(173, 69, 30, 30, CLICK_REGION_GREEN) --U KEY
    sasl.gl.drawRectangle(216, 69, 30, 30, CLICK_REGION_GREEN) --V KEY
    sasl.gl.drawRectangle(258, 69, 30, 30, CLICK_REGION_GREEN) --W KEY
    sasl.gl.drawRectangle(301, 69, 30, 30, CLICK_REGION_GREEN) --X KEY
    sasl.gl.drawRectangle(343, 69, 30, 30, CLICK_REGION_GREEN) --Y KEY
--[[KEYS ROW 6]]--
    sasl.gl.drawRectangle(173, 29, 30, 30, CLICK_REGION_GREEN) --U KEY
    sasl.gl.drawRectangle(216, 29, 30, 30, CLICK_REGION_GREEN) --V KEY
    sasl.gl.drawRectangle(258, 29, 30, 30, CLICK_REGION_GREEN) --W KEY
    sasl.gl.drawRectangle(301, 29, 30, 30, CLICK_REGION_GREEN) --X KEY
    sasl.gl.drawRectangle(343, 29, 30, 30, CLICK_REGION_GREEN) --Y KEY
end

function draw()
    sasl.gl.drawTexture(mcduBackground, 0, 0, 429, 609)
--[[DRAW EVERYTHING BELOW THIS LINE]]--
--[[ DRAW THE SHOW CLICK REGIONS OPTION ]]--
    sasl.gl.drawText(AirbusFont, 0, 618, "ENABLE SHOW CLICK REGION", 12
    , true, false, TEXT_ALIGN_LEFT, AIRBUS_WHITE)
    sasl.gl.drawRectangle(170, 614, 18, 18, AIRBUS_WHITE)
    if SHOW_CLICK_REGIONS == 1 then
        draw_click_regions()
        sasl.gl.drawText(AirbusFont, 174, 616, "X", 16, true, false, TEXT_ALIGN_LEFT, AIRBUS_BLACK_TEXT)
    end
end

function onMouseDown(component, x, y, button, parentX, parentY)
    if x > 169 and x < 181 and y > 613 and y < 633 and SHOW_CLICK_REGIONS == 0 then
        SHOW_CLICK_REGIONS = 1
    elseif x > 169 and x < 181 and y > 613 and y < 633 and SHOW_CLICK_REGIONS == 1 then
        SHOW_CLICK_REGIONS = 0
    end
end