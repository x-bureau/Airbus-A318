require "common_declarations"
local lower_sts_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")

function draw_sts_page()--draw the systems page
    sasl.gl.drawTexture(lower_sts_overlay, 0, 0, 522, 522)--we are drawing the overlay
end