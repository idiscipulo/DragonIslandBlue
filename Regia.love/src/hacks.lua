Hacks = {}
Hacks.__index = Hacks

function Hacks:new()
    local hacks = {}
    setmetatable(hacks, Hacks)
    
    return hacks
end

function Hacks:help()
    print('----------------')
    print('-- HACKS HELP --')
    print('----------------')
    print('SET PALETTE #')
    print('   - changes the current palette.')
    print('   1-default  2-denim')
    print('   3-pumpkin  4-sunnyD')
    print()
    print('CYCLE PALETTE')
    print('   - cycles the colors.')
end

function Hacks:parseCycle(tokens)
    local token = table.remove(tokens, 1)

    if token == 'palette' then
        GLOBAL.customGraphics:cycle()
    end
end

function Hacks:parseSet(tokens)
    local token = table.remove(tokens, 1)

    if token == 'palette' then
        local idx = tonumber(table.remove(tokens, 1))
        GLOBAL.customGraphics:swap(idx)
    end
end

function Hacks:submit(str)
    print()

    local tokens = {}
    for s in string.gmatch(str, "%S+") do 
        table.insert(tokens, s)
    end

    local token = ''
    if #tokens > 0 then
        token = table.remove(tokens, 1)
    end

    if token == 'help' then
        self:help()
    elseif token == 'set' then
        self:parseSet(tokens)
    elseif token == 'cycle' then
        self:parseCycle(tokens)
    end
end