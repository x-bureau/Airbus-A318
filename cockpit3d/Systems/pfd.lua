-- A318 Created by X-Bureau --

size={400,640}

defineProperty("alt_hold", globalPropertyf("sim/cockpit2/autopilot/altitude_dial_ft")) -- Get alt to hold
defineProperty("altitude", globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")) -- Get current alt
defineProperty("brightness", globalPropertyf("sim/cockpit2/electrical/instrument_brightness_ratio[0]")) -- Get current brightness lvl

local airbusFont=loadfont('B612-Regular.ttf')

function draw()
drawAll(components)

drawText(airbusFont, 200, 300, string.format("%d", get(alt_hold)), 1, 1, 1, brightness)
  
local alt=get(altitude)
  if alt <= get(alt_hold) - 500 or alt >= get(alt_hold) + 500 then -- if we're 500ft below or above target alt
    drawText(airbusFont, 200, 300, string.format("%d", get(alt_hold)), 1,0,0)
  else
    drawText(airbusFont, 200, 300, string.format("%d", get(alt_hold)), 0,1,0)