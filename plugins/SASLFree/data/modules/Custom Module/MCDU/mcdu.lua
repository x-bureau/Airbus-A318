-- testing if download works

include("MCDU/pages/mcdu_menu.lua")
include("MCDU/pages/acf_info.lua")
include("MCDU/pages/init.lua")
include("MCDU/pages/init_b.lua")
include("MCDU/pages/data_index.lua")
include("MCDU/pages/irs_init.lua")
include("MCDU/pages/acf_update.lua")
include("MCDU/mcdu_global_properties.lua")
include("MCDU/fms_parser.lua")
include("MCDU/updater.lua")

------------------------------------------------------------------
position = {28, 1212, 479, 400}
size = {479, 400}

------------------------------------------------------------------
--Defining Variables
------------------------------------------------------------------

local MCDU_BLACK = {0 , 0 , 0 , 1.0}
AIRBUS_FONT = sasl.gl.loadFont("fonts/PanelFont.ttf")
--MCDU_FONT = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")
MCDU_FONT = sasl.gl.loadFont("fonts/mcduf.ttf")
BLANK_FONT = sasl.gl.loadFont("fonts/BBStrata.ttf")
MCDU_FONT_BOLD = sasl.gl.loadFont("fonts/mcduf.ttf")
MCDU_CURRENT_PAGE = createGlobalPropertyi("A318/cockpit/mcdu/current_page", 0)
local Airbus_VERSION = "A318-100"
ENG_TYPE = "CFM-56-B"
SCRATCHPAD = ""
scratchpadBuffer = ""
isDisplayingError = false
local blinkTimer = sasl.createTimer()
local isBlinking = false
--Buttons Datarefs 

sasl.gl.setFontGlyphSpacingFactor (BLANK_FONT, 1.2)
sasl.gl.setFontGlyphSpacingFactor (MCDU_FONT, 1.1)
sasl.gl.setFontGlyphSpacingFactor (MCDU_FONT_BOLD, 1.1)

local BUTTON_1_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/1", 0)
local BUTTON_2_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/2", 0)
local BUTTON_3_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/3", 0)
local BUTTON_4_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/4", 0)
local BUTTON_5_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/5", 0)
local BUTTON_6_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/6", 0)

local BUTTON_1_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/1", 0)
local BUTTON_2_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/2", 0)
local BUTTON_3_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/3", 0)
local BUTTON_4_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/4", 0)
local BUTTON_5_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/5", 0)
local BUTTON_6_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/6", 0)

local BUS = globalProperty("A318/systems/ELEC/AC2_V")

local buttonInputs = {
    BUTTON_1_L,
    BUTTON_2_L,
    BUTTON_3_L,
    BUTTON_4_L,
    BUTTON_5_L,
    BUTTON_6_L,
    BUTTON_1_R,
    BUTTON_2_R,
    BUTTON_3_R,
    BUTTON_4_R,
    BUTTON_5_R,
    BUTTON_6_R,

}

-- Info Arrays 
letters = {
  "A", -- 1
  "B", -- 2
  "C", -- 3
  "D", -- 4
  "E", -- 5
  "F", -- 6
  "G", -- 7
  "H", -- 8
  "I", -- 9
  "J", -- 11
  "K", -- 11
  "L", -- 12 
  "M", -- 13
  "N", -- 14
  "O", -- 15
  "P", -- 16
  "Q", -- 17
  "R", -- 18
  "S", -- 19
  "T", -- 20
  "U", -- 21
  "V", -- 22
  "W", -- 23
  "X", -- 24
  "Y", -- 25
  "Z", -- 26
  1, -- 27
  2, -- 28
  3, -- 29
  4, -- 30
  5, -- 31
  6, -- 32
  7, -- 33
  8, -- 34
  9, -- 35
  0, -- 36
  "/",
  "."
 -- "[]", -- 37
}

