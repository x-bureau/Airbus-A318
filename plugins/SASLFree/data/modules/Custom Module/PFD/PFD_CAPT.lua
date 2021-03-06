-- A318 Created by X-Bureau --

position = {43, 647, 512, 513}
size = {1000, 1000}

--get datarefs
local BUS = globalProperty("A318/systems/ELEC/ACESS_V")

ADIRS_aligned = globalProperty("A318/systems/ADIRS/1/aligned")
ADIRS_mode = globalProperty("A318/systems/ADIRS/1/mode")
ias = globalProperty("A318/systems/ADIRS/1/air/ias")
heading = globalProperty("A318/systems/ADIRS/1/inertial/heading")
altitude = globalProperty("A318/systems/ADIRS/1/air/altitude")
pitch = globalProperty("A318/systems/ADIRS/1/inertial/pitch")
roll = globalProperty("A318/systems/ADIRS/1/inertial/roll")
radAlt = globalProperty("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")
radioMins = globalProperty("sim/cockpit/misc/radio_altimeter_minimum")

baroSetting = globalProperty("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot")
units = createGlobalPropertyi("A318/systems/PFD/QNH_unit_CAPT", 1)

--variables
local isAligned = 0
local mode = 0
local airspeed = 0
local hdg = 0
local alt = 0
local p = 0
local r = 0
local radioAlt = 0

local baro = 0
local baroUnits = 0

--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--colors
local BLACK = {0, 0, 0, 1.0}
local GREY = {0.35, 0.35, 0.35, 1.0}
local GREEN = {0.184, 0.733, 0.219, 1.0}
local YELLOW = {1, 1, 0, 1.0}
local PURPLE = {1, 0, 1, 1.0}
local ORANGE = {1, 0.625, 0.0, 1.0}
local WHITE = {1.0, 1.0, 1.0, 1.0}
local BLUE = {0.004, 1.0, 1.0, 1.0}
local RED = {1.0, 0.0, 0.0, 1.0}

--get images
local overlay = sasl.gl.loadImage("overlay.png", 0, 0, 503, 504)
local PitchBackground = sasl.gl.loadImage("horizon_background.png", 0, 0, 508, 1050)
local pitchMarks = sasl.gl.loadImage("horizon_pitch_scale.png", 0, 0, 575, 1050)
local pitchMarksGround = sasl.gl.loadImage("ground_horizon_pitch_scale.png", 0, 0, 575, 1050)
local bank = sasl.gl.loadImage("PFD_Alignment.png", 0, 0, 184, 287)
local ground = sasl.gl.loadImage("ground.png", 0, 0, 390, 500)
local plane = sasl.gl.loadImage("PFD_Other.png", 0, 0, 226, 48)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function fma()
  sasl.gl.drawWideLine(190, 1000, 190, 865, 4, WHITE)
  sasl.gl.drawWideLine(405, 1000, 405, 865, 4, WHITE)
  sasl.gl.drawWideLine(650, 1000, 650, 865, 4, WHITE)
  sasl.gl.drawWideLine(840, 1000, 840, 865, 4, WHITE)
end

