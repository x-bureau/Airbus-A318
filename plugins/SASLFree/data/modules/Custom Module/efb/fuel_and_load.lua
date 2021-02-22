include("efb/widgets/Textfield.lua")
include("efb/widgets/Checkbox.lua")

position = {0, 0, PAGE_WIDTH, PAGE_HEIGHT}
size = {PAGE_WIDTH, PAGE_HEIGHT}

local totalFuel = globalPropertyf("sim/flightmodel/weight/m_fuel_total")
local center_tank = globalPropertyf("sim/flightmodel/weight/m_fuel1")
local totalWeight = globalPropertyf("sim/flightmodel/weight/m_total") --read only

local pax_field = Textfield:new(217, 415, 87, 25, "", false)
local cargo_field = Textfield:new(217, 365, 87, 25, "", false)
local block_fuel_field = Textfield:new(217, 315, 87, 25, "", false)
local fields = {pax_field, cargo_field, block_fuel_field}
local field_locs = {}
local widgets_set = false
local activeField = nil

local gpuCheckBox = Checkbox:new(PAGE_WIDTH - 505, 416, 25, false)
local fuelTruckCheckBox = Checkbox:new(PAGE_WIDTH - 505, 366, 25, false)
local chocksCheckBox = Checkbox:new(PAGE_WIDTH - 505, 316, 25, false)
local paxBusCheckBox = Checkbox:new(PAGE_WIDTH - 505, 266, 25, false)
local checkboxes = {gpuCheckBox, fuelTruckCheckBox, chocksCheckBox, paxBusCheckBox}
local checkboxes_locs = {}

function drawWidgets()
    if widgets_set == false then
        setWidgetLocs()
        widgets_set = true
    end
    for i = 1, table.getn(fields), 1 do
        fields[i]:drawField()
    end
    for i = 1, table.getn(checkboxes), 1 do
        checkboxes[i]:drawBox()
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

function setWidgetLocs() 
    print("setting text field location")
    for i = 1, table.getn(fields), 1 do
        table.insert(field_locs, {fields[i].x, fields[i].y, fields[i].width, fields[i].height})
    end

    for i = 1, table.getn(checkboxes), 1 do
        table.insert(checkboxes_locs, {checkboxes[i].x, checkboxes[i].y, checkboxes[i].size, checkboxes[i].size})
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
            for i = 1, table.getn(checkboxes), 1 do
                if isInRect(checkboxes_locs[i], x, y) then
                    checkboxes[i]:setEnabled(not checkboxes[i].isEnabled)
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

function drawFuelAndLoad()
    sasl.gl.drawFrame(40, 50, 300, PAGE_HEIGHT - 100, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 480, "FUEL AND LOAD", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 420, "PAX", 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 370, "CARGO", 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 320, "BLOCK FUEL", 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)

    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 310, 420, get_weight_label(), 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 310, 370, get_weight_label(), 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 310, 320, get_weight_label(), 17, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    
    sasl.gl.drawRectangle(60, 65, 250, 40, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 183, 79, "LOAD PLANE", 20, false, false, TEXT_ALIGN_CENTER, SYSTEM_COLORS.BG_BLUE)
end

function drawGroundHandling()
    sasl.gl.drawFrame(380, 250, PAGE_WIDTH - 420, PAGE_HEIGHT - 300, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH - 505, 480, "GROUND HANDLING", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH - 465, 420, "GPU", 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH - 465, 370, "FUEL TRUCK", 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH - 465, 320, "CHOCKS", 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH - 465, 270, "PASSENGER BUS", 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
end

function draw() 
    if get(activePage) == 2 then
        drawFuelAndLoad()
        drawGroundHandling()
        drawWidgets()
    end
end

