CustomGraphics = {}
CustomGraphics.__index = CustomGraphics

function CustomGraphics:new()
    customGraphics = {}
    setmetatable(customGraphics, CustomGraphics)

    customGraphics.shader = love.graphics.newShader[[
        extern vec4 col1;
    
        vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords) {
            vec4 pixel = Texel(texture, textureCoords);
            return pixel * col1;
        }
    ]]

    return customGraphics
end

function CustomGraphics:swapColors() -- this will eventually take an image to pull colors from
    col1 = {1, 1, 0, 1}
    col2 = {1, 0, 1, 1}
    -- col3 = {1, 1, 0, 1}
    -- col4 = {1, 1, 0, 1}
    -- col5 = {1, 1, 0, 1}

    self.shader:send('col1', col1)
end