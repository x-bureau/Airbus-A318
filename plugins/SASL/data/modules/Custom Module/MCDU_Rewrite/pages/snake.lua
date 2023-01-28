local screen = {}
screen.x = 20
screen.y = 15
screen.cellSize = 20
screen.offset = 50
directionQueue = {'right'}
score = 0
init = true

snakeSegments = {
    {x = 3, y = 1},
    {x = 2, y = 1},
    {x = 1, y = 1},
}

function moveFood()
    local possiblePos = {}

    for foodX = 1, screen.x do
        for foodY = 1, screen.y do
            local possible = true

            for segmentIndex, segment in ipairs(snakeSegments) do
                if foodX == segment.x and foodY == segment.y then
                    possible = false
                end
            end

            if possible then
                table.insert(possiblePos, {x = foodX, y = foodY})
            end
        end
    end
    foodPosition = possiblePos [
        math.random(#possiblePos)
    ]
end
moveFood()


local drawGame = false
local drawOptions = true

function processSnakeInput()
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, -2)
    end
    if get(MCDU_CURRENT_BUTTON) == 0 and drawOptions == true then
        drawGame = true
        drawOptions = false
        snakeAlive = true
        snakeSegments = {
            {x = 3, y = 1},
            {x = 2, y = 1},
            {x = 1, y = 1},
        }
        moveFood()
        directionQueue = {'right'}
        score = 0
    end
end

local function drawCell(x,y,color)
    sasl.gl.drawRectangle(
        (x-1) * screen.cellSize + screen.offset,
        (y-1) * screen.cellSize + 55,
        screen.cellSize - 2,
        screen.cellSize - 2,
        color
    )
end

function processSnakeMovement()
    if get(MCDU_CURRENT_BUTTON) == 24 and directionQueue[#directionQueue] ~= 'right' and directionQueue[#directionQueue] ~= 'left' then
        table.insert(directionQueue, 'left')
    end
    if get(MCDU_CURRENT_BUTTON) == 25 and directionQueue[#directionQueue] ~= 'down' and directionQueue[#directionQueue] ~= 'up' then
        table.insert(directionQueue, 'up')
    end
    if get(MCDU_CURRENT_BUTTON) == 26 and directionQueue[#directionQueue] ~= 'left' and directionQueue[#directionQueue] ~= 'right' then
        table.insert(directionQueue, 'right')
    end
    if get(MCDU_CURRENT_BUTTON) == 27 and directionQueue[#directionQueue] ~= 'up' and directionQueue[#directionQueue] ~= 'down' then
        table.insert(directionQueue, 'down')
    end
end

local function getTick()
    local ticker = sasl.createTimer()
    sasl.resetTimer(ticker)
    sasl.startTimer(ticker)
    return ticker
end



function drawSnake()
    processSnakeInput() -- We get the input
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "SNAKE", title_location.font_size, true, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])

    if drawGame == true then
        sasl.gl.drawFrame(screen.offset-5, screen.offset, screen.x * screen.cellSize + 7, screen.y * screen.cellSize + 3, MCDU_WHITE) -- draw screen

        local ticks = getTick()

        processSnakeMovement() -- Handle the snake controls
        if snakeAlive then
            init = false
            if ticks%30 == 0 then

                if #directionQueue > 1 then
                    table.remove(directionQueue, 1)
                end
                local nextXPosition = snakeSegments[1].x
                local nextYPosition = snakeSegments[1].y
                if snakeSegments[1].x > screen.x or snakeSegments[1].x < 1 or snakeSegments[1].y > screen.y - 1 or snakeSegments[1].y < 1 then
                    snakeAlive = false
                    drawOptions = true
                    drawGame = false
                end

                if directionQueue[1] == 'right' then
                    nextXPosition = nextXPosition + 1
                elseif directionQueue[1] == 'left' then
                    nextXPosition = nextXPosition - 1
                elseif directionQueue[1] == 'down' then
                    nextYPosition = nextYPosition - 1
                elseif directionQueue[1] == 'up' then
                    nextYPosition = nextYPosition + 1
                end
                
                local canMove = true

                for segmentIndex, segment in ipairs(snakeSegments) do
                    if segmentIndex ~= #snakeSegments and nextXPosition == segment.x and nextYPosition == segment.y then
                        canMove = false
                    end
                end

                if canMove then
                    table.insert(snakeSegments, 1, {x = nextXPosition, y = nextYPosition})
                    
                    if snakeSegments[1].x == foodPosition.x and snakeSegments[1].y == foodPosition.y then
                        score = score + 1
                        moveFood()
                    else
                    table.remove(snakeSegments)
                    end
                else
                    snakeAlive = false
                    drawOptions = true
                    drawGame = false
                end
            end

            for segmentIndex, segment in ipairs(snakeSegments) do
                drawCell(segment.x, segment.y, MCDU_GREEN)
            end

            drawCell(foodPosition.x, foodPosition.y, MCDU_RED)
            sasl.gl.drawText(MCDU_FONT, title_location.x+150, title_location.y, "SCORE: "..score, title_location.font_size, false, false, TEXT_ALIGN_CENTER, MCDU_YELLOW)
        end
    end

    if drawOptions == true then
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-150, "USE THE ARROW KEYS", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-title_location.font_size-6-150, "TO CONTROL THE SNAKE", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
        
        if init == false then
            sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-85, "FINAL SCORE: "..score, title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_RED)
            sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-50, "GAME OVER!", title_location.font_size+10, false, false, TEXT_ALIGN_CENTER, MCDU_YELLOW)
        end

        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<PLAY", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end
end