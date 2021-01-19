Move = {}
Move.__index = Move

function Move:new(name, time, numTargets, targetType, type)
    move = {}
    setmetatable(move, Move)

    -- coords
    move.x = 535
    move.y = 263
    move.space_x = 132
    move.space_y = 92
    move.width = 118
    move.height = 82
    --

    move.name = name
    move.time = time

    move.numTargets = numTargets
    move.targetType = targetType

    move.type = type

    move.pos = 0

    return move
end

function Move:use(user, targets)
end

function Move:isClicked(x, y)
    local sX = self.pos % 2
    local sY = math.floor(self.pos / 2)
    local base_x = self.x + (sX * self.space_x)
    local base_y = self.y + (sY * self.space_y)
    if base_x < x and x < base_x + self.width then
        if base_y < y and y < base_y + self.height then
            return true
        end
    end

    return false
end

function Move:draw(x, y)
    local sX = self.pos % 2
    local sY = math.floor(self.pos / 2)
    local x = x or self.x + (sX * self.space_x)
    local y = y or self.y + (sY * self.space_y)

    love.graphics.rectangle('fill', x, y, self.width, self.height)
    love.graphics.rectangle('fill', x + 96, y + 60, 25, 25)

    love.graphics.printf(self.name, x + 10, y + 6, 100, 'center')
    love.graphics.printf(self.time, x + 10, y + 54, 100, 'center')
end