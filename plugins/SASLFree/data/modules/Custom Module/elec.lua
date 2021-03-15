-- A318 by X-Bureau --

position = {296, 1630, 143, 180}
size = {40, 250}

local startup_complete = false

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local font = sasl.gl.loadFont("fonts/digital.ttf")
local colour = {0.96, 0.73, 0.28, 1.0}

local onGround = globalProperty("sim/flightmodel/failures/onground_any")
local GS = globalProperty("sim/flightmodel/position/groundspeed")

local apuMode = globalProperty("sim/cockpit2/electrical/APU_starter_switch")

local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local apuN1 = globalProperty("sim/cockpit2/electrical/APU_N1_percent")
local simBattery1 = globalProperty("sim/cockpit2/electrical/battery_on[0]")
local simBattery2 = globalProperty("sim/cockpit2/electrical/battery_on[1]")
local simAvionics = globalProperty("sim/cockpit2/switches/avionics_power_on")
local simGPU = globalProperty("sim/cockpit/electrical/gpu_on")
local simAPU = globalProperty("sim/cockpit2/electrical/APU_generator_on")
local simGEN1 = globalProperty("sim/cockpit2/electrical/generator_on[0]")
local simGEN2 = globalProperty("sim/cockpit2/electrical/generator_on[1]")

-- AC SYSTEM
ext_pwr = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/gpu_V", 115),
    hertz = createGlobalPropertyi("A318/systems/ELEC/gpu_H", 400),
    avail = createGlobalPropertyi("A318/systems/ELEC/gpu_Avail", 0),
}

apu_pwr = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/apu_V", 0),
    hertz = createGlobalPropertyi("A318/systems/ELEC/apu_H", 0),
    avail = createGlobalPropertyi("A318/systems/ELEC/apu_Avail", 0),
}

gen_1 = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/gen1_V", 0),
    hertz = createGlobalPropertyi("A318/systems/ELEC/gen1_H", 0),
}

gen_2 = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/gen2_V", 0),
    hertz = createGlobalPropertyi("A318/systems/ELEC/gen2_H", 0),
}

ac_bus_1 = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/AC1_V", 0),
    hertz = createGlobalPropertyi("A318/systems/ELEC/AC1_H", 0)
}
ac_bus_2 = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/AC2_V", 0),
    hertz = createGlobalPropertyi("A318/systems/ELEC/AC2_H", 0)
}
ac_bus_ess = {
    voltage = createGlobalPropertyi("A318/systems/ELEC/ACESS_V", 0),
    hertz = createGlobalPropertyi("A318/systems/ELEC/ACESS_H", 0)
}


-- DC SYSTEM
bat_1 = {
    voltage = createGlobalPropertyf("A318/systems/ELEC/BAT1_V", 28),
    amps = createGlobalPropertyi("A318/systems/ELEC/BAT1_A", 0),
    pb = createGlobalPropertyi("A318/systems/ELEC/bat1/pb", 0)
}

bat_2 = {
    voltage = createGlobalPropertyf("A318/systems/ELEC/BAT2_V", 28),
    amps = createGlobalPropertyi("A318/systems/ELEC/BAT2_A", 0),
    pb = createGlobalPropertyi("A318/systems/ELEC/bat2/pb", 0)
}

dc_bat_bus = {
    voltage = createGlobalPropertyf("A318/systems/ELEC/DCBAT_V", 0),
    amps = createGlobalPropertyi("A318/systems/ELEC/DCBAT_A", 0)
}

dc_bus_1 = {
    voltage = createGlobalPropertyf("A318/systems/ELEC/DC1_V", 0),
    amps = createGlobalPropertyi("A318/systems/ELEC/DC1_A", 0)
}
dc_bus_2 = {
    voltage = createGlobalPropertyf("A318/systems/ELEC/DC2_V", 0),
    amps = createGlobalPropertyi("A318/systems/ELEC/DC2_A", 0)
}
dc_bus_ess = {
    voltage = createGlobalPropertyf("A318/systems/ELEC/DCESS_V", 0),
    amps = createGlobalPropertyi("A318/systems/ELEC/DCESS_A", 0)
}

