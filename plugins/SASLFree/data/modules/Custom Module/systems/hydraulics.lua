------------------------------------------------------------------------
--Airbus A318 By X-Bureau--
--CONTRIBUITORS:
--FBI914

require "common_declarations"
local EventEmitter = require "events_min"

------------------------------------------------------------------------
--Defining the Hydraulic System Components
------------------------------------------------------------------------

local hyd = {
    green = EventEmitter:new({
        qty = createGlobalPropertyi("A318/systems/hyd/green/qty", 145), -- qty in cl
        pressure = createGlobalPropertyi("A318/systems/hyd/green/pressure", 0),
        temp = createGlobalPropertyi("A318/systems/hyd/green/temp", 145), 
        shutoff_valve = {state = createGlobalPropertyi("A318/systems/hyd/green/shutoff_valve", valve_states.open)},
        pumps = {
            engine = {state = createGlobalPropertyi("A318/systems/hyd/green/pumps/engine/state", pump_states.low)},
        },
    }),
    blue = EventEmitter:new({
        qty = createGlobalPropertyi("A318/systems/hyd/blue/qty", 65), -- qty in cl
        pressure = createGlobalPropertyi("A318/systems/hyd/blue/pressure", 0),
        temp = createGlobalPropertyi("A318/systems/hyd/blue/temp", 65), 
        pumps = {
            electric = {state = createGlobalPropertyi("A318/systems/hyd/blue/pumps/electric/state", pump_states.off)},
            rat = {
                pb = createGlobalPropertyi("A318/systems/hyd/blue/pumps/rat/pb", switch_states.off),
                state = createGlobalPropertyi("A318/systems/hyd/blue/pumps/rat/state", pump_states.off),
                is_extended = createGlobalPropertyi("A318/systems/hyd/blue/pumps/rat/is_extended", 0),
                can_retract = false
            },
        },
    }),
    yellow = EventEmitter:new({
        qty = createGlobalPropertyi("A318/systems/hyd/yellow/qty", 125), -- qty in cl
        pressure = createGlobalPropertyi("A318/systems/hyd/yellow/pressure", 0), -- pressure in psi
        temp = createGlobalPropertyi("A318/systems/hyd/yellow/temp", 125), -- temp in c
        shutoff_valve = {state = createGlobalPropertyi("A318/systems/hyd/yellow/shutoff_valve", valve_states.open)},
        pumps = {
            engine = {state = createGlobalPropertyi("A318/systems/hyd/yellow/pumps/engine/state", pump_states.low)},
            electric = {state = createGlobalPropertyi("A318/systems/hyd/yellow/pumps/electric/state", pump_states.off)},
        },
    }),
    ptu = EventEmitter:new({
        enabled = createGlobalPropertyi("A318/systems/hyd/ptu/enabled", enabled_states.disabled),
        xfer = {from = createGlobalPropertys("A318/systems/hyd/ptu/from", "yellow")},
        auto_xfer_psi_diff = 500
    })
}

hyd.blue:on('rat_pb', function(pb_state)
    if pb_state == switch_states.on then
        set(hyd.blue.pumps.rat.state, pump_states.on)
    else
        set(hyd.blue.pumps.rat.state, pump_states.off)
    end
    print("rat state " .. get(hyd.blue.pumps.rat.state))
end)

function rat_pb_handler(phase)
    local current_pb_state = get(hyd.blue.pumps.rat.pb)
    local new_pb_state = current_pb_state
    if phase == SASL_COMMAND_BEGIN then
        if current_pb_state == switch_states.off then
            new_pb_state = switch_states.on
        else
            new_pb_state = switch_states.off
        end
        set(hyd.blue.pumps.rat.pb, new_pb_state)
    elseif phase == SASL_COMMAND_END then
        hyd.blue:emit('rat_pb', new_pb_state)
    end
    return 1 
end

local rat_pb = sasl.findCommand("A318/systems/hyd/pbs/rat")
sasl.registerCommandHandler(rat_pb, 0, rat_pb_handler)

local NmlOpPress = 3000 --The NORMAL OPERATION TEMPERATURE is 3000 psi
local RAT = 2500 --The RAM AIR TURBINE (RAT) powers the BLUE system in an emergency at 2500 psi

local N1Percent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7) --Get the N1 percent of the engines

local isOnGround = globalPropertyi("sim/flightmodel/failures/onground_any") --If the user is on the ground, this dataref is set to 1

