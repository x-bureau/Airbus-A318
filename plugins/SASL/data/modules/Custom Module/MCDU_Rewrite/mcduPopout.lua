
--Load images
local mcduBackground = sasl.gl.loadImage("mcduBackground.png")

-- Define Colors
local CLICK_REGION_GREEN = {0, 1.0, 0, 0.5}
local AIRBUS_BLACK_TEXT = {0.0, 0.0, 0.0, 1.0}
local AIRBUS_WHITE = {1.0, 1.0, 1.0, 1.0}

--Define custom variables
local SHOW_CLICK_REGIONS = 1
local MCDU_CURRENT_PAGE = globalPropertyi("A318/cockpit/mcdu2/current_page")
local FPLAN_INIT = globalPropertyi("A318/cockpit/systems/MCDU/FPLAN/isInitialized")
local MCDU_CURRENT_KEY = globalPropertyi("A318/cockpit/mcdu2/current_key")
local MCDU_CURRENT_BUTTON = globalPropertyi("A318/cockpit/mcdu2/current_button")
local LA = globalPropertyi("A318/systems/mcdu/page/ARROW_LEFT")
local RA = globalPropertyi("A318/systems/mcdu/page/ARROW_RIGHT")
local UA = globalPropertyi("A318/systems/mcdu/page/ARROW_UP")
local DA = globalPropertyi("A318/systems/mcdu/page/ARROW_DOWN")
local KEYS = {
    [0] = globalPropertyi("A318/systems/mcdu/keys/key_a"),
    [1] = globalPropertyi("A318/systems/mcdu/keys/key_b"),
    [2] = globalPropertyi("A318/systems/mcdu/keys/key_c"),
    [3] = globalPropertyi("A318/systems/mcdu/keys/key_d"),
    [4] = globalPropertyi("A318/systems/mcdu/keys/key_e"),
    [5] = globalPropertyi("A318/systems/mcdu/keys/key_f"),
    [6] = globalPropertyi("A318/systems/mcdu/keys/key_g"),
    [7] = globalPropertyi("A318/systems/mcdu/keys/key_h"),
    [8] = globalPropertyi("A318/systems/mcdu/keys/key_i"),
    [9] = globalPropertyi("A318/systems/mcdu/keys/key_j"),
    [10] = globalPropertyi("A318/systems/mcdu/keys/key_k"),
    [11] = globalPropertyi("A318/systems/mcdu/keys/key_l"),
    [12] = globalPropertyi("A318/systems/mcdu/keys/key_m"),
    [13] = globalPropertyi("A318/systems/mcdu/keys/key_n"),
    [14] = globalPropertyi("A318/systems/mcdu/keys/key_o"),
    [15] = globalPropertyi("A318/systems/mcdu/keys/key_p"),
    [16] = globalPropertyi("A318/systems/mcdu/keys/key_q"),
    [17] = globalPropertyi("A318/systems/mcdu/keys/key_r"),
    [18] = globalPropertyi("A318/systems/mcdu/keys/key_s"),
    [19] = globalPropertyi("A318/systems/mcdu/keys/key_t"),
    [20] = globalPropertyi("A318/systems/mcdu/keys/key_u"),
    [21] = globalPropertyi("A318/systems/mcdu/keys/key_v"),
    [22] = globalPropertyi("A318/systems/mcdu/keys/key_w"),
    [23] = globalPropertyi("A318/systems/mcdu/keys/key_x"),
    [24] = globalPropertyi("A318/systems/mcdu/keys/key_y"),
    [25] = globalPropertyi("A318/systems/mcdu/keys/key_z"),
    [26] = globalPropertyi("A318/systems/mcdu/keys/key_1"),
    [27] = globalPropertyi("A318/systems/mcdu/keys/key_2"),
    [28] = globalPropertyi("A318/systems/mcdu/keys/key_3"),
    [29] = globalPropertyi("A318/systems/mcdu/keys/key_4"),
    [30] = globalPropertyi("A318/systems/mcdu/keys/key_5"),
    [31] = globalPropertyi("A318/systems/mcdu/keys/key_6"),
    [32] = globalPropertyi("A318/systems/mcdu/keys/key_7"),
    [33] = globalPropertyi("A318/systems/mcdu/keys/key_8"),
    [34] = globalPropertyi("A318/systems/mcdu/keys/key_9"),
    [35] = globalPropertyi("A318/systems/mcdu/keys/key_0"),
    [36] = globalPropertyi("A318/systems/mcdu/keys/key_."),
    [37] = globalPropertyi("A318/systems/mcdu/keys/key_/"),
    [38] = globalPropertyi("A318/systems/mcdu/keys/key_sp"),
    [39] = globalPropertyi("A318/systems/mcdu/keys/key_ovfy"),
    [40] = globalPropertyi("A318/systems/mcdu/keys/key_clr"),
}

