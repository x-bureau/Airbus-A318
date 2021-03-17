local AIRAC_CYCLE = ""


function getAiracCycle()
    -- don't loop through file if value already exists
    if AIRAC_CYCLE == "" then
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
end

function drawBlanks(side, key, blanks)
    if side == 'l' then
        sasl.gl.drawText(MCDU_FONT_BOLD, 10, mdcu_positons[key], blanks, mcdu_option_size - 5, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end
end

function isOptionEmpty(option)
    if option[2] == "" then
        return true
    end
    return false
end