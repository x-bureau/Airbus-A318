createGlobalPropertyi("A318/comms/transponder/atc_sys", 1, false, true, true)
atc_sys = globalPropertyi("A318/comms/transponder/atc_sys")
local color = {0.240*4,	0.215*4,	0.131*4, 2}
local robofont = loadFont(moduleDirectory.."/Custom Module/fonts/digital.ttf")
local transpondercode = globalPropertyf("sim/cockpit2/radios/actuators/transponder_code")

local transpondernumbfr = "2345"
local transpondernumbfirst = "2"
local transpondernumblast = "45"
local cursorplace = 1
function noice(G)
   if get(cursorplace) == 1 then
      transpondernumbfr = string.sub(transpondernumbfr, 2)
      transpondernumbfr = G..transpondernumbfr
      cursorplace = 2
   elseif get(cursorplace) == 2 then 
      transpondernumbfirst = transpondernumbfr:sub(1, 1)
      transpondernumblast = string.sub(transpondernumbfr, 3)
      transpondernumbfr = transpondernumbfirst..G..transpondernumblast
      cursorplace = 3
   elseif get(cursorplace) == 3 then
      transpondernumbfirst = transpondernumbfr:sub(1, 2)
      transpondernumblast = string.sub(transpondernumbfr, 4)
      transpondernumbfr = transpondernumbfirst..G..transpondernumblast
      cursorplace = 4
   elseif get(cursorplace) == 4 then
      transpondernumbfirst = transpondernumbfr:sub(1, 3)
      transpondernumbfr = transpondernumbfirst..G
      cursorplace = 1
   end
end

--command handlers
function key1CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("1")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key2CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("2")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key3CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("3")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key4CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("4")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key5CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("5")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key6CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("6")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key7CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("7")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function key0CommandHandler (phase)
   if phase == SASL_COMMAND_BEGIN then
      noice("0")

   elseif phase == SASL_COMMAND_END then
      
   end
   return 1

end
function keyclrCommandHandler (phase)
    if phase == SASL_COMMAND_BEGIN then
       transpondernumbfr = "0000"
 
    elseif phase == SASL_COMMAND_END then
       
    end
    return 1
 
 end
key1command = sasl.createCommand("A318/comms/transponder/key1", "cool stuff:tm:")
sasl.registerCommandHandler(key1command, 0, key1CommandHandler) 

key2command = sasl.createCommand("A318/comms/transponder/key2", "cool stuff:tm:")
sasl.registerCommandHandler(key2command, 0, key2CommandHandler) 

key3command = sasl.createCommand("A318/comms/transponder/key3", "cool stuff:tm:")
sasl.registerCommandHandler(key3command, 0, key3CommandHandler) 

key4command = sasl.createCommand("A318/comms/transponder/key4", "cool stuff:tm:")
sasl.registerCommandHandler(key4command, 0, key4CommandHandler) 

key5command = sasl.createCommand("A318/comms/transponder/key5", "cool stuff:tm:")
sasl.registerCommandHandler(key5command, 0, key5CommandHandler) 

key6command = sasl.createCommand("A318/comms/transponder/key6", "cool stuff:tm:")
sasl.registerCommandHandler(key6command, 0, key6CommandHandler) 

key7command = sasl.createCommand("A318/comms/transponder/key7", "cool stuff:tm:")
sasl.registerCommandHandler(key7command, 0, key7CommandHandler) 

key0command = sasl.createCommand("A318/comms/transponder/key0", "cool stuff:tm:")
sasl.registerCommandHandler(key0command, 0, key0CommandHandler) 

keyclrcommand = sasl.createCommand("A318/comms/transponder/keyclr", "cool stuff:tm:")
sasl.registerCommandHandler(keyclrcommand, 0, keyclrCommandHandler) 
function update()
   print(transpondernumbfr)
   set(transpondercode, get(transpondernumbfr))
end

function draw()
   drawText(robofont, 2000, 3000, get(transpondernumbfr), 130, false, false, TEXT_ALIGN_RIGHT, color) 
   drawText(robofont, 2000, 3100, "ATC "..get(atc_sys), 50, false, false, TEXT_ALIGN_RIGHT, color) 
end
