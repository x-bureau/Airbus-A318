local CURRENT_MSG = 1
local CURRENT_PAGE = 0

local function displayMsg(n,page)
    local pgLines = 0
    if page>0 then
        pgLines = page*10
    end
    for i=1+pgLines,math.min(#TEXT_STORAGE[n][2],10+pgLines) do
        if TEXT_STORAGE[n][2][i] ~= "[                      ]" and TEXT_STORAGE[n][2][i] ~=  "[ ]" and TEXT_STORAGE[n][2][i] ~= "" and TEXT_STORAGE[n][2][i] ~= " " then
            drawText(TEXT_STORAGE[n][2][i],1,14-(i-pgLines),MCDU_GREEN,SIZE.HEADER,false,"L")
        end
    end
end

local MSG_SHIFT = 0
local DISPLAY_MODE = 1 -- 1 = menu, 2 = message
local SELECTED_MESSAGE = 0

local function processMsgInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and MSG_SHIFT < #TEXT_STORAGE-5 and #TEXT_STORAGE > 5 then
        MSG_SHIFT = MSG_SHIFT + 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and MSG_SHIFT > 0 and #TEXT_STORAGE > 5 then
        MSG_SHIFT = MSG_SHIFT - 1
    end
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 7)
    end
    if get(MCDU_CURRENT_BUTTON) == 0 and #TEXT_STORAGE>=get(MCDU_CURRENT_BUTTON)+1 then
        SELECTED_MESSAGE = 1+MSG_SHIFT
        DISPLAY_MODE = 2
    elseif get(MCDU_CURRENT_BUTTON) == 1 and #TEXT_STORAGE>=get(MCDU_CURRENT_BUTTON)+1 then
        SELECTED_MESSAGE = 2+MSG_SHIFT
        DISPLAY_MODE = 2
    elseif get(MCDU_CURRENT_BUTTON) == 2 and #TEXT_STORAGE>=get(MCDU_CURRENT_BUTTON)+1 then
        SELECTED_MESSAGE = 3+MSG_SHIFT
        DISPLAY_MODE = 2
    elseif get(MCDU_CURRENT_BUTTON) == 3 and #TEXT_STORAGE>=get(MCDU_CURRENT_BUTTON)+1 then
        SELECTED_MESSAGE = 4+MSG_SHIFT
        DISPLAY_MODE = 2
    elseif get(MCDU_CURRENT_BUTTON) == 4 and #TEXT_STORAGE>=get(MCDU_CURRENT_BUTTON)+1 then
        SELECTED_MESSAGE = 5+MSG_SHIFT
        DISPLAY_MODE = 2
    end
end


local function msgPageControls()
    -- MESSAGE PAGE keys
    if get(MCDU_CURRENT_BUTTON) == 11 and #TEXT_STORAGE > 0 then
        print("printing")
        for i in ipairs(TEXT_STORAGE[CURRENT_MSG][2]) do
            if TEXT_STORAGE[CURRENT_MSG][2][i] == "" or TEXT_STORAGE[CURRENT_MSG][2][i] == " " then
                table.remove(TEXT_STORAGE[CURRENT_MSG][2],i)
            end
        end
        local PATH = getXPlanePath().."Aircraft/Dev Aircraft/Airbus-A318-master/Untitled/plugins/SASL/data/modules/Custom Module/MCDU_Rewrite/pages/AOC/temp.txt"
        local file = io.open(PATH, "w") -- clean out the file
        file:close()

        local file = io.open(PATH, "w") -- Open file again to write the message
        file:write("AOC MSG DISPLAY\n")
        file:write("\n")
        local LINES = TEXT_STORAGE[CURRENT_MSG][2]
        LINES = removeNonAlphanumeric(LINES)
        for i in ipairs(LINES) do
            file:write(LINES[i].."\n")
        end
        file:close()
        printFile("temp.txt") --we print the file to the user's printer
    end
    if get(MCDU_CURRENT_BUTTON) == 24 and DISPLAY_MODE == 2 and CURRENT_PAGE>0 then
        CURRENT_PAGE = CURRENT_PAGE - 1
    elseif get(MCDU_CURRENT_BUTTON) == 26 and DISPLAY_MODE == 2 and CURRENT_PAGE<(math.floor(#TEXT_STORAGE[CURRENT_MSG][2]/10)) then
        CURRENT_PAGE = CURRENT_PAGE + 1
    end
end


function drawMsg()
    drawText("AOC MSG DISPLAY" ,4,14,MCDU_WHITE,SIZE.TITLE,false,"L")
    if DISPLAY_MODE == 1 then
        local MSG_LABELS = {}
        for j in ipairs(TEXT_STORAGE) do table.insert(MSG_LABELS, #MSG_LABELS+1,TEXT_STORAGE[j][1]) end
        wrap(MSG_LABELS,MSG_SHIFT)
        processMsgInput()
        for i=1,math.min(5,#MSG_LABELS) do
            drawText(MSG_LABELS[i],1,14-(i*2),MCDU_GREEN,SIZE.OPTION,false,"L")
        end
        drawText("<AOC MENU",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    elseif DISPLAY_MODE == 2 then
        msgPageControls()
        drawText("<RETURN",1,2,MCDU_BLUE,SIZE.OPTION,false,"L")
        drawText("PRINT*",24,2,MCDU_BLUE,SIZE.OPTION,false,"R")
        displayMsg(SELECTED_MESSAGE,CURRENT_PAGE) -- we draw the current message last
        if get(MCDU_CURRENT_BUTTON) == 5 then
            DISPLAY_MODE = 1
        end
    end

end