local BUTTONS = {
    [0] = globalPropertyi("A318/systems/mcdu/buttons/button_l_1"),
    [1] = globalPropertyi("A318/systems/mcdu/buttons/button_l_2"),
    [2] = globalPropertyi("A318/systems/mcdu/buttons/button_l_3"),
    [3] = globalPropertyi("A318/systems/mcdu/buttons/button_l_4"),
    [4] = globalPropertyi("A318/systems/mcdu/buttons/button_l_5"),
    [5] = globalPropertyi("A318/systems/mcdu/buttons/button_l_6"),
    [6] = globalPropertyi("A318/systems/mcdu/buttons/button_r_1"),
    [7] = globalPropertyi("A318/systems/mcdu/buttons/button_r_2"),
    [8] = globalPropertyi("A318/systems/mcdu/buttons/button_r_3"),
    [9] = globalPropertyi("A318/systems/mcdu/buttons/button_r_4"),
    [10] = globalPropertyi("A318/systems/mcdu/buttons/button_r_5"),
    [11] = globalPropertyi("A318/systems/mcdu/buttons/button_r_6"),
}

--custom functions
function draw_click_regions()
    -- MENU BUTTON KEYS
    sasl.gl.drawRectangle(52, 307, 45, 30, CLICK_REGION_GREEN) --DIR KEY
    sasl.gl.drawRectangle(102, 307, 45, 30, CLICK_REGION_GREEN) --PROG KEY
    sasl.gl.drawRectangle(155, 307, 45, 30, CLICK_REGION_GREEN) --PERF KEY
    sasl.gl.drawRectangle(207, 307, 45, 30, CLICK_REGION_GREEN) --INIT KEY
    sasl.gl.drawRectangle(258, 307, 45, 30, CLICK_REGION_GREEN) --DATA KEY
--[[MENU BUTTON KEYS ROW 2]]--
    sasl.gl.drawRectangle(52, 272, 45, 30, CLICK_REGION_GREEN) --FPLAN KEY
    sasl.gl.drawRectangle(102, 272, 45, 30, CLICK_REGION_GREEN) --RAD NAV KEY
    sasl.gl.drawRectangle(155, 272, 45, 30, CLICK_REGION_GREEN) --FUEL PRED KEY
    sasl.gl.drawRectangle(207, 272, 45, 30, CLICK_REGION_GREEN) --SEC F-PLAN KEY
    sasl.gl.drawRectangle(258, 272, 45, 30, CLICK_REGION_GREEN) --ATC COMM KEY
    sasl.gl.drawRectangle(308, 272, 45, 30, CLICK_REGION_GREEN) --MCDU MENU KEY

-- ARROW KEYS
    sasl.gl.drawRectangle(52, 202, 45, 30, CLICK_REGION_GREEN) --LEFT ARROW
    sasl.gl.drawRectangle(52, 167, 45, 30, CLICK_REGION_GREEN) --LEFT ARROW
    sasl.gl.drawRectangle(103, 202, 45, 30, CLICK_REGION_GREEN) --LEFT ARROW
    sasl.gl.drawRectangle(103, 167, 45, 30, CLICK_REGION_GREEN) --LEFT ARROW

--[[KEYS ROW 1]]--
    sasl.gl.drawRectangle(173, 229, 30, 30, CLICK_REGION_GREEN) --A KEY
    sasl.gl.drawRectangle(216, 229, 30, 30, CLICK_REGION_GREEN) --B KEY
    sasl.gl.drawRectangle(258, 229, 30, 30, CLICK_REGION_GREEN) --C KEY
    sasl.gl.drawRectangle(301, 229, 30, 30, CLICK_REGION_GREEN) --D KEY
    sasl.gl.drawRectangle(343, 229, 30, 30, CLICK_REGION_GREEN) --E KEY
