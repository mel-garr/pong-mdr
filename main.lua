require 'src/Dependencies'

function love.load()
    love.window.setTitle('pong_mdr')
    love.graphics.setDefaultFilter('nearest', 'nearest')
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

    if gamestate == 'play' then
        b1:update(dt)
        p1:update(dt)
        p2:update(dt)
    end
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    b1:render()
    p1:render()
    p2:render()
    displayFPS()
    love.graphics.print('game state: ' ..gamestate, 5, 15)
    push:finish()

end

function displayFPS()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' ..tostring(love.timer.getFPS()), 5, 5)

end