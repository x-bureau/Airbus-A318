




local optionLabels = {
    [1] = "ACT MODE",
    [2] = "",
    [3] = "MANAGED",
    [4] = "SELECTED",
    [5] = "",
    [6] = "PREV",
    [7] = "EFOB",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "NEXT"
}

local function phaseInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 61)
    elseif get(MCDU_CURRENT_BUTTON) == 11 then
        set(MCDU_CURRENT_PAGE, 63)
    end
end


function drawClb()
    phaseInput()
    drawOptionHeadings(optionLabels) -- Draw static labels
    drawText("CLB",11,14,MCDU_WHITE,SIZE.TITLE,false,"L")
    drawText("CI",2,11,MCDU_WHITE,SIZE.HEADER,false,"L")
    drawText("PHASE>",24,2,MCDU_WHITE,SIZE.OPTION,false,"R") -- TODO: add next phase button
    drawText("<PHASE",1,2,MCDU_WHITE,SIZE.OPTION,false,"L") -- Draw Previous Phase button

    drawText("TIME",11,9,MCDU_WHITE,SIZE.HEADER,false,"L")
    drawText("DIST",24,9,MCDU_WHITE,SIZE.HEADER,false,"R")

    drawText("---",12,6,MCDU_WHITE,SIZE.HEADER,false,"L")
    drawText("----",24,6,MCDU_WHITE,SIZE.HEADER,false,"R")


    if COST_INDEX ~= 0 then
        drawText(COST_INDEX,1,10,MCDU_BLUE,SIZE.OPTION,false,"L")
    else
        drawText("---",1,10,MCDU_WHITE,SIZE.OPTION,false,"L")
    end

    drawText("290",2,8,MCDU_GREEN,SIZE.OPTION,false,"L")
    drawText("*[ ]",2,6,MCDU_BLUE,SIZE.OPTION,false,"L")

    --TODO: EDIT STATIC MANUAL ACT MODE
    drawText("MANUAL",1,12,MCDU_GREEN,SIZE.OPTION,false,"L")
end