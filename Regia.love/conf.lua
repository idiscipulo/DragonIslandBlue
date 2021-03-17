function love.conf(t)
    t.console = true
    t.window.highdpi = true

    -- configs
    SCREEN_WIDTH = 800
    SCREEN_HEIGHT = 450
    VSYNC = true
    FULLSCREEN = false
    OPTIONS = {vsync = VSYNC, fullscreen = FULLSCREEN}

    -- include
    require('src/customGraphics')

    require('src/battle')
end