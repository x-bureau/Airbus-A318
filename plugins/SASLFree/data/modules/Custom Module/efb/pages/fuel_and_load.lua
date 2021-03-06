require 'efb.widgets.Checkbox'
require 'efb.widgets.Textfield'

PAGE_WIDTH = 902
PAGE_HEIGHT = 637 - 70

local totalFuel = globalPropertyf("sim/flightmodel/weight/m_fuel_total")
local center_tank = globalPropertyf("sim/flightmodel/weight/m_fuel1")
local totalWeight = globalPropertyf("sim/flightmodel/weight/m_total") --read only

local pax_field = Textfield:new(217, 415, 87, 25, "", false)
local cargo_field = Textfield:new(217, 365, 87, 25, "", false)
local block_fuel_field = Textfield:new(217, 315, 87, 25, "", false)
local fields = {pax_field, cargo_field, block_fuel_field}
local widgets_set = false
local activeField = nil

local gpuCheckBox = Checkbox:new(PAGE_WIDTH - 505, 416, 25, false)
local fuelTruckCheckBox = Checkbox:new(PAGE_WIDTH - 505, 366, 25, false)
local chocksCheckBox = Checkbox:new(PAGE_WIDTH - 505, 316, 25, false)
local paxBusCheckBox = Checkbox:new(PAGE_WIDTH - 505, 266, 25, false)
local checkboxes = {gpuCheckBox, fuelTruckCheckBox, chocksCheckBox, paxBusCheckBox}

-- CLICK HANDLING

function handleFuelLoadClick(x, y)
    for i = 1, table.getn(checkboxes), 1 do
        local box = checkboxes[i]
        if isInRect({box.x, box.y, box.size, box.size}, x, y) then
            box:click()
        end
    end
    setFieldsInactive(fields)
    activeField = nil
    for i = 1, table.getn(fields), 1 do
        local field = fields[i]
        if isInRect({field.x, field.y, field.width, field.height}, x, y) then
            field:setActive()
            activeField = field
        end
    end
end

function handleFuelLoadKey(char)
    if activeField == nil then
        -- do something
    else
        if char == 8 then
            activeField:removeLetter()
        elseif char == 13 then
            setFieldsInactive(fields)
            activeField = nil
        else
            activeField:addLetter(string.char(char))
        end
    end
end

function test()
    print("Hello, world!")
end

-- SECONDARY DRAW FUNCTIONS

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


-- MAIN DRAW LOOP

function drawFuelLoadPage() 
    drawFuelAndLoad()
    drawGroundHandling()
    for i = 1, table.getn(checkboxes), 1 do
        drawCheckBox(checkboxes[i])
    end
    for i = 1, table.getn(fields), 1 do
        drawTextField(fields[i])
    end
end

