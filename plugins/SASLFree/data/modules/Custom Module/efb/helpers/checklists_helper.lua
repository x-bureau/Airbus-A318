-- TODO: add support for custom checklists that the user wants

local pre_start_checklist = {
    {"PARKING BRAKE", "SET", 0},
    {"CHOCKS", "REMOVE", 0},
    {"GPU", "CONNECTED", 0},
    {"THROTTLE", "LEVERS IDLE", 0},
    {"ENGINE MASTERS", "OFF", 0},
    {"BATTERIES", "ON", 0},
    {"GENERATOR SWITCHES", "ON", 0},
    {"EXT POWER", "ON", 0},
    {"ADIRS", "ON", 0},
    {"PANEL DISPLAYS", "BRIGHTNESS SET", 0},
    {"NAV LIGHTS", "ON", 0},
    {"PANEL LIGHTS", "AS REQUIRED", 0},
    {"GEAR LEVER", "DOWN", 0},
    {"FLAPS", "UP", 0},
    {"SPOILER", "RETRACTED", 0},
    {"FUEL QUANTITY", "CHECK", 0},
    {"FASTEN SEATBELTS", "ON", 0},
    {"NO SMOKING SIGNS", "ON", 0},
    {"Check Weather(ATIS, Flight Services)", 0},
    {"TRANSPONDER", "SET, STANDBY", 0},
    {"BEACON LIGHTS", "ON", 0},
    {"FMC", "SETUP", "CHECK", 0},
    {"DEPARTURE BRIEFING", "COMPLETE", 0},
    {"DOORS", "CLOSED", 0}
}

local startup_checklist = {
    {"APU", "START", 0},
    {"APU BLEED", "RUN (WHEN AVAIL)", 0},
    {"APU GEN", "ON", 0},
    {"Request Pushback - Initiate Pushback", 0},
    {"THRUST LEVERS", "IDLE", 0},
    {"ENGINE AREA", "CLEAR", 0},
    {"FUEL PUMPS", "ON", 0},
    {"MODE SELECTOR", "IGN / START", 0},
    {"ENGINE MASTER 1", "START", 0},
    {"AT N2 > 20% FUEL FLOW", "CHECK", 0},
    {"ENGINE MASTER 2", "START", 0},
    {"AT N2 > 20% FUEL FLOW", "CHECK", 0},
    {"FUEL FLOW", "CHECK", 0},
    {"HYDRAULIC PUMP SWITCHES", "ON", 0},
    {"APU", "OFF", 0},
    {"MODE SELECTOR", "NORM", 0}
}

local before_taxi_checklist = {
    {"PROBE/WINDOW HEAT", "AUTO", 0},
    {"HDG INDICATOR / ALTIMETERS", "SET", 0},
    {"STDBY INSTRUMENTS", "SET", 0},
    {"RADIOS AND AVIONICS", "SET FOR DEPARTURE", 0},
    {"AUTOPILOT", "SET, don't activate", 0},
    {"F/D", "ON", 0},
    {"AUTOBRAKE", "MAX", 0},
    {"FLAPS", "SET", 0},
    {"TRIM", "SET", 0},
    {"FLIGHT CONTROLS", "CHECK", 0}
}

local before_takeoff_checklist = {
    {"PARKING BRAKE", "SET", 0},
    {"FLIGHT INSTRUMENTS", "CHECK", 0},
    {"ENGINE INSTRUMENTS", "CHECK", 0},
    {"TAKE-OFF DATA", "(V1, VR, V2) CHECK", 0},
    {"NAV EQUIPMENT", "CHECK", 0},
    {"LANDING LIGHTS", "ON", 0},
    {"STROBE LIGHT", "ON", 0},
    {"PITOT HEAT", "AUTO", 0},
    {"DE-ICE", "AS REQUIRED", 0},
    {"TRANSPONDER", "TA/RA", 0},
    {"Request Takeoff Clearance", 0}
}

local climb_out_checklist = {
    {"THRUST LEVERS", "CLB DETENT", 0},
    {"AP1", "ENGAGE (when suitable)", 0},
    {"TAXI LIGHTS", "OFF", 0},
    {"At TA (Transition Altitude)", 0},
    {"ALTIMETER", "STD (29.92 / 1013)", 0},
    {"BELOW 10,000FT", "MAX 250 KIAS", 0},
    {"ATC", "AS REQUIRED", 0},
    {"Passing 10,000FT", 0},
    {"LANDING LIGHTS", "OFF", 0},
    {"Above 10,000FT", 0},
    {"FASTEN SEATBELTS", "OFF", 0}
}