--[[KEYS ROW 2]]--
    sasl.gl.drawRectangle(173, 189, 30, 30, CLICK_REGION_GREEN) --F KEY
    sasl.gl.drawRectangle(216, 189, 30, 30, CLICK_REGION_GREEN) --G KEY
    sasl.gl.drawRectangle(258, 189, 30, 30, CLICK_REGION_GREEN) --H KEY
    sasl.gl.drawRectangle(301, 189, 30, 30, CLICK_REGION_GREEN) --I KEY
    sasl.gl.drawRectangle(343, 189, 30, 30, CLICK_REGION_GREEN) --J KEY
--[[KEYS ROW 3]]--
    sasl.gl.drawRectangle(173, 149, 30, 30, CLICK_REGION_GREEN) --K KEY
    sasl.gl.drawRectangle(216, 149, 30, 30, CLICK_REGION_GREEN) --L KEY
    sasl.gl.drawRectangle(258, 149, 30, 30, CLICK_REGION_GREEN) --M KEY
    sasl.gl.drawRectangle(301, 149, 30, 30, CLICK_REGION_GREEN) --N KEY
    sasl.gl.drawRectangle(343, 149, 30, 30, CLICK_REGION_GREEN) --O KEY
--[[KEYS ROW 4]]--
    sasl.gl.drawRectangle(173, 109, 30, 30, CLICK_REGION_GREEN) --P KEY
    sasl.gl.drawRectangle(216, 109, 30, 30, CLICK_REGION_GREEN) --Q KEY
    sasl.gl.drawRectangle(258, 109, 30, 30, CLICK_REGION_GREEN) --R KEY
    sasl.gl.drawRectangle(301, 109, 30, 30, CLICK_REGION_GREEN) --S KEY
    sasl.gl.drawRectangle(343, 109, 30, 30, CLICK_REGION_GREEN) --T KEY
--[[KEYS ROW 5]]--
    sasl.gl.drawRectangle(173, 69, 30, 30, CLICK_REGION_GREEN) --U KEY
    sasl.gl.drawRectangle(216, 69, 30, 30, CLICK_REGION_GREEN) --V KEY
    sasl.gl.drawRectangle(258, 69, 30, 30, CLICK_REGION_GREEN) --W KEY
    sasl.gl.drawRectangle(301, 69, 30, 30, CLICK_REGION_GREEN) --X KEY
    sasl.gl.drawRectangle(343, 69, 30, 30, CLICK_REGION_GREEN) --Y KEY
--[[KEYS ROW 6]]--
    sasl.gl.drawRectangle(173, 29, 30, 30, CLICK_REGION_GREEN) --U KEY
    sasl.gl.drawRectangle(216, 29, 30, 30, CLICK_REGION_GREEN) --V KEY
    sasl.gl.drawRectangle(258, 29, 30, 30, CLICK_REGION_GREEN) --W KEY
    sasl.gl.drawRectangle(301, 29, 30, 30, CLICK_REGION_GREEN) --X KEY
    sasl.gl.drawRectangle(343, 29, 30, 30, CLICK_REGION_GREEN) --Y KEY

    --LEFT BUTTON KEYS
    sasl.gl.drawRectangle(12, 530, 30, 15, CLICK_REGION_GREEN) --L1 key
    sasl.gl.drawRectangle(12, 500, 30, 15, CLICK_REGION_GREEN) --L2 KEY
    sasl.gl.drawRectangle(12, 470, 30, 15, CLICK_REGION_GREEN) --L3 KEY
    sasl.gl.drawRectangle(12, 440, 30, 15, CLICK_REGION_GREEN) --L4 KEY
    sasl.gl.drawRectangle(12, 410, 30, 15, CLICK_REGION_GREEN) --l5 KEY
    sasl.gl.drawRectangle(12, 380, 30, 15, CLICK_REGION_GREEN) --l6 KEY
    --RIGHT BUTTON KEYS
    sasl.gl.drawRectangle(380, 530, 30, 15, CLICK_REGION_GREEN) --L1 key
    sasl.gl.drawRectangle(380, 500, 30, 15, CLICK_REGION_GREEN) --L2 KEY
    sasl.gl.drawRectangle(380, 470, 30, 15, CLICK_REGION_GREEN) --L3 KEY
    sasl.gl.drawRectangle(380, 440, 30, 15, CLICK_REGION_GREEN) --L4 KEY
    sasl.gl.drawRectangle(380, 410, 30, 15, CLICK_REGION_GREEN) --l5 KEY
    sasl.gl.drawRectangle(380, 380, 30, 15, CLICK_REGION_GREEN) --l6 KEY

