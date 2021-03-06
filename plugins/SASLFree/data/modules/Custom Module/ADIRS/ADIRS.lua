local startup_complete = false
local eng1N1 = globalProperty("sim/flightmodel/engine/ENGN_N1_[0]")

local onGround = globalProperty("sim/flightmodel/failures/onground_any")
local GS = globalProperty("sim/flightmodel/position/groundspeed")

local AC_1 = globalProperty("A318/systems/ELEC/AC1_V")
local AC_2 = globalProperty("A318/systems/ELEC/AC2_V")
local AC_ESS = globalProperty("A318/systems/ELEC/ACESS_V")

local pilot_latitude = globalProperty("sim/flightmodel/position/latitude")
local pilot_longitude = globalProperty("sim/flightmodel/position/longitude")
local pilot_heading = globalProperty("sim/cockpit/gyros/psi_ind_ahars_pilot_degm")
local pilot_groundspeed = globalProperty("sim/cockpit2/radios/indicators/gps_dme_speed_kts")
local pilot_track = globalProperty("sim/cockpit2/gauges/indicators/ground_track_mag_pilot")
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
local copilot_groundspeed = globalProperty("sim/cockpit2/radios/indicators/gps_dme_speed_kts")
local copilot_track = globalProperty("sim/cockpit2/gauges/indicators/ground_track_mag_copilot")
local copilot_pitch = globalProperty("sim/cockpit/gyros/the_ind_ahars_copilot_deg")
local copilot_roll = globalProperty("sim/cockpit/gyros/phi_ind_ahars_copilot_deg")

local copilot_altitude = globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_copilot")
local copilot_tas = globalProperty("sim/cockpit2/gauges/indicators/true_airspeed_kts_copilot")
local copilot_ias = globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_copilot")
local copilot_mach = globalProperty("sim/cockpit2/gauges/indicators/mach_copilot")
local copilot_aoa = globalProperty("sim/flightmodel2/misc/AoA_angle_degrees")
local copilot_tat = globalProperty("sim/cockpit2/temperature/outside_air_LE_temp_degc")
local copilot_sat = globalProperty("sim/cockpit2/temperature/outside_air_temp_degc")

local Timer1 = 0
local TimerFinal1 = 60

local Timer2 = 0
local TimerFinal2 = 60

local Timer3 = 0
local TimerFinal3 = 60

local DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")

adirs = {
    adirs_1 = {
        mode = createGlobalPropertyi("A318/systems/ADIRS/1/mode", 0), -- mode switch
        aligned = createGlobalPropertyi("A318/systems/ADIRS/1/aligned", 0), -- is aligned
        inertial = {
            latitude = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/latitude", 0.0),
            longitude = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/longitude", 0.0),
            heading = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/heading", 0.0),
            track = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/track", 0.0),
            groundspeed = createGlobalPropertyi("A318/systems/ADIRS/1/inertial/gs", 0),
            pitch = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/pitch", 0.0),
            roll = createGlobalPropertyf("A318/systems/ADIRS/1/inertial/roll", 0.0),
        },
        airdata = {
            altitude = createGlobalPropertyf("A318/systems/ADIRS/1/air/altitude", 0.0),
            tas = createGlobalPropertyf("A318/systems/ADIRS/1/air/tas", 0.0),
            ias = createGlobalPropertyf("A318/systems/ADIRS/1/air/ias", 0.0),
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
            track = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/track", 0.0),
            groundspeed = createGlobalPropertyi("A318/systems/ADIRS/2/inertial/gs", 0),
            pitch = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/pitch", 0.0),
            roll = createGlobalPropertyf("A318/systems/ADIRS/2/inertial/roll", 0.0),
        },
        airdata = {
            altitude = createGlobalPropertyf("A318/systems/ADIRS/2/air/altitude", 0.0),
            tas = createGlobalPropertyf("A318/systems/ADIRS/2/air/tas", 0.0),
            ias = createGlobalPropertyf("A318/systems/ADIRS/2/air/ias", 0.0),
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
            latitude = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/latitude", 0.0),
            longitude = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/longitude", 0.0),
            heading = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/heading", 0.0),
            track = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/track", 0.0),
            groundspeed = createGlobalPropertyi("A318/systems/ADIRS/3/inertial/gs", 0),
            pitch = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/pitch", 0.0),
            roll = createGlobalPropertyf("A318/systems/ADIRS/3/inertial/roll", 0.0),
        },
        airdata = {
            altitude = createGlobalPropertyf("A318/systems/ADIRS/3/air/altitude", 0.0),
            tas = createGlobalPropertyf("A318/systems/ADIRS/3/air/tas", 0.0),
            ias = createGlobalPropertyf("A318/systems/ADIRS/3/air/ias", 0.0),
            mach = createGlobalPropertyf("A318/systems/ADIRS/3/air/mach", 0.0),
            angleOfAttack = createGlobalPropertyf("A318/systems/ADIRS/3/air/aoa", 0.0),
            tat = createGlobalPropertyi("A318/systems/ADIRS/3/air/tat", 0),
            sat = createGlobalPropertyi("A318/systems/ADIRS/3/air/sat", 0),
        }
    },
}

