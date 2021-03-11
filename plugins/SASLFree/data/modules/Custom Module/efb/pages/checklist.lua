require 'efb.widgets.Checkbox'
require 'efb.helpers.checklists_helper'

local activeChecklist = 0
local checklist_titles = {
    "PRE-START",
    "STARTUP",
    "BEFORE TAXI",
    "BEFORE TAKEOFF",
    "CLIMB-OUT",
    "CRUISE",
    "APPROACH",
    "LANDING",
    "AFTER LANDING",
    "SHUTDOWN"
}
local checklistStartX = 340
local checklistStartY = 445

local dotsCalculated = false
local menuLocsCalculated = false
local checkBoxLocsCalculated = false
local checkboxes = {}
local menuLocs = {}
local active_checklist_page = 1
local downArrow = sasl.gl.loadImage("efb/icons/downArrow.png")
local upArrow = sasl.gl.loadImage("efb/icons/upArrow.png")
local pages = 1

function handleChecklistClick(x, y)
    -- check if user wants to open new checklist
    for i = 1, table.getn(menuLocs),1 do
        if isInRect(menuLocs[i], x, y) then
            if activeChecklist == i then
                activeChecklist = 0
            else
                activeChecklist = i
                checkBoxLocsCalculated = false
                checkboxes = {}
                active_checklist_page = 1
            end
        end
    end
    -- check if checkbox is clicked
    for i = 1, table.getn(checkboxes), 1 do
        local cb = checkboxes[i]
        if cb.isHidden == false then
            if isInRect({cb.x, cb.y, cb.size, cb.size}, x, y) then
                cb:click()
                if table.getn(getChecklistPart(activeChecklist)[i]) > 2 then
                    tick(activeChecklist, i)
                    print("item "..getChecklistItem(activeChecklist, i)[1].." is now "..getChecklistItem(activeChecklist, i)[3])
                end
            end
        end
    end
    -- check to see if scroll button was clicked
    if pages > 1 then
        if isInRect({757, 487, 45, 30}, x, y) then
            if active_checklist_page < pages then
                active_checklist_page = active_checklist_page + 1
            end
            checkboxes = {}
            checkBoxLocsCalculated = false
        end
        if isInRect({807, 487, 45, 30}, x, y) then
            if active_checklist_page > 1 then
                active_checklist_page = active_checklist_page - 1
            end
            checkboxes = {}
            checkBoxLocsCalculated = false
        end
    end
end

function handleChecklistKey(char)
end


local function drawDots(item, item2, x, y)
    local dots = ""
    local newX = x + (10 * string.len(item)) + 20
    local counter = 1
    local endX = 852 - (10 * string.len(item2)) - 5
    local totalLength = endX - newX
    local numDots = totalLength / 10
    while counter < numDots do
        dots = dots..". "
        counter = counter + 1
    end
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, newX, y, dots, 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
end

local function drawPageScrolls()
    sasl.gl.drawRectangle(757, 487, 45, 30, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawRectangle(807, 487, 45, 30, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawTexture(downArrow, 768, 492, 24, 21)
    sasl.gl.drawTexture(upArrow, 817, 492, 24, 21)
    local label = active_checklist_page.."/"..pages
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 747, 492, label, 25, false, false, TEXT_ALIGN_RIGHT, SYSTEM_COLORS.FRONT_GREEN)
end

local function drawItems(checklist, cX, cY, i)
    if cY > 40 and cY < 446 then
        if table.getn(checklist[i]) < 3 then
            --print(checklist[i][1])
            sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_REGULAR, 580, cY, checklist[i][1], 20, false, false, TEXT_ALIGN_CENTER, SYSTEM_COLORS.FRONT_GREEN)

        else
            sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, cX, cY, checklist[i][1], 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
            sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 852, cY, checklist[i][2], 20, false, false, TEXT_ALIGN_RIGHT, SYSTEM_COLORS.FRONT_GREEN)
            drawDots(checklist[i][1], checklist[i][2], cX, cY)
        end
    end
end

local function drawActiveChecklist()
    local checklist = getChecklistPart(activeChecklist)
    local title = checklist_titles[activeChecklist].." CHECKLIST"
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 308, 492, title, 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    local cY = checklistStartY
    if active_checklist_page > 1 then
        cY = cY + (12 * 35)
    end
    local cX = checklistStartX
    local index = 1
    pages = math.floor(table.getn(checklist) / 12) + 1
    if activeChecklist == 1 then
        pages = 2
    end
    if pages > 1 then
        drawPageScrolls()
    end
    for i = 1, table.getn(checklist), 1 do
        if table.getn(checklist[i]) < 3 then
            --print(checklist[i][1])
            local box = Checkbox:new(cX - 28, cY - 1, 18, false, true)
            table.insert(checkboxes, box)
        else
            local cb = nil
            if checklist[i][3] == 0 then
                cb = Checkbox:new(cX - 28, cY - 1, 18, false, false)
            else
                cb = Checkbox:new(cX - 28, cY - 1, 18, true, false)
            end
            if checkBoxLocsCalculated == false then
                table.insert(checkboxes, cb)
            end
        end
        drawItems(checklist, cX, cY, i)
        cY = cY - 35
    end
    checkBoxLocsCalculated = true
    for i = 1, table.getn(checkboxes), 1 do
        local bx = checkboxes[i]
        if bx.y > 40 and bx.y < 446 then
            drawCheckBox(bx)
        end
    end
end

local function drawChecklistMenu()
    sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, 492, "CHECKLISTS", 25, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.FRONT_GREEN)
    local y = 427
    local width = 43
    for i = 1, table.getn(checklist_titles), 1 do
        if i == activeChecklist then
            sasl.gl.drawRectangle(40, y, 218, width, SYSTEM_COLORS.BUTTON_SELECTED)
        else
            sasl.gl.drawRectangle(40, y, 218, width, SYSTEM_COLORS.FRONT_GREEN)
        end
        sasl.gl.drawText(SYSTEM_FONTS.ROBOTO_BOLD, 50, y + 15, checklist_titles[i], 20, false, false, TEXT_ALIGN_LEFT, SYSTEM_COLORS.BG_BLUE)
        if menuLocsCalculated == false then
            table.insert(menuLocs, {40, y, 218, width})
        end
        y = y - width
    end
    menuLocsCalculated = true
    y = 427
    for i = 1, table.getn(checklist_titles) - 1, 1 do
        sasl.gl.drawLine (65, y, 258 , y, SYSTEM_COLORS.BG_BLUE)
        y = y - width
    end
end

local function drawFrames()
    sasl.gl.drawFrame(40, 40, 218, 487, SYSTEM_COLORS.FRONT_GREEN)
    sasl.gl.drawFrame(298, 40, 564, 487, SYSTEM_COLORS.FRONT_GREEN)
end

function drawChecklist()
    drawFrames()
    if activeChecklist ~= 0 then
        drawActiveChecklist()
    end
    drawChecklistMenu()
end