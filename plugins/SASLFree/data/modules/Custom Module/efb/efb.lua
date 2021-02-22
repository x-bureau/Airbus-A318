WIDTH = 902
HEIGHT = 637

position = {1090, 1197, WIDTH, HEIGHT}
size = {WIDTH, HEIGHT}

PAGE_WIDTH = WIDTH
PAGE_HEIGHT = HEIGHT - 70

activePage = globalPropertyf("A318/efb/config/activePage")


SYSTEM_COLORS = {
    BG_BLUE = {52/255, 73/255, 102/255, 1.0},
    FRONT_GREEN = {9/255, 188/255, 138/255, 1.0},
    BUTTON_SELECTED = {7/255, 157/255, 114/255, 1.0}
}

SYSTEM_FONTS = {
    ROBOTO_REGULAR = sasl.gl.loadFont("fonts/Roboto-Regular.ttf"),
    ROBOTO_BOLD = sasl.gl.loadFont("fonts/Roboto-Bold.ttf")
}

SYSTEM_ICONS = {
    sasl.gl.loadImage("efb/icons/flight.png"),
    sasl.gl.loadImage("efb/icons/fuel_load.png"),
    sasl.gl.loadImage("efb/icons/perf_calc.png"),
    sasl.gl.loadImage("efb/icons/checklist.png"),
    sasl.gl.loadImage("efb/icons/gear.png")
}

components = {
    efb_menu{};
    fuel_and_load{};
    perf_calc{};
}

function draw()
    sasl.gl.drawRectangle(0, 0, WIDTH, HEIGHT, SYSTEM_COLORS.BG_BLUE)
    drawAll(components)
end