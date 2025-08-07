love.graphics.setDefaultFilter('nearest', 'nearest')
require 'src/Dependencies'

function love.load()
    love.window.setTitle('pong_mdr')
    math.randomseed(os.time())
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })
    gamestate = 'play'
    b1 = Ball()
    p1 = Paddle('left')
    p2 = Paddle('right')
    love.keyboard.keysPressed = {} 
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'space' then
        if gamestate == 'play' then
            gamestate = 'pause'
        else
            gamestate = 'play'
        end
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    if p1.score == MAX_SCORE or p2.score == MAX_SCORE then
        gamestate = 'done'
        p1.score = 0
        p2.score = 0
    end
    if love.keyboard.isDown('s') then
        p1.dy = PADDLE_SPEED
    elseif love.keyboard.isDown('z') then
        p1.dy = -PADDLE_SPEED
    else
        p1.dy = 0
    end
    if love.keyboard.isDown('up') then
        p2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        p2.dy = PADDLE_SPEED
    else
        p2.dy = 0
    end
    if b1:collides(p1) then
        b1.dx = -b1.dx * 1.03
        b1.x = p1.x + 5
        if b1.dy < 0 then
            b1.dy  = -math.random(10, 150)
        else
            b1.dy = math.random(10, 150)
        end
    end
    if b1:collides(p2) then 
        b1.dx = -b1.dx * 1.03
        b1.x = p2.x - 4
        if b1.dy < 0 then
            b1.dy = -math.random(10, 150)
        else
            b1.dy = math.random(10, 150)
        end
    end

    if gamestate == 'play' then
        b1:update(dt)
    end
    p1:update(dt)
    p2:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    displayFPS()
    love.graphics.print('game state: ' ..gamestate, 5, 15)
    if gamestate == 'play' or gamestate == 'pause' or gamestate == 'serve' then
        love.graphics.setColor(255, 255, 255, 255)
        b1:render()
        p1:render()
        p2:render()
        love.graphics.setFont(gfonts['score'])
        love.graphics.print(p1.score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
        love.graphics.print(p2.score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
    end
    if gamestate == 'done' then
        love.graphics.setFont(gfonts['small'])
        love.graphics.printf('the winner is ' ..winner_player, 0, VIRTUAL_HEIGHT /2, VIRTUAL_WIDTH, 'center')
    end
    push:finish()

end
function displayFPS()
    love.graphics.setFont(gfonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' ..tostring(love.timer.getFPS()), 5, 5)
end
