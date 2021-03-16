--A318 Created by X-Bureau--

position = {1144, 622, 522, 522}
size = {512, 512}

--get datarefs
local AC_BUS = globalProperty("A318/systems/ELEC/ACESS_V")

local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local eng1N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[0]")
local eng2N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[1]")
local eng1EGT = globalProperty("sim/flightmodel/engine/ENGN_EGT_c[0]")
local eng2EGT = globalProperty("sim/flightmodel/engine/ENGN_EGT_c[1]")

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
        sasl.gl.drawFrame ( 360, 419, 50, 17, ECAM_WHITE)
        sasl.gl.drawText(AirbusFont, 385.5, 420, "AVAIL", 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    elseif side == 1 then 
        sasl.gl.drawFrame ( 160, 419, 50, 17, ECAM_WHITE)
        sasl.gl.drawText(AirbusFont,  185, 420, "AVAIL", 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
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

    -- N1 arcs
    sasl.gl.drawArc(175, 420, 48 , 50, 40, 155, ECAM_WHITE)
    sasl.gl.drawArc(375, 420, 48 , 50, 40, 155, ECAM_WHITE)
    sasl.gl.drawArc(175, 420, 48 , 50, 15, 30, ECAM_RED)
    sasl.gl.drawArc(375, 420, 48 , 50, 15, 30, ECAM_RED)
    sasl.gl.drawWidePolyLine({417,433, 425, 433}, 2, ECAM_RED)
    sasl.gl.drawWidePolyLine({217,433, 225, 433}, 2, ECAM_RED)
    sasl.gl.drawWidePolyLine({203,448, 215, 460}, 2, ECAM_ORANGE)
    sasl.gl.drawWidePolyLine({403,448, 415, 460}, 2, ECAM_ORANGE)


    -- Boxes and shit
    sasl.gl.drawFrame ( 160, 400, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  190, 402, string.format("%.1f", round(get(eng1N1), 1)), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    sasl.gl.drawFrame ( 360, 400, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  390, 402, string.format("%.1f", round(get(eng2N1), 1)), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)

  
    -- little circle things (math needs to be implemented to orbit the arc)
    sasl.gl.drawCircle(115, 410, 3, false, ECAM_BLUE)
    sasl.gl.drawCircle(315, 410, 3, false, ECAM_BLUE)
    -- EGT ARCS 
    -- sasl.gl.drawArc(165, 344, 48 , 50, 15, 155, ECAM_WHITE)
    -- sasl.gl.drawArc(405, 344, 48 , 50, 15, 155, ECAM_WHITE)
    -- EGT
    sasl.gl.drawFrame ( 380, 350, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  405, 352, math.floor(get(eng2EGT)), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    sasl.gl.drawFrame ( 140, 350, 50, 17, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont,  165, 352, math.floor(get(eng1EGT)), 18, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)



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
    elseif line == 1 and type == 4 then 
        sasl.gl.drawText(AirbusFont, 28, 175, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_BLUE)
    elseif line == 2 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 2 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE )
    elseif line == 2 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED )
    elseif line == 2 and type == 4 then 
        sasl.gl.drawText(AirbusFont, 28, 155, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_BLUE )
    elseif line == 3 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 3 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE )
    elseif line == 3 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED )
    elseif line == 3 and type == 4 then 
        sasl.gl.drawText(AirbusFont, 28, 135, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_BLUE )
    elseif line == 4 and type == 1 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_GREEN )
    elseif line == 4 and type == 2 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_ORANGE )
    elseif line == 4 and type == 3 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_RED )
    elseif line == 4 and type == 4 then 
        sasl.gl.drawText(AirbusFont, 28, 115, message, 21, true, false, TEXT_ALIGN_LEFT, ECAM_BLUE )
    end
    
end

function update()

end

function draw()
    if get(AC_BUS) > 0 then
        draw_ENG_PAGE()
        draw_message("SEATBELTS", 1, 1)
        draw_message("NO SMOKING", 2, 1)
        draw_message("X-BUREAU IS SWAG", 3, 4)
        --draw_avail(2)
    else
        -- off
    end
end
