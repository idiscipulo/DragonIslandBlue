function love.conf(t)
    ---------------------------
    -- LOVE2D CONFIGURATIONS --
    ---------------------------
    t.window.highdpi = true

    ------------------------------
    -- DISABLE FOR DISTRIBUTION --
    ------------------------------
    -- print to console
    t.console = true

    -- enable cheats and editing
    HACKS = true

    ---------------
    -- CONSTANTS --
    ---------------
    -- screen constants
    SCREEN_WIDTH = 800
    SCREEN_HEIGHT = 450
    VSYNC = true
    FULLSCREEN = false
    OPTIONS = {vsync = VSYNC, fullscreen = FULLSCREEN}

    -- input constants
    TOUCH_PRESSED_THRESHOLD = 30

    -------------
    -- INCLUDE --
    -------------
    -- helpers
    require('src/customGraphics')
    require('src/touchInput')
    require('src/textInput')
    
    -- hacks
    require('src/hacks')

    -- states
    require('src/battle')
end