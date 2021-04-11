local data = {
    apt_lat = {"LAT↑↓", "", 'l', 1, 3},
    reference = {"REFERENCE", "", 'c', 1, 2},
    lat = {"LAT", "", 'l', 2, 3},
    gps_position = {"GPS POSITION", "", 'c', 2, 1},
    ret = {"", "<RETURN", 'l', 6, 1},
    apt_long = {"LONG", "", 'r', 1, 3},
    long = {"LONG", "", 'r', 2, 3},
    align_on_ref = {"", "ALIGN ON REF→", 'r', 6, 3},
    irs_1 = {"IRS 1 ALIGNING ON  ---", "", 'c', 3, 1},
    irs_2 = {"IRS 2 ALIGNING ON  ---", "", 'c', 4, 1},
    irs_3 = {"IRS 3 ALIGNING ON  ---", "", 'c', 5, 1}
}

local referenceCoordsFound = false
local alignCounter = 0

local function drawData()
    for key, value in pairs(data) do
        if value[2] ~= "" then
            if value[3] == 'l' then
                sasl.gl.drawText(MCDU_FONT, 10, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[value[5]])
            elseif value[3] == 'r' then
                sasl.gl.drawText(MCDU_FONT, 469, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_RIGHT, mcdu_font_colors[value[5]])
            else
                sasl.gl.drawText(MCDU_FONT, 239, mdcu_positons[value[4]], value[2], mcdu_option_size, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[value[5]])
            end
        end
    end
    if isOptionEmpty(data.irs_1) then
        drawBlanks('c', 3, "——°  ——.—/———° ——.— —")
    end
    if isOptionEmpty(data.irs_2) then
        drawBlanks('c', 4, "——°  ——.—/———° ——.— —")
    end
    if isOptionEmpty(data.irs_3) then
        drawBlanks('c', 5, "——°  ——.—/———° ——.— —")
    end
end

function irs_init_key_input(side, key)
    if side == 'l' then
        if key == 6 then
            set(MCDU_CURRENT_PAGE, 11)
        end
    else
        if key == 6 then
            alignCounter = alignCounter + 1
            
        end
    end
end

function update_irs_init()
    data.reference[2] = get(mcdu_origin)
    local lat = ""..get(gps_positon.latitude)
    local long = ""..get(gps_positon.longitude)
    data.lat[2] = lat:sub(1, 2).."°  "..lat:sub(3, 4).."."..lat:sub(5, 5).." "..lat:sub(1,1)
    data.long[2] = ""..get(gps_positon.longitude)
    if not referenceCoordsFound then
        local refCoords = getBasicLatLong(get(mcdu_origin))
        print(refCoords[1])
        local origin = refCoords[1]
        local dest = refCoords[2]
        data.apt_lat[2] = origin:sub(2, 3).."°  "..origin:sub(4, 5).."."..origin:sub(6, 6).." "..origin:sub(1,1)
        data.apt_long[2] = dest:sub(2, 3).."°  "..dest:sub(4, 5).."."..dest:sub(6, 6).." "..dest:sub(1,1)
        referenceCoordsFound = true
    end
    if alignCounter == 1 then
        data.align_on_ref[2] = "CONFIRM ALIGN*"
        data.align_on_ref[5] = 4
    elseif alignCounter > 1 then
        data.align_on_ref[2] = ""
    end
end

function draw_irs_init()
    sasl.gl.drawText(MCDU_FONT, title_location.x, title_location.y, "IRS INIT", title_location.font_size, false, false, TEXT_ALIGN_CENTER, {1, 1, 1, 1})
    drawStaticTitlesKeyValue(data)
    drawData()
end