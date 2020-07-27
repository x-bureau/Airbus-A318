-- A318 Created by X-Bureau --

position = {50, 600, 522, 522}
size = {522, 522}

--get datarefs
airspeed = globalPropertyf("sim/flightmodel/position/indicated_airspeed")
altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")

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


--custom functions
local function draw_speed_indicator()
  --speed indicator
  sasl.gl.drawText(AirbusFont, -462, 300, get(airspeed), 30, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
end

local function draw_alt_indicator()
  --alt indicator
  sasl.gl.drawText(AirbusFont, 75, 300, get(altitude), 21, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
end

function draw()
  draw_speed_indicator()
  draw_alt_indicator()
  sasl.gl.drawTexture(background, 0, 95, 263, 390)
  sasl.gl.drawTexture(overlay, 0, 150, 522, 522)
end

    
  
  
  
  
  
