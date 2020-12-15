-- A318 created by X-Bureau --
require "common_declarations"

--baro datarefs
baro_units = {["hPa"] = 0, ["inHg"] = 1, ["STD"] = 2}

-- control datarefs
    local rotate = createGlobalPropertyi("A318/controls/rotate", 0)
    local altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
    local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")
    local flapHandleDeployRatio = globalPropertyf("sim/cockpit2/controls/flap_ratio")

-- flaps Position datarefs
    local flaps = createGlobalPropertyi("A318/controls/flaps/position", 0)

-- cockpit datarefs
    local gpws_dataref = createGlobalPropertyi("A318/cockpit/egpws/altitude", 0)--GPWS Dataref
    local gear_status = globalPropertyfa("sim/flightmodel2/gear/deploy_ratio")--Gear deployment status dataref
    local too_low_gear = createGlobalPropertyi("A318/cockpit/warnings/too_low_gear", 0)--Dataref for Too Low gear alarm

-- systems datarefs
    -- fuel
        local xfeed_state = createGlobalPropertyi("A318/systems/fuel/pumps/xfeed_state", valve_states.open)
        local centre_fuel_pump_mode = createGlobalPropertyi("A318/systems/fuel/pumps/centre_mode_sel", auto_man_states.auto) -- Dataref for centre fuel tank model selector 0 = auto; 1 = manual
        local eng_valve_state = createGlobalPropertyia("A318/systems/fuel/eng_valves", {valve_states.closed, valve_states.closed})

    -- cond
        createGlobalPropertyi("A318/systems/aircond/ldg_elev", 100)-- selected landing elevation
        createGlobalPropertyi("A318/systems/aircond/ldg_elev_auto", 1)-- landing elevation in auto mode
        createGlobalPropertyfa("A318/systems/aircond/temps/actual", {22.5, 23.2, 24.1})-- actual temperatures in cockpit, forward and aft cabin
        createGlobalPropertyia("A318/systems/aircond/temps/selected", {23, 24, 24})-- selected temperatures in cockpit, forward and aft cabin

    -- apu
        createGlobalPropertyi("A318/systems/engines/apu/apu_valve", valve_states.closed)

    -- electrical
        --BATTERIES
            createGlobalPropertyia("A318/systems/electrical/switches/battery", {switch_states.off, switch_states.off})--Dataref for Battery switch states
            createGlobalPropertyfa("A318/systems/electrical/dc/battery_1", {0, 0})--Dataref for Battery 1 volts|amps

            createGlobalPropertyfa("A318/systems/electrical/dc/battery_2", {0, 0})--Dataref for Battery 2 volts|amps

        --BUSES
            createGlobalPropertyi("A318/systems/electrical/dc/ess_bus", switch_states.off)--Dataref for the DC ESS BUS
            createGlobalPropertyi("A318/systems/electrical/dc/emer_bus", switch_states.off)--Dataref for the DC EMER BUS

        --GENERATORS
            createGlobalPropertyia("A318/systems/electrical/ac/ext", {switch_states.off, 0, 0}) -- switch|volts|hz
            createGlobalPropertyia("A318/systems/electrical/ac/apu", {switch_states.off, 0, 0, 0}) -- switch|volts|hz|pcent
            createGlobalPropertyia("A318/systems/electrical/ac/gen_1", {switch_states.on, 115, 398, 38}) -- switch|volts|hz|pcent
            createGlobalPropertyia("A318/systems/electrical/ac/gen_2", {switch_states.on, 115, 400, 43}) -- switch|volts|hz|pcent

        --IDG
            createGlobalPropertyia("A318/systems/electrical/idg/temp", {45, 45}) --IDG temperatures
            createGlobalPropertyia("A318/systems/electrical/idg/pressure", {0.25, 0.25}) --IDG pressures, pcent of n2
            
-- efb datarefs
-- TODO this should be fetched from some config/saved state
createGlobalPropertyi("A318/efb/config/units", units.metric)

--baro
local baro_unit = createGlobalPropertyi("A318/cockpit/efis/baro_unit", baro_units.hPa)

function get_baro_unit_selected(hPa)
	if get(efb_units) == baro_units.hPa then
		return hPa
	end
	return hPa * 0.02953
end

function update()
  -- If pitch <= 0, and pitch is >= 0, set rotate dataref to 1
  if math.floor(get(altitude)) <= 0 and math.floor(get(pitch)) > 0 then
    set(rotate, 1)
  else
    set(rotate, 0)
  end
	
  --Setting the flaps deflection dataref 
  --VALUES: 0, 10, 15, 20, 40
  flaps = get(flapHandleDeployRatio) * 40


  if get(altitude)      == 2500 then
      set(gpws_dataref, 2500)
  elseif get(altitude)  == 2000 then
      set(gpws_dataref, 2000)
  elseif get(altitude)  == 1000 then
      set(gpws_dataref, 1000)
  elseif get(altitude)  == 500 then
      set(gpws_dataref, 500)
  elseif get(altitude)  == 400 then
      set(gpws_dataref, 400)    
  elseif get(altitude)  == 300 then
      set(gpws_dataref, 300)
  elseif get(altitude)  == 200 then
      set(gpws_dataref, 200)
  elseif get(altitude)  == 100 then
      set(gpws_dataref, 100)
  elseif get(altitude)  == 50 then
      set(gpws_dataref, 50)
  elseif get(altitude)  == 40 then
      set(gpws_dataref, 40)
  elseif get(altitude)  == 30 then
      set(gpws_dataref, 30)    
  elseif get(altitude)  == 25 then
      set(gpws_dataref, 25)
  elseif get(altitude)  == 10 then
      set(gpws_dataref, 10)
  elseif get(altitude)  == 5 then
      set(gpws_dataref, 5)
  end
 
    -- sasl.logInfo(get(gear_status))
    -- TOO LOW GEAR FUNCTION
    -- jamlen: commented out as gear_status is an array and can't compare to 1... therefore it was failing to load the module.
    -- if get(gear_status) < 1 and math.floor(get(altitude)) <= 750 then
    --     set(too_low_gear, 1)
    -- else
    --     set(too_low_gear, 0)
    -- end
 
  updateAll(components)
end
