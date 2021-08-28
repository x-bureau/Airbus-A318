--WELCOME SCREEN POPOUT DISPLAY WINDOW--
require "common_declarations"
--Load Images
--TODO: local overlay = sasl.gl.loadImage()
local DiscordLogo = sasl.gl.loadImage("Discord.png")
local UpArrow = sasl.gl.loadImage("arrow_up.png")

--Create Colors
local WHITE_COLOR = {1.0, 1.0, 1.0, 1.0}

--Variables
local DiscordLogoClicked = 0

--Draw the graphics on the panel
function draw()
    --TODO: IMPLEMENT OVERLAY TEXTURE
    sasl.gl.drawText(AirbusFont, 500, 610, "Welcome to the XB Airbus A318", 25, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    sasl.gl.drawTexture(DiscordLogo, 75, 40, 240, 135)
    sasl.gl.drawTexture(UpArrow, -16, 595, 55, 57)
    sasl.gl.drawText(AirbusFont, 45, 580, "Click the", 14, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 45, 560, "RED CIRCLE", 14, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 45, 540, "to begin", 14, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    if DiscordLogoClicked == 0 then
        sasl.gl.drawText(AirbusFont, 200, 205, "For Support or to follow development", 18, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
        sasl.gl.drawText(AirbusFont, 200, 180, "Click the button below", 18, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    elseif DiscordLogoClicked == 1 then
        sasl.gl.drawText(AirbusFont, 200, 205, "Link Copied to Clipboard", 20, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
        sasl.gl.drawText(AirbusFont, 200, 180, "Paste into your Browser Searchbar", 20, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    end
end

function onMouseDown(component, x, y, button, parentX, parentY)
    if x > 75 and x < 315 and y > 40 and y < 175 then
        sasl.setClipboardText("https://discord.gg/x-bureau/")
        DiscordLogoClicked = 1
    end
end