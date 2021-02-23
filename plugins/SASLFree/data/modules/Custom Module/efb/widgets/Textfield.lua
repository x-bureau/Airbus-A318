default_field_color = {42/255, 58/255, 80/255, 1.0}


Textfield = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    text = "",
    isActive = false
}

function Textfield:new(x, y, width, height, text, isActive)
    local o = {}
    setmetatable(o, {__index = self})
    o.x = x or 0
    o.y = y or 0
    o.width = width or 0
    o.height = height or 0
    o.text = text or ""
    o.isActive = isActive or false
    return o
end

-- function Textfield:drawField()
--     sasl.gl.drawRectangle(self.x, self.y, self.width, self.height, default_field_color)
--     if self.isActive == true then
--         sasl.gl.drawFrame(self.x, self.y, self.width, self.height, SYSTEM_COLORS.FRONT_GREEN)
--     end
--     sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_REGULAR, self.x + (self.width / 2), self.y + (self.height / 2) - 5, self.text, 15, false, false, TEXT_ALIGN_CENTER, SYSTEM_COLORS.FRONT_GREEN)
-- end

function Textfield:getText()
    return self.text
end

function Textfield:addLetter(character)
    -- add a character to the current text in the field
    if string.len(self.text) < 10 then
        self.text = self.text..character
    end
end

function Textfield:removeLetter()
    self.text = self.text:sub(1, -2)
end

function Textfield:setActive()
    self.isActive = true
end

function Textfield:setInactive()
    self.isActive = false
end

