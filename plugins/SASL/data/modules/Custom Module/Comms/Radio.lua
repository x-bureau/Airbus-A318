------------------------------------------------------------------------
--Airbus A318 By X-Bureau--
--CONTRIBUITORS:
--Cactus2456 Steadyfly
position = {0, 0, 4096, 4096}
size = {4096, 4096}
addSearchPath(moduleDirectory.."/Custom Module/Comms")
createGlobalPropertyf("a318/comms/radios/com1stdbyfreq", 134.567)
--------------------------------------------------------------------------------
local color = {0.240*4,	0.215*4,	0.131*4, 2}
local black = {0, 0, 0, 1}
local path = getXPlanePath()
local robofont = loadFont(moduleDirectory.."/Custom Module/fonts/digital.ttf")
local activecom1 = globalPropertyf("sim/cockpit2/radios/actuators/com1_frequency_hz_833") 
local stdbyfreq = globalPropertyf("a318/comms/radios/com1stdbyfreq")
-- Com1 fist 3 vars
local activecom1f3func = 0
local activecom1f3funcsub = 0

-- Com1 last 3 vars
local activecom1str = 0
local activecom1strsub = 0


function update()
   function aftr3(com, com2, com3)
        com2 = tostring(get(com))
        com3 = get(com2):sub(4)
        return com3
   end


   function prev3(com1, com2, com3, com4)
        com3 = tostring(get(com1) - get(com2))
        com4 = (get(com3):sub(0, -4)):sub(1)
        return com4
   end
   --Activecom1 stuff
   activecom1l3 = aftr3(get(activecom1), get(activecom1str), get(activecom1strsub))
   activecom1f3 = prev3(get(activecom1), get(activecom1l3), get(activecom1f3func), get(activecom1f3funcsub))
   --Stdby freq stuff...
   stdbyfreqsub = tostring(get(stdbyfreq)):sub(0, -9)
   print(get(stdbyfreqsub))
end

function draw()
   drawRectangle(3690, 3080, 320, 95, black) 
   drawRectangle(3690, 3170, 320, 95, black) 
   sasl.gl.drawText(robofont, 3985, 3090, get(activecom1f3).."."..get(activecom1l3), 90, false, false, TEXT_ALIGN_RIGHT, color) 
   sasl.gl.drawText(robofont, 3985, 3185, get(stdbyfreqsub), 90, false, false, TEXT_ALIGN_RIGHT, color) 
end