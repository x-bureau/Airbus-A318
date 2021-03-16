require "common_declarations"
local lower_engine_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")

function draw_eng_page()--draw engine page
    sasl.gl.drawTexture(lower_engine_overlay, 0, 0, 522, 522)--we are drawing the overlay
end