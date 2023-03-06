-- Static Headers
local optionLabels = {
    [1] = "ACT MODE",
    [2] = " CI",
    [3] = " MANAGED",
    [4] = " PRESEL",
    [5] = "",
    [6] = "PREV",
    [7] = "EFOB",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "DES CABIN RATE>",
    [12] = "NEXT"
}

local function phaseInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 62)
    elseif get(MCDU_CURRENT_BUTTON) == 11 then
        print("NOT YET IMPLEMENTED!")
    end
end

function drawCrz()
    phaseInput()
    drawOptionHeadings(optionLabels)
    drawText("CRZ", 11,14,MCDU_WHITE,SIZE.TITLE,false,"L")
    drawText("MANAGED", 1, 12, MCDU_GREEN,SIZE.OPTION,false, "L")
    drawText("30", 1, 10, MCDU_BLUE,SIZE.OPTION,false, "L")
    drawText("290", 2, 8, MCDU_GREEN,SIZE.OPTION,false, "L")
    drawText("*[ ]", 2, 6, MCDU_BLUE,SIZE.OPTION,false, "L")
    drawText("6.0",24,12,MCDU_GREEN,SIZE.OPTION,false,"R")
    drawText("-XXXFT/MIN",24,4,MCDU_GREEN,SIZE.OPTION,false,"R")

    drawText("<PHASE",1,2,MCDU_WHITE,SIZE.OPTION,false,"L") -- Draw Previous Phase button
    drawText("PHASE>",24,2,MCDU_WHITE,SIZE.OPTION,false,"R") -- Draw Next Phase button

end