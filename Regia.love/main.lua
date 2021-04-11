--[[
    Monsters in the world are captured by Alchemists, using Capture Potions.

    THe starting monsters are themed after jellyfish. For the general
    aethetic guide think of a world wear monsterous jellyfish would rule the
    oceans: hot water, high carbon conent, global warming, large forests.
    Surviving animals would be jellyfish, deep sea sharks, crab like 
    creatures, sea urchins, cockroaches, ants, parasites, crocodiles, bats,
    etc.
]]--

----------------------------------
-- CALLED ONCE AT PROGRAM START --
----------------------------------
function love.load()
    ---------------------------
    -- INITIALIZE EVERYTHING --
    ---------------------------
    -- global variable for specifiying global scope
    GLOBAL = {}

    -- initialize canvas
    GLOBAL.canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

    -- initialize custom graphics
    GLOBAL.customGraphics = CustomGraphics:new()

    -- initialize font
    GLOBAL.font = love.graphics.newImageFont('font/imgFont.png', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"')

    -- initialize touch input
    GLOBAL.touchInput = TouchInput:new()

    -- initialize text input
    GLOBAL.textInput = TextInput:new()

    -- initialize battle
    GLOBAL.battle =  Battle:new()

    --------------------
    -- SET EVERYTHING --
    --------------------
    -- set random seed
    love.math.setRandomSeed(os.time())

    -- set pixel scaling filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set font
    love.graphics.setFont(GLOBAL.font)

    -- set text input hookup
    if HACKS then
        GLOBAL.textInput:setVerbose(true)
        GLOBAL.textInput:hookup(Hacks:new())
    end

    -- set screen
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, OPTIONS)

end

----------------------
-- MAIN LOOP UPDATE --
----------------------
function love.update()
    ----------------
    -- GET INPUTS --
    ----------------
    -- get mouse touchInput
    local tapped, pressed = GLOBAL.touchInput:update()

    GLOBAL.textInput:update()

    --------------------------
    -- UPDATE CURRENT STATE --
    --------------------------
    -- update battle
    GLOBAL.battle:update()
end

--------------------
-- MAIN LOOP DRAW --
--------------------
function love.draw()
    --------------------
    -- DRAW TO CANVAS --
    --------------------
    -- set focus to canvas
    love.graphics.setCanvas(GLOBAL.canvas)
    -- clear current frame
    love.graphics.clear()

    -----------------------------
    -- DRAW ELEMENTS TO CANVAS --
    -----------------------------
    -- draw battle
    GLOBAL.battle:draw()

    ---------------------------
    -- DRAW CANVAS TO WINDOW --
    ---------------------------
    -- remove focus from canvas
    love.graphics.setCanvas()

    -- set pixel shader
    love.graphics.setShader(GLOBAL.customGraphics.shader)

    -- draw the canvas
    love.graphics.draw(GLOBAL.canvas, 0, 0)

    -- clear shader
    love.graphics.setShader()
end

------------------------
-- CALLBACK FUNCTIONS --
------------------------

--------------------
-- KEYBOARD INPUT --
--------------------
-- if a key is released
function love:keyreleased(key)
    -- submit the key to text input
    GLOBAL.textInput:getKey(key)
end

-----------------------
-- MOUSE/TOUCH INPUT --
-----------------------
-- if mouse or touch is pressed
function love:mousepressed(x, y)
    -- starts input
    GLOBAL.touchInput:start(x, y)
end

-- if mouse or touch is released
function love:mousereleased(x, y)
    -- finishes input if it hasn't timed out yet
    GLOBAL.touchInput:done(x, y)
end