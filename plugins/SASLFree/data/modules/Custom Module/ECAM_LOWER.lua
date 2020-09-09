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
--create colors
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
    sasl.gl.drawTexture(lower_doors_overlay, 0, 0, 522, 522)--we are drawing the overlay
        if get(door_status, 1) == 0 then--if the door open ratio is = 0
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)--draw a green rectangle
        elseif get(door_status, 1) == 1 then--if the door open ratio is = 1
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)--draw a red rectangle
        else--anything else results in a yellow rectangle
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 2) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 2) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 3) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 3) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW) 
        end
        if get(door_status, 4) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 4) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 5) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 5) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 6) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 6) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 7) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 7) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 8) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 8) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 9) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 9) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
        end
        if get(door_status, 10) == 0 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_GREEN)
        elseif get(door_status, 10) == 1 then
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_RED)
        else
            sasl.gl.drawRectangle(0, 0, 50, 100, ECAM_YELLOW)
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
    elseif get(current_ecam_pag) == 3 then --if the curent ecam page is 3
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