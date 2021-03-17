CustomGraphics = {}
CustomGraphics.__index = CustomGraphics

function CustomGraphics:new()
    customGraphics = {}
    setmetatable(customGraphics, CustomGraphics)

    customGraphics.shader = love.graphics.newShader[[
        extern vec4 col1;
        extern vec4 col2;
        extern vec4 col3;
        extern vec4 col4;
        extern vec4 col5;
    
        vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords) {
            vec4 pixel = Texel(texture, textureCoords);
            if(pixel.r == 1) {
                return col1;
            } else if(pixel.r == 0.8) {
                return col2;
            } else if(pixel.r == 0.6) {
                return col3;
            } else if(pixel.r == 0.4) {
                return col4;
            } else if(pixel.r == 0.2) {
                return col5;
            }
        }
    ]]

    return customGraphics
end

-- https://doc.instantreality.org/tools/color_calculator/
function CustomGraphics:swapColors() -- this will eventually take an image to pull colors from
    col1 = {1, 0.8, 0.9, 1}
    col2 = {1, 0.7, 0.9, 1}
    col3 = {0.5, 0.5, 0.9, 1}
    col4 = {0.3, 0.8, 1, 1}
    col5 = {0.9, 0.7, 0.3, 1}

    self.shader:send('col1', col1)
    self.shader:send('col2', col2)
    self.shader:send('col3', col3)
    self.shader:send('col4', col4)
    self.shader:send('col5', col5)
end