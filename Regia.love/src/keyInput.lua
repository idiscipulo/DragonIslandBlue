KeyInput = {}
KeyInput.__index = KeyInput

---------------------------------
-- CLASS FOR TOUCHSCREEN INPUT --
---------------------------------
-- also works for mouse
function KeyInput:new()
    keyInput = {}
    setmetatable(keyInput, KeyInput)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    keyInput.keyQ = {}
    
    return keyInput
end

---------------
-- GET INPUT --
---------------
function KeyInput:trigger(key)
    table.insert(self.keyQ, key)
end

------------------------------------
-- UPDATE INPUT AND RETURN STATUS --
------------------------------------
function KeyInput:update()
    -- init local return
    local ret = nil

    -- if keys in the queue
    if #self.keyQ > 0 then
        -- pop value from queue
        ret = table.remove(self.keyQ)
    end

    return ret
end