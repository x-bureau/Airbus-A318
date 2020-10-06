-- A318 created by X-Bureau --
require "common_declarations"
-- create control datarefs
local rotate = createGlobalPropertyi("A318/controls/rotate", 0)

-- create cockpit datarefs
local gpws_dataref = createGlobalPropertyi("A318/cockpit/egpws/altitude", 0)--GPWS Dataref
local too_low_gear = createGlobalPropertyi("A318/cockpit/warnings/too_low_gear", 0)--Dataref for Too Low gear alarm

-- systems datarefs
    -- fuel
local xfeed_state = createGlobalPropertyi("A318/systems/fuel/pumps/xfeed_state", valve_states.open)
local centre_fuel_pump_mode = createGlobalPropertyi("A318/systems/fuel/pumps/centre_mode_sel", auto_man_states.auto) -- Dataref for centre fuel tank model selector 0 = auto; 1 = manual
local eng_valve_state = createGlobalPropertyia("A318/systems/fuel/eng_valves", {valve_states.closed, valve_states.closed})

    -- apu
local apu_valve_state = createGlobalPropertyi("A318/systems/engines/apu/apu_valve", valve_states.closed)

-- create efb datarefs
-- TODO this should be fetched from some config/saved state
local unit = createGlobalPropertyi("A318/efb/config/units", units.metric)

local altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")
local gear_status = globalProperty("sim/flightmodel2/gear/deploy_ratio")--Gear deployment status dataref

function update()
  -- If pitch <= 0, and pitch is >= 0, set rotate dataref to 1
  if math.floor(get(altitude)) <= 0 and math.floor(get(pitch)) > 0 then
    set(rotate, 1)
  else
    set(rotate, 0)
  end

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
