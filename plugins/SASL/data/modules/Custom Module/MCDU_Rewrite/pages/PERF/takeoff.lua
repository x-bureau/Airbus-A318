-- labels for static text
V1 = 0
VR = 0
V2 = 0
TRANS_ALT = 10000
ENG_OUT_AOC = 1500
local newTrans = false
local newEngOutAoc = false



local optionLabels = {
    [1] = "V1",
    [2] = "VR",
    [3] = "V2",
    [4] = "TRANS ALT",
    [5] = "THR RED/ACC",
    [6] = "",
    [7] = "RWY",
    [8] = "TO SHIFT",
    [9] = "FLAPS/THS",
    [10] = "FLEX TO TEMP",
    [11] = "ENG OUT ACC",
    [12] = "NEXT"
}



local function processPhaseInput()
    if get(MCDU_CURRENT_BUTTON) == 11 then
        set(MCDU_CURRENT_PAGE, 62)
    end
end

local function processV1()
    if get(MCDU_CURRENT_BUTTON) == 0 and string.len(scratchpad) == 3 and toNum(scratchpad) ~= false then
        V1 = tonumber(scratchpad)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 0 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processVR()
    if get(MCDU_CURRENT_BUTTON) == 1 and string.len(scratchpad) == 3 and toNum(scratchpad) ~= false then
        VR = tonumber(scratchpad)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 1 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processV2()
    if get(MCDU_CURRENT_BUTTON) == 2 and string.len(scratchpad) == 3 and toNum(scratchpad) ~= false then
        V2 = tonumber(scratchpad)
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 2 then
        scratchpad = "INVALID ENTRY"
    end
end

local function processTrans()
    if get(MCDU_CURRENT_BUTTON) == 3 and string.len(scratchpad) > 3 and toNum(scratchpad) ~= false then
        TRANS_ALT = tonumber(scratchpad)
        newTrans = true
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 3 then
        scratchpad = "INVALID ENTRY"
    end
end
local function processEngOutAoc()
    if get(MCDU_CURRENT_BUTTON) == 10 and string.len(scratchpad) > 3 and toNum(scratchpad) ~= false then
        ENG_OUT_AOC = tonumber(scratchpad)
        newEngOutAoc = true
        scratchpad = ""
    elseif get(MCDU_CURRENT_BUTTON) == 10 then
        scratchpad = "INVALID ENTRY"
    end
end

function drawTakeoff()
    processPhaseInput() -- Draw static headers
    drawOptionHeadings(optionLabels)
    drawText("FLP RETR",8,13,MCDU_WHITE,SIZE.HEADER ,false,"L")
    drawText("SLT RETR",8,11,MCDU_WHITE,SIZE.HEADER ,false,"L")
    drawText("CLEAN",9,9,MCDU_WHITE,SIZE.HEADER ,false,"L")

    drawText("TAKE OFF",8,14,MCDU_GREEN,SIZE.TITLE,false,"L") -- draw title
    drawText("PHASE>",24,2,MCDU_WHITE,SIZE.OPTION,false,"R") -- Static Next button

    drawText("F=144",9,12,MCDU_GREEN,SIZE.OPTION,false,"L")
    drawText("S=186",9,10,MCDU_GREEN,SIZE.OPTION,false,"L")
    drawText("O=205",9,8,MCDU_GREEN,SIZE.OPTION,false,"L")

    processV1()
    if V1 ~= 0 then
        drawText(tostring(V1),1,12,MCDU_BLUE,SIZE.OPTION,false,"L")
    else
        drawTextFieldBoxes(3,MCDU_ORANGE,TEXT_X[1]-10,TEXT_Y[12]-8,1)
    end

    processVR()
    if VR ~= 0 then
        drawText(tostring(VR),1,10,MCDU_BLUE,SIZE.OPTION,false,"L")
    else
        drawTextFieldBoxes(3,MCDU_ORANGE,TEXT_X[1]-10,TEXT_Y[10]-8,1)
    end

    processV2()
    if V2 ~= 0 then
        drawText(tostring(V2),1,8,MCDU_BLUE,SIZE.OPTION,false,"L")
    else
        drawTextFieldBoxes(3,MCDU_ORANGE,TEXT_X[1]-10,TEXT_Y[8]-8,1)
    end

    if SELECTED_RUNWAY ~= "" then
        drawText(SELECTED_RUNWAY,24,12,MCDU_GREEN,SIZE.OPTION,false,"R")
    else
        drawText("---",24,12,MCDU_WHITE,SIZE.OPTION,false,"R")
    end

    processTrans()
    if TRANS_ALT == 10000 and newTrans == false then
        drawText(tostring(TRANS_ALT), 1, 6,MCDU_BLUE,SIZE.HEADER,false,"L")
    else
        drawText(tostring(TRANS_ALT),1,6,MCDU_BLUE,SIZE.OPTION,false,"L")
    end

    processEngOutAoc()
    if ENG_OUT_AOC == 1500 and newEngOutAoc == false then
        drawText(tostring(ENG_OUT_AOC),24,4,MCDU_BLUE,SIZE.HEADER,false,"R")
    else
        drawText(tostring(ENG_OUT_AOC),24,4,MCDU_BLUE,SIZE.OPTION,false,"R")
    end

    -- Draw Static TO SHIFT 
    -- TODO: CHANGE FROM STATIC TO DYNAMIC
    drawText("[M]",19,10,MCDU_GREY,22,false,"R")
    drawText("[  ]*",24,10,MCDU_GREY,SIZE.OPTION,false,"R")
    drawText("[]/[   ]",24,8,MCDU_BLUE,SIZE.OPTION,false,"R")
    drawText("[   ]"..DEG_SYMBOL,24,6,MCDU_BLUE,SIZE.OPTION,false,"R")


    drawText("UPLINK",1,3,MCDU_GREY,SIZE.HEADER,false,"L") -- Draw TO Data UPLINK
    drawText("<TO DATA",1,2,MCDU_GREY,SIZE.OPTION,false,"L")

end