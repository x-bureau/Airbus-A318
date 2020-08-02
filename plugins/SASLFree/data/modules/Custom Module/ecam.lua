--A318 Created by X-Bureau--

position = {1144, 622, 522, 522}
size = {522, 522}

--get datarefs
local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)
local n2percent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)
local EGT = globalPropertyfa("sim/flightmodel/engine/ENGN_EGT_c", 7)

--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--images
local needle1 = sasl.gl.loadImage("images/Needle1.png", 0, 0, 89, 47)

--colors
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}
local PFD_GREY = {0.25, 0.26, 0.26, 1.0}


--custom functions
local function draw_ENG_PAGE()
    sasl.gl.drawText(AirbusFont, 205, 455, math.floor(get(npercent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 410, 455, math.floor(get(npercent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 190, 325, math.floor(get(n2percent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 390, 325, math.floor(get(n2percent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 199, 368, math.floor(get(EGT, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 403, 368, math.floor(get(EGT, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 1) * 1.8, 140, 450, 89, 47, PFD_WHITE)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 2) * 1.8, 343, 450, 89, 47, PFD_WHITE)
end

function draw()
    draw_ENG_PAGE()
end
