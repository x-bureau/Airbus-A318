
-------------------------------------------------------
-- DATAREFS

mcdu_origin = createGlobalPropertys("A318/flightInfo/origin_airport", "")
mcdu_destination = createGlobalPropertys("A318/flightInfo/destination_airport", "")
cost_index = createGlobalPropertyi("A318/cockpit/mcdu/data/cost_index", 0)

-------------------------------------------------------
local AIRAC_CYCLE = ""


function getAiracCycle()
    -- don't loop through file if value already exists
    if AIRAC_CYCLE == "" then
        print("reading AIRAC cycle")
        local path = getXPlanePath() --gets the xplane path
        local file = io.open(path.."/Custom Data/cycle_info.txt", "rb")
        local result = ""
        for line in file:lines() do
            if string.match(line, "AIRAC") then
                for token in string.gmatch(line, "[^%s]+") do
                    result = token
                end
                break;
            end
        end
        AIRAC_CYCLE = result
        print("Found AIRAC Cycle: ", result)
        return result
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

function drawBoxesWithSlash(side, key, size, slashIndex)
    -- TODO: CLEAN THIS TF UP
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
    sasl.gl.drawText(MCDU_FONT, x + 2, mdcu_positons[key] - 1, "/", mcdu_option_size - 3, false, false, TEXT_ALIGN_LEFT, mcdu_colors.box)
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
    file = io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        return true
    end
    return false
end