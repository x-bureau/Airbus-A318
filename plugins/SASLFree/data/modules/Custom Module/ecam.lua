--A318 Created by X-Bureau--

position = {1144, 622, 522, 522}
size = {522, 522}

--get datarefs

local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)
local n2percent = globalPropertyfa("sim/cockpit2/engine/indicators/N2_percent", 7)
local EGT = globalPropertyfa("sim/flightmodel/engine/ENGN_EGT_c", 7)
local FOB = globalPropertyfa("sim/cockpit2/fuel/fuel_quantity", 0)

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
local PFD_ORANGE = {1.0, 0.625, 0.0, 1.0}


--custom functions

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end


-- todo : get fuel in all tanks check if engines are burning fuel if they are get fuel burned and take it away from the tank value 
FOB = get(FOB, 1) + get(FOB, 2) + get(FOB, 3) + get(FOB, 4) + get(FOB, 5)
FOB = round(FOB, 1)
print(FOB)
local function draw_ENG_PAGE()
    sasl.gl.drawTexture(Backround, 10, 47, 550, 520, PFD_WHITE)
    -- if get(npercent, 1) == 0 and get(npercent, 2) == 0 then
    -- sasl.gl.drawText(AirbusFont, 205, 445, "XX", 20, false, false, TEXT_ALIGN_RIGHT, PFD_ORANGE)
    -- sasl.gl.drawText(AirbusFont, 410, 445, "XX", 20, false, false, TEXT_ALIGN_RIGHT, PFD_ORANGE)
    -- sasl.gl.drawText(AirbusFont, 189, 323, "XX", 20, false, false, TEXT_ALIGN_RIGHT, PFD_ORANGE)
    -- sasl.gl.drawText(AirbusFont, 390, 323, "XX", 20, false, false, TEXT_ALIGN_RIGHT, PFD_ORANGE)
    -- sasl.gl.drawText(AirbusFont, 195.9, 366.7, "XX", 20, false, false, TEXT_ALIGN_RIGHT, PFD_ORANGE)
    -- sasl.gl.drawText(AirbusFont, 398, 366.7, "XX", 20, false, false, TEXT_ALIGN_RIGHT, PFD_ORANGE)
    -- else

    sasl.gl.drawText(AirbusFont, 205, 445, math.floor(get(npercent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 410, 445, math.floor(get(npercent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 189, 323, math.floor(get(n2percent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 390, 323, math.floor(get(n2percent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 195.9, 366.7, math.floor(get(EGT, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 398, 366.7, math.floor(get(EGT, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 158, 219, FOB , 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 1) * 1.7, 133, 446, 89, 47, PFD_WHITE)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 2) * 1.7, 333, 446, 89, 47, PFD_WHITE)
    -- end 
end


function draw()
    message_mode = 5
    draw_ENG_PAGE()
   -- print(get(current_page))

end
