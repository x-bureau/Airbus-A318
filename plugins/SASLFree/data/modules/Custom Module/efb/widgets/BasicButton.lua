BasicButton = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    color = SYSTEM_COLORS.FRONT_GREEN,
    label = ""
}


function BasicButton:new(x, y, width, height, color, label) 
    local o = {}
    setmetatable(o, {__index = self})
    o.x = x or 0
    o.y = y or 0
    o.width = width or 0
    o.height = height or 0
    o.color = color or SYSTEM_COLORS.FRONT_GREEN
    o.label = label or ""
    return o
end

function BasicButton:drawButton()
    sasl.gl.drawRectangle(self.x, self.y, self.width, self.height, self.color)
end