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
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Ball:collides(paddle)

end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
