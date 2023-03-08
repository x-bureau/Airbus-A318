local optionLabels = {
    [1] = " FLIGHT",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = " ATSU DLK",
    [7] = "",
    [8] = " RECEIVED ",
    [9] = "SENT ",
    [10] = " AMENDED ",
    [11] = " VOICE ",
    [12] = ""
}

local function processAOCMenuInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 10)
    elseif get(MCDU_CURRENT_BUTTON) == 6 then
        set(MCDU_CURRENT_PAGE, 71)
    elseif get(MCDU_CURRENT_BUTTON) == 7 then
        set(MCDU_CURRENT_PAGE, 72)
    elseif get(MCDU_CURRENT_BUTTON) == 1 then
        set(MCDU_CURRENT_PAGE, 73)
    end
end

function drawAOC()
    processAOCMenuInput()

    drawOptionHeadings(optionLabels)
    drawText("AOC MENU", 9, 14, MCDU_WHITE, SIZE.TITLE,false,"L")
    drawText("<INIT",1,12,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("<WX REQ",1,10,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("<ATIS",1,8,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("<PDC",1,6,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("<PERF/W&B",1,4,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("<RETURN",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("FREE TEXT>",24,12,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("MESSAGES>",24,10,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("MESSAGES>",24,8,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("000|>",24,6,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("CONTACT>",24,4,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("MISC>",24,2,MCDU_WHITE,SIZE.OPTION,false,"R")
end