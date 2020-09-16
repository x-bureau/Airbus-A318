-- A318 created by X-Bureau --
--Defining the properties
local altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")
-- Defining the property --
local rotate = createGlobalPropertyi("A318/controls/rotate", 0)
local gpws_dataref = createGlobalPropertyi("a318/egpws/altitude", 0)--GPWS Dataref
local too_low_gear = createGlobalPropertyi("a318/warnings/too_low_gear", 0)--Dataref for Too Low gear alarm
local gear_status = globalPropertyf("sim/flightmodel2/gear/deploy_ratio")--Gear deployment status dataref
function update()
-- If pitch <= 0, and pitch is >= 0, set rotate dataref to 1
  if (math.floor(get(altitude)) <= 0 and (math.floor(get(pitch)) > 0 then
    set(rotate, 1)
  --else set rotate to 0
  else
    set(rotate, 0)
  end

  if get(altitude)  == 2500 then
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
 
  --TOO LOW GEAR FUNCTION
  if get(gear_status) < 1 and math.floor(get(altitude)) <= 750 then
      set(too_low_gear, 1)
  else
      set(too_low_gear, 0)
  end
 
      

end
