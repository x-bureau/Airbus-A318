
-------------------------------------------------------
-- GLOBAL PROPERTIES

mcdu_origin = createGlobalPropertys("A318/flightInfo/origin_airport", "")
mcdu_destination = createGlobalPropertys("A318/flightInfo/destination_airport", "")
cost_index = createGlobalPropertyi("A318/cockpit/mcdu/data/cost_index", 0)
cruise_fl = createGlobalPropertyi("A318/cockpit/mcdu/data/cruise_fl", 0)
zfw = createGlobalPropertyf("A318/cockpit/mcdu/data/zfw", 0)

-------------------------------------------------------
-- SIM DATAREFS
tropo_temp = globalPropertyf("sim/weather/temperature_tropo_c")
gnd_temp = globalPropertyf("sim/weather/temperature_sealevel_c")
-------------------------------------------------------
local AIRAC_CYCLE = ""

-------------------------------------------------------
-- PAGE CALLS

PAGE_CALLS = {
    [0] = {draw_mcdu_menu, update_mcdu_menu, mcdu_menu_key_input},
    [10] = {draw_acf_info, update_acf_info, acf_info_key_input},
    [11] = {draw_init, update_init, init_key_input},
    [112] = {draw_init_b, update_init_b, init_b_key_input},
    [2] = {draw_data_index, update_data_index, data_index_input}
}
-------------------------------------------------------

function getAiracCycle()
    -- don't loop through file if value already exists
    if AIRAC_CYCLE == "" then
        local path = getXPlanePath() --gets the xplane path
        local file = io.open(path.."/Custom Data/cycle_info.txt", "r")
        local result = ""
        if file ~= nil  then
            for line in file:lines() do
                if string.match(line, "AIRAC") then
                    for token in string.gmatch(line, "[^%s]+") do
                        result = token
                    end
                    break
                end
            end
            if result ~= nil then
                AIRAC_CYCLE = result
                return AIRAC_CYCLE
            end
        end
        file = io.open(path.."/Resources/default data/earth_nav.dat", "r")
        isFound = false
        for line in file:lines() do
            if string.match(line, "cycle") then
                for token in string.gmatch(line, "[^%s]+") do
                    result = token
                    if isFound then
                        break
                    end
                    if result == "cycle" then
                        isFound = true
                    end
                end
            end
        end
        AIRAC_CYCLE = result:sub(1, 4)
        return AIRAC_CYCLE
    else
        -- if we have found the airac cycle before then don't look it up again
        return AIRAC_CYCLE
    end
end

function drawBrackets(side, key, size)
    local bracs = "["
    for i = 1, size, 1 do
        bracs = bracs.." "
    end
    bracs = bracs.."]"
    if side == 'l' then
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[key], bracs, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
    else
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[key], bracs, mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[3])
    end
end

function drawBoxes(side, key, size)
    if side == 'l' then
        local sep = 16
        local length = sep * size
        local height = 20
        local x = 10
        local y = mdcu_positons[key] - 2
        sasl.gl.drawFrame(x, y, length, height, mcdu_colors.box)
        for i = 1, size - 1, 1 do
            x = x + sep
            sasl.gl.drawLine(x, y, x, y + height, mcdu_colors.box)
        end
    else

    end
end

function drawBoxesWithSlash(side, key, size, slashIndex, type)
    -- TODO: CLEAN THIS TF UP
    local slash = "/"
    if type == 1 then
        slash = "."
    end
    local x = 10
    if side == 'r' then x = 469 end
    local sep = 16
    local length = sep * (slashIndex - 1)
    local height = 20
    if side == 'r' then
        x = 469 - (sep * size)
    end
    local y = mdcu_positons[key] - 2
    sasl.gl.drawFrame(x, y, length, height, mcdu_colors.box)
    for i = 1, slashIndex - 1, 1 do
        x = x + sep
        sasl.gl.drawLine(x, y, x, y + height, mcdu_colors.box)
    end
    sasl.gl.drawText(MCDU_FONT_BOLD, x + 2, mdcu_positons[key] - 1, slash, mcdu_option_size - 3, false, false, TEXT_ALIGN_LEFT, mcdu_colors.box)
    x = x + sep
    if side == 'r' then
        x = 469 - (sep * (size - slashIndex))
    end
    length = sep * (size - slashIndex)
    sasl.gl.drawFrame(x, y, length, height, mcdu_colors.box)
    for i = 1, slashIndex - 2, 1 do
        x = x + sep
        sasl.gl.drawLine(x, y, x, y + height, mcdu_colors.box)
    end
end

function drawBlanks(side, key, blanks)
    if side == 'l' then
        sasl.gl.drawText(MCDU_FONT_BOLD, 10, mdcu_positons[key], blanks, mcdu_option_size - 5, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    else
        sasl.gl.drawText(MCDU_FONT_BOLD, 469, mdcu_positons[key], blanks, mcdu_option_size - 5, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    end
end

function isOptionEmpty(option)
    if option[2] == "" then
        return true
    end
    return false
end


function checkICAO(icao)
    local path = getXPlanePath() --gets the xplane path
    local file = io.open(path.."/Custom Data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        return true
    end
    print("not found in og directory")
    file = io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        return true
    end
    return false
end

function createTokens(str, separator)
    local tokens = {}
    for token in string.gmatch(str, "[^%"..separator.."]+") do
        table.insert(tokens, token)
    end
    return tokens
end

function drawStaticTitles(titles)
    for i = 1, table.getn(titles), 1 do
		local title = titles[i]
		if title[2] == 'l' then
			sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[title[3]], title[1], option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
		else
			sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[title[3]], title[1], option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
		end
	end
end

function drawStaticTitlesKeyValue(data) 
    for key, value in pairs(data) do
        local title = value
		if title[3] == 'l' then
			sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[title[4]], title[1], option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
		else
			sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[title[4]], title[1], option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
		end
    end
end



