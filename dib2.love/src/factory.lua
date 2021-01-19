Factory = {}
Factory.__index = Factory
  
function Factory:split(str, delim)
    if delim == nil then
            delim = "%s"
    end
    local t={}
    for substr in string.gmatch(str, "([^"..delim.."]+)") do
            table.insert(t, substr)
    end
    return t
end

function Factory:create(str)
    splitStr = Factory:split(str, ';')

    local command = splitStr[1]
    
    if command == 'MONSTER' then
        local name = splitStr[2]
        local level = splitStr[3]
        local healthCur = splitStr[4]
        local team = splitStr[5]
        local status = splitStr[6]

        if name == 'GOLDEN_JELLYPUP' then
            local monster = GoldenJellypupMonster:new(level, healthCur, team, status) 
        end


        return 'MONSTER', monster
    end

    return nil, nil
end