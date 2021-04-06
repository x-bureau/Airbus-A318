sasl.options.setAircraftPanelRendering(true)
sasl.options.set3DRendering(false)
sasl.options.setInteractivity(true)
addSearchPath(moduleDirectory.."/images/")
addSearchPath(moduleDirectory .. "/Custom Module/ADIRS/")
addSearchPath(moduleDirectory .. "/Custom Module/PFD/")
addSearchPath(moduleDirectory .. "/Custom Module/ND/")
addSearchPath(moduleDirectory .. "/Custom Module/ECAM/")
addSearchPath(moduleDirectory .. "/Custom Module/ATSAW/")
addSearchPath(moduleDirectory .. "/Custom Module/efb/")
addSearchPath(moduleDirectory .. "/Custom Module/MCDU/")

size = {2048, 2048}

panelWidth3d = 2048
panelHeight3d = 2048

components = {
  customdataref {};
  elec {};
  cockpit {};
  FADEC {};
  ADIRS {};
  --fuel {};
  hydraulics {};
  bleed {};
  mcdu {
    fbo = true ,
    fpsLimit = 2
  };
  PFD_CAPT {
    fbo = true ,
    fpsLimit = 29
  };
  PFD_FRST {
    fbo = true ,
    fpsLimit = 29
  };
  ND_CAPT {
    fbo = true ,
    fpsLimit = 29
  };
  ND_FRST {
    fbo = true ,
    fpsLimit = 29
  };
  upper_ecam {
    fbo = true ,
    fpsLimit = 20
  };
  lower_ecam {
    fbo = true ,
    fpsLimit = 20
  };
  menu {};
  efb{
    cursor = {
      x = -15 ,
      y = -15 ,
      width = 30 ,
      height = 30 ,
      shape = sasl.gl.loadImage ("efb/icons/cursor.png") ,
      hideOSCursor = true
      },
      fbo = true,
      fpsLimit = 20
  };
}

function onModuleDone()
  print('TODO: save state')
  -- saveState('a318.state')
end