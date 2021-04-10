Cheat = {}
Cheat.__index = Cheat

function Cheat:new()
    local cheat = {}
    setmetatable(cheat, Cheat)
    
    return cheat
end

function Cheat:submit(str)
    if str == '' then
        return 'NO INPUT'
    else
        return 'SUCCESS'
    end
end