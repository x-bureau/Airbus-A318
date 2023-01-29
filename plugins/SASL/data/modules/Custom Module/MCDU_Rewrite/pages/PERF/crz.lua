-- Static Headers
local optionLabels = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "PREV",
    [7] = "",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = ""
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
    drawText("<PHASE",1,2,MCDU_WHITE,SIZE.OPTION,false,"L") -- Draw Previous Phase button
    sasl.gl.drawText(MCDU_FONT, 240, 170, "NYI", 250, false, false, TEXT_ALIGN_CENTER, MCDU_ORANGE)
end