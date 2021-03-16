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