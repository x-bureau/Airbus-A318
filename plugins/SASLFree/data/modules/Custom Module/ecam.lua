--A318 Created by X-Bureau--

position = {1144, 622, 522, 522}
size = {522, 522}

--get datarefs
local AC_BUS = globalProperty("A318/systems/ELEC/ACESS_V")

local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)
local n2percent = globalPropertyfa("sim/cockpit2/engine/indicators/N2_percent", 7)
local EGT = globalPropertyfa("sim/flightmodel/engine/ENGN_EGT_c", 7)

--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--images
local needle1 = sasl.gl.loadImage("images/Needle1.png", 0, 0, 89, 47)
local Backround = sasl.gl.loadImage("images/EWD_Overlay.png", 0, 0, 522,522)

--colors
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}
local PFD_GREY = {0.25, 0.26, 0.26, 1.0}


--custom functions
local function draw_ENG_PAGE()

    sasl.gl.drawTexture(Backround, 10, 47, 550, 520, PFD_WHITE)
    sasl.gl.drawText(AirbusFont, 205, 445, math.floor(get(npercent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 410, 445, math.floor(get(npercent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 189, 323, math.floor(get(n2percent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 390, 323, math.floor(get(n2percent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 195.9, 366.7, math.floor(get(EGT, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 398, 366.7, math.floor(get(EGT, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 1) * 1.7, 133, 446, 89, 47, PFD_WHITE)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 2) * 1.7, 333, 446, 89, 47, PFD_WHITE)

end


function draw()
    message_mode = 5
    if get(AC_BUS) > 0 then
        draw_ENG_PAGE()
    else
        -- off
    end
end
