position = {595, 47, 500, 500}
size = {500, 500}

-- get datarefs
local startup_complete = false
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")

local BUS = globalProperty("A318/systems/ELEC/AC2_V")
local selfTest = 0

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local Timer = 0
local TimerFinal = math.random(25, 40)

local ADIRS_aligned = globalProperty("A318/systems/ADIRS/2/aligned")
local heading = globalPropertyf("A318/systems/ADIRS/2/inertial/heading")

local navid = globalProperty("sim/cockpit2/radios/indicators/nav2_nav_id")
local navfreq = globalProperty("sim/cockpit/radios/nav2_freq_hz")
local navCrs = globalProperty("sim/cockpit/radios/nav2_course_degm")
local navhdev = globalProperty("sim/cockpit/radios/nav2_hdef_dot")
local navvdev = globalProperty("sim/cockpit/radios/nav2_vdef_dot")

local tas = globalPropertyf("A318/systems/ADIRS/2/air/tas")
local gs = globalPropertyf("A318/systems/ADIRS/2/inertial/gs")
local winddirection = globalPropertyf("sim/weather/wind_direction_degt")
local windspeed = globalPropertyf("sim/weather/wind_speed_kt")

local frstNdMode = createGlobalPropertyi("A318/systems/ND/frst_mode", 3)
local rngeKnob = createGlobalPropertyi("A318/systems/ND/frst_rnge", 1)

local frstNdCSTR = createGlobalPropertyi("A318/systems/ND/frst_cstr", 0)
local frstNdWPT = createGlobalPropertyi("A318/systems/ND/frst_wpt", 0)
local frstNdVORD = createGlobalPropertyi("A318/systems/ND/frst_vord", 0)
local frstNdNDB = createGlobalPropertyi("A318/systems/ND/frst_ndb", 0)
local frstNdARPT = createGlobalPropertyi("A318/systems/ND/frst_arpt", 0)
local frstNdTERR = createGlobalPropertyi("A318/systems/ND/frst_terr", 0)
local foNdBright = createGlobalPropertyf("A318/cockpit/fo/ndBright", 1)

--fonts
local ndFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--colours
local PFD_GREEN = {0.184, 0.733, 0.219, 1.0}
local ND_YELLOW = {1, 1, 0, 1.0}
local ND_PURPLE = {1, 0, 1, 1.0}
local ND_ORANGE = {0.85, 0.5, 0.12, 1.0}
local PFD_WHITE = {1.0, 1.0, 1.0, 1.0}
local PFD_BLUE = {0.004, 1.0, 1.0, 1.0}
local PFD_RED = {1.0, 0.0, 0.0, 1.0}

--get images
local miniplane = sasl.gl.loadImage("plane.png", 0, 0, 160, 160)
local rose = sasl.gl.loadImage("rose.png", 0, 0, 550, 550)
local rose_unaligned = sasl.gl.loadImage("rose-unaligned.png", 0, 0, 550, 550)
local arcTape = sasl.gl.loadImage("arc.png", 0, 0, 2048, 2048)
local arcTape_unaligned = sasl.gl.loadImage("arc_unaligned.png", 0, 0, 2048, 2048)

--custom functions
function plane_startup()
    if get(eng1N1) > 1 then
        -- engines running
        selfTest = 1
        Timer = 0
    else
        -- cold and dark
        selfTest = 0
    end
end

local function draw_overlay_text()
    sasl.gl.drawText(ndFont, 10, 475, "GS", 15, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 66, 475, math.floor(get(gs)+ 0.5), 18, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN) -- GROUND SPEED

    sasl.gl.drawText(ndFont, 75, 475, "TAS", 15, false, false, TEXT_ALIGN_LEFT, PFD_WHITE)
    if get(ADIRS_aligned) == 0 then
        sasl.gl.drawText(ndFont, 141, 475, "---", 18, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN)
    else
        sasl.gl.drawText(ndFont, 141, 475, math.floor(get(tas)+ 0.5), 18, false, false, TEXT_ALIGN_RIGHT, PFD_GREEN) -- TAS
    end

    if get(ADIRS_aligned) == 0 then 
        sasl.gl.drawText(ndFont, 10, 455, "---", 18, false, false, TEXT_ALIGN_LEFT, PFD_GREEN)
        sasl.gl.drawText(ndFont, 43, 455, "/", 18, false, false, TEXT_ALIGN_CENTER, PFD_WHITE)
        sasl.gl.drawText(ndFont, 48, 455, "--", 18, false, false, TEXT_ALIGN_LEFT, PFD_GREEN)
    else
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

    if get(ADIRS_aligned) == 0 then
        sasl.gl.drawText(ndFont, 250, 25, "GPS  PRIMARY  LOST", 20, false, false, TEXT_ALIGN_CENTER, ND_ORANGE)
        sasl.gl.drawWidePolyLine({ 100, 22, 400, 22, 400, 42, 100, 42, 100, 22, 110, 22}, 2, PFD_WHITE)
    end
