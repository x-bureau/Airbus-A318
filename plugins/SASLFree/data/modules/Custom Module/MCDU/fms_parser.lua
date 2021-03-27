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