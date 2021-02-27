------------------------------------------------------------------
--Airbus A318 by X-Bureau--
--MCDU

--Written By:
--FBI914
--Future 
--Jamlen
------------------------------------------------------------------
position = {20, 1200, 515, 370}
size = {510, 410}
------------------------------------------------------------------
--Defining Variables
------------------------------------------------------------------
local MCDU_GREEN = {0.184, 0.733, 0.219, 1.0}
local MCDU_WHITE = {1.0, 1.0, 1.0, 1.0}
local MCDU_BLUE = {0.004, 1.0, 1.0, 1.0}

local AIRBUS_FONT = sasl.gl.loadFont("fonts/PanelFont.ttf")
local MCDU_CURRENT_PAGE = createGlobalPropertyi("A318/cockpit/mcdu/current_page", 11)
local Airbus_VERSION = "A318-100"
local ENG_TYPE = "CFM-56-B"

--Buttons Datarefs 

local BUTTON_1_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/1", 0)
local BUTTON_2_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/2", 0)
local BUTTON_3_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/3", 0)
local BUTTON_4_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/4", 0)
local BUTTON_5_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/5", 0)
local BUTTON_6_L = createGlobalPropertyi("A318/cockpit/mcdu/buttons/left/6", 0)

local BUTTON_1_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/1", 0)
local BUTTON_2_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/2", 0)
local BUTTON_3_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/3", 0)
local BUTTON_4_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/4", 0)
local BUTTON_5_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/5", 0)
local BUTTON_6_R = createGlobalPropertyi("A318/cockpit/mcdu/buttons/right/6", 0)
-- Info Arrays 
letters = {
  "A", -- 1
  "B", -- 2
  "C", -- 3
  "D", -- 4
  "E", -- 5
  "F", -- 6
  "G", -- 7
  "H", -- 8
  "I", -- 9
  "J", -- 11
  "K", -- 11
  "L", -- 12 
  "M", -- 13
  "N", -- 14
  "O", -- 15
  "P", -- 16
  "Q", -- 17
  "R", -- 18
  "S", -- 19
  "T", -- 20
  "U", -- 21
  "V", -- 22
  "W", -- 23
  "X", -- 24
  "Y", -- 25
  "Z", -- 26
  1, -- 27
  2, -- 28
  3, -- 29
  4, -- 30
  5, -- 31
  6, -- 32
  7, -- 33
  8, -- 34
  9, -- 35
  0, -- 36
  "/",
  "."
 -- "[]", -- 37
}

