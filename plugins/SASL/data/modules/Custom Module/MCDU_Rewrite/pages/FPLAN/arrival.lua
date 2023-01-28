local ARRIVAL_PHASE = 1
SELECTED_APPROACH = ""
SELECTED_ARR_TRANS = ""
SELECTED_STAR = ""
SELECTED_VIA = ""
local SHIFT = 0

local function arrivalListInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and #(ApproachList) > 3 and SHIFT > 0 then
        SHIFT = SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(ApproachList) > 3 and SHIFT < #ApproachList-3 then
        SHIFT = SHIFT + 1
    else
        SHIFT = SHIFT
    end
end

local function viaInput()
    if get(MCDU_CURRENT_BUTTON) > 1 and get(MCDU_CURRENT_BUTTON) < 5 and SELECTED_APPROACH ~= "" then
        SELECTED_VIA = VIAS[(get(MCDU_CURRENT_BUTTON)-1)+SHIFT]
        ARRIVAL_PHASE = 3
        SHIFT = 0
    end
    if get(MCDU_CURRENT_BUTTON) == 25 and #(VIAS) > 3 and SHIFT > 0 then
        SHIFT = SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(VIAS) > 3 and SHIFT < #VIAS-3 then
        SHIFT = SHIFT + 1
    else
        SHIFT = SHIFT
    end
end

local function processPageInput()
    if get(MCDU_CURRENT_BUTTON) == 24 and ARRIVAL_PHASE > 1 then
        ARRIVAL_PHASE = ARRIVAL_PHASE - 1
        print(ARRIVAL_PHASE)
    end
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 4)
    end
    if get(MCDU_CURRENT_BUTTON) == 11 and ARRIVAL_PHASE == 3 then
        local wpt = getFullApproachProcedure()
        for i in ipairs(wpt) do
            table.insert(FLIGHT_PLAN, wpt[i])
        end
        set(MCDU_CURRENT_PAGE, 3)
    end
end

local function processAppchInput()
    if get(MCDU_CURRENT_BUTTON) > 1 and get(MCDU_CURRENT_BUTTON) < 5 then
        SELECTED_APPROACH = APPCH[(get(MCDU_CURRENT_BUTTON)-1)+SHIFT]
        GLOBAL_APPCH = string.sub(ApproachList[(get(MCDU_CURRENT_BUTTON)-1) + SHIFT], 3)
        ARRIVAL_PHASE = 2
        SHIFT = 0
    end
end

local function processStarInput()
    if get(MCDU_CURRENT_BUTTON) > 1 and get(MCDU_CURRENT_BUTTON) < 5 and SELECTED_APPROACH ~= "" then
        if STARS[(get(MCDU_CURRENT_BUTTON)-1)+SHIFT] ~= "NO STAR" then
            SELECTED_STAR = STARS[(get(MCDU_CURRENT_BUTTON)-1)+SHIFT]
            ARRIVAL_PHASE = 3
            SHIFT = 0
        else
            SELECTED_STAR = "NONE"
            ARRIVAL_PHASE = 3
            SHIFT = 0
        end
    end
end

local function processTransInput()
    if get(MCDU_CURRENT_BUTTON) > 7 and get(MCDU_CURRENT_BUTTON) < 11 and (ARRIVAL_PHASE == 2 or ARRIVAL_PHASE == 3) then
        if TRANS[(get(MCDU_CURRENT_BUTTON)-7)+SHIFT] ~= "NO TRANS" then
            SELECTED_ARR_TRANS = TRANS[(get(MCDU_CURRENT_BUTTON)-7)+SHIFT]
            SHIFT = 0
        else
            SELECTED_ARR_TRANS = "NONE"
            SHIFT = 0
        end
    end
end

