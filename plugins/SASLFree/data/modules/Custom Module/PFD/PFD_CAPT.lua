-- A318 Created by X-Bureau --

position = {43, 647, 512, 513}
size = {1000, 1000}

--get datarefs
local ADIRS_aligned = globalProperty("A318/systems/ADIRS/1/aligned")
local ADIRS_mode = globalProperty("A318/systems/ADIRS/1/mode")
local ias = globalProperty("A318/systems/ADIRS/1/air/ias")
local heading = globalProperty("A318/systems/ADIRS/1/inertial/heading")
local altitude = globalProperty("A318/systems/ADIRS/1/air/altitude")
local pitch = globalProperty("A318/systems/ADIRS/1/inertial/pitch")
local roll = globalProperty("A318/systems/ADIRS/1/inertial/roll")
local radAlt = globalProperty("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")
local radioMins = globalProperty("sim/cockpit/misc/radio_altimeter_minimum")

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


function fma()
  sasl.gl.drawWideLine(190, 1000, 190, 865, 4, WHITE)
  sasl.gl.drawWideLine(405, 1000, 405, 865, 4, WHITE)
  sasl.gl.drawWideLine(650, 1000, 650, 865, 4, WHITE)
  sasl.gl.drawWideLine(840, 1000, 840, 865, 4, WHITE)
end

function pfd_irs_off()
  sasl.gl.drawText(AirbusFont, 440, 460, "ATT", 60, false, false, TEXT_ALIGN_CENTER, RED)

  -- SPEED TAPE
  sasl.gl.drawRectangle(0, 217, 115, 540, GREY)
  sasl.gl.drawWideLine(0, 757, 146, 757, 4, RED)
  sasl.gl.drawWideLine(115, 757, 115, 217, 4, RED)
  sasl.gl.drawWideLine(0, 217, 146, 217, 4, RED)
  sasl.gl.drawText(AirbusFont, 5, 460, "SPD", 60, false, false, TEXT_ALIGN_LEFT, RED)
  --

  -- HEADING TAPE
  sasl.gl.drawRectangle(190, 0, 500, 65, GREY)
  sasl.gl.drawWidePolyLine({190, 0, 190, 65, 690, 65, 690, 0}, 4, RED)
  sasl.gl.drawText(AirbusFont, 440, 10, "HDG", 60, false, false, TEXT_ALIGN_CENTER, RED)
  --

  -- ALTITUDE TAPE
  sasl.gl.drawRectangle(745, 505, 100, 252, GREY)
  sasl.gl.drawWideLine(745, 757, 895, 757, 4, RED)
  sasl.gl.drawWideLine(845, 757, 845, 505, 4, RED)

  sasl.gl.drawRectangle(745, 217, 100, 241, GREY)
  sasl.gl.drawWideLine(745, 217, 895, 217, 4, RED)
  sasl.gl.drawWideLine(845, 458, 845, 217, 4, RED)
  sasl.gl.drawText(AirbusFont, 745, 460, "ALT", 60, false, false, TEXT_ALIGN_LEFT, RED)
  --

  -- VERTICAL SPEED
  sasl.gl.drawRectangle(925, 170, 25, 620, GREY)
  sasl.gl.drawRectangle(925, 270, 50, 420, GREY)
  sasl.gl.drawTriangle (950, 170, 950, 270, 975, 270, GREY)
  sasl.gl.drawTriangle (950, 790, 950, 690, 975, 690, GREY)

  sasl.gl.drawText(AirbusFont, 950, 515, "V", 60, false, false, TEXT_ALIGN_CENTER, RED)
  sasl.gl.drawText(AirbusFont, 950, 460, "/", 60, false, false, TEXT_ALIGN_CENTER, RED)
  sasl.gl.drawText(AirbusFont, 950, 405, "S", 60, false, false, TEXT_ALIGN_CENTER, RED)
  --
end

