TEXT_STORAGE = {}

local optionLabels = {
    [1] = "TO:",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "RETURN TO",
    [7] = "",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = ""
}

local fields = {
    [1] = "",
    [2] = "[                      ]",
    [3] = "[                      ]",
    [4] = "[                      ]",
    [5] = "[                      ]",
}


local function processTextInput(tempStore)
    if get(MCDU_CURRENT_BUTTON) == 0 and string.len(scratchpad) < 12 and string.len(scratchpad) > 3 then
        fields[1] = scratchpad
        scratchpad = ""
        return fields
    elseif get(MCDU_CURRENT_BUTTON) == 1 and string.len(scratchpad) <=24 and string.len(scratchpad) > 0 then
        fields[2] = scratchpad
        scratchpad = ""
        return fields
    elseif get(MCDU_CURRENT_BUTTON) == 2 and string.len(scratchpad) <=24 and string.len(scratchpad) > 0 then
        fields[3] = scratchpad
        scratchpad = ""
        return fields
    elseif get(MCDU_CURRENT_BUTTON) == 3 and string.len(scratchpad) <=24 and string.len(scratchpad) > 0 then
        fields[4] = scratchpad
        scratchpad = ""
        return fields
    elseif get(MCDU_CURRENT_BUTTON) == 4 and string.len(scratchpad) <=24 and string.len(scratchpad) > 0 then
        fields[5] = scratchpad
        scratchpad = ""
        return fields
    elseif get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 7)
    end
end

local tempStore = {
    [1] = "",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = ""
}
function drawFreeText()
    processTextInput(fields)
    drawOptionHeadings(optionLabels)
    drawText("AOC FREE TEXT", 6, 14, MCDU_WHITE, SIZE.TITLE, false, "L")
    drawText("<AOC MENU",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("SEND*",24,2,MCDU_BLUE,SIZE.OPTION,false,"R")

    if get(MCDU_CURRENT_BUTTON) == 11 then
        local tempStore = {
            [1] = fields[1],
            [2] = fields[2],
            [3] = fields[3],
            [4] = fields[4],
            [5] = fields[5]
        }

        table.insert(TEXT_STORAGE, #TEXT_STORAGE+1, {formatTime(get(hours),get(minutes)).." FROM: "..tempStore[1],tempStore})
        fields[1] = ""
        fields[2] = "[                      ]"
        fields[3] = "[                      ]"
        fields[4] = "[                      ]"
        fields[5] = "[                      ]"
    end
    --DRAW MESSAGE
    drawText(fields[1],1,12,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[2],1,10,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[3],1,8,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[4],1,6,MCDU_BLUE,SIZE.OPTION,false,"L")
    drawText(fields[5],1,4,MCDU_BLUE,SIZE.OPTION,false,"L")
end