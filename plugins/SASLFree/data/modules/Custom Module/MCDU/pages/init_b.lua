
local data = {
    taxi = {"TAXI", "0.5", 'l', 1},
    trip_time = {"TRIP TIME", "", 'l', 2},
    rte_rsv = {"RTE RSV/ %", "", 'l', 3},
    altn_time = {"ALTN TIME", "", 'l', 4},
    final_time = {"FINAL TIME", "", 'l', 5},
    min_dest_fob = {"MIN DEST FOB", "", 'l', 6},
    zfw_zfwcg = {"ZFW/ZFWCG", "", 'r', 1},
    block = {"BLOCK", "", 'r', 2},
    tow_lw = {"TOW/  LW", "", 'r', 4},
    trip_wind = {"TRIP WIND", "", 'r', 5},
    extra_time = {"EXTRA/TIME", "", 'r', 6}
}
local zfw_filled = false

local function drawZFW()
    local length = 16 * 10
    local x = 469 - length
    local y = mdcu_positons[1] - 2
    local height = 20
    sasl.gl.drawFrame(x, y, 48, height, mcdu_colors.box)
    sasl.gl.drawLine(x + 16, y, x + 16, y + height, mcdu_colors.box)
    sasl.gl.drawLine(x + 32, y, x + 32, y + height, mcdu_colors.box)
    x = x + 48
    sasl.gl.drawText(MCDU_FONT_BOLD, x + 3, mdcu_positons[1] - 1, ".", mcdu_option_size - 3, false, false, TEXT_ALIGN_LEFT, mcdu_colors.box)
    x = x + 16
    sasl.gl.drawFrame(x, y, 16, height, mcdu_colors.box)
    x = x + 32
    sasl.gl.drawText(MCDU_FONT, x + 3 - 16, mdcu_positons[1] - 1, "/", mcdu_option_size - 3, false, false, TEXT_ALIGN_LEFT, mcdu_colors.box)
    sasl.gl.drawFrame(x, y, 32, height, mcdu_colors.box)
    sasl.gl.drawLine(x + 16, y, x + 16, y + height, mcdu_colors.box)
    x = x + 32
    sasl.gl.drawText(MCDU_FONT_BOLD, x + 3, mdcu_positons[1] - 1, ".", mcdu_option_size - 3, false, false, TEXT_ALIGN_LEFT, mcdu_colors.box)
    x = x + 16
    sasl.gl.drawFrame(x, y, 16, height, mcdu_colors.box)
end

local function processZFW()
    local entry = SCRATCHPAD
    if string.find(entry, "/") then
    else
        if string.len(entry) ~= 4 or string.match(entry, ".") == false then
            displayError("INVALID FORMAT")
        else
            set(zfw, tonumber(entry))
            zfw_filled = true
        end
    end
end

local function drawData()
    for key, value in pairs(data) do
        if value[2] ~= "" then
            if value[3] == 'l' then
                sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[3])
            else
                if value[3] == 'r' and value[4] == 1 then
                    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[3])
                else
                    sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[3])
                end
            end
        end
    end
    if isOptionEmpty(data.taxi) then
        drawBlanks('l', 1, "––.–")
    end
    if isOptionEmpty(data.trip_time) then
        drawBlanks('l', 2, "–––.–/––––")
    end
    if isOptionEmpty(data.rte_rsv) then
        drawBlanks('l', 3, "–––.–/–.–")
    end
    if isOptionEmpty(data.altn_time) then
        drawBlanks('l', 4, "–––.–/––––")
    end
    if isOptionEmpty(data.final_time) then
        drawBlanks('l', 5, "–––.–/––––")
    end
    if isOptionEmpty(data.min_dest_fob) then
        drawBlanks('l', 6, "–––––")
    end
    -- if isOptionEmpty(data.zfw_zfwcg) then
    --     drawZFW()
    -- end
    if not zfw_filled then
        drawZFW()
    end
   
    if isOptionEmpty(data.block) then
        drawBoxesWithSlash('r', 2, 4, 3, 1)
    end
    if isOptionEmpty(data.tow_lw) then
        drawBlanks('r', 4, "–––.–/––––")
    end
    if isOptionEmpty(data.trip_wind) then
        drawBlanks('r', 5, "–––––")
    end
    if isOptionEmpty(data.tow_lw) then
        drawBlanks('r', 6, "–––.–/––––")
    end
end

function update_init_b()
    if get(zfw) ~= 0  then
        data.zfw_zfwcg[2] = ""..round(get(zfw), 1).."/"..round(math.abs(get(center_g)) * 100, 1)
    end
end

function init_b_key_input(side, key)
    if side == 'l' then
    else
        if key == 1 then
            processZFW()
        end
    end
end

function draw_init_b()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "INIT", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawStaticTitlesKeyValue(data)
    drawData()
end