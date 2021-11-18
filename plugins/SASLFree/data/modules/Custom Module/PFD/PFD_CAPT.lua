-- A318 Created by X-Bureau --
position = {49, 52, 1262, 1389}

-- position = {1, 5, 10, 25}
size = {500, 500}

local BUS = globalProperty("A318/systems/ELEC/ACESS_V")
local selfTest = 0

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")
local Timer = 0
local TimerFinal = math.random(25, 40)

local ADIRS_aligned = globalProperty("A318/systems/ADIRS/1/aligned")
local ADIRS_mode = globalProperty("A318/systems/ADIRS/1/mode")
local ias = globalProperty("A318/systems/ADIRS/1/air/ias")
local heading = globalProperty("A318/systems/ADIRS/1/inertial/heading")
local altitude = globalProperty("A318/systems/ADIRS/1/air/altitude")
local vertSpeed = globalProperty("sim/cockpit2/gauges/indicators/vvi_fpm_pilot")
local pitch = globalProperty("A318/systems/ADIRS/1/inertial/pitch")
local roll = globalProperty("A318/systems/ADIRS/1/inertial/roll")
local sideSlip = globalProperty("sim/cockpit2/gauges/indicators/sideslip_degrees")
local radAlt = globalProperty("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")
local radioMins = globalProperty("sim/cockpit/misc/radio_altimeter_minimum")

local baroSetting = globalProperty("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot")
local units = createGlobalPropertyi("A318/systems/PFD/QNH_unit_CAPT", 1)

local captPfdBright = createGlobalPropertyf("A318/cockpit/capt/pfdBright", 1)

--variables
local startup_complete = false
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")

local isAligned = 0
local mode = 0
local airspeed = 0
local hdg = 0
local alt = 0
local vvi = 0
local p = 0
local r = 0
local slip = 0
local radioAlt = 0

local baro = 0
local baroUnits = 0

--get images
local overlay = sasl.gl.loadImage("overlay.png")
local PitchBackground = sasl.gl.loadImage("horizon.png")
local pitchMarks = sasl.gl.loadImage("pitchMarks.png")
local bank = sasl.gl.loadImage("PFD_Alignment.png", 0, 0, 184, 287)
local ground = sasl.gl.loadImage("ground.png", 0, 0, 390, 500)
local plane = sasl.gl.loadImage("PFD/plane.png", 0, 0, 226, 48)

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


function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function fma()
  sasl.gl.drawWideLine(100, 500, 100, 433, 2, ECAM_COLOURS.WHITE)
  sasl.gl.drawWideLine(205, 500, 205, 433, 2, ECAM_COLOURS.WHITE)
  sasl.gl.drawWideLine(324, 500, 324, 433, 2, ECAM_COLOURS.WHITE)
  sasl.gl.drawWideLine(419, 500, 419, 433, 2, ECAM_COLOURS.WHITE)
end

