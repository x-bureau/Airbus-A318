require "common_declarations"

local eng1N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[0]")
local eng2N2 = globalProperty("sim/flightmodel/engine/ENGN_N2_[1]")

local apuValve = globalPropertyi("A318/systems/bleed/APUValve")

local eng1Valve = globalPropertyi("A318/systems/bleed/ENG1Valve")
local eng2Valve = globalPropertyi("A318/systems/bleed/ENG2Valve")

local mixerPress = globalPropertyf("A318/systems/bleed/mixer/pressure")
local leftPress = globalPropertyf("A318/systems/bleed/left/pressure")
local leftTemp = globalPropertyf("A318/systems/bleed/left/temp")
local rightPress = globalPropertyf("A318/systems/bleed/right/pressure")
local rightTemp = globalPropertyf("A318/systems/bleed/right/temp")

local crossBleed = globalPropertyi("A318/systems/bleed/crossBleed")

local pack1valve = globalPropertyi("A318/systems/bleed/packs/one/valve")
local pack2valve = globalPropertyi("A318/systems/bleed/packs/two/valve")

local apuMstr = globalPropertyi("A318/systems/ELEC/APUMASTRSwtch")

local pack1Temp = globalPropertyf("A318/systems/bleed/packs/one/temp")
local pack1Out = globalPropertyf("A318/systems/aircond/cockpit/actTemp")
local pack2Temp = globalPropertyf("A318/systems/bleed/packs/two/temp")
local pack2Out = globalPropertyf("A318/systems/aircond/aft/actTemp")

