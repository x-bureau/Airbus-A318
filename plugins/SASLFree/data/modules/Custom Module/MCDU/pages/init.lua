-- PAGE KEY: 3

local options = {
    co_route = {"CO-ROUTE", "", 'l', 1},
    alt_route = {"ALT-ROUTE", "", 'l', 2},
    flt_nmbr = {"FLT NBR", "", 'l', 3},
    lat = {"LAT", "", 'l', 4},
    cost_index = {"COST INDEX", "", 'l', 5},
    crz_flt_temp = {"CRZ FL/TEMP", "", 'l', 6},
    from_to = {"FROM/TO", "", 'r', 1}
}

function init_key_input(side, key)
    if side == 'l' then
        if key == 3 then
            options.flt_nmbr[2] = SCRATCHPAD
        end
    end
end

local function drawStaticTitles()
    for key, value in pairs(options) do
        if value[3] == 'l' then
            sasl.gl.drawText(MCDU_FONT_BOLD, 17, option_heading_locations[value[4]], value[1], option_heading_font_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        else
            sasl.gl.drawText(MCDU_FONT_BOLD, 462, option_heading_locations[value[4]], value[1], option_heading_font_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
        end
    end
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[3], "*IRS INIT>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_colors.box)
    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[5], "WIND>", mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[1])
end

local function drawFields()
    for key, value in pairs(options) do
        if value[2] ~= "" then
            sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
        end
    end
    if isOptionEmpty(options.co_route) then
        drawBoxes('l', 1, 7)
    end
    if isOptionEmpty(options.alt_route) then
        drawBlanks('l', 2, "----/----------")
    end
    if isOptionEmpty(options.flt_nmbr) then
        drawBoxes('l', 3, 8)
    end
    if isOptionEmpty(options.lat) then
        drawBlanks('l', 4, "----.-")
    end
    if isOptionEmpty(options.cost_index) then
        drawBlanks('l', 5, "---")
    end
    if isOptionEmpty(options.crz_flt_temp) then
        drawBlanks('l', 6, "----- /---°")
    end
end

function draw_init()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "INIT", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawStaticTitles()
    drawFields()
end