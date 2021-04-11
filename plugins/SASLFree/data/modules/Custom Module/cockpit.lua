local AC1 = globalProperty("A318/systems/ELEC/AC1_V")
local AC2 = globalProperty("A318/systems/ELEC/AC2_V")

local gpuAvail = globalProperty("A318/systems/ELEC/gpu_Avail")

local faultLights = {
    elec = {
        bat1 = createGlobalPropertyi("A318/cockpit/lights/fault/bat1", 0),
        bat2 = createGlobalPropertyi("A318/cockpit/lights/fault/bat2", 0),
        acess = createGlobalPropertyi("A318/cockpit/lights/fault/acess", 0),
        gen1 = createGlobalPropertyi("A318/cockpit/lights/fault/gen1", 0),
        gen2 = createGlobalPropertyi("A318/cockpit/lights/fault/gen2", 0),
        apu = createGlobalPropertyi("A318/cockpit/lights/fault/apu", 0)
    },
    aircond = {
        pack1 = createGlobalPropertyi("A318/cockpit/lights/fault/pack1", 0),
        pack2 = createGlobalPropertyi("A318/cockpit/lights/fault/pack2", 0),
        eng1 = createGlobalPropertyi("A318/cockpit/lights/fault/eng1", 0),
        eng2 = createGlobalPropertyi("A318/cockpit/lights/fault/eng2", 0),
        apu = createGlobalPropertyi("A318/cockpit/lights/fault/apubleed", 0),
    }
}

local lights = {
    elec = {
        bat1 = createGlobalPropertyi("A318/cockpit/lights/bat1", 0),
        bat2 = createGlobalPropertyi("A318/cockpit/lights/bat2", 0),
        acess = createGlobalPropertyi("A318/cockpit/lights/acess", 0),
        bustie = createGlobalPropertyi("A318/cockpit/lights/bustie", 0),
        gen1 = createGlobalPropertyi("A318/cockpit/lights/gen1", 0),
        gen2 = createGlobalPropertyi("A318/cockpit/lights/gen2", 0),
        apu = createGlobalPropertyi("A318/cockpit/lights/apu", 0),
        gpuAv = createGlobalPropertyi("A318/cockpit/lights/gpuAv", 0),
        gpu = createGlobalPropertyi("A318/cockpit/lights/gpu", 0),
    },
    aircond = {
        pack1 = createGlobalPropertyi("A318/cockpit/lights/pack1", 0),
        pack2 = createGlobalPropertyi("A318/cockpit/lights/pack2", 0),
        eng1 = createGlobalPropertyi("A318/cockpit/lights/eng1", 0),
        eng2 = createGlobalPropertyi("A318/cockpit/lights/eng2", 0),
        apu = createGlobalPropertyi("A318/cockpit/lights/apubleed", 0),
    }
}

local switches = {
    elec = {
        bat1 = globalProperty("A318/systems/ELEC/bat1/pb"),
        bat2 = globalProperty("A318/systems/ELEC/bat2/pb"),
        acess = globalProperty("A318/systems/ELEC/ESSFeedSwtch"),
        bustie = globalProperty("A318/systems/ELEC/busTieSwtch"),
        gen1 = globalProperty("A318/systems/ELEC/GEN1Swtch"),
        gen2 = globalProperty("A318/systems/ELEC/GEN2Swtch"),
        apu = globalProperty("A318/systems/ELEC/APUGENSwtch"),
        gpu = globalProperty("A318/systems/ELEC/EXTPWRSwtch")
    },
    aircond = {
        pack1 = createGlobalPropertyi("A318/systems/bleed/PACK1", 0),
        pack2 = createGlobalPropertyi("A318/systems/bleed/PACK2", 0),
        eng1 = createGlobalPropertyi("A318/systems/bleed/ENG1BLEED", 0),
        eng2 = createGlobalPropertyi("A318/systems/bleed/ENG2BLEED", 0),
        apu = createGlobalPropertyi("A318/systems/bleed/APUBLEED", 0),
    }
}

function elecLights()
    -- BATTERY SWITCHES
    if get(switches.elec.bat1) == 1 then
        set(lights.elec.bat1, 0)
    else
        set(lights.elec.bat1, 1)
    end
    if get(switches.elec.bat2) == 1 then
        set(lights.elec.bat2, 0)
    else
        set(lights.elec.bat2, 1)
    end

    -- AC ESS SWITCH
    if get(switches.elec.acess) == 1 then
        set(lights.elec.acess, 1)
    else
        set(lights.elec.acess, 0)
    end

    -- BUS TIE SWITCH
    if get(switches.elec.bustie) == 1 then
        set(lights.elec.bustie, 1)
    else
        set(lights.elec.bustie, 0)
    end

    -- GEN 1 SWITCH
    if get(switches.elec.gen1) == 1 then
        set(lights.elec.gen1, 0)
    else
        set(lights.elec.gen1, 1)
    end

    -- GEN 2 SWITCH
    if get(switches.elec.gen2) == 1 then
        set(lights.elec.gen2, 0)
    else
        set(lights.elec.gen2, 1)
    end

    -- APU SWITCH
    if get(switches.elec.apu) == 1 then
        set(lights.elec.apu, 0)
    else
        set(lights.elec.apu, 1)
    end

    -- GPU SWITCH
    if get(switches.elec.gpu) == 1 then
        set(lights.elec.gpu, 1)
    else
        set(lights.elec.gpu, 0)
    end
end

function aircondLights()
    -- PACK 1 SWITCH
    if get(switches.aircond.pack1) == 1 then
        set(lights.aircond.pack1, 0)
    else
        set(lights.aircond.pack1, 1)
    end

    -- PACK 2 SWITCH
    if get(switches.aircond.pack2) == 1 then
        set(lights.aircond.pack2, 0)
    else
        set(lights.aircond.pack2, 1)
    end

    -- ENG 1 SWITCH
    if get(switches.aircond.eng1) == 1 then
        set(lights.aircond.eng1, 0)
    else
        set(lights.aircond.eng1, 1)
    end

    -- ENG 2 SWITCH
    if get(switches.aircond.eng2) == 1 then
        set(lights.aircond.eng2, 0)
    else
        set(lights.aircond.eng2, 1)
    end

    -- APU SWITCH
    if get(switches.aircond.apu) == 1 then
        set(lights.aircond.apu, 1)
    else
        set(lights.aircond.apu, 0)
    end
end

function update()
    -- GPU AVAIL LIGHT
    if get(gpuAvail) == 1 then
        set(lights.elec.gpuAv, 1)
    else
        set(lights.elec.gpuAv, 0)
    end

    if get(AC1) > 0 or get(AC2) > 0 then
        elecLights()
        aircondLights()
    else
        set(lights.elec.bat1, 0)
        set(lights.elec.bat2, 0)
        set(lights.elec.acess, 0)
        set(lights.elec.bustie, 0)
        set(lights.elec.gen1, 0)
        set(lights.elec.gen2, 0)
        set(lights.elec.apu, 0)
        set(lights.elec.gpu, 0)
        set(lights.aircond.pack1, 0)
        set(lights.aircond.pack2, 0)
        set(lights.aircond.eng1, 0)
        set(lights.aircond.eng2, 0)
        set(lights.aircond.apu, 0)
    end
end