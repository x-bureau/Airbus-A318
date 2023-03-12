function processATSUInput()
    if get(MCDU_CURRENT_BUTTON) == 6 then
        set(MCDU_CURRENT_PAGE, 7)
    end
end

function drawATSU()
    processATSUInput() -- we check inputs for the ATSU menu page
    drawText("ATSU DATALINK", 7, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("<ATC MENU",1,12,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("AOC MENU>",24,12,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("DATALINK",23,5,MCDU_WHITE,SIZE.HEADER,false,"R")
    drawText("STATUS>",24,4,MCDU_WHITE,SIZE.OPTION,false,"R")
    drawText("COMM MENU>",24,2,MCDU_WHITE,SIZE.OPTION,false,"R")

end