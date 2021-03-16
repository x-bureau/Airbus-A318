require "common_declarations"
local lower_bleed_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")

function draw_bleed_page()--draw the bleed page
    sasl.gl.drawTexture(lower_bleed_overlay, 0, 0, 522, 522)--we are drawing the overlay
end