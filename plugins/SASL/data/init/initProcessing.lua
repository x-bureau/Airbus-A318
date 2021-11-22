-------------------------------------------------------------------------------
-- Draw
-------------------------------------------------------------------------------

--- Draws (2D) all components.
--- @param components Component[]
--- @see reference
--- : https://1-sim.com/files/SASL3Manual.pdf#drawAll
function drawAll(components)
    for _, v in ipairs(components) do
        private.drawComponent(v)
    end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Draws 3D from components.
--- @param components Component[]
--- @see reference
--- : https://1-sim.com/files/SASL3Manual.pdf#drawAll3D
function drawAll3D(components)
    for _, v in ipairs(components) do
        v:draw3D()
    end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Draws objects from components.
--- @param components Component[]
--- @see reference
--- : https://1-sim.com/files/SASL3Manual.pdf#drawAllObjects
function drawAllObjects(components)
    for _, v in ipairs(components) do
        v:drawObjects()
    end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Simulator framerate dataref
local simFRP = globalPropertyf("sim/operation/misc/frame_rate_period")

--- Draws component to its 2D render target.
--- @param v Component
function private.drawComponentToTarget(v)
    setRenderTarget(v.renderTarget, true)
    v:draw()
    restoreRenderTarget()
end

--- Draws component in 2D.
--- @param v Component
function private.drawComponent(v)
    if v and toboolean(get(v.visible)) then
        sasl.gl.saveGraphicsContext()
        local renderTargetExist = toboolean(get(v.fbo))
        if renderTargetExist then
            local omitRendering = toboolean(get(v.noRenderSignal))
            if not omitRendering then
                local currentFPS = 1.0 / get(simFRP)
                local limit = get(v.fpsLimit)
                if limit == -1 or limit >= currentFPS then
                    private.drawComponentToTarget(v)
                    v.frames = 0
                else
                    if v.frames > currentFPS / limit then
                        private.drawComponentToTarget(v)
                        v.frames = 0
                    else
                        v.frames = v.frames + 1
                    end
                end
            end
            local pos = get(v.position)
            sasl.gl.setComponentTransform(pos[1], pos[2], pos[3], pos[4], v.size[1], v.size[2])
            sasl.gl.drawTexture(v.renderTarget, 0, 0, v.size[1], v.size[2], 1, 1, 1, 1)
            set(v.noRenderSignal, false)
        else
            local pos = get(v.position)
            sasl.gl.setComponentTransform(pos[1], pos[2], pos[3], pos[4], v.size[1], v.size[2])
            local clip = toboolean(get(v.clip))
            local cs = get(v.clipSize) and get(v.clipSize) or { pos[1], pos[2], pos[3], pos[4] }
            local clipSize = cs[3] > 0 and cs[4] > 0
            if clip then
                if clipSize then
                    sasl.gl.setClipArea(cs[1], cs[2], cs[3], cs[4])
                else
                    sasl.gl.setClipArea(0, 0, v.size[1], v.size[2])
                end
            end
            v:draw()
            if clip then
                sasl.gl.resetClipArea()
            end
        end
        sasl.gl.restoreGraphicsContext()
    end
end

-------------------------------------------------------------------------------
-- Initialize
-------------------------------------------------------------------------------

--- Initializes all components.
--- @param components Component[]
--- @see reference
--- : https://1-sim.com/files/SASL3Manual.pdf#initializeAll
function initializeAll(components)
    for _, v in ipairs(components) do
        v:initialize()
    end
end

-------------------------------------------------------------------------------
-- Update
-------------------------------------------------------------------------------

--- Updates all components.
--- @param components Component[]
--- @see reference
--- : https://1-sim.com/files/SASL3Manual.pdf#updateAll
function updateAll(components)
    for _, v in ipairs(components) do
        v:update()
    end
end

-------------------------------------------------------------------------------
-- Utilities
-------------------------------------------------------------------------------

--- Calls callback function for component recursively.
--- @param name string
--- @param component Component
--- @param arg any
function private.callCallback(name, component, arg)
    local handler = rawget(component, name)
    if handler then
        handler(arg)
    end
    for i = #component.components, 1, -1 do
        private.callCallback(name, component.components[i], arg)
    end
end

--- Calls callback for all components layers.
--- @param name string
--- @param arg any
function private.callCallbackForAllLayers(name, arg)
    private.callCallback(name, popups, arg)
    private.callCallback(name, panel, arg)
    private.callCallback(name, contextWindows, arg)
end

-------------------------------------------------------------------------------
-- Other
-------------------------------------------------------------------------------

--- Draws 3D panel components.
function drawPanelStage()
    private.drawComponent(panel)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Draws old-style popups components.
function drawPopupsStage()
    private.drawComponent(popups)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Draws 3D.
function draw3DStage()
    panel:draw3D()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Draws objects.
function drawObjectsStage()
    panel:drawObjects()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Initializing callback right before first update cycle
function initialize()
    panel:initialize()
    popups:initialize()
    contextWindows:initialize()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Updates components.
function update()
    panel:update()
    popups:update()
    contextWindows:update()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called whenever the user's plane is positioned at a new airport (or new flight start).
--- @param flightIndex number
function onAirportLoaded(flightIndex)
    private.callCallbackForAllLayers("onAirportLoaded", flightIndex)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called whenever new scenery is loaded.
function onSceneryLoaded()
    private.callCallbackForAllLayers("onSceneryLoaded")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called whenever the user adjusts the number of X-Plane aircraft models.
function onAirplaneCountChanged()
    private.callCallbackForAllLayers("onAirplaneCountChanged")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called when user aircraft is loaded.
function onPlaneLoaded()
    private.callCallbackForAllLayers("onPlaneLoaded")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called when user aircraft is unloaded.
function onPlaneUnloaded()
    private.callCallbackForAllLayers("onPlaneUnloaded")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called whenever user plane is crashed.
function onPlaneCrash()
    local planeCrashHandler = rawget(panel, 'onPlaneCrash')
    needReload = 1
    if planeCrashHandler then
        needReload = planeCrashHandler()
    end
    if needReload == 0 then
        for i = #panel.components, 1, -1 do
            private.callCallback('onPlaneCrash', panel.components[i])
        end
        private.callCallback('onPlaneCrash', popups)
        private.callCallback('onPlaneCrash', contextWindows)
    end
    return needReload
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called on module shutdown.
function shutdownModules()
    private.callCallbackForAllLayers("onModuleShutdown")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

--- Called when module is unloading.
function doneModules()
    private.callCallbackForAllLayers("onModuleDone")
    private.saveState()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------