function pfd()
  -- ARTIFICIAL HORIZON
  if isAligned == 0 and mode <= 1 then
    sasl.gl.drawText(AirbusFont, 220, 232, "ATT", 31, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.RED)
  else
    artificial_horizon()
    angleOfBank()
  end
  --

  -- SPEED TAPE
  if mode == 0 then 
    sasl.gl.drawRectangle(0, 108, 60, 270, ECAM_COLOURS.GREY)
    sasl.gl.drawWideLine(0, 378, 76, 378, 2, ECAM_COLOURS.RED)
    sasl.gl.drawWideLine(61, 108, 61, 378, 2, ECAM_COLOURS.RED)
    sasl.gl.drawWideLine(0, 108, 76, 108, 2, ECAM_COLOURS.RED)
    sasl.gl.drawText(AirbusFont, 2, 232, "SPD", 31, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.RED)
  else
    sasl.gl.drawRectangle(0, 108, 60, 270, ECAM_COLOURS.GREY)
    sasl.gl.drawWideLine(0, 378, 76, 378, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(61, 108, 61, 378, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(0, 108, 76, 108, 2, ECAM_COLOURS.WHITE)
    speed_tape()
    sasl.gl.drawTriangle(60, 243, 77, 249, 77, 237, ECAM_COLOURS.YELLOW)
    sasl.gl.drawWideLine(45, 243, 65, 243, 3, ECAM_COLOURS.YELLOW)
    sasl.gl.drawWideLine(0, 243, 5, 243, 3, ECAM_COLOURS.YELLOW)
  end
  --

  -- HEADING TAPE
  if isAligned == 0 or mode == 2 then
    sasl.gl.drawRectangle(101, 0, 235, 39, ECAM_COLOURS.GREY)
    sasl.gl.drawWidePolyLine({101, 0, 101, 39, 335, 39, 335, 0}, 2, ECAM_COLOURS.RED)
    sasl.gl.drawText(AirbusFont, 220, 7, "HDG", 32, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.RED)
  else
    sasl.gl.drawRectangle(101, 0, 235, 39, ECAM_COLOURS.GREY)
    sasl.gl.drawWidePolyLine({101, 0, 101, 39, 335, 39, 335, 0}, 2, ECAM_COLOURS.WHITE)
    heading_tape()
    sasl.gl.drawWideLine(218, 33, 218, 57, 4, ECAM_COLOURS.YELLOW)
  end
  --

  -- ALTITUDE TAPE
  if mode == 0 then
    sasl.gl.drawRectangle(372, 255, 43, 123, ECAM_COLOURS.GREY)
    sasl.gl.drawWideLine(372, 378, 436, 378, 2, ECAM_COLOURS.RED)
    sasl.gl.drawWideLine(415, 378, 415, 255, 2, ECAM_COLOURS.RED)
  
    sasl.gl.drawRectangle(372, 108, 43, 122, ECAM_COLOURS.GREY)
    sasl.gl.drawWideLine(372, 108, 436, 108, 2, ECAM_COLOURS.RED)
    sasl.gl.drawWideLine(415, 230, 415, 108, 2, ECAM_COLOURS.RED)
    sasl.gl.drawText(AirbusFont, 395, 232, "ALT", 31, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.RED)
  else
    sasl.gl.drawRectangle(372, 255, 43, 123, ECAM_COLOURS.GREY)
    sasl.gl.drawWideLine(372, 378, 436, 378, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(415, 378, 415, 255, 2, ECAM_COLOURS.WHITE)
  
    sasl.gl.drawRectangle(372, 108, 43, 122, ECAM_COLOURS.GREY)
    sasl.gl.drawWideLine(372, 108, 436, 108, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(415, 230, 415, 108, 2, ECAM_COLOURS.WHITE)
    altitude_tape()

    sasl.gl.drawRectangle(372, 230, 43, 25, ECAM_COLOURS.BLACK)
    sasl.gl.drawRectangle(415, 221, 21, 42, ECAM_COLOURS.BLACK)
    sasl.gl.setClipArea(415, 221, 21, 42)
    sasl.gl.saveGraphicsContext()
    if get(alt) >= 0 then
      sasl.gl.setTranslateTransform(0, 170 - (0.65 * string.sub(alt, string.len(math.floor(alt)) - 1,  string.len(math.floor(alt)) - 0)))
    else
      sasl.gl.setTranslateTransform(0, 170 + (0.65 * string.sub(alt, string.len(math.floor(alt)) - 1,  string.len(math.floor(alt)) - 0)))
    end
    for t=0,2 do
     for i=0,4 do
      if get(alt) > 0 then
        sasl.gl.setFontGlyphSpacingFactor (AirbusFont, 0.8)
        sasl.gl.drawText(AirbusFont, 416, (t * 65) + (i * 13), string.format("%02d",(i * 20)), 17, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
        sasl.gl.setFontGlyphSpacingFactor (AirbusFont, 1)
      else
        sasl.gl.setFontGlyphSpacingFactor (AirbusFont, 0.8)
        sasl.gl.drawText(AirbusFont, 416, (t * 65) + (i * -13), string.format("%02d",(i * 20)), 17, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
        sasl.gl.setFontGlyphSpacingFactor (AirbusFont, 1)
      end
     end
    end
    sasl.gl.resetClipArea()
    sasl.gl.restoreGraphicsContext()
    sasl.gl.drawText(AirbusFont, 417, 232, math.floor(alt / 100), 28, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
    sasl.gl.drawWidePolyLine({372, 255, 415, 255, 415, 263, 436, 263, 436, 221, 415, 221, 415, 230, 372, 230}, 2, ECAM_COLOURS.YELLOW)
  end
  --

  -- VERTICAL SPEED
  if mode == 0 then
    sasl.gl.drawRectangle(460, 87, 14, 312, ECAM_COLOURS.GREY)
    sasl.gl.drawRectangle(474, 140, 17, 205, ECAM_COLOURS.GREY)
    sasl.gl.drawTriangle(474, 87, 474, 140, 491, 140, ECAM_COLOURS.GREY)
    sasl.gl.drawTriangle(474, 399, 474, 345, 491, 345, ECAM_COLOURS.GREY)
    sasl.gl.drawText(AirbusFont, 477, 259, "V", 31, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.RED)
    sasl.gl.drawText(AirbusFont, 477, 231, "/", 31, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.RED)
    sasl.gl.drawText(AirbusFont, 477, 205, "S", 31, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.RED)
  else
    sasl.gl.drawRectangle(460, 87, 14, 312, ECAM_COLOURS.GREY)
    sasl.gl.drawRectangle(474, 140, 17, 205, ECAM_COLOURS.GREY)
    sasl.gl.drawTriangle(474, 87, 474, 140, 491, 140, ECAM_COLOURS.GREY)
    sasl.gl.drawTriangle(474, 399, 474, 345, 491, 345, ECAM_COLOURS.GREY)

    sasl.gl.drawWideLine(470, 389, 477, 389, 4, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 471, 383, "6", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 372, 478, 372, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 356, 478, 356, 4, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 472, 351, "2", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 340, 478, 340, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 324, 478, 324, 4, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 472, 318, "1", 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 283, 478, 283, 2, ECAM_COLOURS.WHITE)

    sasl.gl.drawWideLine(471, 203, 478, 203, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 472, 156, "1", 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 162, 478, 162, 4, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 146, 478, 146, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 472, 125, "2", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 130, 478, 130, 4, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(471, 114, 478, 114, 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 471, 92, "6", 17, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    sasl.gl.drawWideLine(470, 98, 477, 98, 4, ECAM_COLOURS.WHITE)

    -- actual vertical speed bar
    sasl.gl.setClipArea(460, 65, 35, 370)
    if vvi >= 0 then
      if vvi >= 0 and vvi < 1000 then
        sasl.gl.drawWideLine(473, 243 + (0.075 * vvi), 520, 242, 2, ECAM_COLOURS.GREEN)
        if vvi > 100 then
          sasl.gl.drawRectangle(484, 243 + (0.075 * vvi), 13, 17, ECAM_COLOURS.BLACK)
          sasl.gl.drawText(AirbusFont, 497, 244 + (0.075 * vvi), math.floor(vvi / 100), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        end
      elseif vvi >= 1000 and vvi < 2000 then
        sasl.gl.drawWideLine(473, 324 + (0.033 * (vvi - 1000)), 520, 242, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawRectangle(475, 324 + (0.033 * (vvi - 1000)), 20, 17, ECAM_COLOURS.BLACK)
        sasl.gl.drawText(AirbusFont, 476, 325 + (0.033 * (vvi - 1000)), math.floor(vvi / 100), 20, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
      elseif vvi >= 2000 and vvi < 6000 then
        sasl.gl.drawWideLine(473, 356 + (0.008 * (vvi - 2000)), 520, 242, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawRectangle(471, 356 + (0.008 * (vvi - 2000)), 20, 17, ECAM_COLOURS.BLACK)
        sasl.gl.drawText(AirbusFont, 472, 357 + (0.008 * (vvi - 2000)), math.floor(vvi / 100), 20, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
      else
        sasl.gl.drawWideLine(471, 243 + (0.0243 * 6000), 520, 242, 2, ECAM_COLOURS.ORANGE)
        if math.abs(vvi) > 10000 then
          sasl.gl.drawRectangle(456, 243 + (0.0243 * 6000), 39, 17, ECAM_COLOURS.BLACK)
        else
          sasl.gl.drawRectangle(471, 243 + (0.0243 * 6000), 26, 17, ECAM_COLOURS.BLACK)
        end
        sasl.gl.drawText(AirbusFont, 497, 244 + (0.0243 * 6000), math.floor(vvi / 100), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
      end
    elseif vvi < 0 then
      if vvi < 0 and vvi > -1000 then
        sasl.gl.drawWideLine(473, 243 + (0.075 * vvi), 520, 242, 2, ECAM_COLOURS.GREEN)
        if vvi < -100 then
          sasl.gl.drawRectangle(484, 226 + (0.075 * vvi), 13, 17, ECAM_COLOURS.BLACK)
          sasl.gl.drawText(AirbusFont, 497, 227 + (0.075 * vvi), math.floor(math.abs(vvi) / 100), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.GREEN)
        end
      elseif vvi <= -1000 and vvi > -2000 then
        sasl.gl.drawWideLine(473, 162 + (0.033 * (vvi + 1000)), 520, 242, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawRectangle(475, 145 + (0.033 * (vvi + 1000)), 20, 17, ECAM_COLOURS.BLACK)
        sasl.gl.drawText(AirbusFont, 476, 146 + (0.033 * (vvi + 1000)), math.floor(math.abs(vvi) / 100), 20, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
      elseif vvi <= -2000 and vvi > -6000 then
        sasl.gl.drawWideLine(473, 130 + (0.008 * (vvi + 2000)), 520, 242, 2, ECAM_COLOURS.GREEN)
        sasl.gl.drawRectangle(471, 113 + (0.008 * (vvi + 2000)), 20, 17, ECAM_COLOURS.BLACK)
        sasl.gl.drawText(AirbusFont, 472, 114 + (0.008 * (vvi + 2000)), math.floor(math.abs(vvi) / 100), 20, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.GREEN)
      else
        sasl.gl.drawWideLine(471, 243 + (0.0243 * -6000), 520, 242, 2, ECAM_COLOURS.ORANGE)
        if math.abs(vvi) > 10000 then
          sasl.gl.drawRectangle(456, 243 + (0.0243 * -6000), 39, 17, ECAM_COLOURS.BLACK)
        else
          sasl.gl.drawRectangle(471, 243 + (0.0243 * -6000), 26, 17, ECAM_COLOURS.BLACK)
        end
        sasl.gl.drawText(AirbusFont, 497, 244 + (0.0243 * -6000), math.floor(math.abs(vvi) / 100), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.ORANGE)
      end
    end
    sasl.gl.resetClipArea()

    sasl.gl.drawWideLine(459, 243, 477, 243, 4, ECAM_COLOURS.YELLOW)
  end
  --

  -- QNH
  if mode == 0 then

  else
    sasl.gl.drawText(AirbusFont, 404, 56, "QNH", 19, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
    if baroUnits == 1 then
      sasl.gl.drawText(AirbusFont, 414, 56, round((baro / 0.029529983071445), 0), 19, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    else
      sasl.gl.drawText(AirbusFont, 414, 56, round(baro, 2), 19, true, false, TEXT_ALIGN_LEFT, ECAM_COLOURS.BLUE)
    end
  end
  --

  fma()
end

function angleOfBank()
  sasl.gl.saveGraphicsContext()
  sasl.gl.setTranslateTransform(220,242)
  sasl.gl.setRotateTransform(-r)

  sasl.gl.drawWidePolyLine({0, 118, -12, 118, 0, 136, 12, 118, 0, 118}, 2, ECAM_COLOURS.YELLOW)

  sasl.gl.restoreGraphicsContext()
end

function artificial_horizon()
  local horizon = 242 - (6.0625 * p)
  local gap = horizon - 145

  sasl.gl.saveGraphicsContext()
  sasl.gl.setTranslateTransform(220, 242 - (6.0625 * p))
  sasl.gl.drawRotatedTextureCenter(PitchBackground, -r, 0, 0 + (6.0625 * p), -250, -750, 500, 1500, ECAM_COLOURS.WHITE)
  sasl.gl.drawRotatedTextureCenter(pitchMarks, -r, 0, 0 + (6.0625 * p), -67, -485, 130, 970, ECAM_COLOURS.WHITE)
  sasl.gl.restoreGraphicsContext()

  sasl.gl.drawRotatedTexturePartCenter(bank, -r, 220, 242, 122, 342, 195, 36, 0, 252, 184, 34, ECAM_COLOURS.WHITE)
  if radioAlt > 130 then
    sasl.gl.drawRotatedTextureCenter(ground, -r, 220, 242, 108, -105, 225, 250, ECAM_COLOURS.WHITE)
  elseif  get(globalProperty("sim/flightmodel/failures/onground_any")) == 1 then
    sasl.gl.drawRotatedTextureCenter(ground, -r, 220, 242, 98, -4 - (6.0625 * p), 245, 250, ECAM_COLOURS.WHITE)
  else
    sasl.gl.drawRotatedTextureCenter(ground, -r, 220, 242, 98, (horizon - ((gap / 130) * (radioAlt - 3.5))) - 250, 245, 250, ECAM_COLOURS.WHITE)
  end
  
  if radioAlt < 2500 then
    sasl.gl.saveGraphicsContext()
    sasl.gl.setTranslateTransform(220, 242)
    sasl.gl.setRotateTransform(-r)
    if radioAlt <= 400 then
      if radioAlt > 50 then
        sasl.gl.drawText(AirbusFont, 0, -127, math.floor(radioAlt / 10 + 0.5) * 10, 25, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
      elseif radioAlt > 5 then
        sasl.gl.drawText(AirbusFont, 0, -127, math.floor(radioAlt / 5 + 0.5) * 5, 25, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
      else
        sasl.gl.drawText(AirbusFont, 0, -127, math.floor(radioAlt), 25, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
      end
    else 
      if radioAlt > 50 then
        sasl.gl.drawText(AirbusFont, 0, -127, math.floor(radioAlt / 10 + 0.5) * 10, 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
     elseif radioAlt > 5 then
        sasl.gl.drawText(AirbusFont, 0, -127, math.floor(radioAlt / 5 + 0.5) * 5, 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
      else
        sasl.gl.drawText(AirbusFont, 0, -127, math.floor(radioAlt), 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
      end
    end
    sasl.gl.restoreGraphicsContext()
  end
  sasl.gl.drawTexture(overlay, 0, 0, 500, 500, ECAM_COLOURS.WHITE)
  sasl.gl.drawTexture(plane, 106, 208, 225, 52, ECAM_COLOURS.WHITE)
end

function speed_tape()
  sasl.gl.setClipArea(0, 108, 60, 270)
  sasl.gl.saveGraphicsContext()

  if airspeed < 35 then
    sasl.gl.setTranslateTransform(0, 130)
  else 
    sasl.gl.setTranslateTransform(0, 243 - (3.2 * airspeed))
  end

  for i=4,50 do
    sasl.gl.drawWideLine(50, (0 + (i * 32)), 60, (0 + (i * 32)), 2, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 48, (((i - 2) * 64)) - 7, string.format("%03d", (20 * (i - 2))), 23, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
  end

  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function heading_tape()
  sasl.gl.setClipArea(101, 0, 235, 39)
  sasl.gl.saveGraphicsContext()

  sasl.gl.setTranslateTransform(-1510 - (4.8 * hdg), 0)
  for t=0,3 do
    for i=1,72 do
      sasl.gl.drawWideLine((t * 1728) + (24 * i), 39, (t * 1728) + (24 * i), 32, 2, ECAM_COLOURS.WHITE)
    end
    for i=1,36 do
      sasl.gl.drawWideLine((t * 1728) + (48 * i), 39, (t * 1728) + (48 * i), 26, 2, ECAM_COLOURS.WHITE)
      if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 or i == 30 or i == 33 or i == 36 then
        sasl.gl.drawText(AirbusFont, (t * 1728) + (48 * i), 9, i, 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
      else
        sasl.gl.drawText(AirbusFont, (t * 1728) + (48 * i), 11, i, 19, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
      end
      
    end
  end
  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function altitude_tape()
  sasl.gl.setClipArea(372, 108, 43, 270)
  sasl.gl.saveGraphicsContext()
  sasl.gl.setTranslateTransform(0, 243 - (0.2435 * alt))

  for i=-10,450,05 do
    sasl.gl.drawText(AirbusFont, 408, (24.35 * i) - 6, string.format("%03d", i), 20, true, false, TEXT_ALIGN_RIGHT, ECAM_COLOURS.WHITE)
  end
  for i=-10,450 do
    sasl.gl.drawWideLine(409, (24.35 * i), 415, (24.35 * i), 2, ECAM_COLOURS.WHITE)
  end

  sasl.gl.restoreGraphicsContext()
  sasl.gl.resetClipArea()
end

function update()
  if not startup_complete then
    plane_startup()
    startup_complete = true
  end
  
  isAligned = get(ADIRS_aligned)
  mode = get(ADIRS_mode)

  airspeed = get(ias)
  hdg = get(heading)
  alt = get(altitude)
  vvi = get(vertSpeed)
  p = get(pitch)
  r = get(roll)
  slip = get(sideSlip)
  radioAlt = get(radAlt)

  baro = get(baroSetting)
  baroUnits = get(units)

  if Timer < TimerFinal and selfTest == 0 then
    Timer = Timer + 1 * get(DELTA_TIME)
  else
    selfTest = 1
  end
end

function draw()
  sasl.gl.setClipArea(0, 0, 500, 500)
  if get(BUS) > 0 then
    if selfTest == 1 then
      pfd()
      Timer = 0
    else
      sasl.gl.drawText(AirbusFont, 250, 255, "SELF TEST IN PROGESS", 22, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
      sasl.gl.drawText(AirbusFont, 250, 230, "MAX 40 SECONDS", 21, true, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    end
    --sasl.gl.drawRectangle(0,0,500,500, {0.33, 0.38, 0.42, 0.35 * get(captPfdBright)})
  else
    Timer = 0
    selfTest = 0
  end
  sasl.gl.drawRectangle(0, 0, 500, 500, {0.0, 0.0, 0.0, 1 - get(captPfdBright)})
  sasl.gl.resetClipArea()
end
