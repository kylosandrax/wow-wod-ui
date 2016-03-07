-- ATTACHING TO THE MAIN MODULE --

--[[ WORK IN PROGRESS

-- button on main frame
hopAddon.buttonGroup = CreateFrame("Button","groupOnMain",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonGroup:SetSize(25,25)
hopAddon.buttonGroup:SetPoint("TOPRIGHT",-46,4)
hopAddon.buttonGroup.Icon = hopAddon.buttonGroup:CreateTexture("butOptionsTex","OVERLAY")
hopAddon.buttonGroup.Icon:SetSize(10,11)
hopAddon.buttonGroup.Icon:SetPoint("CENTER",1,0)
hopAddon.buttonGroup.Icon:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-Note")
hopAddon.buttonGroup.Icon:SetVertexColor(1,0.82,0)
hopAddon.buttonGroup.tooltip = OPTIONS
-- override on enter, onhide event is inside template
hopAddon.buttonGroup:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT", 0, -25)
	GameTooltip:SetText(button.tooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)
-- toggle options frame on click
hopAddon.buttonGroup:SetScript("OnClick", function(button)
	PVEFrame:Show()
	GroupFinderFrame_ShowGroupFrame(LFGListPVEStub)
	--LFGListEntryCreation_Show(LFGListFrame.EntryCreation,0,6,0)
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)


]]