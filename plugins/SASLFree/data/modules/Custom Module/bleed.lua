require "common_declarations"

local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local apuN1 = globalProperty("sim/cockpit2/electrical/APU_N1_percent")

local apuPress = createGlobalPropertyf("A318/systems/bleed/APUPress", 0)
local apuValve = createGlobalPropertyi("A318/systems/bleed/APUValve", 0)

local eng1Press = createGlobalPropertyf("A318/systems/bleed/ENG1Press", 0)
local eng1Valve = createGlobalPropertyi("A318/systems/bleed/ENG1Valve", 0)

local eng2Press = createGlobalPropertyf("A318/systems/bleed/ENG2Press", 0)
local eng2Valve = createGlobalPropertyi("A318/systems/bleed/ENG2Valve", 0)

local simapuBleed = globalProperty("sim/cockpit2/bleedair/actuators/apu_bleed")
local simeng1Bleed = globalProperty("sim/cockpit2/bleedair/actuators/engine_bleed_sov[0]")
local simeng2Bleed = globalProperty("sim/cockpit2/bleedair/actuators/engine_bleed_sov[1]")

switches = {
    eng1Bleed = createGlobalPropertyi("A318/systems/bleed/ENG1BLEED", 1),
    eng2Bleed = createGlobalPropertyi("A318/systems/bleed/ENG2BLEED", 1),
    apuBleed = createGlobalPropertyi("A318/systems/bleed/APUBLEED", 0),
    crossBleed = createGlobalPropertyi("A318/systems/bleed/CROSSBLEED", 1)
}

banks = {
    left = {
        press = createGlobalPropertyf("A318/systems/bleed/left/pressure", 0)
    },
    right = {
        press = createGlobalPropertyf("A318/systems/bleed/right/pressure", 0)
    },
    crossBleed = createGlobalPropertyi("A318/systems/bleed/crossBleed", 0)
}

function update()
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
    else
        set(apuPress, 0)
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
        set(eng1Press, 30)
    else
        set(eng1Press, 0)
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
        set(eng2Press, 30)
    else
        set(eng2Press, 0)
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
        elseif get(eng1Valve) == 1 then
            set(banks.left.press, get(eng1Press))
        elseif get(banks.crossBleed) == 1 and get(eng2Valve) == 1 then
            set(banks.left.press, get(banks.right.press))
        else
            set(banks.left.press, 0)
        end
    else
        set(banks.left.press, 0)
    end

    -- RIGHT SIDE LOGIC
    if get(eng2Valve) == 1 or get(banks.crossBleed) == 1 then
        if get(eng2Valve) == 1 then
            set(banks.right.press, get(eng2Press))
        elseif get(banks.crossBleed) == 1 and (get(eng1Valve) == 1 or get(apuValve) == 1) then
            set(banks.right.press, get(banks.left.press))
        else
            set(banks.right.press, 0)
        end
    else
        set(banks.right.press, 0)
    end
end