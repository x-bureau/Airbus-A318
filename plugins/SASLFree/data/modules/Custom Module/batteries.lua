--Airbus A318 By X-Bureau--
-----------------------------------------------------------------------------------------------------
--Battery Components Set-Up
--BATTERY INFO [FOR REFERENCE]:
--TYPE: NCSP B 23060 LM
--MATERIAL: Nickel Cadmium
-----------------------------------------------------------------------------------------------------
local BAT_NOM_VOLTAGE = 24 --This is the recommended use voltage
local BAT_NOM_CAPACITY = 23 --This is the charging rate
local BAT_MAX_CAPACITY = 28.5 --This is the absolute max capacity that the battery can hold
local BAT_CHARGE_LEVEL = 26 --Below this threshold, the battery will begin to chargeß
local BAT_ENERGY_LOSS = 0.05 --The charge of a battery slowly depletes over time
local BAT_CHARGING_CURRENT = BAT_NOM_CAPACITY / 5 --This is the charging current
-----------------------------------------------------------------------------------------------------
--Defining the Actual Batteries
-----------------------------------------------------------------------------------------------------
batteries = {
    {
    id = 1
    in_use = false,
    charging = false,
    current_volt = 0,
    current_sink_amps = 0,
    current_source_amps = 0,
    current_charge = BAT_NOM_CAPACITY-math.random(0,5)/10,
    connected_to_dc_bus = false,
    },
    {   
    id = 2
    in_use = false,
    charging = false,
    current_volt = 0,
    current_sink_amps = 0,
    current_source_amps = 0,
    current_charge = BAT_NOM_CAPACITY-math.random(0,5)/10,
    connected_to_dc_bus = false,
    }
}
-----------------------------------------------------------------------------------------------------
--FUNCTION TIME!
-----------------------------------------------------------------------------------------------------
local function update_battery_charge
    bat.current_charge = bat.current_charge + (bat.current_sink_amps - bat.current_source_amps)
    * get(DELTA_TIME) / 3600

    --CALCULATING THE VOLTAGE
    bat.current_volt = math.max(0, BAT_MAX_CAPACITY * (bat.current_charge / BAT_NOM_CAPACITY))
end


