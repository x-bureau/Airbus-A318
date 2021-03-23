
local isUpdating = false
local updateComplete = false

local isUpdating = false
local updateComplete = false

function drawOptions()
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    if not isUpdating and not updateComplete then
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "UPDATE*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
    else
        if updateComplete == false then
            sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "UPDATING...", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
        else
            sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "UPDATE FINISHED", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
        end
    end
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[1], "FIXES:", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[1], "AUTHOR: @"..UPDATE_METADATA.author, mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[2])
    for i = 1, table.getn(UPDATE_METADATA.fixes), 1 do
        if i > 4 then break end
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[i + 1], "- "..UPDATE_METADATA.fixes[i]:sub(2), mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
    end
end

function acf_update_key_info(side, key)
    if side == 'l' then
        if key == 6 then
            set(MCDU_CURRENT_PAGE, 0)
        end
    else
        if key == 6 then
            isUpdating = true
            updateLuaFiles()
            updateComplete = true
        end
    end
end

function update_acf_update()
end

function draw_acf_update()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "X-BUREAU UPDATE: "..UPDATE_METADATA.version, title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawOptions()
end
