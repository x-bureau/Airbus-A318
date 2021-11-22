require "common_declarations"
local lower_hyd_overlay = sasl.gl.loadImage("ECAM_LOWER_HYD_OVERLAY.png")
local arrow_points = {left = -1, right = 1}

local hyd = {
    green = {
        qty = globalPropertyi("A318/systems/hyd/green/qty", 145), -- qty in cl
        pressure = globalPropertyi("A318/systems/hyd/green/pressure", 0),
        temp = globalPropertyi("A318/systems/hyd/green/temp", 145), 
        shutoff_valve = {state = globalPropertyi("A318/systems/hyd/green/shutoff_valve", valve_states.open)},
        pumps = {
            engine = {state = globalPropertyi("A318/systems/hyd/green/pumps/engine/state", pump_states.low)},
        },
    },
    blue = {
        qty = globalPropertyi("A318/systems/hyd/blue/qty", 65), -- qty in cl
        pressure = globalPropertyi("A318/systems/hyd/blue/pressure", 0),
        temp = globalPropertyi("A318/systems/hyd/blue/temp", 65), 
        pumps = {
            electric = {state = globalPropertyi("A318/systems/hyd/blue/pumps/electric/state", pump_states.off)},
            rat = {state = globalPropertyi("A318/systems/hyd/blue/pumps/rat/state", pump_states.off)},
        },
    },
    yellow = {
        qty = globalPropertyi("A318/systems/hyd/yellow/qty", 125), -- qty in cl
        pressure = globalPropertyi("A318/systems/hyd/yellow/pressure", 0), -- pressure in psi
        temp = globalPropertyi("A318/systems/hyd/yellow/temp", 125), -- temp in c
        shutoff_valve = {state = globalPropertyi("A318/systems/hyd/yellow/shutoff_valve", valve_states.open)},
        pumps = {
            engine = {state = globalPropertyi("A318/systems/hyd/yellow/pumps/engine/state", pump_states.low)},
            electric = {state = globalPropertyi("A318/systems/hyd/yellow/pumps/electric/state", pump_states.off)},
        },
    },
    ptu = {
        enabled = globalPropertyi("A318/systems/hyd/ptu/enabled", enabled_states.disabled),
        state = globalPropertyi("A318/systems/hyd/ptu/state", active_states.inactive),
        xfer = {from = globalPropertys("A318/systems/hyd/ptu/from", "yellow")}
    }
}

local function round(v, bracket)
    local function sign(v)
        return (v >= 0 and 1) or -1
    end
    bracket = bracket or 1
    return math.floor(v/bracket + sign(v) * 0.5) * bracket
end

