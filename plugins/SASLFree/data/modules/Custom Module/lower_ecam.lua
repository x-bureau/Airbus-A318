--A318 by X-Bureau--
position = {1170, 50, 522, 522}
size = {522, 522}
require "common_declarations"

--defining dataref variables
local current_ecam_page = createGlobalPropertyi("A318/cockpit/ecam/current_page", 13)--create variable that tells us current ecam page
local current_flight_phase = createGlobalPropertyi("A318/cockpit/ecam/flight_phase", flight_phases.elec_pwr)
local auto_change_page = false
local fuel_used = createGlobalPropertyfa("A318/systems/fuel/fuel_used", 2)--we define the amount of fuel used by each engine
local fuel_flow = createGlobalPropertyf("A318/systems/fuel/fuel_flow")

local altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")--we define an altitude variable
local airspeed = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")--we define an airspeed variable
local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")--we define an a pitch variable
local roll = globalPropertyf("sim/cockpit2/gauges/indicators/roll_electric_deg_pilot")--we define a roll variable
local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)--we define the N1 Percent dataref
local n2percent = globalPropertyfa("sim/cockpit2/engine/indicators/N2_percent", 7)--we define the N2 Percent dataref
local door_status = globalPropertyfa("sim/flightmodel2/misc/door_open_ratio", 10)--we define the door open ratio dataref
local gear_on_ground = globalPropertyia("sim/flightmodel2/gear/on_ground", 10)
local engine_burning_fuel = globalPropertyia("sim/flightmodel2/engines/engine_is_burning_fuel", 8)
local fuel_init_quantity = globalPropertyf("sim/cockpit2/fuel/fuel_totalizer_init_kg")--we define the amout of fuel that the aircraft was loaded with
local fuel_current_quantity = globalPropertyfa("sim/cockpit2/fuel/fuel_quantity")--we define the amount of fuel that the aircraft has remaining
local centre_fuel_pump_mode = globalPropertyi("A318/systems/fuel/pumps/centre_mode_sel")
local fuel_tank_pumps = globalPropertyia("sim/cockpit2/fuel/fuel_tank_pump_on", 8) -- define the fuel tank pump status
local fuel_flow_kg_sec = globalPropertyfa("sim/cockpit2/engine/indicators/fuel_flow_kg_sec", 2)
local eng_valve_state = globalPropertyia("A318/systems/fuel/eng_valves")
local xfeed_state = globalPropertyi("A318/systems/fuel/pumps/xfeed_state")
local apu_valve_state = globalPropertyi("A318/systems/engines/apu/apu_valve")
local apu_master = globalPropertyi("sim/cockpit/engine/APU_switch")

local cond_temps = globalPropertyfa("A318/systems/aircond/temps/actual", 3)
local oil_qty = globalPropertyfa("sim/flightmodel/engine/ENGN_oil_quan", 8)--we define an oil quantity dataref
local cabin_alt = globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft")--we define the dataref for cabin altitude
local speedbrake_status = globalPropertyfa("sim/flightmodel2/controls/speedbrake_ratio", 10)--we define the status of speedbrakes
local local_hour = globalPropertyi("sim/cockpit2/clock_timer/local_time_hours")
local local_mins = globalPropertyi("sim/cockpit2/clock_timer/local_time_minutes")
local zulu_hour = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours")
local zulu_mins = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
local temp_sat = globalPropertyf("sim/cockpit2/temperature/outside_air_LE_temp_degc")
local temp_tat = globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")
local weight_empty = globalPropertyf("sim/aircraft/weight/acf_m_empty")
local weight_fuel = globalPropertyf("sim/aircraft/weight/acf_m_fuel_tot")
local vsi = {["value"] = 0, ["colour"] = ECAM_COLOURS["GREEN"], ["blink"] = false}

-- need to understand what the array elements relate to.
local aileron = globalPropertyfa("sim/flightmodel2/wing/aileron1_deg", 4)

