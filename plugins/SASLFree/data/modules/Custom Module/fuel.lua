local startup_complete = false

local override = globalProperty("sim/operation/override/override_fuel_system")

local fuelflowLeft = globalProperty("sim/flightmodel2/engines/has_fuel_flow_before_mixture[0]")
local fuelflowRight = globalProperty("sim/flightmodel2/engines/has_fuel_flow_before_mixture[1]")

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local Timer1 = 0
local TimerFinal1 = 120
local twoAfterStart1 = 0

local Timer2 = 0
local TimerFinal2 = 120
local twoAfterStart2 = 0

local slatRat = globalProperty("sim/flightmodel/controls/slatrat")


local eng1MSTR = globalProperty("A318/systems/FADEC/ENG1MASTR")
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng1FF = globalProperty("sim/flightmodel/engine/ENGN_FF_[0]")
local eng1Burning = globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[0]")
local eng2MSTR = globalProperty("A318/systems/FADEC/ENG2MASTR")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local eng2FF = globalProperty("sim/flightmodel/engine/ENGN_FF_[1]")
local eng2Burning = globalProperty("sim/flightmodel2/engines/engine_is_burning_fuel[1]")

local fuelTotal = globalProperty("sim/flightmodel/weight/m_fuel_total")
local fuelTanks = globalPropertyfa("sim/cockpit2/fuel/fuel_quantity")
local centerTank = globalProperty("sim/flightmodel/weight/m_fuel[0]")
local leftTank = globalProperty("sim/flightmodel/weight/m_fuel[2]")
local outerTankL = globalProperty("sim/flightmodel/weight/m_fuel[4]")
local rightTank = globalProperty("sim/flightmodel/weight/m_fuel[1]")
local outerTankR = globalProperty("sim/flightmodel/weight/m_fuel[3]")

local ltr1 = globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[0]")
local ltr2 = globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[1]")
local ctr1 = globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[4]")
local ctr2 = globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[5]")
local rtr1 = globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[2]")
local rtr2 = globalProperty("sim/cockpit2/fuel/fuel_tank_pump_on[3]")
local crossFeed = createGlobalPropertyi("A318/systems/FUEL/XFEED", 0)
local apuPump = createGlobalPropertyi("A318/systems/FUEL/APUPump", 0)
local apuMstr = globalProperty("A318/systems/ELEC/APUMASTRSwtch")
local apuN1 = globalProperty("sim/cockpit/engine/APU_N1")

local eng1LP = createGlobalPropertyi("A318/systems/FUEL/ENG1LP", 0)
local eng2LP = createGlobalPropertyi("A318/systems/FUEL/ENG2LP", 0)

local switches = {
    lTk1 = createGlobalPropertyi("A318/systems/FUEL/LTKPUMP1Switch", 0),
    lTk2 = createGlobalPropertyi("A318/systems/FUEL/LTKPUMP2Switch", 0),
    ctr1 = createGlobalPropertyi("A318/systems/FUEL/CTRPUMP1Switch", 0),
    ctrMode = createGlobalPropertyi("A318/systems/FUEL/CTRPUMPMODESwitch", 0),
    xfeed = createGlobalPropertyi("A318/systems/FUEL/XFEEDSwitch", 0),
    ctr2 = createGlobalPropertyi("A318/systems/FUEL/CTRPUMP2Switch", 0),
    rTk1 = createGlobalPropertyi("A318/systems/FUEL/RTKPUMP1Switch", 0),
    rTk2 = createGlobalPropertyi("A318/systems/FUEL/RTKPUMP2Switch", 0)
}

local function startup()
    if get(eng1N1) > 1 or get(eng2N1) > 1 then
        set(switches.lTk1, 1)
        set(switches.lTk2, 1)
        set(switches.ctr1, 1)
        set(switches.ctr2, 1)
        set(switches.rTk1, 1)
        set(switches.rTk2, 1)
    else
        set(switches.lTk1, 0)
        set(switches.lTk2, 0)
        set(switches.ctr1, 0)
        set(switches.ctr2, 0)
        set(switches.rTk1, 0)
        set(switches.rTk2, 0)
    end
end

