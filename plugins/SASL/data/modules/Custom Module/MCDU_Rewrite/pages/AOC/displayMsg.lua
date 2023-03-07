local CURRENT_MSG = 1

local function displayMsg(n)
    for i in ipairs(TEXT_STORAGE[n]) do
        if TEXT_STORAGE[n][i] ~= "[                      ]" then
            drawText(TEXT_STORAGE[n][i],1,14-i,MCDU_GREEN,SIZE.HEADER,false,"L")
        end
    end
end

local function processMsgInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and CURRENT_MSG < #TEXT_STORAGE then
        CURRENT_MSG = CURRENT_MSG + 1
    elseif get(MCDU_CURRENT_BUTTON) == 27 and CURRENT_MSG > 1 then
        CURRENT_MSG = CURRENT_MSG - 1
    end
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 7)
    end
    if get(MCDU_CURRENT_BUTTON) == 11 and #TEXT_STORAGE > 0 then
        local PATH = getXPlanePath().."Aircraft/Dev Aircraft/Airbus-A318-master/Untitled/plugins/SASL/data/modules/Custom Module/MCDU_Rewrite/pages/AOC/temp.txt"
        local file = io.open(PATH, "w") -- clean out the file
        file:close()

        local file = io.open(PATH, "w") -- Open file again to write the message
        file:write("AOC MSG DISPLAY\n")
        file:write("\n")
        for i in ipairs(TEXT_STORAGE[CURRENT_MSG]) do
            file:write(TEXT_STORAGE[CURRENT_MSG][i].."\n")
        end
        file:close()
        printFile("temp.txt") --we print the file to the user's printer
    end
end

function drawMsg()
    processMsgInput()
    drawText("AOC MSG DISPLAY  "..CURRENT_MSG.."/"..#TEXT_STORAGE,3,14,MCDU_WHITE,SIZE.TITLE,false,"L")
    drawText("<AOC MENU",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("PRINT*",24,2,MCDU_BLUE,SIZE.OPTION,false,"R")
    if #TEXT_STORAGE > 0 then
        displayMsg(CURRENT_MSG) -- we draw the current message last
    end
end