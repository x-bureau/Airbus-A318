size={225,-308}


defineProperty("alt_hold",
globalPropertyf("sim/cockpit2/autopilot/altitude_dial_ft"))
defineProperty("altitude",
globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot"))
defineProperty("brightness",
globalPropertyf("sim/cockpit2/electrical/instrument_brightness_ratio[0]"))

local font1=loadFont('B612.ttf')

function draw()
drawAll (components)

drawText (font1, 200, 300,