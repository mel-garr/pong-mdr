Paddle = Class{}

function Paddle:init(side)
    self.width = 4
    self.height = 12
    self.x = side == 'left' and 20 or VIRTUAL_WIDTH - 20 - self.width
    self.y = VIRTUAL_HEIGHT / 2 - self.height/2
    self.score = 0
end

function Paddle:update(dt)
end


function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end