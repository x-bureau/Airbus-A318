require "common_declarations"

local delta_time = globalProperty("sim/operation/misc/frame_rate_period")

local oat = globalProperty("sim/cockpit2/temperature/outside_air_temp_degc")

local modeSel = globalProperty("A318/systems/FADEC/MODESEL")

local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local apuN1 = globalProperty("sim/cockpit2/electrical/APU_N1_percent")

local apuPress = createGlobalPropertyf("A318/systems/bleed/APUPress", 0)
local apuTemp = createGlobalPropertyf("A318/systems/bleed/APUTemp", 0)
local apuValve = createGlobalPropertyi("A318/systems/bleed/APUValve", 0)

local eng1Press = createGlobalPropertyf("A318/systems/bleed/ENG1Press", 0)
local eng1Temp = createGlobalPropertyf("A318/systems/bleed/ENG1Temp", 0)
local eng1Valve = createGlobalPropertyi("A318/systems/bleed/ENG1Valve", 0)

local eng2Press = createGlobalPropertyf("A318/systems/bleed/ENG2Press", 0)
local eng2Temp = createGlobalPropertyf("A318/systems/bleed/ENG2Temp", 0)
local eng2Valve = createGlobalPropertyi("A318/systems/bleed/ENG2Valve", 0)

local simapuBleed = globalProperty("sim/cockpit2/bleedair/actuators/apu_bleed")
local simeng1Bleed = globalProperty("sim/cockpit2/bleedair/actuators/engine_bleed_sov[0]")
local simeng2Bleed = globalProperty("sim/cockpit2/bleedair/actuators/engine_bleed_sov[1]")

local switches = {
    eng1Bleed = createGlobalPropertyi("A318/systems/bleed/ENG1BLEED", 1),
    eng2Bleed = createGlobalPropertyi("A318/systems/bleed/ENG2BLEED", 1),
    apuBleed = createGlobalPropertyi("A318/systems/bleed/APUBLEED", 0),
    crossBleed = createGlobalPropertyi("A318/systems/bleed/CROSSBLEED", 1),
    pack1 = createGlobalPropertyi("A318/systems/bleed/PACK1", 1),
    pack2 = createGlobalPropertyi("A318/systems/bleed/PACK2", 1)
}

local banks = {
    left = {
        press = createGlobalPropertyf("A318/systems/bleed/left/pressure", 0),
        temp = createGlobalPropertyf("A318/systems/bleed/left/temp", 0)
    },
    right = {
        press = createGlobalPropertyf("A318/systems/bleed/right/pressure", 0),
        temp = createGlobalPropertyf("A318/systems/bleed/right/temp", 0)
    },
    mixer = {
        press = createGlobalPropertyf("A318/systems/bleed/mixer/pressure", 0),
        temp = createGlobalPropertyf("A318/systems/bleed/mixer/temp", 0)
    },
    crossBleed = createGlobalPropertyi("A318/systems/bleed/crossBleed", 0)
}

local packs = {
    one = {
        valve = createGlobalPropertyi("A318/systems/bleed/packs/one/valve", 0),
        temp = createGlobalPropertyi("A318/systems/bleed/packs/one/temp", 0),
        output = createGlobalPropertyi("A318/systems/bleed/packs/one/output", 0)
    },
    two = {
        valve = createGlobalPropertyi("A318/systems/bleed/packs/two/valve", 0),
        temp = createGlobalPropertyi("A318/systems/bleed/packs/two/temp", 0),
        output = createGlobalPropertyi("A318/systems/bleed/packs/two/output", 0)
    }
}

local zones = {
    cockpit = {
        selector = createGlobalPropertyi("A318/systems/aircond/cockpit/selector", 3),
        reqTemp = createGlobalPropertyf("A318/systems/aircond/cockpit/reqTemp", 24),
        actTemp = createGlobalPropertyf("A318/systems/aircond/cockpit/actTemp", 24)
    },
    fwd = {
        selector = createGlobalPropertyi("A318/systems/aircond/fwd/selector", 3),
        reqTemp = createGlobalPropertyf("A318/systems/aircond/fwd/reqTemp", 24),
        actTemp = createGlobalPropertyf("A318/systems/aircond/fwd/actTemp", 24)
    },
    aft = {
        selector = createGlobalPropertyi("A318/systems/aircond/aft/selector", 3),
        reqTemp = createGlobalPropertyf("A318/systems/aircond/aft/reqTemp", 24),
        actTemp = createGlobalPropertyf("A318/systems/aircond/aft/actTemp", 24)
    }
}