end

function draw()
    sasl.gl.drawTexture(mcduBackground, 0, 0, 429, 609)
--[[DRAW EVERYTHING BELOW THIS LINE]]--
--[[ DRAW THE SHOW CLICK REGIONS OPTION ]]--
    sasl.gl.drawText(AirbusFont, 0, 618, "SHOW CLICK REGIONS", 14, true, false, TEXT_ALIGN_LEFT, AIRBUS_WHITE)
    sasl.gl.drawRectangle(168, 614, 18, 18, AIRBUS_WHITE)
    sasl.gl.drawRectangle(70, 360, 286, 220, AIRBUS_BLACK_TEXT)
    if SHOW_CLICK_REGIONS == 1 then
        draw_click_regions()
        sasl.gl.drawText(AirbusFont, 174, 616, "X", 16, true, false, TEXT_ALIGN_LEFT, AIRBUS_BLACK_TEXT)
    end
    sasl.gl.drawTexture(MCDU_DISPLAY, 85, 366, 245, 218, {1.0 , 1.0 , 1.0 , 1.0})
end
--MCDU
-- position = {1130, 3015, 500, 510}
-- size = {525, 510}

function onMouseDown(component, x, y, button, parentX, parentY)
    if x > 169 and x < 181 and y > 613 and y < 633 and SHOW_CLICK_REGIONS == 0 then
        SHOW_CLICK_REGIONS = 1
    elseif x > 169 and x < 181 and y > 613 and y < 633 and SHOW_CLICK_REGIONS == 1 then
        SHOW_CLICK_REGIONS = 0
    end
    -- MCDU PAGE BUTTON KEYS
    if x>154 and x < 200 and y > 307 and y < 338 then -- PERF BUTTON
        set(MCDU_CURRENT_PAGE, 61)
    elseif x>206 and x < 251 and y > 307 and y < 338 then -- INIT BUTTON
        set(MCDU_CURRENT_PAGE, 1)
    elseif x>258 and x < 304 and y > 307 and y < 338 then -- DATA BUTTON
        set(MCDU_CURRENT_PAGE, 2)
    elseif x>51 and x < 97 and y > 272 and y < 302 then -- MCDU MENU BUTTON
        if get(FPLAN_INIT) == 1 then
            set(MCDU_CURRENT_PAGE, 3)
        end
    elseif x>308 and x < 353 and y > 272 and y < 302 then -- MCDU MENU BUTTON
        set(MCDU_CURRENT_PAGE, 0)
    end

    -- MCDU PAGE ARROW KEYS
    if x>52 and x < 97 and y > 202 and y < 232 then -- MCDU MENU BUTTON
        set(LA, 1)
    elseif x>52 and x < 97 and y > 167 and y < 197 then -- MCDU MENU BUTTON
        set(RA, 1)
    elseif x>103 and x < 148 and y > 202 and y < 232 then -- MCDU MENU BUTTON
        set(UA, 1)
    elseif x>103 and x < 148 and y > 167 and y < 197 then -- MCDU MENU BUTTON
        set(DA, 1)
    end

    -- MCDU SIDE SELECTION KEYS
    if x>11 and x<42 and y>529 and y<546 then
        set(BUTTONS[0],1) -- L1 button
    elseif x>11 and x<42 and y>499 and y<531 then
        set(BUTTONS[1],1) -- L2 button
    elseif x>11 and x<42 and y>469 and y<486 then
        set(BUTTONS[2],1) -- L3 button
    elseif x>11 and x<42 and y>439 and y<456 then
        set(BUTTONS[3],1) -- L4 button
    elseif x>11 and x<42 and y>409 and y<426 then
        set(BUTTONS[4],1) -- L5 button
    elseif x>11 and x<42 and y>379 and y<396 then
        set(BUTTONS[5],1) -- L6 button
    elseif x>379 and x<411 and y>529 and y<546 then
        set(BUTTONS[6],1) -- R1 button
    elseif x>379 and x<411 and y>499 and y<531 then
        set(BUTTONS[7],1) -- R2 button
    elseif x>379 and x<411 and y>469 and y<486 then
        set(BUTTONS[8],1) -- R3 button
    elseif x>379 and x<411 and y>439 and y<456 then
        set(BUTTONS[9],1) -- R4 button
    elseif x>379 and x<411 and y>409 and y<426 then
        set(BUTTONS[10],1) -- R5 button
    elseif x>379 and x<411 and y>379 and y<396 then
        set(BUTTONS[11],1) -- R6 button
    end
