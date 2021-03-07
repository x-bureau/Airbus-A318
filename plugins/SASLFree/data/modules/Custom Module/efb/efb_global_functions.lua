require 'efb.widgets.Checkbox'
local buttonY = 567
local buttonHeight = 70
local default_field_color = {42/255, 58/255, 80/255, 1.0}

local avitab_enabled = globalProperty("avitab/panel_enabled")
local avitab_powered = globalProperty("avitab/panel_powered")

function checkMenuClick(x, y)
    if isInRect({482, buttonY, buttonHeight, buttonHeight}, x, y) then
        set(activePage, 1)
        set(avitab_enabled, 0)
    elseif isInRect({552, buttonY, buttonHeight, buttonHeight}, x, y) then
        set(activePage, 2)
        set(avitab_enabled, 0)
    elseif isInRect({622, buttonY, buttonHeight, buttonHeight}, x, y) then
        -- perf calc
        set(activePage, 3)
        set(avitab_enabled, 0)
    elseif isInRect({692, buttonY, buttonHeight, buttonHeight}, x, y) then
        --avitab integration
        set(activePage, 4)
        set(avitab_powered, 1)
        set(avitab_enabled, 1)
    elseif isInRect({762, buttonY, buttonHeight, buttonHeight}, x, y) then
        set(activePage, 1)
        set(avitab_enabled, 0)
    elseif isInRect({832, buttonY, buttonHeight, buttonHeight}, x, y) then
        set(activePage, 1)
        set(avitab_enabled, 0)
    end
end

function drawCheckBox(box)
    sasl.gl.drawFrame(box.x, box.y, box.size, box.size, SYSTEM_COLORS.FRONT_GREEN)
    if box.isEnabled == true then
        local inset = 3
        local newSize = box.size - (2 * inset)
        sasl.gl.drawRectangle(box.x + inset, box.y + inset, newSize - 1, newSize - 1, SYSTEM_COLORS.FRONT_GREEN)
    end
end

function drawTextField(field)
    sasl.gl.drawRectangle(field.x, field.y, field.width, field.height, default_field_color)
    if field.isActive == true then
        sasl.gl.drawFrame(field.x, field.y, field.width, field.height, SYSTEM_COLORS.FRONT_GREEN)
    end
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_REGULAR, field.x + (field.width / 2), field.y + (field.height / 2) - 5, field.text, 15, false, false, TEXT_ALIGN_CENTER, SYSTEM_COLORS.FRONT_GREEN)
end

function setFieldsInactive(fields)
    for i = 1, table.getn(fields), 1 do
        fields[i]:setInactive()
    end
end

function getMETAR(icao)
    local path = getXPlanePath() --gets the xplane path
    local file = io.open(path.."METAR.rwx", "r+")
    local metar = ""
    for line in file:lines() do
        if string.match(line, icao) then
            metar = line
        end
    end
    return metar
end