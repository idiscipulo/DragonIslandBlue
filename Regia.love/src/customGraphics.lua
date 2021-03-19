CustomGraphics = {}
CustomGraphics.__index = CustomGraphics

function CustomGraphics:new()
    customGraphics = {}
    setmetatable(customGraphics, CustomGraphics)

    -- data for pulling colors
    customGraphics.defaultImageData = love.image.newImageData('img/palettes/default.png')
    customGraphics.curImageData = nil
    customGraphics.curCycle = 0

    -- the actual shader
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
            } else {
                return vec4 (0, 0, 0, 1);
            }
        }
    ]]

    -- initialize the colors for the shader
    customGraphics:swapColors()

    return customGraphics
end

function CustomGraphics:swapColors(imageData, offset)
    -- get image to pull colors from
    if imageData == nil then
        self.curImageData = self.defaultImageData
    else
        self.curImageData = imageData
    end

    -- select and send colors to the shader
    self:cycleColors(offset)
end

function CustomGraphics:cycleColors(offset)
    if offset == nil then
        offset = 0
    end

    -- retrieve colors from image data
    local r, g, b, a = self.curImageData:getPixel((0 + offset) % 5, 0)
    local col1 = {r, g, b, a}
    local r, g, b, a = self.curImageData:getPixel((1 + offset) % 5, 0)
    local col2 = {r, g, b, a}
    local r, g, b, a = self.curImageData:getPixel((2 + offset) % 5, 0)
    local col3 = {r, g, b, a}
    local r, g, b, a = self.curImageData:getPixel((3 + offset) % 5, 0)
    local col4 = {r, g, b, a}
    local r, g, b, a = self.curImageData:getPixel((4 + offset) % 5, 0)
    local col5 = {r, g, b, a}

    -- send colors to the shader
    self.shader:send('col1', col1)
    self.shader:send('col2', col2)
    self.shader:send('col3', col3)
    self.shader:send('col4', col4)
    self.shader:send('col5', col5)
end