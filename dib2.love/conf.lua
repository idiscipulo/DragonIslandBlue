function love.conf(t)
    t.console = true
    t.window.highdpi = true

    -- configs
    SCREEN_WIDTH = 800
    SCREEN_HEIGHT = 450
    VSYNC = true
    FULLSCREEN = false
    OPTIONS = {vsync = VSYNC, fullscreen = FULLSCREEN}

    -- require files  
    require('src/healthBarUtility')

    require('src/move')
    require('src/moves/sting')
    
    require('src/monster')
    require('src/factory')
    require('src/monsters/goldenJellypup')
    
    require('src/color')
    require('src/game')

    require('src/stateManager')

    require('src/battle')
end

function table.copy(tab)
    local newTab = {}

    for i = 1, #tab do
        newTab[i] = tab[i]
    end
    return newTab
end