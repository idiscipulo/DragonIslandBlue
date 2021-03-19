Input = {}
Input.__index = Input

function Input:new()
    input = {}
    setmetatable(input, Input)

    input.tapped = false
    input.pressed = false
    input.isStart = false
    input.isDone = false
    input.time = 0
    
    return input
end

-- start input
function Input:start()
    self.isStart = true
end

-- end input
function Input:done()
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

-- return true/false and consume input if true
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