end

function onKeyDown(component, char, key, shiftDown, ctrlDown, altOptDown)
    if string.char(char) == "a" then
        set(KEYS[0],1)
        return true
    elseif string.char(char) == "b" then
        set(KEYS[1],1)
        return true
    elseif string.char(char) == "c" then
        set(KEYS[2],1)
        return true
    elseif string.char(char) == "d" then
        set(KEYS[3],1)
        return true
    elseif string.char(char) == "e" then
        set(KEYS[4],1)
        return true
    elseif string.char(char) == "f" then
        set(KEYS[5],1)
        return true
    elseif string.char(char) == "g" then
        set(KEYS[6],1)
        return true
    elseif string.char(char) == "h" then
        set(KEYS[7],1)
        return true
    elseif string.char(char) == "i" then
        set(KEYS[8],1)
        return true
    elseif string.char(char) == "j" then
        set(KEYS[9],1)
        return true
    elseif string.char(char) == "k" then
        set(KEYS[10],1)
        return true
    elseif string.char(char) == "l" then
        set(KEYS[11],1)
        return true
    elseif string.char(char) == "m" then
        set(KEYS[12],1)
        return true
    elseif string.char(char) == "n" then
        set(KEYS[13],1)
        return true
    elseif string.char(char) == "o" then
        set(KEYS[14],1)
        return true
    elseif string.char(char) == "p" then
        set(KEYS[15],1)
        return true
    elseif string.char(char) == "q" then
        set(KEYS[16],1)
        return true
    elseif string.char(char) == "r" then
        set(KEYS[17],1)
        return true
    elseif string.char(char) == "s" then
        set(KEYS[18],1)
        return true
    elseif string.char(char) == "t" then
        set(KEYS[19],1)
        return true
    elseif string.char(char) == "u" then
        set(KEYS[20],1)
        return true
    elseif string.char(char) == "v" then
        set(KEYS[21],1)
        return true
    elseif string.char(char) == "w" then
        set(KEYS[22],1)
        return true
    elseif string.char(char) == "x" then
        set(KEYS[23],1)
        return true
    elseif string.char(char) == "y" then
        set(KEYS[24],1)
        return true
    elseif string.char(char) == "z" then
        set(KEYS[25],1)
        return true
    elseif string.char(char) == "1" then
        set(KEYS[26],1)
        return true
    elseif string.char(char) == "2" then
        set(KEYS[27],1)
        return true
    elseif string.char(char) == "3" then
        set(KEYS[28],1)
        return true
    elseif string.char(char) == "4" then
        set(KEYS[29],1)
        return true
    elseif string.char(char) == "5" then
        set(KEYS[30],1)
        return true
    elseif string.char(char) == "6" then
        set(KEYS[31],1)
        return true
    elseif string.char(char) == "7" then
        set(KEYS[32],1)
        return true
    elseif string.char(char) == "8" then
        set(KEYS[33],1)
        return true
    elseif string.char(char) == "9" then
        set(KEYS[34],1)
        return true
    elseif string.char(char) == "0" then
        set(KEYS[35],1)
        return true
    elseif string.char(char) == "." then
        set(KEYS[36],1)
        return true
    elseif string.char(char) == "/" then
        set(KEYS[37],1)
        return true
    end
    if string.char(char) == string.char(8) then
        set(KEYS[40],1)
        return true
    end
end
