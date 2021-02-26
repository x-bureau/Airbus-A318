position = {30, 50, 495, 500}
size = {500, 500}

font = sasl.gl.loadFont("B612-Regular.ttf")
white = {1.0, 1.0, 1.0, 1.0}
orange = {1.0, 0.5, 0, 1.0}
red = {1.0, 0, 0, 1.0}

symbols = sasl.gl.loadImage("symbols.png", 0, 0, 1090, 500)
toggle = globalProperty("sim/cockpit/switches/EFIS_shows_tcas")

-- Define
targetZ = globalProperty("sim/cockpit2/tcas/targets/position/z", 64)
targetX = globalProperty("sim/cockpit2/tcas/targets/position/x", 64)

localZ = globalProperty("sim/flightmodel/position/local_z")
localX = globalProperty("sim/flightmodel/position/local_x")
localHdg = globalProperty("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot")

vX = globalProperty("sim/cockpit2/tcas/targets/position/vx", 64)
vZ = globalProperty("sim/cockpit2/tcas/targets/position/vz", 64)
heading = globalProperty("sim/cockpit2/tcas/targets/position/psi", 64)

verticalspeed = globalProperty("sim/cockpit2/tcas/targets/position/vertical_speed", 64)
relativeAlt = globalProperty("sim/cockpit2/tcas/indicators/relative_altitude_mtrs", 64)


captNdMode = globalProperty("A318/systems/ND/capt_mode")
captNdRnge = globalProperty("A318/systems/ND/capt_rnge")

-- /Define

function drawTarget(i)

	rangeKnob = get(globalProperty("sim/cockpit2/EFIS/map_range"))
	rangeMultiply = 8.5

	local yOffset = (get(targetZ, i) - get(localZ)) / 1852
	local xOffset = (get(targetX, i) - get(localX)) / 1852

	local a = get(vX, i) * get(vX, i)
	local b = get(vZ, i) * get(vZ, i)
	local groundspeed = math.floor((1.944 * math.sqrt(a + b)) + 0.5)

	local relAlt = math.floor(((get(relativeAlt, i) * 3.28) / 100))

	local hdg = get(heading, i)

	local targetDist = globalProperty("sim/cockpit2/tcas/indicators/relative_distance_mtrs", 64)

	if (i-1) == 0 then
		flightid = get(globalProperty("sim/multiplayer/position/plane"..(i).."_tailnum"))
		type = get(globalProperty("sim/multiplayer/position/plane"..(i).."_ICAO"))
	else
		flightid = get(globalProperty("sim/multiplayer/position/plane"..(i - 1).."_tailnum"))
		type = get(globalProperty("sim/multiplayer/position/plane"..(i - 1).."_ICAO"))
	end

	if i == 1 then
		-- do nothing
	else 
		if (get(targetDist, i) / 1852) < 2.1 and math.abs(get(relativeAlt, i) * 3.28) < 600 then -- resolution advisory
			if relAlt >= 01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, red)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, red)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), 25 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), "+"..relAlt, 12, true, false, TEXT_ALIGN_CENTER, red)
			elseif relAlt <= -01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, red)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, red)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), -42 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), relAlt, 12, true, false, TEXT_ALIGN_CENTER, red)
			end
			sasl.gl.drawRotatedTexturePart(symbols, hdg,  -20 + (rangeMultiply * xOffset), -24.855 - (rangeMultiply * yOffset), 40, 49.71, 816, 0, 272, 334, white)
		elseif (get(targetDist, i) / 1852) < 3.3 and math.abs(get(relativeAlt, i) * 3.28) < 850 then -- traffic advisory
			if relAlt >= 01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, orange)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, orange)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), 25 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), "+"..relAlt, 12, true, false, TEXT_ALIGN_CENTER, orange)
			elseif relAlt <= -01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, orange)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  22 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, orange)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), -42 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), relAlt, 12, true, false, TEXT_ALIGN_CENTER, orange)
			end
			sasl.gl.drawRotatedTexturePart(symbols, hdg,  -20 + (rangeMultiply * xOffset), -24.855 - (rangeMultiply * yOffset), 40, 49.71, 544, 0, 272, 334, white)
		elseif (get(targetDist, i) / 1852) < 6 and math.abs(get(relativeAlt, i) * 3.28) < 1200 then -- Intruder
			sasl.gl.drawRotatedTexturePart(symbols, hdg,  -20 + (rangeMultiply * xOffset), -24.855 - (rangeMultiply * yOffset), 40, 49.71, 272, 0, 272, 334, white)
			if relAlt >= 01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, white)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, white)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), 25 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), "+"..relAlt, 12, true, false, TEXT_ALIGN_CENTER, white)
			elseif relAlt <= -01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, white)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, white)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), -42 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), relAlt, 12, true, false, TEXT_ALIGN_CENTER, white)
			end
			if rangeKnob < 4 then
				sasl.gl.drawRotatedText(font, -25 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), flightid, 15, true, false, TEXT_ALIGN_RIGHT, white)
				sasl.gl.drawRotatedText(font, -25 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset) - 15, 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg),  groundspeed.." "..type, 12, true, false, TEXT_ALIGN_RIGHT, white)
			end
		else -- no threat
			sasl.gl.drawRotatedTexturePart(symbols, hdg,  -20 + (rangeMultiply * xOffset), -24.855 - (rangeMultiply * yOffset), 40, 49.71, 0, 0, 272, 334, white)
			if relAlt >= 01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, white)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), 23 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, white)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), 25 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), "+"..relAlt, 12, true, false, TEXT_ALIGN_CENTER, white)
			elseif relAlt <= -01 then
				if get(verticalspeed, i) > 100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 14, 365, 65, 130, white)
				elseif get(verticalspeed, i) < -100 then 
					sasl.gl.drawRotatedTexturePartCenter(symbols, get(localHdg), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset),  20 + (rangeMultiply * xOffset), -44 - (rangeMultiply * yOffset), 6.5, 13, 80, 365, 65, 130, white)
				end
				sasl.gl.drawRotatedText(font, 0 + (rangeMultiply * xOffset), -42 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), relAlt, 12, true, false, TEXT_ALIGN_CENTER, white)
			end
			if rangeKnob < 4 then
				sasl.gl.drawRotatedText(font, -25 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg), flightid, 15, true, false, TEXT_ALIGN_RIGHT, white)
				sasl.gl.drawRotatedText(font, -25 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset) - 15, 0 + (rangeMultiply * xOffset), 0 - (rangeMultiply * yOffset), get(localHdg),  groundspeed.." "..type, 12, true, false, TEXT_ALIGN_RIGHT, white)
			end
		end
	end
end

function draw()
	sasl.gl.setClipArea (0, 0, 500, 500)
	if get(captNdMode) < 3 then
		sasl.gl.setTranslateTransform (249.5, 250)
	else
		sasl.gl.setTranslateTransform (249.5, 95)
	end
	sasl.gl.setRotateTransform (-1 * get(localHdg))

	for i=1,64 do
		drawTarget(i)
	end
	if get(toggle) == 1 and get(globalProperty("sim/cockpit/switches/EFIS_map_mode")) == 1 and get(globalProperty("sim/cockpit/radios/transponder_mode")) == 2  and get(globalProperty("sim/operation/override/override_TCAS")) == 1 then

	end
end