function pfd_irs_align()
  sasl.gl.drawText(AirbusFont, 440, 460, "ATT", 60, false, false, TEXT_ALIGN_CENTER, RED)

  -- SPEED TAPE
  sasl.gl.drawRectangle(0, 217, 115, 540, GREY)
  sasl.gl.drawWideLine(0, 757, 146, 757, 4, WHITE)
  sasl.gl.drawWideLine(115, 757, 115, 217, 4, WHITE)
  sasl.gl.drawWideLine(0, 217, 146, 217, 4, WHITE)
  speed_tape()
  sasl.gl.drawTriangle(115, 481, 146, 493, 146, 468, YELLOW)
  sasl.gl.drawWideLine(88, 481, 115, 481, 5, YELLOW)
  sasl.gl.drawWideLine(0, 481, 10, 481, 5, YELLOW)
  --

  -- HEADING TAPE
  sasl.gl.drawRectangle(190, 0, 500, 65, GREY)
  sasl.gl.drawWidePolyLine({190, 0, 190, 65, 690, 65, 690, 0}, 4, RED)
  sasl.gl.drawText(AirbusFont, 440, 10, "HDG", 60, false, false, TEXT_ALIGN_CENTER, RED)
  --

  -- ALTITUDE TAPE
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
  sasl.gl.setTranslateTransform(0, 115 - (1.75 * string.sub(get(altitude), string.len(math.floor(get(altitude))) - 1,  string.len(math.floor(get(altitude))) - 0)))
  for t=1,3 do
    for i=0,4 do
      sasl.gl.drawText(AirbusFont, 850, (t * 175) + (i * 35), string.format("%02d",(i * 20)), 40, false, false, TEXT_ALIGN_LEFT, GREEN)
    end
  end
  sasl.gl.resetClipArea()
  sasl.gl.restoreGraphicsContext()
  sasl.gl.drawText(AirbusFont, 845, 463, math.floor(get(altitude) / 100), 50, false, false, TEXT_ALIGN_RIGHT, GREEN)
  sasl.gl.drawWidePolyLine({745, 505, 845, 505, 845, 525, 895, 525, 895, 438, 845, 438, 845, 458, 745, 458}, 4, YELLOW)
  --

  -- VERTICAL SPEED
  sasl.gl.drawRectangle(925, 170, 25, 620, GREY)
  sasl.gl.drawRectangle(925, 270, 50, 420, GREY)
  sasl.gl.drawTriangle(950, 170, 950, 270, 975, 270, GREY)
  sasl.gl.drawTriangle(950, 790, 950, 690, 975, 690, GREY)
  sasl.gl.drawWideLine(925, 481, 950, 481, 5, YELLOW)
end

function pfd()
  artificial_horizon()
  -- SPEED TAPE
  sasl.gl.drawRectangle(0, 217, 115, 540, GREY)
  sasl.gl.drawWideLine(0, 757, 146, 757, 4, WHITE)
  sasl.gl.drawWideLine(115, 757, 115, 217, 4, WHITE)
  sasl.gl.drawWideLine(0, 217, 146, 217, 4, WHITE)
  speed_tape()
  sasl.gl.drawTriangle(115, 481, 146, 493, 146, 468, YELLOW)
  sasl.gl.drawWideLine(88, 481, 115, 481, 5, YELLOW)
  sasl.gl.drawWideLine(0, 481, 10, 481, 5, YELLOW)
  --

  -- HEADING TAPE
  sasl.gl.drawRectangle(190, 0, 500, 65, GREY)
  sasl.gl.drawWidePolyLine({190, 0, 190, 65, 690, 65, 690, 0}, 4, WHITE)
  heading_tape()
  sasl.gl.drawWideLine(440, 46, 440, 90, 5, YELLOW)
  --

  -- ALTITUDE TAPE
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
  sasl.gl.setTranslateTransform(0, 115 - (1.75 * string.sub(get(altitude), string.len(math.floor(get(altitude))) - 1,  string.len(math.floor(get(altitude))) - 0)))
  for t=1,3 do
    for i=0,4 do
      sasl.gl.drawText(AirbusFont, 850, (t * 175) + (i * 35), string.format("%02d",(i * 20)), 40, false, false, TEXT_ALIGN_LEFT, GREEN)
    end
  end
  sasl.gl.resetClipArea()
  sasl.gl.restoreGraphicsContext()
  sasl.gl.drawText(AirbusFont, 845, 463, math.floor(get(altitude) / 100), 50, false, false, TEXT_ALIGN_RIGHT, GREEN)
  sasl.gl.drawWidePolyLine({745, 505, 845, 505, 845, 525, 895, 525, 895, 438, 845, 438, 845, 458, 745, 458}, 4, YELLOW)
  --

  -- VERTICAL SPEED
  sasl.gl.drawRectangle(925, 170, 25, 620, GREY)
  sasl.gl.drawRectangle(925, 270, 50, 420, GREY)
  sasl.gl.drawTriangle(950, 170, 950, 270, 975, 270, GREY)
  sasl.gl.drawTriangle(950, 790, 950, 690, 975, 690, GREY)
  sasl.gl.drawWideLine(925, 481, 950, 481, 5, YELLOW)
  --
