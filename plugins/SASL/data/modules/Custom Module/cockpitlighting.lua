-- Define Capt Reading Lights
local captReadLight = createGlobalPropertyf("A318/cockpit/lights/capt_reading")
local spillLight = globalPropertyf("sim/graphics/animation/lights/airplane_panel_spill[0]")

-- Initialize Captain Reading Light to ON
set(captReadLight, 1)