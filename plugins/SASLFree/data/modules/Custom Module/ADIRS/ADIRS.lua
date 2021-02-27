local pilot_latitude = globalProperty("sim/flightmodel/position/latitude")
local pilot_longitude = globalProperty("sim/flightmodel/position/longitude")
local pilot_heading = globalProperty("sim/cockpit/gyros/psi_ind_ahars_pilot_degm")
local pilot_groundspeed = globalProperty("sim/flightmodel/position/groundspeed")
local pilot_pitch = globalProperty("sim/cockpit/gyros/the_ind_ahars_pilot_deg")
local pilot_roll = globalProperty("sim/cockpit/gyros/phi_ind_ahars_pilot_deg")

local pilot_altitude = globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
local pilot_tas = globalProperty("sim/cockpit2/gauges/indicators/true_airspeed_kts_pilot")
local pilot_ias = globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
local pilot_mach = globalProperty("sim/cockpit2/gauges/indicators/mach_pilot")
local pilot_aoa = globalProperty("sim/flightmodel2/misc/AoA_angle_degrees")
local pilot_tat = globalProperty("sim/cockpit2/temperature/outside_air_LE_temp_degc")
local pilot_sat = globalProperty("sim/cockpit2/temperature/outside_air_temp_degc")


local copilot_latitude = globalProperty("sim/flightmodel/position/latitude")
local copilot_longitude = globalProperty("sim/flightmodel/position/longitude")
local copilot_heading = globalProperty("sim/cockpit/gyros/psi_ind_ahars_copilot_degm")
local copilot_groundspeed = globalProperty("sim/flightmodel/position/groundspeed")
local copilot_pitch = globalProperty("sim/cockpit/gyros/the_ind_ahars_copilot_deg")
local copilot_roll = globalProperty("sim/cockpit/gyros/phi_ind_ahars_copilot_deg")

local copilot_altitude = globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_copilot")
local copilot_tas = globalProperty("sim/cockpit2/gauges/indicators/true_airspeed_kts_copilot")
local copilot_ias = globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_copilot")
local copilot_mach = globalProperty("sim/cockpit2/gauges/indicators/mach_copilot")
local copilot_aoa = globalProperty("sim/flightmodel2/misc/AoA_angle_degrees")
local copilot_tat = globalProperty("sim/cockpit2/temperature/outside_air_LE_temp_degc")
local copilot_sat = globalProperty("sim/cockpit2/temperature/outside_air_temp_degc")

