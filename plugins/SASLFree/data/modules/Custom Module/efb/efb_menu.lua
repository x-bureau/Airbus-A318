position = {0, 567, WIDTH, HEIGHT - 70}
size = {WIDTH, HEIGHT - 70}

local BUTTON_LENGTH = 70
local button_locs = {}
local isButtonLocsSet = false

function drawButtons()
    x = WIDTH-350
    y = 0
    for i = 1, 5 do
        if isButtonLocsSet == false then
            table.insert(button_locs, {x, y, 70, 70})
            print("writing button location")
        end
        if i == get(activePage) then
            sasl.gl.drawRectangle(x, y, BUTTON_LENGTH, BUTTON_LENGTH, SYSTEM_COLORS.BUTTON_SELECTED)
        else
            sasl.gl.drawRectangle(x, y, BUTTON_LENGTH, BUTTON_LENGTH, SYSTEM_COLORS.FRONT_GREEN)
        end
        sasl.gl.drawTexture(SYSTEM_ICONS[i], x + 15, y + 15, 40, 40)
        x = x + BUTTON_LENGTH
    end
    isButtonLocsSet = true
end

function onMouseDown(component, x, y, button, parentX, parentY)
    if button == MB_LEFT then
        for i = 1, table.getn(button_locs) do
            if isInRect(button_locs[i], x, y) then
                set(activePage, i)
            end
        end
    end
end

function draw() 
    sasl.gl.drawWideLine(0, 1.5, WIDTH, 1.5, 3, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 15, 20, "X-Bureau's A318 EFB", 36, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    drawButtons()
end