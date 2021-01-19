Battle = {}
Battle.__index = Battle

function Battle:new(parent)
    local battle = {}
    setmetatable(battle, Battle)

    battle.parent = parent

    -- colors
    battle.COLOR1 = Color:new({1, 0, 0, 1})
    battle.COLOR2 = Color:new({0, 1, 0, 1})
    battle.COLOR3 = Color:new({0, 0, 1, 1})
    battle.COLOR4 = Color:new({1, 1, 0, 1})
    battle.COLOR5 = Color:new({0, 1, 1, 1})
    battle.COLOR6 = Color:new({1, 0, 1, 1})

    battle.colors = {battle.COLOR1, battle.COLOR2, battle.COLOR3, battle.COLOR4, battle.COLOR5, battle.COLOR6}

    battle.background = love.graphics.newImage('img/background.png')

    -- monster lists
    battle.curMonster = nil
    battle.playerMonsters = {}
    battle.enemyMonsters = {}
    battle.activeMonsters = {}

    -- states
    battle.state = nil
    battle.moveIndex = nil

    battle.delayTimer = 0

    return battle
end

-- monster cycle within tied time order 
function Battle:updateActiveMonsters(start)
    local c = 0
    local newMonsters = {}
    for i = 1, #self.playerMonsters do
        if self.playerMonsters[i].status == 'IN' then
            self.playerMonsters[i].pos = c
            table.insert(newMonsters, self.playerMonsters[i])
            c = c + 1
        end
        if c == 3 then
            break
        end
    end

    c = 0
    local eMonsters = {}
    for i = 1, #self.enemyMonsters do
        if self.enemyMonsters[i].status == 'IN' then
            self.enemyMonsters[i].pos = c
            table.insert(newMonsters, self.enemyMonsters[i])
            c = c + 1
        end
        if c == 3 then
            break
        end
    end

    if start then
        for i = 1, #newMonsters do
            table.insert(self.activeMonsters, newMonsters[i])
        end
    else
        local inc = false
        local pos = {}
        for i = 1, #newMonsters do
            inc = false 
            pos = {}
            for j = 1, #self.activeMonsters do
                if newMonsters[i] == self.activeMonsters[j] then
                    inc = true
                elseif newMonsters[i].team == self.activeMonsters[j].team and self.activeMonsters[j].status == 'OUT' then
                    table.insert(pos, j)
                end
            end

            if not inc then
                self.activeMonsters[pos[1]] = newMonsters[i]
            end
        end
        
        for i = 1, #self.activeMonsters do
            if self.activeMonsters[i].status == 'OUT' then
                table.remove(self.activeMonsters, i)
            end

            if i == #self.activeMonsters then
                break
            end
        end
    end
end

function Battle:updateColors()
    local color = nil

    for i = 1, #self.activeMonsters do
        for j = 1, #self.colors do
            if not self.colors[j].status then
                self.colors[j].status = true
                color = self.colors[j]
                break
            end
        end

        self.activeMonsters[i].color = self.activeMonsters[i].color or color
    end
end

function Battle:updateTime()
    if self.curMonster then
        self.curMonster.time = self.curMonster.time + 1
    end

    for i = 1, #self.activeMonsters - 1 do
        if self.activeMonsters[i].time > self.activeMonsters[i + 1].time then
            local temp1 = self.activeMonsters[i]
            self.activeMonsters[i] = nil
            
            local temp2 = self.activeMonsters[i + 1]
            self.activeMonsters[i + 1] = nil

            self.activeMonsters[i] = temp2
            self.activeMonsters[i + 1] = temp1
        end
    end

    if self.curMonster then
        self.curMonster.time = self.curMonster.time - 1
    end
    self.curMonster = self.activeMonsters[1]

    local time = self.curMonster.time
    for i = 1, #self.activeMonsters do
        self.activeMonsters[i].time = self.activeMonsters[i].time - time
        self.activeMonsters[i].order = i - 1
    end
end

function Battle:start(data)
    for i = 1, #data do
        resp, obj = Factory:create(data[i])
        if resp == 'MONSTER' then
            if obj.team == 'PLAYER' then
                table.insert(self.playerMonsters, obj)
            elseif obj.team == 'ENEMY' then
                table.insert(self.enemyMonsters, obj)
            end
        end
    end

    self:updateActiveMonsters(true)
    self:updateColors()
    self:updateTime()

    local team = self.activeMonsters[1].team
    self.state = team
end

function Battle:update()
    if self.state == 'PLAYER' then
        if mouse.clicked then
            for i = 1, #self.curMonster.moves do
                if self.curMonster.moves[i]:isClicked(mouse.x, mouse.y) then
                    mouse.clicked = false
                    self.moveIndex = i
                end
            end
            
            if self.moveIndex ~= nil then
                if self.curMonster.moves[self.moveIndex].targetType == 'OTHER' then
                    for i = 1, #self.activeMonsters do
                        if self.activeMonsters[i].team == 'ENEMY' then
                            if self.activeMonsters[i]:isClickedEnemy(mouse.x, mouse.y) then
                                mouse.clicked = false

                                self.curMonster.moves[self.moveIndex]:use(self.curMonster, self.activeMonsters[i])
                                self.curMonster.time = self.curMonster.time + self.curMonster.moves[self.moveIndex].time
                                
                                self.moveIndex = nil

                                -- |||||||||||||||||||||||||||||||||||| --
                                for i = 1, #self.activeMonsters do
                                    self.activeMonsters[i]:update()
                                end

                                self:updateActiveMonsters()
                                self:updateColors()
                                self:updateTime()
                        
                                local team = self.activeMonsters[1].team
                                self.state = team

                                break
                                -- |||||||||||||||||||||||||||||||||||| --
                            end
                        end
                    end
                end
            end
        end
    elseif self.state == 'ENEMY' then
        self.delayTimer = self.delayTimer + 1
        if self.delayTimer > 50 then
            self.delayTimer = 0

            self.curMonster.time = self.curMonster.time + 10

            -- |||||||||||||||||||||||||||||||||||| --
            for i = 1, #self.activeMonsters do
                self.activeMonsters[i]:update()
            end

            self:updateActiveMonsters()
            self:updateColors()
            self:updateTime()
    
            local team = self.activeMonsters[1].team
            self.state = team
            -- |||||||||||||||||||||||||||||||||||| --
        end
    end
end

-- see monster parent class for drawing coords
function Battle:draw()
    -- love.graphics.draw(self.background, 0, 0)

    -- menu buttons
    love.graphics.rectangle('fill', 8, 211, 25, 25)
    love.graphics.rectangle('fill', 40, 211, 25, 25)
    love.graphics.rectangle('fill', 72, 211, 25, 25)

    local x = 0
    local y = 0
    for i = 1, #self.activeMonsters do
        if self.activeMonsters[i].team == 'PLAYER' then
            --if self.state ~= 'PLAYER' then 
                self.activeMonsters[i]:drawPlayer()
            --end
        elseif self.activeMonsters[i].team == 'ENEMY' then 
            self.activeMonsters[i]:drawEnemy()
        end

        self.activeMonsters[i]:drawTime()
    end

    if self.state == 'PLAYER' then
        self.curMonster:drawMoves()
    end
end