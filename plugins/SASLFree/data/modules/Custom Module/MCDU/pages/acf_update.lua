
local isUpdating = false
local updateComplete = false

local phase = 0
local downloadTimer = sasl.createTimer()

function drawOptions()
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    if get(updatePageType) == 0 then
        if phase == 0 then
            sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "UPDATE*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
        elseif phase == 1 then
            sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "CONFIRM UPDATE>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
        elseif phase == 2 then
            sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "DOWNLOADING UPDATE...", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
        elseif phase == 3 then
            sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[6], "INSTALL UPDATE", option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_colors.box)
            sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[6], "REBOOT SYSTEM>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_colors.box)
        end
    end
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[1], "FIXES:", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    if get(updatePageType) == 0 then
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[1], "AUTHOR: @"..UPDATE_METADATA.author, mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[2])
        for i = 1, table.getn(UPDATE_METADATA.fixes), 1 do
            if i > 4 then break end
            sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[i + 1], "- "..UPDATE_METADATA.fixes[i]:sub(2), mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
        end
    else
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[1], "AUTHOR: @"..VERSION_METADATA.author, mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[2])
        for i = 1, table.getn(VERSION_METADATA.fixes), 1 do
            if i > 4 then break end
            sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[i + 1], "- "..VERSION_METADATA.fixes[i]:sub(2), mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
        end
    end
end

function acf_update_key_info(side, key)
    if side == 'l' then
        if key == 6 then
            set(MCDU_CURRENT_PAGE, 0)
        end
    else
        if key == 6 then
            if phase == 0 then
                phase = 1 -- ask for download confirmation
            elseif phase == 1 then
                phase = 2 -- confirm download start
                sasl.startTimer(downloadTimer)
            elseif phase == 3 then
                sasl.scheduleProjectReboot()
            end
        end
    end
end

function update_acf_update()
    if sasl.getElapsedSeconds(downloadTimer) > 3 then
        sasl.stopTimer(downloadTimer)
        sasl.resetTimer(downloadTimer)
        print("starting download")
        updateLuaFiles()
        print("finished download")
        phase = 3
        -- sasl.scheduleProjectReboot()
        --displayError("PLEASE RELOAD AIRCRAFT")
    end
end

function draw_acf_update()
    if get(updatePageType) == 0 then
        sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "UPDATE: "..UPDATE_METADATA.version, title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    else
        sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "VERSION: "..VERSION_METADATA.version, title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    end
    drawOptions()
end