function plane_startup()
    if get(eng1N1) > 1 then
        -- engines running
        print("Starting with engines running")
        set(adirs.adirs_1.mode, 1)
        set(adirs.adirs_1.aligned, 1)
        set(adirs.adirs_2.mode, 1)
        set(adirs.adirs_2.aligned, 1)
        set(adirs.adirs_3.mode, 1)
        set(adirs.adirs_3.aligned, 1)
    else
        -- cold and dark
        print("Starting cold and dark")
        set(adirs.adirs_1.mode, 0)
        set(adirs.adirs_1.aligned, 0)
        set(adirs.adirs_2.mode, 0)
        set(adirs.adirs_2.aligned, 0)
        set(adirs.adirs_3.mode, 0)
        set(adirs.adirs_3.aligned, 0)
    end
end

function ADIRS1()
    local mode = adirs.adirs_1.mode
    local isAligned = adirs.adirs_1.aligned

    local airData = get(adirs.adirs_1.airdata)
    local InertialData = get(adirs.adirs_1.inertial)

    if get(isAligned) == 0 and get(mode) == 1 and get(onGround) == 1 and get(GS) < 1 then -- on and aligning
        if Timer1 < TimerFinal1 then
            Timer1 = Timer1 + 1 * get(DELTA_TIME)
          else
            Timer1 = 0
            set(isAligned, 1)
          end
        -- air data
        set(airData.altitude, get(pilot_altitude))
        set(airData.tas, get(pilot_tas))
        set(airData.ias, get(pilot_ias))
        set(airData.mach, get(pilot_mach))
        set(airData.aoa, get(pilot_aoa))
        set(airData.tat, math.floor(get(pilot_tat) + 0.5))
        set(airData.sat, math.floor(get(pilot_sat) + 0.5))
    elseif get(isAligned) == 1 and get(mode) == 1 then -- on and aligned
        Timer1 = 0

        -- inertial data
        set(InertialData.latitude, get(pilot_latitude))
        set(InertialData.longitude, get(pilot_longitude))
        set(InertialData.heading, get(pilot_heading))
        set(InertialData.groundspeed, math.floor(get(pilot_groundspeed) + 0.5))
        set(InertialData.track, get(pilot_track))
        set(InertialData.pitch, get(pilot_pitch))
        set(InertialData.roll, get(pilot_roll))

        -- air data
        set(airData.altitude, get(pilot_altitude))
        set(airData.tas, get(pilot_tas))
        set(airData.ias, get(pilot_ias))
        set(airData.mach, get(pilot_mach))
        set(airData.aoa, get(pilot_aoa))
        set(airData.tat, math.floor(get(pilot_tat) + 0.5))
        set(airData.sat, math.floor(get(pilot_sat) + 0.5))

    elseif get(mode) == 2 then -- ATT mode
        Timer1 = 0

        -- inertial data
        set(InertialData.pitch, get(pilot_pitch))
        set(InertialData.roll, get(pilot_roll))

        -- air data
        set(airData.altitude, get(pilot_altitude))
        set(airData.tas, get(pilot_tas))
        set(airData.ias, get(pilot_ias))
        set(airData.mach, get(pilot_mach))
        set(airData.aoa, get(pilot_aoa))
        set(airData.tat, math.floor(get(pilot_tat) + 0.5))
        set(airData.sat, math.floor(get(pilot_sat) + 0.5))
    elseif get(mode) == 0 then -- off
        Timer1 = 0

        set(isAligned, 0)
        -- inertial data
        set(InertialData.latitude, 0.0)
        set(InertialData.longitude, 0.0)
        set(InertialData.heading, 0)
        set(InertialData.groundspeed, 0)
        set(InertialData.track, 0.0)
        set(InertialData.pitch, 0.0)
        set(InertialData.roll, 0.0)

        -- air data
        set(airData.altitude, 0.0)
        set(airData.tas, 0.0)
        set(airData.ias, 0.0)
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

    if get(isAligned) == 0  and get(mode) == 1 and get(onGround) == 1 and get(GS) < 1 then -- on and aligning
        if Timer2 < TimerFinal2 then
            Timer2 = Timer2 + 1 * get(DELTA_TIME)
        else
            Timer2 = 0
            set(isAligned, 1)
        end

        -- air data
        set(airData.altitude, get(copilot_altitude))
        set(airData.tas, get(copilot_tas))
        set(airData.ias, get(copilot_ias))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))
    elseif get(isAligned) == 1 and get(mode) == 1 then -- on and aligned
        Timer2 = 0
        -- inertial data
        set(InertialData.latitude, get(copilot_latitude))
        set(InertialData.longitude, get(copilot_longitude))
        set(InertialData.heading, get(copilot_heading))
        set(InertialData.groundspeed, math.floor(get(copilot_groundspeed) + 0.5))
        set(InertialData.track, get(copilot_track))
        set(InertialData.pitch, get(copilot_pitch))
        set(InertialData.roll, get(copilot_roll))

        -- air data
        set(airData.altitude, get(copilot_altitude))
        set(airData.tas, get(copilot_tas))
        set(airData.ias, get(copilot_ias))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))

    elseif get(mode) == 2 then -- ATT mode
        Timer2 = 0
        -- inertial data
        set(InertialData.pitch, get(copilot_pitch))
        set(InertialData.roll, get(copilot_roll))

        -- air data
        set(airData.altitude, get(copilot_altitude))
        set(airData.tas, get(copilot_tas))
        set(airData.ias, get(copilot_ias))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))

    elseif get(mode) == 0 then -- off
        Timer2 = 0
        set(isAligned, 0)
        -- inertial data
        set(InertialData.latitude, 0.0)
        set(InertialData.longitude, 0.0)
        set(InertialData.heading, 0)
        set(InertialData.groundspeed, 0)
        set(InertialData.track, 0.0)
        set(InertialData.pitch, 0.0)
        set(InertialData.roll, 0.0)

        -- air data
        set(airData.altitude, 0.0)
        set(airData.tas, 0.0)
        set(airData.ias, 0.0)
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

    if get(isAligned) == 0  and get(mode) == 1 and get(onGround) == 1 and get(GS) < 1 then -- on and aligning
        if Timer3 < TimerFinal3 then
            Timer3 = Timer3 + 1 * get(DELTA_TIME)
        else
            Timer3 = 0
            set(isAligned, 1)
        end

        -- air data
        set(airData.altitude, get(copilot_altitude))
        set(airData.tas, get(copilot_tas))
        set(airData.ias, get(copilot_ias))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))
    elseif get(isAligned) == 1 and get(mode) == 1 then -- on and aligned
        Timer3 = 0

        -- inertial data
        set(InertialData.latitude, get(copilot_latitude))
        set(InertialData.longitude, get(copilot_longitude))
        set(InertialData.heading, get(copilot_heading))
        set(InertialData.groundspeed, math.floor(get(copilot_groundspeed) + 0.5))
        set(InertialData.track, get(copilot_track))
        set(InertialData.pitch, get(copilot_pitch))
        set(InertialData.roll, get(copilot_roll))

        -- air data
        set(airData.altitude, get(copilot_altitude))
        set(airData.tas, get(copilot_tas))
        set(airData.ias, get(copilot_ias))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))

    elseif get(mode) == 2 then -- ATT mode
        Timer2 = 0
        -- inertial data
        set(InertialData.pitch, get(copilot_pitch))
        set(InertialData.roll, get(copilot_roll))

        -- air data
        set(airData.altitude, get(copilot_altitude))
        set(airData.tas, get(copilot_tas))
        set(airData.ias, get(copilot_ias))
        set(airData.mach, get(copilot_mach))
        set(airData.aoa, get(copilot_aoa))
        set(airData.tat, math.floor(get(copilot_tat) + 0.5))
        set(airData.sat, math.floor(get(copilot_sat) + 0.5))

    elseif get(mode) == 0 then -- off
        Timer3 = 0

        set(isAligned, 0)
        -- inertial data
        set(InertialData.latitude, 0.0)
        set(InertialData.longitude, 0.0)
        set(InertialData.heading, 0)
        set(InertialData.groundspeed, 0)
        set(InertialData.track, 0.0)
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

function update()
    if not startup_complete then
        plane_startup()
        startup_complete = true
    end
    if get(AC_1) > 1 then
        ADIRS3()
    else
        set(adirs.adirs_3.aligned, 0)
    end
    if get(AC_2) > 1 then
        ADIRS2()
    else
        set(adirs.adirs_2.aligned, 0)
    end
    if get(AC_ESS) > 1 then
        ADIRS1()
    else
        set(adirs.adirs_1.aligned, 0)
    end
end
