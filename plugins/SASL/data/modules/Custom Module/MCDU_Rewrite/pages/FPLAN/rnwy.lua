local MCDU_BLUE = {0.0, 0.7, 0.8, 1.0}

SELECTED_RUNWAY = ""
SELECTED_DPT_SID = ""
SELECTED_DPT_TRANS = ""

local PAGE_STATE = 1

local SHIFT = 0
local SID_SHIFT = 0
local TRANS_SHIFT = 0

local function runwayListInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and #(RwyList) > 4 and SHIFT > 0 then
        SHIFT = SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(RwyList) > 4 and SHIFT < #RwyList-4 then
        SHIFT = SHIFT + 1
    else
        SHIFT = SHIFT
    end
end

local function sidListInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and #(SIDS) > 4 and SID_SHIFT > 0 then
        SID_SHIFT = SID_SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #(SIDS) > 4 and SID_SHIFT < #SIDS-4 then
        SID_SHIFT = SID_SHIFT + 1
    else
        SID_SHIFT = SID_SHIFT
    end
end

local function transListInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and #TRANS > 4 and SID_SHIFT > 0 then
        TRANS_SHIFT = TRANS_SHIFT - 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and #TRANS > 4 and SID_SHIFT < #TRANS-4 then
        TRANS_SHIFT = TRANS_SHIFT + 1
    else
        TRANS_SHIFT = TRANS_SHIFT
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

local function processTransSelect()
    if get(MCDU_CURRENT_BUTTON) > 0 and get(MCDU_CURRENT_BUTTON) < 6 then
        local val = get(MCDU_CURRENT_BUTTON) -- We determine what the index is of the airport aligned with the selected button
        SELECTED_DPT_TRANS = TRANS[val]
        PAGE_STATE = 4
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


    if PAGE_STATE == 1 then
        RwyList = getAirportRunways(DEPARTURE_AIRPORT) -- we get the runways
        runwayListInput()
    
        processRnwyInput()

        wrap(RwyList, SHIFT) -- IMPLEMENTING SCROLLING
        processRwySelect(RwyList)

        --DRAW RUNWAY OPTIONS
        for i=1, math.min(4,#RwyList) do
            if RwyList[i] ~= " " then
                drawText("<"..RwyList[i]:sub(3), 1, i+1, MCDU_BLUE, SIZE.OPTION, false, "L", true, "O")
            end
        end
        drawText("---", 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText("------", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
        drawText("AVAILABLE RUNWAYS", 4, 11, MCDU_WHITE, SIZE.HEADER, false, "L")
        drawText("------", 10, 12, MCDU_WHITE, SIZE.OPTION, false, "L")



    elseif PAGE_STATE == 2 then
        SIDS = getDepartureProcedures(DEPARTURE_AIRPORT, SELECTED_RUNWAY) -- parse CIFP files for SIDS

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
        TRANS = getDptTrans(DEPARTURE_AIRPORT)
        if #TRANS > 0 then
            transListInput()

            wrap(TRANS, TRANS_SHIFT)
            processTransSelect()

            if #TRANS < 4 then
                for i=4, 4-#TRANS, -1 do
                    table.insert(TRANS, i, " ")
                end
            end
            for i=1, math.min(#TRANS,4) do
                if TRANS[i] ~= " " then
                    drawText("<"..TRANS[i], 1, i+1, MCDU_BLUE, SIZE.OPTION, false, "L", true, "O")
                end
            end
        else
            SELECTED_DPT_TRANS = "NONE"
            if get(MCDU_CURRENT_BUTTON) == 26 then
                PAGE_STATE = 4
            elseif get(MCDU_CURRENT_BUTTON) == 24 then
                PAGE_STATE = 3
            end
        end
        drawText(SELECTED_RUNWAY, 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText(SELECTED_DPT_SID, 10, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText("------", 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
        drawText("INSERT*", 24, 2, MCDU_ORANGE, SIZE.OPTION, false, "R")
    elseif PAGE_STATE == 4 then
        drawText(SELECTED_RUNWAY, 1, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText(SELECTED_DPT_SID, 10, 12, MCDU_WHITE, SIZE.OPTION, false, "L")
        drawText(SELECTED_DPT_TRANS, 24, 12, MCDU_WHITE, SIZE.OPTION, false, "R")
        drawText("INSERT*", 24, 2, MCDU_ORANGE, SIZE.OPTION, false, "R")
    end
    -- Draw text_fields
    drawText("RWY", 1, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("SID", 11, 13, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("TRANS", 24, 13, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("DEPARTURE FROM "..DEPARTURE_AIRPORT, 3, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("<RETURN", 1, 2, MCDU_WHITE, SIZE.OPTION, false, "L")
end