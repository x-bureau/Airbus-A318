include("efb/widgets/Textfield.lua")

position = {0, 0, PAGE_WIDTH, PAGE_HEIGHT}
size = {PAGE_WIDTH, PAGE_HEIGHT}

local totalFuel = globalPropertyf("sim/flightmodel/weight/m_fuel_total")
local center_tank = globalPropertyf("sim/flightmodel/weight/m_fuel1")
local totalWeight = globalPropertyf("sim/flightmodel/weight/m_total") --read only

local pax_field = Textfield:new(225, 415, 87, 25, "", false)
local cargo_field = Textfield:new(225, 365, 87, 25, "", false)
local block_fuel_field = Textfield:new(225, 315, 87, 25, "", false)

local fields = {pax_field, cargo_field, block_fuel_field}
local field_locs = {}
local fieldsSet = false
local activeField = nil

function drawFields()
    if fieldsSet == false then
        setFieldLocs()
        fieldsSet = true
    end
    for i = 1, table.getn(fields), 1 do
        fields[i]:drawField()
        if fields[i].isActive == true then
            sasl.gl.drawFrame(field_locs[i][1], field_locs[i][2], field_locs[i][3], field_locs[i][4], SYSTEM_COLORS.FRONT_GREEN)
        end
    end
end

function setWidgetsInactive()
    -- sets all active widgets on this page to inactive state
    -- set fields inactive
    for i = 1, table.getn(fields), 1 do
        fields[i]:setInactive()
    end
    activeField = nil
end

function setFieldLocs() 
    print("setting text field location")
    for i = 1, table.getn(fields), 1 do
        table.insert(field_locs, {fields[i].x, fields[i].y, fields[i].width, fields[i].height})
    end
end

function onMouseDown(component, x, y, button, parentX, parentY)
    if get(activePage) == 2 then
        if button == MB_LEFT then
            setWidgetsInactive()
            for i = 1, table.getn(fields), 1 do
                if isInRect(field_locs[i], x, y) then
                    if fields[i].isActive == false then
                        fields[i]:setActive()
                        activeField = fields[i]
                    end
                end
            end
        end
    end
end

function onKeyDown ( component , char , key , shDown , ctrlDown , altOptDown )
    if get(activePage) == 2 then
        if activeField == nil then
            -- do nothing
        else 
            if tonumber(string.char(char)) then
                activeField:addLetter(string.char(char))
            end
            if char == 8 then
                activeField:removeLetter()
            end
            if char == 13 then
                setWidgetsInactive()
            end
        end
    end
    return true
end

function draw() 
    if get(activePage) == 2 then
        sasl.gl.drawFrame(40, 50, 300, PAGE_HEIGHT - 100, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 480, "FUEL AND LOAD", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 420, "PAX", 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 370, "CARGO", 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 320, "BLOCK FUEL", 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawRectangle(60, 65, 250, 40, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 183, 79, "LOAD PLANE", 20, false, false, TEXT_ALIGN_CENTER, SYSTEM_COLORS.BG_BLUE)
        sasl.gl.drawFrame(380, 50, PAGE_WIDTH - 420, PAGE_HEIGHT - 100, SYSTEM_COLORS.FRONT_GREEN)
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH - 505, 480, "GROUND HANDLING", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
        drawFields()
    end
end