end

function pfd_att()
  sasl.gl.drawText(AirbusFont, 440, 460, "ATT", 60, false, false, TEXT_ALIGN_CENTER, RED)

  -- SPEED TAPE
  sasl.gl.drawRectangle(0, 217, 115, 540, GREY)
  sasl.gl.drawWideLine(0, 757, 146, 757, 4, WHITE)
  sasl.gl.drawWideLine(115, 757, 115, 217, 4, WHITE)
  sasl.gl.drawWideLine(0, 217, 146, 217, 4, WHITE)
  speed_tape()
  sasl.gl.drawTriangle(115, 481, 146, 493, 146, 468, YELLOW)
  sasl.gl.drawWideLine(88, 481, 115, 481, 5, YELLOW)
  sasl.gl.drawWideLine(0, 481, 10, 481, 5, YELLOW)
  --

  -- HEADING TAPE
  sasl.gl.drawRectangle(190, 0, 500, 65, GREY)
  sasl.gl.drawWidePolyLine({190, 0, 190, 65, 690, 65, 690, 0}, 4, RED)
  sasl.gl.drawText(AirbusFont, 440, 10, "HDG", 60, false, false, TEXT_ALIGN_CENTER, RED)
  --

  -- ALTITUDE TAPE
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
  sasl.gl.setTranslateTransform(0, 115 - (1.75 * string.sub(get(altitude), string.len(math.floor(get(altitude))) - 1,  string.len(math.floor(get(altitude))) - 0)))
  for t=1,3 do
    for i=0,4 do
      sasl.gl.drawText(AirbusFont, 850, (t * 175) + (i * 35), string.format("%02d",(i * 20)), 40, false, false, TEXT_ALIGN_LEFT, GREEN)
    end
  end
  sasl.gl.resetClipArea()
  sasl.gl.restoreGraphicsContext()
  sasl.gl.drawText(AirbusFont, 845, 463, math.floor(get(altitude) / 100), 50, false, false, TEXT_ALIGN_RIGHT, GREEN)
  sasl.gl.drawWidePolyLine({745, 505, 845, 505, 845, 525, 895, 525, 895, 438, 845, 438, 845, 458, 745, 458}, 4, YELLOW)
  --

  -- VERTICAL SPEED
  sasl.gl.drawRectangle(925, 170, 25, 620, GREY)
  sasl.gl.drawRectangle(925, 270, 50, 420, GREY)
  sasl.gl.drawTriangle(950, 170, 950, 270, 975, 270, GREY)
  sasl.gl.drawTriangle(950, 790, 950, 690, 975, 690, GREY)
  sasl.gl.drawWideLine(925, 481, 950, 481, 5, YELLOW)
end

