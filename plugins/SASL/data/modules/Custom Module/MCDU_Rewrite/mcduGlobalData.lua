-- PAGE REFERENCES -- 
include("MCDU_Rewrite/pages/mcdu_menu.lua")
include("MCDU_Rewrite/pages/init.lua")
include("MCDU_Rewrite/pages/data.lua")
include("MCDU_Rewrite/pages/printaoc.lua")
include("MCDU_Rewrite/pages/gps.lua")
include("MCDU_Rewrite/pages/FPLAN/fplan.lua")
include("MCDU_Rewrite/pages/FPLAN/latrev.lua")
include("MCDU_Rewrite/pages/FPLAN/rnwy.lua")
include("MCDU_Rewrite/pages/arcade.lua")
include("MCDU_Rewrite/pages/pong.lua")
include("MCDU_Rewrite/pages/simon.lua")
include("MCDU_Rewrite/pages/snake.lua")
include("MCDU_Rewrite/pages/text.lua")
include("MCDU_Rewrite/mcduLib.lua")
include("MCDU_Rewrite/pages/FPLAN/arrival.lua")
include("MCDU_Rewrite/pages/initb.lua")
include("MCDU_Rewrite/pages/PERF/takeoff.lua")
include("MCDU_Rewrite/pages/PERF/clb.lua")
include("MCDU_Rewrite/pages/PERF/perfData.lua")
include("MCDU_Rewrite/pages/PERF/crz.lua")
include("MCDU_Rewrite/pages/acstatus.lua")
include("MCDU_Rewrite/mcduPopout.lua")
include("MCDU_Rewrite/pages/atsu.lua")
include("MCDU_Rewrite/pages/aocmenu.lua")

MCDU_FONT = sasl.gl.loadFont("fonts/MCDU.ttf")
BLANK_FONT = sasl.gl.loadFont("fonts/MCDU.ttf")
MCDU_FONT_BOLD = sasl.gl.loadFont("fonts/MCDU.ttf")
SPECIAL_CHAR_FONT = sasl.gl.loadFont("fonts/Roboto-Regular.ttf")

MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
MCDU_GREY = {1.0, 1.0, 1.0, 0.5}

MCDU_GREEN = {0., 1.0, 0.1, 1.0}
MCDU_BLUE = {0.4, 0.9, 1.0, 1.0}
MCDU_YELLOW = {1.0, 1.0, 0.0, 1.0}
MCDU_RED = {1.0, 0.0, 0.0, 1.0}



-- MCDU GENERAL DATAREFS
MCDU_CURRENT_PAGE = createGlobalPropertyi("A318/cockpit/mcdu2/current_page")
MCDU_CURRENT_KEY = createGlobalPropertyi("A318/cockpit/mcdu2/current_key")
MCDU_CURRENT_BUTTON = createGlobalPropertyi("A318/cockpit/mcdu2/current_button")
FPLAN_INIT = createGlobalPropertyi("A318/cockpit/systems/MCDU/FPLAN/isInitialized")

hours = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours")
minutes = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
seconds = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_seconds")

--MCDU GLOBAL VARIABLES
DEPARTURE_AIRPORT = " "
DESTINATION_AIRPORT = " "
RWY_LABELS = "RLC"

--======================================--
--           INPUT HANDLER              --
--======================================--

function update()
    set(MCDU_CURRENT_KEY, -1)
    set(MCDU_CURRENT_BUTTON, -1)
    local keyStorage = checkForPress(keys)
    local buttonStorage = checkForPress(buttons)
    if keyStorage ~= -1 then
        set(MCDU_CURRENT_KEY, keyStorage)
        set(keys[keyStorage], 0)
        keyStorage = -1
    end
    if keysDecoder[get(MCDU_CURRENT_KEY)] ~= nil and get(MCDU_CURRENT_KEY) < 38 then
        if scratchpad == "ERROR" then
            scratchpad = ""
        end
        scratchpad = scratchpad .. keysDecoder[get(MCDU_CURRENT_KEY)]
        set(MCDU_CURRENT_KEY, -1)
    elseif keysDecoder[get(MCDU_CURRENT_KEY)] == "c" then
        scratchpad = ""
        set(MCDU_CURRENT_KEY, -1)
    end
    if buttonStorage ~= -1 then
        set(MCDU_CURRENT_BUTTON, buttonStorage)
        set(buttons[buttonStorage], 0)
        buttonStorage = -1
    end
    pageButtons(buttons)
    switchDataPage()
    switchPrintAOCPage()
    switchInitPage()
    -- REMOVE SCRATCHPAD ERRORS
end

