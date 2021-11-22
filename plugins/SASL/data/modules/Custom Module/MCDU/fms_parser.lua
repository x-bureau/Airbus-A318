-- require 'MCDU.structs.Tree'
-- require 'MCDU.structs.wpt'
local aptTester = {}

function processCustomAptData()
	-- just testing and probably not going in final product
	local path = getXPlanePath()
	local aptData = io.open(path.."/Custom Data/GNS430/navdata/Airports.txt", "r")
	if aptData == nil then
		print("couldn't find file")
	else
		counter = 0
		for line in aptData:lines() do
			if string.sub(line, 1, 1) == "A" then
				local tokens = createTokens(line, ",")
				print(tokens[2])
			end
		end
	end
end

-- function processCustomWaypointData()
-- 	local wptData = io.open(getXPlanePath().."/Custom Data/GNS430/navdata/Waypoints.txt", "r")
-- 	local tree = Tree:new()
-- 	local counter = 0
-- 	for line in wptData:lines() do
-- 		local tokens = createTokens(line, ",")
-- 		local wpt = wpt:new(tokens[1], tonumber(tokens[2]), tonumber(tokens[3]), tree:hash(tokens[1]))
-- 		tree:insert(wpt)
-- 	end
-- 	return tree
-- end


function getOriginDestination(line)
	-- get tokens
	local result = ""
	local counter = 1
	for token in string.gmatch(line, "[^%s]+") do
		if counter > 2 then
			break
		end
		result = token
		counter = counter + 1
	end
	if line:sub(1, 4) == "ADEP" then
		set(mcdu_origin, result)
	else
		set(mcdu_destination, result)
	end
end

function parseFMS(filename, check)
	local path = getXPlanePath()
	print("looking for "..filename..".fms")
	local flightPlan = io.open(path.."/Output/FMS plans/"..filename..".fms", "r")
	if flightPlan == nil then
		return false
	end
	if check == 0 then
		return
	end
	for line in flightPlan:lines() do
		if string.match(line, "ADEP") or string.match(line, "ADES") then
			--print("found")
			getOriginDestination(line)
		end
	end
end