function artificial_horizon()
  local horizon = 481 - (12.65 * get(pitch))
  local gap = horizon - 290

  sasl.gl.saveGraphicsContext()
  sasl.gl.setTranslateTransform(440, 481 - (12.65 * get(pitch)))
  sasl.gl.drawRotatedTextureCenter(PitchBackground, -get(roll), 0, 0 + (12.65 * get(pitch)), -500, -1495, 1000, 3000, WHITE)
  if get(globalProperty("sim/flightmodel/failures/onground_any")) == 1 then
    sasl.gl.drawRotatedTexturePartCenter(pitchMarksGround, -get(roll), 0, 0 + (12.65 * get(pitch)), -150, -1500, 300, 3000, 241, 0, 94, 1050, WHITE)
  else
    sasl.gl.drawRotatedTexturePartCenter(pitchMarks, -get(roll), 0, 0 + (12.65 * get(pitch)), -150, -1500, 300, 3000, 241, 0, 94, 1050, WHITE)
  end
  sasl.gl.restoreGraphicsContext()

  sasl.gl.drawRotatedTexturePartCenter(bank, -get(roll), 440, 481, 245, 685, 390, 72, 0, 252, 184, 34, WHITE)
  if get(radAlt) > 130 then
    sasl.gl.drawRotatedTextureCenter(ground, -get(roll), 440, 481, 215, -210, 450, 500, WHITE)
  elseif  get(globalProperty("sim/flightmodel/failures/onground_any")) == 1 then
    
  else
    sasl.gl.drawRotatedTexturePartCenter(ground, -get(roll), 440, 481, 215, (horizon - ((gap / 130) * get(radAlt))) - 500, 450, 500, 0, 0, 390, 500, WHITE)
  end

  if get(radAlt) < 2500 then
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(440, 481)
    sasl.gl.setRotateTransform(-get(roll))
    if get(radAlt) <= 400 then
      if get(radAlt) > 50 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(get(radAlt) / 10 + 0.5) * 10, 50, false, false, TEXT_ALIGN_CENTER, ORANGE)
      elseif get(radAlt) > 5 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(get(radAlt) / 5 + 0.5) * 5, 50, false, false, TEXT_ALIGN_CENTER, ORANGE)
      else
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(get(radAlt)), 50, false, false, TEXT_ALIGN_CENTER, ORANGE)
      end
    else 
      if get(radAlt) > 50 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(get(radAlt) / 10 + 0.5) * 10, 45, false, false, TEXT_ALIGN_CENTER, GREEN)
     elseif get(radAlt) > 5 then
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(get(radAlt) / 5 + 0.5) * 5, 45, false, false, TEXT_ALIGN_CENTER, GREEN)
      else
        sasl.gl.drawText(AirbusFont, 0, -251, math.floor(get(radAlt)), 45, false, false, TEXT_ALIGN_CENTER, GREEN)
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

  if get(ias) < 35 then
    sasl.gl.setTranslateTransform(0, 276)
  else 
    sasl.gl.setTranslateTransform(0, 481 + (-6 * get(ias)))
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

  sasl.gl.setTranslateTransform(-2512 - (8.15 * get(heading)), 0)
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

  sasl.gl.setTranslateTransform(0, 481 - (2.45 * get(altitude)))
  for i=0,450 do
    sasl.gl.drawText(AirbusFont, 827, -18 + (245 * i), string.format("%03d", i), 50, false, false, TEXT_ALIGN_RIGHT, WHITE)
  end
  for i=0,2250 do
    sasl.gl.drawWideLine(830, 0 + (49 * i), 845, 0 + (49 * i), 4, WHITE)
  end


  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function draw()
  sasl.gl.setClipArea(0, 0, 1000, 1000)

  if get(ADIRS_mode) == 0 then
    pfd_irs_off()
  elseif get(ADIRS_mode) == 1 and get(ADIRS_aligned) == 0 then
    pfd_irs_align()
  elseif get(ADIRS_mode) == 1 and get(ADIRS_aligned) == 1 then
    pfd()
  else 
    pfd_att()
  end
  fma()
  sasl.gl.resetClipArea()
end

    

