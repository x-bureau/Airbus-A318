require "common_declarations"
local lower_doors_overlay = sasl.gl.loadImage("ECAM_LOWER_DOORS_OVERLAY.png")
local door_status = globalPropertyfa("sim/flightmodel2/misc/door_open_ratio", 10)
local vsi = {["value"] = 0, ["colour"] = ECAM_COLOURS["GREEN"], ["blink"] = false}

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

function draw_doors_page()--draw the doors page
    sasl.gl.drawTexture(lower_doors_overlay, 0, 0, 522, 522)--18, -3, 542, 542)--we are drawing the overlay

    -- Vertical speed
    sasl.gl.drawText(AirbusFont, 362, 410, 'V/S', 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)

    -- sasl.gl.drawWidePolyLine({403, 411, 410, 411, 423, 424, 417, 423, 423, 418, 423, 424}, 2, vsi["colour"])
    sasl.gl.drawTriangle(424, 417, 423, 423, 418, 423, vsi["colour"])
    sasl.gl.drawText(AirbusFont, 476, 410, string.format("%.f", round(vsi["value"], 50)), 20, false, false, TEXT_ALIGN_RIGHT, vsi["colour"])
    sasl.gl.drawText(AirbusFont, 482, 410, "FT/MIN", 14, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)

    -- door 1 - CPT FRONT
    sasl.gl.drawWidePolyLine({228, 350, 228, 368, 238, 368, 238, 350, 227, 350}, 2, ECAM_COLOURS.GREEN)
    -- door 2 - FO FRONT
    sasl.gl.drawWidePolyLine({283, 350, 283, 368, 293, 368, 293, 350, 282, 350}, 2, ECAM_COLOURS.GREEN)
    -- door 3 - fwd cargo
    sasl.gl.drawWidePolyLine({277, 297, 277, 315, 293, 315, 293, 297, 276, 297}, 2, ECAM_COLOURS.GREEN)
    -- L slide
    sasl.gl.drawWidePolyLine({228, 230, 228, 248, 238, 248, 238, 230, 227, 230}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 217, 232, 'SLIDE', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    -- R slide
    sasl.gl.drawWidePolyLine({283, 230, 283, 248, 293, 248, 293, 230, 282, 230}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 306, 232, 'SLIDE', 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)

    -- door 4 - aft cargo
    sasl.gl.drawWidePolyLine({277, 172, 277, 190, 293, 190, 293, 172, 276, 172}, 2, ECAM_COLOURS.GREEN)

    -- door 5 - CPT aft
    sasl.gl.drawWidePolyLine({228, 110, 228, 128, 238, 128, 238, 110, 227, 110}, 2, ECAM_COLOURS.GREEN)

    -- door 6 - FO aft
    sasl.gl.drawWidePolyLine({283, 110, 283, 128, 293, 128, 293, 110, 282, 110}, 2, ECAM_COLOURS.GREEN)

    -- avionics
    sasl.gl.drawWidePolyLine({253, 428, 253, 436, 268, 436, 268, 428, 252, 428}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawWidePolyLine({271, 398, 271, 413, 279, 413, 279, 398, 270, 398}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawWidePolyLine({243, 398, 243, 413, 251, 413, 251, 398, 242, 398}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawWidePolyLine({278, 140, 278, 158, 285, 158, 285, 140, 277, 140}, 2, ECAM_COLOURS.GREEN)

    if get(door_status, 1) == 0 then--if the door open ratio is = 0
        -- sasl.gl.drawWidePolyLine({225, 350, 225, 370, 238, 370, 238, 350, 224, 350}, 3, ECAM_COLOURS.GREEN)
        -- sasl.gl.drawFrame(223, 350, 13, 20, ECAM_COLOURS.GREEN)--draw a green rectangle
    elseif get(door_status, 1) > 0 then--if the door open ratio is = 1
        sasl.gl.drawText(AirbusFont, 218, 355, 'CABIN -----------', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawRectangle(228, 350, 10, 18, ECAM_COLOURS.YELLOW)--draw a red rectangle
    -- else--anything else results in a yellow rectangle
    --     sasl.gl.drawRectangle(225, 350, 11, 18, ECAM_COLOURS.RED)
    end

    if get(door_status, 2) > 0 then
        sasl.gl.drawText(AirbusFont, 302, 355, '----------- CABIN', 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawRectangle(283, 350, 10, 18, ECAM_COLOURS.YELLOW)
    end

    if get(door_status, 3) == 1 then
        sasl.gl.drawText(AirbusFont, 302, 300, '------ CARGO', 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawRectangle(277, 297, 16, 18, ECAM_COLOURS.YELLOW)
    elseif get(door_status, 3) > 0 then
        sasl.gl.drawRectangle(277, 297, 16, 18, ECAM_COLOURS.RED)
    end

    if get(door_status, 4) == 1 then
        sasl.gl.drawText(AirbusFont, 302, 175, '------ CARGO', 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawRectangle(277, 172, 16, 18, ECAM_COLOURS.YELLOW)
    elseif get(door_status, 4) > 0 then
        sasl.gl.drawRectangle(277, 172, 16, 18, ECAM_COLOURS.RED)
    end

    if get(door_status, 5) > 0 then
        sasl.gl.drawText(AirbusFont, 218, 115, 'CABIN -----------', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawRectangle(228, 110, 10, 18, ECAM_COLOURS.YELLOW)
    end

    if get(door_status, 6) > 0 then
        sasl.gl.drawText(AirbusFont, 302, 115, '----------- CABIN', 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawRectangle(283, 110, 10, 18, ECAM_COLOURS.YELLOW)
    -- else
    --     sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_COLOURS.RED)
    end

end