end

local function draw_ils()
    sasl.gl.drawText(ndFont, 450, 475, "ILS2  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 475, string.format("%.2f", get(navfreq) / 100), 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 460, 455, "CRS  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 455, string.format("%03d", (math.floor(get(navCrs) + 0.5))).."°", 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 490, 435, get(navid), 18, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)

    sasl.gl.saveGraphicsContext ()
    sasl.gl.setTranslateTransform (250, 250)
    sasl.gl.setRotateTransform(-1 * (get(heading) - get(navCrs)))
    sasl.gl.drawWideLine(0, 90, 0, 175, 3, ND_PURPLE)
    sasl.gl.drawWideLine(-20, 107, 20, 107, 3, ND_PURPLE)

    sasl.gl.drawCircle(-100, 0, 4, false, PFD_WHITE) -- full left
    sasl.gl.drawCircle(-50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(100, 0, 4, false, PFD_WHITE) -- full right

    sasl.gl.drawWideLine(0 + (50 * get(navhdev)), 80, 0 + (50 * get(navhdev)), -80, 3, ND_PURPLE) -- Horizontal Deviation bar

    sasl.gl.drawWideLine(0, -90, 0, -175, 3, ND_PURPLE)
    sasl.gl.restoreGraphicsContext ()

    sasl.gl.drawWideLine(470, 250, 490, 250, 3, ND_YELLOW)
    sasl.gl.drawCircle(480, 350, 4, false, PFD_WHITE) -- full down
    sasl.gl.drawCircle(480, 300, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(480, 200, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(480, 150, 4, false, PFD_WHITE) -- full up

    if get(navvdev) > 2 then
        sasl.gl.drawWidePolyLine({488, 150, 480, 137, 472, 150}, 1.5, ND_PURPLE)
    elseif get(navvdev) < -2 then
        sasl.gl.drawWidePolyLine({ 472, 350, 480, 363, 488, 350}, 1.5, ND_PURPLE)
    else
        sasl.gl.drawWidePolyLine({ 472, 250 - (50 * get(navvdev)), 480, 263 - (50 * get(navvdev)), 488, 250 - (50 * get(navvdev)), 480, 237 - (50 * get(navvdev)), 472, 250 - (50 * get(navvdev))}, 1.5, ND_PURPLE) -- Vertical Deviation bar
    end

    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
    sasl.gl.drawTexture(miniplane, 225, 216, 50, 50, PFD_WHITE)
    sasl.gl.drawText(ndFont, 125, 126, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(frstNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

local function draw_ils_unaligned()
    sasl.gl.drawText(ndFont, 450, 475, "ILS2  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 475, string.format("%.2f", get(navfreq) / 100), 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 460, 455, "CRS  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 455, string.format("%03d", (math.floor(get(navCrs) + 0.5))).."°", 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 490, 435, get(navid), 18, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)

    sasl.gl.saveGraphicsContext ()
    sasl.gl.setTranslateTransform (250, 250)
    sasl.gl.drawWideLine(0, 90, 0, 175, 3, ND_PURPLE)
    sasl.gl.drawWideLine(-20, 107, 20, 107, 3, ND_PURPLE)

    sasl.gl.drawCircle(-100, 0, 4, false, PFD_WHITE) -- full left
    sasl.gl.drawCircle(-50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(100, 0, 4, false, PFD_WHITE) -- full right

    sasl.gl.drawWideLine(0 + (50 * get(navhdev)), 80, 0 + (50 * get(navhdev)), -80, 3, ND_PURPLE) -- Horizontal Deviation bar

    sasl.gl.drawWideLine(0, -90, 0, -175, 3, ND_PURPLE)
    sasl.gl.restoreGraphicsContext ()

    sasl.gl.drawWideLine(470, 250, 490, 250, 3, ND_YELLOW)
    sasl.gl.drawCircle(480, 350, 4, false, PFD_WHITE) -- full down
    sasl.gl.drawCircle(480, 300, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(480, 200, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(480, 150, 4, false, PFD_WHITE) -- full up

    if get(navvdev) > 2 then
        sasl.gl.drawWidePolyLine({488, 150, 480, 137, 472, 150}, 1.5, ND_PURPLE)
    elseif get(navvdev) < -2 then
        sasl.gl.drawWidePolyLine({ 472, 350, 480, 363, 488, 350}, 1.5, ND_PURPLE)
    else
        sasl.gl.drawWidePolyLine({ 472, 250 - (50 * get(navvdev)), 480, 263 - (50 * get(navvdev)), 488, 250 - (50 * get(navvdev)), 480, 237 - (50 * get(navvdev)), 472, 250 - (50 * get(navvdev))}, 1.5, ND_PURPLE) -- Vertical Deviation bar
    end

    sasl.gl.drawCircle(250, 250, 6, true, PFD_RED)
    sasl.gl.drawCircle(250, 250, 4, true, {0.0, 0.0, 0.0, 1.0})
    sasl.gl.drawTexture(rose_unaligned,0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawText(ndFont, 250, 345, "HDG", 30, false, false, TEXT_ALIGN_CENTER, PFD_RED)
    sasl.gl.drawText(ndFont, 125, 126, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(frstNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

local function draw_vor()
    sasl.gl.drawText(ndFont, 450, 475, "VOR2  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 475, string.format("%.2f", get(navfreq) / 100), 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 460, 455, "CRS  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 455, string.format("%03d", (math.floor(get(navCrs) + 0.5))).."°", 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 490, 435, get(navid), 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)

    sasl.gl.saveGraphicsContext ()
    sasl.gl.setTranslateTransform (250, 250)
    sasl.gl.setRotateTransform(-1 * (get(heading) - get(navCrs)))
    sasl.gl.drawWideLine(0, 90, 0, 175, 3, ND_PURPLE)
    sasl.gl.drawWideLine(-20, 107, 20, 107, 3, ND_PURPLE)

    sasl.gl.drawCircle(-100, 0, 4, false, PFD_WHITE) -- full left
    sasl.gl.drawCircle(-50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(100, 0, 4, false, PFD_WHITE) -- full right

    sasl.gl.drawWideLine(0 + (50 * get(navhdev)), 80, 0 + (50 * get(navhdev)), -80, 3, ND_PURPLE) -- Horizontal Deviation bar
    sasl.gl.drawWidePolyLine({-10 + (50 * get(navhdev)), 70, 0 + (50 * get(navhdev)), 80, 10 + (50 * get(navhdev)), 70}, 3, ND_PURPLE)

    sasl.gl.drawWideLine(0, -90, 0, -175, 3, ND_PURPLE)
    sasl.gl.restoreGraphicsContext ()

    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
    sasl.gl.drawTexture(miniplane, 225, 216, 50, 50, PFD_WHITE)
    sasl.gl.drawText(ndFont, 125, 126, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(frstNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

local function draw_vor_unaligned()
    sasl.gl.drawText(ndFont, 450, 475, "VOR2  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 475, string.format("%.2f", get(navfreq) / 100), 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 460, 455, "CRS  ", 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)
    sasl.gl.drawText(ndFont, 490, 455, string.format("%03d", (math.floor(get(navCrs) + 0.5))).."°", 15, false, false, TEXT_ALIGN_RIGHT, ND_PURPLE)
    sasl.gl.drawText(ndFont, 490, 435, get(navid), 18, false, false, TEXT_ALIGN_RIGHT, PFD_WHITE)

    sasl.gl.saveGraphicsContext ()
    sasl.gl.setTranslateTransform (250, 250)
    sasl.gl.drawWideLine(0, 90, 0, 175, 3, ND_PURPLE)
    sasl.gl.drawWideLine(-20, 107, 20, 107, 3, ND_PURPLE)

    sasl.gl.drawCircle(-100, 0, 4, false, PFD_WHITE) -- full left
    sasl.gl.drawCircle(-50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(50, 0, 4, false, PFD_WHITE)
    sasl.gl.drawCircle(100, 0, 4, false, PFD_WHITE) -- full right

    sasl.gl.drawWideLine(0 + (50 * get(navhdev)), 80, 0 + (50 * get(navhdev)), -80, 3, ND_PURPLE) -- Horizontal Deviation bar
    sasl.gl.drawWidePolyLine({-10 + (50 * get(navhdev)), 70, 0 + (50 * get(navhdev)), 80, 10 + (50 * get(navhdev)), 70}, 3, ND_PURPLE)

    sasl.gl.drawWideLine(0, -90, 0, -175, 3, ND_PURPLE)
    sasl.gl.restoreGraphicsContext ()

    sasl.gl.drawCircle(250, 250, 6, true, PFD_RED)
    sasl.gl.drawCircle(250, 250, 4, true, {0.0, 0.0, 0.0, 1.0})
    sasl.gl.drawTexture(rose_unaligned,0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawText(ndFont, 250, 345, "HDG", 30, false, false, TEXT_ALIGN_CENTER, PFD_RED)
    sasl.gl.drawText(ndFont, 125, 126, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(frstNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

local function draw_nav()
    sasl.gl.drawTexture(miniplane, 225, 216, 50, 50, PFD_WHITE)
    sasl.gl.drawRotatedTexture(rose, -1 * get(heading), 0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawWideLine(250, 417, 250, 433, 3, ND_YELLOW )
    sasl.gl.drawText(ndFont, 125, 126, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(frstNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

local function draw_nav_unaligned()
    sasl.gl.drawCircle(250, 250, 6, true, PFD_RED)
    sasl.gl.drawCircle(250, 250, 4, true, {0.0, 0.0, 0.0, 1.0})
    sasl.gl.drawTexture(rose_unaligned,0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawText(ndFont, 250, 345, "HDG", 30, false, false, TEXT_ALIGN_CENTER, PFD_RED)
    sasl.gl.drawText(ndFont, 250, 285, "MAP NOT AVAIL", 27, false, false, TEXT_ALIGN_CENTER, PFD_RED)
    sasl.gl.drawText(ndFont, 125, 126, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 190, 191, get(frstNdRnge) / 4, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
end

local function draw_arc()
    sasl.gl.drawTexture(miniplane, 225, 50, 50, 50, PFD_WHITE)
    sasl.gl.drawRotatedTexture(arcTape, -1 * get(heading), -123, -290, 746, 746, PFD_WHITE)
    sasl.gl.drawWideLine(250, 398, 250, 425, 3, ND_YELLOW )

    sasl.gl.setInternalLineWidth(2.0)
    sasl.gl.setInternalLineStipple(true, 8, 0xAAAA)
    sasl.gl.drawArcLine(250, 83, 247, 15, 150.0, PFD_WHITE)
    sasl.gl.drawArcLine(250, 83, 164, 15, 150.0, PFD_WHITE)
    sasl.gl.drawArcLine(250, 83, 81, 15, 150.0, PFD_WHITE)
    sasl.gl.setInternalLineWidth(1.0)
    sasl.gl.setInternalLineStipple( false)
    sasl.gl.drawText(ndFont, 110, 150, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 35, 187, 3 * (get(frstNdRnge) / 4), 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 390, 150, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_RIGHT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 465, 187, 3 * (get(frstNdRnge) / 4), 15, false, false, TEXT_ALIGN_RIGHT, PFD_BLUE)
end

local function draw_arc_unaligned()
    sasl.gl.drawTexture(arcTape_unaligned, -123, -290, 746, 746, PFD_WHITE)
    sasl.gl.drawText(ndFont, 250, 345, "HDG", 30, false, false, TEXT_ALIGN_CENTER, PFD_RED)
    sasl.gl.drawText(ndFont, 250, 285, "MAP NOT AVAIL", 27, false, false, TEXT_ALIGN_CENTER, PFD_RED)

    sasl.gl.setInternalLineWidth(2.0)
    sasl.gl.setInternalLineStipple(true, 8, 0xAAAA)
    sasl.gl.drawArcLine(250, 83, 247, 15, 150.0, PFD_RED)
    sasl.gl.drawArcLine(250, 83, 164, 15, 150.0, PFD_RED)
    sasl.gl.drawArcLine(250, 83, 81, 15, 150.0, PFD_RED)
    sasl.gl.setInternalLineWidth(1.0)
    sasl.gl.setInternalLineStipple( false)
    sasl.gl.drawText(ndFont, 110, 150, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 35, 187, 3 * (get(frstNdRnge) / 4), 15, false, false, TEXT_ALIGN_LEFT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 390, 150, get(frstNdRnge) / 2, 15, false, false, TEXT_ALIGN_RIGHT, PFD_BLUE)
    sasl.gl.drawText(ndFont, 465, 187, 3 * (get(frstNdRnge) / 4), 15, false, false, TEXT_ALIGN_RIGHT, PFD_BLUE)


    sasl.gl.drawCircle(250, 83, 6, true, PFD_RED)
    sasl.gl.drawCircle(250, 83, 4, true, {0.0, 0.0, 0.0, 1.0})
end


local function draw_unavail()
    sasl.gl.drawCircle(250, 250, 6, true, PFD_RED)
    sasl.gl.drawCircle(250, 250, 4, true, {0.0, 0.0, 0.0, 1.0})
    sasl.gl.drawTexture(rose_unaligned,0, 0, 500, 500, PFD_WHITE)
    sasl.gl.drawText(ndFont, 250, 295, "MAP NOT AVAIL", 27, false, false, TEXT_ALIGN_CENTER, PFD_RED)
end

function update()

    if not startup_complete then
        plane_startup()
        startup_complete = true
    end

    if get(rngeKnob) == 6 then
        set(rngeKnob, 5)
    end

    if get(frstNdMode) > 4 then
        set(frstNdMode, 4)
    end

    if get(rngeKnob) == 0 then
        frstNdRnge = 10
    elseif get(rngeKnob) == 1 then
        frstNdRnge = 20
    elseif get(rngeKnob) == 2 then
        frstNdRnge = 40
    elseif get(rngeKnob) == 3 then
        frstNdRnge = 80
    elseif get(rngeKnob) == 4 then
        frstNdRnge = 160
    elseif get(rngeKnob) == 5 then
        frstNdRnge = 320
    end

    if Timer < TimerFinal and selfTest == 0 then
        Timer = Timer + 1 * get(DELTA_TIME)
    else
        selfTest = 1
    end
end

function draw()
    sasl.gl.setClipArea(0,0,500,500)

    if get(BUS) > 0 then
        if selfTest == 1 then
        if get(frstNdMode) == 0 then
            if get(ADIRS_aligned) == 0 then
                draw_ils_unaligned()
            else
                draw_ils()
            end
        elseif get(frstNdMode) == 1 then
            if get(ADIRS_aligned) == 0 then
                draw_vor_unaligned()
            else
                draw_vor()
            end
        elseif get(frstNdMode) == 2 then
            if get(ADIRS_aligned) == 0 then
                draw_nav_unaligned()
            else
                draw_nav()
            end
        elseif get(frstNdMode) == 3 then
            if get(ADIRS_aligned) == 0 then
                draw_arc_unaligned()
            else
                draw_arc()
            end
        elseif get(frstNdMode) == 4 then
            if get(ADIRS_aligned) == 0 then
                draw_unavail()
            else
                draw_unavail()
            end
        end
        draw_overlay_text()
        Timer = 0
    else
        sasl.gl.drawText(AirbusFont, 250, 255, "SELF TEST IN PROGESS", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
        sasl.gl.drawText(AirbusFont, 250, 230, "MAX 40 SECONDS", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    end
    else
        Timer = 0
        selfTest = 0
    end
    sasl.gl.drawRectangle(0,0,500,500, {0.0, 0.0, 0.0, 1 - get(foNdBright)})
    sasl.gl.resetClipArea()
end