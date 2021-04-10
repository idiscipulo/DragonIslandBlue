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
    -- initialize palettes
    customGraphics.palettes = {love.image.newImageData('img/palettes/default.png'),
                                love.image.newImageData('img/palettes/sunnyD.png'),
                                love.image.newImageData('img/palettes/denim.png'),
                                love.image.newImageData('img/palettes/pumpkin.png')}

    -- initialize palette swap variables
    customGraphics.curPalette = 1
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
    customGraphics:setColors()

    return customGraphics
end

-------------------
-- SWAP PALETTES --
-------------------
function CustomGraphics:swap()
    self.curPalette = (self.curPalette % #self.palettes) + 1

    self.curCycle = 0

    self:setColors()
end

------------------
-- CYCLE COLORS --
------------------
function CustomGraphics:cycle()
    self.curCycle = (self.curCycle % 5) + 1

    self:setColors()
end

----------------
-- SET COLORS --
----------------
function CustomGraphics:setColors()
    -- retrieve colors from image data
    local r, g, b, a = self.palettes[self.curPalette]:getPixel((0 + self.curCycle) % 5, 0)
    local col1 = {r, g, b, a}
    local r, g, b, a = self.palettes[self.curPalette]:getPixel((1 + self.curCycle) % 5, 0)
    local col2 = {r, g, b, a}
    local r, g, b, a = self.palettes[self.curPalette]:getPixel((2 + self.curCycle) % 5, 0)
    local col3 = {r, g, b, a}
    local r, g, b, a = self.palettes[self.curPalette]:getPixel((3 + self.curCycle) % 5, 0)
    local col4 = {r, g, b, a}
    local r, g, b, a = self.palettes[self.curPalette]:getPixel((4 + self.curCycle) % 5, 0)
    local col5 = {r, g, b, a}

    -- send colors to the shader
    self.shader:send('col1', col1)
    self.shader:send('col2', col2)
    self.shader:send('col3', col3)
    self.shader:send('col4', col4)
    self.shader:send('col5', col5)
end

------------
-- UPDATE --
------------
function CustomGraphics:update(tapped, pressed)
    -- if tap
    if tapped then
        customGraphics:swap()
    -- if hold
    elseif pressed then
        customGraphics:cycle()
    end
end