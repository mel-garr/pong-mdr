Paddle = Class{}

function Paddle:init(side)
    self.width = 4
    self.height = 20
    self.x = side == 'left' and 20 or VIRTUAL_WIDTH - 20 - self.width
    self.y = VIRTUAL_HEIGHT / 2 - self.height/2
    self.score = 0
    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y+ self.dy * dt)
    end

end


function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end