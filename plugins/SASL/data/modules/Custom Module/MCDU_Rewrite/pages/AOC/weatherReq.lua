local WIND_SPEED = globalPropertyf("sim/weather/view/wind_base_speed_kts")
local WIND_DIRECTION = globalPropertyf("sim/weather/wind_direction_degt")
local GUST_SPEED = globalPropertyf("sim/weather/view/wind_gust_kts")
local VISIBILITY = globalPropertyf("sim/weather/region/visibility_reported_sm")


local optionLabels = {
    [1] = " WX TYPE",
    [2] = "",
    [3] = "",
    [4] = "",
    [5] = "",
    [6] = "AOC MENU",
    [7] = "AIRPORTS ",
    [8] = "",
    [9] = "",
    [10] = "",
    [11] = "",
    [12] = ""
}

local fields = {
    [1] = "[ ]",
    [2] = "[ ]",
    [3] = "[ ]",
    [4] = "[ ]"
 }

local function drawFields()
    for i in ipairs(fields) do
        drawText(fields[i],24,14-(2*i),MCDU_GREEN,SIZE.OPTION,false,"R")
    end
end

local function processWXReqInput()
    if get(MCDU_CURRENT_BUTTON) == 6 then
        if checkICAO(scratchpad) then
            fields[1] = scratchpad
            scratchpad = ""
        else
            scratchpad = "ERROR: INVALID ICAO"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 7 then
        if checkICAO(scratchpad) then
            fields[2] = scratchpad
            scratchpad = ""
        else
            scratchpad = "ERROR: INVALID ICAO"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 8 then
        if checkICAO(scratchpad) then
            fields[3] = scratchpad
            scratchpad = ""
        else
            scratchpad = "ERROR: INVALID ICAO"
        end
    elseif get(MCDU_CURRENT_BUTTON) == 9 then
        if checkICAO(scratchpad) then
            fields[4] = scratchpad
            scratchpad = ""
        else
            scratchpad = "ERROR: INVALID ICAO"
        end
    end

    if get(MCDU_CURRENT_BUTTON) == 5 then
        set(MCDU_CURRENT_PAGE, 7)
    end

    if get(MCDU_CURRENT_BUTTON) == 11 and fields[1] ~= "" then
        local METAR = {}
        for i=1,4,1 do
            if fields[i]~="[ ]" then
                local metar = {}
                metar = getMETAR(fields[i])
                for j in ipairs(metar) do
                    table.insert(METAR,#METAR+1,metar[j])
                end
                table.insert(METAR,#METAR+1,"--------------------")
            end
        end
        for i in ipairs(METAR) do
            print(METAR[i])
        end
        table.insert(TEXT_STORAGE, #TEXT_STORAGE+1, {"METAR REQUEST AT "..formatTime(get(hours),get(minutes)),METAR})
    end
end

function getMETAR(icao)
    local link = "https://tgftp.nws.noaa.gov/data/observations/metar/stations/"..icao..".TXT"
    local result, contents = sasl.net.downloadFileContentsSync(link)
    if result == false then
        print("ERROR RETRIEVING METAR DATA")
    end

    local words = {}

    for word in contents:gmatch("%S+") do table.insert(words, word) end
    local metar = {""}
    table.remove(words,1)
    words[1] = "METAR"
    for _, word in ipairs(words) do
        local line = metar[#metar]
        if #line + #word+1<= 24 and _ ~= 1 then
            metar[#metar] = line .. " " .. word
        else
            table.insert(metar, word) -- begin new line
        end
    end
    for i in ipairs(metar) do
        if metar[i] == "" then
            table.remove(metar, i)
        end
    end
    return metar
end

function drawWeatherRequest()
    processWXReqInput()
    drawOptionHeadings(optionLabels) -- Draw Static optionLabels
    drawText("AOC WEATHER REQUEST", 3, 14, MCDU_WHITE, SIZE.TITLE,false,"L")

    --TODO: ADD OTHER  WX TYPE
    drawText("vMETAR",1,12,MCDU_BLUE,SIZE.OPTION,false,"L")--Static METAR drawing

    drawText("<RETURN",1,2,MCDU_WHITE,SIZE.OPTION,false,"L")
    drawText("SEND",23,2,MCDU_BLUE,SIZE.OPTION,false,"R")

    drawFields()

end