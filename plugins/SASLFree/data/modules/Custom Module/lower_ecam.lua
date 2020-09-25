--A318 by X-Bureau--
position = {1144, 50, 522, 522}
size = {522, 522}

--defining dataref variables
local current_ecam_page = createGlobalPropertyi("A318/cockpit/ecam/ecam_current_page", 1)--create variable that tells us current ecam page
local altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")--we define an altitude variable
local airspeed = globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")--we define an airspeed variable
local pitch = globalPropertyf("sim/cockpit2/gauges/indicators/pitch_electric_deg_pilot")--we define an a pitch variable
local roll = globalPropertyf("sim/cockpit2/gauges/indicators/roll_electric_deg_pilot")--we define a roll variable
local npercent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)--we define the N1 Percent dataref
local n2percent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7)--we define the N2 Percent dataref
local door_status = globalPropertyfa("sim/flightmodel2/misc/door_open_ratio", 10)--we define the door open ratio dataref
local fuel_init_quantity = globalPropertyf("sim/cockpit2/fuel/fuel_totalizer_init_kg")--we define the amout of fuel that the aircraft was loaded with
local fuel_current_quantity = globalPropertyfa("sim/cockpit2/fuel/fuel_quantity", 9)--we define the amount of fuel that the aircraft has remaining
local fuel_used = createGlobalPropertyfa("A318/systems/fuel_used", 2)--we define the amount of fuel used by each engine
local oil_qty = globalPropertyfa("sim/flightmodel/engine/ENGN_oil_quan", 8)--we define an oil quantity dataref
local cabin_alt = globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft")--we define the dataref for cabin altitude
local speedbrake_status = globalPropertyfa("sim/flightmodel2/controls/speedbrake_ratio", 10)--we define the status of speedbrakes
local local_hour = globalPropertyi("sim/cockpit2/clock_timer/local_time_hours")
local local_mins = globalPropertyi("sim/cockpit2/clock_timer/local_time_minutes")
local zulu_hour = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_hours")
local zulu_mins = globalPropertyi("sim/cockpit2/clock_timer/zulu_time_minutes")
local temp_sat = globalPropertyf("sim/cockpit2/temperature/outside_air_LE_temp_degc")
local temp_tat = globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")
local weight_empty = globalPropertyf("sim/aircraft/weight/acf_m_empty")
local weight_fuel = globalPropertyf("sim/aircraft/weight/acf_m_fuel_tot")
local vsi = globalPropertyf("sim/flightmodel/position/vh_ind_fpm")

--create colors
local ECAM_ORANGE = {255, 165, 0} --We make a red color with 255 red, 0 green, and 0 blue
local ECAM_RED = {255, 0, 0} --We make a red color with 255 red, 0 green, and 0 blue
local ECAM_GREEN = {0.184, 0.733, 0.219, 1.0}--we make a green color with 0.184 red, 0.733 green, 0.219 Blue, and 1.0 for the alpha
local ECAM_WHITE = {1.0, 1.0, 1.0, 1.0}--we make a white color with 1.0 red, 1.0 green, 1.0 Blue, and 1.0 for the alpha
local ECAM_BLUE = {0.004, 1.0, 1.0, 1.0}--we make a blue color with 0.004 red, 1.0 green, 1.0 Blue, and 1.0 for the alpha
local ECAM_GREY = {0.25, 0.26, 0.26, 1.0}--we make a grey color with 0.25 red, 0.26 green, 0.26 Blue, and 1.0 for the alpha
local ECAM_YELLOW = {1.0, 1.0, 0, 1.0}--we make a yellow color with 1.0 red, 1.0 green, 0 blue, and 1.0 alpha
--fonts
local AirbusFont = sasl.gl.loadFont("fonts/PanelFont.ttf")

--load images
local lower_engine_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam engine page overlay
local lower_bleed_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam bleed page overlay
local lower_press_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam pressure page overlay
local lower_elec_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam electricity page overlay
local lower_hyd_overlay = sasl.gl.loadImage("images/hydraulics.png")--defining the lower ecam hydraulics page overlay
local lower_fuel_overlay = sasl.gl.loadImage("images/fuel.png")--defining the lower ecam fuel page overlay
local lower_apu_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam APU page overlay
local lower_air_cond_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam Air Cond page overlay
local lower_doors_overlay = sasl.gl.loadImage("images/ECAM_DOOR_OVERLAY.png")--defining the lower ecam doors page overlay
local lower_wheel_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam wheels page overlay
local lower_fctl_overlay = sasl.gl.loadImage("images/fctl.png")--defining the lower ecam Flight Controls page overlay
local lower_sts_overlay = sasl.gl.loadImage("images/ECAM_ENG_LOWER.png")--defining the lower ecam systems page overlay
local lower_cruise_overlay = sasl.gl.loadImage("images/cruise.png")--defining the lower ecam cruise page overlay


