-- INITIALIZE VARIABLES
--local CTL_OVERRIDE = globalProperty("sim/operation/override/override_control_surfaces")
--local heading = globalPropertyf("A318/systems/ADIRS/1/inertial/heading")
-- local ROLL_OVERRIDE = globalProperty("sim/operation/override/override_joystick_roll")
-- local HDG = math.floor(get(heading))

-- local aileron = {
--     left = {
--         deflection = globalPropertyfa("sim/flightmodel2/wing/aileron1_deg")
--     },
--     right = {
--         deflection = globalPropertyfa("sim/flightmodel2/wing/aileron1_deg")
--     }
-- }

-- local elevators = {
--     left = {
--         deflection = globalPropertyfa("sim/flightmodel2/wing/elevator1_deg")
--     },
--     right = {
--         deflection = globalPropertyfa("sim/flightmodel2/wing/elevator1_deg")
--     }
-- }


-- OVERRIDE DEFAULT CONTROLS
-- set(ROLL_OVERRIDE, 0)

-- -- HEADING
-- local MAX_AILERON_ANGLE = 20 -- Maximum aileron angle in degrees
-- local MAX_BANK_ANGLE = 25 -- Maximum bank angle in degrees

-- function update()
--     if HDG ~= 180 then
--         if HDG > 180 then
--             set(aileron.left.deflection,20,2)
--             set(aileron.left.deflection,-20,3)

--         else
--             set(aileron.left.deflection,-20,2)
--             set(aileron.left.deflection,20,3)
--         end
--     end
-- end