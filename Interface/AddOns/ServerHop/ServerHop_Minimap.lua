local function OnEnter(tooltip)
	tooltip:SetText("Server Hop", 1, 1, 1);
	tooltip:AddLine(HOPADDON_TOGGLE, nil, nil, nil, 1);
	tooltip:Show();
end

local function OnClick(self, button, down)
	if hopAddon:IsShown() then
		hopAddon:Hide()
	else
		hopAddon:Show()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")		
end


local minimapData = LibStub("LibDataBroker-1.1"):NewDataObject("ServerHopMinimapButton",{
	type = "data source",
	text = "Server Hop",
	icon = "Interface\\Icons\\Achievement_General_StayClassy",
	OnClick =  OnClick,
	OnTooltipShow = OnEnter
})

function hopAddon_MiniMapInit()
	hopAddon.minimap:Register("ServerHop", minimapData, hopAddon.var.minimapDB.global.minimap)
end