bus_tie = createGlobalPropertyi("A318/systems/ELEC/busTieSwtch", 0)
ac_ess_feed = createGlobalPropertyi("A318/systems/ELEC/ESSFeedSwtch", 0)
gen1 = createGlobalPropertyi("A318/systems/ELEC/GEN1Swtch", 1)
gen2 = createGlobalPropertyi("A318/systems/ELEC/GEN2Swtch", 1)
apu_gen = createGlobalPropertyi("A318/systems/ELEC/APUGENSwtch", 1)
ext_pow = createGlobalPropertyi("A318/systems/ELEC/EXTPWRSwtch", 0)

apuMstr = createGlobalPropertyi("A318/systems/ELEC/APUMASTRSwtch", 0)
apuStart = createGlobalPropertyi("A318/systems/ELEC/APUSTARTSwtch", 0)

contacts = {
    -- Batteries
    BC1 = createGlobalPropertyi("A318/systems/ELEC/contacts/BC1", 0),
    BC2 = createGlobalPropertyi("A318/systems/ELEC/contacts/BC2", 0),

    -- DC TIE
    DCT1 = createGlobalPropertyi("A318/systems/ELEC/contacts/DCBTC1", 0),
    DCT2 = createGlobalPropertyi("A318/systems/ELEC/contacts/DCBTC2", 0),
    DCE  = createGlobalPropertyi("A318/systems/ELEC/contacts/DCEBTC", 0),

    -- Engine Generator Contacts
    GLC1 = createGlobalPropertyi("A318/systems/ELEC/contacts/GLC1", 1),
    GLC2 = createGlobalPropertyi("A318/systems/ELEC/contacts/GLC2", 1),

    -- Bus Tie Contacts
    BTC1 = createGlobalPropertyi("A318/systems/ELEC/contacts/BTC1", 0),
    BTC2 = createGlobalPropertyi("A318/systems/ELEC/contacts/BTC2", 0),

    -- Auxilary Power Contacts
    AGC = createGlobalPropertyi("A318/systems/ELEC/contacts/AGC", 0),
    EPC = createGlobalPropertyi("A318/systems/ELEC/contacts/EPC", 0),

    -- Essential Bus Contacts
    ACEssF1 = createGlobalPropertyi("A318/systems/ELEC/contacts/ACEssF1", 1),
    ACEssF2 = createGlobalPropertyi("A318/systems/ELEC/contacts/ACEssF2", 0),

    -- TRU Contacts
    TR1 = createGlobalPropertyi("A318/systems/ELEC/contacts/TR1", 0),
    TR2 = createGlobalPropertyi("A318/systems/ELEC/contacts/TR2", 0),
}

function startup()
    if get(eng1N1) > 1 then
        -- engines running
        set(bat_1.pb, 1)
        set(bat_2.pb, 1)
    else
        -- cold and dark
        set(bat_1.pb, 0)
        set(bat_2.pb, 0)
    end
end

