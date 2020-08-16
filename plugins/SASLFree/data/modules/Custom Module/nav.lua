-- A318 Created by X-Bureau --

position = {10, 100, 522, 522}
size = {522, 522}

-- get datarefs
heading = globalPropertyf("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot")
local tairspeed = globalPropertyf("sim/cockpit2/gauges/indicators/true_airspeed_kts_pilot")
local gspeed = globalPropertyf("sim/flightmodel/position/groundspeed")
local winddirection = globalPropertyf("sim/weather/wind_direction_degt")
local windspeed = globalPropertyf("sim/weather/wind_speed_kt")


--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--colors
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}
local PFD_GREY = {0.25, 0.26, 0.26, 1.0}

--get images
local nd_overlay = sasl.gl.loadImage("images/Nav_Overlay.png", 0, 0, 2048, 2048)
local miniplane = sasl.gl.loadImage("images/A320-ND-Rose-Airplane-Standalone.png", 0, 0, 160, 160)
local arc = sasl.gl.loadImage("images/ARC_Nav.png", 0, 0, 2048, 2048)
local arcTape = sasl.gl.loadImage("images/ARC_Tape.png", 0, 0, 3072, 3072)

--custom functions

local function draw_overlay_text()
    sasl.gl.drawText(AirbusFont, 185, 432, math.floor(get(tairspeed)), 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(AirbusFont, 80, 432, math.floor(get(gspeed)), 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(AirbusFont, 80, 410, math.floor(get(winddirection)), 18, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
    sasl.gl.drawText(AirbusFont, 120, 410, math.floor(get(windspeed)), 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
end

local function draw_rose_cardinal()
   sasl.gl.drawRotatedTexture(arcTape, 0 - get(heading), -110, -375, 800, 800, PFD_WHITE)
end

function draw()
    sasl.gl.drawTexture(nd_overlay, 22, -44, 500, 500)
    sasl.gl.drawTexture(arc, 24, -105, 522, 522)
    sasl.gl.drawTexture(miniplane, 261, 20, 50, 50)
    sasl.gl.resetClipArea()
    draw_rose_cardinal()
    draw_overlay_text()
    sasl.gl.resetClipArea()

end

