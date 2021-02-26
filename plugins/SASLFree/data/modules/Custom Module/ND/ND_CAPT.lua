-- A318 Created by X-Bureau --

position = {30, 50, 495, 500}
size = {500, 500}

-- get datarefs
heading = globalPropertyf("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot")
nav1id = globalProperty("sim/cockpit2/radios/indicators/nav1_nav_id")
nav1freq = globalProperty("sim/cockpit/radios/nav1_freq_hz")
nav1Crs = globalProperty("sim/cockpit/radios/nav1_course_degm")
nav1hdev = globalProperty("sim/cockpit/radios/nav1_hdef_dot")
nav1vdev = globalProperty("sim/cockpit/radios/nav1_vdef_dot")

tas = globalPropertyf("sim/cockpit2/gauges/indicators/true_airspeed_kts_pilot")
gs = globalPropertyf("sim/flightmodel/position/groundspeed")
winddirection = globalPropertyf("sim/weather/wind_direction_degt")
windspeed = globalPropertyf("sim/weather/wind_speed_kt")

CaptNdMode = createGlobalPropertyi("A318/systems/ND/capt_mode", 0)
CaptNdRnge = createGlobalPropertyi("A318/systems/ND/capt_rnge", 10)

CaptNdCSTR = createGlobalPropertyi("A318/systems/ND/capt_cstr", 0)
CaptNdWPT = createGlobalPropertyi("A318/systems/ND/capt_wpt", 0)
CaptNdVORD = createGlobalPropertyi("A318/systems/ND/capt_vord", 0)
CaptNdNDB = createGlobalPropertyi("A318/systems/ND/capt_ndb", 0)
CaptNdARPT = createGlobalPropertyi("A318/systems/ND/capt_arpt", 0)
CaptNdTERR = createGlobalPropertyi("A318/systems/ND/capt_terr", 0)

--fonts
local ndFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--colours
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local ND_YELLOW = {1, 1, 0, 1.0}
local ND_PURPLE = {1, 0, 1, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}

--get images
local miniplane = sasl.gl.loadImage("A320-ND-Rose-Airplane-Standalone.png", 0, 0, 160, 160)
rose = sasl.gl.loadImage("A320-ND-Rose-Cardinals-01.png", 0, 0, 550, 550)
local arc = sasl.gl.loadImage("ARC_Nav.png", 0, 0, 2048, 2048)
local arcTape = sasl.gl.loadImage("ARC_Tape.png", 0, 0, 768, 768)

--custom functions

local function draw_overlay_text()
    sasl.gl.drawText(ndFont, 10, 475, "GS", 15, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 66, 475, math.floor(get(gs)+ 0.5), 18, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN) -- GROUND SPEED

    sasl.gl.drawText(ndFont, 75, 475, "TAS", 15, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 141, 475, math.floor(get(tas)+ 0.5), 18, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN) -- TAS

    if get(gs) < 100 then 
        sasl.gl.drawText(ndFont, 10, 455, "---", 18, false, false, TEXT_ALIGN_LEFT, PFD_GREEN)
        sasl.gl.drawText(ndFont, 43, 455, "/", 18, false, false, TEXT_ALIGN_CENTER, PFD_WHITE)
        sasl.gl.drawText(ndFont, 48, 455, "--", 18, false, false, TEXT_ALIGN_LEFT, PFD_GREEN)
    else 
        sasl.gl.drawText(ndFont, 10, 455, string.format("%03d", math.floor(get(winddirection) + 0.5)), 18, false, false, TEXT_ALIGN_LEFT, PFD_GREEN)
        sasl.gl.drawText(ndFont, 43, 455, "/", 18, false, false, TEXT_ALIGN_CENTER, PFD_WHITE)
        sasl.gl.drawText(ndFont, 48, 455, math.floor(get(windspeed) + 0.5), 18, false, false, TEXT_ALIGN_LEFT, PFD_GREEN)
    end
end

