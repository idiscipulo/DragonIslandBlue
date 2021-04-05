Battle = {}
Battle.__index = Battle

-----------------------
-- CLASS FOR BATTLES --
-----------------------
function Battle:new(parent)
    local battle = {}
    setmetatable(battle, Battle)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    -- load background image
    battle.background = love.graphics.newImage('img/backgrounds/battle.png')

    return battle
end

------------
-- UPDATE --
------------
function Battle:update()
end

----------
-- DRAW --
----------
function Battle:draw()
    -- draw background
    love.graphics.draw(self.background, 0, 0)
end