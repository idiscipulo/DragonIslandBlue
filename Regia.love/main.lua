--[[
    Monsters in the world are captured by Alchemists, using Capture Potions.

    THe starting monsters are themed after jellyfish. For the general
    aethetic guide think of a world wear monsterous jellyfish would rule the
    oceans: hot water, high carbon conent, global warming, large forests.
    Surviving animals would be jellyfish, deep sea sharks, crab like 
    creatures, sea urchins, cockroaches, ants, parasites, crocodiles, bats,
    etc.
]]--

function love.load()
    ---------------------------
    -- INITIALIZE EVERYTHING --
    ---------------------------
    -- initialize canvas
    canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

    -- initialize custom graphics
    customGraphics = CustomGraphics:new()

    -- initialize palettes
    palettes = {love.image.newImageData('img/palettes/default.png'),
                love.image.newImageData('img/palettes/sunnyD.png'),
                love.image.newImageData('img/palettes/denim.png'),
                love.image.newImageData('img/palettes/pumpkin.png')}
    paletteIndex = 1
    cycleIndex = 1

    -- initialize font
    font = love.graphics.newImageFont('font/imgFont.png', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"')

    -- initialize tap
    touchInput = Input:new()

    -- initialize battle
    battle =  Battle:new()

    --------------------
    -- SET EVERYTHING --
    --------------------
    -- set random seed
    love.math.setRandomSeed(os.time())

    -- set pixel scaling filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set font
    love.graphics.setFont(font)

    -- set screen
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, OPTIONS)

end

function love.update()
    ----------------
    -- GET INPUTS --
    ----------------
    -- get mouse touchInput
    local tapped, pressed = touchInput:update()

    --------------------------
    -- UPDATE CURRENT STATE --
    --------------------------
    -- update battle
    battle:update()

    ------------------------
    -- NON-STATE HANDLING --
    ------------------------
    -- if tap
    if tapped then
        -- cycle the color palettes
        paletteIndex = (paletteIndex % #palettes) + 1
        customGraphics:swapColors(palettes[paletteIndex], cycleIndex)
    -- if hold
    elseif pressed then
        -- cycle the colors in the palette
        cycleIndex = (cycleIndex % 5) + 1
        customGraphics:cycleColors(cycleIndex)
    end
end

function love.draw()
    --------------------
    -- DRAW TO CANVAS --
    --------------------
    -- set focus to canvas
    love.graphics.setCanvas(canvas)
    -- clear current frame
    love.graphics.clear()

    -----------------------------
    -- DRAW ELEMENTS TO CANVAS --
    -----------------------------
    -- draw battle
    battle:draw()

    ---------------------------
    -- DRAW CANVAS TO WINDOW --
    ---------------------------
    -- remove focus from canvas
    love.graphics.setCanvas()

    -- set pixel shader
    love.graphics.setShader(customGraphics.shader)

    -- draw the canvas
    love.graphics.draw(canvas, 0, 0)

    -- clear shader
    love.graphics.setShader()
end

function love:mousepressed(x, y)
    -----------------
    -- start input --
    -----------------
    touchInput:start(x, y)
end

function love:mousereleased(x, y)
    ------------------
    -- finish input --
    ------------------
    -- finishes if the touch has not timed out
    touchInput:done(x, y)
end