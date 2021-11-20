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

position = {2765, 1545, 1292, 1420}
size = {522, 522}

--defining dataref variables
local Bright = createGlobalPropertyf("A318/cockpit/ecam/lwBright", 1)
local startup_complete = false

local BUS = globalProperty("A318/systems/ELEC/AC2_V")
local selfTest = 0

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local Timer = 0
local TimerFinal = math.random(25, 40)

local eng = createGlobalPropertyi("A318/cockpit/ecam/eng", 0)
local bleed = createGlobalPropertyi("A318/cockpit/ecam/bleed", 0)
local press = createGlobalPropertyi("A318/cockpit/ecam/press", 0)
local elec = createGlobalPropertyi("A318/cockpit/ecam/elec", 0)
local hyd = createGlobalPropertyi("A318/cockpit/ecam/hyd", 0)
local fuel = createGlobalPropertyi("A318/cockpit/ecam/fuel", 0)
local apu = createGlobalPropertyi("A318/cockpit/ecam/apu", 0)
local cond = createGlobalPropertyi("A318/cockpit/ecam/cond", 0)
local door = createGlobalPropertyi("A318/cockpit/ecam/door", 0)
local wheel = createGlobalPropertyi("A318/cockpit/ecam/wheel", 0)
local fctl = createGlobalPropertyi("A318/cockpit/ecam/fctl", 0)
local sts = createGlobalPropertyi("A318/cockpit/ecam/sts", 0)

local buttons = {
    eng,
    bleed,
    press,
    elec,
    hyd,
    fuel,
    apu,
    cond,
    door,
    wheel,
    fctl,
    sts
}

local current_ecam_page = 9
local auto_change_page = true
local fuel_flow = globalPropertyf("A318/systems/fuel/fuel_flow")

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

local apuMode = globalProperty("sim/cockpit2/electrical/APU_starter_switch")
local apuAvail = globalPropertyi("A318/systems/ELEC/apu_Avail")
local engMode = globalPropertyi("A318/systems/FADEC/MODESEL")
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")

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

function systemPages()
    if auto_change_page == true then
        -- set the current page to appropriate page for phase
        if get(apuMode) == 1 and get(apuAvail) == 0 then
            current_ecam_page = 7
        elseif get(engMode) ~= 1 and (get(eng1N1) < 19.5 or get(eng2N1) < 19.5) then
            current_ecam_page = 1
        elseif fltPhase == 1 then
            current_ecam_page = 9
        elseif fltPhase == 2 then
            current_ecam_page = 10
         elseif fltPhase >= 3 and fltPhase <= 5 then
            current_ecam_page = 1
        elseif fltPhase == 6 then
            current_ecam_page = 13
        elseif fltPhase >= 7 and fltPhase <= 9 then
            current_ecam_page = 10
        elseif fltPhase == 10 then
            current_ecam_page = 9
        end
    end
end

function update()
    if not startup_complete then
        plane_startup()
        startup_complete = true
    end
    systemPages()

    set(fuel_flow, get(fuel_flow_kg_sec, 1) + get(fuel_flow_kg_sec, 2))
    set(vsi, get_vsi())

    for i = 1, table.getn(buttons), 1 do
        if get(buttons[i]) == 1 then
            if current_ecam_page ~= i then
                auto_change_page = false
                current_ecam_page = i
            else
                auto_change_page = true
            end
            set(buttons[i], 0)
        end
    end

    
    if Timer < TimerFinal and selfTest == 0 then
        Timer = Timer + 1 * get(DELTA_TIME)
    else
        selfTest = 1
    end
end

function draw()
    sasl.gl.setClipArea(0,0,512,512)
    
    if get(BUS) > 0 then
        if selfTest == 1 then
            Timer = 0
            if current_ecam_page == 1 then
                draw_eng_page()
            elseif current_ecam_page == 2 then
                draw_bleed_page()
            elseif current_ecam_page == 3 then
                draw_press_page()
            elseif current_ecam_page == 4 then
                draw_elec_page()
            elseif current_ecam_page == 5 then
                draw_hyd_page()
            elseif current_ecam_page == 6 then
                draw_fuel_page()
            elseif current_ecam_page == 7 then
                draw_apu_page()
            elseif current_ecam_page == 8 then
                draw_air_cond_page()
            elseif current_ecam_page == 9 then
                draw_doors_page()
            elseif current_ecam_page == 10 then
                draw_wheel_page()
            elseif current_ecam_page == 11 then
                draw_fctl_page()
            elseif current_ecam_page == 12 then
                draw_sts_page()
            elseif current_ecam_page == 13 then
                draw_cruise_page()
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
        else
            sasl.gl.drawText(AirbusFont, 261, 266, "SELF TEST IN PROGESS", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 261, 239, "MAX 40 SECONDS", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        end
        --sasl.gl.drawRectangle(0,0,512,512, {0.33, 0.38, 0.42, 0.35 * get(Bright)})
    else
        Timer = 0
         -- off
    end
    sasl.gl.drawRectangle(0,0,522,522, {0.0, 0.0, 0.0, 1 - get(Bright)})
    sasl.gl.resetClipArea()
end
