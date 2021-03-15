PAGE_WIDTH = 902
PAGE_HEIGHT = 637 - 70

local defaultColor = {0, 0, 0, 1.0}


function handle_flight_summary_click(x, y)
end

function handle_flight_summary_key(char)
end

function drawFlightSummary()
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, PAGE_WIDTH / 2, PAGE_HEIGHT / 2, "INOP", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
end