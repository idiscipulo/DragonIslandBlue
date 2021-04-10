Cheat = {}
Cheat.__index = Cheat

function Cheat:new()
    local cheat = {}
    setmetatable(cheat, Cheat)
    
    cheat.keyInput = KeyInput:new()
    cheat.string = ''

    return cheat
end

function Cheat:getKey(key)
    if CHEAT then
        self.keyInput:trigger(key)
    end
end

function Cheat:submit()
    self.string = ''
    self.new = false
end

function Cheat:update(tapped, pressed)
    if CHEAT then
        -- get key
        local key = self.keyInput:update()

        -- variables
        local new = false
        
        if key ~= nil then
            -- filter special characters
            if key == 'space' then
                key = ' '
            elseif key == 'return' then
                key = ''
                new = true
            elseif key == 'backspace' then
                io.write('\b')
                
                self.string = string.sub(self.string, 1, #self.string - 1)
                key = ''
            elseif string.len(key) > 1 then
                key = ''
            end
            
            self.string = self.string..key

            -- write to console
            io.write(key)

            if new then
                self:submit()
            end
        end
    end
end