function draw_hyd_page()--draw the hyd page
    --sasl.gl.drawTexture(lower_hyd_overlay, 0, 0, 522, 522)--we are drawing the overlay

    function drawHydArrows(x, y, dir, colour, filled)
        local point = 10 * (dir or arrow_points.left)
        if filled then
            sasl.gl.drawTriangle(x,y,  x,y+14, x+point,y+7, ECAM_COLOURS.GREEN)
        else
            sasl.gl.drawWidePolyLine({x,y,  x,y+14,  x+point,y+7,  x,y}, 2.0, colour or ECAM_COLOURS.GREEN)
        end
    end

    function drawSystem(system, offset)
        local pump_offset = 271

        -- system valve
        if system.shutoff_valve ~= nil then
            local valve_state = get(system.shutoff_valve.state)
            if valve_state == valve_states.closed then
                sasl.gl.drawCircle(offset, 210, 13, true, ECAM_COLOURS.ORANGE)
                sasl.gl.drawCircle(offset, 210, 11, true, {0, 0, 0})
                sasl.gl.drawWidePolyLine({offset-13,210,  offset+13,210}, 2, ECAM_COLOURS.ORANGE)
            elseif valve_state == valve_states.transit then
                sasl.gl.drawCircle(offset, 210, 13, true, ECAM_COLOURS.ORANGE)
                sasl.gl.drawCircle(offset, 210, 11, true, {0, 0, 0})
                sasl.gl.drawWidePolyLine({offset-10,200,  offset+10,220}, 2, ECAM_COLOURS.ORANGE)
            elseif valve_state == valve_states.open then
                sasl.gl.drawCircle(offset, 210, 13, true, ECAM_COLOURS.GREEN)
                sasl.gl.drawCircle(offset, 210, 11, true, {0, 0, 0})
                sasl.gl.drawWidePolyLine({offset,197,  offset,223}, 2, ECAM_COLOURS.GREEN)
            end
        else
            pump_offset = 227
        end

        -- draw system line
        sasl.gl.drawLine(offset, 85, offset, pump_offset, ECAM_COLOURS.GREEN)

        -- pumps
        if system.pumps.rat ~= nil then
            -- TODO move a little closer
            if get(system.pumps.rat.state) == pump_states.on then
                drawHydArrows(223, 323, arrow_points.right, ECAM_COLOURS.GREEN, true)
                sasl.gl.drawLine(242, 332, offset, 332, ECAM_COLOURS.GREEN)
            else
                drawHydArrows(223, 323, arrow_points.right, ECAM_COLOURS.WHITE)
            end
        end

        if system.pumps.electric ~= nil then
            local pump_state = get(system.pumps.electric.state)
            -- if the system also has an engine pump, then it is yellow and draw triangles
            if system.pumps.engine ~= nil then
                if pump_state == pump_states.on then
                    drawHydArrows(463, 323, arrow_points.left, ECAM_COLOURS.GREEN, true)
                    sasl.gl.drawLine(444, 332, offset, 332, ECAM_COLOURS.GREEN)
                    sasl.gl.drawLine(offset, pump_offset+60, offset, 410, ECAM_COLOURS.GREEN)
                else
                    drawHydArrows(463, 323, arrow_points.left, ECAM_COLOURS.WHITE)
                    sasl.gl.drawLine(offset, pump_offset+60, offset, 410, ECAM_COLOURS.ORANGE)
                end
            else
                -- draw elec pump as boxes because system is blue
                if pump_state == pump_states.off then
                    sasl.gl.drawFrame(offset-15, pump_offset, 29, 29, ECAM_COLOURS.ORANGE)
                    sasl.gl.drawLine(offset-10, pump_offset+15, offset+10, pump_offset+15, ECAM_COLOURS.ORANGE)
                    sasl.gl.drawLine(offset, pump_offset+29, offset, 410, ECAM_COLOURS.ORANGE)
                elseif pump_state == pump_states.on then
                    sasl.gl.drawFrame(offset-15, pump_offset, 29, 29, ECAM_COLOURS.GREEN)
                    sasl.gl.drawLine(offset, pump_offset, offset, 410, ECAM_COLOURS.GREEN)
                end
            end
        end

        if system.pumps.engine ~= nil then
            local pump_state = get(system.pumps.engine.state)
            if pump_state == pump_states.on then
                sasl.gl.drawFrame(offset-15, pump_offset, 29, 29, ECAM_COLOURS.GREEN)
                sasl.gl.drawLine(offset, pump_offset, offset, 410, ECAM_COLOURS.GREEN)
            elseif pump_state == pump_states.low then
                sasl.gl.drawFrame(offset-15, pump_offset, 29, 29, ECAM_COLOURS.ORANGE)
                if system.pumps.elec ~= nil then
                    if get(system.pumps.electric.state) == pump_states.off then
                        sasl.gl.drawLine(offset, pump_offset+29, offset, pump_offset+60, ECAM_COLOURS.ORANGE)
                    else
                        sasl.gl.drawLine(offset, pump_offset+29, offset, pump_offset+60, ECAM_COLOURS.ORANGE)
                    end
                else
                    sasl.gl.drawLine(offset, pump_offset+29, offset, 410, ECAM_COLOURS.ORANGE)
                end
                sasl.gl.drawText(AirbusFont, offset, pump_offset+7, "LO", 22, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
            end
        end

        -- draw fixed items
        -- norm level
        sasl.gl.drawFrame(offset, 154, 6, 15, ECAM_COLOURS.GREEN)

        sasl.gl.drawLine(offset, 106, offset, 153, ECAM_COLOURS.WHITE)
        -- Low level warn
        sasl.gl.drawFrame(offset, 86, 6, 20, ECAM_COLOURS.ORANGE)

        local qty = get(system.qty)
        local pos = math.floor(qty * 0.56552) + 86
        sasl.gl.drawPolyLine({offset,86,  offset-11,86,  offset-11,pos,  offset,pos,  offset-11,pos+12}, ECAM_COLOURS.GREEN)
    end

     -- green/blue/yellow
    -- psi  3000 ±200
    -- qty
      -- max, norm, acceptable, low
    -- temp green|yellow|blue
    -- engine 1/2 hyd valve -> green/yellow - circle, engine 1/2 fire valve
    -- hyd pumps (box) green/yellow -> engine pump; blue -> elec; yellow also has elec
    -- rat on blue - white == inactive; green == active
    -- ptu when active solid green triangles
    -- yellow has the accumulator

    -- From engineer:
    -- Green full range 12L-14.5L (this is the green bar on the ECAM), low level 3L (top of amber bar), max gauge readable 18L
    -- Yellow full range 10L-12.5L, low level 3L, max gauge 18L
    -- Blue full range 5L-6.5L, low level 2L, max gauge 8L
    -- These are all reservoir quantities...the systems themselves hold much more in pipes and actuators etc
    -- Green max system volume is 100L, Yellow 75L, Blue 60L
    -- That includes reservoir max volume Green 30L, Yellow 40L, Blue 30L (this includes air space)

    sasl.gl.saveInternalLineState()
    sasl.gl.setInternalLineStipple(false)
    sasl.gl.setInternalLineWidth(2)
    drawSystem(hyd.green, 93)
    drawSystem(hyd.blue, 261)
    drawSystem(hyd.yellow, 430)

    if get(hyd.green.pressure) >= 2800 then
        sasl.gl.drawText(AirbusFont, 93, 448, "GREEN", 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 93, 420, round(get(hyd.green.pressure), 10), 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 93, 448, "GREEN", 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 93, 420, round(get(hyd.green.pressure), 10), 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end
    if get(hyd.blue.pressure) >= 2800 then
        sasl.gl.drawText(AirbusFont, 261, 448, "BLUE", 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 261, 420, round(get(hyd.blue.pressure), 10), 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 261, 448, "BLUE", 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 261, 420, round(get(hyd.blue.pressure), 10), 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end
    if get(hyd.yellow.pressure) >= 2800 then
        sasl.gl.drawText(AirbusFont, 430, 448, "YELLOW", 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
        sasl.gl.drawText(AirbusFont, 430, 420, round(get(hyd.yellow.pressure), 10), 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.GREEN)
    else
        sasl.gl.drawText(AirbusFont, 430, 448, "YELLOW", 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
        sasl.gl.drawText(AirbusFont, 430, 420, round(get(hyd.yellow.pressure), 10), 24, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.ORANGE)
    end

    sasl.gl.drawText(AirbusFont, 345, 371, "PTU", 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 200, 325, "RAT", 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 493, 325, "ELEC", 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)
    sasl.gl.drawText(AirbusFont, 261+45, 227+29, "ELEC", 20, false, false, TEXT_ALIGN_CENTER, ECAM_COLOURS.WHITE)

    -- draw PTU line
    if get(hyd.ptu.state) == active_states.active then
        -- draw filled triangles 
        local pointing = arrow_points.left
        if get(hyd.ptu.xfer.from) == "green" then
            pointing = arrow_points.right
        end
        drawHydArrows(373, 370, pointing, ECAM_COLOURS.GREEN, true)
        drawHydArrows(311, 370, pointing, ECAM_COLOURS.GREEN, true)
        drawHydArrows(187, 370, pointing, ECAM_COLOURS.GREEN, true)
        sasl.gl.drawLine(93, 378, 188, 378, ECAM_COLOURS.GREEN)
        sasl.gl.drawLine(373, 378, 430, 378, ECAM_COLOURS.GREEN)
    else
        -- draw empty triangles
        drawHydArrows(373, 370, arrow_points.right)
        drawHydArrows(311, 370)
        drawHydArrows(187, 370)
    end
    sasl.gl.drawArc(261, 378, 14, 16, 180, 180, ECAM_COLOURS.GREEN)
    sasl.gl.drawLine(188, 378, 246, 378, ECAM_COLOURS.GREEN)
    sasl.gl.drawLine(276, 378, 300, 378, ECAM_COLOURS.GREEN)

    sasl.gl.restoreInternalLineState()
end