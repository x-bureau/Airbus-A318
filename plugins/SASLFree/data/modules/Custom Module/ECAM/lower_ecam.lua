require "common_declarations"

include("ECAM/pages/AIRCOND.lua")
include("ECAM/pages/APU.lua")
include("ECAM/pages/BLEED.lua")
include("ECAM/pages/CRUISE.lua")
include("ECAM/pages/DOORS.lua")
include("ECAM/pages/ELEC.lua")
include("ECAM/pages/ENG.lua")
include("ECAM/pages/FCTL.lua")
include("ECAM/pages/FUEL.lua")
include("ECAM/pages/HYD.lua")
include("ECAM/pages/PRESS.lua")
include("ECAM/pages/STS.lua")
include("ECAM/pages/WHEEL.lua")

position = {1153, 51, 544, 503}
size = {522, 522}

--defining dataref variables
local startup_complete = false
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")

local BUS = globalProperty("A318/systems/ELEC/AC2_V")
local selfTest = 0

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local Timer = 0
local TimerFinal = math.random(25, 40)

local current_ecam_page = createGlobalPropertyi("A318/cockpit/ecam/current_page", 7)--create variable that tells us current ecam page
local current_flight_phase = createGlobalPropertyi("A318/cockpit/ecam/flight_phase", flight_phases.elec_pwr)
local auto_change_page = false
local fuel_flow = globalPropertyf("A318/systems/fuel/fuel_flow")

local airspeed = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")--we define an airspeed variable
local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)--we define the N1 Percent dataref
local gear_on_ground = globalPropertyia("sim/flightmodel2/gear/on_ground", 10)
local engine_burning_fuel = globalPropertyia("sim/flightmodel2/engines/engine_is_burning_fuel", 8)
local fuel_flow_kg_sec = globalPropertyfa("sim/cockpit2/engine/indicators/fuel_flow_kg_sec", 2)

local altitude = globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
local zulu_hour = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours")
local zulu_mins = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
local temp_sat = globalPropertyf("sim/cockpit2/temperature/outside_air_LE_temp_degc")
local temp_tat = globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")
local is_isa_enabled = globalPropertyi("A318/efb/config/isa_enabled", enabled_states.enabled)
local weight_empty = globalPropertyf("sim/aircraft/weight/acf_m_empty")
local weight_fuel = globalPropertyf("sim/aircraft/weight/acf_m_fuel_tot")
local vsi = {["value"] = 0, ["colour"] = ECAM_COLOURS["GREEN"], ["blink"] = false}

local efb_units = globalPropertyi("A318/efb/config/units")
local lower_overlay = sasl.gl.loadImage("ECAM_LOWER_OVERLAY.png")--defining the lower ecam cruise page overlay

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

local ecam_pages = {
    eng = 1,
    bleed = 2,
    press = 3,
    elec = 4,
    hyd = 5,
    fuel = 6,
    apu = 7,
    air_cond = 8,
    doors = 9,
    wheel = 10,
    fctl = 11,
    sts = 12,
    cruise = 13,
}

local arrow_points = {left = -1, right = 1}

local function update_page(page)
    if auto_change_page then
        set(current_ecam_page, page)
    end
end

function get_isa()
    local alt = get(altitude)
    local isa = math.max(-56.5, 15 - 1.98 * math.floor(alt / 1000))
    return tonumber(string.format("%.1f", isa))
end

function plane_startup()
    if get(eng1N1) > 1 then
        -- engines running
        selfTest = 1
        Timer = 0
    else
        -- cold and dark
        selfTest = 0
    end
end