adirs ={
    adirs_1 = {
        mode = createGlobalPropertyi("A318/systems/ADIRS/1/mode", 0), -- mode switch
        aligned = createGlobalPropertyi("A318/systems/ADIRS/1/aligned", 0), -- is aligned
        inertial = {
            latitude = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/latitude", 0.0),
            longitude = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/longitude", 0.0),
            heading = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/heading", 0.0),
            groundspeed = createGlobalPropertyi("A318/systems/ADIRS/1/inertial/gs", 0),
            pitch = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/pitch", 0.0),
            roll = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/roll", 0.0),
        },
        airdata = {
            altitude = createGlobalPropertyi("A318/systems/ADIRS/1/air/altitude", 0),
            tas = createGlobalPropertyi("A318/systems/ADIRS/1/air/tas", 0),
            ias = createGlobalPropertyi("A318/systems/ADIRS/1/air/ias", 0),
            mach = createGlobalPropertyf("A318/systems/ADIRS/1/air/mach", 0.0),
            angleOfAttack = createGlobalPropertyf("A318/systems/ADIRS/1/air/aoa", 0.0),
            tat = createGlobalPropertyi("A318/systems/ADIRS/1/air/tat", 0),
            sat = createGlobalPropertyi("A318/systems/ADIRS/1/air/sat", 0),
        }
    },
    adirs_2 = {
        mode = createGlobalPropertyi("A318/systems/ADIRS/2/mode", 0), -- mode switch
        aligned = createGlobalPropertyi("A318/systems/ADIRS/2/aligned", 0),
        inertial = {
            latitude = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/latitude", 0.0),
            longitude = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/longitude", 0.0),
            heading = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/heading", 0.0),
            groundspeed = createGlobalPropertyi("A318/systems/ADIRS/2/inertial/gs", 0),
            pitch = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/pitch", 0.0),
            roll = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/roll", 0.0),
        },
        airdata = {
            altitude = createGlobalPropertyi("A318/systems/ADIRS/2/air/altitude", 0),
            tas = createGlobalPropertyi("A318/systems/ADIRS/2/air/tas", 0),
            ias = createGlobalPropertyi("A318/systems/ADIRS/2/air/ias", 0),
            mach = createGlobalPropertyf("A318/systems/ADIRS/2/air/mach", 0.0),
            angleOfAttack = createGlobalPropertyf("A318/systems/ADIRS/2/air/aoa", 0.0),
            tat = createGlobalPropertyi("A318/systems/ADIRS/2/air/tat", 0),
            sat = createGlobalPropertyi("A318/systems/ADIRS/2/air/sat", 0),
        }
    },
    adirs_3 = {
        mode = createGlobalPropertyi("A318/systems/ADIRS/3/mode", 0), -- mode switch
        aligned = createGlobalPropertyi("A318/systems/ADIRS/3/aligned", 0),
        inertial = {
            latitude = createGlobalPropertyi("A318/systems/ADIRS/3/inertial/latitude", 0),
            longitude = createGlobalPropertyi("A318/systems/ADIRS/3/inertial/longitude", 0),
            heading = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/heading", 0.0),
            groundspeed = createGlobalPropertyi("A318/systems/ADIRS/3/inertial/gs", 0),
            pitch = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/pitch", 0.0),
            roll = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/roll", 0.0),
        },
        airdata = {
            altitude = createGlobalPropertyi("A318/systems/ADIRS/3/air/altitude", 0),
            tas = createGlobalPropertyi("A318/systems/ADIRS/3/air/tas", 0),
            ias = createGlobalPropertyi("A318/systems/ADIRS/3/air/ias", 0),
            mach = createGlobalPropertyi("A318/systems/ADIRS/3/air/mach", 0),
            angleOfAttack = createGlobalPropertyi("A318/systems/ADIRS/3/air/aoa", 0),
            tat = createGlobalPropertyi("A318/systems/ADIRS/3/air/tat", 0),
            sat = createGlobalPropertyi("A318/systems/ADIRS/3/air/sat", 0),
        }
    },
}

function ADIRS1()
    local mode = adirs.adirs_1.mode
    local isAligned = adirs.adirs_1.aligned

    local airData = get(adirs.adirs_1.airdata)
    local InertialData = get(adirs.adirs_1.inertial)

    if get(isAligned) == 0  and get(mode) > 0 then -- on and aligning

    elseif get(isAligned) == 1 and get(mode) == 1 then -- on and aligned
        -- inertial data
        set(InertialData.latitude, get(pilot_latitude))
        set(InertialData.longitude, get(pilot_longitude))
        set(InertialData.heading, get(pilot_heading))
        set(InertialData.groundspeed, math.floor(get(pilot_groundspeed) + 0.5))
        set(InertialData.pitch, get(pilot_pitch))
        set(InertialData.roll, get(pilot_roll))

        -- air data
        set(airData.altitude, math.floor(get(pilot_altitude) + 0.5))
        set(airData.tas, math.floor(get(pilot_tas) + 0.5))
        set(airData.ias, math.floor(get(pilot_ias) + 0.5))
        set(airData.mach, get(pilot_mach))
        set(airData.aoa, get(pilot_aoa))
        set(airData.tat, math.floor(get(pilot_tat) + 0.5))
        set(airData.sat, math.floor(get(pilot_sat) + 0.5))

    elseif get(mode) == 0 then -- off
        set(isAligned, 0)
        -- inertial data
        set(InertialData.latitude, 0.0)
        set(InertialData.longitude, 0.0)
        set(InertialData.heading, 0)
        set(InertialData.groundspeed, 0)
        set(InertialData.pitch, 0.0)
        set(InertialData.roll, 0.0)

        -- air data
        set(airData.altitude, 0)
        set(airData.tas, 0)
        set(airData.ias, 0)
        set(airData.mach, 0.0)
        set(airData.aoa, 0.0)
        set(airData.tat, 0)
        set(airData.sat, 0)
    end
