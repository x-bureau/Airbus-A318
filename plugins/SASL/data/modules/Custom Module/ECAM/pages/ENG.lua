local eng1OilPress = globalProperty("sim/flightmodel/engine/ENGN_oil_press_psi[0]")
local eng2OilPress = globalProperty("sim/flightmodel/engine/ENGN_oil_press_psi[1]")
local eng1OilTemp = globalProperty("sim/cockpit2/engine/indicators/oil_temperature_deg_C[0]")
local eng2OilTemp = globalProperty("sim/cockpit2/engine/indicators/oil_temperature_deg_C[1]")
local eng1OilQuant = globalProperty("sim/flightmodel/engine/ENGN_oil_quan[0]")
local eng2OilQuant = globalProperty("sim/flightmodel/engine/ENGN_oil_quan[1]")
local eng1FuelUsed = globalPropertyf("A318/systems/FADEC/eng1FuelUsed")
local eng2FuelUsed = globalPropertyf("A318/systems/FADEC/eng2FuelUsed")
local leftPress = globalProperty("A318/systems/bleed/left/pressure")
local rightPress = globalProperty("A318/systems/bleed/right/pressure")
local eng1MSTR = globalPropertyi("A318/systems/FADEC/ENG1MASTR")
local eng2MSTR = globalPropertyi("A318/systems/FADEC/ENG2MASTR")
local modeSel = globalPropertyi("A318/systems/FADEC/MODESEL")
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")
local eng2N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[1]")

