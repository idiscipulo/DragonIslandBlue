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
    -- initialize canvas
    canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)

    -- initialize custom graphics
    customGraphics = CustomGraphics:new()

    -- initialize font
    font = love.graphics.newImageFont('font/imgFont.png', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`\'*#=[]"')

    -- initialize touch input
    touchInput = TouchInput:new()

    -- initialize text input
    textInput = TextInput:new()

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

    -- set text input hookup
    if CHEAT then
        textInput:setVerbose(true)
        textInput:hookup(Cheat:new())
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
    local tapped, pressed = touchInput:update()

    textInput:update()

    --------------------------
    -- UPDATE CURRENT STATE --
    --------------------------
    -- update battle
    battle:update()

    ------------------------
    -- NON-STATE HANDLING --
    ------------------------
    -- update shader
    customGraphics:update(tapped, pressed)
end

--------------------
-- MAIN LOOP DRAW --
--------------------
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

------------------------
-- CALLBACK FUNCTIONS --
------------------------

--------------------
-- KEYBOARD INPUT --
--------------------
-- if a key is released
function love:keyreleased(key)
    -- submit the key to text input
    textInput:getKey(key)
end

-----------------------
-- MOUSE/TOUCH INPUT --
-----------------------
-- if mouse or touch is pressed
function love:mousepressed(x, y)
    -- starts input
    touchInput:start(x, y)
end

-- if mouse or touch is released
function love:mousereleased(x, y)
    -- finishes input if it hasn't timed out yet
    touchInput:done(x, y)
end