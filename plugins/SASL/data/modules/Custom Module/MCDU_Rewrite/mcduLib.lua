--******************************--
--[[     LIBRARY FILE         ]]--
--    CUSTOM FUNCTIONS IN HERE  --
--******************************--
function drawTextFieldBoxes(chars, color, x, y, side)
    y = y + 24
    if side == 1 then
        sasl.gl.drawLine(x, y, (SIZE.HEADER*chars), y, color)
        for i=0, chars do
            sasl.gl.drawLine(x+(i*SIZE.HEADER), y, x+(i*SIZE.HEADER), y-SIZE.HEADER, color)
        end
        sasl.gl.drawLine(x, (y)-SIZE.HEADER, (SIZE.HEADER*chars), (y)-SIZE.HEADER, color)
    elseif side == 2 then
        sasl.gl.drawLine(x, y, x-(SIZE.HEADER*chars), y, color)
        for i=0, chars do
            sasl.gl.drawLine(x-(i*SIZE.HEADER), y, x-(i*SIZE.HEADER), y-SIZE.HEADER, color)
        end
        sasl.gl.drawLine(x, (y)-SIZE.HEADER, x-(SIZE.HEADER*chars), (y)-SIZE.HEADER, color)
    end
end


function drawOptionHeadings(field)
    for i=1, 12 do
        if i < 7 then
            drawText(field[i], 1, 15-(2*i), MCDU_WHITE, SIZE.HEADER, false, "L")
        else
            drawText(field[i], 24, 1+(2*(13-i)), MCDU_WHITE, SIZE.HEADER, false, "R")
        end
    end
end

