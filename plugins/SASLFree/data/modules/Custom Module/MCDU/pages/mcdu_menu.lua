-- PAGE KEY: 1

local options = {
    left = {
        {"<FMGS", 2},
        {"<ATSU", 1},
        {"<ACMS", 1},
        {"", 1},
        {"<SAT", 1}
    },
    right = {
        {"", 1},
        {"", 1},
        {"", 1},
        {"", 1},
        {"", 1},
        {"RETURN>", 1}
    }
}

function update_mcdu_menu()
end

local function drawOptions()
    -- draw left options
    for i = 1, table.getn(options.left), 1 do
        local option = options.left[i]
        sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[i], option[1], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[option[2]])
    end
    for i = 1, table.getn(options.right), 1 do
        local option = options.right[i]
        sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[i], option[1], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[option[2]])
    end
end

function draw_mcdu_menu()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "MCDU MENU", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawOptions()
end