function draw_bleed_page()

    sasl.gl.drawWideLine(23, 480, 78, 480, 1, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 23, 485, 'BLEED', 21, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)

    -- MIXER STATUS

    if get(mixerPress) > 30 then
        sasl.gl.drawWidePolyLine({104, 450, 104, 470, 418, 470, 418, 450}, 2, ECAM_COLOURS.GREEN)

        sasl.gl.drawWidePolyLine({150, 475, 162, 475, 156, 485, 150, 475}, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawWidePolyLine({255, 475, 267, 475, 261, 485, 255, 475}, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawWidePolyLine({359, 475, 372, 475, 366, 485, 359, 475}, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawWidePolyLine({104, 450, 104, 470, 418, 470, 418, 450}, 2, ECAM_COLOURS.ORANGE)

        sasl.gl.drawWidePolyLine({150, 475, 162, 475, 156, 485, 150, 475}, 2, ECAM_COLOURS.ORANGE)
        sasl.gl.drawWidePolyLine({255, 475, 267, 475, 261, 485, 255, 475}, 2, ECAM_COLOURS.ORANGE)
        sasl.gl.drawWidePolyLine({359, 475, 372, 475, 366, 485, 359, 475}, 2, ECAM_COLOURS.ORANGE)
    end

    -- RAM AIR ( USELESS :( )
    sasl.gl.drawCircle(261, 436, 13, true, ECAM_COLOURS.GREEN)
    sasl.gl.drawCircle(261, 436, 11, true, {0, 0, 0})
    sasl.gl.drawWideLine(250, 436, 272, 436, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawWideLine(261, 425, 261, 403, 2, ECAM_COLOURS.GREEN)

    sasl.gl.drawText(AirbusFont, 261, 385, 'RAM', 18, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 364, 'AIR', 18, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)

    -- PACK 1 STATUS
    sasl.gl.drawRectangle(65, 332, 79, 118, ECAM_COLOURS.GREY)
    sasl.gl.drawCircle(104, 313, 40, true, {0, 0, 0})
    sasl.gl.drawArc(104, 313, 38, 40, 30, 120, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 144, 362, "°C", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 64, 326, "LO", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 145, 326, "HI", 17, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawArc(104, 384, 38, 40, 0, 180, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 144, 433, "°C", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 64, 384, "C", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 145, 384, "H", 17, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 104, 362, math.floor(get(pack1Temp) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 104, 433, math.floor(get(pack1Out) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)


    if get(pack1valve) == 0 then
        sasl.gl.drawCircle(104, 313, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(104, 313, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(93, 313, 115, 313, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawCircle(104, 313, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(104, 313, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(104, 302, 104, 324, 2, ECAM_COLOURS.GREEN)
    end

    -- PACK 2 STATUS
    sasl.gl.drawRectangle(379, 332, 79, 118, ECAM_COLOURS.GREY)
    sasl.gl.drawCircle(418, 313, 40, true, {0, 0, 0})
    sasl.gl.drawArc(418, 313, 38, 40, 30, 120, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 458, 362, "°C", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 378, 326, "LO", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 459, 326, "HI", 17, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawArc(418, 384, 38, 40, 0, 180, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 458, 433, "°C", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 378, 384, "C", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 459, 384, "H", 17, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 418, 362, math.floor(get(pack2Temp) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 418, 433, math.floor(get(pack2Out) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)

    if get(pack2valve) == 0 then
        sasl.gl.drawCircle(418, 313, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(418, 313, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(407, 313, 429, 313, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawCircle(418, 313, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(418, 313, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(418, 302, 418, 324, 2, ECAM_COLOURS.GREEN)
    end

    sasl.gl.drawWideLine(104, 302, 104, 170, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawWideLine(418, 302, 418, 170, 2, ECAM_COLOURS.GREEN)

    -- CROSS BLEED
    if get(crossBleed) == 1 then
        sasl.gl.drawCircle(313, 271, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(313, 271, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(104, 271, 418, 271, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawWideLine(275, 271, 351, 271, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(313, 271, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(313, 271, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(313, 260, 313, 282, 2, ECAM_COLOURS.GREEN)
    end

    -- APU
    sasl.gl.drawText(AirbusFont, 261, 160, 'APU', 18, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    if get(apuMstr) == 1 then
        sasl.gl.drawWidePolyLine({261, 177, 261, 271, 104, 271}, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawWideLine(261, 271, 275, 271, 2, ECAM_COLOURS.GREEN)

        if get(apuValve) == 1 then
            sasl.gl.drawCircle(261, 205, 13, true, ECAM_COLOURS.GREEN)
            sasl.gl.drawCircle(261, 205, 11, true, {0, 0, 0})
            sasl.gl.drawWideLine(261, 194, 261, 216, 2, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawCircle(261, 205, 13, true, ECAM_COLOURS.GREEN)
            sasl.gl.drawCircle(261, 205, 11, true, {0, 0, 0})
            sasl.gl.drawWideLine(250, 205, 272, 205, 2, ECAM_COLOURS.GREEN)
        end
    end

    -- ENG 1
    if get(eng1N2) < 60 then
        sasl.gl.drawText(AirbusFont, 51, 149, '1', 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    else
        sasl.gl.drawText(AirbusFont, 51, 149, '1', 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    end

    sasl.gl.drawWideLine(104, 144, 104, 105, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawCircle(144, 118, 13, true, ECAM_COLOURS.GREEN)
    sasl.gl.drawCircle(144, 118, 11, true, {0, 0, 0})
    sasl.gl.drawWidePolyLine({104, 118, 183, 118, 183, 105}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 104, 88, 'IP', 17, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 183, 88, 'HP', 17, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    if get(eng1Valve) == 1 then
        sasl.gl.drawCircle(104, 157, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(104, 157, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(104, 144, 104, 170, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawCircle(104, 157, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(104, 157, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(93, 157, 115, 157, 2, ECAM_COLOURS.GREEN)
    end

    -- ENG 2
    if get(eng2N2) < 60 then
        sasl.gl.drawText(AirbusFont, 470, 149, '2', 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    else
        sasl.gl.drawText(AirbusFont, 470, 149, '2', 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    end

    sasl.gl.drawWideLine(418, 144, 418, 105, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawCircle(378, 118, 13, true, ECAM_COLOURS.GREEN)
    sasl.gl.drawCircle(378, 118, 11, true, {0, 0, 0})
    sasl.gl.drawWidePolyLine({418, 118, 339, 118, 339, 105}, 2, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 418, 88, 'IP', 17, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 339, 88, 'HP', 17, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    if get(eng2Valve) == 1 then
        sasl.gl.drawCircle(418, 157, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(418, 157, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(418, 144, 418, 170, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawCircle(418, 157, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(418, 157, 11, true, {0, 0, 0})
        sasl.gl.drawWideLine(407, 157, 429, 157, 2, ECAM_COLOURS.GREEN)
    end

    -- T's and P's
    sasl.gl.drawRectangle(85, 192, 38, 44, ECAM_COLOURS.GREY)
    sasl.gl.drawText(AirbusFont, 160, 219, "PSI", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 160, 198, "°C", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 104, 216, math.floor(get(leftPress) + 0.5), 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 104, 195, math.floor(get(leftTemp) + 0.5), 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)


    sasl.gl.drawRectangle(399, 192, 38, 44, ECAM_COLOURS.GREY)
    sasl.gl.drawText(AirbusFont, 393, 219, "PSI", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 393, 198, "°C", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 418, 216, math.floor(get(rightPress) + 0.5), 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 418, 195, math.floor(get(rightTemp) + 0.5), 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    
end