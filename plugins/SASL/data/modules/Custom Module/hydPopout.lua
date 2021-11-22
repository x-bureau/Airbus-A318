-- position = {1170, 50, 522, 522}
-- size = {522, 522}
require "common_declarations"

local overlay = sasl.gl.loadImage("a320-hyd-fuel-popout.png")--defining the page overlay
local rat_pb = sasl.findCommand("A318/systems/hyd/pbs/rat")
local ptu_pb = sasl.findCommand("A318/systems/hyd/pbs/ptu")
local eng1_pb = sasl.findCommand("A318/systems/hyd/pbs/green/eng1_pump")
local eng2_pb = sasl.findCommand("A318/systems/hyd/pbs/yellow/eng2_pump")
local elec_pb = sasl.findCommand("A318/systems/hyd/pbs/yellow/elec_pump")
local blue_pb = sasl.findCommand("A318/systems/hyd/pbs/blue/elec_pump")


function update()
end

function draw()
    sasl.gl.drawTexture(overlay, 0, 0, 768, 300)--we are drawing the overlay
    sasl.gl.saveInternalLineState()
    sasl.gl.setInternalLineWidth(3)

    sasl.gl.drawFrame(133, 152, 50, 50, ECAM_COLOURS.WHITE) --draw GREEN ENG 1 PUMP switch
    sasl.gl.drawFrame(243, 152, 50, 50, ECAM_COLOURS.WHITE) --draw RAT switch
    sasl.gl.drawFrame(360, 152, 50, 50, ECAM_COLOURS.WHITE) --draw BLUE ELEC PUMP switch
    sasl.gl.drawFrame(470, 202, 50, 50, ECAM_COLOURS.WHITE) --draw PTU switch
    sasl.gl.drawFrame(585, 152, 50, 50, ECAM_COLOURS.WHITE) --draw YELLOW ENG 2 PUMP switch
    sasl.gl.drawFrame(664, 169, 50, 50, ECAM_COLOURS.WHITE) --draw YELLOW ELEC PUMP switch

    sasl.gl.restoreInternalLineState()
end

function onMouseDown(component, x, y, button, parentX, parentY)
    if button == MB_LEFT then
        if x > 133 and x < 133+50 and y > 152 and y < 152+50 then
            sasl.commandBegin(eng1_pb)
            sasl.commandEnd(eng1_pb)
        elseif x > 243 and x < 243+50 and y > 152 and y < 152+50 then
            sasl.commandBegin(rat_pb)
            sasl.commandEnd(rat_pb)
        elseif x > 360 and x < 360+50 and y > 152 and y < 152+50 then
            sasl.commandBegin(blue_pb)
            sasl.commandEnd(blue_pb)
        elseif x > 470 and x < 470+50 and y > 202 and y < 202+50 then
            sasl.commandBegin(ptu_pb)
            sasl.commandEnd(ptu_pb)
        elseif x > 585 and x < 585+50 and y > 152 and y < 152+50 then
            sasl.commandBegin(eng2_pb)
            sasl.commandEnd(eng2_pb)
        elseif x > 664 and x < 664+50 and y > 169 and y < 169+50 then
            sasl.commandBegin(elec_pb)
            sasl.commandEnd(elec_pb)
        end
    end
    return true
end

