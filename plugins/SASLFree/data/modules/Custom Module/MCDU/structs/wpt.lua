wpt = {
    name = "",
    lat = 0,
    long = 0,
    left = nil,
    right = nil,
    hash = 0
}

function wpt:new(name, lat, long, hash)
    local o = {}
    setmetatable(o, {__index = self})
    o.name = name or ""
    o.lat = lat or 0
    o.long = long or 0
    o.hash = hash or 0
    return o
end