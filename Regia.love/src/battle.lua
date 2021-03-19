Battle = {}
Battle.__index = Battle

function Battle:new(parent)
    local battle = {}
    setmetatable(battle, Battle)

    -- load background image
    battle.background = love.graphics.newImage('img/backgrounds/battle.png')

    return battle
end

function Battle:update()
end

function Battle:draw()
    love.graphics.draw(self.background, 0, 0)
end