function pfd()
  -- ARTIFICIAL HORIZON
  if isAligned == 0 then
    sasl.gl.drawText(AirbusFont, 440, 460, "ATT", 60, false, false, TEXT_ALIGN_CENTER, RED)
  else
    artificial_horizon()
  end
  --

  -- SPEED TAPE
  if mode == 0 and mode <= 1 then 
    sasl.gl.drawRectangle(0, 217, 115, 540, GREY)
    sasl.gl.drawWideLine(0, 757, 146, 757, 4, RED)
    sasl.gl.drawWideLine(115, 757, 115, 217, 4, RED)
    sasl.gl.drawWideLine(0, 217, 146, 217, 4, RED)
    sasl.gl.drawText(AirbusFont, 5, 460, "SPD", 60, false, false, TEXT_ALIGN_LEFT, RED)
  else
    sasl.gl.drawRectangle(0, 217, 115, 540, GREY)
    sasl.gl.drawWideLine(0, 757, 146, 757, 4, WHITE)
    sasl.gl.drawWideLine(115, 757, 115, 217, 4, WHITE)
    sasl.gl.drawWideLine(0, 217, 146, 217, 4, WHITE)
    speed_tape()
    sasl.gl.drawTriangle(115, 481, 146, 493, 146, 468, YELLOW)
    sasl.gl.drawWideLine(88, 481, 115, 481, 5, YELLOW)
    sasl.gl.drawWideLine(0, 481, 10, 481, 5, YELLOW)
  end
  --

  -- HEADING TAPE
  if isAligned == 0 or mode == 2 then
    sasl.gl.drawRectangle(190, 0, 500, 65, GREY)
    sasl.gl.drawWidePolyLine({190, 0, 190, 65, 690, 65, 690, 0}, 4, RED)
    sasl.gl.drawText(AirbusFont, 440, 10, "HDG", 60, false, false, TEXT_ALIGN_CENTER, RED)
  else
    sasl.gl.drawRectangle(190, 0, 500, 65, GREY)
    sasl.gl.drawWidePolyLine({190, 0, 190, 65, 690, 65, 690, 0}, 4, WHITE)
    heading_tape()
    sasl.gl.drawWideLine(440, 46, 440, 90, 5, YELLOW)
  end
  --

  -- ALTITUDE TAPE
  if mode == 0 then
    sasl.gl.drawRectangle(745, 505, 100, 252, GREY)
    sasl.gl.drawWideLine(745, 757, 895, 757, 4, RED)
    sasl.gl.drawWideLine(845, 757, 845, 505, 4, RED)
  
    sasl.gl.drawRectangle(745, 217, 100, 241, GREY)
    sasl.gl.drawWideLine(745, 217, 895, 217, 4, RED)
    sasl.gl.drawWideLine(845, 458, 845, 217, 4, RED)
    sasl.gl.drawText(AirbusFont, 745, 460, "ALT", 60, false, false, TEXT_ALIGN_LEFT, RED)
  else
    sasl.gl.drawRectangle(745, 505, 100, 252, GREY)
    sasl.gl.drawWideLine(745, 757, 895, 757, 4, WHITE)
    sasl.gl.drawWideLine(845, 757, 845, 505, 4, WHITE)

    sasl.gl.drawRectangle(745, 217, 100, 241, GREY)
    sasl.gl.drawWideLine(745, 217, 895, 217, 4, WHITE)
    sasl.gl.drawWideLine(845, 458, 845, 217, 4, WHITE)
    altitude_tape()

    sasl.gl.drawRectangle(745, 458, 100, 46, BLACK)
    sasl.gl.drawRectangle(845, 438, 50, 87, BLACK)
    sasl.gl.setClipArea(845, 438, 50, 87)
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(0, 115 - (1.75 * string.sub(alt, string.len(math.floor(alt)) - 1,  string.len(math.floor(alt)) - 0)))
    for t=1,3 do
     for i=0,4 do
        sasl.gl.drawText(AirbusFont, 850, (t * 175) + (i * 35), string.format("%02d",(i * 20)), 40, false, false, TEXT_ALIGN_LEFT, GREEN)
     end
    end
    sasl.gl.resetClipArea()
    sasl.gl.restoreGraphicsContext()
    sasl.gl.drawText(AirbusFont, 845, 463, math.floor(alt / 100), 50, false, false, TEXT_ALIGN_RIGHT, GREEN)
    sasl.gl.drawWidePolyLine({745, 505, 845, 505, 845, 525, 895, 525, 895, 438, 845, 438, 845, 458, 745, 458}, 4, YELLOW)
  end
  --

  -- VERTICAL SPEED
  if mode == 0 then
    sasl.gl.drawRectangle(925, 170, 25, 620, GREY)
    sasl.gl.drawRectangle(925, 270, 50, 420, GREY)
    sasl.gl.drawTriangle (950, 170, 950, 270, 975, 270, GREY)
    sasl.gl.drawTriangle (950, 790, 950, 690, 975, 690, GREY)
    sasl.gl.drawText(AirbusFont, 950, 515, "V", 60, false, false, TEXT_ALIGN_CENTER, RED)
    sasl.gl.drawText(AirbusFont, 950, 460, "/", 60, false, false, TEXT_ALIGN_CENTER, RED)
    sasl.gl.drawText(AirbusFont, 950, 405, "S", 60, false, false, TEXT_ALIGN_CENTER, RED)
  else
    sasl.gl.drawRectangle(925, 170, 25, 620, GREY)
    sasl.gl.drawRectangle(925, 270, 50, 420, GREY)
    sasl.gl.drawTriangle(950, 170, 950, 270, 975, 270, GREY)
    sasl.gl.drawTriangle(950, 790, 950, 690, 975, 690, GREY)
    sasl.gl.drawWideLine(925, 481, 950, 481, 5, YELLOW)
  end
  --

  -- QNH
  if mode == 0 then

  else
    sasl.gl.drawText(AirbusFont, 810, 110, "QNH", 40, false, false, TEXT_ALIGN_RIGHT, WHITE)
    if baroUnits == 1 then
      sasl.gl.drawText(AirbusFont, 835, 110, round((baro / 0.029529983071445), 0), 40, false, false, TEXT_ALIGN_LEFT, BLUE)
    else
      sasl.gl.drawText(AirbusFont, 835, 110, round(baro, 2), 40, false, false, TEXT_ALIGN_LEFT, BLUE)
    end
  end
  --

  fma()
end

