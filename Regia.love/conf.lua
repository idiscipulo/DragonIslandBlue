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
    CHEAT = true

    ---------------
    -- CONSTANTS --
    ---------------

    -- screen constants
    SCREEN_WIDTH = 800
    SCREEN_HEIGHT = 450
    VSYNC = true
    FULLSCREEN = false
    OPTIONS = {vsync = VSYNC, fullscreen = FULLSCREEN}

    -------------
    -- INCLUDE --
    -------------

    -- helpers
    require('src/customGraphics')
    require('src/touchInput')

    -- states
    require('src/battle')
end