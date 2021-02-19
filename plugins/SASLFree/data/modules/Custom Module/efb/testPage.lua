position = {200, 200, 300, 300}
size = {300, 300}


function onMouseDown(component, x, y, button, parentX, parentY)
    if get(activePage) == 1 then
        if button == MB_LEFT then
            print("x: ", x)
            print("y: ", y)
        end
    end
end

function draw() 
    if get(activePage) == 1 then
        sasl.gl.drawRectangle(0, 0, 300, 300, SYSTEM_COLORS.FRONT_GREEN)
    end
end