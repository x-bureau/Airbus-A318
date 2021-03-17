require "common_declarations"
local lower_fctl_overlay = sasl.gl.loadImage("ECAM_LOWER_FCTL_OVERLAY.png")
local speedbrake_status = globalPropertyf("sim/flightmodel2/controls/speedbrake_ratio", 10)

function draw_fctl_page()--draw the flight controls page
    sasl.gl.drawTexture(lower_fctl_overlay, 0, 0, 522, 522)--we are drawing the overlay
	--drawing the spoilers
	if get(speedbrake_status, 1) == 1 then
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 1) == 0 then
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 2) == 1 then
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 2) == 0 then
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 3) == 1 then
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 3) == 0 then
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 4) == 1 then
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 4) == 0 then
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 5) == 1 then
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 5) == 0 then
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 6) == 1 then
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 6) == 0 then
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 7) == 1 then
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 7) == 0 then
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 8) == 1 then
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 8) == 0 then 
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 9) == 1 then
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 9) == 0 then
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
	end
	if get(speedbrake_status, 10) == 1 then
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	elseif get(speedbrake_status, 10) == 0 then
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
	else
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.YELLOW)
    end
    
    -- if get(aileron, 1)
end