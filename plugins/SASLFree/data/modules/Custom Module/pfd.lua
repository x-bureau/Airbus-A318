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
background = sasl.gl.loadImage("images/horizon_background.png", 0, 95, 263, 500)
pscale = sasl.gl.loadImage("images/horizon_pitch_scale.png", 0, 95, 508, 1050)
align = sasl.gl.loadImage("PFD_Alignment.png", 0, 105, 522, 522)
pitch_indicator = sasl.gl.loadImage("images/PFD_Other.png", 263, 500)


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
  sasl.gl.setClipArea(0, 100, 490, 400)
  sasl.gl.drawRotatedTextureCenter(background, 0 - get(roll), 200, 200, -300, ((0- get(pitch)) * 5) + 25, 1000, 700, PFD_WHITE)
  sasl.gl.drawRotatedTextureCenter(pscale, 0 - get(roll), 200, 200, 0, ((0 - get(pitch)) * 5) - 168, 500, 1000, PFD_WHITE)
  sasl.gl.drawRotatedTextureCenter(pitch_indicator, 0 - get(roll), 200, 200, 50, ((0- get(pitch)) * 5) - 70, 263, 500, PFD_WHITE)
  sasl.gl.drawRotatedTextureCenter(align, 0 - get(roll), 200, 200, 0, 90, 522, 522, PFD_WHITE)
-- angle, rx, ry, x, y, width, height, color
end


function draw()
  draw_artificial_horizon()
  sasl.gl.drawTexture(overlay, 0, 90, 522, 522)
  draw_speed_indicator()
  draw_alt_indicator()
  sasl.gl.resetClipArea()
end

    
  