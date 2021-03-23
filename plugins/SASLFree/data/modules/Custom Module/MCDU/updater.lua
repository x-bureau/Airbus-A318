function isUpdateAvailable()
    -- if getCurrentVersionFromGithub() > get(CURRENT_VERSION) then
    --     return true
    -- end
    -- return false
    return true
end

local updateDataURL = "https://raw.githubusercontent.com/x-bureau/Airbus-A318/master/plugins/SASLFree/data/modules/updateData.txt"
local files = {}

function getCurrentVersionFromGithub()

end

function updateLuaFiles()
    downloadResult , error = sasl.net.downloadFileSync (updateDataURL, getMyPluginPath():sub(1, -3).."data/modules/updateData.txt")
    local file = io.open(getMyPluginPath():sub(1, -3).."data/modules/updateData.txt")
    local counter = 1
    for line in file:lines() do
        local path = getMyPluginPath():sub(1, -3).."data/modules/Custom Module/"
        local tokens = createTokens(line, ",")
        local filename = tokens[1]
        local url = tokens[2]
        url = url:sub(2)
        if counter == 1 then
            path = getMyPluginPath():sub(1, -3).."data/modules/"
            print(path)
            --downloadResult , error = sasl.net.downloadFileSync (url , path..filename)
        else
            if table.getn(tokens) == 3 then
                local pathEnd = tokens[3]
                pathEnd = pathEnd:sub(2)
                
            end
        end
        counter = counter + 1
    end
end