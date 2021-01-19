GoldenJellypupMonster = {}
GoldenJellypupMonster.__index = GoldenJellypupMonster
setmetatable(GoldenJellypupMonster, Monster)

function GoldenJellypupMonster:new(level, healthCur, team, status)
    goldenJellypupMonster = Monster:new()
    setmetatable(goldenJellypupMonster, GoldenJellypupMonster)

    -- don't change this to initialize with :new()
    -- @future.isaiah i'm doing it this way for visibility
    -- of variable meaning
    local data = {
        image = 'goldenJellypup',
        name = 'Golden Jellypup',
        faction = 'GOLDEN',
        level = level,
        healthScale = 1.2,
        healthMax = 10, -- health.max @ level 1
        healthCur = healthCur,
        team = team,
        status = status}

    goldenJellypupMonster:setStats(data)
    goldenJellypupMonster:addMove(StingMove:new())
    goldenJellypupMonster:addMove(StingMove:new())    
    goldenJellypupMonster:addMove(StingMove:new())
    
    return goldenJellypupMonster
end