--DEFINE BALL AND BALL PROPERTIES
drawGame = false
drawOptions = true

local ball = {}
ball.x = 239
ball.y = 216
ball.vel = {}
ball.vel.x = 0
ball.vel.y = 0
ball.height = 20
ball.width = 20


-- DEFINE MAP
local map = {}
map.offset = 5
map.width = 480
map.height = 353

a = {}
a.width = 5
a.height = 80
a.y = 200
a.x = 475

b = {}
b.width = 5
b.height = 80
b.y = 250
b.x = 10

a.score = 0
b.score = 0


function processPongInput()
    if get(MCDU_CURRENT_BUTTON) == 25 and b.y + b.height < map.height + map.offset then
        b.y = b.y + 25
    end
    if get(MCDU_CURRENT_BUTTON) == 27 and b.y > map.offset then
        b.y = b.y - 25
    end
    if get(MCDU_CURRENT_BUTTON) == 0 then
        print("Fat")
        ball.vel.x = 3
        ball.vel.y = 1
        drawGame = true
        drawOptions = false
        print("Fat")
        a.score = 0
        b.score = 0
    end
    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, -2)
    end
end






function drawPong()
    if a.score > 2 or b.score > 2 then
        if a.score > 3 then
            sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[1]-20, "AI WINS", mcdu_option_size, true, false, TEXT_ALIGN_CENTER, MCDU_ORANGE)
        else
            sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[1]-20, "PLAYER WINS", mcdu_option_size, true, false, TEXT_ALIGN_CENTER, MCDU_ORANGE)
        end
        drawGame = false
        drawOptions = true
        ball.vel.x = 0
        ball.vel.y = 0
    end

    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "PONG", title_location.font_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])

    ball.x = ball.x + ball.vel.x
    ball.y = ball.y + ball.vel.y

    --DEFINE MAP
    if ball.x >= (map.width + map.offset) - ball.width then
        b.score = b.score + 1
        ball:reset()
    end
    if ball.x <= map.offset then
        a.score = a.score+1
        ball:reset()
    end

    --WALL BOUNCE
    if ball.y <= map.offset then
        ball:bounce(1,-1)
    end
    if ball.y >= (map.height + map.offset) - ball.height then
        ball:bounce(1,-1)
    end

    -- paddles bounces
    if ball.x > a.x - ball.width and ball.y <= a.y + a.height and ball.y >= a.y-ball.height then
        ball:bounce(-1,1)
        ball.x = ball.x - 10
    end
    if ball.x < b.x + 5 and ball.y <= b.y + b.height and ball.y >= b.y - ball.height then
        ball:bounce(-1,1)
        ball.x = ball.x + 10
    end

    --Keys testing
    processPongInput()


    function ball:bounce(x,y)
        self.vel.x = x * self.vel.x
        self.vel.y = y * self.vel.y
    end

    function ball:reset()
        ball.x = 239
        ball.y = 216
        ball.vel = {}
        ball.vel.x = 3
        ball.vel.y = 1
        ball.height = 20
        ball.width = 20
    end

    -- Draw objects
    if drawGame == true then
        sasl.gl.drawRectangle(ball.x, ball.y, ball.width, ball.height,MCDU_BLUE)
        sasl.gl.drawFrame(map.offset, map.offset, map.width, map.height, {0.1, 0.1, 0.1, 1.0})

    --Draw paddles
        sasl.gl.drawRectangle(a.x, a.y, a.width, a.height)
        sasl.gl.drawRectangle(b.x, b.y, b.width, b.height)

        sasl.gl.drawText(MCDU_FONT, title_location.x, option_heading_locations[1]-20, b.score.. "-"..a.score, mcdu_option_size, true, false, TEXT_ALIGN_CENTER, MCDU_WHITE)
    end

    -- MISS CHANCE
    local miss_threshold = 10
    local willMiss = math.random(1, 100)
    if willMiss <= miss_threshold then
        a.y = a.y + 20
    end

    --PLAYER A AI CONTROLS
    --calculate y hit location
    if ball.y > a.y + (a.height/ 2) and miss_threshold < willMiss then
        a.y = a.y + 15
    end

    if ball.y < a.y + (a.height / 2) and miss_threshold < willMiss then
        a.y = a.y - 15
    end


    if drawOptions == true then
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-100, "USE THE ARROW KEYS", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
        sasl.gl.drawText(MCDU_FONT, title_location.x, mcdu_positions[1]-title_location.font_size-6-100, "TO CONTROL THE PADDLE", title_location.font_size, true, false, TEXT_ALIGN_CENTER, MCDU_GREEN)
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[1], "<PLAY", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[5], "<RESET BALL", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        sasl.gl.drawText(MCDU_FONT, 2, mcdu_positions[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    end
end