----------------------------------------------------------------------------------
--LOGIC TIME!
----------------------------------------------------------------------------------
function update()
    ----------------------------------------------------------------------------------
    --Ram Air Turbine (RAT) Logic
    ----------------------------------------------------------------------------------
    --If the Aircraft is on the ground, then the RAT can retract.
    if get(isOnGround) == 1 then
        set(hyd.blue.pumps.rat.can_retract, 1)
    else
        set(hyd.blue.pumps.rat.can_retract, 0)
        set(hyd.blue.pumps.rat.is_extended, 1)
    end

    --If the Aircraft is on the ground, then the RAT can be deployed manually
    if get(isOnGround) == 1 and get(hyd.blue.pumps.rat.pb) == switch_states.on then
        set(hyd.blue.pumps.rat.is_extended, 1)
    elseif get(isOnGround) == 0 and get(hyd.blue.pumps.rat.pb) == switch_states.on then
        set(hyd.blue.pumps.rat.can_retract, 0)
    end

    --If the Ram Air Turbine (RAT) cannot retract, then it will continue in the extended position
    if get(hyd.blue.pumps.rat.can_retract) == false then
        set(hyd.blue.pumps.rat.is_extended, 1)
    end

    --If the BLUE PUMP fails, then use the Ram Air Turbine (RAT) to power the BLUE SYSTEM
    if get(hyd.blue.pumps.electric.state) == pump_states.on and get(hyd.blue.pumps.rat.is_extended) == true then
        set(hyd.blue.pressure, RAT)
    end

    ----------------------------------------------------------------------------------
    --Power Transfer Unit (PTU) Logic
    ----------------------------------------------------------------------------------
    --Automatically activating the PTU when it reaches the 500 psi difference threshold
    if get(hyd.green.pressure) - get(hyd.yellow.pressure) >= 500 and get(hyd.yellow.shutoff_valve.state) == valve_states.open then --If the GREEN SYSTEM - the YELLOW SYSTEM is = or > than 500, then activate the Power Transfer Unit (PTU)
        set(hyd.ptu.enabled, enabled_states.enabled)
        set(hyd.ptu.xfer.from, "green")
        sasl.logInfo("xfer from green")
    elseif get(hyd.yellow.pressure) - get(hyd.green.pressure) >= 500 and get(hyd.green.shutoff_valve.state) == valve_states.open then --If the YELLOW SYSTEM - the GREEN SYSTEM is = or > than 500, then activate the Power Transfer Unit (PTU)
        set(hyd.ptu.enabled, enabled_states.enabled)
        set(hyd.ptu.xfer.from, "yellow")
        sasl.logInfo("xfer from yellow")
    else
        set(hyd.ptu.enabled, enabled_states.disabled)
    end

    --Logic to determine how much pressure to transfer to the other system
    local green_pressure = get(hyd.green.pressure)
    local yellow_pressure = get(hyd.yellow.pressure)
    if get(hyd.ptu.enabled) == enabled_states.enabled and get(hyd.yellow.shutoff_valve.state) == valve_states.open and green_pressure > yellow_pressure then
        set(hyd.yellow.pressure, yellow_pressure + ((green_pressure - yellow_pressure) / 2))
        set(hyd.ptu.xfer.from, "yellow")
        while hyd.ptu.enabled == enabled_states.enabled and green_pressure < NmlOpPress do --While the PTU is active and the GREEN SYSTEM is less than 3000 psi, add to it until it once again meets that threshold
            set(hyd.green.pressure, green_pressure + 1)
        end
        if yellow_pressure == 3000 and green_pressure == 3000 then --If both the GREEN and YELLOW systems once again meet the threshold, turn off the PTU.
            set(hyd.ptu.enabled, enabled_states.disabled)
            set(hyd.ptu.xfer.from, "yellow")
        end
    elseif get(hyd.ptu.enabled) == enabled_states.enabled and get(hyd.green.shutoff_valve.state) == valve_states.open and yellow_pressure > green_pressure then
        set(hyd.green.pressure, green_pressure + ((yellow_pressure - green_pressure) / 2))
        set(hyd.ptu.xfer.from, "green")
        while hyd.ptu.enabled == enabled_states.enabled and yellow_pressure < NmlOpPress do --While the PTU is active and the GREEN SYSTEM is less than 3000 psi, add to it until it once again meets that threshold
            set(hyd.yellow.pressure, yellow_pressure + 1)
        end
        if green_pressure == 3000 and yellow_pressure == 3000 then --If both the GREEN and YELLOW systems once again meet the threshold, turn off the PTU.
            set(hyd.ptu.enabled, enabled_states.disabled)
            set(hyd.ptu.xfer.from, "green")
        end
    end
    ----------------------------------------------------------------------------------
    --PUMP LOGIC
    ----------------------------------------------------------------------------------
    --If an engine is running, then the BLUE PUMP can start
    if get(N1Percent, 1) > 0 or get(N1Percent, 2) > 0 then
        set(hyd.blue.pumps.electric.state, pump_states.on)
    else
        set(hyd.blue.pumps.electric.state, pump_states.off)
    end

    --Logic for the GREEN SYSTEM PUMP
    -- TODO only if system has pump creating pressure
    if get(hyd.green.pumps.engine.state) ==pump_states.on then
        if get(hyd.green.shutoff_valve.state) == valve_states.open and get(hyd.green.pressure) < 3000 and get(hyd.ptu.xfer.from) == 'yellow' then
            if get(hyd.green.pressure) < 3000 then
                set(hyd.green.pressure, get(hyd.green.pressure) + 10)
            end
        end
    end

    -- --Logic for the YELLOW SYSTEM PUMP
    -- if get(FireShutOffYellow) == false and get(hyd.yellow) < 3000 and get(PTU.transferToYellow) == false then
    --     while get(hyd.yellow) < 3000
    --         if get(timer) == 120 then
    --             hyd.yellow = hyd.yellow + 10
    --             set(timer) = 0
    --         end
    --     end
    -- end

    -- if get(hyd.yellow.shutoff_valve.state) == valve_states.open and get(hyd.yellow.pressure) < 3000 and get(hyd.ptu.xfer.from) == 'green' then
    --     while get(hyd.yellow.pressure) < 3000
    --         if get(timer) == 120 then
    --             hyd.yellow.pressure = hyd.yellow.pressure + 10
    --             set(timer, 0)
    --         end
    --     end
    -- end

    -- ----------------------------------------------------------------------------------
    -- --TODO: WRITE THE LOGIC FOR THE FIRE SHUT OFF
    -- ----------------------------------------------------------------------------------
end