local cruise_checklist = {
    {"Accelerate to Cruise Speed", 0},
    {"ENGINE & INSTRUMENTS", "MONITOR", 0},
    {"FUEL QUANTITY", "CHECK", 0},
    {"RADIOS", "TUNED & SET", 0},
    {"AUTOPILOT", "CHECK & SET", 0},
    {"LIGHTS", "AS REQUIRED", 0},
    {"ATIS / AIRPORT INFO", "CHECK", 0},
    {"ALTIMETER", "CHECK", 0},
    {"RADIOS", "SET", 0},
    {"ANTI-ICE", "AS REQUIRED", 0},
    {"TOD", "SET TCAS TO BELOW", 0},
    {"At TA (Transition Altitude)", 0},
    {"ALTIMETER", "RESET TO LOCAL",},
    {"FL120", "280 KIAS", 0},
    {"Below 10,000FT", 0},
    {"SPEED", "250 KIAS", 0},
    {"LANDING LIGHTS", "ON", 0},
    {"LS", "ON", 0},
    {"FUEL QUANTITIES & BALANCE", "CHECK", 0},
    {"FLAPS / LANDING GEAR", "CHECK UP", 0},
    {"Check Weather (ATIS, Flight Services)", 0}
}

local approach_checklist = {
    {"FASTEN SEATBELTS", "ON", 0},
    {"RADIOS", "SET", 0},
    {"SPEED", "AS REQUIRED", 0},
    {"LANDING LIGHTS", "CHECK ON", 0},
    {"TAXI LIGHTS", "ON", 0},
    {"GND SPOILERS", "ARM", 0},
    {"AUTO BRAKE", "SET", 0},
    {"FLAPS", "AS REQUIRED", 0},
    {"LANDING GEAR", "DOWN", 0},
    {"Final Glideslope Descent", 0},
    {"SPEED", "AS REQUIRED", 0},
    {"PARKING BRAKE", "VERIFY OFF", 0},
    {"ANTI-ICE", "AS REQUIRED", 0}
}

local landing_checklist = {
    {"LANDING GEAR", "CHECK DOWN", 0},
    {"AUTOPILOT", "AS REQUIRED", 0},
    {"GO-AROUND ALTITUDE", "SET IN FCU", 0},
    {"AUTO-THRUST", "AS REQUIRED", 0},
    {"LANDING MEMO", "NO BLUE", 0},
    {"After Touchdown", 0},
    {"REVERSE THRUST", "VERIFY ENGAGED", 0},
    {"SPOILERS", "VERIFY EXTENDED", 0},
    {"BRAKES", "AS REQUIRED", 0}
}

local after_landing_checklist = {
    {"SPOILERS", "DISARMED", 0},
    {"FLAPS", "RETRACT", 0},
    {"ENG MODE SELECTOR", "NORM", 0},
    {"LANDING LIGHTS", "OFF", 0},
    {"STROBE LIGHTS", "OFF", 0},
    {"ANTI-ICE", "AS REQUIRED", 0},
    {"APU", "START", 0},
    {"BRAKE TEMP", "CHECK", 0},
    {"TRANSPONDER", "OFF", 0},
    {"Taxi to Assigned Gate / Parking", 0},
    {"APU", "START / CHECK RUN", 0},
    {"APU", "GEN ON / CHECK VOLTS", 0},
    {"TAXI LIGHTS", "OFF", 0}
}

local shutdown_checklist = {
    {"PARKING BRAKES", "SET", 0},
    {"THRUST LEVERS", "IDLE", 0},
    {"GROUND CONTACT", "ESTABLISH", 0},
    {"ELECTRICAL POWER", "ESTABLISH", 0},
    {"ENGINE MASTER 1", "OFF", 0},
    {"ENGINE MASTER 2", "OFF", 0},
    {"NAV LIGHTS", "OFF", 0},
    {"EXTERIOR LIGHTS", "AS REQUIRED", 0},
    {"ANTI-ICE", "OFF", 0},
    {"PASSENGER SIGNS", "OFF", 0},
    {"DOORS", "OPEN", 0},
    {"F/D", "OFF", 0},
    {"APU BLEED", "AS REQUIRED", 0},
    {"FUEL PUMPS", "ALL OFF", 0},
    {"BEACON", "OFF", 0},
    {"ECAM STS", "DEPRESS", 0},
    {"PANEL LIGHTS", "OFF", 0},
    {"ADIRS", "OFF", 0},
    {"AVIONICS", "OFF", 0},
    {"NO SMOKING", "OFF", 0},
    {"APU", "AS REQUIRED", 0},
    {"BATTERIES", "AS REQUIRED", 0}
}


local full_checklist = {
    pre_start_checklist,
    startup_checklist,
    before_taxi_checklist,
    before_takeoff_checklist,
    climb_out_checklist,
    cruise_checklist,
    approach_checklist,
    landing_checklist,
    after_landing_checklist,
    shutdown_checklist
}

function getFullChecklist()
    return full_checklist
end

function getChecklistPart(part)
    if part <= table.getn(full_checklist) then
        return full_checklist[part]
    end
end

function getChecklistItem(checklist, index)
    return full_checklist[checklist][index]
end

function tick(checklist, item)
    print("changing value for ", full_checklist[checklist][item][1])
    if full_checklist[checklist][item][3] == 0 then
        full_checklist[checklist][item][3] = 1
    else
        full_checklist[checklist][item][3] = 0
    end
end