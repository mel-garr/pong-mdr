Ball = Class{}


function Ball:init()
    self.width = 4
    self.height = 4
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)
end

function Ball:update(dt)
    if (self.y <= 0) or (self.y + self.height >= VIRTUAL_HEIGHT) then
        self.dy = -self.dy
    end
    if (self.x <= 0) then
        gamestate = 'serve'
        self:reset(2)
        p2.score = p2.score + 1
    end
    if (self.x >= VIRTUAL_WIDTH) then
        gamestate = 'serve'
        self:reset(1)
        p1.score = p1.score + 1
    end
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset(servingPlayer)
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(10, 50) * (servingPlayer == 1 and -1 or 1)
    winner_player = servingPlayer
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end
    return true
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
