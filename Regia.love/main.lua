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
    -- set random seed
    love.math.setRandomSeed(os.time())

    -- set pixel scaling filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- initialize font
    font = love.graphics.newImageFont('font/imgFont.png', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"')
    love.graphics.setFont(font)

    -- initialize screen
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, OPTIONS)

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

    -- initialize tap
    input = Input:new()

    -- initialize battle
    battle =  Battle:new()
end

function love.update()
    ----------------------
    -- UPDATE GAME HERE --
    ----------------------
    
    -- if true consume input
    local tapped, pressed = input:update()

    if tapped then
        -- cycle the color palettes
        paletteIndex = (paletteIndex % #palettes) + 1
        customGraphics:swapColors(palettes[paletteIndex], cycleIndex)
    elseif pressed then
        -- cycle the colors in the palette
        cycleIndex = (cycleIndex % 5) + 1
        customGraphics:cycleColors(cycleIndex)
    end

    -- update battle
    battle:update()
end

function love.draw()
    --------------------
    -- DRAW TO CANVAS --
    --------------------

    -- set focus to canvas
    love.graphics.setCanvas(canvas)
    -- clear current frame
    love.graphics.clear()

    -- >> DRAW GRAPHICS HERE <<

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

function love:keypressed(key)
    -- start input
    input:start()
end

function love:keyreleased(key)
    -- finish input
    input:done()
end