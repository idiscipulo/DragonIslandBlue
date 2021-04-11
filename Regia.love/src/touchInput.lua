TouchInput = {}
TouchInput.__index = TouchInput

---------------------------------
-- CLASS FOR TOUCHSCREEN INPUT --
---------------------------------
-- also works for mouse
function TouchInput:new()
    touchInput = {}
    setmetatable(touchInput, TouchInput)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    touchInput.tapped = false
    touchInput.pressed = false
    touchInput.isStart = false
    touchInput.isDone = false
    touchInput.time = 0
    
    return touchInput
end

-----------
-- CLEAR --
-----------
function TouchInput:clear()
    -- clear variables
    self.tapped = false
    self.pressed = false
    self.isStart = false
    self.isDone = false
    self.time = 0
end

----------
-- DONE --
----------
function TouchInput:done(x, y)
    -- if input has started
    if self.isStart then 
        -- end input
        self.isDone = true
        self.tapped = true
    end
end

-----------
-- START --
-----------
function TouchInput:start(x, y)
    self.isStart = true
end

------------
-- UPDATE --
------------
function TouchInput:update()
    ----------------------
    -- IF INPUT STARTED --
    ----------------------
    if self.isStart then
        -- increment time
        self.time = self.time + 1

        -- if time greater than threshold
        if self.time > TOUCH_PRESSED_THRESHOLD then
            -- end input and register long touch
            self.isDone = true
            self.pressed = true
        end
    end

    --------------------
    -- IF INPUT ENDED --
    --------------------
    if self.isDone then
        -- save values
        local tapped = self.tapped
        local pressed = self.pressed

        -- clear variables
        self:clear()

        -- return values
        return tapped, pressed  
    -- if input has not ended
    else
        return false, false
    end
end