function draw_eng_page()--draw engine page
    sasl.gl.saveInternalLineState()
    sasl.gl.setInternalLineWidth(2)

    sasl.gl.drawText(AirbusFont, 43, 469, "ENGINE", 21, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(39, 456, 118, 456, 2, ECAM_COLOURS.WHITE)

    -- FUEL USED
    sasl.gl.drawText(AirbusFont, 261, 443, "F. USED", 20, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 170, 424, math.floor(get(eng1FuelUsed) / 10 + 0.5) * 10, 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawWideLine(209, 429, 235, 429, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 424, "KG", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    sasl.gl.drawWideLine(313, 429, 287, 429, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 352, 424, math.floor(get(eng2FuelUsed) / 10 + 0.5) * 10, 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)

    -- OIL QUANTITY
    sasl.gl.drawArcLine(170, 371, 45, 0, 180, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(125, 372, 130, 372, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(170, 411, 170, 416, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(210, 372, 215, 372, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawArcLine(352, 371, 45, 0, 180, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(307, 372, 312, 372, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(352, 411, 352, 416, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(392, 372, 397, 372, 2, ECAM_COLOURS.WHITE)

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(170, 372)
    sasl.gl.setRotateTransform(90 - (5 * (22 - (22 * get(eng1OilQuant)))))
    sasl.gl.drawWideLine(0, 22, 0, 48, 3, ECAM_COLOURS.GREEN)
    sasl.gl.restoreGraphicsContext()
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(352, 372)
    sasl.gl.setRotateTransform(90 - (5 * (22 - (22 * get(eng2OilQuant)))))
    sasl.gl.drawWideLine(0, 22, 0, 48, 3, ECAM_COLOURS.GREEN)
    sasl.gl.restoreGraphicsContext()

    sasl.gl.drawText(AirbusFont, 193, 371, string.format("%.1f", math.floor((22 * get(eng1OilQuant)) / 0.5 + 0.5) * 0.5), 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 261, 398, "OIL", 20, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 371, "QT", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 376, 371, string.format("%.1f", math.floor((22 * get(eng2OilQuant)) / 0.5 + 0.5) * 0.5), 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)

    -- OIL PRESSURE
    sasl.gl.drawArcLine(170, 313, 45, 0, 158, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(170, 352, 170, 359, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(210, 314, 215, 314, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawArcLine(170, 313, 45, 158, 22, ECAM_COLOURS.RED)
    sasl.gl.drawArcLine(352, 313, 45, 0, 158, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(352, 352, 352, 359, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(392, 314, 397, 314, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawArcLine(352, 313, 45, 158, 22, ECAM_COLOURS.RED)

    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(170, 314)
    sasl.gl.setRotateTransform(-90 + (1.83 * get(eng1OilPress)))
    if get(eng1OilPress) < 12 then
        sasl.gl.drawWideLine(0, 22, 0, 48, 3, ECAM_COLOURS.RED)
    else
        sasl.gl.drawWideLine(0, 22, 0, 48, 3, ECAM_COLOURS.GREEN)
    end
    sasl.gl.restoreGraphicsContext()
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(352, 314)
    sasl.gl.setRotateTransform(-90 + (1.83 * get(eng2OilPress)))
    if get(eng2OilPress) < 12 then
        sasl.gl.drawWideLine(0, 22, 0, 48, 3, ECAM_COLOURS.RED)
    else
        sasl.gl.drawWideLine(0, 22, 0, 48, 3, ECAM_COLOURS.GREEN)
    end
    sasl.gl.restoreGraphicsContext()

    if get(eng1OilPress) < 12 then
        sasl.gl.drawText(AirbusFont, 187, 313, math.floor(get(eng1OilPress) / 2 + 0.5) * 2, 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.RED)
    else
        sasl.gl.drawText(AirbusFont, 187, 313, math.floor(get(eng1OilPress) / 2 + 0.5) * 2, 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    end
    sasl.gl.drawText(AirbusFont, 261, 313, "PSI", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    if get(eng2OilPress) < 12 then
        sasl.gl.drawText(AirbusFont, 370, 313, math.floor(get(eng2OilPress) / 2 + 0.5) * 2, 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.RED)
    else
        sasl.gl.drawText(AirbusFont, 370, 313, math.floor(get(eng2OilPress) / 2 + 0.5) * 2, 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    end

    -- OIL TEMPERATURE
    sasl.gl.drawText(AirbusFont, 187, 287, "0", 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawWideLine(209, 292, 235, 292, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 287, "°C", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)
    sasl.gl.drawWideLine(313, 292, 287, 292, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 370, 287, "0", 21, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)

    -- VIB
    sasl.gl.drawText(AirbusFont, 261, 260, "VIB", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 170, 235, "0.0", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawWideLine(209, 240, 235, 240, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 235, "N1", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(313, 240, 287, 240, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 352, 235, "0.0", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)

    sasl.gl.drawText(AirbusFont, 170, 214, "0.0", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    sasl.gl.drawWideLine(209, 219, 235, 219, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 214, "N2", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(313, 219, 287, 219, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 352, 214, "0.0", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)

    -- IGN MODE
    if get(modeSel) == 2 then
        sasl.gl.drawText(AirbusFont, 261, 156, "IGN", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 261, 91, "PSI", 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.BLUE)

        sasl.gl.drawLine(170, 110, 170, 151, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(170, 131, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(170, 131, 11, true, ECAM_COLOURS.BLACK)
        sasl.gl.drawLine(352, 110, 352, 151, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(352, 131, 13, true, ECAM_COLOURS.GREEN)
        sasl.gl.drawCircle(352, 131, 11, true, ECAM_COLOURS.BLACK)

        if get(eng1MSTR) == 1 and get(eng1N1) < 19.5 and get(leftPress) > 0 then
            sasl.gl.drawLine(170, 118, 170, 144, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawLine(157, 131, 183, 131, ECAM_COLOURS.GREEN)
        end
        if get(eng2MSTR) == 1 and get(eng2N1) < 19.5 and get(rightPress) > 0 then
            sasl.gl.drawLine(352, 118, 352, 144, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawLine(339, 131, 365, 131, ECAM_COLOURS.GREEN)
        end

        if get(leftPress) > 0 then
            sasl.gl.drawText(AirbusFont, 170, 91, math.floor(get(leftPress) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawText(AirbusFont, 170, 91, math.floor(get(leftPress) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        end
        if get(rightPress) > 0 then
            sasl.gl.drawText(AirbusFont, 352, 91, math.floor(get(rightPress) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawText(AirbusFont, 352, 91, math.floor(get(rightPress) + 0.5), 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        end
    end
    sasl.gl.restoreInternalLineState()
end