local xb_menu_item = sasl.appendMenuItem(PLUGINS_MENU_ID , "X-Bureau")

local xb_menu = sasl.createMenu("Project", PLUGINS_MENU_ID , xb_menu_item)

local hydPopout_cmd = sasl.createCommand("A318/popouts/hyd", "HYD popout panel")
sasl.registerCommandHandler(hydPopout_cmd, 0, function(phase)
    if phase == SASL_COMMAND_BEGIN then
        if hydPopoutWindow:isVisible() then
            hydPopoutWindow:setIsVisible(false)
        else
            hydPopoutWindow:setIsVisible(true)
        end
    end
end)

local hyd_popout_menuItem = sasl.appendMenuItemWithCommand(xb_menu, "Show/hide HYD popup", hydPopout_cmd)

hydPopoutWindow = contextWindow { name = 'HYD panel';
  position = { 100, 250, 768, 300 }; noBackground = true; proportional = true; minimumSize = { 512, 200 }; maximumSize = { 1356, 530 }; gravity = { 0, 1, 0, 1 }; visible = true; saveState = false;
  components = {
    hydPopout {};
  }
}
