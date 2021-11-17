--WELCOME SCREEN POPOUT DISPLAY WINDOW--
require "common_declarations"
--Load Images
local overlay = sasl.gl.loadImage("X-Bureau_Welcome.png")
local DiscordLogo = sasl.gl.loadImage("Discord.png")
local UpArrow = sasl.gl.loadImage("arrow_up.png")

--Create Colors
local WHITE_COLOR = {1.0, 1.0, 1.0, 1.0}
local CLICK_REGION_GREEN = {0, 1.0, 0, 1.0}
local RED_COLOR = {1.0, 0, 0, 1.0}

--Variables
local DiscordLogoClicked = 0 --Tells us whether the discord logo has been clicked
local TwitterLogoClicked = 0 --Tells us whether the Twitter logo has been clicked

--Custom Functions
local function drawChangeLog()--Function to draw the Change log
    --———============= EDIT BELOW HERE ===========————
    local TitleLine = "Version 0.5.0 Pre 2.1" --This is the title line
    local FeaturesLine = "New Features" --NEW FEATURES LINE (Usually there's no need to edit this)
    local Line1 = "• Added Welcome Screen" --List items start here
    --———============= DO NOT EDIT BELOW HERE ======————
    
    --Draw the log
    sasl.gl.drawText(AirbusFont, 810, 345, TitleLine, 12, true, false, TEXT_ALIGN_LEFT, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 810, 330, FeaturesLine, 12, true, false, TEXT_ALIGN_LEFT, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 810, 315, Line1, 12, true, false, TEXT_ALIGN_LEFT, WHITE_COLOR)
end


--Draw the graphics on the panel
function draw()
    --TODO: IMPLEMENT OVERLAY TEXTURE
    sasl.gl.drawTexture(overlay, 0, 0, 1000, 650)
    sasl.gl.drawTexture(UpArrow, -16, 595, 55, 57)
    sasl.gl.drawText(AirbusFont, 45, 580, "Click the", 14, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 45, 560, "RED CIRCLE", 14, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 45, 540, "to begin", 14, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    sasl.gl.drawText(AirbusFont, 200, 280, "NYI", 50, true, false, TEXT_ALIGN_CENTER, RED_COLOR)
    sasl.gl.drawText(AirbusFont, 200, 100, "NYI", 50, true, false, TEXT_ALIGN_CENTER, RED_COLOR)

    drawChangeLog() --Draw the Change Log

    sasl.gl.drawFrame(575, 60, 60, 60, CLICK_REGION_GREEN) --Show the Click Region for Twitter Button
    sasl.gl.drawFrame(690, 60, 60, 60, CLICK_REGION_GREEN) --Show the Click Region for Discord Button
    if DiscordLogoClicked == 0 and TwitterLogoClicked == 0 then --If the Discord Logo is not clicked, draw this text by default
        sasl.gl.drawText(AirbusFont, 665, 150, "For Support or to follow development", 12, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
        sasl.gl.drawText(AirbusFont, 665, 130, "Click the buttons below", 16, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    elseif DiscordLogoClicked == 1 or TwitterLogoClicked == 1 then --When the discord logo is clicked, tell the user the link was copied to clipboard
        sasl.gl.drawText(AirbusFont, 665, 150, "Link Copied to Clipboard", 16, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
        sasl.gl.drawText(AirbusFont, 665, 130, "Paste into your Browser Searchbar", 12, true, false, TEXT_ALIGN_CENTER, WHITE_COLOR)
    end

end

function onMouseDown(component, x, y, button, parentX, parentY)
    if x > 574 and x < 636 and y > 59 and y < 121 then
        sasl.setClipboardText("https://twitter.com/xbureauofficial")
        TwitterLogoClicked = 1
    elseif x > 689 and x < 751 and y > 59 and y < 121 then
        sasl.setClipboardText("https://discord.gg/x-bureau")
        DiscordLogoClicked = 1
    end
end