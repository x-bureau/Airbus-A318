-- GLOBAL VARIABLES
ZFW = ""
ZFWCG = ""
TAXI_FUEL = ""
BLOCK = ""
ALTN = ""
ALTN_TIME = ""
FINAL = ""
FINAL_TIME = ""
TOW = ""
LW = ""
TRIP_WIND = ""
MIN_DEST_FOB = ""
EXTRA = ""
EXTRA_TIME = ""


-- Label Headers
local optionLabels = {
    [1] = "TAXI",
    [2] = "TRIP/TIME",
    [3] = "RTE RSV/%",
    [4] = "ALTN/TIME",
    [5] = "FINAL/TIME",
    [6] = "MIN DEST FOB",
    [7] = "ZFW/ZFWCG",
    [8] = "BLOCK",
    [9] = "",
    [10] = "TOW/LW",
    [11] = "TRIP WIND",
    [12] = "EXTRA/TIME"
}

local function input()
    if get(MCDU_CURRENT_BUTTON) == 24 or get(MCDU_CURRENT_BUTTON) == 26 then
        set(MCDU_CURRENT_PAGE, 1)
    end
end

local function processZFW()
    if get(MCDU_CURRENT_BUTTON) == 6 and string.len(scratchpad) == 9 and string.sub(scratchpad,5,5) == "/" then
        ZFW = string.sub(scratchpad,1,4)
        ZFWCG = string.sub(scratchpad,5)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 6 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processTaxi()
    if get(MCDU_CURRENT_BUTTON) == 0 and string.len(scratchpad) == 3 and string.sub(scratchpad,2,2) == "." then
        TAXI_FUEL = scratchpad
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 0 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processBlock()
    if get(MCDU_CURRENT_BUTTON) == 7 and string.len(scratchpad) == 4 and string.sub(scratchpad, 3,3) == "." then
        BLOCK = scratchpad
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 7 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processAltnTime()
    if get(MCDU_CURRENT_BUTTON) == 3 and string.match(scratchpad, "/") and string.match(scratchpad, ".") then
        if string.len(scratchpad) == 8 then
            ALTN = "0"..string.sub(scratchpad,1,3)
            ALTN_TIME = string.sub(scratchpad, 5)
            scratchpad = ""
        elseif string.len(scratchpad) == 9 then
            ALTN = string.sub(scratchpad,1,4)
            ALTN_TIME = string.sub(scratchpad,6,9)
            scratchpad = ""
        else
            scratchpad = "INVALID ENTRY"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 3 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processFinalTime()
    if get(MCDU_CURRENT_BUTTON) == 4 and string.match(scratchpad, "/") and string.match(scratchpad, ".") then
        if string.len(scratchpad) == 8 then
            FINAL = "0"..string.sub(scratchpad,1,3)
            FINAL_TIME = string.sub(scratchpad, 5)
            scratchpad = ""
        elseif string.len(scratchpad) == 9 then
            FINAL = string.sub(scratchpad,1,4)
            FINAL_TIME = string.sub(scratchpad,6,9)
            scratchpad = ""
        else
            scratchpad = "INVALID ENTRY"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 4 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processExtraTime()
    if get(MCDU_CURRENT_BUTTON) == 11 and string.match(scratchpad, "/") and string.match(scratchpad, ".") then
        if string.len(scratchpad) == 8 then
            EXTRA = "0"..string.sub(scratchpad,1,3)
            EXTRA_TIME = string.sub(scratchpad, 5)
            scratchpad = ""
        elseif string.len(scratchpad) == 9 then
            EXTRA = string.sub(scratchpad,1,4)
            EXTRA_TIME = string.sub(scratchpad,6,9)
            scratchpad = ""
        else
            scratchpad = "INVALID ENTRY"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 11 then
        scratchpad = "INVALID ENTRY"
    end
end


