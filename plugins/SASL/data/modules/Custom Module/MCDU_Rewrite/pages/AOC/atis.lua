local staticLabels = {
    [1] = " AIRPORT",
    [2] = "-------SELECT ONE-------",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "RETURN TO",
    [7] = "vFORMAT FOR ",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = ""
}

local fields = {
    [1] = "[ ]",
    [2] = "<ARRIVAL",
    [3] = "DEPARTURE",
    [4] = "ENROUTE>",
}

-- ATIS MODE:
-- 1 = ARRIVAL
-- 2 = DEPARTURE
-- 3 = ENROUTE

ATIS_CURRENT_MODE = 2

local function processATISInput()
    -- Process ATIS ICAO and mode selection
    if get(MCDU_CURRENT_BUTTON) == 0 then
        if checkICAO(scratchpad) then
            fields[1] = scratchpad
            scratchpad = ""
        else
            scratchpad = "ERROR: INVALID ICAO"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 1 and ATIS_CURRENT_MODE ~= 1 then
        ATIS_CURRENT_MODE = 1
        fields[2] = "ARRIVAL"
        fields[3] = "<DEPARTURE"
        fields[4] = "ENROUTE>"
    elseif get(MCDU_CURRENT_BUTTON) == 2 and ATIS_CURRENT_MODE ~= 2 then
        ATIS_CURRENT_MODE = 2
        fields[2] = "<ARRIVAL"
        fields[3] = "DEPARTURE"
        fields[4] = "ENROUTE>"
    elseif get(MCDU_CURRENT_BUTTON) == 7 and ATIS_CURRENT_MODE ~= 3 then
        ATIS_CURRENT_MODE = 3
        fields[2] = "<ARRIVAL"
        fields[3] = "<DEPARTURE"
        fields[4] = "ENROUTE"
    end
    -- process ATIS SEND
    if get(MCDU_CURRENT_BUTTON) == 11 and checkICAO(fields[1]) then
        fields[1] = "[ ]"
        print("TEMP SENDING MESSAGE")
    end

end

local function drawButtons()
    drawText("<AOC MENU",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("MCDU*",24,12,MCDU_BLUE,SIZE.OPTION,false,"R")
    drawText("SEND",23,2,MCDU_BLUE,SIZE.OPTION,false,"R")

end

function drawATIS()
    processATISInput()
    drawOptionHeadings(staticLabels)
    drawButtons()
    drawText("AOC ATIS REQUEST",5,14,MCDU_WHITE,SIZE.TITLE,false,"L")

    -- draw the fields
    drawText(fields[1],1,12,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[2],1,10,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[3],1,8,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[4],24,10,MCDU_BLUE,SIZE.OPTION,false,"R")
end