function drawDashSeparated(position, num1, num2, side)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 5+(num1*12)+(num1*1), position+2, "/",SIZE.HEADER, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=1, num2 do
            local x = 0+(num1*12)+(num1*1)+10+(12*i)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i = 0, (num1-1) do
            local x = 480 - (num2*12)-(num2*1)-10-(12*i)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 480-(num2*12)-(num2*1), position+2, "/",SIZE.HEADER, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function drawDashDotSeparated (position, num1, num2, side)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 3+(num1*12)+(num1*1), position+2, ".",25, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 0+(num1*12)+(num1*1)+10+(12*i)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i = 0, (num1-1) do
            local x = 480 - (num2*12)-(num2*1)-10-(12*i)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
        sasl.gl.drawText(MCDU_FONT, 483-(num2*12)-(num2*1), position+2, ".",25, false, false, TEXT_ALIGN_LEFT, mcdu_font_colors[1])
        for i=0, (num2-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function drawDashField(position, side, num1)
    if side == 1 then
        for i=0, (num1-1) do
            local x = 0+(i*12)+(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    elseif side == 2 then
        for i=0, (num1-1) do
            local x = 480-(i*12)-(2*i)
            sasl.gl.drawLine(x, position+10, x+12, position+10, mcdu_font_colors[1])
        end
    end
end

function clearScratch(scratchpad)
    local scratchpad = ""
    return scratchpad
end

function isEmpty(input)
    if input[5] == " " then
        return true
    else
         return false
    end
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function getAiracCycle()
    -- don't loop through file if value already exists
    if AIRAC_CYCLE == "" then
        local path = getXPlanePath() --gets the xplane path
        local file = io.open(path.."/Custom Data/cycle_info.txt", "r")
        local result = ""
        if file ~= nil  then
            for line in file:lines() do
                if string.match(line, "AIRAC") then
                    for token in string.gmatch(line, "[^%s]+") do
                        result = token
                    end
                    break
                end
            end
            if result ~= nil then
                AIRAC_CYCLE = result
                return AIRAC_CYCLE
            end
        end
        file = io.open(path.."/Resources/default data/earth_nav.dat", "r")
        isFound = false
        for line in file:lines() do
            if string.match(line, "cycle") then
                for token in string.gmatch(line, "[^%s]+") do
                    result = token
                    if isFound then
                        break
                    end
                    if result == "cycle" then
                        isFound = true
                    end
                end
            end
        end
        AIRAC_CYCLE = result:sub(1, 4)
        return AIRAC_CYCLE
    else
        -- if we have found the airac cycle before then don't look it up again
        return AIRAC_CYCLE
    end
end

function checkICAO(icao)
    local path = getXPlanePath() --gets the xplane path
    local file = io.open(path.."/Custom Data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        file:close()
        return true
    end
    print("not found in og directory")
    file = io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r")
    if file ~= nil then
        file:close()
        return true
    end
    return false
end

function checkForAirports()
    if DEPARTURE_AIRPORT ~= " " and DESTINATION_AIRPORT ~= " " then
        return true
    else
        return false
    end
end

function calculateDistance(lat1, lon1, lat2, lon2)

    --This function returns great circle distance between 2 points.
    --Found here: http://bluemm.blogspot.gr/2007/01/excel-formula-to-calculate-distance.html
    --lat1, lon1 = the coords from start position (or aircraft's) / lat2, lon2 coords of the target waypoint.
    --6371km is the mean radius of earth in meters. Since X-Plane uses 6378 km as radius, which does not makes a big difference,
    --(about 5 NM at 6000 NM), we are going to use the same.
    --Other formulas I've tested, seem to break when latitudes are in different hemisphere (west-east).  
    local distance = math.acos(math.cos(math.rad(90-lat1))*math.cos(math.rad(90-lat2))+math.sin(math.rad(90-lat1))*math.sin(math.rad(90-lat2))*math.cos(math.rad(lon1-lon2))) * (6378000/1852)
    return distance
end

function createTokens(str, separator)
    local tokens = {}
    for token in string.gmatch(str, "[^%"..separator.."]+") do
        table.insert(tokens, token)
    end
    return tokens
end

function getBasicLatLong(icao)
    local path = getXPlanePath()
--    if isFileExists(path.."/Resources/default data/CIFP/"..icao..".dat", "r") then
    local file = assert(io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r"))
    local str = ""
    io.input(file)
    for line in io.lines() do
        if string.match(line, "RWY") then
            str = line
            break
        end
    end
        local firstTokenSet = createTokens(str, ";")[2]
        local secondTokenSet = createTokens(firstTokenSet, ",")
        file:close()
        if string.sub(tostring(secondTokenSet[1]),1,1) == "S" then
            secondTokenSet[1] = -1 * (tonumber(string.sub(tostring(secondTokenSet[1]),2,-1)))*(10^(-6))
        else
            secondTokenSet[1] = tonumber(string.sub(tostring(secondTokenSet[1]),2,-1))*(10^(-6))
        end
        if string.sub(tostring(secondTokenSet[2]),1,1) == "W" then
            secondTokenSet[2] = -1 * (tonumber(string.sub(tostring(secondTokenSet[2]),2,-1)))*(10^(-6))
        else
            secondTokenSet[2] = (tonumber(string.sub(tostring(secondTokenSet[2]),2,-1)))*(10^(-6))
        end
        return {secondTokenSet[1], secondTokenSet[2]}
 --   else
--        print("DIABETES")
 --       return "0"
   -- end
end

function calculateAirportDistance(icao1, icao2)
    local apt1 = getBasicLatLong(icao1)
    local apt2 = getBasicLatLong(icao2)
    local nmDist = calculateDistance(apt1[1],apt1[2],apt2[1],apt2[2])
    return nmDist
end

function calcTimeToDest(dist)
    local m = dist/(453.564/60)
    local h = m%60
    m = m-h*60
    return h,m
end

function getAirportRunways(icao)
    local path = getXPlanePath()
    local file = assert(io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r"))
    local runways = {}
    io.input(file)
    for line in io.lines() do
        if string.match(line, "RWY:") then
            local str = string.sub(line, 1, string.find(line, ",")-1)
            table.insert(runways, str)
        end
    end
    file:close()
    return runways
end

function wrap( t, l )
    for i = 1, l do
        table.insert( t, #t+1, t[1])
        table.remove( t, 1)
    end
end

function getDepartureProcedures(icao, runway)
    local new_runway = ""
    if string.match(RWY_LABELS, string.sub(runway, -1, -1)) then
        new_runway = string.sub(runway, 1, -2)
    else
        new_runway = runway
    end
    local path = getXPlanePath()
    local file = assert(io.open(path.."/Resources/default data/CIFP/"..icao..".dat", "r"))
    local procedures = {}
    io.input(file)
    
    for line in io.lines() do
        local begin_rwy = string.find(line, ",", 11)
        if string.match(line, "SID:") and string.find(line, new_runway) then
            local str = string.sub(line, string.find(line, ",",8), string.find(line, ",", 25 ))
            table.insert(procedures, str)
        end
    end
    file:close()
    return procedures
end

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
end

-- function checkIsInProcedure(firstLine, checkLine)
--     print(tonumber(string.sub(checkLine, 5, 6)))
--     print(tonumber(string.sub(firstLine, 5, 6)))
--     return (tonumber(string.sub(checkLine, 5, 6)) > tonumber(string.sub(firstLine, 5, 6)))
-- end

function getFullDepartureProcedure()
    local icao = DEPARTURE_AIRPORT
    local rwy = SELECTED_RUNWAY
    local sid = SELECTED_DPT_SID
    local path = getXPlanePath()
    local file = assert(io.open(path.."/Resources/default data/CIFP/"..icao..".dat","r"))
    local wpts = {}
    if string.match(RWY_LABELS, string.sub(rwy, -1, -1)) then
        rwy = string.sub(rwy, 1, -2)
    else
        rwy = rwy
    end
    io.input(file)
    for line in io.lines() do
        if string.match(line, sid) and string.match(line, "RW"..rwy) then
            table.insert(wpts,line)
        end
    end
    file:close()
    return wpts
end

function isGreaterThan(val1, val2)
    return(val1 > val2)
end

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function validateAirway(awy)
    local path = getXPlanePath()
    local file = assert(io.open(path.."/Resources/default data/earth_awy.dat"),"r")
    io.input(file)
    for line in io.lines() do
        if string.match(line, awy) then
            file:close()
            return true
        end
    end
    file:close()
    return false
end

function strToTable(str)
    local t = {}
    for i = 1, #str do
        t[i] = str:sub(i, i)
    end
    return t
end

function drawText(TEXT, X, Y, COLOR, size, BOLD, FROMSIDE, inFpln, field)
    local len = string.len(TEXT)
    local text = strToTable(TEXT)
    local HDG_FACTOR = 0
    local TITLE_FACTOR = 0
    if size == SIZE.HEADER then
        HDG_FACTOR = 8
    elseif size == SIZE.TITLE then
        TITLE_FACTOR = 10
    end
    local YCord = TEXT_Y[Y]
    if inFpln then
        if field == "O" then
            YCord = OPTION[Y]
        elseif field == "H" then
            YCord = HEADER[Y]
        end
    end
    if FROMSIDE == "L" then
        for i=1, len do
            if text[i] ~= " " then
                sasl.gl.drawText(MCDU_FONT, TEXT_X[(X-1)+i], YCord-HDG_FACTOR-TITLE_FACTOR, text[i], size, BOLD, false, TEXT_ALIGN_CENTER, COLOR)
            end
        end
    elseif FROMSIDE == "R" then
        for i=len,1,-1 do
            local char = len-i+1
            if text[char] ~= " " then
                sasl.gl.drawText(MCDU_FONT, TEXT_X[(X+1)-i], YCord-HDG_FACTOR-TITLE_FACTOR, text[char], size, BOLD, false, TEXT_ALIGN_CENTER, COLOR)
            end
        end
    end
end