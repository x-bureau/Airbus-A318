require "common_declarations"
local lower_wheel_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")

function draw_wheel_page()--draw the wheels page
    sasl.gl.drawTexture(lower_wheel_overlay, 0, 0, 522, 522)--we are drawing the overlay
end