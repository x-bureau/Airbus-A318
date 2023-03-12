
function drawTextTest()
    drawText("AM I ALIGNED", 1, 9, MCDU_WHITE, SIZE.HEADER, false, "L")
    drawText("TESTING", 1, 8, MCDU_WHITE, SIZE.OPTION, false, "L")
    drawText("AM I ALIGNED", 24, 9, MCDU_WHITE, SIZE.HEADER, false, "R")
    drawText("TESTING LEFT", 24, 8, MCDU_WHITE, SIZE.OPTION, false, "R")
    -- for i in ipairs(TEXT_X) do
    --     for j in ipairs(TEXT_Y) do
    --         sasl.gl.drawText(MCDU_FONT, TEXT_X[i], TEXT_Y[j], "A", 10, false, false, TEXT_ALIGN_CENTER, mcdu_font_colors[1])
    --     end
    -- end
end