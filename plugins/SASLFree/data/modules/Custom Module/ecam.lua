--A318 Created by X-Bureau--

position = {1144, 622, 522, 522}
size = {512, 512}

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
local ECAM_GREEN = {0.184, 0.733, 0.219, 1.0}
local ECAM_WHITE = {1.0, 1.0, 1.0, 1.0}
local ECAM_BLUE = {0.004, 1.0, 1.0, 1.0}
local ECAM_GREY = {0.25, 0.26, 0.26, 1.0}
local ECAM_BLACK = {0, 0, 0, 1.0}
local ECAM_ORANGE = {1.0, 0.625, 0.0, 1.0}
local ECAM_RED = {1.0, 0.0, 0.0, 1.0}
--custom functions

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function draw_avail(side)
    if side == 2 then 
        sasl.gl.drawFrame ( 330, 419, 50, 17, ECAM_WHITE)
        sasl.gl.drawText(AirbusFont,  355.5, 420, "AVAIL", 18, true, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    elseif side == 1 then 
        sasl.gl.drawFrame ( 160, 419, 50, 17, ECAM_WHITE)
        sasl.gl.drawText(AirbusFont,  185, 420, "AVAIL", 18, true, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    end
end

local function draw_ENG_PAGE()
    -- Center
    sasl.gl.drawText(AirbusFont,  270, 420, "N1", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  270, 400, "%", 20, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)

    sasl.gl.drawText(AirbusFont,  270, 370, "EGT", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  270, 350, "*C", 20, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)

    sasl.gl.drawText(AirbusFont,  270, 320, "N2", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  270, 300, "%", 20, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)

    --  N1
    sasl.gl.drawFrame ( 160, 400, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  190, 402, round(get(npercent, 1), 1), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    sasl.gl.drawFrame ( 330, 400, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  360, 402, round(get(npercent, 1), 1), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    sasl.gl.drawCircle(110, 400, 3, false, ECAM_BLUE)
    -- EGT 
    sasl.gl.drawFrame ( 350, 350, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  375, 352, math.floor(get(EGT, 1)), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    sasl.gl.drawFrame ( 140, 350, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  165, 352, math.floor(get(EGT, 2)), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)



  -- Bottom messages shit 
   sasl.gl.drawText(AirbusFont, 60, 220, 'FOB :', 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
   sasl.gl.drawText(AirbusFont, 200, 219, 'KG', 16, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)
   sasl.gl.drawWidePolyLine({335,200, 520, 200}, 3, ECAM_WHITE)
   sasl.gl.drawWidePolyLine({315,50, 315,190}, 3, ECAM_WHITE)
   sasl.gl.drawWidePolyLine({30,200, 300, 200}, 3, ECAM_WHITE)

end

function draw_message(message, line, type)
    if line == 1 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 175, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 1 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 175, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
    elseif line == 1 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 175, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED)
    elseif line == 2 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 2 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE )
    elseif line == 2 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED )
    elseif line == 3 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 3 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE )
    elseif line == 3 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED )
    elseif line == 4 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 4 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE )
    elseif line == 4 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED )
    end
    
end

function update()

end

function draw()
    if get(AC_BUS) > 0 then
        draw_ENG_PAGE()
        draw_message("SEATBELTS", 1, 1)
        draw_message("NO SMOKING", 2, 1)
    else
        -- off
    end
end