local efb_units = globalPropertyi("A318/efb/config/units")

--create colors
local ECAM_ORANGE = {1.0, 0.625, 0.0, 1.0} --We make a red color with 255 red, 0 green, and 0 blue
local ECAM_RED = {255, 0, 0} --We make a red color with 255 red, 0 green, and 0 blue
local ECAM_GREEN = {0.184, 0.733, 0.219, 1.0}--we make a green color with 0.184 red, 0.733 green, 0.219 Blue, and 1.0 for the alpha
local ECAM_WHITE = {1.0, 1.0, 1.0, 1.0}--we make a white color with 1.0 red, 1.0 green, 1.0 Blue, and 1.0 for the alpha
local ECAM_BLUE = {0.004, 1.0, 1.0, 1.0}--we make a blue color with 0.004 red, 1.0 green, 1.0 Blue, and 1.0 for the alpha
local ECAM_GREY = {0.25, 0.26, 0.26, 1.0}--we make a grey color with 0.25 red, 0.26 green, 0.26 Blue, and 1.0 for the alpha
local ECAM_YELLOW = {1.0, 1.0, 0, 1.0}--we make a yellow color with 1.0 red, 1.0 green, 0 blue, and 1.0 alpha

--load images
local lower_engine_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam engine page overlay
local lower_bleed_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam bleed page overlay
local lower_press_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam pressure page overlay
local lower_elec_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam electricity page overlay
local lower_hyd_overlay = sasl.gl.loadImage("ECAM_LOWER_HYD_OVERLAY.png")--defining the lower ecam hydraulics page overlay
local lower_fuel_overlay = sasl.gl.loadImage("ECAM_LOWER_FUEL_OVERLAY.png")--defining the lower ecam fuel page overlay
local lower_apu_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam APU page overlay
local lower_air_cond_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam Air Cond page overlay
local lower_doors_overlay = sasl.gl.loadImage("ECAM_LOWER_DOORS_OVERLAY.png")--defining the lower ecam doors page overlay
local lower_wheel_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam wheels page overlay
local lower_fctl_overlay = sasl.gl.loadImage("ECAM_LOWER_FCTL_OVERLAY.png")--defining the lower ecam Flight Controls page overlay
local lower_sts_overlay = sasl.gl.loadImage("ECAM_ENG_LOWER.png")--defining the lower ecam systems page overlay
local lower_cruise_overlay = sasl.gl.loadImage("ECAM_LOWER_CRUISE.png")--defining the lower ecam cruise page overlay
local lower_overlay = sasl.gl.loadImage("ECAM_LOWER_OVERLAY.png")--defining the lower ecam cruise page overlay

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

function get_weight(kg)
    if get(efb_units) == units.metric then
        return kg
    end
    return kg * 2.20462262185
end

function get_temp(celsius)
    if get(efb_units) == units.metric then
        return celsius
    end
    return celsius * 1.8 + 32
end

local ecam_pages = {
    ["eng"] = 1,
    ["bleed"] = 2,
    ["press"] = 3,
    ["elec"] = 4,
    ["hyd"] = 5,
    ["fuel"] = 6,
    ["apu"] = 7,
    ["air_cond"] = 8,
    ["doors"] = 9,
    ["wheel"] = 10,
    ["fctl"] = 11,
    ["sts"] = 12,
    ["cruise"] = 13,
}

