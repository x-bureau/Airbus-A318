local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}

SELECTED_RUNWAY = ""
SELECTED_DPT_SID = ""
SELECTED_TRANS = ""

PAGE_STATE = 1

SHIFT = 0
SID_SHIFT = 0

local function runwayListInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and #(RUNWAYS) > 4 and SHIFT > 0 then
        SHIFT = SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(RUNWAYS) > 4 and SHIFT < #RUNWAYS-4 then
        SHIFT = SHIFT + 1
    else
        SHIFT = SHIFT
    end
end

local function sidListInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and #(DPT_PROCEDURE) > 4 and SID_SHIFT > 0 then
        SID_SHIFT = SID_SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(DPT_PROCEDURE) > 4 and SID_SHIFT < #SIDS-4 then
        SID_SHIFT = SID_SHIFT + 1
    else
        SID_SHIFT = SID_SHIFT
    end
end



local function processRnwyInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 4)
    end
end

local function processRwySelect(runway)
    if get(MCDU_CURRENT_BUTTON) > 0 and get(MCDU_CURRENT_BUTTON) < 6 then
        local val = get(MCDU_CURRENT_BUTTON) -- We determine what the index is of the airport aligned with the selected button
        SELECTED_RUNWAY = string.sub(runway[val], 1, -2)
        PAGE_STATE = 2
    end
end

local function processSidSelect(DPT_PROCEDURE)
    if get(MCDU_CURRENT_BUTTON) > 0 and get(MCDU_CURRENT_BUTTON) < 6 then
        local val = get(MCDU_CURRENT_BUTTON) -- We determine what the index is of the airport aligned with the selected button
        SELECTED_DPT_SID = DPT_PROCEDURE[val]
        PAGE_STATE = 3
    end
end

local function processPageInput()
    if get(MCDU_CURRENT_BUTTON) == 24 and PAGE_STATE > 1 then
        PAGE_STATE = PAGE_STATE - 1
    elseif get(MCDU_CURRENT_BUTTON) == 11 and PAGE_STATE >= 2 then
        local wpt = getFullDepartureProcedure()
        for i in ipairs(wpt) do
            table.insert(FLIGHT_PLAN, wpt[i])
        end
        set(MCDU_CURRENT_PAGE, 3)
    end

end




function drawRnwy()
    processPageInput()
    RUNWAYS = getAirportRunways(DEPARTURE_AIRPORT)
    runwayListInput()

    local RwyList = {
    }
    for i in ipairs(RUNWAYS) do
        table.insert(RwyList, #RwyList+1, string.sub(RUNWAYS[i],string.find(RUNWAYS[i],":")+3,-1))
    end
    processRnwyInput()


    if PAGE_STATE == 1 then
        wrap(RwyList, SHIFT) -- IMPLEMENTING SCROLLING
        processRwySelect(RwyList)
        --DRAW RUNWAY OPTIONS
        if #RwyList < 4 then
            local amt = 4 - #RwyList
            for i=amt,4-amt,-1 do
                table.insert(RwyList,i,"")
            end
        end
        drawText("<"..RwyList[1], 1, 10, MCDU_BLUE, SIZE.OPTION, false, "L")
        drawText("<"..RwyList[2], 1, 8, MCDU_BLUE, SIZE.OPTION, false, "L")
        drawText("<"..RwyList[3], 1, 6, MCDU_BLUE, SIZE.OPTION, false, "L")
        drawText("<"..RwyList[4], 1, 4, MCDU_BLUE, SIZE.OPTION, false, "L")

        drawText("---", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText("------", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
        drawText("AVAILABLE RUNWAYS", 4, 11, MCDU_WHITE, SIZE.HEADER, false, "L")
        drawText("------", 10, 12, MCDU_WHITE, SIZE.OPTION, false, "L")



    elseif PAGE_STATE == 2 then
        DPT_PROCEDURE = getDepartureProcedures(DEPARTURE_AIRPORT, SELECTED_RUNWAY)
        SIDS = {
        }
        for i in ipairs(DPT_PROCEDURE) do
            if not table.contains(SIDS, string.sub(DPT_PROCEDURE[i], 4, string.find(DPT_PROCEDURE[i],",",6)-1)) then
                table.insert(SIDS, #SIDS+1, string.sub(DPT_PROCEDURE[i], 4, string.find(DPT_PROCEDURE[i],",",6)-1))
            end
        end

        sidListInput()
        wrap(SIDS, SID_SHIFT)
        processSidSelect(SIDS)
        if #SIDS < 4 then
            for i=4, 4-#SIDS, -1 do
                table.insert(SIDS, i, " ")
            end
        end
        for i=1, 4 do
            if SIDS[i] ~= " " then
                drawText("<"..SIDS[i], 1, i+1, MCDU_BLUE, SIZE.OPTION, false, "L", true, "O")
            end
        end
        drawText(SELECTED_RUNWAY, 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText("------", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
        drawText("------", 10, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText("AVAILABLE SIDS", 5, 11, MCDU_WHITE, SIZE.HEADER, false, "L")
    elseif PAGE_STATE == 3 then
        drawText(SELECTED_RUNWAY, 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText(SELECTED_DPT_SID, 10, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText("------", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
        drawText("INSERT*", 24, 2, MCDU_ORANGE, SIZE.OPTION, false, "R")
    else
        drawText(SELECTED_RUNWAY, 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText(SELECTED_DPT_SID, 12, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText(SELECTED_TRANS, 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
    end
    -- Draw text_fields
    drawText("RWY", 1, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("SID", 11, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("TRANS", 24, 13, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("DEPARTURE FROM "..DEPARTURE_AIRPORT, 3, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
end

--TODO: FIX VISIBILITY OF SIDS FROM SPECIFIC RUNWAYS