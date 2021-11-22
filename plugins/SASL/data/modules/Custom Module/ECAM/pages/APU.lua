require "common_declarations"

local mstrButton = globalProperty("A318/systems/ELEC/APUMASTRSwtch")
local genButton = globalProperty("A318/systems/ELEC/APUGENSwtch")

local flap = globalProperty("sim/cockpit2/electrical/APU_door")

local N1 = globalProperty("sim/cockpit2/electrical/APU_N1_percent")
local EGT = globalProperty("sim/cockpit2/electrical/APU_EGT_c")
local apu_pwr = {
    bleed = globalPropertyi("A318/systems/bleed/APUPress"),
    valve = globalProperty("A318/systems/bleed/APUValve"),
    voltage = globalPropertyi("A318/systems/ELEC/apu_V"),
    hertz = globalPropertyi("A318/systems/ELEC/apu_H"),
    avail = globalPropertyi("A318/systems/ELEC/apu_Avail"),
    contact = globalPropertyi("A318/systems/ELEC/contacts/AGC")
}

function draw_apu_page()
    sasl.gl.drawWideLine(238, 494, 284, 494, 1, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261, 496, 'APU', 26, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)

    if get(apu_pwr.avail) == 1 then
        sasl.gl.drawText(AirbusFont, 261, 435, 'AVAIL', 26, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    end

    if get(genButton) == 1 and get(mstrButton) == 1 then
        if get(apu_pwr.voltage) == 0 then
            sasl.gl.drawText(AirbusFont, 118, 422, 'APU GEN', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
            sasl.gl.drawText(AirbusFont, 118, 367, get(apu_pwr.voltage), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
            sasl.gl.drawText(AirbusFont, 118, 344, get(apu_pwr.hertz), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
            sasl.gl.drawText(AirbusFont, 118, 367, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
            sasl.gl.drawText(AirbusFont, 118, 344, " HZ", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
        else
            sasl.gl.drawText(AirbusFont, 118, 422, 'APU GEN', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
            sasl.gl.drawText(AirbusFont, 118, 367, get(apu_pwr.voltage), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 118, 344, get(apu_pwr.hertz), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
            sasl.gl.drawText(AirbusFont, 118, 367, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
            sasl.gl.drawText(AirbusFont, 118, 344, " HZ", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
        end
        if get(apu_pwr.contact) == 1 then
            sasl.gl.drawWidePolyLine({118, 444, 118, 455, 108, 455, 118, 473, 128, 455, 118, 455}, 2, ECAM_COLOURS.GREEN)
        end
        sasl.gl.drawWidePolyLine({164, 390, 164, 444, 70, 444, 70, 335, 164, 335, 164, 390}, 2, ECAM_COLOURS.WHITE)
    elseif get(mstrButton) == 1 and get(genButton) == 0 then
        sasl.gl.drawText(AirbusFont, 118, 422, 'APU GEN', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 118, 367, "OFF", 22, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawWidePolyLine({164, 390, 164, 444, 70, 444, 70, 335, 164, 335, 164, 390}, 2, ECAM_COLOURS.WHITE)
    else
        sasl.gl.drawText(AirbusFont, 118, 422, 'APU GEN', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    end

    sasl.gl.drawWidePolyLine({404, 437, 404, 455, 394, 455, 404, 473, 414, 455, 404, 455}, 2, ECAM_COLOURS.GREEN)

    sasl.gl.saveInternalLineState()
    sasl.gl.setInternalLineWidth(2)
    sasl.gl.drawCircle(404, 422, 16, false, ECAM_COLOURS.GREEN)
    sasl.gl.restoreInternalLineState()

    if get(apu_pwr.valve) == 0 then
        sasl.gl.drawWideLine(389, 422, 419, 422, 2, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawWideLine(404, 407, 404, 437, 2, ECAM_COLOURS.GREEN)
    end
    sasl.gl.drawWideLine(404, 389, 404, 407, 2, ECAM_COLOURS.GREEN)

    sasl.gl.drawText(AirbusFont, 404, 367, 'BLEED', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    if get(apu_pwr.bleed) > 0 then
        sasl.gl.drawText(AirbusFont, 396, 344, math.floor(get(apu_pwr.bleed) + 0.5), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 396, 344, 'XX', 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end
    sasl.gl.drawText(AirbusFont, 396, 344, " PSI", 18, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawWidePolyLine({403, 335, 365, 335, 365, 389, 441, 389, 441, 335, 403, 335}, 2, ECAM_COLOURS.WHITE)

    sasl.gl.drawWidePolyLine({66, 299, 66, 325, 456, 325, 456, 299}, 2, ECAM_COLOURS.WHITE)

    if get(flap) == 1 then
        sasl.gl.drawText(AirbusFont, 384, 180, 'FLAP OPEN', 23, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    end
    
    sasl.gl.drawArc(139, 240, 45, 47, 50, 160, ECAM_COLOURS.WHITE)
    sasl.gl.drawArc(139, 240, 45, 48, 35, 15, ECAM_COLOURS.RED)
    sasl.gl.drawWideLine(169, 273, 178, 282, 4, ECAM_COLOURS.ORANGE)
    sasl.gl.drawText(AirbusFont, 106, 222, '0', 16, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 161, 257, '10', 16, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    if get(flap) > 0 then
        sasl.gl.saveGraphicsContext()
        sasl.gl.setTranslateTransform(139,240)
        sasl.gl.setRotateTransform(-120 + (1.6 * get(N1)))
        sasl.gl.drawWideLine(0, 0, 0, 45, 2.5, ECAM_COLOURS.GREEN)
        sasl.gl.restoreGraphicsContext()
    end

    sasl.gl.drawText(AirbusFont, 212, 267, "N", 22, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 211, 242, "%", 18, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    if get(flap) > 0 then
        sasl.gl.drawText(AirbusFont, 187, 223, math.floor(get(N1) + 0.5), 22, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 187, 223, "XX", 22, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end

    sasl.gl.drawArc(139, 127, 45, 47, 10, 202, ECAM_COLOURS.WHITE)
    if get(N1) > 95 then
        sasl.gl.drawArc(139, 127, 45, 48, 10, 100, ECAM_COLOURS.RED)
    elseif get(N1) < 95 and get(N1) > 1 then
        sasl.gl.drawArc(139, 127, 45, 48, 10, 35, ECAM_COLOURS.RED)
    end
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(139, 127)
    if get(flap) > 0 and get(N1) < 1 then
        sasl.gl.setRotateTransform(75)
        sasl.gl.drawWideLine(0, 45, 0, 57, 4, ECAM_COLOURS.ORANGE)
    elseif get(N1) < 95 and get(N1) > 1 then
        sasl.gl.setRotateTransform(45)
        sasl.gl.drawWideLine(0, 45, 0, 57, 4, ECAM_COLOURS.ORANGE)
    elseif get(N1) > 95 then
        sasl.gl.setRotateTransform(-20)
        sasl.gl.drawWideLine(0, 45, 0, 57, 4, ECAM_COLOURS.ORANGE)
    end
    sasl.gl.restoreGraphicsContext()
    sasl.gl.drawText(AirbusFont, 106, 109, '3', 16, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 126, 153, '7', 16, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 161, 144, '10', 16, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    if get(flap) > 0 then
        sasl.gl.saveGraphicsContext()
        sasl.gl.setTranslateTransform(139,127)
        if get(EGT) > 300 then
            sasl.gl.setRotateTransform(-122 + (0.25 * (get(EGT) - 300)))
        else
            sasl.gl.setRotateTransform(-122)
        end
        sasl.gl.drawWideLine(0, 0, 0, 45, 2.5, ECAM_COLOURS.GREEN)
        sasl.gl.restoreGraphicsContext()
    end

    sasl.gl.drawText(AirbusFont, 206, 154, "EGT", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 217, 129, "°C", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.BLUE)
    if get(flap) > 0 then
        sasl.gl.drawText(AirbusFont, 187, 111, math.floor(get(EGT) + 0.5), 22, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 187, 111, "XX", 22, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end
end