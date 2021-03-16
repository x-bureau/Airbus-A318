require "common_declarations"
local lower_air_cond_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")

function draw_air_cond_page()--draw the air conditioning page
    sasl.gl.drawTexture(lower_air_cond_overlay, 0, 0, 522, 522)--we are drawing the overlay
end