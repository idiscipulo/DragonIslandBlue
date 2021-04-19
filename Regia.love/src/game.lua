Game = {}
Game.__index = Game

----------
-- GAME --
----------
-- main game class
function Game:new()
    local game = {}
    setmetatable(game, Game)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    game.battle = Battle:new()
    game.map = Map:new()

    -- set current state
    game.curState = game.map

    return game
end

------------
-- UPDATE --
------------
function Game:update()
    self.curState:update()
end

----------
-- DRAW --
----------
function Game:draw()
    self.curState:draw()
end