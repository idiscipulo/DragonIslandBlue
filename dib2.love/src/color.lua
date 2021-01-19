Color = {}
Color.__index = Color

function Color:new(col)
    color = {}
    setmetatable(color, Color)

    color.col = col
    color.status = false

    return color
end