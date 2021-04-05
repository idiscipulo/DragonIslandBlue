CustomGraphics = {}
CustomGraphics.__index = CustomGraphics

--------------------------------
-- CLASS FOR PALETTE SWAPPING --
--------------------------------
function CustomGraphics:new()
    customGraphics = {}
    setmetatable(customGraphics, CustomGraphics)

    --------------------------
    -- INITIALIZE VARIABLES --
    --------------------------
    -- initialize default palette
    customGraphics.defaultImageData = love.image.newImageData('img/palettes/default.png')

    -- initialize palette swap variables
    customGraphics.curImageData = nil
    customGraphics.curCycle = 0

    -----------------------
    -- INITIALIZE SHADER --
    -----------------------
    -- written in GLSL
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

    -- set default palette
    customGraphics:swapColors()

    return customGraphics
end

----------------------------
-- SWAP OR CYCLE PALETTES --
----------------------------
function CustomGraphics:swapColors(imageData, offset)
    -- if no palette given
    if imageData == nil then
        -- use default palette
        self.curImageData = self.defaultImageData
    -- if palette given
    else
        -- use given palette
        self.curImageData = imageData
    end

    -- send palette to shader with given offset
    self:cycleColors(offset)
end

--------------------------------------
-- CYCLE AND SEND PALETTE TO SHADER --
--------------------------------------
function CustomGraphics:cycleColors(offset)
    -- if no offset given
    if offset == nil then
        -- don't cycle the palette
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