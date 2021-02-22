include("efb/widgets/Textfield.lua")
include("efb/widgets/Checkbox.lua")
include("efb/widgets/BasicButton.lua")

position = {0, 0, PAGE_WIDTH, PAGE_HEIGHT}
size = {PAGE_WIDTH, PAGE_HEIGHT}

local metar_field = Textfield:new(55, PAGE_HEIGHT - 200 + 100, 60, 20, "", false)
local activeField = nil
local buttonTest = BasicButton:new(10, 10, 100, 50, SYSTEM_COLORS.FRONT_GREEN, "Test")

function drawMETARBox()
    -- get active metar from any given ICAO
    sasl.gl.drawFrame(40, PAGE_HEIGHT - 150, PAGE_WIDTH - 80, 100, SYSTEM_COLORS.FRONT_GREEN)
end

function onMouseDown(component, x, y, button, parentX, parentY)
    if get(activePage) == 3 then
        if button == MB_LEFT then
            if isInRect({metar_field.x, metar_field.y, metar_field.width, metar_field.height}, x, y) then
                metar_field:setActive()
                activeField = metar_field
            end
            if isInRect({10, 10, 100, 50}, x, y) then
                print("pressed")
            end
        end
    end
    return true
end

function onKeyDown ( component , char , key , shDown , ctrlDown , altOptDown )
    if get(activePage) == 3 then
        if activeField == nil then
            -- do nothing
        else 
            if char == 13 then
                print(getMETAR(activeField:getText()))
            elseif char == 8 then
                activeField:removeLetter()
            else
                activeField:addLetter(string.upper(string.char(char)))
            end
        end
    end
    return true
end

function draw()
    if get(activePage) == 3 then
        drawMETARBox()
        metar_field:drawField() --temporary
        buttonTest:drawButton()
    end
end