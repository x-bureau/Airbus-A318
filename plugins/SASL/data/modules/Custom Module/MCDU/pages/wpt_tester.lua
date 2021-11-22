require 'MCDU.structs.Tree'
require 'MCDU.structs.wpt'
local isLoaded = false
local tree = Tree:new()
local isFilled = false
local text = ""
local coords = {
    [1] = nil,
    [2] = nil
}

function processCustomWaypointData()
	local wptData = io.open(getXPlanePath().."/Custom Data/GNS430/navdata/Waypoints.txt", "r")
	local counter = 0
	for line in wptData:lines() do
		local tokens = createTokens(line, ",")
		local wpt = wpt:new(tokens[1], tonumber(tokens[2]), tonumber(tokens[3]), tree:hash(tokens[1]))
		tree:insert(wpt)
	end
end

function wpt_tester_key_input(side, key)
    if side == 'l' then
        if key == 6 then
            set(MCDU_CURRENT_PAGE, 0)
        end
        if key == 1 then
            if isLoaded then
                print(text)
                isFilled = true
                if tree:lookup(text) == false then
                    displayError("NOT A VALID WAYPOINT")
                    coords[1] = nil
                    coords[2] = nil
                else
                    w = tree:lookup(text)
                    coords[1] = w.lat
                    coords[2] = w.long
                end
                --tree:lookup(text) 
            end
        end
    else 
        if key == 1 then
            processCustomWaypointData()
            isLoaded = true
        end
        if key == 2 then
            text = "CEPIN"
        end
        if key == 3 then
            text = "AXMUL"
        end
        if key == 4 then
            text = "HOODS"
        end
        if key == 5 then
            text = "ZZZZZ"
        end
    end
    
end

function update_wpt_tester()
end

function draw_wpt_tester()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "WAYPOINT LOOKUP", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[1], "WAYPOINT", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[3], "LATITUDE", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[4], "LONGITUDE", option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[2], "CEPIN>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[3], "AXMUL>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[4], "HOODS>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[5], "ZZZZZ>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
    if isFilled then
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[1], text, mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    else
        drawBoxes('l', 1, 5)
    end
    if isLoaded == false then
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[1], "LOAD DATABASE*>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[4])
    else
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[1], "DATABASE LOADED*", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[2])
    end
    sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[6], "<RETURN", mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
    if coords[1] ~= nil then
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[3], coords[1], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[4], coords[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
    end
end