function update()
    set(override, 1) -- override X-Plane's fuel system

    if not startup_complete then
        startup()
        startup_complete = true
    end

    if get(eng1MSTR) == 1 then
        set(eng1LP, 1)
    else
        set(eng1LP, 0)
    end
    if get(eng2MSTR) == 1 then
        set(eng2LP, 1)
    else
        set(eng2LP, 0)
    end

    -- If any of left pumps are on, the left engine has fuel
    if get(eng1LP) == 1 and get(leftTank) > 0 then
        set(fuelflowLeft, 1)
    elseif get(ctr1) == 1 and get(centerTank) > 0 then
        set(fuelflowLeft, 1)
    else
        set(fuelflowLeft, 0)
    end

    -- If any of right pumps are on, the right engine has fuel
    if get(eng2LP) == 1 and get(rightTank) > 0 then
        set(fuelflowRight, 1)
    elseif get(ctr2) == 1 and get(centerTank) > 0 then
        set(fuelflowRight, 1)
    else
        set(fuelflowRight, 0)
    end

    -- ENG 1 TIMER
    if get(eng1MSTR) == 1 and Timer1 < TimerFinal1 and twoAfterStart1 == 0 then
        Timer1 = Timer1 + 1 * get(DELTA_TIME)
    else
        twoAfterStart1 = 1
    end

    if get(eng1MSTR) == 0 then
        Timer1 = 0
        twoAfterStart1 = 0
    end

    -- ENG 2 TIMER
    if get(eng2MSTR) == 1 and Timer2 < TimerFinal2 and twoAfterStart2 == 0 then
        Timer2 = Timer2 + 1 * get(DELTA_TIME)
    else
        twoAfterStart2 = 1
    end

    if get(eng2MSTR) == 0 then
        Timer2 = 0
        twoAfterStart2 = 0
    end

    -- APU PUMP
    if get(apuMstr) == 1 then
        set(apuPump, 1)
    else
        set(apuPump, 0)
    end

    -- LEFT PUMPS
    if get(switches.lTk1) == 1 and get(fuelTanks, 3) > 750 then
        set(ltr1, 1)
    else
        set(ltr1, 0)
    end

    if get(switches.lTk2) == 1 and get(fuelTanks, 3) > 750 then
        set(ltr2, 1)
    else
        set(ltr2, 0)
    end

    -- RIGHT PUMPS
    if get(switches.rTk1) == 1 and get(fuelTanks, 2) > 750 then
        set(rtr1, 1)
    else
        set(rtr1, 0)
    end

    if get(switches.rTk2) == 1 and get(fuelTanks, 2) > 750 then
        set(rtr2, 1)
    else
        set(rtr2, 0)
    end

    -- CTR PUMPS
    if get(switches.ctrMode) == 1 then
        -- MAN MODE
        if get(switches.ctr1) == 1 then
            set(ctr1, 1)
        else
            set(ctr1, 0)
        end

        if get(switches.ctr2) == 1 then
            set(ctr2, 1)
        else
            set(ctr2, 0)
        end
    else
        -- AUTO MODE
        if get(switches.ctr1) == 1 then
            if (get(fuelTanks, 1) > 5341 or get(slatRat) > 0) and (get(eng1N1) == 0 or twoAfterStart1 == 1) then
                set(ctr1, 0)
            else
                if get(fuelTanks, 1) > 500 then
                    set(ctr1, 1)
                else
                    set(ctr1, 0)
                end
            end
        else
            set(ctr1, 0)
        end

        if get(switches.ctr2) == 1 then
            if (get(fuelTanks, 2) > 5341 or get(slatRat) > 0) and (get(eng2N1) == 0 or twoAfterStart2 == 1) then
                set(ctr2, 0)
            else
                if get(fuelTanks, 1) > 500 then
                    set(ctr2, 1)
                else
                    set(ctr2, 0)
                end
            end
        else
            set(ctr2, 0)
        end
    end

    -- ENG 1 FUEL BURN
    if get(eng1Burning) == 1 then
        if get(ctr1) == 1 then
            set(centerTank, (get(centerTank) - (get(DELTA_TIME) * get(eng1FF))))
        end
        if get(ctr1) == 0 then
            set(leftTank, (get(leftTank) - (get(DELTA_TIME) * get(eng1FF))))
        end
    else
        -- nothing
    end

    -- ENG 2 FUEL BURN
    if get(eng2Burning) == 1 then
        if get(ctr2) == 1 then
            set(centerTank, (get(centerTank) - (get(DELTA_TIME) * get(eng2FF))))
        end
        if get(ctr2) == 0 then
            set(rightTank, (get(rightTank) - (get(DELTA_TIME) * get(eng2FF))))
        end
    else
        -- nothing
    end

    -- APU FUEL BURN
    if get(apuN1) > 15 then
        if get(leftTank) > 0 then
            set(leftTank, (get(leftTank) - (get(DELTA_TIME) * 0.035)))
        elseif get(centerTank) > 0 then
            set(centerTank, (get(centerTank) - (get(DELTA_TIME) * 0.035)))
        end
    else
        -- No burn
    end

    -- LEFT OUTER TANK TRANSFER
    if get(leftTank) < 750 then
        if get(outerTankL) > 0 then
            set(leftTank, (get(leftTank) + (get(DELTA_TIME) * 2)))
            set(outerTankL, (get(outerTankL) - (get(DELTA_TIME) * 2)))
        end
    end

    -- RIGHT OUTER TANK TRANSFER
    if get(rightTank) < 750 then
        if get(outerTankR) > 0 then
            set(rightTank, (get(rightTank) + (get(DELTA_TIME) * 2)))
            set(outerTankR, (get(outerTankR) - (get(DELTA_TIME) * 2)))
        end
    end
end