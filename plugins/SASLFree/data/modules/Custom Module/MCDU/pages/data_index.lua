-- PAGE KEY: 4

local staticData = {
	titles = {
		{"POSITION", 'l', 1},
		{"IRS", 'l', 2},
		{"GPS", 'l', 3},
		{"CLOSEST", 'l', 5},
		{"EQUIPMENT", 'l', 6},
		{"PRINT", 'r', 5},
		{"AOC", 'r', 6}
	},
	options = {
		{"<MONITOR", 'l', 1},
		{"<MONITOR", 'l', 2},
		{"<MONITOR", 'l', 3},
		{"<A/C STATUS", 'l', 4},
		{"<AIRPORTS", 'l', 5},
		{"<POINT", 'l', 6},
		{"FUNCTION>", 'r', 5},
		{"FUNCTION>", 'r', 6}
	}
}


local function drawStaticData()
	for i = 1, table.getn(staticData.titles), 1 do
		local title = staticData.titles[i]
		if title[2] == 'l' then
			sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[title[3]], title[1], option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
		else
			sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[title[3]], title[1], option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
		end
	end
	for i = 1, table.getn(staticData.options), 1 do
		local option = staticData.options[i]
		if option[2] == 'l' then
			sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[option[3]], option[1], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
		else
			sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[option[3]], option[1], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
		end
	end
end

function data_index_input(side, key)
end

function update_data_index() 
end

function draw_data_index()
	sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "DATA INDEX", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
	drawStaticData()
end