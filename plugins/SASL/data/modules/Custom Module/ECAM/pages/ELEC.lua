require "common_declarations"
local grey = {0.4, 0.4, 0.4, 1.0}

-- ELEC VARIABLES
local BC1 = globalPropertyi("A318/systems/ELEC/contacts/BC1")
local BC2 = globalPropertyi("A318/systems/ELEC/contacts/BC2")
local DCT1 = globalPropertyi("A318/systems/ELEC/contacts/DCBTC1")
local DCT2 = globalPropertyi("A318/systems/ELEC/contacts/DCBTC2")
local DCE  = globalPropertyi("A318/systems/ELEC/contacts/DCEBTC")

local TR1 = globalPropertyi("A318/systems/ELEC/contacts/TR1")
local TR2 = globalPropertyi("A318/systems/ELEC/contacts/TR2")

local GLC1 = globalPropertyi("A318/systems/ELEC/contacts/GLC1")
local GLC2 = globalPropertyi("A318/systems/ELEC/contacts/GLC2")

local AGC = globalPropertyi("A318/systems/ELEC/contacts/AGC")
local EPC = globalPropertyi("A318/systems/ELEC/contacts/EPC")

local BTC1 = globalPropertyi("A318/systems/ELEC/contacts/BTC1")
local BTC2 = globalPropertyi("A318/systems/ELEC/contacts/BTC2")

local ACEssF1 = globalPropertyi("A318/systems/ELEC/contacts/ACEssF1")
local ACEssF2 = globalPropertyi("A318/systems/ELEC/contacts/ACEssF2")

dc = {
    bat_1 = {
        voltage = globalPropertyf("A318/systems/ELEC/BAT1_V"),
        amps = globalPropertyi("A318/systems/ELEC/BAT1_A")
    },
    bat_2 = {
        voltage = globalPropertyf("A318/systems/ELEC/BAT2_V"),
        amps = globalPropertyi("A318/systems/ELEC/BAT2_A")
    },
    bat_bus = {
        voltage = globalPropertyf("A318/systems/ELEC/DCBAT_V"),
        amps = globalPropertyi("A318/systems/ELEC/DCBAT_A")
    },
    ess_bus = {
        voltage = globalPropertyf("A318/systems/ELEC/DCESS_V"),
        amps = globalPropertyi("A318/systems/ELEC/DCESS_A")
    },
    bus_1 = {
        voltage = globalPropertyf("A318/systems/ELEC/DC1_V"),
        amps = globalPropertyi("A318/systems/ELEC/DC1_A")
    },
    bus_2 = {
        voltage = globalPropertyf("A318/systems/ELEC/DC2_V"),
        amps = globalPropertyi("A318/systems/ELEC/DC2_A")
    }
}
ac = {
    ext_pwr = {
        voltage = globalPropertyi("A318/systems/ELEC/gpu_V"),
        hertz = globalPropertyi("A318/systems/ELEC/gpu_H"),
        avail = globalPropertyi("A318/systems/ELEC/gpu_Avail")
    },
    apu_pwr = {
        voltage = globalPropertyi("A318/systems/ELEC/apu_V"),
        hertz = globalPropertyi("A318/systems/ELEC/apu_H"),
        avail = globalPropertyi("A318/systems/ELEC/apu_Avail")
    },
    gen_1 = {
        voltage = globalPropertyi("A318/systems/ELEC/gen1_V"),
        hertz = globalPropertyi("A318/systems/ELEC/gen1_H")
    },
    gen_2 = {
        voltage = globalPropertyi("A318/systems/ELEC/gen2_V"),
        hertz = globalPropertyi("A318/systems/ELEC/gen2_H")
    },
    ess_bus = {
        voltage = globalPropertyi("A318/systems/ELEC/ACESS_V"),
        hertz = globalPropertyi("A318/systems/ELEC/ACESS_H")
    },
    bus_1 = {
        voltage = globalPropertyi("A318/systems/ELEC/AC1_V"),
        hertz = globalPropertyi("A318/systems/ELEC/AC1_H")
    },
    bus_2 = {
        voltage = globalPropertyi("A318/systems/ELEC/AC2_V"),
        hertz = globalPropertyi("A318/systems/ELEC/AC2_H")
    }
}

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