local CLR_KEY = createGlobalPropertyi("A318/cockpit/mcdu/keys/clr", 0) --1
keys = {
  [1] = createGlobalPropertyi("A318/cockpit/mcdu/keys/a", 0), --1
  [2] = createGlobalPropertyi("A318/cockpit/mcdu/keys/b", 0), --2
  [3] = createGlobalPropertyi("A318/cockpit/mcdu/keys/c", 0), --3 
  [4] = createGlobalPropertyi("A318/cockpit/mcdu/keys/d", 0), --4
  [5] = createGlobalPropertyi("A318/cockpit/mcdu/keys/e", 0), --5
  [6] = createGlobalPropertyi("A318/cockpit/mcdu/keys/f", 0), --6
  [7] = createGlobalPropertyi("A318/cockpit/mcdu/keys/g", 0), --7
  [8] = createGlobalPropertyi("A318/cockpit/mcdu/keys/h", 0), --8
  [9] = createGlobalPropertyi("A318/cockpit/mcdu/keys/i", 0), --9
  [10] = createGlobalPropertyi("A318/cockpit/mcdu/keys/j", 0), --10
  [11] = createGlobalPropertyi("A318/cockpit/mcdu/keys/k", 0), --11
  [12] = createGlobalPropertyi("A318/cockpit/mcdu/keys/l", 0), --12
  [13] = createGlobalPropertyi("A318/cockpit/mcdu/keys/m", 0), --13
  [14] = createGlobalPropertyi("A318/cockpit/mcdu/keys/n", 0), --14
  [15] = createGlobalPropertyi("A318/cockpit/mcdu/keys/o", 0), --15
  [16] = createGlobalPropertyi("A318/cockpit/mcdu/keys/p", 0), --16
  [17] = createGlobalPropertyi("A318/cockpit/mcdu/keys/q", 0), --17 
  [18] = createGlobalPropertyi("A318/cockpit/mcdu/keys/r", 0), --18
  [19] = createGlobalPropertyi("A318/cockpit/mcdu/keys/s", 0), --19
  [20] = createGlobalPropertyi("A318/cockpit/mcdu/keys/t", 0), --20 
  [21] = createGlobalPropertyi("A318/cockpit/mcdu/keys/u", 0), --21
  [22] = createGlobalPropertyi("A318/cockpit/mcdu/keys/v", 0), --22
  [23] = createGlobalPropertyi("A318/cockpit/mcdu/keys/w", 0), --23
  [24] = createGlobalPropertyi("A318/cockpit/mcdu/keys/x", 0), --24
  [25] = createGlobalPropertyi("A318/cockpit/mcdu/keys/y", 0), --25
  [26] = createGlobalPropertyi("A318/cockpit/mcdu/keys/z", 0), --26
  [27] = createGlobalPropertyi("A318/cockpit/mcdu/keys/1", 0), --27
  [28] = createGlobalPropertyi("A318/cockpit/mcdu/keys/2", 0), --28
  [29] = createGlobalPropertyi("A318/cockpit/mcdu/keys/3", 0), --29
  [30] = createGlobalPropertyi("A318/cockpit/mcdu/keys/4", 0), --30
  [31] = createGlobalPropertyi("A318/cockpit/mcdu/keys/5", 0), --31
  [32] = createGlobalPropertyi("A318/cockpit/mcdu/keys/6", 0), --32
  [33] = createGlobalPropertyi("A318/cockpit/mcdu/keys/7", 0), --33
  [34] = createGlobalPropertyi("A318/cockpit/mcdu/keys/8", 0), --34
  [35] = createGlobalPropertyi("A318/cockpit/mcdu/keys/9", 0), --35
  [36] = createGlobalPropertyi("A318/cockpit/mcdu/keys/0", 0), --36
  [37] = createGlobalPropertyi("A318/cockpit/mcdu/keys/slash", 0), --37
  [38] = createGlobalPropertyi("A318/cockpit/mcdu/keys/period", 0), --38
}



data_L = {
  [1] = {
    value = "0",
    isWriteable = "true",
    maxChar = 9,
  };
  [2] = {
    value = "0",
    isWriteable = "false",
    maxChar = 9,
  };
  [3] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [4] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [5] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [6] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  }
}

data_R = {
  [1] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [2] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [3] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [4] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [5] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  };
  [6] = {
    value = "0",
    isWriteable = "false",
    maxChar = 8,
  }
}


local scratchPad_Data = {
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
}


key_datarefs = {

  
}

local FromTo_Data = {
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
  "[]",
}


--Creating the blank character space
local blankChar = "[]"
--print(blankChar)



