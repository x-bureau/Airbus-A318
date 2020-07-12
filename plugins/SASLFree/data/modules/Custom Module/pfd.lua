-- A318 Created by X-Bureau --
position = {94, 1558, 2048, 2048}
size = {2048, 2048}

--get datarefs
airspeed = globalPropertyf("sim/flightmodel/position/indicated_airspeed")
altitude = globalPropertyf("sim/flightmodel/position/elevation")

--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--colors
local PFD_GREEN = {0.184, 0.733, 0.219}
local PFD_WHITE = {1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0}

--custom functions

local function draw_speed_indicator()
  --speed indicator
  sasl.gl.drawText(AirbusFont, 10, 10, get(airspeed), 30, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
end

local function draw_alt_indicator()
  --alt indicator
  sasl.gl.drawText(AirbusFont, 10, 50, get(altitude), 30, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
end

function draw()
  draw_speed_indicator()
  draw_alt_indicator()
end