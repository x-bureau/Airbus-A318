sasl.options.setAircraftPanelRendering(true)
sasl.options.set3DRendering(true)
sasl.options.setInteractivity(true)
addSearchPath(moduleDirectory.."/images/")
addSearchPath(moduleDirectory .. "/Custom Module/ATSAW/")
addSearchPath(moduleDirectory .. "/Custom Module/ND/")
addSearchPath(moduleDirectory .. "/Custom Module/ADIRS/")
addSearchPath(moduleDirectory .. "/Custom Module/PFD/")

size = {2048, 2048}

panelWidth3d = 2048
panelHeight3d = 2048

components = {
  customdataref {};
  systems {};
  ADIRS {};
  MCDU {};
  PFD_CAPT {};
  PFD_FRST {};
  ND_CAPT {};
  ND_FRST {};
  -- ATSAW {};
  ecam {};
  lower_ecam {};
  menu {};
}

function onModuleDone()
  print('TODO: save state')
  -- saveState('a318.state')
end