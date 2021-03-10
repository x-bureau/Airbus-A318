local pre_start_checklist = {
    {"PARKING BRAKE", "SET"},
    {"CHOCKS", "REMOVE"},
    {"GPU", "CONNECTED"},
    {"THROTTLE", "LEVERS IDLE"},
    {"ENGINE MASTERS", "OFF"},
    {"BATTERIES", "ON"},
    {"GENERATOR SWITCHES", "ON"},
    {"EXT POWER", "ON"},
    {"ADIRS", "ON"},
    {"PANEL DISPLAYS", "BRIGHTNESS SET"},
    {"NAV LIGHTS", "ON"},
    {"PANEL LIGHTS", "AS REQUIRED"},
    {"GEAR LEVER", "DOWN"},
    {"FLAPS", "UP"},
    {"SPOILER", "RETRACTED"},
    {"FUEL QUANTITY", "CHECK"},
    {"FASTEN SEATBELTS", "ON"},
    {"NO SMOKING SIGNS", "ON"},
    {"Check Weather(ATIS, Flight Services)"},
    {"TRANSPONDER", "SET, STANDBY"},
    {"BEACON LIGHTS", "ON"},
    {"FMC", "SETUP", "CHECK"},
    {"DEPARTURE BRIEFING", "COMPLETE"},
    {"DOORS", "CLOSED"}
}

local startup_checklist = {
    {"APU", "START"},
    {"APU BLEED", "RUN (WHEN AVAIL)"},
    {"APU GEN", "ON"},
    {"Request Pushback - Initiate Pushback"},
    {"THRUST LEVERS", "IDLE"},
    {"ENGINE AREA", "CLEAR"},
    {"FUEL PUMPS", "ON"},
    {"MODE SELECTOR", "IGN / START"},
    {"ENGINE MASTER 1", "START"},
    {"AT N2 > 20% FUEL FLOW", "CHECK"},
    {"ENGINE MASTER 2", "START"},
    {"AT N2 > 20% FUEL FLOW", "CHECK"},
    {"FUEL FLOW", "CHECK"},
    {"HYDRAULIC PUMP SWITCHES", "ON"},
    {"APU", "OFF"},
    {"MODE SELECTOR", "NORM"}
}

local before_taxi_checklist = {
    {"PROBE/WINDOW HEAT", "AUTO"},
    {"HDG INDICATOR / ALTIMETERS", "SET"},
    {"STDBY INSTRUMENTS", "SET"},
    {"RADIOS AND AVIONICS", "SET FOR DEPARTURE"},
    {"AUTOPILOT", "SET, don't activate"},
    {"F/D", "ON"},
    {"AUTOBRAKE", "MAX"},
    {"FLAPS", "SET"},
    {"TRIM", "SET"},
    {"FLIGHT CONTROLS", "CHECK"}
}


local full_checklist = {
    pre_start_checklist,
    startup_checklist,
    before_taxi_checklist
}

function getFullChecklist()
    return full_checklist
end

function getChecklistPart(part)
    if part <= table.getn(full_checklist) then
        return full_checklist[part]
    end
end