end

function ADIRS2()
    local mode = adirs.adirs_2.mode
    local isAligned = adirs.adirs_2.aligned

    local airData = get(adirs.adirs_2.airdata)
    local InertialData = get(adirs.adirs_2.inertial)

    if get(isAligned) == 0  and get(mode) > 0 then -- on and aligning

    elseif get(isAligned) == 1 and get(mode) == 1 then -- on and aligned
        -- inertial data
        set(InertialData.latitude, get(copilot_latitude))
        set(InertialData.longitude, get(copilot_longitude))
        set(InertialData.heading, get(copilot_heading))
        set(InertialData.groundspeed, math.floor(get(copilot_groundspeed) + 0.5))
        set(InertialData.pitch, get(copilot_pitch))
        set(InertialData.roll, get(copilot_roll))

        -- air data
        set(airData.altitude, math.floor(get(copilot_altitude) + 0.5))
        set(airData.tas, math.floor(get(copilot_tas) + 0.5))
        set(airData.ias, math.floor(get(copilot_ias) + 0.5))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))

    elseif get(mode) == 0 then -- off
        set(isAligned, 0)
        -- inertial data
        set(InertialData.latitude, 0.0)
        set(InertialData.longitude, 0.0)
        set(InertialData.heading, 0)
        set(InertialData.groundspeed, 0)
        set(InertialData.pitch, 0.0)
        set(InertialData.roll, 0.0)

        -- air data
        set(airData.altitude, 0)
        set(airData.tas, 0)
        set(airData.ias, 0)
        set(airData.mach, 0.0)
        set(airData.aoa, 0.0)
        set(airData.tat, 0)
        set(airData.sat, 0)
    end
end

function ADIRS3()
    local mode = adirs.adirs_3.mode
    local isAligned = adirs.adirs_3.aligned

    local airData = get(adirs.adirs_3.airdata)
    local InertialData = get(adirs.adirs_3.inertial)

    if get(isAligned) == 0  and get(mode) > 0 then -- on and aligning

    elseif get(isAligned) == 1 and get(mode) == 1 then -- on and aligned
        -- inertial data
        set(InertialData.latitude, get(copilot_latitude))
        set(InertialData.longitude, get(copilot_longitude))
        set(InertialData.heading, get(copilot_heading))
        set(InertialData.groundspeed, math.floor(get(copilot_groundspeed) + 0.5))
        set(InertialData.pitch, get(copilot_pitch))
        set(InertialData.roll, get(copilot_roll))

        -- air data
        set(airData.altitude, math.floor(get(copilot_altitude) + 0.5))
        set(airData.tas, math.floor(get(copilot_tas) + 0.5))
        set(airData.ias, math.floor(get(copilot_ias) + 0.5))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))

    elseif get(mode) == 0 then -- off
        set(isAligned, 0)
        -- inertial data
        set(InertialData.latitude, 0.0)
        set(InertialData.longitude, 0.0)
        set(InertialData.heading, 0)
        set(InertialData.groundspeed, 0)
        set(InertialData.pitch, 0.0)
        set(InertialData.roll, 0.0)

        -- air data
        set(airData.altitude, 0)
        set(airData.tas, 0)
        set(airData.ias, 0)
        set(airData.mach, 0.0)
        set(airData.aoa, 0.0)
        set(airData.tat, 0)
        set(airData.sat, 0)
    end
end

function draw()
    ADIRS1()
    ADIRS2()
    ADIRS3()
end