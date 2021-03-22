-- PAGE KEY: 3

local options = {
    co_route = {"CO-ROUTE", "", 'l', 1},
    alt_route = {"ALT-ROUTE", "", 'l', 2},
    flt_nmbr = {"FLT NBR", "", 'l', 3},
    cost_index = {"COST INDEX", "", 'l', 5},
    crz_flt_temp = {"CRZ FL/TEMP", "", 'l', 6},
    from_to = {"FROM/TO", "", 'r', 1},
    tropo = {"TROPO", "36090", 'r', 5},
    gnd_temp = {"GND TEMP", "", 'r', 6}
}

local initialInfoFilled = false

local function processFltNbr()
    if string.len(SCRATCHPAD) == 0 then
        displayError("INVALID FORMAT")
    else
        options.flt_nmbr[2] = SCRATCHPAD
    end
end


local function processFromTo()
    local entry = SCRATCHPAD
    if string.len(entry) == 5 then
        if entry:sub(5, 5) == "/" then
            local origin = createTokens(entry, "/")[1]
            print(origin)
            if checkICAO(origin) then 
                set(mcdu_origin, origin) 
            end
        elseif entry:sub(1, 1) == "/" then
            local dest = createTokens(entry, "/")[1]
            if checkICAO(dest) then 
                set(mcdu_destination, dest) 
            end
        end
    else
        if string.len(entry) < 8 then
            displayError("INVALID FORMAT")
        else
            print(string.len(entry))
            local origin = entry:sub(1, 4)
            local destination = entry:sub(5, 8)
            if string.match(entry, "/") and string.len(entry) == 9 then
                local tokens = createTokens(entry, "/")
                origin = tokens[1]
                print(tokens[1])
                destination = tokens[2]
            end
            if checkICAO(origin) == false or checkICAO(destination) == false then
                displayError("AIRPORT NOT FOUND IN DATABASE")
            else
                set(mcdu_origin, origin)
                set(mcdu_destination, destination)
            end
        end
    end
end

local function processCostIndex()
    if initialInfoFilled then
        local indx = tonumber(SCRATCHPAD)
        if indx == nil then
            displayError("INVALID FORMAT")
        else
            if indx < 1 or indx > 999 then
                displayError("INVALID COST INDEX")
            else
                set(cost_index, indx)
            end
        end 
    end
end

local function processFlightLevel()
    if initialInfoFilled then
        local entry = SCRATCHPAD
        if string.len(entry) == 3 then
            -- just flight level
            local fl = tonumber(entry)
            if fl ~= nil then
                set(cruise_fl, fl)
            else
                displayError("INVALID FORMAT")
            end
        elseif string.len(entry) == 5 then
            local fl = tonumber(entry)
            print(fl)
            if fl ~= nil then
                set(cruise_fl, math.floor(fl / 1000))
            elseif string.match(entry, "FL") then
                local newFL = tonumber(entry:sub(3, 5))
                print(newFL)
                if newFL ~= nil then
                    set(cruise_fl, newFL)
                else
                    displayError("INVALID FORMAT")
                end
            end
        else
            displayError("INVALID ENTRY")
        end
    end
end

local function process_gnd_temp()
    if initialInfoFilled then
        options.gnd_temp[2] = ""..math.floor(get(gnd_temp)).."°"
    end
end

local function processInitRequest()
    if parseFMS(options.co_route[2], 0) ~= false then
        parseFMS(options.co_route[2], 1)
    else
        displayError("FLIGHTPLAN NOT FOUND")
    end
end


function init_key_input(side, key)
    if side == 'l' then
        if key == 1 then
            --displayError("INOP - COMING SOON")
            options.co_route[2] = SCRATCHPAD
        end
        if key == 3 then
            processFltNbr()
        end
        if key == 4 then
            set(MCDU_CURRENT_PAGE, 112)
        end
        if key == 5 then
            processCostIndex()
        end
        if key == 6 then
            processFlightLevel()
        end
    else
        if key == 1 then
            processFromTo()
        end
        if key == 2 then
            processInitRequest()
        end
        if key == 3 then
            if initialInfoFilled then
                set(MCDU_CURRENT_PAGE, 113)
            end
            
            set(MCDU_CURRENT_PAGE, 113) -- TODO: Remove after testing
        end
        if key == 6 then
            process_gnd_temp()
        end
    end
end

local function drawStaticTitles()
    for key, value in pairs(options) do
        if value[3] == 'l' then
            sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[value[4]], value[1], option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        else
            sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[value[4]], value[1], option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
        end
    end
    if initialInfoFilled then
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[3], "IRS INIT>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    end
    if not isOptionEmpty(options.co_route) then
        sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[2], "INIT", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_colors.box)
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[2], "REQUEST*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_colors.box)
    end
    
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[4], "WIND>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
end

local function drawFields()
    for key, value in pairs(options) do
        if value[2] ~= "" then
            if value[3] == 'l' then
                sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
            else
                sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[3])
            end
        end
    end
    if isOptionEmpty(options.co_route) then
        drawBoxes('l', 1, 7)
    end
    if isOptionEmpty(options.alt_route) then
        drawBlanks('l', 2, "––––/––––––––––")
    end
    if isOptionEmpty(options.flt_nmbr) then
        drawBoxes('l', 3, 8)
    end
    if isOptionEmpty(options.cost_index) then
        if initialInfoFilled then
            drawBoxes('l', 5, 3)
        else
            drawBlanks('l', 5, "–––")
        end
    end
    if isOptionEmpty(options.crz_flt_temp) then
        if initialInfoFilled then
            drawBoxesWithSlash('l', 6, 10, 6, 0)
        else
            drawBlanks('l', 6, "––––– /–––°")
        end
    end
    if isOptionEmpty(options.from_to) then
        drawBoxesWithSlash('r', 1, 9, 5, 0)
    end
    if isOptionEmpty(options.gnd_temp) then
        drawBlanks('r', 6, "–––°")
    end
end

function update_init()
    if get(mcdu_destination) ~= "" or get(mcdu_origin) ~= "" then
        options.from_to[2] = get(mcdu_origin).."/"..get(mcdu_destination)
        initialInfoFilled = true
    end
    if get(cost_index) ~= 0 then
        options.cost_index[2] = ""..get(cost_index)
    end
    if get(cruise_fl) ~= 0 then
        options.crz_flt_temp[2] = "FL"..get(cruise_fl).."/"..math.floor(get(tropo_temp)).."°"
    end
end

function draw_init()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "INIT", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawStaticTitles()
    drawFields()
end