local startup_complete = false

local eng1MSTR = createGlobalPropertyi("A318/systems/FADEC/ENG1MASTR", 0)
local eng2MSTR = createGlobalPropertyi("A318/systems/FADEC/ENG2MASTR", 0)
local modeSel = createGlobalPropertyi("A318/systems/FADEC/MODESEL", 2)

local eng1IsRunning = 0
local eng2IsRunning = 0

local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local eng1N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[0]")
local eng2N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[1]")

local eng1Starter = globalProperty("sim/cockpit2/engine/actuators/ignition_key[0]")
local eng2Starter = globalProperty("sim/cockpit2/engine/actuators/ignition_key[1]")

local eng1Shutdown = sasl.findCommand("sim/starters/shut_down_1")
local eng2Shutdown = sasl.findCommand("sim/starters/shut_down_2")

function startup()
    if get(eng1N1) > 1 or get(eng2N1) > 1 then
        set(eng1MSTR, 1)
        eng1IsRunning = 1
        set(eng2MSTR, 1)
        eng2IsRunning = 1
    else
        set(eng1MSTR, 0)
        eng1IsRunning = 0
        set(eng2MSTR, 0)
        eng2IsRunning = 0
    end
end

function update()
    if not startup_complete then
        startup()
        startup_complete = true
    end

    -- ENG 1
    if get(eng1MSTR) == 1 then
        -- eng on
        set(eng1Starter, 3)
        if get(modeSel) == 2 then
            -- ignition
            if get(eng1IsRunning) == 0 then
                set(eng1Starter, 4)
            end
        end
    else
        -- eng off
        set(eng1Starter, 0)
        sasl.commandOnce(eng1Shutdown)
    end

    if get(eng1N2) > 23.5 then
        eng1IsRunning = 1
    else
        eng1IsRunning = 0
    end

    -- ENG 2
    if get(eng2MSTR) == 1 then
        -- eng on
        set(eng2Starter, 3)
        if get(modeSel) == 2 then
            -- ignition
            if get(eng2IsRunning) == 0 then
                set(eng2Starter, 4)
            end
        end
    else
        -- eng off
        set(eng2Starter, 0)
        sasl.commandOnce(eng2Shutdown)
    end

    if get(eng2N2) > 23.5 then
        eng2IsRunning = 1
    else
        eng2IsRunning = 0
    end
end