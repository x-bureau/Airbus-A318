local optionLablesA = {
    [1] = "POSITION",
    [2] = "IRS",
    [3] = "GPS",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "PRINT",
    [12] = "AOC"
}


function switchDataPage()
    if get(MCDU_CURRENT_BUTTON) == 26 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 22)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 24 and get(MCDU_CURRENT_PAGE) == 22 then
        set(MCDU_CURRENT_PAGE, 2)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 10 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 225)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 11 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 226)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 2 and get(MCDU_CURRENT_PAGE) == 2 then
        set(MCDU_CURRENT_PAGE, 223)
        set(MCDU_CURRENT_BUTTON, -1)
    end
end


function drawDataA()
    drawOptionHeadings(optionLablesA)
    -- [ STATIC DRAWINGS ] --
    drawText("DATA INDEX", 7, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("1/2", 23, 14, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("<MONITOR", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<MONITOR", 1, 10, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<MONITOR", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<A/C STATUS", 1, 6, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("FUNCTION>", 24, 4, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("FUNCTION>", 24, 2, MCDU_WHITE, SIZE.OPTION, false, "R")
end

local optionLablesB = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "ACTIVE F-PLN",
    [6] = "SEC F-PLN",
    [7] = "PILOTS",
    [8] = "PILOTS",
    [9] = "PILOTS",
    [10] = "PILOTS",
    [11] = "",
    [12] = ""
}

function drawDataB()
    drawText("DATA INDEX", 7, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("2/2", 23, 14, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("<WAYPOINTS", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<NAVAIDS", 1, 10, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<RUNWAYS", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<ROUTES", 1, 6, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<WINDS", 1, 4, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("<WINDS", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("WAYPOINTS>", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("NAVAIDS>", 24, 10, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("RUNWAYS>", 24, 8, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("ROUTES>", 24, 6, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawOptionHeadings(optionLablesB)
end