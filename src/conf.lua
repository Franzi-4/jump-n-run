function love.conf(t)
    t.version = "11.4"                  -- The LÖVE version this game was made for
    t.window.title = "My Platform Game" -- The window title
    t.window.width = 800               -- Game window width
    t.window.height = 600              -- Game window height
    
    -- For debugging
    t.console = true                   -- Enable console output for Windows
    
    -- Modules to include
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false         -- Disable unused modules
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.timer = true
    t.modules.window = true
end
