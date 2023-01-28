------------------------------------------------------
--                MCDU WRITTEN BY:
--                  - FBI914
------------------------------------------------------


--Custom Colors
local MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
local MCDU_GREEN = {0.0, 1.0, 0.1, 1.0}
local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}

-- INPUT HANDLER
function switchPrintAOCPage()
    if get(MCDU_CURRENT_BUTTON) == 26 and get(MCDU_CURRENT_PAGE) == 225 then
        set(MCDU_CURRENT_PAGE, 2251)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 24 and get(MCDU_CURRENT_PAGE) == 2251 then
        set(MCDU_CURRENT_PAGE, 225)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 11 and get(MCDU_CURRENT_PAGE) == 225 then
        set(MCDU_CURRENT_PAGE,226)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 11 and get(MCDU_CURRENT_PAGE) == 226 then
        set(MCDU_CURRENT_PAGE, 225)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 26 and get(MCDU_CURRENT_PAGE) == 226 then
            set(MCDU_CURRENT_PAGE, 2261)
            set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 24 and get(MCDU_CURRENT_PAGE) == 2261 then
        set(MCDU_CURRENT_PAGE, 226)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 5 and (get(MCDU_CURRENT_PAGE) == 225 or get(MCDU_CURRENT_PAGE) == 2251 or get(MCDU_CURRENT_PAGE) == 226 or get(MCDU_CURRENT_PAGE == 2261)) then
        set(MCDU_CURRENT_PAGE, 2)
        set(MCDU_CURRENT_BUTTON, -1)
    end
end

local optionLablesA = {
    [1] = "AUTO",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "MANUAL",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "AOC"
}

local function processPrintInput()
    if get(MCDU_CURRENT_BUTTON) >= 6 and get(MCDU_CURRENT_BUTTON) <= 8 and get(MCDU_CURRENT_PAGE) == 225 then
        scratchpad = "PRINTER NOT AVAILABLE"
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) >= 6 and get(MCDU_CURRENT_BUTTON) <= 9 and get(MCDU_CURRENT_PAGE) == 2251 then
        scratchpad = "PRINTER NOT AVAILABLE"
        set(MCDU_CURRENT_BUTTON, -1)
    end
end

function drawPrintA()
    --STATIC DRAWINGS
    processPrintInput()
    drawOptionHeadings(optionLablesA)
    drawText("PRINT FUNCTION", 5, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("1/2", 23, 14, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("*NO", 1, 12, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("*NO", 1, 10, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("*NO", 1, 8, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("PRINT*", 24, 12, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("PRINT*", 24, 10, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("PRINT*", 24, 8, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("FUNCTION>", 24, 2, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("F-PLN INIT", 7, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("TO DATA", 9, 10, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("WIND DATA", 7, 8, MCDU_GREEN, SIZE.OPTION, false, "L")

end

local optionLabelsB = {
    [1] = "AUTO",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "MANUAL",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "AOC"
}
function drawPrintB()
    --STATIC DRAWINGS
    processPrintInput()
    drawOptionHeadings(optionLabelsB)
    drawText("PRINT FUNCTION", 5, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("2/2", 23, 14, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("*NO", 1, 12, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("*NO", 1, 10, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("*NO", 1, 8, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("*NO", 1, 6, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("PRINT*", 24, 12, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("PRINT*", 24, 10, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("PRINT*", 24, 8, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("PRINT*", 24, 6, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("FUNCTION>", 24, 2, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("PREFLIGHT", 8, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("PREFLIGHT", 8, 10, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("PREFLIGHT", 7, 8, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("PREFLIGHT", 8, 6, MCDU_GREEN, SIZE.OPTION, false, "L")
end

local optionLablesC = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "UPLINK",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "PRINT"
}

function drawAOCA()
    -- STATIC DRAWINGS
    drawOptionHeadings(optionLablesC)
    drawText("AOC FUNCTION", 6, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("1/2", 23, 14, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("REQ*", 24, 12, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("REQ*", 24, 10, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("REQ*", 24, 8, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("FUNCTION>", 24, 2, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("F-PLAN INIT", 6, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("TO DATA", 8, 10, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("WIND DATA", 7, 8, MCDU_GREEN, SIZE.OPTION, false, "L")
end

local optionLablesD = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "",
    [7] = "REPORT",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = "PRINT"
}

function drawAOCB()
    --STATIC DRAWINGS
    drawOptionHeadings(optionLablesD)
    drawText("PRINT FUNCTION", 5, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("2/2", 23, 14, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("SEND*", 24, 12, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("SEND*", 24, 10, MCDU_ORANGE, SIZE.OPTION, false, "R")
    drawText("FUNCTION>", 24, 2, MCDU_WHITE, SIZE.OPTION, false, "R")
    drawText("F-PLN RPT", 9, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("POSITION RPT", 7, 10, MCDU_GREEN, SIZE.OPTION, false, "L")
end