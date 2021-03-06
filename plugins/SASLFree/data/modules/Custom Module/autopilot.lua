--Airbus A318 By X-Bureau--
-----------------------------------------------------------------------------------------------------
-- Written by 

-- Evn


-- TODO : figure out some way to throttle up depeding on what speed they asked
-----------------------------------------------------------------------------------------------------
position = {296, 1630, 143, 180}
size = {250, 250}

local AP_SPD = createGlobalPropertyi("A318/cockpit/ap/speed", 0)
local AP_SPD_ENGAGE = createGlobalPropertyi("A318/cockpit/ap/ENGAGE_SPEED", 0)
local AIRSPEED = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
local ENGINE_PERCENT = globalPropertyfa("sim/flightmodel/engine/ENGN_N1_", 7)
local gspeed = globalPropertyf("sim/flightmodel/position/groundspeed")
local throttle_up = sasl.findCommand("sim/engines/throttle_up")
local throttle_down = sasl.findCommand("sim/engines/throttle_down")

local AP_SPD_SIZE = 34
local MCDU_ORANGE = {1.0, 0.625, 0.0, 1.0}

local SPD_TBL = { -- GOES BY THIS ORDER AND THIS ORDER ONLY!!!
    "-", -- 3 
    "-", -- 2 
    "-" -- 1  
}


function draw_panel()
    sasl.gl.drawText(AirbusFont, -370, 500, "SPD", 25, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, -360, 470, SPD_TBL[3], AP_SPD_SIZE, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, -375, 470, SPD_TBL[2], AP_SPD_SIZE, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, -390, 470, SPD_TBL[1], AP_SPD_SIZE, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, -110, 500, "HDG", 25, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, -70, 470, "---", 50, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, -30, 500, "LAT", 25, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    sasl.gl.drawText(AirbusFont, 110, 480, "HDG", 25, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
end

function update()

    -- for i in ipairs(SPD_TBL) do
    --     SPD_TBL[i] = get(AP_SPD)
    -- end

    -- AUTO THROTTLE 
        if get(AP_SPD_ENGAGE) == 1 and get(AIRSPEED) ~= get(AP_SPD) and get(AP_SPD) > get(gspeed) * 2 then 
            print(get(AIRSPEED))
            if get(AP_SPD) >= 100 and get(AP_SPD) <= 110 then 
                sasl.commandOnce(throttle_up)
            elseif get(AP_SPD) >= 110 then
                sasl.commandOnce(throttle_up)
            else
                sasl.commandOnce(throttle_up)
            end
        elseif get(AP_SPD) == get(gspeed) then 
            sasl.commandOnce(throttle_down)
    end



    -- HEADING
end

function draw()
draw_panel() 
end
