------------------------------------------------------------------------
--Airbus A318 By X-Bureau--
--CONTRIBUITORS:
--FBI914
------------------------------------------------------------------------
--Defining the Hydraulic System Components
------------------------------------------------------------------------
local timer = 0 --Defining a TIMER to be used with the pumps

--TIMER FUNCTION
--This function counts up and when it reaches a certain threshold it will trigger an event
while timer < 120 do
    timer = timer + 1
end

--Defining three INDEPENDENT hyd systems, blue, green, and yellow
local hyd.blue = 0
local hyd.green = 0
local hyd.yellow = 0

local NmlOpPress = 3000 --The NORMAL OPERATION TEMPERATURE is 3000 psi

local HydPumpYellow --The YELLOW hydraulic pump
local HydPumpGreen --The GREEN hydraulic pump
local HydPumpBlue --The BLUE hydraulic pump
local HydPumpBlue.isRunning = false --Determine if the BLUE HYDRAULIC PUMP is running

local PTU = false --Defining the variable for the POWER TRANSFER UNIT (PTU)
local PTU.transferToGreen = false --Determine whether the PTU is tranferring pressure to the GREEN SYSTEM
local PTU.transferToYellow = false --Determine whether the PTU is transferring pressure to the YELLOW SYSTEM

local FireShutOffGreen = false --Defining the FIRE SHUT OFF VALVE for the GREEN system
local FireShutOffYellow = false --Defining the FIRE SHUT OFF VALVE for the YELLOW system

local RAT = 2500 --The RAM AIR TURBINE (RAT) powers the BLUE system in an emergency at 2500 psi
local Rat.isExtended = true --Determining whether the Ram Air Turbine (RAT) is extended
local Rat.canRetract = false --Determining whether the Ram Air Turbine (RAT) is able to retract

local N1Percent = globalPropertyfa("sim/cockpit2/engine/indicators/N1_percent", 7) --Get the N1 percent of the engines

local isOnGround = globalPropertyi("sim/flightmodel/failures/onground_any") --If the user is on the ground, this dataref is set to 1

local RatPB = createGlobalPropertyi("A318/hydraulics/RAT/rat_extend_pb", 0)--1 = pushed, 0 = default

local PtuAutoTransfer = 500 --The threshold at which the PTU begins to automatically transfer power is a 500 psi difference.
----------------------------------------------------------------------------------
--LOGIC TIME!
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--Ram Air Turbine (RAT) Logic
----------------------------------------------------------------------------------
--If the Aircraft is on the ground, then the RAT can retract.
if get(isOnGround) == 1 then
	set(Rat.canRetract) == true
else
	set(Rat.canRetract) == false and set(Rat.isExtended) == true
end

--If the Aircraft is on the ground, then the RAT can be deployed manually
if get(isOnGround) == 1 and get(RatPB) == 1 then
	set(Rat.isExtended) == true
elseif get(isOnGround) == 0 and get(RatPB) == 1 then
	set(Rat.canRetract) == false
end

--If the Ram Air Turbine (RAT) cannot retract, then it will continue in the extended position
if get(Rat.canRetract) == false then
    set(Rat.isExtended) == true
end

--If the BLUE PUMP fails, then use the Ram Air Turbine (RAT) to power the BLUE SYSTEM
if get(HydPumpBlue) == 0 and Rat.isExtended == true then
    set(HydPumpBlue) == RAT
end
----------------------------------------------------------------------------------
--Power Transfer Unit (PTU) Logic
----------------------------------------------------------------------------------
--Automatically activating the PTU when it reaches the 500 psi difference threshold
if get(hyd.green) - get(hyd.yellow) >= 500 and get(FireShutOffYellow) == false then --If the GREEN SYSTEM - the YELLOW SYSTEM is = or > than 500, then activate the Power Transfer Unit (PTU)
    set(PTU) == true
    set(PTU.transferToYellow) = true 
elseif get(hyd.yellow) - get(hyd.green) >= 500 and get(FireShutOffGreen) == false then --If the YELLOW SYSTEM - the GREEN SYSTEM is = or > than 500, then activate the Power Transfer Unit (PTU)
    set(PTU) == true
    set(PTU.transferToGreen) = true
else
    set(PTU) == false
end

--Logic to determine how much pressure to transfer to the other system
if get(PTU) == true and get(FireShutOffYellow) == false and get(hyd.green) > (hyd.yellow) then
    set(hyd.yellow) = hyd.yellow + ((get(hyd.green) - get(hyd.yellow)) / 2) 
    set(PTU.transferToYellow) = true
    while PTU == true and get(hyd.green) < NmlOpPress do --While the PTU is active and the GREEN SYSTEM is less than 3000 psi, add to it until it once again meets that threshold
        hyd.green = hyd.green + 1
    end
    if get(hyd.yellow) == 3000 and get(hyd.green) == 3000 then --If both the GREEN and YELLOW systems once again meet the threshold, turn off the PTU.
        set(PTU) = false
        set(PTU.transferToGreen) = false
    end
elseif get(PTU) == true and get(FireShutOffGreen) == false and get(hyd.yellow) > get(hyd.green) then
    set(hyd.green) = hyd.green + ((get(hyd.yellow) - get(hyd.green)) / 2)
    set(PTU.transferToYellow) = true
    while PTU == true and get(hyd.yellow) < NmlOpPress do --While the PTU is active and the YELLOW SYSTEM is less than 3000 psi, add to it until it once again meets that threshold
        hyd.yellow = hyd.yellow + 1
    end
    if get(hyd.yellow) == 3000 and get(hyd.green) == 3000 then --If both the GREEN and YELLOW systems once again meet the threshold, turn off the PTU.
        set(PTU) = false
        set(PTU.transferToYellow) = false
    end
end
----------------------------------------------------------------------------------
--PUMP LOGIC
----------------------------------------------------------------------------------
--If an engine is running, then the BLUE PUMP can start
if get(N1Percent, 1) > 0 or get(N1Percent, 2) > 0 then
    set(HydPumpBlue.isRunning) = true
else
    set(HydPumpBlue.isRunning) = false
end

--Logic for the GREEN SYSTEM PUMP
if get(FireShutOffGreen) == false and get(hyd.green) < 3000 and get(PTU.transferToGreen) == false then
    while get(hyd.green) < 3000
        if get(timer) == 120
            hyd.green = hyd.green + 10
            set(timer) = 0
        end
    end
end

--Logic for the YELLOW SYSTEM PUMP
if get(FireShutOffYellow) == false and get(hyd.yellow) < 3000 and get(PTU.transferToYellow) == false then
    while get(hyd.yellow) < 3000
        if get(timer) == 120
            hyd.yellow = hyd.yellow + 10
            set(timer) = 0
        end
    end
end
----------------------------------------------------------------------------------
--TODO: WRITE THE LOGIC FOR THE FIRE SHUT OFF
----------------------------------------------------------------------------------