function editDisplayApproach(appch)

    local key = "LRC"
    -- Build the string that will be displayed on the screen
    local APPCH = {}
    
    for i in ipairs(appch) do
        local runway = string.sub(appch[i], 4)
        if not string.find(key, string.sub(runway,3,3)) then
            runway = string.sub(runway, 1,2)
        else
            runway = string.sub(runway,1,3)
        end
        if string.sub(appch[i],1,1) == "H" then
            runway = "RNAV "..runway
        elseif string.sub(appch[i],1,1) == "D" then
            runway = "VORDME "..runway
        elseif string.sub(appch[i],1,1) == "I" then
            runway = "ILS "..runway
        elseif string.sub(appch[i],1,1) == "L" then
            runway = "LOC "..runway
        elseif string.sub(appch[i],1,1) == "Q" then
            runway = "DME "..runway
        elseif string.sub(appch[i],1,1) == "R" then
            runway = "RNAV "..runway
        elseif string.sub(appch[i],1,1) == "S" then
            runway = "VORDME "..runway
        elseif string.sub(appch[i],1,1) == "V" then
            runway = "VOR "..runway
        end
        table.insert(APPCH, #APPCH+1, runway)
    end
    return APPCH
end
function drawPhase1()

    -- DRAW FIELDS
    drawText("NONE",11, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("------",24, 12, MCDU_GREEN, SIZE.OPTION, false, "R")
    drawText("NONE",24, 10, MCDU_GREEN, SIZE.OPTION, false, "R")


    drawText("APPR",1, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("AVAILABLE",9, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    ApproachList = getApproachProcedures(DESTINATION_AIRPORT)

    APPCH = editDisplayApproach(ApproachList)

    wrap(APPCH, SHIFT)
    if #APPCH < 3 then
        local amt = 3 - #APPCH
        for i=amt,3-amt,-1 do
            table.insert(APPCH,#APPCH+1,"")
        end
    end
    drawText("<"..APPCH[1], 1, 8, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<"..APPCH[2], 1, 6, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<"..APPCH[3], 1, 4, MCDU_BLUE, SIZE.OPTION, false, "L")
end

function drawPhase2()
    drawText("APPR",1, 11, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText(SELECTED_APPROACH, 1, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("<VIAS",1, 10, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("------",24, 12, MCDU_GREEN, SIZE.OPTION, false, "R")
    -- drawText("NONE",24, 10, MCDU_GREEN, SIZE.OPTION, false, "R")
    drawText("STAR",1, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("TRANS",24, 9, MCDU_WHITE, SIZE.HEADER, false, "R")

    drawText("AVAILABLE",9, 9, MCDU_WHITE, SIZE.HEADER, false, "L")

    STARS = getArrivalProcedures(DESTINATION_AIRPORT)
    wrap(STARS, SHIFT)
    if #STARS < 3 then
        local amt = 3 - #STARS
        for i=amt, 3-amt, -1 do
            table.insert(STARS, #STARS+1, "")
        end
    end
    drawText("<"..STARS[1], 1, 8, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<"..STARS[2], 1, 6, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<"..STARS[3], 1, 4, MCDU_BLUE, SIZE.OPTION, false, "L")

    if SELECTED_ARR_TRANS ~= "" then
        drawText(SELECTED_ARR_TRANS, 24, 10, MCDU_GREEN, SIZE.OPTION, false, "R")
    end

end

local function drawPhase3()
    drawText(SELECTED_APPROACH, 1, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    drawText("APPR VIAS",1, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText(SELECTED_STAR, 24, 12, MCDU_GREEN, SIZE.OPTION, false, "R")
    drawText("INSERT*", 24, 2, MCDU_ORANGE, SIZE.OPTION, false, "R")
    if SELECTED_VIA ~= "" then
        drawText(SELECTED_VIA,12, 12, MCDU_GREEN, SIZE.OPTION, false, "L")
    end

    if SELECTED_ARR_TRANS ~= "" then
        drawText(SELECTED_ARR_TRANS, 24, 10, MCDU_GREEN, SIZE.OPTION, false, "R")
    end

    VIAS = findVias()

    wrap(VIAS, SHIFT)

    if #VIAS < 3 then
        local amt = 3 - #TRANS
        for i=amt, 3-amt, -1 do
            table.insert(TRANS, #TRANS+1, "")
        end
    end

    drawText("<"..VIAS[1], 1, 8, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<"..VIAS[2], 1, 6, MCDU_BLUE, SIZE.OPTION, false, "L")
    drawText("<"..VIAS[3], 1, 4, MCDU_BLUE, SIZE.OPTION, false, "L")
end

local function drawTrans()
    TRANS = getArrivalTrans(DESTINATION_AIRPORT)
    wrap(TRANS, SHIFT)
    if #TRANS < 3 then
        local amt = 3 - #TRANS
        for i=amt, 3-amt, -1 do
            table.insert(TRANS, #TRANS+1, "")
        end
    end
    drawText(TRANS[1]..">", 24, 8, MCDU_BLUE, SIZE.OPTION, false, "R")
    drawText(TRANS[2]..">", 24, 6, MCDU_BLUE, SIZE.OPTION, false, "R")
    drawText(TRANS[3]..">", 24, 4, MCDU_BLUE, SIZE.OPTION, false, "R")
end

function drawArr()
    processPageInput()
    drawText("ARRIVAL TO "..DESTINATION_AIRPORT, 4, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("APPR",1, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("VIA",12, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("STAR",24, 13, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("TRANS",24, 11, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("<RETURN",1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
    if SELECTED_ARR_TRANS == "" and ARRIVAL_PHASE > 1 then
        drawTrans()
        processTransInput()
    end
    if ARRIVAL_PHASE == 1 then
        processAppchInput()
        arrivalListInput()
        drawPhase1()
    elseif ARRIVAL_PHASE == 2 and SELECTED_APPROACH ~="" then
        drawPhase2()
        processStarInput()
        arrivalListInput()
    elseif ARRIVAL_PHASE == 3 then
        drawPhase3()
        viaInput()
    end
end