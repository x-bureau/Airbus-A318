-- INITIALIZE VARIABLES
local CTL_OVERRIDE = globalProperty("sim/operation/override/override_control_surfaces")
local aileron = {
    left = {
        deflection = globalPropertyfa("sim/flightmodel2/wing/aileron1_deg")
    },
    right = {
        deflection = globalPropertyfa("sim/flightmodel2/wing/aileron1_deg")
    }
}



-- OVERRIDE DEFAULT CONTROLS
set(CTL_OVERRIDE, 1)
local MAX_AILERON_ANGLE = 20 -- Maximum aileron angle in degrees
local MAX_BANK_ANGLE = 25 -- Maximum bank angle in degrees

-- HEADING CONTROL
-- Variables
local current_heading = 180 -- Current heading in degrees
local desired_heading = 270 -- Desired heading in degrees

local function calculate_aileron_input(current_heading, desired_heading)
  -- Calculate the heading difference between the current and desired headings
    local heading_diff = desired_heading - current_heading
  -- If the heading difference is greater than 180 degrees, wrap around to the opposite direction
    if heading_diff > 180 then
        heading_diff = heading_diff - 360
    elseif heading_diff < -180 then
        heading_diff = heading_diff + 360
    end
    -- Calculate the maximum bank angle based on the heading difference and maximum bank angle
    local max_bank_angle = MAX_BANK_ANGLE * math.abs(heading_diff) / 180
    -- If the maximum bank angle is greater than the maximum allowed angle, use the maximum allowed angle instead
    if max_bank_angle > MAX_BANK_ANGLE then
        max_bank_angle = MAX_BANK_ANGLE
    end
    
    -- Calculate the maximum possible aileron angle based on the maximum bank angle and maximum aileron angle
    local max_aileron_angle = MAX_AILERON_ANGLE * max_bank_angle / MAX_BANK_ANGLE
    
    -- Calculate the aileron input based on the maximum aileron angle and the direction of the heading difference
    local aileron_input = 0
    if heading_diff > 0 then
        aileron_input = max_aileron_angle
    elseif heading_diff < 0 then
        aileron_input = -max_aileron_angle
    end
    
    -- Return the calculated aileron input
    return aileron_input
    end

    -- Example usage
    for i = 1, 10 do
    local aileron_input = calculate_aileron_input(current_heading, desired_heading)
    print("Aileron input: " .. aileron_input)
    
    -- Update the current heading based on the aileron input
    current_heading = current_heading + aileron_input * 0.1 -- Assuming a 0.1 second time delta
end