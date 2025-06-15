if not MOD_LOAD_ORDER_INSTANTIATE_ORIGINAL_FUNC then
    MOD_LOAD_ORDER_INSTANTIATE_ORIGINAL_FUNC = ModSelector.ModLoadOrderPanel.instantiate;
end
function ModSelector.ModLoadOrderPanel:instantiate()
    local gameVersion = getGameVersion();

    if gameVersion:match("^42%.[0-9]") then
        ISPanelJoypad.instantiate(self)
        self.modList:clear()
        local modArray = self.model:getActiveMods():getMods()
        self.defaultOrder = {}

        for i = 0, modArray:size() - 1 do
            local modId = modArray:get(i)
            local modData = {}
            --- Missing mods will still appear when getting active mods,
            --- but they are absent from self.model.mods
            if self.model.mods[modId] then
                modData.name = self.model.mods[modId].name
                modData.icon = self.model.mods[modId].icon
                modData.modId = self.model.mods[modId].modId
                modData.modInfo = self.model.mods[modId].modInfo
                local item = self.modList:addItem("", modData)
                item.color = { r = 0.9, g = 0.9, b = 0.9 }
                item.tooltip = self:getTooltip(modData.modInfo)
                table.insert(self.defaultOrder, self.model.mods[modId].modId)
            end
        end
        self.modList:updateModsColor()
    else
        print("[DELRAN - MOD LOAD ORDER CRASH FIX] : Current game version is not supported.")
        MOD_LOAD_ORDER_INSTANTIATE_ORIGINAL_FUNC(self);
    end
end
