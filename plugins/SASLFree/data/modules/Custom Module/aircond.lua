--[[====================
	AIR COND SYSTEM
========================
WRITTEN BY:
- FBI914
- Jamlen
========================
DEFINING PROPERTIES
========================]]
local Aircond {
[1] = { --ZONE 1 = COCKPIT
	pressure = sasl.gl.createGlobalPropertyi("A318/systems/aircond/cockpit/pressure", 0);
	trimAir_valve = sasl.gl.createGlobalPropertyi("A318/systems/aircond/cockpit/trim_air_valve", 0);
	tempControlSwitch = sasl.gl.createGlobalPropertyf("A318/systems/aircond/cockpit/temp_control", 1);
	--.80 = 80% = LO | 1 = 100% = REG | 1.2 = 120% = HI
	setTemp = sasl.gl.createGlobalPropertyf("A318/systems/aircond/cockpit/set_temperature", 0)
	};
[2] = { --ZONE 2 = FWD CABIN
	pressure = sasl.gl.createGlobalPropertyi("A318/systems/aircond/FWD_Cabin/pressure", 0);
	trimAir_valve = sasl.gl.createGlobalPropertyi("A318/systems/aircond/FWD_Cabin/trim_air_valve", 0);
	tempControlSwitch = sasl.gl.createGlobalPropertyf("A318/systems/aircond/FWD_Cabin/temp_control", 1);	
	--.80 = 80% = LO | 1 = 100% = REG | 1.2 = 120% = HI
	setTemp = sasl.gl.createGlobalPropertyf("A318/systems/aircond/FWD_Cabin/set_temperature", 0)
	};
[3] = { --ZONE 3 = AFT CABIN
	pressure = sasl.gl.createGlobalPropertyi("A318/systems/aircond/AFT_Cabin/pressure", 0);
	trimAir_valve = sasl.gl.createGlobalPropertyi("A318/systems/aircond/AFT_Cabin/trim_air_valve", 0);
	tempControlSwitch = sasl.gl.createGlobalPropertyf("A318/systems/aircond/AFT_Cabin/temp_control", 1); 
	--.80 = 80% = LO | 1 = 100% = REG | 1.2 = 120% = HI
	setTemp = sasl.gl.createGlobalPropertyf("A318/systems/aircond/AFT_Cabin/set_temperature", 0)
	}
}

local packs = {
	[1] = {
		valve_switch_state = {
			[0] = "Closed";
			[1] = "Opened"
		};
		pb = sasl.gl.createGlobalPropertyi("A318/systems/aircond/packs/1/state", 0)
		};
	[2] = {
		valve_switch_state = {
			[0] = "Closed";
			[1] = "Opened"
		};
		pb  = sasl.gl.createGlobalPropertyi("A318/systems/aircond/packs/2/state", 0)
	}
}

local temp {
	cold = 64;
	reg = 76;
	hot = 86;
}

local HotAir_Valve = sasl.gl.createGlobalPropertyi("A318/systems/aircond/heat_air_valve", 0)
--RAM AIR PB Dataref: 0 = RELEASED | 1 = PUSHED
local RAM_AIR_PB = sasl.gl.createGlobalPropertyi("A318/systems/aircond/RAM_AIR/pb", 0)

--[[======================
		FUNCTIONS
==========================]]

while packs.1.switch_state == 1 
	air.transfer = true
end

--If the cockpit TRIM AIR VALVE FAILS, or if BOTH CABIN TRIM AIR VALVES FAIL, then close the HOT AIR VALVE 
if get(Aircond.1.trimAir_valve) == 2 or get(Aircond.2.trimAir_valve) == 2 and get(Aircond.2.trimAir_valve) == 2 then
	set(HotAir_Valve) == 0
end


--[[================================
	AIRCRAFT TEMPERATURE CONTROLS
==================================]]

--TEMP CONTROLS for COCKPIT
if get(Aircond.1.setTempControlSwitch) == 0 then
	set(Aircond.1.setTemp) = 18
elseif get(Aircond.1.setTempControlSwitch) == 1 then
	set(Aircond.1.setTemp) = 20
elseif get(Aircond.1.setTempControlSwitch) == 2 then
	set(Aircond.1.setTemp) = 22
elseif get(Aircond.1.setTempControlSwitch) == 3 then
	set(Aircond.1.setTemp) = 24
elseif get(Aircond.1.setTempControlSwitch) == 4 then
	set(Aircond.1.setTemp) = 26
elseif get(Aircond.1.setTempControlSwitch) == 5 then
	set(Aircond.1.setTemp) = 28
elseif get(Aircond.1.setTempControlSwitch) == 6 then
	set(Aircond.1.setTemp) = 30
else
	set(Aircond.1.setTemp) = 24
end

--TEMP CONTROLS for FWD_Cabin
if get(Aircond.2.setTempControlSwitch) == 0 then
	set(Aircond.2.setTemp) = 18
elseif get(Aircond.2.setTempControlSwitch) == 1 then
	set(Aircond.2.setTemp) = 20
elseif get(Aircond.2.setTempControlSwitch) == 2 then
	set(Aircond.2.setTemp) = 22
elseif get(Aircond.2.setTempControlSwitch) == 3 then
	set(Aircond.2.setTemp) = 24
elseif get(Aircond.2.setTempControlSwitch) == 4 then
	set(Aircond.2.setTemp) = 26
elseif get(Aircond.2.setTempControlSwitch) == 5 then
	set(Aircond.2.setTemp) = 28
elseif get(Aircond.2.setTempControlSwitch) == 6 then
	set(Aircond.2.setTemp) = 30
else
	set(Aircond.2.setTemp) = 24
end

--TEMP CONTROLS for AFT_Cabin/pressure
if get(Aircond.3.setTempControlSwitch) == 0 then
	set(Aircond.3.setTemp) = 18
end 
elseif get(Aircond.3.setTempControlSwitch) == 1 then
	set(Aircond.3.setTemp) = 20
elseif get(Aircond.3.setTempControlSwitch) == 2 then
	set(Aircond.3.setTemp) = 22
elseif get(Aircond.3.setTempControlSwitch) == 3 then
	set(Aircond.3.setTemp) = 24
elseif get(Aircond.3.setTempControlSwitch) == 4 then
	set(Aircond.3.setTemp) = 26
elseif get(Aircond.3.setTempControlSwitch) == 5 then
	set(Aircond.3.setTemp) = 28
elseif get(Aircond.3.setTempControlSwitch) == 6 then
	set(Aircond.3.setTemp) = 30
else
	set(Aircond.3.setTemp) = 24
end

