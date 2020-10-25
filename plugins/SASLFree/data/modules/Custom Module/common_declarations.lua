switch_states = {["off"] = 0, ["on"] = 1}
auto_man_states = {["auto"] = 0, ["manual"] = 1}
valve_states = {["closed"] = 0, ["transit"] = 1, ["open"] = 2}
units = {["metric"] = 0, ["imperial"] = 1}

local efb_units = globalPropertyi("A318/efb/config/units")

function get_weight(kg)
    if get(efb_units) == units.metric then
        return kg
    end
    return kg * 2.20462262185
end

function get_temp(celsius)
    if get(efb_units) == units.metric then
        return celsius
    end
    return celsius * 1.8 + 32
end
