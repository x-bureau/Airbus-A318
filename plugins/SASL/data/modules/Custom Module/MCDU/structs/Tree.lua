require 'MCDU.structs.wpt'
Tree = {
    head = nil
}

function Tree:new()
    -- create a new binary search tree
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function Tree:recInsert(currentWpt, wpt)
    if currentWpt == nil then
        currentWpt = wpt
        return currentWpt
    end

    if wpt.hash < currentWpt.hash then
        currentWpt.left = self:recInsert(currentWpt.left, wpt)
    elseif(wpt.hash >= currentWpt.hash) then
        currentWpt.right = self:recInsert(currentWpt.right, wpt)
    end
    return currentWpt
end

function Tree:insert(waypoint)
    --print(waypoint.hash)
    self.head = self:recInsert(self.head, waypoint)
    --print("inserted some shit")
end

function Tree:recLookup(currentWpt, name)
    if currentWpt == nil or currentWpt.hash == self:hash(name) then
        if currentWpt == nil then
            print("its nil bruh")
        end
        return currentWpt
    end
    if currentWpt.hash < self:hash(name) then
        return self:recLookup(currentWpt.right, name)
    end
    return self:recLookup(currentWpt.left, name)
end

function Tree:lookup(waypoint)
    wpt = self:recLookup(self.head, waypoint)
    if wpt ~= nil then
        return wpt
    else
        return false
    end
end

function Tree:hash(name)
    local total = 0
    for i = 1, #name do
        local c = name:sub(i,i)
        total = total + string.byte(c)
    end
    local hash = total + (string.byte(name:sub(-1)) / string.byte(name:sub(1, 1)))
    return hash
end
