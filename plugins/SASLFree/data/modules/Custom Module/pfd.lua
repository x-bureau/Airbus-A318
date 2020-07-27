-- A318 Created by X-Bureau --

position = {50, 600, 522, 522}
size = {522, 522}

--get datarefs
airspeed = globalPropertyf("sim/flightmodel/position/indicated_airspeed")
altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")
roll = globalPropertyf("sim/cockpit2/gauges/indicators/roll_electric_deg_pilot")


--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--colors
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}
local PFD_GREY = {0.25, 0.26, 0.26, 1.0}

--get images
overlay = sasl.gl.loadImage("images/PFD_Overlay.png", 0, 105, 552, 522)
background = sasl.gl.loadImage("images/horizon_background.png", 0, 95, 263, 395)
pscale = sasl.gl.loadImage("images/horizon_pitch_scale.png", 0, 95, 263, 395)

--custom functions
local function draw_speed_indicator()
  --speed indicator
  sasl.gl.drawText(AirbusFont, -462, 300, get(airspeed), 30, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
end

local function draw_alt_indicator()
  --alt indicator
  sasl.gl.drawText(AirbusFont, 95, 300, get(pitch), 21, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
end

local function draw_artificial_horizon()
  sasl.gl.setClipArea(0, 100, 522, 522)
  sasl.gl.drawRotatedTextureCenter(background, get(roll), 220, 220, 100, ((0- get(pitch)) * 6) + 90, 263, 395, PFD_WHITE)
  sasl.gl.drawRotatedTextureCenter(pscale, get(roll), 220, 220, 50, ((0- get(pitch)) * 6) - 10, 375, 600, PFD_WHITE)
-- angle, rx, ry, x, y, width, height, color
end

function draw()
  draw_artificial_horizon()
  sasl.gl.drawTexture(overlay, 0, 90, 522, 522)
  draw_speed_indicator()
  draw_alt_indicator()
end

    
  
  
  
  
  
