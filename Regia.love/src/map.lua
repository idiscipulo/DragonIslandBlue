Map = {}
Map.__index = Map

function Map:new()
    local map = {}
    setmetatable(map, Map)

    map.background = love.graphics.newImage('img/backgrounds/map.png')

    map.nodes = {}
    map.nodes.village = Object:new(16, 16, 32, 32)

    return map
end

function Map:update()
end

function Map:draw()
    for key, val in pairs(self.nodes) do
        val:draw()
    end
end