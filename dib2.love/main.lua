--[[
    Monsters in the world are captured by Alchemists, using Capture Potions.

    THe starting monsters are themed after jellyfish. For the general
    aethetic guide think of a world wear monsterous jellyfish would rule the
    oceans: hot water, high carbon conent, global warming, large forests.
    Surviving animals would be jellyfish, deep sea sharks, crab like 
    creatures, sea urchins, cockroaches, ants, parasites, crocodiles, bats,
    etc.
]]--

-- load function
function love.load()
    -- set random seed
    love.math.setRandomSeed(os.time())

    -- set pixel scaling filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- setup font
    font = love.graphics.newImageFont('font/imgFont.png', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"')
    fontBig = love.graphics.newImageFont('font/imgFontBig.png', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"')
    love.graphics.setFont(font)

    -- mouse
    mouse = {
        clicked = false,
        x = 0,
        y = 0
    }

    -- health bars
    healthBarUtility = HealthBarUtility:new()

    -- init game
    game = Game:new()

    -- input
    KEYDOWN = false

    -- create screen
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, OPTIONS)

    -- game canvas
    canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
end

function love.update()
    game:update()
end

function love.draw()
    love.graphics.setCanvas(canvas)

    love.graphics.clear()

    love.graphics.setColor({1, 0.8, 0.8, 1})
    love.graphics.rectangle('fill', 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor({1, 1, 1, 1})

    game:draw()

    love.graphics.setCanvas()

    love.graphics.draw(canvas, 0, 0)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.push('quit')
    else
        KEYDOWN = true
    end
end

function love.mousepressed(x, y)
    mouse.clicked = true
    mouse.x = x
    mouse.y = y
end