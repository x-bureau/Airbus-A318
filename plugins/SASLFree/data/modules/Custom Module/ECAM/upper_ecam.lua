--A318 Created by X-Bureau--

position = {1165, 663, 519, 496}
size = {512, 512}

--get datarefs
local AC_BUS = globalProperty("A318/systems/ELEC/ACESS_V")
local selfTest = 0
local eng1AVAIL = 0
local eng2AVAIL = 0

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local Timer = 0
local TimerFinal = math.random(15, 35)

local TimerEng1 = 0
local TimerFinalEng1 = 10
local TimerEng2 = 0
local TimerFinalEng2 = 10

local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")
local eng1N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[0]")
local eng2N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[1]")
local eng1EGT = globalProperty("sim/flightmodel/engine/ENGN_EGT_c[0]")
local eng2EGT = globalProperty("sim/flightmodel/engine/ENGN_EGT_c[1]")

local eng1Throttle = globalProperty("sim/cockpit2/engine/actuators/throttle_ratio[0]")
local eng2Throttle = globalProperty("sim/cockpit2/engine/actuators/throttle_ratio[1]")

local eng1FF = globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[0]")
local eng2FF = globalProperty("sim/cockpit2/engine/indicators/fuel_flow_kg_sec[1]")

local fuel = globalProperty("sim/flightmodel/weight/m_fuel_total")

--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

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
    return string.format("%.1f", math.floor(num * mult + 0.5) / mult)
end