function draw_elec_page()
    sasl.gl.drawWideLine(15, 491, 67, 491, 1, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 15, 496, 'ELEC', 25, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.WHITE)

    -- LINE logic
    if get(BC1) == 1 then
        sasl.gl.drawWideLine(185, 480, 210, 480, 2, ECAM_COLOURS.GREEN)
    end
    if get(BC2) == 1 then
        sasl.gl.drawWideLine(312, 480, 337, 480, 2, ECAM_COLOURS.GREEN)
    end
    if get(DCT1) == 1 then
        sasl.gl.drawWidePolyLine({72, 417, 234, 417, 234, 467}, 2, ECAM_COLOURS.GREEN)
    end
    if get(TR1) == 1 then
        sasl.gl.drawWidePolyLine({61, 325, 61, 404}, 2, ECAM_COLOURS.GREEN)
    end
    if get(TR2) == 1 then
        sasl.gl.drawWidePolyLine({461, 325, 461, 404}, 2, ECAM_COLOURS.GREEN)
    end
    if get(DCT2) == 1 then
        sasl.gl.drawWidePolyLine({480, 417, 288, 417, 288, 467}, 2, ECAM_COLOURS.GREEN)
    end
    if get(ACEssF1) == 1 then
        if get(ac.bus_1.voltage) > 0 then
            sasl.gl.drawWideLine(109, 253, 261, 253, 2, ECAM_COLOURS.GREEN)
        end
    end
    if get(ACEssF2) == 1 then
        if get(ac.bus_2.voltage) > 0 then
            sasl.gl.drawWideLine(312, 253, 414, 253, 2, ECAM_COLOURS.GREEN)
        end
    end
    if get(GLC1) == 1 and get(ac.gen_1.voltage) > 0 then
        sasl.gl.drawWidePolyLine({61, 197, 61, 240}, 2, ECAM_COLOURS.GREEN)
    end
    if get(GLC2) == 1 and get(ac.gen_2.voltage) > 0 then
        sasl.gl.drawWidePolyLine({461, 197, 461, 240}, 2, ECAM_COLOURS.GREEN)
    end
    if get(EPC) == 1 then
        sasl.gl.drawWideLine(320, 197, 320, 218, 2, ECAM_COLOURS.GREEN)
    end
    if get(AGC) == 1 then
        sasl.gl.drawWideLine(192, 197, 192, 218, 2, ECAM_COLOURS.GREEN)
    end
    if get(BTC1) == 1 and get(BTC2) == 1 then
        sasl.gl.drawWidePolyLine({61, 240, 61, 218, 461, 218, 461, 240}, 2, ECAM_COLOURS.GREEN)
    end
    if get(BTC1) == 0 and get(BTC2) == 1 then
        sasl.gl.drawWidePolyLine({320, 218, 461, 218, 461, 240}, 2, ECAM_COLOURS.GREEN)
        if get(AGC) == 1 then
            sasl.gl.drawWideLine(192, 218, 320, 218, 2, ECAM_COLOURS.GREEN)
        end
    end
    if get(BTC1) == 1 and get(BTC2) == 0 then
        sasl.gl.drawWidePolyLine({61, 240, 61, 218, 192, 218}, 2, ECAM_COLOURS.GREEN)
        if get(EPC) == 1 then
            sasl.gl.drawWideLine(192, 218, 320, 218, 2, ECAM_COLOURS.GREEN)
        end
    end
    if get(DCE) == 1 then
        if get(DCT1) == 1 then
            sasl.gl.drawWideLine(234, 398, 234, 417, 2, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawWideLine(288, 398, 288, 417, 2, ECAM_COLOURS.GREEN)
        end
    end

    -- BAT 1
    sasl.gl.drawWidePolyLine({103, 477, 103, 518, 185, 518, 185, 436, 103, 436, 103, 477}, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 144, 494, 'BAT 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 147, 470, math.floor(get(dc.bat_1.voltage) + 0.5), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 147, 470, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 147, 448, get(dc.bat_1.amps), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 147, 448, " A", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)

    -- BAT 2
    sasl.gl.drawWidePolyLine({419, 477, 419, 518, 337, 518, 337, 436, 419, 436, 419, 477}, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 377, 494, 'BAT 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 387, 470, round(get(dc.bat_2.voltage), 1), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 383, 470, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 387, 448, get(dc.bat_2.amps), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawText(AirbusFont, 383, 448, " A", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)

    -- TR 1
    sasl.gl.drawRectangle(21, 279, 82, 82, {0.0, 0.0, 0.0, 1.0})
    sasl.gl.drawText(AirbusFont, 60, 311, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 60, 288, " A", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    if get(ac.bus_1.voltage) > 0 then
        sasl.gl.drawWidePolyLine({61, 246, 61, 279}, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 60, 337, 'TR 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 60, 311, "28", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 60, 288, "150", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawWidePolyLine({61, 246, 61, 279}, 2, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 60, 337, 'TR 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 60, 311, "0", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 60, 288, "0", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end
    sasl.gl.drawWidePolyLine({21, 320, 21, 361, 103, 361, 103, 279, 21, 279, 21, 320}, 2, ECAM_COLOURS.WHITE)

    -- TR 2
    sasl.gl.drawRectangle(419, 279, 482, 82, {0.0, 0.0, 0.0, 1.0})
    sasl.gl.drawText(AirbusFont, 460, 311, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 460, 288, " A", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    if get(ac.bus_2.voltage) > 0 then
        sasl.gl.drawWidePolyLine({461, 246, 461, 279}, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 460, 337, 'TR 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 460, 311, "28", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 460, 288, "150", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawWidePolyLine({461, 246, 461, 279}, 2, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 460, 337, 'TR 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 460, 311, "0", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 460, 288, "0", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end
    sasl.gl.drawWidePolyLine({501, 320, 501, 361, 419, 361, 419, 279, 501, 279, 501, 320}, 2, ECAM_COLOURS.WHITE)

    -- GEN 1
    sasl.gl.drawText(AirbusFont, 66, 134, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 63, 111, " HZ", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    if get(ac.gen_1.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 62, 175, 'GEN 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 69, 134, get(ac.gen_1.voltage), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 69, 111, get(ac.gen_1.hertz), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 62, 175, 'GEN 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 69, 134, "0", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 69, 111, "XX", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end
    sasl.gl.drawWidePolyLine({20, 153, 20, 197, 102, 197, 102, 108, 20, 108, 20, 153}, 2, ECAM_COLOURS.WHITE)

    -- GEN 2
    sasl.gl.drawText(AirbusFont, 466, 134, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    sasl.gl.drawText(AirbusFont, 463, 111, " HZ", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    if get(ac.gen_2.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 460, 175, 'GEN 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 467, 134, get(ac.gen_2.voltage), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 467, 111, get(ac.gen_2.hertz), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 460, 175, 'GEN 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 467, 134, "0", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 467, 111, "XX", 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
    end
    sasl.gl.drawWidePolyLine({501, 153, 501, 197, 418, 197, 418, 108, 501, 108, 501, 153}, 2, ECAM_COLOURS.WHITE)

    -- EXT PWR

    if get(ac.ext_pwr.avail) == 1 then
        sasl.gl.drawText(AirbusFont, 325, 175, 'EXT PWR', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 334, 155, get(ac.ext_pwr.voltage), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 334, 132, get(ac.ext_pwr.hertz), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 328, 155, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
        sasl.gl.drawText(AirbusFont, 328, 132, " HZ", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
        sasl.gl.drawWidePolyLine({371, 153, 371, 197, 277, 197, 277, 124, 371, 124, 371, 153}, 2, ECAM_COLOURS.WHITE)
    else
        sasl.gl.drawText(AirbusFont, 325, 175, 'EXT PWR', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    end
    
    -- APU GEN

    if get(ac.apu_pwr.avail) == 1 then
        sasl.gl.drawText(AirbusFont, 192, 175, 'APU GEN', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 197, 155, get(ac.apu_pwr.voltage), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 197, 132, get(ac.apu_pwr.hertz), 22, false, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 197, 155, " V", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
        sasl.gl.drawText(AirbusFont, 197, 132, " HZ", 22, false, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
        sasl.gl.drawWidePolyLine({238, 153, 238, 197, 144, 197, 144, 124, 238, 124, 238, 153}, 2, ECAM_COLOURS.WHITE)
    else
        sasl.gl.drawText(AirbusFont, 192, 175, 'APU GEN', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    end

    -- DC BAT BUS
    sasl.gl.drawRectangle(210, 467, 102, 26, grey)
    if get(dc.bat_bus.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 261, 473, 'DC BAT', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 261, 473, 'DC BAT', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    -- DC ESS BUS
    sasl.gl.drawRectangle(210, 372, 102, 26, grey)
    if get(dc.ess_bus.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 261, 378, 'DC ESS', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 261, 378, 'DC ESS', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    -- DC BUS 1
    sasl.gl.drawRectangle(7, 404, 65, 26, grey)
    if get(dc.bus_1.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 39, 410, 'DC 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 39, 410, 'DC 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    -- DC BUS 2
    sasl.gl.drawRectangle(449, 404, 65, 26, grey)
    if get(dc.bus_2.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 481, 410, 'DC 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 481, 410, 'DC 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    -- AC ESS BUS
    sasl.gl.drawRectangle(210, 240, 102, 26, grey)
    if get(ac.ess_bus.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 261, 246, 'AC ESS', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 261, 246, 'AC ESS', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    -- AC BUS 1
    sasl.gl.drawRectangle(7, 240, 102, 26, grey)
    if get(ac.bus_1.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 57, 246, 'AC 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 57, 246, 'AC 1', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    -- AC BUS 2
    sasl.gl.drawRectangle(414, 240, 102, 26, grey)
    if get(ac.bus_2.voltage) > 0 then
        sasl.gl.drawText(AirbusFont, 466, 246, 'AC 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 466, 246, 'AC 2', 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end
    
end