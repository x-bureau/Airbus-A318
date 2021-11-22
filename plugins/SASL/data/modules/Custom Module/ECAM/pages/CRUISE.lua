require "common_declarations"
local lower_cruise_overlay = sasl.gl.loadImage("ECAM_LOWER_CRUISE.png")
local cabin_alt = globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft")
local cond_temps = globalPropertyfa("A318/systems/aircond/temps/actual", 3)
local ldg_elev = globalPropertyi("A318/systems/aircond/ldg_elev")
local ldg_elev_auto = globalPropertyi("A318/systems/aircond/ldg_elev_auto")
local oil_qty = globalPropertyfa("sim/flightmodel/engine/ENGN_oil_quan", 8)
local vsi = {["value"] = 0, ["colour"] = ECAM_COLOURS["GREEN"], ["blink"] = false}

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

function draw_cruise_page()--draw the cruise page
    sasl.gl.drawTexture(lower_cruise_overlay, 0, 72, 522, 450)--we are drawing the overlay
    -- draw fixed text
    sasl.gl.drawText(AirbusFont, 261, 404, "KG", 16, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)-- F.USED KG
    sasl.gl.drawText(AirbusFont, 460, 228, "FT", 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)-- LDG ELEV FT
    sasl.gl.drawText(AirbusFont, 460, 153, "FT/MIN", 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)-- VS FT/MIN
    sasl.gl.drawText(AirbusFont, 460, 90, "FT", 16, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)-- CABIN ALT FT
    
    --engine 1 fuel used = initial fuel quantity - (the current fuel quantity of tank 1) + (The current fuel quantity of engine 2)
    --sasl.gl.drawText(AirbusFont, 110, 375, get(fuel_used, 1), false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)--we display the fuel used by engine 1
    --sasl.gl.drawText(AirbusFont, 210, 375, get(fuel_used, 2), false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)--we display the fuel used by engine 2

    sasl.gl.drawText(AirbusFont, 180, 447, "0", 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)-- Fuel used 1
    sasl.gl.drawText(AirbusFont, 342, 447, "0", 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)-- Fuel used 2
    sasl.gl.drawText(AirbusFont, 261, 424, "0", 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)-- Fuel used total

    sasl.gl.drawText(AirbusFont, 180, 365, round(get(oil_qty, 1), 0.1), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)--we display the engine 1 oil quantity
    sasl.gl.drawText(AirbusFont, 342, 365, round(get(oil_qty, 2), 0.1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)--we display the engine 2 oil quantity

    sasl.gl.drawText(AirbusFont, 180, 323, "0.1", 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 342, 323, "0.2", 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)

    sasl.gl.drawText(AirbusFont, 180, 293, "0.7", 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 342, 293, "0.7", 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)

    if get(ldg_elev_auto) then
        sasl.gl.drawText(AirbusFont, 333, 228, "AUTO", 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
    end
    sasl.gl.drawText(AirbusFont, 448, 228, get(ldg_elev), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)

    sasl.gl.drawText(AirbusFont, 33, 124, round(get(cond_temps, 1), 1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)-- CKPT A/C temp
    sasl.gl.drawText(AirbusFont, 108, 124, round(get(cond_temps, 2), 1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)-- FWD A/C temp
    sasl.gl.drawText(AirbusFont, 183, 124, round(get(cond_temps, 3), 1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)-- AFT A/C temp
    
    sasl.gl.drawText(AirbusFont, 448, 153, vsi.value, 20, false, false, TEXT_ALIGN_RIGHT, vsi.colour)

    sasl.gl.drawText(AirbusFont, 448, 90, round(get(cabin_alt), 10), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)--we display the current cabin altitude
end