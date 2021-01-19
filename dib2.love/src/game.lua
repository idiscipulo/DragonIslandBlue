Game = {}
Game.__index = Game

function Game:new()
    local game = {}
    setmetatable(game, Game)

    -- states
    game.battle = Battle:new(game)

    -- state manager
    game.stateManager = StateManager:new('GameStateManager')
    game.stateManager:addState('BATTLE', game.battle)

    -- start state
    game.stateManager:changeState('BATTLE', {'MONSTER;GOLDEN_JELLYPUP;2;nil;PLAYER;IN', 
                                                'MONSTER;GOLDEN_JELLYPUP;2;nil;PLAYER;IN', 
                                                'MONSTER;GOLDEN_JELLYPUP;2;nil;PLAYER;IN', 
                                                'MONSTER;GOLDEN_JELLYPUP;2;nil;PLAYER;IN', 
                                                'MONSTER;GOLDEN_JELLYPUP;2;nil;ENEMY;IN', 
                                                'MONSTER;GOLDEN_JELLYPUP;2;nil;ENEMY;IN', 
                                                'MONSTER;GOLDEN_JELLYPUP;2;nil;ENEMY;IN'})

    return game
end

function Game:update()
    self.stateManager:update()
end

function Game:draw()
    self.stateManager:draw()
end