function update() -- perform updating logic as drawing should only draw!
    if not startup_complete then
        plane_startup()
        startup_complete = true
    end
    -- if get(fuel_current_quantity, 1) > 60 and get(centre_fuel_pump_mode) == 0 then -- fuel in centre tanks so centre pumps can be off and green
        -- set()
    -- set(fuel_used, 1) = (math.floor(get(fuel_init_quantity)) - (math.floor(get(fuel_current_quantity, 1) + math.floor(get(fuel_current_quantity, 2)))))--we determine the fuel used by engine 1
    -- set(fuel_used, 2) = (math.floor(get(fuel_init_quantity)) - (math.floor(get(fuel_current_quantity, 1) + math.floor(get(fuel_current_quantity, 2)))))--we determine the fuel used by engine 2
    set(fuel_flow, get(fuel_flow_kg_sec, 1) + get(fuel_flow_kg_sec, 2))
    set(vsi, get_vsi())

    if get(current_flight_phase) == flight_phases.elec_pwr and get(engine_burning_fuel, 1) == 1 then
        set(current_flight_phase, flight_phases.engine_start)
        update_page(ecam_pages.doors)
    elseif get(current_flight_phase) == flight_phases.engine_start and get(npercent, 1) > 50 then
        set(current_flight_phase, flight_phases.engine_power)
        update_page(ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.engine_power and get(airspeed) > 80 then
        set(current_flight_phase, flight_phases.at_80_kts)
        update_page(ecam_pages.eng)
    elseif get(current_flight_phase) == flight_phases.at_80_kts and get(gear_on_ground, 2) == 0 then
        set(current_flight_phase, flight_phases.liftoff)
        update_page(ecam_pages.eng)
    elseif get(current_flight_phase) == flight_phases.liftoff and round(get(altitude), 100) > 1500 then
        set(current_flight_phase, flight_phases.above_1500_ft)
        update_page(ecam_pages.cruise)
    elseif get(current_flight_phase) == flight_phases.above_1500_ft and round(get(altitude), 100) < 800 then
        set(current_flight_phase, flight_phases.below_800_ft)
        update_page(ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.below_800_ft and get(gear_on_ground, 1) == 1 then
        set(current_flight_phase, flight_phases.touchdown)
        update_page(ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.touchdown and get(airspeed) < 80 then
        set(current_flight_phase, flight_phases.below_80_kts)
        update_page(ecam_pages.wheel)
    elseif get(current_flight_phase) == flight_phases.below_80_kts and get(engine_burning_fuel, 2) == 0 then
        set(current_flight_phase, flight_phases.engine_shutdown)
        update_page(ecam_pages.door)
    end
    if Timer < TimerFinal and selfTest == 0 then
        Timer = Timer + 1 * get(DELTA_TIME)
    else
        selfTest = 1
    end
end

function draw() --the function that actually draws on the panel
    if get(BUS) > 0 then
        if selfTest == 1 then
            Timer = 0
            if get(current_ecam_page) == ecam_pages.eng then --if the curent ecam page is 1
                draw_eng_page()--draw the engine page
            elseif get(current_ecam_page) == ecam_pages.bleed then --if the curent ecam page is 2
                draw_bleed_page()--draw the bleed page
            elseif get(current_ecam_page) == ecam_pages.press then --if the curent ecam page is 3
                draw_press_page()--draw the pressure page
            elseif get(current_ecam_page) == ecam_pages.elec then --if the curent ecam page is 4
                draw_elec_page() --draw the electricity page
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

            sasl.gl.drawTexture(lower_overlay, 0, 0, 522, 72, ECAM_COLOURS.WHITE)--we are drawing the overlay

            -- draw Temperatures
            sasl.gl.drawText(AirbusFont, 90, 48, string.format("%+.1f", get_temp(get(temp_tat))), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 90, 27, string.format("%+.1f", get_temp(get(temp_sat))), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 140, 48, "° " .. (get(efb_units) == units.metric and "C" or "F"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
            sasl.gl.drawText(AirbusFont, 140, 27, "° " .. (get(efb_units) == units.metric and "C" or "F"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
            if get(is_isa_enabled) then
                sasl.gl.drawText(AirbusFont, 90, 6, string.format("%+.1f", get_temp(get_isa())), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
                sasl.gl.drawText(AirbusFont, 140,  6, "° " .. (get(efb_units) == units.metric and "C" or "F"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
            end
    
            -- draw Clock
            sasl.gl.drawText(AirbusFont, 251, 27, string.format("%02d", get(zulu_hour)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 273, 27, string.format("%02d", get(zulu_mins)), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 268, 27, 'H', 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)

            -- draw Gross Weight
            local tot_weight = get(weight_empty) + get(weight_fuel)
            sasl.gl.drawText(AirbusFont, 472, 46, string.format("%.0f", round(get_weight(get(tot_weight)), 10)), 20, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 482, 46, (get(efb_units) == units.metric and "KG" or "LBS"), 20, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
            ----------------------------------------------------------------------------------------------------------
        else
            sasl.gl.drawText(AirbusFont, 261, 266, "SELF TEST IN PROGESS", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 261, 239, "MAX 40 SECONDS", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        end
    else
        Timer = 0
         -- off
    end
end
