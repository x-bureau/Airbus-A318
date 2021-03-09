require 'efb.widgets.Checkbox'
require 'efb.widgets.Textfield'

local metarField = Textfield:new(260, 481, 70, 25, "", false)
local activeField = nil
local METAR = ""
local loadingTimer = sasl.createTimer(1)
local loadingInProgress = false

local fields = {
    metarField
}

function handlePerfCalcClick(x, y)
    for i = 1, table.getn(fields), 1 do
        local field = fields[i]
        if isInRect({field.x, field.y, field.width, field.height}, x, y) then
            field:setActive()
            activeField = field
        end
    end
end

function handlePerfCalcKey(char)
    if activeField == nil then
        -- do nothing
    else
        if char == 8 then
            activeField:removeLetter()
        elseif char == 13 then
            -- TODO: add text wrapping for long METAR string
            -- TODO: add a loading feature when pulling metar data
            if fields[1].isActive then
                sasl.startTimer(1)
                loadingInProgress = true
                METAR = ""
            end
            setFieldsInactive(fields)
            activeField = nil
        else
            activeField:addLetter(string.upper(string.char(char)))
        end
    end
end

function drawPerfCalc()
    sasl.gl.drawFrame(40, 427, 821, 90, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 485, "GET METAR FOR: ", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 445, METAR, 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    if loadingInProgress then
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 445, "loading...", 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    end
    for i = 1, table.getn(fields), 1 do
        drawTextField(fields[i])
    end
    if sasl.getElapsedSeconds(1) > 2 then
        METAR = getMETAR(metarField:getText())
        sasl.stopTimer(1)
        sasl.resetTimer(1)
        loadingInProgress = false
    end
end