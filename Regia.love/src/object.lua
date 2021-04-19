Object = {}
Object.__index = Object

function Object:new(x, y, w, h)
    object = {}
    setmetatable(object, Object)

    object.x = x or 0
    object.y = y or 0
    object.w = w or 0
    object.h = h or 0

    return object
end

function Object:onTapped()
    if self.x <= x and x <= self.x + self.w then
        if self.y <= y and y < self.y + self.h then
            -- do thing        
        end
    end 
end

function Object:onPressed()
    if self.x <= x and x <= self.x + self.w then
        if self.y <= y and y < self.y + self.h then
            -- do thing            
        end
    end 
end

function Object:update()
end

function Object:draw()
    if HACK_VARS.SHOW_HITBOXES then
        love.graphics.setColor(0.8, 0.8, 0.8, 0.5)
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
        love.graphics.setColor(1, 1, 1, 1)
    end
end