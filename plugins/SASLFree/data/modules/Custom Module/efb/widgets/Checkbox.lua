Checkbox = {
    x = 0,
    y = 0,
    size = 0,
    isEnabled = false
}

function Checkbox:new(x, y, size,isEnabled)
    local o = {}
    setmetatable(o, {__index = self})
    o.x = x or 0
    o.y = y or 0
    o.size = size or 0
    o.isEnabled = isEnabled or false
    return o
end

-- function Checkbox:drawBox()
--     sasl.gl.drawFrame(self.x, self.y, self.size, self.size, SYSTEM_COLORS.FRONT_GREEN)
--     if self.isEnabled == true then
--         local inset = 3
--         local newSize = self.size - (2 * inset)
--         sasl.gl.drawRectangle(self.x + inset, self.y + inset, newSize - 1, newSize - 1, SYSTEM_COLORS.FRONT_GREEN)
--     end
-- end

function Checkbox:click()
    self.isEnabled = not self.isEnabled
end