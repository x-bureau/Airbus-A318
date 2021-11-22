-- A318 created by X-Bureau --
require "common_declarations"

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
    -- hydraulic
        -- GREEN

-- efb datarefs
-- TODO this should be fetched from some config/saved state
-- createGlobalPropertyi("A318/efb/config/units", units.metric)
createGlobalPropertyi("A318/efb/config/isa_enabled", enabled_states.disabled)
createGlobalPropertyi("A318/efb/config/activePage", 1)

------------------------------------------------------------------------------------------------------
-- Commands
------------------------------------------------------------------------------------------------------

sasl.createCommand("A318/systems/hyd/pbs/rat", "RAT push button")
sasl.createCommand("A318/systems/hyd/pbs/ptu", "PTU push button")
sasl.createCommand("A318/systems/hyd/pbs/green/eng1_pump", "GREEN system Engine 1 Pump push button")
sasl.createCommand("A318/systems/hyd/pbs/yellow/eng2_pump", "YELLOW system Engine 1 Pump push button")
sasl.createCommand("A318/systems/hyd/pbs/yellow/elec_pump", "YELLOW system Electric Pump push button")
sasl.createCommand("A318/systems/hyd/pbs/blue/elec_pump", "BLUE system Electric Pump push button")


function update()
  -- If pitch <= 0, and pitch is >= 0, set rotate dataref to 1
  if math.floor(get(altitude)) <= 0 and math.floor(get(pitch)) > 0 then
    set(rotate, 1)
  else
    set(rotate, 0)
  end
	
  --Setting the flaps deflection dataref 
  --VALUES: 0, 10, 15, 20, 40
  set(flaps, (get(flapHandleDeployRatio)* 40))


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
