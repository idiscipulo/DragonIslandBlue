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
    customGraphics:swapColors()

    -- initialize battle
    battle =  Battle:new()
end

function love.update()
    -- >> UPDATE GAME HERE <<

    -- update battle
    battle:update()
end

function love.draw()    
    -- set focus to canvas
    love.graphics.setCanvas(canvas)
    -- clear current frame
    love.graphics.clear()

    -- >> DRAW GRAPHICS HERE <<

    -- draw battle
    battle:draw()

    -- remove focus from canvas
    love.graphics.setCanvas()

    -- set pixel shader
    love.graphics.setShader(customGraphics.shader)

    -- draw the canvas
    love.graphics.draw(canvas, 0, 0)

    -- clear shader
    love.graphics.setShader()
end