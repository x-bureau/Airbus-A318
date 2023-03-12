local function drawLabels()
    drawText("A318-112",9,14, MCDU_WHITE, SIZE.TITLE, false, "L") -- Draw Title

    drawText("ENG", 2, 13, MCDU_WHITE, SIZE.HEADER, false, "L") -- draw eng header
    drawText("ACTIVE NAV DATA BASE", 2, 11, MCDU_WHITE, SIZE.HEADER, false, "L") -- draw headers
    drawText("SECOND NAV DATA BASE", 2, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("CHG CODE", 1, 5, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("IDLE/PERF",1,3,MCDU_WHITE,SIZE.HEADER,false,"L")

end

local function drawFields()
    drawText("CFM56-5B9/P", 1, 12, MCDU_GREEN,SIZE.OPTION,false,"L")
    drawText("XXXXXXXXXXX", 2, 10, MCDU_BLUE, SIZE.OPTION,false,"L")
    drawText("XXXXXXXXXX", 15, 10, MCDU_GREEN, SIZE.HEADER,false,"L")
    drawText("XXXXXXXXXXX", 1, 8, MCDU_BLUE, SIZE.HEADER,false,"L")
    drawText("[ ]", 1, 4, MCDU_BLUE, SIZE.OPTION,false,"L")
    drawText("+0.0/+0.0", 1, 2, MCDU_GREEN, SIZE.OPTION,false,"L")

end


function drawACStatus()
    drawLabels() -- draw the labels
    drawFields() -- draw the fields
end