local function draw_scratchPad()
  local x = "[]" 
  for i,v in ipairs(keys) do 
    if get(v) ~= 0 then 
      x = letters[i]-- X is set to match the letter corresponding to the index value from keys here we set x to letter 
      print(x) --We want X to be the letter we want to draw

      if scratchPad_Data[1] == "[]" then
        scratchPad_Data[1] = x
        set(v, 0)
        elseif scratchPad_Data[2] == "[]" then
         scratchPad_Data[2] = x
         set(v, 0)
        elseif scratchPad_Data[3] == "[]" then
          scratchPad_Data[3] = x
          set(v, 0)
        elseif scratchPad_Data[4] == "[]" then
          scratchPad_Data[4] = x
          set(v, 0)
        elseif scratchPad_Data[5] == "[]" then
          scratchPad_Data[5] = x
          set(v, 0)
        elseif scratchPad_Data[6] == "[]" then
          scratchPad_Data[6] = x
          set(v, 0)
        elseif scratchPad_Data[7] == "[]" then
          scratchPad_Data[7] = x
          set(v, 0)
        elseif scratchPad_Data[8] == "[]" then
          scratchPad_Data[8] = x
          set(v, 0)
        elseif scratchPad_Data[9] == "[]" then
          scratchPad_Data[9] = x
          set(v, 0)
        elseif scratchPad_Data[10] == "[]" then
          scratchPad_Data[10] = x
          set(v, 0)
      end
    end
  end 

  sasl.gl.drawText(AIRBUS_FONT, 20, 35, scratchPad_Data[1], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 60, 35, scratchPad_Data[2], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 100, 35, scratchPad_Data[3], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 140, 35, scratchPad_Data[4], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 180, 35, scratchPad_Data[5], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 220, 35, scratchPad_Data[6], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 260, 35, scratchPad_Data[7], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 300, 35, scratchPad_Data[8], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 340, 35, scratchPad_Data[9], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  sasl.gl.drawText(AIRBUS_FONT, 380, 35, scratchPad_Data[10], 40, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
end 


local function drawPage()
  if get(MCDU_CURRENT_PAGE) == 11 then -- Draw Menu Page
    sasl.gl.drawText(AIRBUS_FONT, 170, 400, "MCDU MENU" , 30, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 15, 350, "<FMGC" , 25, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 15, 300, "<ATSU", 25, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 15, 250, "<AIDS", 25, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 15, 200, "<CFDS", 25, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 365, 380, "SELECT", 22, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 345, 350, "NAV B/UP>", 25, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
    sasl.gl.drawText(AIRBUS_FONT, 345, 100, "RETURN>", 25, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
   
    if get(BUTTON_1_L) == 1 then 
      MCDU_CURRENT_PAGE = 1 
    end
    elseif get(MCDU_CURRENT_PAGE) == 1 then -- Draw main Page
      sasl.gl.drawText(AIRBUS_FONT, 190, 400, Airbus_VERSION , 30, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      sasl.gl.drawText(AIRBUS_FONT, 30, 380, "ENG" , 24, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      sasl.gl.drawText(AIRBUS_FONT, 15, 350, ENG_TYPE , 29, false, false, TEXT_ALIGN_LEFT, MCDU_GREEN)
  
    elseif get(MCDU_CURRENT_PAGE) == 2 then 
      -- TITLE --  
      sasl.gl.drawText(AIRBUS_FONT, 215, 400, "INIT" , 30, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      --   LEFT SIDE
      sasl.gl.drawText(AIRBUS_FONT, 40, 380, "CO RTE" , 24, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      

      sasl.gl.drawText(AIRBUS_FONT, 15, 350, "[              ]" , 29, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
  
      sasl.gl.drawText(AIRBUS_FONT, 15, 320, "ALTN/CO RTE" , 24, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      sasl.gl.drawText(AIRBUS_FONT, 15, 290, "----/---------" , 29, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)

      sasl.gl.drawText(AIRBUS_FONT, 15, 265, "FLT NBR" , 24, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      sasl.gl.drawText(AIRBUS_FONT, 15, 235, "[][][][][][][][][]" , 29, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)

      sasl.gl.drawText(AIRBUS_FONT, 15, 195, "LAT" , 24, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
      sasl.gl.drawText(AIRBUS_FONT, 15, 170, "inop" , 29, false, false, TEXT_ALIGN_LEFT, MCDU_BLUE)
    
      -- RIGHT SIDE 
      sasl.gl.drawText(AIRBUS_FONT, 325, 380, "FROM/TO", 24, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)

    
      local x = 325 --We add the base X - Value so we space out the input fields.
      for i in ipairs(FromTo_Data) do   
        sasl.gl.drawText(AIRBUS_FONT, x, 350, FromTo_Data[i], 29, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE)
        x = x + 15
        if i == 4 then 
          x = x + 25
        end
      end
      sasl.gl.drawText(AIRBUS_FONT, 390, 350, "/", 29, false, false, TEXT_ALIGN_LEFT, MCDU_WHITE) --Draw the slash separately from the dataset
    elseif get(MCDU_CURRENT_PAGE) == 3 then 
    
    elseif get(MCDU_CURRENT_PAGE) == 4 then
  
    end

    
    --Delete(Clear) Button
    for i,v in ipairs(letters) do 
      if get(v) ~= 0 then 
        if get(CLR_KEY) == 1 and scratchPad_Data[10] ~= "[]" then 
          scratchPad_Data[10] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[9] ~= "[]" then 
          scratchPad_Data[9] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[8] ~= "[]" then
          scratchPad_Data[8] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[7] ~= "[]" then 
          scratchPad_Data[7] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[6] ~= "[]" then 
          scratchPad_Data[6] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[5] ~= "[]" then 
          scratchPad_Data[5] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[4] ~= "[]" then 
          scratchPad_Data[4] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[3] ~= "[]" then 
          scratchPad_Data[3] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[2] ~= "[]" then 
          scratchPad_Data[2] = "[]"
          set(CLR_KEY, 0)
        elseif get(CLR_KEY) == 1 and scratchPad_Data[1] ~= "[]" then 
          scratchPad_Data[1] = "[]"
          set(CLR_KEY, 0)
        end     
      end
    end  
  end
  
--You realize that's gonna last for like a nanosecond? If you're at like 10fps that's gonna be like 1/2 a second
function THROW_INVALID()
  scratchPad_Data[1] = "I"
  scratchPad_Data[2] = "N"
  scratchPad_Data[3] = "V"
  scratchPad_Data[4] = "A"
  scratchPad_Data[5] = "L"
  scratchPad_Data[6] = "I"
  scratchPad_Data[7] = "D"  
  scratchPad_Data[8] = ""
  scratchPad_Data[9] = ""
  scratchPad_Data[10] = ""
  CLEAR_ALL()
end 

function CLEAR_ALL()
if get(CLR_KEY) == 1 and scratchPad_Data[1] == "I" and scratchPad_Data[2] == "N" and scratchPad_Data[3] == "V" and scratchPad_Data[4] == "A" and scratchPad_Data[5] == "L" and scratchPad_Data[6] == "I" and scratchPad_Data[7] == "D"and scratchPad_Data[8] == "" and scratchPad_Data[9] == "" and scratchPad_Data[10] == "" then
    scratchPad_Data[1] = "[]"
    scratchPad_Data[2] = "[]"
    scratchPad_Data[3] = "[]"
    scratchPad_Data[4] = "[]"
    scratchPad_Data[5] = "[]"
    scratchPad_Data[6] = "[]"
    scratchPad_Data[7] = "[]"  
    scratchPad_Data[8] = "[]"
    scratchPad_Data[9] = "[]"
    scratchPad_Data[10] = "[]"
  end
end 
function update()
  CLEAR_ALL()
  -- Add text to FROM/TO
  if get(MCDU_CURRENT_PAGE) == 2 and get(BUTTON_1_R) == 1 then 
    if scratchPad_Data[5] ~= "/" or  scratchPad_Data[1] == "[]" or scratchPad_Data[2] == "[]" or scratchPad_Data[3] == "[]" or scratchPad_Data[4] == "[]" or scratchPad_Data[5] == "[]" or scratchPad_Data[6] == "[]" or scratchPad_Data[7] == "[]" or scratchPad_Data[8] == "[]" or scratchPad_Data[9] == "[]" then 
        THROW_INVALID()
    else --What are you trying to do here? also, we need to throw an error if it's greater than macChar or we can just leave it as is where it takes the first 8 letters
      FromTo_Data[1] =  scratchPad_Data[1]
      FromTo_Data[2] =  scratchPad_Data[2]
      FromTo_Data[3] =  scratchPad_Data[3]
      FromTo_Data[4] =  scratchPad_Data[4]
      FromTo_Data[5] =  scratchPad_Data[6]
      FromTo_Data[6] =  scratchPad_Data[7]
      FromTo_Data[7] =  scratchPad_Data[8]
      FromTo_Data[8] =  scratchPad_Data[9]
    end
  end 
end

function draw()
  update()
	drawPage()   
  draw_scratchPad()
end.
