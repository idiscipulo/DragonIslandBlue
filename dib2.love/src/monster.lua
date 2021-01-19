Monster = {}
Monster.__index = Monster

function Monster:new()
    monster = {}
    setmetatable(monster, Monster)

    -- coords
    monster.player_x = 24
    monster.player_y = 267
    monster.player_width = 128
    monster.player_height = 128
    monster.player_space = 170

    monster.enemy_x = 290
    monster.enemy_y = 22
    monster.enemy_width = 128
    monster.enemy_height = 128
    monster.enemy_space = 170
    ---

    monster.image = nil

    monster.name = ''

    monster.faction = ''
    monster.factionIcon = nil

    monster.level = ''

    monster.health = {}
    monster.health.scale = 0
    monster.health.max = 0
    monster.health.cur = 0

    monster.moves = {}

    monster.team = ''

    monster.status = nil

    monster.time = 0
    monster.oldTime = 0
    monster.order = 0
    monster.pos = 0

    monster.color = nil

    return monster
end

function Monster:setStats(data)
    self.image = love.graphics.newImage('img/monsters/'..data.image..'128.png')

    self.name = data.name

    self.faction = data.faction
    if self.faction == 'GOLDEN' then
        self.factionIcon = love.graphics.newImage('img/faction/golden.png')
    end

    self.level = data.level

    self.health = {}
    self.health.scale = data.healthScale
    self.health.max = math.floor(10 * math.pow(data.healthScale, data.level))
    if data.healthCur == 'nil' then
        self.health.cur = self.health.max
    else
        self.health.cur = data.healthCur
    end

    self.team = data.team

    self.status = data.status
end

function Monster:addMove(move)
    table.insert(self.moves, move)

    move.pos = #self.moves - 1
end

function Monster:takeDamage(damage, type, faction)
    local adjDamage = damage

    if self.faction == faction then
        adjDamage = math.floor(adjDamage * 0.8)
    end

    self.health.cur = math.max(0, (self.health.cur - adjDamage))
end

function Monster:isClickedPlayer(x, y)
    local base_x = self.player_x + (self.pos * self.player_space)
    local basy_y = self.player_y
    if base_x < x and x < base_x + self.player_width then
        if base_y < y and y < base_y + self.player_height then
            return true
        end
    end

    return false
end

function Monster:isClickedEnemy(x, y)
    local base_x = self.enemy_x + (self.pos * self.enemy_space)
    local base_y = self.enemy_y
    if base_x < x and x < base_x + self.enemy_width then
        if base_y < y and y < base_y + self.enemy_height then
            return true
        end
    end

    return false
end

function Monster:update()
    if self.health.cur <= 0 then
        self.status = 'OUT' -- IN, OUT, DEAD
        self.color.status = false
    end
end

function Monster:drawMoves()
    for i = 1, #self.moves do
        self.moves[i]:draw()
    end
end

function Monster:drawPlayer(x, y)
    local x = x or self.player_x + (self.pos * self.player_space)
    local y = y or self.player_y

    love.graphics.rectangle('fill', x, y, self.player_width, self.player_height)
    
    love.graphics.printf({self.color.col, self.name}, x - 21, y + 132, 170, 'center')
    
    local healthPerc = self.health.cur / self.health.max
    healthBarUtility:draw(healthPerc, x - 7, y + 153)

    local healthString = self.health.cur .. '/' .. self.health.max
    love.graphics.printf({self.color.col, healthString}, x - 21, y + 151, 170, 'center')
end

function Monster:drawEnemy(x, y)
    local x = x or self.enemy_x + (self.pos * self.enemy_space)
    local y = y or self.enemy_y

    love.graphics.printf({self.color.col, self.name}, x - 21, y, 170, 'center')

    local healthPerc = self.health.cur / self.health.max
    healthBarUtility:draw(healthPerc, x - 7, y + 21)

    local healthString = self.health.cur .. '/' .. self.health.max
    love.graphics.printf({self.color.col, healthString}, x - 21, y + 19, 170, 'center')

    love.graphics.rectangle('fill', x, y + 39, self.enemy_width, self.enemy_height)
    love.graphics.draw(self.factionIcon, x + 48, y + 151)
end

function Monster:drawTime()
    love.graphics.rectangle('fill', 24, 14 + (32 * self.order), 24, 24)
    love.graphics.printf({self.color.col, self.name}, 58, 18 + (32 * self.order), 158, 'left')
    love.graphics.printf({self.color.col, self.time}, 216, 18 + (32 * self.order), 27, 'right')
end