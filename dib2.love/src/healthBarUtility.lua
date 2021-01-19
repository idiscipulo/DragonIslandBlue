HealthBarUtility = {}
HealthBarUtility.__index = HealthBarUtility

function HealthBarUtility:new()
    local healthBarUtility = {}
    setmetatable(healthBarUtility, HealthBarUtility)

    healthBarUtility.frame = love.graphics.newImage('img/misc/healthFrame.png')
    healthBarUtility.bar = love.graphics.newImage('img/misc/healthBar.png')

    return healthBarUtility
end

function HealthBarUtility:draw(percHealth, x, y)
    love.graphics.draw(self.frame, x, y)
    love.graphics.draw(self.bar, x + 7, y + 2, 0, percHealth, 1)
end