--Airbus A318 by X-Bureau--
-------------------------------------------------------------------------------
--COMPONENTS
-------------------------------------------------------------------------------
--ENGINE GENERATORS
local GEN_1 = createGlobalPropertyi("A318/electrical/generator_1", 0)--Supplies AC BUS 1
local GEN_2 = createGlobalPropertyi("A318/electrical/generator_2", 0)--Supplies AC BUS 2
--Auxillary Power Unit (APU)
local APU_ON = createGlobalProperyi("A318/electrical/gpu_on", 0)--IS THE GPU ON
local APU_GEN = createGlobalPropertyi("A318/electrical/apu_gen", 0)--APU Generator
--EXTERNAL POWER
local GPU_IS_AVAIL = createGlobalPropertyi("A318/electrical/gpu_is_avail", 0)--Is the GPU Available
local GPU_PWR = createGlobalPropertyi("A318/electrical/gpu_pwr", 0)--GPU Power
--CREATING THE AC BUSSES
local AC_BUS_1 = createGlobalPropertyi("A318/electrical/ac_bus_1", 0)--Dataref for AC BUS 1
local AC_BUS_2 = createGlobalPropertyi("A318/electrical/ac_bus_2", 0)--Dataref for AC BUS 2
local AC_ESS_BUS = createGlobalPropertyi("A318/electrical/ac_ess_bus", 0)--Dataref for the AC ESS BUS
local AC_EMER_BUS = createGlobalPropertyi("A318/electric/ac_emer_bus", 0)--Dataref for the EMERGENCY BUS
local AC_GND_SER_BUS = createGlobalPropertyi("A318/electrical/ac_gnd_ser_bus", 0)--Dataref for AC GROUND SERVICE BUS
--CREATING THE TRU
local TRU_1 = createGlobalPropertyi("A318/electrical/tru_1", 0)--Powered by AC BUS 1
local TRU_2 = createGlobalPropertyi("A318/electrical/tru_2", 0)--Powered by AC BUS 2
local TRU_ESS = createGlobalPropertyi("A318/electrical/tru_ess", 0)--Powered by ESS BUS
local TRU_EMER = createGlobalPropertyi("A318/electrical/tru_emer", 0)
local TRU_GND_SER = createGlobalPropertyi("A318/electrical/tru_gnd_ser", 0)--Powered by AC GND SER BUS
--CREATING THE DC BUSSES
local DC_BUS_1 = createGlobalPropertyi("A318/electrical/dc_bus_1", 0)--Dataref for AC BUS 1
local DC_BUS_2 = createGlobalPropertyi("A318/electrical/dc_bus_2", 0)--Dataref for AC BUS 2
local DC_ESS_BUS = createGlobalPropertyi("A318/electrical/dc_ess_bus", 0)--Dataref for the DC ESS BUS
local DC_EMER_BUS = createGlobalPropertyi("A318/electric/dc_emer_bus", 0)--Dataref for the EMERGENCY BUS
local DC_GND_SER_BUS = createGlobalPropertyi("A318/electrical/dc_gnd_ser_bus", 0)--Dataref for AC GROUND SERVICE BUS
local DUAL_DC_BUS = createGlobalPropertyi("A318/electrical/dual_DC_Bus", 0)--Dataref for the DUAL DC BUS
--CROSS TIES
local dcb1_dcb2_x_tie = createGlobalPropertyi("A318/electrical/dcb1_dcb2_x_tie", 0)--DC BUS 1 and DC BUS 2 Cross-Tie
--BATTERIES
local BAT_1 = createGlobalPropertyi("A318/electrical/battery_1", 0)--Dataref for Battery 1
local BAT_2 = createGlobalPropertyi("A318/electrical/battery_2", 0)--Dataref for Battery 2
--PUSH BUTTONS
local battery_switch = createGlobalPropertyia("A318/buttons/battery_switch", {switch_states.off, switch_states.off})--The Dataref for the battery switch
local GPU_PB = createGlobalPropertyi("A318/buttons/gpu_pb")--Dataref for the Push Button for the GPU
local ESS_EMER_PWR_ONLY = createGlobalPropertyi("A318/buttons/ess_emer_pwr_only", 0)--Dataref for the button for EMERGENCY PWR only 
local GEN_1_PB = createGlobalPropertyi("A318/buttons/gen_1_pb", 0)--Dataref for Generator 1 Push Button
local GEN_2_PB = createGlobalPropertyi("A318/buttons/gen_2_pb", 0)--Dataref for Generator 2 Push Button
local APU_GEN_PB = createGlobalPropertyi("A318/buttons/apu_gen_pb", 0)--Dataref for the APU Gen Push Button
local DC_X_TIE_PB = createGlobalPropertyi("A318/buttons/dc_x_tie_pb", 1)--Dataref for DC X TIE Push button
local AC_X_PB_1 = createGlobalPropertyi("A318/buttons/ac_x_tie_pb1", 1)--dataref for AC X TIE Push Button 1 
local AC_X_PB_2 = createGlobalPropertyi("A318/buttons/ac_x_tie_pb2", 1)--dataref for AC X TIE Push Button 2
local TRU_1_PB = createGlobalPropertyi("A318/buttons/tru_1_pb", 1)
local TRU_2_PB = createGlobalPropertyi("A318/buttons/tru_2_pb", 1)
local IS_ON_GROUND = globalProperty("sim/flightmodel/failures/onground_any")
-------------------------------------------------------------------------------
--BUILDING FUNCTIONS
-------------------------------------------------------------------------------
function update()
    if get(DC_ESS_BUS) == 0 then
        --PRESENT ALERT WHEN ESS DC BUS
    end
    --GENERATORS
    if get(GEN_1) == 1 and get(GEN_2) == 1 then --If GEN 1 and GEN 2 are ON
        set(AC_BUS_1, 1)
        set(AC_ESS_BUS, 1)
        set(AC_BUS_2, 1)
    elseif get(APU_GEN) == 1 and get(AC_GND_SER_BUS) == 1 then
        --LET APU POWER THE ESSENTIAL AC BUS
        set(AC_ESS_BUS, 1)
        --Let GPU power AC BUS 1 and AC BUS 2
        set(AC_BUS_1, 1)
        set(AC_BUS_2, 1)

    elseif get(APU_GEN) == 1 then -- Acts as STANDBY if GEN 1 and GEN 2 are ON
        if get(IS_ON_GROUND) == 1 then
            if get(GEN_1) == 0 and get(GEN_2) == 0 then -- ON GROUND, WHEN BOTH ENGINES ARE OFF, AND APU IS ON, POWER ALL OF THE AC SYSTEM
                set(AC_BUS_1, 1)
                set(AC_BUS_2, 1)
            end
        else
            if get(GEN_1) == 1 and get(GEN_2) == 0 then --If BOTH ENGINES are FAILED
                set(AC_BUS_1, 1)
                set(AC_BUS_2, 1)
            elseif get(GEN_1) == 1 and get(GEN_2) == 0 then --If GEN 1 fails
                set(AC_BUS_1, 1)
            elseif get(GEN_1) == 0 and get(GEN_2) == 1 then --If GEN 2 fails
                set(AC_BUS_2, 1)
            end
        end
    elseif get(AC_GND_SER_BUS) == 1 then
        set(AC_BUS_1, 1)
        set(AC_ESS_BUS, 1)
        set(AC_BUS_2, 1)
    end
    --If the battery switch is ON
    if get(battery_switch, 0) == switch_states.on then
        set(BAT_1, 1)
    end
    if get(battery_switch, 1) == switch_states.on then
        set(BAT_2, 1)
    end
    --If BATTERIES are ON, power the EMERGENCY BUS
    if get(BAT_1) == 1 or get(BAT_2) == 1 then
        set(DC_EMER_BUS, 1)
    end
    --Once the EMERGENCY BUS is POWERED, power the DC ESSENTIAL BUS, the DC BUS 1, and IF THE CROSS TIE IS ON (Which it is AUTOMATICALLY), turn the DC BUS 2 ON
    --Simulating the DC ESSENTIAL BUS and DC X-TIE
    if get(DC_EMER_BUS) == 1 then
        set(DC_ESS_BUS, 1)
        set(DC_BUS_1, 1)
        if get(DC_X_TIE_PB) == 1 then
            set(DC_BUS_2, 1)
        else
            set(DC_BUS_2, 0)
        end
    end
    if get(DC_BUS_1) == 1 or get(DC_BUS_2) == 1 then set(DUAL_DC_BUS, 1) end --DUAL DC BUS is UN-INTERRUPTED | Provides electrical power for lift dumpers, anti-skid, speed brakes, IF DC BUS 1 or DC BUS 2 Fails during landing
    --SIMULATE THE GCU
    if get(GEN_1_PB) == 1 then set(GEN_1, 1) else set(GEN_1, 0) end
    if get(GEN_2_PB) == 1 then set(GEN_2, 1) else set(GEN_2, 0) end
    if get(APU_GEN_PB) == 1 and get(APU_ON) == 1 then set(APU_GEN, 1) else set(APU_GEN, 0) end
    --SIMULATE THE GPCU
    if get(GPU_IS_AVAIL) == 1 then
        if get(GPU_PB) == 1 then
            set(AC_GND_SER_BUS, 1)--If the GPU is on, and the push button is on, then supply power to the AC Ground Service Bus
            ------ TODO: MEMO MESSAGE, EXT POWER CONNECTED (PRESENTED AT THE MFDU PRIMARY PAGE)
        else
            ------ TODO: MEMO MESSAGE, EXT POWER CONNECTED (PRESENTED AT THE MFDU PRIMARY PAGE)
        end
    end
        
    --Automatically power the AC EMERGENCY BUS
    if get(AC_ESS_BUS) == 1 then
        set(AC_EMER_BUS, 1)--IF THE AC ESS BUS IS ON, POWER THE EMER BUS
    elseif get(BAT_1) == 1 and get(BAT_2) == 1 then
        set(AC_EMER_BUS, 1)-- HAVE THE BATTERIES CONTINUE TO POWER THE AC EMER BUS
        --------------------- TODO: In this case, an AC SUPPLY alert will be presented at the Standby Annunciator Panel (SAP); See section Flight Warnign System. TOTAL LOSS OF EMERGENCY POWER MAY OCCUR AFTER 30 MINUTES, BUT IS ACTUALLY DEPENDANT ON THE BATTERY CONFIGURATION AND SYSTEM LOADS
    else set(AC_EMER_BUS, 0) end
    --IF the AC BUSSES are POWERED, turn the TRU on, else turn them off
    if get(AC_BUS_1) == 1 and get(TRU_1_PB) == 1 then set(TRU_1, 1) else set(TRU_1, 0) end
    if get(AC_BUS_2) == 1 and get(TRU_2_PB) == 1 then set(TRU_2, 1) else set(TRU_2, 0) end
    if get(AC_ESS_BUS) == 1 then set(TRU_ESS, 1) else set(TRU_ESS, 0) end
    if get(AC_EMER_BUS) == 1 then set(TRU_EMER, 1) else set(TRU_EMER, 0) end
    if get(AC_GND_SER_BUS) == 1 then set(TRU_GND_SER, 1) else set (TRU_GND_SER, 0) end
    --AND IF the TRU's are POWERED, the coresponding DC BUSSES will then be powered
    if get(TRU_1) == 1 then set(DC_BUS_1, 1) else set(DC_BUS_1, 0) end
    if get(TRU_2) == 1 then set(DC_BUS_2, 1) else set(DC_BUS_2, 0) end
    if get(TRU_ESS) == 1 then set(DC_ESS_BUS, 1) else set(DC_ESS_BUS, 0) end
    if get(TRU_EMER) == 1 then set(DC_EMER_BUS, 1) else set(DC_GND_SER_BUS, 0) end
    if get(TRU_GND_SER) == 1 then set(DC_GND_SER_BUS, 1) else set(DC_GND_SER_BUS, 0) end
end