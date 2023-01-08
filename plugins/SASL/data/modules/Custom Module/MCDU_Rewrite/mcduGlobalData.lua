include("MCDU_Rewrite/pages/mcdu_menu.lua")
include("MCDU_Rewrite/pages/init.lua")

MCDU_FONT = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")
BLANK_FONT = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")
MCDU_FONT_BOLD = sasl.gl.loadFont("fonts/B612Mono-Regular.ttf")

MCDU_ORANGE = {1.0, 0.549, 0.0, 1.0}
MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}

-- MCDU GENERAL DATAREFS
MCDU_CURRENT_PAGE = createGlobalPropertyi("A318/cockpit/mcdu2/current_page", 0)
MCDU_CURRENT_KEY = createGlobalPropertyi("A318/cockpit/mcdu2/current_key")
MCDU_CURRENT_BUTTON = createGlobalPropertyi("A318/cockpit/mcdu2/current_button")

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

    -- REMOVE SCRATCHPAD ERRORS
end

function pageButtons(button)
    if get(MCDU_CURRENT_BUTTON) == 15 then
        set(MCDU_CURRENT_PAGE, 1)
        set(MCDU_CURRENT_BUTTON, -1)
    elseif get(MCDU_CURRENT_BUTTON) == 22 then
        set(MCDU_CURRENT_PAGE, 0)
        set(MCDU_CURRENT_BUTTON, -1)
    else

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
    [0] = {drawMCDUMenu},
    [1] = {drawInit},
    --[11] = {initB},
    --[111] = {drawClimbWind}
    --[112] = {drawDescentWind}
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

function drawTextFieldBoxes(chars, color, x, y, side)
    y = y + 24
    if side == 1 then
        sasl.gl.drawLine(x, y, (option_heading_font_size*chars), y, color)
        for i=0, chars do
            sasl.gl.drawLine(x+(i*option_heading_font_size), y, x+(i*option_heading_font_size), y-option_heading_font_size, color)
        end
        sasl.gl.drawLine(x, (y)-option_heading_font_size, (option_heading_font_size*chars), (y)-option_heading_font_size, color)
    elseif side == 2 then
        sasl.gl.drawLine(x, y, x-(option_heading_font_size*chars), y, color)
        for i=0, chars do
            sasl.gl.drawLine(x-(i*option_heading_font_size), y, x-(i*option_heading_font_size), y-option_heading_font_size, color)
        end
        sasl.gl.drawLine(x, (y)-option_heading_font_size, x-(option_heading_font_size*chars), (y)-option_heading_font_size, color)
    end
end


function drawOptionHeadings(field)
    for i=1, 6 do
        sasl.gl.drawText(MCDU_FONT, 0, option_heading_locations[i],field[i],option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end
    for j = 7, 12 do
         sasl.gl.drawText(MCDU_FONT, 490, option_heading_locations[j-6],field[j],option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    end
end

function drawDashSeparated(position, num1, num2, side)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 5+(num1*12)+(num1*1), position+2, "/",option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=1, num2 do
            local x = 0+(num1*12)+(num1*1)+10+(12*i)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i = 0, (num1-1) do
            local x = 480 - (num2*12)-(num2*1)-10-(12*i)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 480-(num2*12)-(num2*1), position+2, "/",option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function drawDashDotSeparated (position, num1, num2, side)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 3+(num1*12)+(num1*1), position+2, ".",25, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 0+(num1*12)+(num1*1)+10+(12*i)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i = 0, (num1-1) do
            local x = 480 - (num2*12)-(num2*1)-10-(12*i)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 483-(num2*12)-(num2*1), position+2, ".",25, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function drawDashField(position, side, num1)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i=0, (num1-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function clearScratch(scratchpad)
    local scratchpad = ""
    return scratchpad
end

function isEmpty(input)
    if input[5] == " " then
        return true
    else
         return false
    end
end