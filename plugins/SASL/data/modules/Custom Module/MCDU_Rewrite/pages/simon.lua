local playSimon = false

local turns = 1
playerSequence = {}


function processSimonInput()
    if get(MCDU_CURRENT_BUTTON) == 24 then
        table.insert(playerSequence, 1)
    end
    if get(MCDU_CURRENT_BUTTON) == 25 then
        table.insert(playerSequence, 2)
    end
    if get(MCDU_CURRENT_BUTTON) == 26 then
        table.insert(playerSequence, 3)
    end
    if get(MCDU_CURRENT_BUTTON) == 27 then
        table.insert(playerSequence, 4)
    end
end

function processPageInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, -2)
    elseif get(MCDU_CURRENT_BUTTON) == 0 then
        playSimon = true
        turns = 1
    end
end

function generatePattern(num)
    local pattern = {}
    for i=1, num do
        table.insert(pattern, math.random(1,4))
    end
    return pattern
end
function drawSimon()
    processPageInput()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "SIMON", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    if playSimon == false then
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<PLAY", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-100, "USE THE ARROW KEYS", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-title_location.font_size-6-100, "TO CONTROL THE GAME", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)

    end

    if playSimon == true then
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1], "NOT YET IMPLEMENTED", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
        sasl.gl.drawRectangle(125, 90, 120, 100, MCDU_WHITE)
        sasl.gl.drawRectangle(250, 90, 120, 100, MCDU_BLUE)
        sasl.gl.drawRectangle(125, 195, 120, 100, MCDU_RED)
        sasl.gl.drawRectangle(250, 195, 120, 100, MCDU_YELLOW)
    end
-- Game logic
    --local key = generatePattern(turns)
    -- Test Key generation
    -- for i in ipairs(key) do
    --     print(key[i])
    -- end
    -- print("--------")
    -- for i in ipairs(playerSequence) do
    --     table.remove(playerSequence, i)
    -- end
    if playSimon == true then

        processSimonInput()

        -- while #playerSequence < #key do
        --     for i in ipairs(playerSequence)do
        --         if playerSequence[i] ~= key[i] then
        --             playSimon = false
        --         end d
        --     end
        -- end
        -- turns = turns + 1

    end


end