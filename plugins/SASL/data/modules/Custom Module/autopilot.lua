--Airbus A318 By X-Bureau--
-----------------------------------------------------------------------------------------------------
-- Written by 
-- FBI914 
-- Evn
--THIS IS A SPED UPDATE

-- TODO : figure out some way to throttle up depeding on what speed they asked
-----------------------------------------------------------------------------------------------------
position = {1570, 3602, 421, 87}
size = {421, 87}

local AP_SPD = createGlobalPropertyi("A318/cockpit/ap/speed", 0)
local AP_SPD_ENGAGE = createGlobalPropertyi("A318/cockpit/ap/ENGAGE_SPEED", 0)
local AIRSPEED = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
local ENGINE_PERCENT = globalPropertyfa("sim/flightmodel/engine/ENGN_N1", 7)
local gspeed = globalPropertyf("sim/flightmodel/position/groundspeed")
local throttle_up = sasl.findCommand("sim/engines/throttle_up")
local throttle_down = sasl.findCommand("sim/engines/throttle_down")
local throttle_down = sasl.findCommand("sim/engines/throttle_down")
local speed_setting = globalPropertyf("sim/cockpit/autopilot/airspeed")
local hdg_setting = globalPropertyf("sim/cockpit/autopilot/heading")
local alt_step_setting = globalPropertyf("sim/aircraft/autopilot/alt_step_ft")
local altitude_setting = globalPropertyf("sim/cockpit/autopilot/altitude")

local AP_SPD_SIZE = 34
local MCDU_ORANGE = {1.0, 0.625, 0.0, 1.0}
local font = sasl.gl.loadFont("fonts/digital.ttf")
local AP_WHITE = {1.0, 1.0, 1.0, 1.0}
local AP_GOLD = {1.0, 0.85, 0, 1.0}



function draw_panel()
    -- DRAW SPEED
    sasl.gl.drawText(font, 25, 40, "SPD", 24, false, false, TEXT_ALIGN_LEFT, AP_GOLD )
    sasl.gl.drawText(font, 45, 1, get(speed_setting), 50, true, false, TEXT_ALIGN_LEFT,AP_GOLD)
    -- DRAW HEADING
    sasl.gl.drawText(font, 170, 40, "HDG", 24, false, false, TEXT_ALIGN_LEFT, AP_GOLD)
    sasl.gl.drawText(font, 260, 40, "LAT", 24, false, false, TEXT_ALIGN_LEFT, AP_GOLD)
    sasl.gl.drawText(font, 190, 1, math.floor(get(hdg_setting)), 50, true, false, TEXT_ALIGN_LEFT,AP_GOLD)
    sasl.gl.drawText(font, 372, 18, "HDG", 30, false, false, TEXT_ALIGN_LEFT, AP_GOLD)
    -- DRAW altitude
    sasl.gl.drawText(font, 15, 123, "V/S", 30, false, false, TEXT_ALIGN_LEFT, AP_GOLD)
    sasl.gl.drawText(font, 185, 155, "ALT", 24, false, false, TEXT_ALIGN_LEFT, AP_GOLD)
    sasl.gl.drawText(font, 120, 115, math.floor(get(altitude_setting)), 50, false, false, TEXT_ALIGN_LEFT, AP_GOLD)



end

function draw()
draw_panel()
end