--custom functions
local function draw_eng_page()--draw engine page
    sasl.gl.drawTexture(lower_engine_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_bleed_page()--draw the bleed page
    sasl.gl.drawTexture(lower_bleed_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_press_page()--draw the pressure page
    sasl.gl.drawTexture(lower_press_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_elec_page()--draw the electricity page
    sasl.gl.drawTexture(lower_elec_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_hyd_page()--draw the hyd page
    sasl.gl.drawTexture(lower_hyd_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_fuel_page()--draw the fuel page
    sasl.gl.drawTexture(lower_fuel_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_apu_page()--draw the apu page
    sasl.gl.drawTexture(lower_apu_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_air_cond_page()--draw the air conditioning page
    sasl.gl.drawTexture(lower_air_cond_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_doors_page()--draw the doors page
    sasl.gl.drawTexture(lower_doors_overlay, 0, 0, 522, 522)--18, -3, 542, 542)--we are drawing the overlay

    -- sasl.gl.drawText(AirbusFont, 70, 55, "TAT", 18, false, false, TEXT_ALIGN_RIGHT, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 90, 48, string.format("%+.1f", get(temp_tat)), 18, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
    -- sasl.gl.drawText(AirbusFont, 140, 55, "°C", 18, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)

    -- sasl.gl.drawText(AirbusFont, 70, 20, "SAT", 18, false, false, TEXT_ALIGN_RIGHT, ECAM_WHITE)
    sasl.gl.drawText(AirbusFont, 90, 27, string.format("%+.1f", get(temp_sat)), 18, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
    -- sasl.gl.drawText(AirbusFont, 140, 20, "°C", 18, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)

    sasl.gl.drawText(AirbusFont, 251, 27, string.format("%02d", get(zulu_hour)), 18, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 273, 27, string.format("%02d", get(zulu_mins)), 18, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
    -- sasl.gl.drawText(AirbusFont, 261, 32, 'H', 14, false, false, TEXT_ALIGN_RIGHT, ECAM_WHITE)

    local tot_weight = get(weight_empty) + get(weight_fuel)
    sasl.gl.drawText(AirbusFont, 472, 46, string.format("%.f", get(tot_weight)), 18, false, false, TEXT_ALIGN_RIGHT, ECAM_GREEN)
    ----------------------------------------------------------------------------------------------------------

    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    local function round(v, bracket)
        bracket = bracket or 1
        return math.floor(v/bracket + sign(v) * 0.5) * bracket
    end
    -- Vertical speed
    sasl.gl.drawText(AirbusFont, 362, 410, 'V/S', 20, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)

    local vs = round(get(vsi))
    local blink = false
    local vs_colour = ECAM_GREEN
    if vs >= 2000 or vs <= -2000 then
        vs_colour = ECAM_ORANGE
    elseif (vs >= 1850 and vs < 2000) or (vs <= -1850 and vs > -2000) then
        blink = true
    elseif blink and (vs < 1600 or vs > -1600) then
        blink = false
    elseif vs > 0 then
    end
    sasl.gl.drawWidePolyLine({403, 411, 410, 411, 423, 424, 417, 423, 423, 418, 423, 424}, 2, vs_colour)
    sasl.gl.drawText(AirbusFont, 476, 410, string.format("%.f", round(vs, 10)), 20, false, false, TEXT_ALIGN_RIGHT, vs_colour)
    sasl.gl.drawText(AirbusFont, 482, 410, "FT/MIN", 14, false, false, TEXT_ALIGN_LEFT, ECAM_BLUE)

    -- door 1 - CPT FRONT
    sasl.gl.drawWidePolyLine({228, 350, 228, 368, 238, 368, 238, 350, 227, 350}, 2, ECAM_GREEN)
    -- door 2 - FO FRONT
    sasl.gl.drawWidePolyLine({283, 350, 283, 368, 293, 368, 293, 350, 282, 350}, 2, ECAM_GREEN)
    -- door 3 - fwd cargo
    sasl.gl.drawWidePolyLine({277, 297, 277, 315, 293, 315, 293, 297, 276, 297}, 2, ECAM_GREEN)
    -- L slide
    sasl.gl.drawWidePolyLine({228, 230, 228, 248, 238, 248, 238, 230, 227, 230}, 2, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 217, 232, 'SLIDE', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_WHITE)
    -- R slide
    sasl.gl.drawWidePolyLine({283, 230, 283, 248, 293, 248, 293, 230, 282, 230}, 2, ECAM_GREEN)
    sasl.gl.drawText(AirbusFont, 306, 232, 'SLIDE', 16, false, false, TEXT_ALIGN_LEFT, ECAM_WHITE)

    -- door 4 - aft cargo
    sasl.gl.drawWidePolyLine({277, 172, 277, 190, 293, 190, 293, 172, 276, 172}, 2, ECAM_GREEN)

    -- door 5 - CPT aft
    sasl.gl.drawWidePolyLine({228, 110, 228, 128, 238, 128, 238, 110, 227, 110}, 2, ECAM_GREEN)

    -- door 6 - FO aft
    sasl.gl.drawWidePolyLine({283, 110, 283, 128, 293, 128, 293, 110, 282, 110}, 2, ECAM_GREEN)

    -- avionics
    sasl.gl.drawWidePolyLine({253, 428, 253, 436, 268, 436, 268, 428, 252, 428}, 2, ECAM_GREEN)
    sasl.gl.drawWidePolyLine({271, 398, 271, 413, 279, 413, 279, 398, 270, 398}, 2, ECAM_GREEN)
    sasl.gl.drawWidePolyLine({243, 398, 243, 413, 251, 413, 251, 398, 242, 398}, 2, ECAM_GREEN)
    sasl.gl.drawWidePolyLine({278, 140, 278, 158, 285, 158, 285, 140, 277, 140}, 2, ECAM_GREEN)

    if get(door_status, 1) == 0 then--if the door open ratio is = 0
        -- sasl.gl.drawWidePolyLine({225, 350, 225, 370, 238, 370, 238, 350, 224, 350}, 3, ECAM_GREEN)
        -- sasl.gl.drawFrame(223, 350, 13, 20, ECAM_GREEN)--draw a green rectangle
    elseif get(door_status, 1) > 0 then--if the door open ratio is = 1
        sasl.gl.drawText(AirbusFont, 218, 355, 'CABIN -----------', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_ORANGE)
        sasl.gl.drawRectangle(228, 350, 10, 18, ECAM_YELLOW)--draw a red rectangle
    -- else--anything else results in a yellow rectangle
    --     sasl.gl.drawRectangle(225, 350, 11, 18, ECAM_RED)
    end

    if get(door_status, 2) > 0 then
        sasl.gl.drawText(AirbusFont, 302, 355, '----------- CABIN', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(283, 350, 10, 18, ECAM_YELLOW)
    end

    if get(door_status, 3) == 1 then
        sasl.gl.drawText(AirbusFont, 302, 300, '------ CARGO', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(277, 297, 16, 18, ECAM_YELLOW)
    elseif get(door_status, 3) > 0 then
        sasl.gl.drawRectangle(277, 297, 16, 18, ECAM_RED)
    end

    if get(door_status, 4) == 1 then
        sasl.gl.drawText(AirbusFont, 302, 175, '------ CARGO', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(277, 172, 16, 18, ECAM_YELLOW)
    elseif get(door_status, 4) > 0 then
        sasl.gl.drawRectangle(277, 172, 16, 18, ECAM_RED)
    end

    if get(door_status, 5) > 0 then
        sasl.gl.drawText(AirbusFont, 218, 115, 'CABIN -----------', 16, false, false, TEXT_ALIGN_RIGHT, ECAM_ORANGE)
        sasl.gl.drawRectangle(228, 110, 10, 18, ECAM_YELLOW)
    end

    if get(door_status, 6) > 0 then
        sasl.gl.drawText(AirbusFont, 302, 115, '----------- CABIN', 16, false, false, TEXT_ALIGN_LEFT, ECAM_ORANGE)
        sasl.gl.drawRectangle(283, 110, 10, 18, ECAM_YELLOW)
    -- else
    --     sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_RED)
    end

    if get(door_status, 7) == 0 then
        sasl.gl.drawFrame(0, 0, 13, 20, ECAM_GREEN)
    elseif get(door_status, 7) == 1 then
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_YELLOW)
    else
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_RED)
    end

    if get(door_status, 8) == 0 then
        sasl.gl.drawFrame(0, 0, 13, 20, ECAM_GREEN)
    elseif get(door_status, 8) == 1 then
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_YELLOW)
    else
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_RED)
    end

    if get(door_status, 9) == 0 then
        sasl.gl.drawFrame(0, 0, 13, 20, ECAM_GREEN)
    elseif get(door_status, 9) == 1 then
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_YELLOW)
    else
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_RED)
    end

    if get(door_status, 10) == 0 then
        sasl.gl.drawFrame(0, 0, 13, 20, ECAM_GREEN)
    elseif get(door_status, 10) == 1 then
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_YELLOW)
    else
        sasl.gl.drawRectangle(0, 0, 13, 20, ECAM_RED)
    end
end

local function draw_wheel_page()--draw the wheels page
    sasl.gl.drawTexture(lower_wheel_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_fctl_page()--draw the flight controls page
    sasl.gl.drawTexture(lower_fctl_overlay, 0, 0, 522, 522)--we are drawing the overlay
	--drawing the spoilers
	if get(speedbrake_status, 1) == 1 then
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 1) == 0 then
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 90, 300, 1, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 2) == 1 then
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 2) == 0 then
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 130, 310, 2, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 3) == 1 then
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 3) == 0 then
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 170, 320, 3, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 4) == 1 then
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 4) == 0 then
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 210, 330, 4, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 5) == 1 then
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 5) == 0 then
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 250, 340, 5, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 6) == 1 then
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 6) == 0 then
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 290, 340, 6, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 7) == 1 then
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 7) == 0 then
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 330, 330, 7, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 8) == 1 then
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 8) == 0 then 
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 370, 320, 8, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 9) == 1 then
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 9) == 0 then
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 410, 310, 9, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
	if get(speedbrake_status, 10) == 1 then
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	elseif get(speedbrake_status, 10) == 0 then
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)
	else
		sasl.gl.drawText(AirbusFont, 450, 300, 10, 25, false, false, TEXT_ALIGN_LEFT, ECAM_YELLOW)
	end
