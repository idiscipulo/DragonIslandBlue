TextInput = {}
TextInput.__index = TextInput

---------------------------------
-- CLASS FOR TOUCHSCREEN INPUT --
---------------------------------
-- also works for mouse
function TextInput:new()
    textInput = {}
    setmetatable(textInput, TextInput)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    textInput.keyQ = {}
    textInput.string = ''

    textInput.verbose = false

    textInput.hookups = {}

    print()
    
    return textInput
end

---------------
-- GET INPUT --
---------------
function TextInput:getKey(key)
    table.insert(self.keyQ, key)
end

function TextInput:setVerbose(val)
    self.verbose = val
end

function TextInput:hookup(hook)
    table.insert(self.hookups, hook)
end

function TextInput:submit()
    local allRes = ''
    local res = ''

    for i = 1, #self.hookups do
        self.hookups[i]:submit(self.string)
    end

    self.string = ''
end

function TextInput:cleanString()
    local sLen = #self.string
    self.string = string.gsub(self.string, '^%s*(.-)%s*$', '%1')
    self.string = string.lower(self.string)
end

------------------------------------
-- UPDATE INPUT AND RETURN STATUS --
------------------------------------
function TextInput:update()
    -- init local variables
    local key = nil
    local new = false

    -- if keys in the queue
    if #self.keyQ > 0 then
        -- pop value from queue
        key = table.remove(self.keyQ)
    end

    if key ~= nil then
        -- filter special characters
        if key == 'space' then
            key = ' '
        elseif key == 'return' then
            key = ''
            new = true
        elseif key == 'backspace' then
            io.write('\b')
            io.write(' ')
            io.write('\b')
            
            self.string = string.sub(self.string, 1, #self.string - 1)
            key = ''
        elseif string.len(key) > 1 then
            key = ''
        end

        if self.verbose then
            -- write to console
            io.write(key)
        end
        
        self.string = string.format('%s%s', self.string, key)

        if new then
            self:cleanString()

            self:submit()
        end
    end

    return nil
end