require "common_declarations"
local lower_press_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")

function draw_press_page()--draw the pressure page
    sasl.gl.drawTexture(lower_press_overlay, 0, 0, 522, 522)--we are drawing the overlay
end