end

local function draw_sts_page()--draw the systems page
    sasl.gl.drawTexture(lower_sts_overlay, 0, 0, 522, 522)--we are drawing the overlay
end

local function draw_cruise_page()--draw the cruise page
    sasl.gl.drawTexture(lower_cruise_overlay, 0, 0, 522, 522)--we are drawing the overlay
    --engine 1 fuel used = initial fuel quantity - (the current fuel quantity of tank 1) + (The current fuel quantity of engine 2)
    --set(fuel_used, 1) = (math.floor(get(fuel_init_quantity)) - (math.floor(get(fuel_current_quantity, 1) + math.floor(get(fuel_current_quantity, 2)))))--we determine the fuel used by engine 1
    --set(fuel_used, 2) = (math.floor(get(fuel_init_quantity)) - (math.floor(get(fuel_current_quantity, 1) + math.floor(get(fuel_current_quantity, 2)))))--we determine the fuel used by engine 2
    --sasl.gl.drawText(AirbusFont, 110, 375, get(fuel_used, 1), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the fuel used by engine 1
    --sasl.gl.drawText(AirbusFont, 210, 375, get(fuel_used, 2), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the fuel used by engine 2
    sasl.gl.drawText(AirbusFont, 110, 325, get(oil_qty, 1), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the engine 1 oil quantity
    sasl.gl.drawText(AirbusFont, 210, 325, get(oil_qty, 2), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the engine 2 oil quantity
    sasl.gl.drawText(AirbusFont, 490, 80, get(cabin_alt), false, false, TEXT_ALIGN_LEFT, ECAM_GREEN)--we display the current cabin altitude
end

function draw() --the function that actually draws on the panel
    if get(current_ecam_page) == 1 then --if the curent ecam page is 1
        draw_eng_page()--draw the engine page
    elseif get(current_ecam_page) == 2 then --if the curent ecam page is 2
        draw_bleed_page()--draw the bleed page
    elseif get(current_ecam_page) == 3 then --if the curent ecam page is 3
        draw_press_page()--draw the pressure page
    elseif get(current_ecam_page)== 4 then --if the curent ecam page is 4
        draw_elec_page()--draw the electricity page
    elseif get(current_ecam_page) == 5 then --if the curent ecam page is 5
        draw_hyd_page()--draw the hyd page
    elseif get(current_ecam_page) == 6 then --if the curent ecam page is 6
        draw_fuel_page()--draw the fuel page
    elseif get(current_ecam_page) == 7 then --if the curent ecam page is 7
        draw_apu_page()--draw the apu page
    elseif get(current_ecam_page) == 8 then --if the curent ecam page is 8
        draw_air_cond_page()--draw the air conditioning page
    elseif get(current_ecam_page) == 9 then --if the curent ecam page is 9
        draw_doors_page()--draw the doors page
    elseif get(current_ecam_page) == 10 then --if the curent ecam page is 10
        draw_wheel_page()--draw the wheel page
    elseif get(current_ecam_page) == 11	then --if the curent ecam page is 11
        draw_fctl_page()--draw the flight controls page
    elseif get(current_ecam_page) == 12 then --if the curent ecam page is 12
        draw_sts_page()--draw the systems page
    elseif get(current_ecam_page) == 13 then --if the curent ecam page is 13
        draw_cruise_page()--draw the cruise page
    end
end
