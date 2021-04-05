Input = {}
Input.__index = Input

function Input:new()
    touchInput = {}
    setmetatable(touchInput, Input)

    touchInput.tapped = false
    touchInput.pressed = false
    touchInput.isStart = false
    touchInput.isDone = false
    touchInput.time = 0
    
    return touchInput
end

-- start input
function Input:start(x, y)
    self.isStart = true
end

-- end input
function Input:done(x, y)
    if self.isStart then 
        self.isDone = true
        self.tapped = true
    end
end

function Input:get()
    if self.isDone then
        local tapped = self.tapped
        local pressed = self.pressed

        self:clear()

        return tapped, pressed
    else
        return false, false
    end
end

function Input:clear()
    self.tapped = false
    self.pressed = false
    self.isStart = false
    self.isDone = false
    self.time = 0
end

-- return true/false and consume touchInput if true
function Input:update()
    if self.isStart then
        self.time = self.time + 1
        if self.time > 30 then
            self.isDone = true
            self.pressed = true
        end
    end

    return self:get()
end