function artificial_horizon()
  local horizon = 481 - (12.65 * p)
  local gap = horizon - 290

  sasl.gl.saveGraphicsContext()
  sasl.gl.setTranslateTransform(440, 481 - (12.65 * p))
  sasl.gl.drawRotatedTextureCenter(PitchBackground, -r, 0, 0 + (12.65 * p), -500, -1495, 1000, 3000, WHITE)
  if get(globalProperty("sim/flightmodel/failures/onground_any")) == 1 then
    sasl.gl.drawRotatedTexturePartCenter(pitchMarksGround, -r, 0, 0 + (12.65 * p), -150, -1500, 300, 3000, 241, 0, 94, 1050, WHITE)
  else
    sasl.gl.drawRotatedTexturePartCenter(pitchMarks, -r, 0, 0 + (12.65 * p), -150, -1500, 300, 3000, 241, 0, 94, 1050, WHITE)
  end
  sasl.gl.restoreGraphicsContext()

  sasl.gl.drawRotatedTexturePartCenter(bank, -r, 440, 481, 245, 685, 390, 72, 0, 252, 184, 34, WHITE)
  if radioAlt > 130 then
    sasl.gl.drawRotatedTextureCenter(ground, -r, 440, 481, 215, -210, 450, 500, WHITE)
  elseif  get(globalProperty("sim/flightmodel/failures/onground_any")) == 1 then
    
  else
    sasl.gl.drawRotatedTexturePartCenter(ground, -r, 440, 481, 215, (horizon - ((gap / 130) * r)) - 500, 450, 500, 0, 0, 390, 500, WHITE)
  end

  if radioAlt < 2500 then
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(440, 481)
    sasl.gl.setRotateTransform(r)
    if radioAlt <= 400 then
      if radioAlt > 50 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(radioAlt / 10 + 0.5) * 10, 50, false, false, TEXT_ALIGN_CENTER, ORANGE)
      elseif radioAlt > 5 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(radioAlt / 5 + 0.5) * 5, 50, false, false, TEXT_ALIGN_CENTER, ORANGE)
      else
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(radioAlt), 50, false, false, TEXT_ALIGN_CENTER, ORANGE)
      end
    else 
      if radioAlt > 50 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(radioAlt / 10 + 0.5) * 10, 45, false, false, TEXT_ALIGN_CENTER, GREEN)
     elseif radioAlt > 5 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(radioAlt / 5 + 0.5) * 5, 45, false, false, TEXT_ALIGN_CENTER, GREEN)
      else
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(radioAlt), 45, false, false, TEXT_ALIGN_CENTER, GREEN)
      end
    end
    sasl.gl.restoreGraphicsContext()
  end
  sasl.gl.drawTexture(overlay, 0, 0, 1005, 1000, WHITE)
  sasl.gl.drawTexture(plane, 200, 414, 480, 101, WHITE)
end

function speed_tape()
  sasl.gl.setClipArea(0, 217, 115, 540)
  sasl.gl.saveGraphicsContext()

  if airspeed < 35 then
    sasl.gl.setTranslateTransform(0, 276)
  else 
    sasl.gl.setTranslateTransform(0, 481 + (-6 * airspeed))
  end

  for i=4,50 do
    sasl.gl.drawWideLine(90, (0 + (i * 60)), 115, (0 + (i * 60)), 4, WHITE)
    sasl.gl.drawText(AirbusFont, 80, (-20 + ((i - 2) * 120)), string.format("%03d", (20 * (i - 2))), 50, false, false, TEXT_ALIGN_RIGHT, WHITE)
  end

  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function heading_tape()
  sasl.gl.setClipArea(190, 0, 500, 65)
  sasl.gl.saveGraphicsContext()

  sasl.gl.setTranslateTransform(-2512 - (8.15 * hdg), 0)
  for t=0,3 do
    for i=1,72 do
      sasl.gl.drawWideLine((t * 2952) + (41 * i), 50, (t * 2952) + (41 * i), 65, 4, WHITE)
    end
    for i=1,36 do
      sasl.gl.drawWideLine((t * 2952) + (82 * i), 35, (t * 2952) + (82 * i), 65, 4, WHITE)
      sasl.gl.drawText(AirbusFont, (t * 2952) + (82 * i), 3, i, 38, false, false, TEXT_ALIGN_CENTER, WHITE)
    end
  end
  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function altitude_tape()
  sasl.gl.setClipArea(745, 217, 100, 540)
  sasl.gl.saveGraphicsContext()

  sasl.gl.setTranslateTransform(0, 481 - (2.45 * alt))
  for i=0,450 do
    sasl.gl.drawText(AirbusFont, 827, -18 + (245 * i), string.format("%03d", i), 50, false, false, TEXT_ALIGN_RIGHT, WHITE)
  end
  for i=0,2250 do
    sasl.gl.drawWideLine(830, 0 + (49 * i), 845, 0 + (49 * i), 4, WHITE)
  end


  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function update()
  isAligned = get(ADIRS_aligned)
  mode = get(ADIRS_mode)

  airspeed = get(ias)
  hdg = get(heading)
  alt = get(altitude)
  p = get(pitch)
  r = get(roll)
  radioAlt = get(radAlt)

  baro = get(baroSetting)
  baroUnits = get(units)
end

function draw()
  sasl.gl.setClipArea(0, 0, 1000, 1000)
  if get(BUS) > 0 then
    pfd()
  else
    -- off
  end
  sasl.gl.resetClipArea()
end