function pageButtons(button)
    if get(MCDU_CURRENT_BUTTON) == 15 then
        set(MCDU_CURRENT_PAGE, 1)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 22 then
        set(MCDU_CURRENT_PAGE, 0)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 16 then
        set(MCDU_CURRENT_PAGE, 2)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 17 then
        if checkForAirports() == true then
            set(MCDU_CURRENT_PAGE, 3)
        else
            scratchpad = "ERROR: INITALIZE ROUTE"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 14 then
        set(MCDU_CURRENT_PAGE, 61)
    end
end

function checkTextInput(field)
    for i=0, 11 do
        if get(MCDU_CURRENT_BUTTON) == i-1 and string.len(scratchpad) == field[i+1].size then
            set(MCDU_CURRENT_BUTTON, -1)
            clearScratch(scratchpad)
            return scratchpad
        end
    end
end


--MCDU PAGES:
mcduPages = {
    [-23] = {drawSnake},
    [-22] = {drawSimon},
    [-21] = {drawPong},
    [-2] = {drawArcadeMenu},
    [0] = {drawMCDUMenu},
    [1] = {drawInit},
    [10] = {drawATSU},
    [11] = {drawInitB},
    [12] = {drawCoRte},
    --[111] = {drawClimbWind},
    --[112] = {drawDescentWind},
    [2] = {drawDataA},
    [22] = {drawDataB},
    --[221] = {drawPositionMonitor},
    --[222] = {drawIRSMonitor},
    [223] = {drawGPSMonitor},
    --[224] = {drawACStatus},
    [225] = {drawPrintA},
    [2251] = {drawPrintB},
    [226] = {drawAOCA},
    [2261] = {drawAOCB},
    [23] = {drawACStatus},
    [3] = {drawFPlan},
    [4] = {drawInitialLatRev},
    [41] = {drawRnwy},
    [42] = {drawArr},
    [5] = {drawAirway},
    [61] = {drawTakeoff},
    [62] = {drawClb},
    [63] = {drawCrz},
    [7] = {drawAOC},
}

mcdu_font_colors = {
    [1] = {1, 1, 1, 1},
    [2] = {52/255, 207/255, 21/255, 1.0},
    [3] = {0, 227/255, 223/255, 1.0},
    [4] = {1, 153/255, 0, 1},
    [5] = {1, 1, 1/10, 1},
    [6] = {255, 165, 0, 1.0},
}

-- POSITIONS AND SIZING
title_location = {
    x = 239,
    y = 360,
    font_size = 28
}

option_heading_font_size = 18
option_heading_locations = {
    [1] = 353,
    [2] = 300,
    [3] = 247,
    [4] = 194,
    [5] = 141,
    [6] = 88
}

mcdu_positions = {
    [1] = 322,
    [2] = 269,
    [3] = 216,
    [4] = 163,
    [5] = 110,
    [6] = 55
}

mcdu_option_size = 24

mcdu_font_colors = {
    [1] = {1, 1, 1, 1},
    [2] = {52/255, 207/255, 21/255, 1.0},
    [3] = {0, 227/255, 223/255, 1.0},
    [4] = {1, 153/255, 0, 1}
}



-- TEXT SHIT
TEXT_X = {
    [1] = 2,
    [2] = 24,
    [3] = 46,
    [4] = 68,
    [5] = 90,
    [6] = 112,
    [7] = 134,
    [8] = 156,
    [9] = 178,
    [10] = 200,
    [11] = 222,
    [12] = 244,
    [13] = 266,
    [14] = 288,
    [15] = 310,
    [16] = 332,
    [17] = 354,
    [18] = 376,
    [19] = 398,
    [20] = 420,
    [21] = 442,
    [22] = 464,
    [23] = 486,
    [24] = 508,
}

TEXT_Y = {
    [1] = 5,
    [2] = 40,
    [3] = 75,
    [4] = 110,
    [5] = 145,
    [6] = 180,
    [7] = 215,
    [8] = 250,
    [9] = 285,
    [10] = 320,
    [11] = 355,
    [12] = 390,
    [13] = 425,
    [14] = 460
}

OPTION = {
    [1] = TEXT_Y[12],
    [2] = TEXT_Y[10],
    [3] = TEXT_Y[8],
    [4] = TEXT_Y[6],
    [5] = TEXT_Y[4],
    [6] = TEXT_Y[2]
}

HEADER = {
    [1] = TEXT_Y[13],
    [2] = TEXT_Y[11],
    [3] = TEXT_Y[9],
    [4] = TEXT_Y[7],
    [5] = TEXT_Y[5],
    [6] = TEXT_Y[3]
}

SIZE = {
    HEADER = 22,
    OPTION = 30,
    TITLE = 30,
}

SIDE = {
    "L",
    "R",
}

SPECIAL_CHARS = {
    [1] = "°",
}

DEG_SYMBOL = string.char(248)