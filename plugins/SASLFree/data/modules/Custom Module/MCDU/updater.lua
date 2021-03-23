UPDATE_METADATA = {
    author = "",
    version = "",
    fixes = {}
}

VERSION_METADATA = {
    author = "",
    version = "",
    fixes = ""
}

function isUpdateAvailable()
    if get(update_available) == 1 then
        return true
    end
    return false
end

local updateDataURL = "https://raw.githubusercontent.com/x-bureau/Airbus-A318/master/plugins/SASLFree/data/modules/updateData.txt"
local files = {}

function checkCurrentVersion()
    local newData = io.open(getMyPluginPath():sub(1, -3).."data/modules/updateData.txt")
        local version = ""
        for line in newData:lines() do
            if string.match(line, "Version") then
                local tokens = createTokens(line, ":")
                local v = tokens[2]
                version = v:sub(2)
            end
            if not string.match(line, ".lua") then
                if string.match(line, "Author") then
                    local at = createTokens(line, ":")
                    local author = at[2]
                    VERSION_METADATA.author = author:sub(2)
                end
                if string.match(line, "Version") then
                    local vt = createTokens(line, ":")
                    local version = vt[2]
                    VERSION_METADATA.version = version:sub(2)
                end
                if string.match(line, "Fixes") then
                    local fx = createTokens(line, ":")
                    local fixes = fx[2]
                    VERSION_METADATA.fixes = createTokens(fixes, ",")
                    print(VERSION_METADATA.fixes[1])
                end
            end
        end
end

function setUpdateStatus(inUrl , inFilePath , inIsOk , inError )
    if inIsOk then
        local newData = io.open(getMyPluginPath():sub(1, -3).."data/modules/temp.txt")
        local version = ""
        local cycle = 0
        for line in newData:lines() do
            if string.match(line, "Version") then
                local tokens = createTokens(line, ":")
                local v = tokens[2]
                version = v:sub(2)
            end
            if not string.match(line, ".lua") then
                if string.match(line, "Author") then
                    local at = createTokens(line, ":")
                    local author = at[2]
                    UPDATE_METADATA.author = author:sub(2)
                end
                if string.match(line, "Version") then
                    local vt = createTokens(line, ":")
                    local version = vt[2]
                    UPDATE_METADATA.version = version:sub(2)
                end
                if string.match(line, "Fixes") then
                    local fx = createTokens(line, ":")
                    local fixes = fx[2]
                    UPDATE_METADATA.fixes = createTokens(fixes, ",")
                    print(UPDATE_METADATA.fixes[1])
                end
            end
        end
        if version ~= get(CURRENT_VERSION) then
            set(update_available, 1)
            print("UPDATE AVAILABLE")
        end
    end
end

function checkForUpdate()
    local currentData = io.open(getMyPluginPath():sub(1, -3).."data/modules/updateData.txt")
    local version = ""
    for line in currentData:lines() do
        if string.match(line, "Version") then
            local tokens = createTokens(line, ":")
            local v = tokens[2]
            version = v:sub(2)
            break
        end
    end
    set(CURRENT_VERSION, version)
    sasl.net.downloadFileAsync(updateDataURL,getMyPluginPath():sub(1, -3).."data/modules/temp.txt", setUpdateStatus)
end

function updateLuaFiles()
    downloadResult , error = sasl.net.downloadFileSync (updateDataURL, getMyPluginPath():sub(1, -3).."data/modules/updateData.txt")
    local file = io.open(getMyPluginPath():sub(1, -3).."data/modules/updateData.txt")
    local counter = 1
    local metadata = {}
    for line in file:lines() do
        if not string.match(line, ".lua") then
            if not string.match(line, "--") then
                table.insert(metadata, line)
            end
        else
            local path = getMyPluginPath():sub(1, -3).."data/modules/Custom Module/"
            local tokens = createTokens(line, ",")
            local filename = tokens[1]
            if filename == "mcdu.lua" then
                print(line)
            end
            local url = tokens[2]
            url = url:sub(2)
            if counter == 1 then
                path = getMyPluginPath():sub(1, -3).."data/modules/"
                --print(path..filename)
                downloadResult , error = sasl.net.downloadFileSync (url , path..filename)
            else
                if table.getn(tokens) == 3 then
                    local pathEnd = tokens[3]
                    pathEnd = pathEnd:sub(2)
                    --print(path..pathEnd..filename)
                    downloadResult , error = sasl.net.downloadFileSync (url , path..pathEnd..filename)
                else
                    --print(url , path..filename)
                    downloadResult , error = sasl.net.downloadFileSync (url , path..filename)
                end
            end
            counter = counter + 1
        end
    end
    return metadata
end