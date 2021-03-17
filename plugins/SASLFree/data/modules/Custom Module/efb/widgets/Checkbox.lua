Checkbox = {
    x = 0,
    y = 0,
    size = 0,
    isEnabled = false,
    isHidden = false
}

function Checkbox:new(x, y, size,isEnabled, isHidden)
    local o = {}
    setmetatable(o, {__index = self})
    o.x = x or 0
    o.y = y or 0
    o.size = size or 0
    o.isEnabled = isEnabled or false
    o.isHidden = isHidden or false
    return o
end

function Checkbox:click()
    self.isEnabled = not self.isEnabled
end