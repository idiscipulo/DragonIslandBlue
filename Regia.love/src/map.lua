Map = {}
Map.__index = Map

function Map:new()
    local map = {}
    setmetatable(map, Map)

    return map
end