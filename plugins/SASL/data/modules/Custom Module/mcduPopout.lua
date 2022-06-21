--Hello World

--Load images
local mcduBackground = sasl.gl.loadImage("mcduBackground.png")

function draw()
    sasl.gl.drawTexture(mcduBackground, 0, 0, 429, 609)
end