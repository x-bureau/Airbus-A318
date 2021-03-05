sasl.options.setAircraftPanelRendering(true)
sasl.options.set3DRendering(true)
sasl.options.setInteractivity(true)
addSearchPath(moduleDirectory.."/images/")

size = {2048, 2048}

panelWidth3d = 2048
panelHeight3d = 2048

components = {
  customdataref {};
  systems {};
  pfd {};
  nav {};
  ecam {};
  lower_ecam {};
  menu {};
  efb{};
}

function onModuleDone()
  print('TODO: save state')
  -- saveState('a318.state')
end