function update()
    -- TEMP SELECTOR
    if get(zones.cockpit.selector) == 0 then
        set(zones.cockpit.reqTemp, 18)
    elseif get(zones.cockpit.selector) == 1 then
        set(zones.cockpit.reqTemp, 20)
    elseif get(zones.cockpit.selector) == 2 then
        set(zones.cockpit.reqTemp, 22)
    elseif get(zones.cockpit.selector) == 3 then
        set(zones.cockpit.reqTemp, 24)
    elseif get(zones.cockpit.selector) == 4 then
        set(zones.cockpit.reqTemp, 26)
    elseif get(zones.cockpit.selector) == 5 then
        set(zones.cockpit.reqTemp, 28)
    elseif get(zones.cockpit.selector) == 6 then
        set(zones.cockpit.reqTemp, 30)
    end
    if get(zones.fwd.selector) == 0 then
        set(zones.fwd.reqTemp, 18)
    elseif get(zones.fwd.selector) == 1 then
        set(zones.fwd.reqTemp, 20)
    elseif get(zones.fwd.selector) == 2 then
        set(zones.fwd.reqTemp, 22)
    elseif get(zones.fwd.selector) == 3 then
        set(zones.fwd.reqTemp, 24)
    elseif get(zones.fwd.selector) == 4 then
        set(zones.fwd.reqTemp, 26)
    elseif get(zones.fwd.selector) == 5 then
        set(zones.fwd.reqTemp, 28)
    elseif get(zones.fwd.selector) == 6 then
        set(zones.fwd.reqTemp, 30)
    end
    if get(zones.aft.selector) == 0 then
        set(zones.aft.reqTemp, 18)
    elseif get(zones.aft.selector) == 1 then
        set(zones.aft.reqTemp, 20)
    elseif get(zones.aft.selector) == 2 then
        set(zones.aft.reqTemp, 22)
    elseif get(zones.aft.selector) == 3 then
        set(zones.aft.reqTemp, 24)
    elseif get(zones.aft.selector) == 4 then
        set(zones.aft.reqTemp, 26)
    elseif get(zones.aft.selector) == 5 then
        set(zones.aft.reqTemp, 28)
    elseif get(zones.aft.selector) == 6 then
        set(zones.aft.reqTemp, 30)
    end

    -- SIM DATAREF COMPAT
    if get(apuValve) == 1 then
        set(simapuBleed, 1)
    else
        set(simapuBleed, 0)
    end
    if get(eng1Valve) == 1 then
        set(simeng1Bleed, 1)
    else
        set(simeng1Bleed, 0)
    end
    if get(eng2Valve) == 1 then
        set(simeng2Bleed, 1)
    else
        set(simeng2Bleed, 0)
    end

    -- APU BLEED
    if get(apuN1) > 90 then
        set(apuPress, (0.35 * get(apuN1)))
        set(apuTemp, 190)
    else
        set(apuPress, 0)
        set(apuTemp, get(oat))
    end

    -- APU BLEED SWITCHES
    if get(switches.apuBleed) == 1 then
        if get(apuN1) > 95 then
            set(apuValve, 1)
        else
            set(apuValve, 0)
        end
    else
        set(apuValve, 0)
    end

    -- ENG1 BLEED
    if get(eng1N1) > 12 then
        set(eng1Press, 40)
        set(eng1Temp, 200)
    else
        set(eng1Press, 0)
        set(eng1Temp, get(oat))
    end

    -- ENG1 BLEED SWITCHES
    if get(switches.eng1Bleed) == 1 then
        if get(eng1Press) > 8 and get(apuValve) == 0 then
            set(eng1Valve, 1)
        else
            set(eng1Valve, 0)
        end
    else
        set(eng1Valve, 0)
    end

    -- ENG2 BLEED
    if get(eng2N1) > 12 then
        set(eng2Press, 40)
        set(eng2Temp, 200)
    else
        set(eng2Press, 0)
        set(eng2Temp, get(oat))
    end

    -- ENG2 BLEED SWITCHES
    if get(switches.eng2Bleed) == 1 then
        if get(eng2Press) > 8 and get(apuValve) == 0 then
            set(eng2Valve, 1)
        else
            set(eng2Valve, 0)
        end
    else
        set(eng2Valve, 0)
    end

    --CROSSBLEED
    if get(switches.crossBleed) == 0 then
        set(banks.crossBleed, 0)
    elseif get(switches.crossBleed) == 1 then
        if get(apuValve) == 1 then
            set(banks.crossBleed, 1)
        else
            set(banks.crossBleed, 0)
        end
    elseif get(switches.crossBleed) == 2 then
        set(banks.crossBleed, 1)
    end

    -- LEFT SIDE LOGIC
    if get(apuValve) == 1 or get(eng1Valve) == 1 or get(banks.crossBleed) == 1 then
        if get(apuValve) == 1 then
            set(banks.left.press, get(apuPress))
            set(banks.left.temp, get(apuTemp))
        elseif get(eng1Valve) == 1 then
            set(banks.left.press, get(eng1Press))
            set(banks.left.temp, get(eng1Temp))
        elseif get(banks.crossBleed) == 1 and get(eng2Valve) == 1 then
            set(banks.left.press, get(banks.right.press))
            set(banks.left.temp, get(banks.right.temp))
        else
            set(banks.left.press, 0)
            if get(banks.left.temp) >= 0 then
                set(banks.left.temp, get(banks.left.temp) - 0.8 * get(delta_time))
            else
                set(banks.left.temp, 0)
            end
        end
    else
        set(banks.left.press, 0)
        if get(banks.left.temp) >= 0 then
            set(banks.left.temp, get(banks.left.temp) - 0.8 * get(delta_time))
        else
            set(banks.left.temp, 0)
        end
    end

    -- RIGHT SIDE LOGIC
    if get(eng2Valve) == 1 or get(banks.crossBleed) == 1 then
        if get(eng2Valve) == 1 then
            set(banks.right.press, get(eng2Press))
            set(banks.right.temp, get(eng2Temp))
        elseif get(banks.crossBleed) == 1 and (get(eng1Valve) == 1 or get(apuValve) == 1) then
            set(banks.right.press, get(banks.left.press))
            set(banks.right.temp, get(banks.left.temp))
        else
            set(banks.right.press, 0)
            if get(banks.right.temp) >= 0 then
                set(banks.right.temp, get(banks.right.temp) - 0.8 * get(delta_time))
            else
                set(banks.right.temp, 0)
            end
        end
    else
        set(banks.right.press, 0)
        if get(banks.right.temp) >= 0 then
            set(banks.right.temp, get(banks.right.temp) - 0.8 * get(delta_time))
        else
            set(banks.right.temp, 0)
        end
    end

    -- PACK SWITCH LOGIC
    if get(switches.pack1) == 1 then
        if (get(modeSel) == 2 and get(eng1N1) < 19.5) or (get(modeSel) == 2 and get(eng2N1) < 19.5) then
            set(packs.one.valve, 0)
        else
            set(packs.one.valve, 1)
        end
    else
        set(packs.one.valve, 0)
    end
    if get(switches.pack2) == 1 then
        if (get(modeSel) == 2 and get(eng1N1) < 19.5) or (get(modeSel) == 2 and get(eng2N1) < 19.5) then
            set(packs.two.valve, 0)
        else
            set(packs.two.valve, 1)
        end
    else
        set(packs.two.valve, 0)
    end

    -- PACK 1 TEMPS
    if get(packs.one.valve) == 1 then
        if get(banks.left.temp) < 10 then
            set(packs.one.temp, 0)
        else
            set(packs.one.temp, get(banks.left.temp) - 10)
        end
    else
        set(packs.one.temp, get(packs.one.temp) - 0.02 * get(delta_time))
    end

    -- PACK 2 TEMPS
    if get(packs.two.valve) == 1 then
        if get(banks.right.temp) < 10 then
            set(packs.two.temp, 0)
        else
            set(packs.two.temp, get(banks.right.temp) - 10)
        end
    else
        set(packs.two.temp, get(packs.two.temp) - 0.02 * get(delta_time))
    end

    -- MIXER UNIT PRESSURE
    if get(packs.one.valve) == 1 or get(packs.two.valve) == 1 then
        -- packs are on, mixer pressurised
        if get(packs.one.valve) == 1 then
            set(banks.mixer.press, get(banks.left.press))
        elseif get(packs.two.valve) == 1 then
            set(banks.mixer.press, get(banks.right.press))
        else
            set(banks.mixer.press, 0)
        end
    else
        set(banks.mixer.press, 0)
    end

    -- COCKPIT TEMP
    if get(banks.mixer.press) > 0 then
        -- mixer has air, time to heat
        if get(zones.cockpit.actTemp) > get(zones.cockpit.reqTemp) then
            set(zones.cockpit.actTemp, (get(zones.cockpit.actTemp) - (0.04 * get(delta_time))))
        elseif get(zones.cockpit.actTemp) < get(zones.cockpit.reqTemp) then
            set(zones.cockpit.actTemp, (get(zones.cockpit.actTemp) + (0.04 * get(delta_time))))
        elseif get(zones.cockpit.actTemp) == get(zones.cockpit.reqTemp) then
            -- do nothing
        end
    elseif get(banks.mixer.press) == 0 then
        -- mixer has no air
        if get(zones.cockpit.actTemp) > get(oat) then
            set(zones.cockpit.actTemp, (get(zones.cockpit.actTemp) - (0.005 * get(delta_time))))
        elseif get(zones.cockpit.actTemp) < get(oat) then
            set(zones.cockpit.actTemp, (get(zones.cockpit.actTemp) + (0.005 * get(delta_time))))
        elseif get(zones.cockpit.actTemp) == get(oat) then
            -- do nothing
        end
    end

    -- FWD CABIN TEMP
    if get(banks.mixer.press) > 0 then
        -- mixer has air, time to heat
        if get(zones.fwd.actTemp) > get(zones.fwd.reqTemp) then
            set(zones.fwd.actTemp, (get(zones.fwd.actTemp) - (0.02 * get(delta_time))))
        elseif get(zones.fwd.actTemp) < get(zones.fwd.reqTemp) then
            set(zones.fwd.actTemp, (get(zones.fwd.actTemp) + (0.02 * get(delta_time))))
        elseif get(zones.fwd.actTemp) == get(zones.fwd.reqTemp) then
            -- do nothing
        end
    elseif get(banks.mixer.press) == 0 then
        -- mixer has no air
        if get(zones.fwd.actTemp) > get(oat) then
            set(zones.fwd.actTemp, (get(zones.fwd.actTemp) - (0.005 * get(delta_time))))
        elseif get(zones.fwd.actTemp) < get(oat) then
            set(zones.fwd.actTemp, (get(zones.fwd.actTemp) + (0.005 * get(delta_time))))
        elseif get(zones.fwd.actTemp) == get(oat) then
            -- do nothing
        end
    end

    -- AFT CABIN TEMP
    if get(banks.mixer.press) > 0 then
        -- mixer has air, time to heat
        if get(zones.aft.actTemp) > get(zones.aft.reqTemp) then
            set(zones.aft.actTemp, (get(zones.aft.actTemp) - (0.02 * get(delta_time))))
        elseif get(zones.aft.actTemp) < get(zones.aft.reqTemp) then
            set(zones.aft.actTemp, (get(zones.aft.actTemp) + (0.02 * get(delta_time))))
        elseif get(zones.aft.actTemp) == get(zones.aft.reqTemp) then
            -- do nothing
        end
    elseif get(banks.mixer.press) == 0 then
        -- mixer has no air
        if get(zones.aft.actTemp) > get(oat) then
            set(zones.aft.actTemp, (get(zones.aft.actTemp) - (0.005 * get(delta_time))))
        elseif get(zones.aft.actTemp) < get(oat) then
            set(zones.aft.actTemp, (get(zones.aft.actTemp) + (0.005 * get(delta_time))))
        elseif get(zones.aft.actTemp) == get(oat) then
            -- do nothing
        end
    end
end