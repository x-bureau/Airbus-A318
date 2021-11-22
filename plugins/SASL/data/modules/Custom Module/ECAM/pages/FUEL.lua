require "common_declarations"
local lower_fuel_overlay = sasl.gl.loadImage("ECAM_LOWER_FUEL_OVERLAY.png")
local fuel_tank_pumps = globalPropertyia("sim/cockpit2/fuel/fuel_tank_pump_on", 8)
local eng1LP = globalProperty("A318/systems/FUEL/ENG1LP")
local eng2LP = globalProperty("A318/systems/FUEL/ENG2LP")
local xfeed_state = globalPropertyi("A318/systems/FUEL/XFEED")
local fuel_current_quantity = globalPropertyfa("sim/cockpit2/fuel/fuel_quantity")
local fuel_flow = createGlobalPropertyf("A318/systems/fuel/fuel_flow")
local weight_fuel = globalPropertyf("sim/flightmodel/weight/m_fuel_total")

local crossFeed = globalPropertyi("A318/systems/FUEL/XFEED")
local apuPump = globalPropertyi("A318/systems/FUEL/APUPump")

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

function draw_fuel_page()--draw the fuel page
    sasl.gl.drawTexture(lower_fuel_overlay, 0, 0, 522, 522, ECAM_COLOURS.WHITE)--we are drawing the overlay
    -- F USED
    -- sasl.gl.drawText(AirbusFont, 175, 87, string.format("%.0f", round(get_weight(get(weight_fuel)), 10)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 262, 440, (get(efb_units) == units.metric and "KG" or "LBS"), 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)

    -- FOB
    sasl.gl.drawText(AirbusFont, 190, 87, (get(efb_units) == units.metric and "KG" or "LBS"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 175, 87, string.format("%.0f", round(get_weight(get(weight_fuel)), 10)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)

    -- F.FLOW
    sasl.gl.drawText(AirbusFont, 190, 115, (get(efb_units) == units.metric and "KG" or "LBS") .. "/MIN", 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 175, 115, string.format("%.2f", round(get_weight(get(fuel_flow)), 0.01)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)

    local function drawQuantities()
        -- centre tank
        sasl.gl.drawText(AirbusFont, 262, 270, round(get_weight(get(fuel_current_quantity, 1)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        -- left inner tank
        sasl.gl.drawText(AirbusFont, 130, 265, round(get_weight(get(fuel_current_quantity, 3)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        -- right inner tank
        sasl.gl.drawText(AirbusFont, 390, 265, round(get_weight(get(fuel_current_quantity, 2)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        -- left outer tank
        sasl.gl.drawText(AirbusFont, 35, 260, round(get_weight(get(fuel_current_quantity, 5)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        -- right outer tank
        sasl.gl.drawText(AirbusFont, 485, 260, round(get_weight(get(fuel_current_quantity, 4)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    end

    local function drawValveStatuses()
        -- drawing the valve statuses

        if get(eng1LP) == 0 then
            sasl.gl.drawCircle(136, 441, 13, true, ECAM_COLOURS.ORANGE)
            sasl.gl.drawCircle(136, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({123,441,  149,441}, 2, ECAM_COLOURS.ORANGE)
        elseif get(eng1LP) == 1 then
            sasl.gl.drawCircle(136, 441, 13, true, ECAM_COLOURS.GREEN)
            sasl.gl.drawCircle(136, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({136,428,  136,454}, 2, ECAM_COLOURS.GREEN)
        end

        if get(eng2LP) == 0 then
            sasl.gl.drawCircle(387, 441, 13, true, ECAM_COLOURS.ORANGE)
            sasl.gl.drawCircle(387, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({374,441,  400,441}, 2, ECAM_COLOURS.ORANGE)
        elseif get(eng2LP) == 1 then
            sasl.gl.drawCircle(387, 441, 13, true, ECAM_COLOURS.GREEN)
            sasl.gl.drawCircle(387, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({387,428,  387,454}, 2, ECAM_COLOURS.GREEN)
        end

        if get(crossFeed) == 0 then
            sasl.gl.drawCircle(262, 401, 13, true, ECAM_COLOURS.GREEN)
            sasl.gl.drawCircle(262, 401, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({262,388,  262,414}, 2, ECAM_COLOURS.GREEN)
        elseif get(crossFeed) == 1 then
            sasl.gl.drawCircle(262, 401, 13, true, ECAM_COLOURS.GREEN)
            sasl.gl.drawCircle(262, 401, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({235,401,  288,401}, 2, ECAM_COLOURS.GREEN)
        end
    end

    local function drawApuStatus()
        sasl.gl.drawText(AirbusFont, 90, 396, "APU", 18, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)

        if get(apuPump) == 1 then
            sasl.gl.drawWidePolyLine({106, 402, 124, 410, 124, 394, 106, 402}, 1, ECAM_COLOURS.GREEN)
            sasl.gl.drawWideLine(124, 402, 135, 402, 1, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawWidePolyLine({106, 402, 124, 410, 124, 394, 106, 402}, 1, ECAM_COLOURS.WHITE)
        end
    end

    local function drawPumpStates()
        -- left tanks
        if get(fuel_tank_pumps, 1) == switch_states.on then
            sasl.gl.drawFrame(122, 311, 28, 29, ECAM_COLOURS.GREEN) -- we are drawing the fuel pump outline
            sasl.gl.drawWidePolyLine({135,311, 135,340}, 2, ECAM_COLOURS.GREEN) -- we are drawing the fuel pump indicator line
        elseif get(fuel_tank_pumps, 1) == switch_states.off then
            sasl.gl.drawFrame(122, 311, 28, 29, ECAM_COLOURS.ORANGE)
            sasl.gl.drawWidePolyLine({128,326, 144,326}, 2, ECAM_COLOURS.ORANGE)
        end
        if get(fuel_tank_pumps, 2) == switch_states.on then
            sasl.gl.drawFrame(157, 311, 28, 29, ECAM_COLOURS.GREEN)
            sasl.gl.drawWidePolyLine({170,311, 170,340}, 2, ECAM_COLOURS.GREEN)
        elseif get(fuel_tank_pumps, 2) == switch_states.off then
            sasl.gl.drawFrame(157, 311, 28, 29, ECAM_COLOURS.ORANGE)
            sasl.gl.drawWidePolyLine({163,326, 179,326}, 2, ECAM_COLOURS.ORANGE)
        end

        -- right tanks
        if get(fuel_tank_pumps, 3) == switch_states.on then
            sasl.gl.drawFrame(338, 311, 28, 29, ECAM_COLOURS.GREEN)
            sasl.gl.drawWidePolyLine({352,311, 352,340}, 2, ECAM_COLOURS.GREEN)
        elseif get(fuel_tank_pumps, 3) == switch_states.off then
            sasl.gl.drawFrame(338, 311, 28, 29, ECAM_COLOURS.ORANGE)
            sasl.gl.drawWidePolyLine({344,326, 360,326}, 2, ECAM_COLOURS.ORANGE)
        end
        if get(fuel_tank_pumps, 4) == switch_states.on then
            sasl.gl.drawFrame(374, 311, 28, 29, ECAM_COLOURS.GREEN)
            sasl.gl.drawWidePolyLine({387,311, 387,340}, 2, ECAM_COLOURS.GREEN)
        elseif get(fuel_tank_pumps, 4) == switch_states.off then
            sasl.gl.drawFrame(374, 311, 28, 29, ECAM_COLOURS.ORANGE)
            sasl.gl.drawWidePolyLine({380,326, 396,326}, 2, ECAM_COLOURS.ORANGE)
        end
        -- centre tanks
        if get(fuel_tank_pumps, 5) == switch_states.on then
            sasl.gl.drawFrame(224, 322, 28, 29, ECAM_COLOURS.GREEN)
            sasl.gl.drawWidePolyLine({238,322, 238,351}, 2, ECAM_COLOURS.GREEN)
        elseif get(fuel_tank_pumps, 5) == switch_states.off then
            sasl.gl.drawFrame(224, 322, 28, 29, ECAM_COLOURS.ORANGE)
            sasl.gl.drawWidePolyLine({229,337, 245,337}, 2, ECAM_COLOURS.ORANGE)
        end
        if get(fuel_tank_pumps, 6) == switch_states.on then
            sasl.gl.drawFrame(271, 322, 28, 29, ECAM_COLOURS.GREEN)
            sasl.gl.drawWidePolyLine({285,322, 285,351}, 2, ECAM_COLOURS.GREEN)
        elseif get(fuel_tank_pumps, 6) == switch_states.off then
            sasl.gl.drawFrame(271, 322, 28, 29, ECAM_COLOURS.ORANGE)
            sasl.gl.drawWidePolyLine({277,337, 293,337}, 2, ECAM_COLOURS.ORANGE)
        end
    end

    drawQuantities()
    drawPumpStates()
    drawValveStatuses()
    drawApuStatus()
end