--custom functions
local function draw_eng_page()--draw engine page
    sasl.gl.drawTexture(lower_engine_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_bleed_page()--draw the bleed page
    sasl.gl.drawTexture(lower_bleed_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_press_page()--draw the pressure page
    sasl.gl.drawTexture(lower_press_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_elec_page()--draw the electricity page
    sasl.gl.drawTexture(lower_elec_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_hyd_page()--draw the hyd page
    sasl.gl.drawTexture(lower_hyd_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_fuel_page()--draw the fuel page
    sasl.gl.drawTexture(lower_fuel_overlay, 0, 0, 522, 522)--we are drawing the overlay
    -- F USED
    -- sasl.gl.drawText(AirbusFont, 175, 87, string.format("%.0f", round(get_weight(get(weight_fuel)), 10)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 262, 440, (get(efb_units) == units.metric and "KG" or "LBS"), 20, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)

    -- FOB
    sasl.gl.drawText(AirbusFont, 190, 87, (get(efb_units) == units.metric and "KG" or "LBS"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 175, 87, string.format("%.0f", round(get_weight(get(weight_fuel)), 10)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    -- F.FLOW
    sasl.gl.drawText(AirbusFont, 190, 115, (get(efb_units) == units.metric and "KG" or "LBS") .. "/MIN", 20, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 175, 115, string.format("%.2f", round(get_weight(get(fuel_flow)), 0.01)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    local function drawQuantities()
        -- centre tank
        sasl.gl.drawText(AirbusFont, 262, 270, round(get_weight(get(fuel_current_quantity, 1)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
        -- left inner tank
        sasl.gl.drawText(AirbusFont, 130, 265, round(get_weight(get(fuel_current_quantity, 2)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
        -- right inner tank
        sasl.gl.drawText(AirbusFont, 390, 265, round(get_weight(get(fuel_current_quantity, 3)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
        -- left outer tank
        sasl.gl.drawText(AirbusFont, 35, 260, round(get_weight(get(fuel_current_quantity, 4)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
        -- right outer tank
        sasl.gl.drawText(AirbusFont, 485, 260, round(get_weight(get(fuel_current_quantity, 5)), 10), 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    end

    local function drawValveStatuses()
        -- drawing the valve statuses

        if get(eng_valve_state, 1) == valve_states.closed then
            sasl.gl.drawCircle(136, 441, 13, true, ECAM_ORANGE)
            sasl.gl.drawCircle(136, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({123,441,  149,441}, 2, ECAM_ORANGE)
        elseif get(eng_valve_state, 1) == valve_states.transit then
            sasl.gl.drawCircle(136, 441, 13, true, ECAM_ORANGE)
            sasl.gl.drawCircle(136, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({126,431,  146,451}, 2, ECAM_ORANGE)
        elseif get(eng_valve_state, 1) == valve_states.open then
            sasl.gl.drawCircle(136, 441, 13, true, ECAM_GREEN)
            sasl.gl.drawCircle(136, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({136,428,  136,454}, 2, ECAM_GREEN)
        end

        if get(eng_valve_state, 2) == valve_states.closed then
            sasl.gl.drawCircle(387, 441, 13, true, ECAM_ORANGE)
            sasl.gl.drawCircle(387, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({374,441,  400,441}, 2, ECAM_ORANGE)
        elseif get(eng_valve_state, 2) == valve_states.transit then
            sasl.gl.drawCircle(387, 441, 13, true, ECAM_ORANGE)
            sasl.gl.drawCircle(387, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({378,432,  397,451}, 2, ECAM_ORANGE)
        elseif get(eng_valve_state, 2) == valve_states.open then
            sasl.gl.drawCircle(387, 441, 13, true, ECAM_GREEN)
            sasl.gl.drawCircle(387, 441, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({387,428,  387,454}, 2, ECAM_GREEN)
        end

        if get(xfeed_state) == valve_states.closed then
            sasl.gl.drawCircle(262, 401, 13, true, ECAM_GREEN)
            sasl.gl.drawCircle(262, 401, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({262,388,  262,414}, 2, ECAM_GREEN)
        elseif get(xfeed_state) == valve_states.transit then
            sasl.gl.drawCircle(262, 401, 13, true, ECAM_ORANGE)
            sasl.gl.drawCircle(262, 401, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({262,388,  262,414}, 2, ECAM_ORANGE)
        elseif get(xfeed_state) == valve_states.open then
            sasl.gl.drawCircle(262, 401, 13, true, ECAM_GREEN)
            sasl.gl.drawCircle(262, 401, 11, true, {0, 0, 0})
            sasl.gl.drawWidePolyLine({235,401,  288,401}, 2, ECAM_GREEN)
        end
    end

    local function drawApuStatus()
        sasl.gl.drawText(AirbusFont, 90, 396, "APU", 18, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)

        -- if get(apu_valve_state) == valve_states.closed and get(apu_master) == switch_states.on then
        --     sasl.gl.drawCircle(182, 426, 13, false, ECAM_ORANGE)
        --     sasl.gl.drawPolyLine({169,426,  195,426}, ECAM_ORANGE)
        --     -- draw horizontal line
        -- elseif get(apu_valve_state) == valve_states.closed then
        --     sasl.gl.drawCircle(182, 426, 13, false, ECAM_GREEN)
        --     sasl.gl.drawPolyLine({169,426,  195,426}, ECAM_GREEN)
        --     -- draw horizontal line
        -- elseif get(apu_valve_state) == valve_states.transit then
        --     sasl.gl.drawCircle(182, 426, 13, false, ECAM_ORANGE)
        --     sasl.gl.drawPolyLine({172,416,  192,436}, ECAM_ORANGE)
        -- elseif get(apu_valve_state) == valve_states.open then
        --     sasl.gl.drawCircle(182, 426, 13, false, ECAM_GREEN)
        --     sasl.gl.drawPolyLine({183,413,  183,439}, ECAM_GREEN)
        -- end
    end

    local function drawPumpStates()
        -- left tanks
        if get(fuel_tank_pumps, 1) == switch_states.on then
            sasl.gl.drawFrame(122, 311, 28, 29, ECAM_GREEN) -- we are drawing the fuel pump outline
            sasl.gl.drawWidePolyLine({135,311, 135,340}, 2, ECAM_GREEN) -- we are drawing the fuel pump indicator line
        elseif get(fuel_tank_pumps, 1) == switch_states.off then
            sasl.gl.drawFrame(122, 311, 28, 29, ECAM_ORANGE)
            sasl.gl.drawWidePolyLine({128,326, 144,326}, 2, ECAM_ORANGE)
        end
        if get(fuel_tank_pumps, 2) == switch_states.on then
            sasl.gl.drawFrame(157, 311, 28, 29, ECAM_GREEN)
            sasl.gl.drawWidePolyLine({170,311, 170,340}, 2, ECAM_GREEN)
        elseif get(fuel_tank_pumps, 2) == switch_states.off then
            sasl.gl.drawFrame(157, 311, 28, 29, ECAM_ORANGE)
            sasl.gl.drawWidePolyLine({163,326, 179,326}, 2, ECAM_ORANGE)
        end

        -- right tanks
        if get(fuel_tank_pumps, 3) == switch_states.on then
            sasl.gl.drawFrame(338, 311, 28, 29, ECAM_GREEN)
            sasl.gl.drawWidePolyLine({352,311, 352,340}, 2, ECAM_GREEN)
        elseif get(fuel_tank_pumps, 3) == switch_states.off then
            sasl.gl.drawFrame(338, 311, 28, 29, ECAM_ORANGE)
            sasl.gl.drawWidePolyLine({344,326, 360,326}, 2, ECAM_ORANGE)
        end
        if get(fuel_tank_pumps, 4) == switch_states.on then
            sasl.gl.drawFrame(374, 311, 28, 29, ECAM_GREEN)
            sasl.gl.drawWidePolyLine({387,311, 387,340}, 2, ECAM_GREEN)
        elseif get(fuel_tank_pumps, 4) == switch_states.off then
            sasl.gl.drawFrame(374, 311, 28, 29, ECAM_ORANGE)
            sasl.gl.drawWidePolyLine({380,326, 396,326}, 2, ECAM_ORANGE)
        end
        -- centre tanks
        if get(fuel_tank_pumps, 5) == switch_states.on and get(centre_fuel_pump_mode) == auto_man_states.auto then
            sasl.gl.drawFrame(224, 322, 28, 29, ECAM_GREEN)
            sasl.gl.drawWidePolyLine({238,322, 238,351}, 2, ECAM_GREEN)
        elseif get(fuel_tank_pumps, 5) == switch_states.off then
            sasl.gl.drawFrame(224, 322, 28, 29, ECAM_ORANGE)
            sasl.gl.drawWidePolyLine({229,337, 245,337}, 2, ECAM_ORANGE)
        end
        if get(fuel_tank_pumps, 6) == switch_states.on and get(centre_fuel_pump_mode) == auto_man_states.auto then
            sasl.gl.drawFrame(271, 322, 28, 29, ECAM_GREEN)
            sasl.gl.drawWidePolyLine({285,322, 285,351}, 2, ECAM_GREEN)
        elseif get(fuel_tank_pumps, 6) == switch_states.off then
            sasl.gl.drawFrame(271, 322, 28, 29, ECAM_ORANGE)
            sasl.gl.drawWidePolyLine({277,337, 293,337}, 2, ECAM_ORANGE)
        end
    end

    drawQuantities()
    drawPumpStates()
    drawValveStatuses()
    drawApuStatus()
end

local function draw_apu_page()--draw the apu page
    sasl.gl.drawTexture(lower_apu_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_air_cond_page()--draw the air conditioning page
    sasl.gl.drawTexture(lower_air_cond_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_doors_page()--draw the doors page
    sasl.gl.drawTexture(lower_doors_overlay, 0, 0, 522, 522)--18, -3, 542, 542)--we are drawing the overlay

    -- Vertical speed
    sasl.gl.drawText(AirbusFont, 362, 410, 'V/S', 20, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)

    -- sasl.gl.drawWidePolyLine({403, 411, 410, 411, 423, 424, 417, 423, 423, 418, 423, 424}, 2, vsi["colour"])
    sasl.gl.drawTriangle(424, 417, 423, 423, 418, 423, vsi["colour"])
    sasl.gl.drawText(AirbusFont, 476, 410, string.format("%.f", round(vsi["value"], 50)), 20, false, false, TEXT_ALIGN_RIGHT, vsi["colour"])
    sasl.gl.drawText(AirbusFont, 482, 410, "FT/MIN", 14, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)

    -- door 1 - CPT FRONT
    sasl.gl.drawWidePolyLine({228, 350, 228, 368, 238, 368, 238, 350, 227, 350}, 2, ECAM_GREEN)
    -- door 2 - FO FRONT
    sasl.gl.drawWidePolyLine({283, 350, 283, 368, 293, 368, 293, 350, 282, 350}, 2, ECAM_GREEN)
    -- door 3 - fwd cargo
    sasl.gl.drawWidePolyLine({277, 297, 277, 315, 293, 315, 293, 297, 276, 297}, 2, ECAM_GREEN)
    -- L slide
    sasl.gl.drawWidePolyLine({228, 230, 228, 248, 238, 248, 238, 230, 227, 230}, 2, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 217, 232, 'SLIDE', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_WHITE)
    -- R slide
    sasl.gl.drawWidePolyLine({283, 230, 283, 248, 293, 248, 293, 230, 282, 230}, 2, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 306, 232, 'SLIDE', 16, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)

    -- door 4 - aft cargo
    sasl.gl.drawWidePolyLine({277, 172, 277, 190, 293, 190, 293, 172, 276, 172}, 2, ECAM_GREEN)

    -- door 5 - CPT aft
    sasl.gl.drawWidePolyLine({228, 110, 228, 128, 238, 128, 238, 110, 227, 110}, 2, ECAM_GREEN)

    -- door 6 - FO aft
    sasl.gl.drawWidePolyLine({283, 110, 283, 128, 293, 128, 293, 110, 282, 110}, 2, ECAM_GREEN)

    -- avionics
    sasl.gl.drawWidePolyLine({253, 428, 253, 436, 268, 436, 268, 428, 252, 428}, 2, ECAM_GREEN)
    sasl.gl.drawWidePolyLine({271, 398, 271, 413, 279, 413, 279, 398, 270, 398}, 2, ECAM_GREEN)
    sasl.gl.drawWidePolyLine({243, 398, 243, 413, 251, 413, 251, 398, 242, 398}, 2, ECAM_GREEN)
    sasl.gl.drawWidePolyLine({278, 140, 278, 158, 285, 158, 285, 140, 277, 140}, 2, ECAM_GREEN)

    if get(door_status, 1) == 0 then--if the door open ratio is = 0
        -- sasl.gl.drawWidePolyLine({225, 350, 225, 370, 238, 370, 238, 350, 224, 350}, 3, ECAM_GREEN)
        -- sasl.gl.drawFrame(223, 350, 13, 20, ECAM_GREEN)--draw a green rectangle
    elseif get(door_status, 1) > 0 then--if the door open ratio is = 1
        sasl.gl.drawText(AirbusFont, 218, 355, 'CABIN -----------', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_ORANGE)
        sasl.gl.drawRectangle(228, 350, 10, 18, ECAM_YELLOW)--draw a red rectangle
    -- else--anything else results in a yellow rectangle
    --     sasl.gl.drawRectangle(225, 350, 11, 18, ECAM_RED)
    end

    if get(door_status, 2) > 0 then
        sasl.gl.drawText(AirbusFont, 302, 355, '----------- CABIN', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(283, 350, 10, 18, ECAM_YELLOW)
    end

    if get(door_status, 3) == 1 then
        sasl.gl.drawText(AirbusFont, 302, 300, '------ CARGO', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(277, 297, 16, 18, ECAM_YELLOW)
    elseif get(door_status, 3) > 0 then
        sasl.gl.drawRectangle(277, 297, 16, 18, ECAM_RED)
    end

    if get(door_status, 4) == 1 then
        sasl.gl.drawText(AirbusFont, 302, 175, '------ CARGO', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(277, 172, 16, 18, ECAM_YELLOW)
    elseif get(door_status, 4) > 0 then
        sasl.gl.drawRectangle(277, 172, 16, 18, ECAM_RED)
    end

    if get(door_status, 5) > 0 then
        sasl.gl.drawText(AirbusFont, 218, 115, 'CABIN -----------', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_ORANGE)
        sasl.gl.drawRectangle(228, 110, 10, 18, ECAM_YELLOW)
    end

    if get(door_status, 6) > 0 then
        sasl.gl.drawText(AirbusFont, 302, 115, '----------- CABIN', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(283, 110, 10, 18, ECAM_YELLOW)
    -- else
    --     sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_RED)
    end

end

local function draw_wheel_page()--draw the wheels page
    sasl.gl.drawTexture(lower_wheel_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_fctl_page()--draw the flight controls page
    sasl.gl.drawTexture(lower_fctl_overlay, 0, 0, 522, 522)--we are drawing the overlay
	--drawing the spoilers
	if get(speedbrake_status, 1) == 1 then
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 1) == 0 then
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 2) == 1 then
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 2) == 0 then
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 3) == 1 then
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 3) == 0 then
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 4) == 1 then
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 4) == 0 then
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 5) == 1 then
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 5) == 0 then
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 6) == 1 then
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 6) == 0 then
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 7) == 1 then
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 7) == 0 then
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 8) == 1 then
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 8) == 0 then 
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 9) == 1 then
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 9) == 0 then
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 10) == 1 then
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 10) == 0 then
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
    end
    
    -- if get(aileron, 1)
end

local function draw_sts_page()--draw the systems page
    sasl.gl.drawTexture(lower_sts_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_cruise_page()--draw the cruise page
    sasl.gl.drawTexture(lower_cruise_overlay, 0, 72, 522, 450)--we are drawing the overlay
    --engine 1 fuel used = initial fuel quantity - (the current fuel quantity of tank 1) + (The current fuel quantity of engine 2)
    --sasl.gl.drawText(AirbusFont, 110, 375, get(fuel_used, 1), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the fuel used by engine 1
    --sasl.gl.drawText(AirbusFont, 210, 375, get(fuel_used, 2), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the fuel used by engine 2

    sasl.gl.drawText(AirbusFont, 180, 447, "0", 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 342, 447, "0", 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)

    sasl.gl.drawText(AirbusFont, 180, 365, round(get(oil_qty, 1), 0.1), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)--we display the engine 1 oil quantity
    sasl.gl.drawText(AirbusFont, 342, 365, round(get(oil_qty, 2), 0.1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the engine 2 oil quantity

    sasl.gl.drawText(AirbusFont, 180, 323, "0.1", 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 342, 323, "0.2", 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)

    sasl.gl.drawText(AirbusFont, 180, 293, "0.7", 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 342, 293, "0.7", 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)

    sasl.gl.drawText(AirbusFont, 33, 124, round(get(cond_temps, 1), 1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)-- CKPT A/C temp
    sasl.gl.drawText(AirbusFont, 108, 124, round(get(cond_temps, 2), 1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)-- FWD A/C temp
    sasl.gl.drawText(AirbusFont, 183, 124, round(get(cond_temps, 3), 1), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)-- AFT A/C temp
    sasl.gl.drawText(AirbusFont, 490, 80, round(get(cabin_alt), 10), 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the current cabin altitude
end

function update() -- perform updating logic as drawing should only draw!
    -- if get(fuel_current_quantity, 1) > 60 and get(centre_fuel_pump_mode) == 0 then -- fuel in centre tanks so centre pumps can be off and green
        -- set()
    -- set(fuel_used, 1) = (math.floor(get(fuel_init_quantity)) - (math.floor(get(fuel_current_quantity, 1) + math.floor(get(fuel_current_quantity, 2)))))--we determine the fuel used by engine 1
    -- set(fuel_used, 2) = (math.floor(get(fuel_init_quantity)) - (math.floor(get(fuel_current_quantity, 1) + math.floor(get(fuel_current_quantity, 2)))))--we determine the fuel used by engine 2
    set(fuel_flow, get(fuel_flow_kg_sec, 1) + get(fuel_flow_kg_sec, 2))
    set(vsi, get_vsi())

    if get(current_flight_phase) == flight_phases.elec_pwr and get(engine_burning_fuel, 1) == 1 then
        set(current_flight_phase, flight_phases.engine_start)
        set(current_ecam_page, ecam_pages.doors)
    elseif get(current_flight_phase) == flight_phases.engine_start and get(npercent, 1) > 50 then
        set(current_flight_phase, flight_phases.engine_power)
        set(current_ecam_page, ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.engine_power and get(airspeed) > 80 then
        set(current_flight_phase, flight_phases.at_80_kts)
        set(current_ecam_page, ecam_pages.eng)
    elseif get(current_flight_phase) == flight_phases.at_80_kts and get(gear_on_ground, 2) == 0 then
        set(current_flight_phase, flight_phases.liftoff)
        set(current_ecam_page, ecam_pages.eng)
    elseif get(current_flight_phase) == flight_phases.liftoff and round(get(altitude), 100) > 1500 then
        set(current_flight_phase, flight_phases.above_1500_ft)
        set(current_ecam_page, ecam_pages.cruise)
    elseif get(current_flight_phase) == flight_phases.above_1500_ft and round(get(altitude), 100) < 800 then
        set(current_flight_phase, flight_phases.below_800_ft)
        set(current_ecam_page, ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.below_800_ft and get(gear_on_ground, 1) == 1 then
        set(current_flight_phase, flight_phases.touchdown)
        set(current_ecam_page, ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.touchdown and get(airspeed) < 80 then
        set(current_flight_phase, flight_phases.below_80_kts)
        set(current_ecam_page, ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.below_80_kts and get(engine_burning_fuel, 2) == 0 then
        set(current_flight_phase, flight_phases.engine_shutdown)
        set(current_ecam_page, ecam_pages.door)
    end
end

function draw() --the function that actually draws on the panel
    if get(current_ecam_page) == ecam_pages.eng then --if the curent ecam page is 1
        draw_eng_page()--draw the engine page
    elseif get(current_ecam_page) == ecam_pages.bleed then --if the curent ecam page is 2
        draw_bleed_page()--draw the bleed page
    elseif get(current_ecam_page) == ecam_pages.press then --if the curent ecam page is 3
        draw_press_page()--draw the pressure page
    elseif get(current_ecam_page) == ecam_pages.elec then --if the curent ecam page is 4
        draw_elec_page()--draw the electricity page
    elseif get(current_ecam_page) == ecam_pages.hyd then --if the curent ecam page is 5
        draw_hyd_page()--draw the hyd page
    elseif get(current_ecam_page) == ecam_pages.fuel then --if the curent ecam page is 6
        draw_fuel_page()--draw the fuel page
    elseif get(current_ecam_page) == ecam_pages.apu then --if the curent ecam page is 7
        draw_apu_page()--draw the apu page
    elseif get(current_ecam_page) == ecam_pages.air_cond then --if the curent ecam page is 8
        draw_air_cond_page()--draw the air conditioning page
    elseif get(current_ecam_page) == ecam_pages.doors then --if the curent ecam page is 9
        draw_doors_page()--draw the doors page
    elseif get(current_ecam_page) == ecam_pages.wheel then --if the curent ecam page is 10
        draw_wheel_page()--draw the wheel page
    elseif get(current_ecam_page) == ecam_pages.fctl	then --if the curent ecam page is 11
        draw_fctl_page()--draw the flight controls page
    elseif get(current_ecam_page) == ecam_pages.sts then --if the curent ecam page is 12
        draw_sts_page()--draw the systems page
    elseif get(current_ecam_page) == ecam_pages.cruise then --if the curent ecam page is 13
        draw_cruise_page()--draw the cruise page
    end

    sasl.gl.drawTexture(lower_overlay, 0, 0, 522, 72)--we are drawing the overlay

    -- draw Temperatures
    sasl.gl.drawText(AirbusFont, 90, 48, string.format("%+.1f", get_temp(get(temp_tat))), 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 90, 27, string.format("%+.1f", get_temp(get(temp_sat))), 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 140, 48, "° " .. (get(efb_units) == units.metric and "C" or "F"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)
    sasl.gl.drawText(AirbusFont, 140, 27, "° " .. (get(efb_units) == units.metric and "C" or "F"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)
    sasl.gl.drawText(AirbusFont, 140,  6, "° " .. (get(efb_units) == units.metric and "C" or "F"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)
    
    -- draw Clock
    sasl.gl.drawText(AirbusFont, 251, 27, string.format("%02d", get(zulu_hour)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 273, 27, string.format("%02d", get(zulu_mins)), 20, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 268, 27, 'H', 20, false, false, TEXT_ALIGN_RIGHT, ECAM_BLUE)

    -- draw Gross Weight
    local tot_weight = get(weight_empty) + get(weight_fuel)
    sasl.gl.drawText(AirbusFont, 472, 46, string.format("%.0f", round(get_weight(get(tot_weight)), 10)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 482, 46, (get(efb_units) == units.metric and "KG" or "LBS"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)
    ----------------------------------------------------------------------------------------------------------

end