local function draw_avail(side)
    sasl.gl.saveInternalLineState()
    sasl.gl.setInternalLineWidth(1)
    if side == 2 then
        sasl.gl.drawRectangle(345, 434, 61, 20, ECAM_BLACK)
        sasl.gl.drawFrame(345, 434, 61, 20, ECAM_WHITE)
        sasl.gl.drawText(AirbusFont, 375.5, 436.5, "AVAIL", 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    elseif side == 1 then 
        sasl.gl.drawRectangle(146, 434, 61, 20, ECAM_BLACK)
        sasl.gl.drawFrame(146, 434, 61, 20, ECAM_WHITE)
        sasl.gl.drawText(AirbusFont, 176.5, 436.5, "AVAIL", 20, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
    end
    sasl.gl.restoreInternalLineState()
end

function getDec(num)
    return string.sub(num, string.len(num), string.len(num))
end

local function draw_ENG_PAGE()
    --sasl.gl.drawTexture(overlay, 0, 0, 512, 512)
    sasl.gl.saveInternalLineState()
    sasl.gl.setInternalLineWidth(2)

    --N1
    sasl.gl.drawArcLine(156, 447, 45, 28, 181, ECAM_WHITE)
    for i=0,4 do
        sasl.gl.saveGraphicsContext()
        sasl.gl.setTranslateTransform(156,447)
        sasl.gl.setRotateTransform(-47 + (22 * i))
        sasl.gl.drawLine(0, 39, 0, 45, ECAM_WHITE)
        sasl.gl.restoreGraphicsContext()
    end
    sasl.gl.drawLine(195, 448, 201, 448, ECAM_RED)
    sasl.gl.drawArcLine(156, 447, 45, 0, 28, ECAM_RED)
    sasl.gl.drawArcLine(156, 447, 39, 0, 28, ECAM_RED)
    sasl.gl.drawLine(190, 465, 197, 467, ECAM_RED)
    sasl.gl.drawWideLine(182, 479, 187, 485, 4, ECAM_ORANGE)
    sasl.gl.drawText(AirbusFont, 134, 462, "5", 16, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 173, 460, "10", 16, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(156,447)
    if get(eng1N1) < 19.9 then
        sasl.gl.setRotateTransform(-119)
    else
        sasl.gl.setRotateTransform(41 - (2 * (100 - get(eng1N1))))
    end
    sasl.gl.drawWideLine(0, 0, 0, 57, 3, ECAM_GREEN)
    sasl.gl.restoreGraphicsContext()
    sasl.gl.drawRectangle(146, 413, 61, 20, ECAM_BLACK)
    sasl.gl.drawFrame(146, 413, 61, 20, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 190, 416, math.floor(get(eng1N1))..".", 19, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 201, 416, getDec(round(get(eng1N1), 1)), 16, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    sasl.gl.drawText(AirbusFont, 256, 430, "N1", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 256, 414, "%", 19, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)

    sasl.gl.drawArcLine(356, 447, 45, 28, 181, ECAM_WHITE)
    for i=0,4 do
        sasl.gl.saveGraphicsContext()
        sasl.gl.setTranslateTransform(356,447)
        sasl.gl.setRotateTransform(-47 + (22 * i))
        sasl.gl.drawLine(0, 39, 0, 45, ECAM_WHITE)
        sasl.gl.restoreGraphicsContext()
    end
    sasl.gl.drawLine(395, 448, 401, 448, ECAM_RED)
    sasl.gl.drawArcLine(356, 447, 45, 0, 28, ECAM_RED)
    sasl.gl.drawArcLine(356, 447, 39, 0, 28, ECAM_RED)
    sasl.gl.drawLine(390, 465, 397, 467, ECAM_RED)
    sasl.gl.drawWideLine(382, 479, 387, 485, 4, ECAM_ORANGE)

    sasl.gl.drawText(AirbusFont, 334, 462, "5", 16, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 374, 460, "10", 16, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(356,447)
    if get(eng2N1) < 19.9 then
        sasl.gl.setRotateTransform(-119)
    else
        sasl.gl.setRotateTransform(41 - (2 * (100 - get(eng2N1))))
    end
    sasl.gl.drawWideLine(0, 0, 0, 57, 3, ECAM_GREEN)
    sasl.gl.restoreGraphicsContext()

    sasl.gl.drawRectangle(345, 413, 61, 20, ECAM_BLACK)
    sasl.gl.drawFrame(345, 413, 61, 20, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 390, 416, math.floor(get(eng2N1))..".", 19, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 400, 416, getDec(round(get(eng2N1), 1)), 16, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(156, 447)
    sasl.gl.setRotateTransform(41 - (160 * (1 - get(eng1Throttle))))
    sasl.gl.drawCircle(0, 48, 3.5, false, ECAM_BLUE)
    sasl.gl.restoreGraphicsContext()

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(356, 447)
    sasl.gl.setRotateTransform(41 - (160 * (1 - get(eng2Throttle))))
    sasl.gl.drawCircle(0, 48, 3.5, false, ECAM_BLUE)
    sasl.gl.restoreGraphicsContext()

    -- EGT
    sasl.gl.drawArcLine(156, 346, 40, 11, 169, ECAM_WHITE)
    sasl.gl.drawLine(156, 386, 156, 381, ECAM_WHITE)
    sasl.gl.drawLine(116, 346, 121, 346, ECAM_WHITE)
    sasl.gl.drawArcLine(156, 346, 40, 0, 11, ECAM_RED)
    sasl.gl.drawArcLine(156, 346, 35, 0, 9, ECAM_RED)
    sasl.gl.drawLine(190, 346, 197, 346, ECAM_RED)
    sasl.gl.drawLine(190, 352, 197, 353, ECAM_RED)

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(156,346)
    sasl.gl.setRotateTransform(-90 + (0.18 * get(eng1EGT)))
    sasl.gl.drawWideLine(0, 25, 0, 45, 3, ECAM_GREEN)
    sasl.gl.restoreGraphicsContext()

    sasl.gl.drawRectangle(131, 338, 50, 20, ECAM_BLACK)
    sasl.gl.drawFrame(131, 338, 50, 20, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 175, 341, math.floor(get(eng1EGT)), 19, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    sasl.gl.drawText(AirbusFont, 256, 357, "EGT", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 253, 340, "°C", 18, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)

    sasl.gl.drawArcLine(356, 346, 40, 11, 169, ECAM_WHITE)
    sasl.gl.drawLine(316, 346, 321, 346, ECAM_WHITE)
    sasl.gl.drawLine(356, 386, 356, 381, ECAM_WHITE)
    sasl.gl.drawArcLine(356, 346, 40, 0, 11, ECAM_RED)
    sasl.gl.drawArcLine(356, 346, 35, 0, 9, ECAM_RED)
    sasl.gl.drawLine(390, 346, 397, 346, ECAM_RED)
    sasl.gl.drawLine(390, 352, 397, 353, ECAM_RED)

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(356,346)
    sasl.gl.setRotateTransform(-90 + (0.18 * get(eng2EGT)))
    sasl.gl.drawWideLine(0, 25, 0, 45, 3, ECAM_GREEN)
    sasl.gl.restoreGraphicsContext()

    sasl.gl.drawRectangle(331, 338, 50, 20, ECAM_BLACK)
    sasl.gl.drawFrame(331, 338, 50, 20, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 375, 341, math.floor(get(eng2EGT)), 19, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    -- N2
    sasl.gl.drawText(AirbusFont, 167, 293, math.floor(get(eng1N2))..".", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 177, 293, getDec(round(get(eng1N2), 1)), 16, true, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawWideLine(209, 303, 231, 309, 2, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 256, 307, "N2", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 256, 290, "%", 19, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)
    sasl.gl.drawWideLine(281, 309, 303, 303, 2, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 368, 293, math.floor(get(eng2N2))..".", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 378, 293, getDec(round(get(eng2N2), 1)), 16, true, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    -- FF
    sasl.gl.drawText(AirbusFont, 177, 259, (math.floor((get(eng1FF) * 60 * 60) / 20 + 0.5) * 20), 19, true, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawWideLine(209, 266, 231, 273, 2, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 256, 266, "FF", 20, true, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 256, 250, "KG/H", 17, true, false, TEXT_ALIGN_CENTER, ECAM_BLUE)
    sasl.gl.drawWideLine(303, 266, 281, 273, 2, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 378, 259, (math.floor((get(eng2FF) * 60 * 60) / 20 + 0.5) * 20), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)

    -- Bottom Group
    sasl.gl.drawText(AirbusFont, 38, 187, 'FOB :', 21, false, false, TEXT_ALIGN_CENTER, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 143, 187, math.floor(get(fuel) / 100 + 0.5) * 100, 21, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 172, 187, 'KG', 19, false, false, TEXT_ALIGN_CENTER, ECAM_BLUE)
    sasl.gl.drawWidePolyLine({346, 167, 504, 167}, 2, ECAM_WHITE)
    sasl.gl.drawWidePolyLine({322, 26, 322, 155}, 2, ECAM_WHITE)
    sasl.gl.drawWidePolyLine({8, 167, 297, 167}, 2, ECAM_WHITE)

    sasl.gl.restoreInternalLineState()
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
    if get(eng1N1) < 19.5 then
        eng1AVAIL = 0
    end
    if get(eng2N1) < 19.5 then
        eng2AVAIL = 0
    end
end

function draw()
    if get(AC_BUS) > 0 then
        if selfTest == 1 then
            draw_ENG_PAGE()
            if TimerEng1 < TimerFinalEng1 and eng1AVAIL == 0 and get(eng1N1) > 19.5 then
                TimerEng1 = TimerEng1 + 1 * get(DELTA_TIME)
                draw_avail(1)
            else
                eng1AVAIL = 1
                TimerEng1 = 0
            end
            if TimerEng2 < TimerFinalEng2 and eng2AVAIL == 0 and get(eng2N1) > 19.5 then
                TimerEng2 = TimerEng2 + 1 * get(DELTA_TIME)
                draw_avail(2)
            else
                eng2AVAIL = 1
                TimerEng2 = 0
            end
            Timer = 0
        else
            if Timer < TimerFinal then
                Timer = Timer + 1 * get(DELTA_TIME)
                sasl.gl.drawText(AirbusFont, 256, 256, "SELF TEST IN PROGESS", 28.7, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
                sasl.gl.drawText(AirbusFont, 256, 225, "(MAX 40 SECONDS)", 28.7, false, false, TEXT_ALIGN_CENTER, ECAM_GREEN)
            else
                selfTest = 1
            end
        end
    else
        -- off
    end
end
