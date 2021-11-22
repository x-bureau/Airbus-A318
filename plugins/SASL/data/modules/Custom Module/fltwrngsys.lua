require "common_declarations"

local elecPwr = globalProperty("A318/systems/ELEC/AC2_V")
local modeSel = createGlobalPropertyi("A318/systems/FADEC/MODESEL", 1)
local eng1MSTR = globalPropertyi("A318/systems/FADEC/ENG1MASTR")
local eng2MSTR = globalPropertyi("A318/systems/FADEC/ENG2MASTR")

local ias = globalProperty("A318/systems/ADIRS/1/air/ias")
local wow = globalProperty("sim/flightmodel/failures/onground_any")
local agl = globalProperty("sim/flightmodel/position/y_agl")

local shutDownTimer = 0
local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")

local first = 0
local second = 1
local engfrstN1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[".. first .. "]")
local engscndN1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[".. second .. "]")

function update()

    if get(modeSel) ~= 1 then
        if get(eng1MSTR) == 1 and get(eng2MSTR) == 0 then
            first = 0
            second = 1
        elseif get(eng1MSTR) == 0 and get(eng2MSTR) == 1 then
            first = 1
            second = 0
        end
    end

    if get(elecPwr) > 0 and get(engfrstN1) < 19.5 and get(wow) == 1 and fltPhase == 0 then
        fltPhase = 1
    elseif get(engfrstN1) > 19.5 and get(wow) == 1 and fltPhase == 1 then
        fltPhase = 2
    elseif get(engscndN1) > 75 and get(ias) < 80 and get(wow) == 1 and fltPhase == 2 then
        fltPhase = 3
    elseif get(ias) > 80 and get(wow) == 1 and fltPhase == 3 then
        fltPhase = 4
    elseif get(wow) == 0 and (get(agl) * 3.285) < 1500 and fltPhase == 4 then
        fltPhase = 5
    elseif (get(agl) * 3.285) > 1500 and fltPhase == 5 then
        fltPhase = 6
    elseif (get(agl) * 3.285) < 800 and fltPhase == 6 then
        fltPhase = 7
    elseif get(wow) == 1 and get(ias) > 80 and fltPhase == 7 then
        fltPhase = 8
    elseif get(ias) < 80 and get(engscndN1) > 19.5 and get(wow) == 1 and fltPhase == 8 then
        fltPhase = 9
    elseif get(engscndN1) < 5 and get(wow) == 1 and fltPhase == 9 then
        fltPhase = 10
    end
    
    if fltPhase == 10 then
        if shutDownTimer < 300 then
            shutDownTimer = shutDownTimer + 1 * get(DELTA_TIME)
        else
            fltPhase = 0
            shutDownTimer = 0
        end
    end
end