local CLR_KEY = createGlobalPropertyi("A318/cockpit/mcdu/keys/clr", 0) --1
keys = {
  [1] = createGlobalPropertyi("A318/cockpit/mcdu/keys/a", 0), --1
  [2] = createGlobalPropertyi("A318/cockpit/mcdu/keys/b", 0), --2
  [3] = createGlobalPropertyi("A318/cockpit/mcdu/keys/c", 0), --3 
  [4] = createGlobalPropertyi("A318/cockpit/mcdu/keys/d", 0), --4
  [5] = createGlobalPropertyi("A318/cockpit/mcdu/keys/e", 0), --5
  [6] = createGlobalPropertyi("A318/cockpit/mcdu/keys/f", 0), --6
  [7] = createGlobalPropertyi("A318/cockpit/mcdu/keys/g", 0), --7
  [8] = createGlobalPropertyi("A318/cockpit/mcdu/keys/h", 0), --8
  [9] = createGlobalPropertyi("A318/cockpit/mcdu/keys/i", 0), --9
  [10] = createGlobalPropertyi("A318/cockpit/mcdu/keys/j", 0), --10
  [11] = createGlobalPropertyi("A318/cockpit/mcdu/keys/k", 0), --11
  [12] = createGlobalPropertyi("A318/cockpit/mcdu/keys/l", 0), --12
  [13] = createGlobalPropertyi("A318/cockpit/mcdu/keys/m", 0), --13
  [14] = createGlobalPropertyi("A318/cockpit/mcdu/keys/n", 0), --14
  [15] = createGlobalPropertyi("A318/cockpit/mcdu/keys/o", 0), --15
  [16] = createGlobalPropertyi("A318/cockpit/mcdu/keys/p", 0), --16
  [17] = createGlobalPropertyi("A318/cockpit/mcdu/keys/q", 0), --17 
  [18] = createGlobalPropertyi("A318/cockpit/mcdu/keys/r", 0), --18
  [19] = createGlobalPropertyi("A318/cockpit/mcdu/keys/s", 0), --19
  [20] = createGlobalPropertyi("A318/cockpit/mcdu/keys/t", 0), --20 
  [21] = createGlobalPropertyi("A318/cockpit/mcdu/keys/u", 0), --21
  [22] = createGlobalPropertyi("A318/cockpit/mcdu/keys/v", 0), --22
  [23] = createGlobalPropertyi("A318/cockpit/mcdu/keys/w", 0), --23
  [24] = createGlobalPropertyi("A318/cockpit/mcdu/keys/x", 0), --24
  [25] = createGlobalPropertyi("A318/cockpit/mcdu/keys/y", 0), --25
  [26] = createGlobalPropertyi("A318/cockpit/mcdu/keys/z", 0), --26
  [27] = createGlobalPropertyi("A318/cockpit/mcdu/keys/1", 0), --27
  [28] = createGlobalPropertyi("A318/cockpit/mcdu/keys/2", 0), --28
  [29] = createGlobalPropertyi("A318/cockpit/mcdu/keys/3", 0), --29
  [30] = createGlobalPropertyi("A318/cockpit/mcdu/keys/4", 0), --30
  [31] = createGlobalPropertyi("A318/cockpit/mcdu/keys/5", 0), --31
  [32] = createGlobalPropertyi("A318/cockpit/mcdu/keys/6", 0), --32
  [33] = createGlobalPropertyi("A318/cockpit/mcdu/keys/7", 0), --33
  [34] = createGlobalPropertyi("A318/cockpit/mcdu/keys/8", 0), --34
  [35] = createGlobalPropertyi("A318/cockpit/mcdu/keys/9", 0), --35
  [36] = createGlobalPropertyi("A318/cockpit/mcdu/keys/0", 0), --36
  [37] = createGlobalPropertyi("A318/cockpit/mcdu/keys/slash", 0), --37
  [38] = createGlobalPropertyi("A318/cockpit/mcdu/keys/period", 0), --38
}

---------------------------------------------------------------------
-- POSITIONS AND SIZING
title_location = {
    x = 239,
    y = 360,
    font_size = 30
}

option_heading_font_size = 20
option_heading_locations = {
    [1] = 333,
    [2] = 280,
    [3] = 227,
    [4] = 174,
    [5] = 121,
    [6] = 63
}

mdcu_positons = {
    [1] = 307,
    [2] = 254,
    [3] = 201,
    [4] = 148,
    [5] = 95,
    [6] = 40
}

mcdu_option_size = 26

mcdu_font_colors = {
    [1] = {1, 1, 1, 1},
    [2] = {52/255, 207/255, 21/255, 1.0},
    [3] = {0, 227/255, 223/255, 1.0},
    [4] = {1, 153/255, 0, 1}
}

mcdu_colors = {
    box = {1, 153/255, 0, 1}
}

-- PAGES and DRAW CALLS

function clearScratchpad() 
    SCRATCHPAD = ""
end

function displayError(error)
    scratchpadBuffer = SCRATCHPAD
    SCRATCHPAD = error
    isDisplayingError = true
end

local function checkInput()
    -- check for letter keys
    for i = 1, table.getn(keys), 1 do
        if get(keys[i]) == 1 then
            SCRATCHPAD = SCRATCHPAD..letters[i]
            set(keys[i], 0)
        end
    end
    if get(CLR_KEY) == 1 then
        if isDisplayingError then
            SCRATCHPAD = scratchpadBuffer
            scratchpadBuffer = ""
            isDisplayingError = false
        else
            if string.len(SCRATCHPAD) == 0 then
                SCRATCHPAD = "CLR"
            elseif SCRATCHPAD == "CLR" then
                SCRATCHPAD = ""
            else
                SCRATCHPAD = SCRATCHPAD:sub(1, -2)
            end
        end
        set(CLR_KEY, 0)
    end
end

function checkKeyInput()
    for i = 1, table.getn(buttonInputs), 1 do
        if get(buttonInputs[i]) == 1 then
            local side = ''
            local key = 0
            if i > 6 then
                side = 'r'
                key = i - 6
            else
                side = 'l'
                key = i
            end
            PAGE_CALLS[get(MCDU_CURRENT_PAGE)][3](side, key)
            set(buttonInputs[i], 0)
            if isDisplayingError == false then
                clearScratchpad()
            end
            sasl.startTimer(blinkTimer)
            isBlinking = true
        end
    end
end

function update()
    checkInput()
    checkKeyInput()
    PAGE_CALLS[get(MCDU_CURRENT_PAGE)][2]()
    if sasl.getElapsedSeconds(blinkTimer) > 0.13 then
        sasl.stopTimer(blinkTimer)
        sasl.resetTimer(blinkTimer)
        isBlinking = false
    end
end


function draw()
    if get(BUS) > 0 then
      sasl.gl.drawRectangle(0, 0, 479, 400, {0, 15/255, 28/255, 1.0})
      if not isBlinking then
        sasl.gl.drawText(MCDU_FONT, 10, 10, SCRATCHPAD, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        --drawCalls[get(MCDU_CURRENT_PAGE)]()
        PAGE_CALLS[get(MCDU_CURRENT_PAGE)][1]()
      end
    end
end
