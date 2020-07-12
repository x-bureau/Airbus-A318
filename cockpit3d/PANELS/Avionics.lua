size={1024,1024}

panelWidth3d = 1024
panelHeight3d = 1024

components{
    PFD {position={24,225,-308,541} },
}
function draw()
    w = screen getwidth()
    h = screen getheight()
    screen  setColor (0,0,0)
    screen.draw('special.png')(w / 2, h / 2)
end