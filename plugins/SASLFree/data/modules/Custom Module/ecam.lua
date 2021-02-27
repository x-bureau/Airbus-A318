--A318 Created by X-Bureau--

position = {1144, 622, 522, 522}
size = {522, 522}

--get datarefs
local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)
local n2percent = globalPropertyfa("sim/cockpit2/engine/indicators/N2_percent", 7)
local EGT = globalPropertyfa("sim/flightmodel/engine/ENGN_EGT_c", 7)

--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--images
local needle1 = sasl.gl.loadImage("images/Needle1.png", 0, 0, 89, 47)

local Backround = sasl.gl.loadImage("images/EWD_Overlay.png", 0, 0, 522,522)

--colors
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}
local PFD_GREY = {0.25, 0.26, 0.26, 1.0}


--custom functions
local function draw_ENG_PAGE()

    sasl.gl.drawTexture(Backround, 10, 47, 550, 520, PFD_WHITE)
    sasl.gl.drawText(AirbusFont, 205, 445, math.floor(get(npercent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 410, 445, math.floor(get(npercent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 189, 323, math.floor(get(n2percent, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 390, 323, math.floor(get(n2percent, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 195.9, 366.7, math.floor(get(EGT, 1)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawText(AirbusFont, 398, 366.7, math.floor(get(EGT, 2)), 20, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 1) * 1.7, 133, 446, 89, 47, PFD_WHITE)
    sasl.gl.drawRotatedTexture(needle1, get(npercent, 2) * 1.7, 333, 446, 89, 47, PFD_WHITE)
    

    


end

--[[===============================
			DRAW ECAM MEMOS
=================================]]
local message_mode = {
    [1] = "Level 1";
    [2] = "Level 2";
    [3] = "Level 3";
    [4] = "Advisory";
    [5] = "Memo"
}
local message1 = ""
local message2 = ""
local message3 = ""
local message4 = ""
local message5 = ""
local message6 = ""

local inputmessage = ""

local message6IsInUse = 0 --0 = FALSE, 1 = TRUE
--[[
    THIS IS A TEMPLATE FOR A MESSAGE:

    if get(variable) <operator> [value] then
        inputmessage = "ECAM MEMO/MESSAGE"
        message6 = message5
        message5 = message4
        message4 = message3
        message3 = message2
        message2 = message1
        message1 = inputmessage
    end
]]

inputmessage = ""
if inputmessage ~= message1 then
    message6 = message5
    message5 = message4
    message4 = message3
    message3 = message2
    message2 = message1
    message1 = inputmessage
end

inputmessage = ""
if inputmessage ~= message1 then
    message6 = message5
    message5 = message4
    message4 = message3
    message3 = message2
    message2 = message1
    message1 = inputmessage
end

local function draw_messages()
    if message_mode == 5 then
        if message1 ~= "" then
            sasl.gl.drawText(AirbusFont, 30, 60, message1, 20, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
        end
        if message2 ~= "" then
            sasl.gl.drawText(AirbusFont, 30, 80, message2, 20, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
        end
        if message3 ~= "" then
            sasl.gl.drawText(AirbusFont, 30, 100, message3, 20, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
        end
        if message4 ~= "" then
            sasl.gl.drawText(AirbusFont, 30, 120, message4, 20, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
        end
        if message5 ~= "" then
            sasl.gl.drawText(AirbusFont, 30, 140, message5, 20, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
        end
        if message6 ~= "" then
            sasl.gl.drawText(AirbusFont, 30, 160, message6, 20, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
        end
    end
end


function draw()
    message_mode = 5
    draw_ENG_PAGE()
    draw_messages()
end