function draw_ils()
    sasl.gl.drawText(ndFont, 450, 475, "ILS1  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 475, string.format("%.2f", get(nav1freq) / 100), 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 460, 455, "CRS  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 455, string.format("%03d", (math.floor(get(nav1Crs) + 0.5))).."°", 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 490, 435, get(nav1id), 18, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)

    sasl.gl.saveGraphicsContext ()
    sasl.gl.setTranslateTransform (250, 250)
    sasl.gl.setRotateTransform(-1 * (get(heading) - get(nav1Crs)))
    sasl.gl.drawWideLine(0, 90, 0, 175, 3, ND_PURPLE)
    sasl.gl.drawWideLine(-20, 107, 20, 107, 3, ND_PURPLE)

    sasl.gl.drawCircle(-100, 0, 4, false, PFD_WHITE) -- full left
    sasl.gl.drawCircle(-50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(100, 0, 4, false, PFD_WHITE) -- full right

    sasl.gl.drawWideLine(0 + (50 * get(nav1hdev)), 80, 0 + (50 * get(nav1hdev)), -80, 3, ND_PURPLE) -- Horizontal Deviation bar

    sasl.gl.drawWideLine(0, -90, 0, -175, 3, ND_PURPLE)
    sasl.gl.restoreGraphicsContext ()

    sasl.gl.drawWideLine(470, 250, 490, 250, 3, ND_YELLOW)
    sasl.gl.drawCircle(480, 350, 4, false, PFD_WHITE) -- full down
    sasl.gl.drawCircle(480, 300, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(480, 200, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(480, 150, 4, false, PFD_WHITE) -- full up

    if get(nav1vdev) > 2 then
        sasl.gl.drawWidePolyLine({488, 150, 480, 137, 472, 150}, 1.5, ND_PURPLE)
    elseif get(nav1vdev) < -2 then
        sasl.gl.drawWidePolyLine({ 472, 350, 480, 363, 488, 350}, 1.5, ND_PURPLE)
    else
        sasl.gl.drawWidePolyLine({ 472, 250 - (50 * get(nav1vdev)), 480, 263 - (50 * get(nav1vdev)), 488, 250 - (50 * get(nav1vdev)), 480, 237 - (50 * get(nav1vdev)), 472, 250 - (50 * get(nav1vdev))}, 1.5, ND_PURPLE) -- Vertical Deviation bar
    end

    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
    sasl.gl.drawTexture(miniplane, 225, 216, 50, 50, PFD_WHITE)
    sasl.gl.drawText(ndFont, 125, 126, get(CaptNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(CaptNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

function draw_vor()
    sasl.gl.drawText(ndFont, 450, 475, "VOR1  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 475, string.format("%.2f", get(nav1freq) / 100), 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 460, 455, "CRS  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 455, string.format("%03d", (math.floor(get(nav1Crs) + 0.5))).."°", 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 490, 435, get(nav1id), 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)

    sasl.gl.saveGraphicsContext ()
    sasl.gl.setTranslateTransform (250, 250)
    sasl.gl.setRotateTransform(-1 * (get(heading) - get(nav1Crs)))
    sasl.gl.drawWideLine(0, 90, 0, 175, 3, ND_PURPLE)
    sasl.gl.drawWideLine(-20, 107, 20, 107, 3, ND_PURPLE)

    sasl.gl.drawCircle(-100, 0, 4, false, PFD_WHITE) -- full left
    sasl.gl.drawCircle(-50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(100, 0, 4, false, PFD_WHITE) -- full right

    sasl.gl.drawWideLine(0 + (50 * get(nav1hdev)), 80, 0 + (50 * get(nav1hdev)), -80, 3, ND_PURPLE) -- Horizontal Deviation bar
    sasl.gl.drawWidePolyLine({-10 + (50 * get(nav1hdev)), 70, 0 + (50 * get(nav1hdev)), 80, 10 + (50 * get(nav1hdev)), 70}, 3, ND_PURPLE)

    sasl.gl.drawWideLine(0, -90, 0, -175, 3, ND_PURPLE)
    sasl.gl.restoreGraphicsContext ()

    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
    sasl.gl.drawTexture(miniplane, 225, 216, 50, 50, PFD_WHITE)
    sasl.gl.drawText(ndFont, 125, 126, get(CaptNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(CaptNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

function draw_nav()
    sasl.gl.drawTexture(miniplane, 225, 216, 50, 50, PFD_WHITE)
    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
    sasl.gl.drawText(ndFont, 125, 126, get(CaptNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(CaptNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

function draw_arc()
    sasl.gl.drawTexture(miniplane, 225, 65, 50, 50, PFD_WHITE)
    sasl.gl.setTranslateTransform (-100, -252)
    sasl.gl.drawRotatedTexture(arcTape, -1 * get(heading), 0, 0, 700, 700, PFD_WHITE)
end

function draw_plan()
    sasl.gl.drawTexture(miniplane, 225, 225, 50, 50, PFD_WHITE)
    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
end

function draw()
    sasl.gl.setClipArea(0,0,500,500)
    draw_overlay_text()
    if get(CaptNdMode) == 0 then
        draw_ils()
    elseif get(CaptNdMode) == 1 then
        draw_vor()
    elseif get(CaptNdMode) == 2 then
        draw_nav()
    elseif get(CaptNdMode) == 3 then
        draw_arc()
    elseif get(CaptNdMode) == 4 then
        draw_plan()
    end
end

