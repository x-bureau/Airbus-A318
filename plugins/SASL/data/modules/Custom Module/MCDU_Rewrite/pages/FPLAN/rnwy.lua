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

local function processRwySelect(RUNWAYS)
    if get(MCDU_CURRENT_BUTTON) > 0 and get(MCDU_CURRENT_BUTTON) < 6 then
        local val = get(MCDU_CURRENT_BUTTON) -- We determine what the index is of the airport aligned with the selected button
        SELECTED_RUNWAY = RUNWAYS[val]
        PAGE_STATE = 2
    end
end

local function processSidSelect(DPT_PROCEDURE)
    if get(MCDU_CURRENT_BUTTON) > 0 and get(MCDU_CURRENT_BUTTON) < 6 then
        local val = get(MCDU_CURRENT_BUTTON) -- We determine what the index is of the airport aligned with the selected button
        SELECTED_DPT_SID = DPT_PROCEDURE[val]
        print(SELECTED_DPT_SID)
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
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "←"..RwyList[1], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "←"..RwyList[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[4], "←"..RwyList[3], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[5], "←"..RwyList[4], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        drawDashField(mcdu_positions[1],1,3)
        drawDashField(mcdu_positions[1],2,6)
        sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[2]-4, "AVAILABLE RUNWAYS", option_heading_font_size+3, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]+4, "------", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
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
            local amt = 4 - #SIDS
            for i=amt,4-amt,-1 do
                table.insert(SIDS,i,"")
            end
        end
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[2], "←"..SIDS[1], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[3], "←"..SIDS[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[4], "←"..SIDS[3], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[5], "←"..SIDS[4], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1]+4, SELECTED_RUNWAY, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        drawDashField(mcdu_positions[1],2,6)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]+4, "------", mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[2]-4, "AVAILABLE SIDS", option_heading_font_size+3, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    elseif PAGE_STATE == 3 then
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1]+4, SELECTED_RUNWAY, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]+4, SELECTED_DPT_SID, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, 480, mcdu_positions[1]+4, "------", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, 495, mcdu_positions[6], "INSERT*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, MCDU_ORANGE)
    else
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1]+4, SELECTED_RUNWAY, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1]+4, SELECTED_DPT_SID, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]+4, SELECTED_TRANS, mcdu_option_size, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    end
    -- Draw text_fields
    sasl.gl.drawText(MCDU_FONT, 2, option_heading_locations[1]-4, "RWY", option_heading_font_size+3, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[1]-4, "SID", option_heading_font_size+3, false, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, 480, option_heading_locations[1]-4, "TRANS", option_heading_font_size+3, false, false, TEXT_ALIGN_RIGHT, MCDU_WHITE)
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y+20, "DEPARTURE FROM "..DEPARTURE_AIRPORT, title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
end

--TODO: FIX VISIBILITY OF SIDS FROM SPECIFIC RUNWAYS