function update()
    if not startup_complete then
        startup()
        startup_complete = true
    end

    -- SIM DATAREF COMPAT.
    if get(bat_1.pb) == 1 then
        set(simBattery1, 1)
    else
        set(simBattery1, 0)
    end
    if get(bat_2.pb) == 1 then
        set(simBattery2, 1)
    else
        set(simBattery2, 0)
    end
    if get(ac_bus_1.voltage) > 0 or get(ac_bus_2.voltage) > 0 then
        set(simAvionics, 1)
    else
        set(simAvionics, 0)
    end
    if get(contacts.EPC) == 1 then
        set(simGPU, 1)
    else
        set(simGPU, 0)
    end
    if get(contacts.AGC) == 1 then
        set(simAPU, 1)
    else
        set(simAPU, 0)
    end
    if get(contacts.GLC1) == 1 then
        set(simGEN1, 1)
    else
        set(simGEN1, 0)
    end
    if get(contacts.GLC2) == 1 then
        set(simGEN2, 1)
    else
        set(simGEN2, 0)
    end

    -- BATTERY DISCHARGE
    if get(bat_1.amps) > 0 then
        set(bat_1.voltage, get(bat_1.voltage) + (-10 * (get(DELTA_TIME) / 3600)))
    else
        if get(dc_bat_bus.voltage) > 0 and get(contacts.BC2) == 0 then
            set(bat_1.voltage, 28)
            else
                --charge remains
            end
    end

    if get(bat_2.amps) > 0 then
        set(bat_2.voltage, get(bat_2.voltage) + (-10 * (get(DELTA_TIME) / 3600)))
    else
        if get(dc_bat_bus.voltage) > 0 and get(contacts.BC1) == 0 then
        set(bat_2.voltage, 28)
        else
            --charge remains
        end
    end

    -- ENGINE GENERATORS
    if get(eng1N1) > 15 then
        set(gen_1.voltage, 115)
        set(gen_1.hertz, 400)
    else
        set(gen_1.voltage, 0)
        set(gen_1.hertz, 0)
    end

    if get(eng2N1) > 15 then
        set(gen_2.voltage, 115)
        set(gen_2.hertz, 400)
    else
        set(gen_2.voltage, 0)
        set(gen_2.hertz, 0)
    end

    -- APU 
    if get(apuMstr) == 1 then
        if get(dc_bus_ess.voltage) > 0 then
            set(apuMode, 1)
        else
            set(apuMode, 0)
        end
    else
        set(apuMode, 0)
    end

    if get(apuStart) == 1 then
        if get(apuMode) == 1 then
            if get(dc_bus_ess.voltage) > 0 then
                set(apuMode, 2)
            end
        end
    end

    -- APU GENERATOR
    if get(apuN1) > 95 then
        set(apu_pwr.voltage, 115)
        set(apu_pwr.hertz, 400)
        set(apu_pwr.avail, 1)
    else
        set(apu_pwr.voltage, 0)
        set(apu_pwr.hertz, 0)
        set(apu_pwr.avail, 0)
    end

    -- GROUND POWER ON/OFF
    if get(onGround) == 1 and get(GS) < 1 then
        set(ext_pwr.avail, 1)
        set(ext_pwr.voltage, 115)
        set(ext_pwr.hertz, 400)
    else
        set(ext_pwr.avail, 0)
        set(ext_pwr.voltage, 0)
        set(ext_pwr.hertz, 0)
    end

    -- BAT BUTTON LOGIC
    if get(bat_1.pb) == 1 then
        if get(contacts.DCT1) == 1 or get(contacts.DCT2) == 1 then
            set(contacts.BC1, 0)
            set(bat_1.amps, 0)
        elseif get(onGround) == 1 and get(GS) < 50 then
            set(contacts.BC1, 1)
            set(bat_1.amps, 150)
        else
            set(contacts.BC1, 0)
            set(bat_1.amps, 0)
        end
    else
        set(contacts.BC1, 0)
        set(bat_1.amps, 0)
    end

    if get(bat_2.pb) == 1 then
        if get(contacts.DCT1) == 1 or get(contacts.DCT2) == 1 then
            set(contacts.BC2, 0)
            set(bat_2.amps, 0)
        elseif get(onGround) == 1 and get(GS) < 50 then
            set(contacts.BC2, 1)
            set(bat_2.amps, 150)
        else
            set(contacts.BC2, 0)
            set(bat_2.amps, 0)
        end
    else
        set(contacts.BC2, 0)
        set(bat_2.amps, 0)
    end

    -- AUXILIARY POWER BUTTONS
    if (get(apu_gen) == 1 and get(ext_pow) == 1) or (get(apu_gen) == 0 and get(ext_pow) == 1) then
        if get(contacts.GLC1) == 1 and get(contacts.GLC2) == 1 then
            set(contacts.AGC, 0)
            set(contacts.EPC, 0)
        else
            set(contacts.AGC, 0)
            set(contacts.EPC, 1)
        end
    elseif get(apu_gen) == 1 and get(apu_pwr.avail) == 1 then
        if get(contacts.GLC1) == 1 and get(contacts.GLC2) == 1 then
            set(contacts.AGC, 0)
            set(contacts.EPC, 0)
        else
            set(contacts.AGC, 1)
            set(contacts.EPC, 0)
        end
    else
        set(contacts.AGC, 0)
        set(contacts.EPC, 0)
    end

    -- GENERATOR CONTROL UNIT
    if get(gen1) == 1 and get(gen_1.voltage) > 0 then
        set(contacts.GLC1, 1)
    else
        set(contacts.GLC1, 0)
    end
    if get(gen2) == 1 and get(gen_2.voltage) > 0 then
        set(contacts.GLC2, 1)
    else
        set(contacts.GLC2, 0)
    end

    -- BUS TIE LOGIC
    if get(bus_tie) == 0 then
        if get(contacts.GLC1) == 1 and get(gen_1.voltage) > 0 and get(contacts.GLC2) == 1 and get(gen_2.voltage) > 0 then
            -- BTC1 and 2 off
            set(contacts.BTC1, 0)
            set(contacts.BTC2, 0)
        elseif get(contacts.GLC1) == 0 and get(contacts.GLC2) == 1 and (get(gen_1.voltage) > 0 or get(gen_2.voltage) > 0) and (get(contacts.AGC) == 1 or get(contacts.EPC) == 1) then
            -- BTC 1 on BTC 2 off
            set(contacts.BTC1, 1)
            set(contacts.BTC2, 0)
        elseif get(contacts.GLC1) == 1 and get(contacts.GLC2) == 0 and (get(gen_1.voltage) > 0 or get(gen_2.voltage) > 0) and (get(contacts.AGC) == 1 or get(contacts.EPC) == 1) then
            -- BTC 1 off BTC 2 on
            set(contacts.BTC1, 0)
            set(contacts.BTC2, 1)
        elseif get(contacts.GLC1) == 0 and get(contacts.GLC2) == 1 and get(contacts.AGC) == 0 and get(contacts.EPC) == 0 then
            -- BTC 1 on BTC 2 off
            set(contacts.BTC1, 1)
            set(contacts.BTC2, 1)
        elseif get(contacts.GLC1) == 1 and get(contacts.GLC2) == 0 and get(contacts.AGC) == 0 and get(contacts.EPC) == 0 then
            -- BTC 1 off BTC 2 on
            set(contacts.BTC1, 1)
            set(contacts.BTC2, 1)
        elseif (get(contacts.AGC) == 1 or get(contacts.EPC) == 1) then
            set(contacts.BTC1, 1)
            set(contacts.BTC2, 1)
        end
    else
        set(contacts.BTC1, 0)
        set(contacts.BTC2, 0)
    end

    -- AC ESS FEED LOGIC
    if get(ac_ess_feed) == 0 then
        set(contacts.ACEssF1, 1)
        set(contacts.ACEssF2, 0)
    else
        set(contacts.ACEssF1, 0)
        set(contacts.ACEssF2, 1)
    end

    -- AC BUS 1
    if get(contacts.BTC1) == 1 then
        if get(ext_pwr.voltage) > 0 and get(contacts.EPC) == 1 then
            set(ac_bus_1.voltage, get(ext_pwr.voltage))
            set(ac_bus_1.hertz, get(ext_pwr.hertz))
        elseif get(apu_pwr.voltage) > 0 and get(contacts.AGC) == 1 then
            set(contacts.EPC, 0)
            set(ac_bus_1.voltage, get(apu_pwr.voltage))
            set(ac_bus_1.hertz, get(apu_pwr.hertz))
        elseif get(gen_2.voltage) > 0 and get(contacts.GLC2) == 1 and get(contacts.BTC2) == 1 then
            set(ac_bus_1.voltage, get(gen_2.voltage))
            set(ac_bus_1.hertz, get(gen_2.hertz))
        else
            if get(contacts.GLC1) == 1 then
                set(ac_bus_1.voltage, get(gen_1.voltage))
                set(ac_bus_1.hertz, get(gen_1.hertz))
            else
                set(ac_bus_1.voltage, 0)
                set(ac_bus_1.hertz, 0)
            end
        end
    elseif get(contacts.GLC1) == 1 then
        set(ac_bus_1.voltage, get(gen_1.voltage))
        set(ac_bus_1.hertz, get(gen_1.hertz))
    else
        set(ac_bus_1.voltage, 0)
        set(ac_bus_1.hertz, 0)
    end

    -- AC BUS 2
    if get(contacts.BTC2) == 1 then
        if get(ext_pwr.voltage) > 0 and get(contacts.EPC) == 1 then
            set(ac_bus_2.voltage, get(ext_pwr.voltage))
            set(ac_bus_2.hertz, get(ext_pwr.hertz))
        elseif get(apu_pwr.voltage) > 0 and get(contacts.AGC) == 1 then
            set(contacts.EPC, 0)
            set(ac_bus_2.voltage, get(apu_pwr.voltage))
            set(ac_bus_2.hertz, get(apu_pwr.hertz))
        elseif get(gen_1.voltage) > 0 and get(contacts.GLC1) == 1 and get(contacts.BTC1) == 1 then
            set(ac_bus_2.voltage, get(gen_1.voltage))
            set(ac_bus_2.hertz, get(gen_1.hertz))
        else
            if get(contacts.GLC2) == 1 then
                set(ac_bus_2.voltage, get(gen_2.voltage))
                set(ac_bus_2.hertz, get(gen_2.hertz))
            else
                set(ac_bus_2.voltage, 0)
                set(ac_bus_2.hertz, 0)
            end
        end
    elseif get(contacts.GLC2) == 1 then
        set(ac_bus_2.voltage, get(gen_2.voltage))
        set(ac_bus_2.hertz, get(gen_2.hertz))
    else
        set(ac_bus_2.voltage, 0)
        set(ac_bus_2.hertz, 0)
    end

    -- AC ESS BUS
    if get(contacts.ACEssF1) == 1 then
        set(ac_bus_ess.voltage, get(ac_bus_1.voltage))
        set(ac_bus_ess.hertz, get(ac_bus_1.hertz))
    elseif get(contacts.ACEssF2) == 1 then
        set(ac_bus_ess.voltage, get(ac_bus_2.voltage))
        set(ac_bus_ess.hertz, get(ac_bus_2.hertz))
    else
        set(ac_bus_ess.voltage, 0)
        set(ac_bus_ess.hertz, 0)
    end

    --TR 1
    if get(ac_bus_1.voltage) > 0 then
        set(contacts.TR1, 1)
    else
        set(contacts.TR1, 0)
    end

    --TR 2
    if get(ac_bus_2.voltage) > 0 then
        set(contacts.TR2, 1)
    else
        set(contacts.TR2, 0)
    end

    -- DC BUS 1
    if get(contacts.TR1) == 1 and get(ac_bus_1.voltage) > 0 then
        set(dc_bus_1.voltage, 28)
        set(dc_bus_1.amps, 150)
    elseif get(contacts.TR1) == 0 and get(contacts.DCT2) == 1 and get(dc_bat_bus.voltage) > 0 then
        set(dc_bus_1.voltage, get(dc_bat_bus.voltage))
        set(dc_bus_1.amps, get(dc_bat_bus.amps))
    else
        set(dc_bus_1.voltage, 0)
        set(dc_bus_1.amps, 0)
    end

    -- DC BUS 2
    if get(contacts.TR2) == 1 and get(ac_bus_2.voltage) > 0 then
        set(dc_bus_2.voltage, 28)
        set(dc_bus_2.amps, 150)
    elseif get(contacts.TR2) == 0 and get(contacts.DCT1) == 1 and get(dc_bat_bus.voltage) > 0 then
        set(dc_bus_2.voltage, get(dc_bat_bus.voltage))
        set(dc_bus_2.amps, get(dc_bat_bus.amps))
    else
        set(dc_bus_2.voltage, 0)
        set(dc_bus_2.amps, 0)
    end

    -- DC ESS BUS
    if get(contacts.DCE) == 1 then
        set(dc_bus_ess.voltage, get(dc_bat_bus.voltage))
        set(dc_bus_ess.amps, get(dc_bat_bus.amps))
    else
        set(dc_bus_ess.voltage, 0)
        set(dc_bus_ess.amps, 0)
    end

    --DC BAT BUS
    if get(contacts.BC1) == 1 or get(contacts.BC2) == 1 then
        -- powered by batteries
        if get(contacts.BC1) == 1 then
            set(dc_bat_bus.voltage, get(bat_1.voltage))
            set(dc_bat_bus.amps, get(bat_1.amps))
        elseif get(contacts.BC2) == 1 then
            set(dc_bat_bus.voltage, get(bat_2.voltage))
            set(dc_bat_bus.amps, get(bat_2.amps))
        end
    elseif get(contacts.DCT1) == 1 and get(contacts.TR1) == 1 then
        -- powered by DC BUS 1
        set(dc_bat_bus.voltage, get(dc_bus_1.voltage))
        set(dc_bat_bus.amps, get(dc_bus_1.amps))
    elseif get(contacts.DCT2) == 1 and get(contacts.TR2) == 1 then
        -- powered by DC BUS 2
        set(dc_bat_bus.voltage, get(dc_bus_2.voltage))
        set(dc_bat_bus.amps, get(dc_bus_2.amps))
    else
        set(dc_bat_bus.voltage, 0)
        set(dc_bat_bus.amps, 0)
    end

    -- DC BUS TIE CONT LOGIC
    if get(dc_bus_1.voltage) > 0 and get(contacts.TR1) == 1 and get(contacts.TR2) == 0 then
        set(contacts.DCT1, 1)
        set(contacts.DCT2, 1)
    elseif get(dc_bus_2.voltage) > 0 and get(contacts.TR2) == 1 and get(contacts.TR1) == 0 then
        set(contacts.DCT1, 1)
        set(contacts.DCT2, 1)
    elseif get(dc_bus_1.voltage) > 0 and get(contacts.TR1) == 1 then
        set(contacts.DCT1, 1)
        set(contacts.DCT2, 0)
    elseif get(dc_bus_2.voltage) > 0 and get(contacts.TR2) == 1 then
        set(contacts.DCT1, 0)
        set(contacts.DCT2, 1)
    else
        set(contacts.DCT1, 0)
        set(contacts.DCT2, 0)
    end

    -- DC ESS BUS
    if get(dc_bat_bus.voltage) > 0 then
        set(contacts.DCE, 1)
    else
        set(contacts.DCE, 0)
    end
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function draw()
    
    if get(bat_1.voltage) > 14 then
        sasl.gl.saveGraphicsContext()
        sasl.gl.setRotateTransform(90)
        sasl.gl.setTranslateTransform(-250,0)
        sasl.gl.drawText(font, 2.5, 2.5, string.format("%.1f", round(get(bat_1.voltage), 1)), 50, false, false, TEXT_ALIGN_LEFT, colour)
        sasl.gl.drawText(font, 145.5, 2.5, string.format("%.1f", round(get(bat_2.voltage), 1)), 50, false, false, TEXT_ALIGN_LEFT, colour)
        sasl.gl.restoreGraphicsContext()
    else
        -- Nothing
    end
end