local function processTowLw()
    if get(MCDU_CURRENT_BUTTON) == 9 and string.match(scratchpad, ".") then
        if string.len(scratchpad) == 4 and string.sub(scratchpad, 3,3) == "." then
            TOW = "0"..scratchpad
            if LW == "" then
                LW = "---.-"
            end
            scratchpad = ""
        elseif string.len(scratchpad) == 5 and string.sub(scratchpad,4,4) == "." then
            TOW = scratchpad
            if LW == "" then
                LW = "---.-"
            end
            scratchpad = ""
        elseif string.len(scratchpad) == 6 and string.sub(scratchpad,1,1) == "/" then
            if TOW == "" then
                TOW = "---.-"
            end
            LW = string.sub(scratchpad,2)
            scratchpad = ""
        elseif string.len(scratchpad) == 11 then
            TOW = string.sub(scratchpad,1,5)
            LW = string.sub(scratchpad,7)
            scratchpad = ""
        else
            scratchpad = "INVALID ENTRY"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 6 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processTripWind()
    if get(MCDU_CURRENT_BUTTON) == 10 and string.sub(scratchpad,string.len(scratchpad)-1,string.len(scratchpad)-1) then
        TRIP_WIND = scratchpad
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 10 then
        scratchpad = "INVALID ENTRY"

    end
end

local function processMinDestFob()
    if get(MCDU_CURRENT_BUTTON) == 5 and string.len(scratchpad) < 6 then
        MIN_DEST_FOB = scratchpad
        scratchpad = ""
    end
end
function drawInitB()
    input()
    -- Draw Static Text
    drawText("INIT",11,14,MCDU_WHITE,SIZE.TITLE,false,"L")
    drawOptionHeadings(optionLabels)

    -- Dynamic Updates
    processZFW() -- validate ZFW / ZFWCG inputs
    if ZFW ~= "" and ZFWCG ~= "" then
        drawText(ZFW.."/"..ZFWCG, 24, 12, MCDU_BLUE, SIZE.OPTION, false, "R")
    else
        drawText("--.-/--.-", 24, 12,  MCDU_WHITE, SIZE.OPTION, false, "R")
    end

    processTaxi() -- process taxi fuel input
    if TAXI_FUEL ~= "" then
        drawText(TAXI_FUEL, 1, 12, MCDU_BLUE, SIZE.OPTION, false, "L")
    else
        drawText("-.-", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    end

    processBlock() -- Process Block
    if BLOCK ~= "" then
        drawText(BLOCK, 24, 10, MCDU_BLUE, SIZE.OPTION, false, "R")
    else
        drawText("--.-",24, 10, MCDU_WHITE, SIZE.OPTION, false, "R")
    end

    processAltnTime()
    if ALTN ~= "" and ALTN_TIME ~= "" then
        drawText(ALTN.."/"..ALTN_TIME, 1, 6, MCDU_BLUE, SIZE.OPTION, false, "L")
    else
        drawText("--.-/----", 1, 6, MCDU_WHITE, SIZE.OPTION, false, "L")
    end

    processFinalTime()
    if FINAL ~= "" and FINAL_TIME ~= "" then
        drawText(FINAL.."/"..FINAL_TIME, 1,4,MCDU_BLUE,SIZE.OPTION,false,"L")
    else
        drawText("--.-/----", 1,4,MCDU_WHITE,SIZE.OPTION,false,"L")
    end

    processTowLw()
    if TOW ~= "" and LW ~= "" then
        drawText(TOW.."/"..LW,24,6,MCDU_BLUE,SIZE.OPTION,false,"R")
    else
        drawText("---.-/---.-",24,6,MCDU_WHITE,SIZE.OPTION,false,"R")
    end

    processTripWind()
    if TRIP_WIND ~= "" then
        drawText(TRIP_WIND, 24, 4, MCDU_BLUE, SIZE.OPTION, false, "R")
    else
        drawText("---.-",24,4,MCDU_WHITE,SIZE.OPTION,false,"R")
    end

    processMinDestFob()
    if MIN_DEST_FOB ~= "" then
        drawText(MIN_DEST_FOB,1,2,MCDU_BLUE,SIZE.OPTION,false,"L")
    else
        drawText("-----",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    end

    processExtraTime()
    if EXTRA ~= "" and EXTRA_TIME ~= "" then
        drawText(EXTRA.."/"..EXTRA_TIME,24,2,MCDU_BLUE,SIZE.OPTION,false,"R")
    else
        drawText("--.-/--.-",24,2,MCDU_WHITE,SIZE.OPTION,false,"R")
    end

    -- draw TRIP/TIME
    drawText("0.0/0000", 1, 10, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("0.0/0.0",1,8,MCDU_BLUE,SIZE.OPTION,false,"L") -- Draw RTE RSV
end