TextInput = {}
TextInput.__index = TextInput

---------------
-- TEXTINPUT --
---------------
function TextInput:new()
    textInput = {}
    setmetatable(textInput, TextInput)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    -- text variables
    textInput.keyQ = {}
    textInput.string = ''

    -- settings
    textInput.verbose = false
    textInput.hooks = {}
    
    return textInput
end

-----------------
-- CLEANSTRING --
-----------------
function TextInput:cleanString()
    -- remove trailing/leading spaces
    self.string = string.gsub(self.string, '^%s*(.-)%s*$', '%1')

    -- throw to lowercase
    self.string = string.lower(self.string)
end

------------
-- GETKEY --
------------
function TextInput:getKey(key)
    -- insert key into queue
    table.insert(self.keyQ, key)
end

------------
-- HOOKUP --
------------
-- add class to recieve the string when submitted
function TextInput:hookup(hook)
    -- add hook to list
    table.insert(self.hooks, hook)
end

----------------
-- SETVERBOSE --
----------------
-- whether or not to print to console
function TextInput:setVerbose(val)
    self.verbose = val
end

------------
-- SUBMIT --
------------
-- send string to hooks
function TextInput:submit()
    -- for each hook
    for i = 1, #self.hooks do
        -- send string to hook
        self.hooks[i]:submit(self.string)
    end

    -- reset string
    self.string = ''
end

------------
-- UPDATE --
------------
function TextInput:update()
    -- init local variables
    local key = nil
    local ret = false

    -- if keys in the queue
    if #self.keyQ > 0 then
        -- pop key from queue
        key = table.remove(self.keyQ)

        -- filter special characters
        if key == 'space' then
            -- set space character
            key = ' '
        elseif key == 'return' then
            -- clear character
            key = ''

            -- set return
            ret = true
        elseif key == 'backspace' then
            -- clear previous character from console
            if self.verbose then
                io.write('\b')
                io.write(' ')
                io.write('\b')
            end
            
            -- clear previous character from string
            self.string = string.sub(self.string, 1, #self.string - 1)

            -- clear character
            key = ''

        -- ignore special characters
        elseif string.len(key) > 1 then
            -- clear character
            key = ''
        end

        if self.verbose then
            -- write character to console
            io.write(key)
        end
        
        -- append character to string
        self.string = string.format('%s%s', self.string, key)

        -- if return key
        if ret then
            -- clean string
            self:cleanString()

            -- submit string to hooks
            self:submit()
        end
    end

    return nil
end