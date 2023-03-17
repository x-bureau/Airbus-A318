position= {0,0,4096,4096}
size = {4096, 4096}

function Math_rescale_no_lim(in1, out1, in2, out2, x)

    if in2 - in1 == 0 then return out1 + (out2 - out1) * (x - in1) end
    return out1 + (out2 - out1) * (x - in1) / (in2 - in1)
end

function Math_rescale_lim_lower(in1, out1, in2, out2, x)

    if x < in1 then return out1 end
    return Math_rescale_no_lim(in1, out1, in2, out2, x)
end

function Math_rescale_lim_upper(in1, out1, in2, out2, x)

    if x > in2 then return out2 end
    return Math_rescale_no_lim(in1, out1, in2, out2, x)
    
end

function Math_rescale(in1, out1, in2, out2, x)

    if x < in1 then return out1 end
    if x > in2 then return out2 end
    return Math_rescale_no_lim(in1, out1, in2, out2, x)

end

function Draw_LCD_backlight(x, y, width, hight, min_brightness_for_backlight, max_brightness_for_backlight, brightness)
    local LCD_backlight_cl = {10/255, 15/255, 25/255}

    --calculate backlight
    local blacklight_R = Math_rescale(min_brightness_for_backlight, 0, max_brightness_for_backlight, LCD_backlight_cl[1], brightness)
    local blacklight_G = Math_rescale(min_brightness_for_backlight, 0, max_brightness_for_backlight, LCD_backlight_cl[2], brightness)
    local blacklight_B = Math_rescale(min_brightness_for_backlight, 0, max_brightness_for_backlight, LCD_backlight_cl[3], brightness)

    sasl.gl.drawRectangle(x, y, width, hight, {blacklight_R, blacklight_G, blacklight_B})
end

function draw()
    Draw_LCD_backlight(49, 52, 500, 500, 0.2, 1, 1.0) -- CAPT PFD BACKLIGHT
    Draw_LCD_backlight(49, 1545, 500, 500, 0.2, 1, 1.0) -- CAPT ND BACKLIGHT
    Draw_LCD_backlight(1408, 1545, 900, 900, 0.2, 1, 1.0) -- F/O PFD BACKLIGHT
    Draw_LCD_backlight(2768, 52, 900, 900, 0.2, 1, 1.0) -- F/O ND BACKLIGHT
    Draw_LCD_backlight(30,   2226, 900, 900, 0.2, 1, 1.0)
    Draw_LCD_backlight(1030, 2226, 900, 900, 0.2, 1, 1.0)
    Draw_LCD_backlight(2030, 2726, 600, 400, 0.2, 1, 1.0)
    Draw_LCD_backlight(2030, 2298, 600, 400, 0.2, 1, 1.0)
end
