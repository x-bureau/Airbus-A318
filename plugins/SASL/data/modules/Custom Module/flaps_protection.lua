local lever_isMoved = false
local lever_position = 0
local selected_position = 0
local new_lever_position = 0

if lever_position == 4 then
    if lever_isMoved == true then
        new_lever_position = 3
    end
elseif lever_position == 0 then
    if lever_isMoved == true then
        new_lever_position = 1
    end
elseif lever_position == 3 then
    if lever_isMoved == true then
        if not selected_position == 0 then
            new_lever_position = selected_position
        end
    end
elseif lever_position == 1 then
    if lever_isMoved == true then
        if not selected_position == 4 then
            new_lever_position = selected_position
        end
    end
elseif lever_position == 2 then
    if lever_isMoved == true then
        new_lever_position = selected_position
    end
end

