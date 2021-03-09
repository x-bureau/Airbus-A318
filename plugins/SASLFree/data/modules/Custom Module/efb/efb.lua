include("efb/pages/fuel_and_load.lua")
include("efb/pages/perf_calc.lua")
include("efb/pages/flight_summary.lua")
include("efb/efb_global_functions.lua")

WIDTH = 902
HEIGHT = 637

position = {1090, 1197, WIDTH, HEIGHT}
size = {WIDTH, HEIGHT}

MENU_POSITION = {
    x = 0,
    y = HEIGHT - 70,
    width = WIDTH,
    height = 70
}

activePage = globalPropertyf("A318/efb/config/activePage")

PAGE_DRAW_CALLS = {
    drawFlightSummary,
    drawFuelLoadPage,
    drawPerfCalc
}

PAGE_HANDLE_CLICK = {
    handle_flight_summary_click,
    handleFuelLoadClick,
    handlePerfCalcClick
}

PAGE_HANDLE_KEY = {
    handle_flight_summary_key,
    handleFuelLoadKey,
    handlePerfCalcKey
}

SYSTEM_COLORS = {
    BG_BLUE = {52/255, 73/255, 102/255, 1.0},
    FRONT_GREEN = {9/255, 188/255, 138/255, 1.0},
    BUTTON_SELECTED = {7/255, 157/255, 114/255, 1.0}
}

SYSTEM_FONTS = {
    ROBOTO_REGULAR = sasl.gl.loadFont("fonts/Roboto-Regular.ttf"),
    ROBOTO_BOLD = sasl.gl.loadFont("fonts/Roboto-Bold.ttf")
}

local logo = sasl.gl.loadImage("efb/icons/xb_logo.png")
local BUTTON_LENGTH = 70
SYSTEM_ICONS = {
    sasl.gl.loadImage("efb/icons/flight.png"),
    sasl.gl.loadImage("efb/icons/fuel_load.png"),
    sasl.gl.loadImage("efb/icons/perf_calc.png"),
    sasl.gl.loadImage("efb/icons/map.png"),
    sasl.gl.loadImage("efb/icons/checklist.png"),
    sasl.gl.loadImage("efb/icons/gear.png")
}

function onMouseDown(component, x, y, button, parentX, parentY)
    if button == MB_LEFT then
        checkMenuClick(x, y)
        if get(activePage) ~= 4 then
            PAGE_HANDLE_CLICK[get(activePage)](x, y)
        end
    end
end

function onKeyDown ( component , char , key , shDown , ctrlDown , altOptDown )
    if get(activePage) ~= 4 then
        PAGE_HANDLE_KEY[get(activePage)](char)
    end
    return true
end

-- function onMouseMove(component, x, y, button, parentX, parentY)
--     efb_cursor.x = x
--     efb_cursor.y = y
-- end

function drawMenuBar()
    sasl.gl.drawWideLine(0, MENU_POSITION.y, WIDTH, MENU_POSITION.y, 3, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 125, MENU_POSITION.y + 22, "A318 EFB", 36, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawTexture(logo, 10, MENU_POSITION.y - 20, 100, 100)
    local x = WIDTH-420
    local y = MENU_POSITION.y
    for i = 1, 6 do
        if i == get(activePage) then
            sasl.gl.drawRectangle(x, y, BUTTON_LENGTH, BUTTON_LENGTH, SYSTEM_COLORS.BUTTON_SELECTED)
        else
            sasl.gl.drawRectangle(x, y, BUTTON_LENGTH, BUTTON_LENGTH, SYSTEM_COLORS.FRONT_GREEN)
        end
        sasl.gl.drawTexture(SYSTEM_ICONS[i], x + 15, y + 15, 40, 40)
        x = x + BUTTON_LENGTH
    end
end

function draw()
    sasl.gl.drawRectangle(0, 0, WIDTH, HEIGHT, SYSTEM_COLORS.BG_BLUE)
    drawMenuBar()
    if get(activePage) ~= 4 then
        PAGE_DRAW_CALLS[get(activePage)]()
    else
        local bgColor = {64/255, 64/255, 64/255, 1.0}
        sasl.gl.drawRectangle(0, 0, WIDTH, HEIGHT - 71, bgColor)
    end
end