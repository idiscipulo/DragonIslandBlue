StingMove = {}
StingMove.__index = StingMove
setmetatable(StingMove, Move)

function StingMove:new()
    local stingMove = Move:new('StingMove devastation', 50, 1, 'OTHER', 'PHYS')
    setmetatable(stingMove, StingMove)

    stingMove.damage = 8

    return stingMove
end

function StingMove:use(user, target)
    target:takeDamage(self.damage, self.type, user.faction)
end