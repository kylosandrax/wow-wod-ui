-- Populating hopAddon frame


-- mode change


hopAddon.buttonChangeMode = CreateFrame("Button",nil,hopAddon,"UIGoldBorderButtonTemplate")
hopAddon.buttonChangeMode:SetSize(110,21)
hopAddon.buttonChangeMode:SetPoint("TOPLEFT", 30,2)
hopAddon.buttonChangeMode:SetText(HOPADDON_CHANGEMODE)

--[[	 SQUARE VERSION WITHOUT TEXT

hopAddon.buttonChangeMode = CreateFrame("Button","changemodebut",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonChangeMode:SetSize(25,25)
hopAddon.buttonChangeMode:SetPoint("TOPLEFT",27,4)
hopAddon.buttonChangeMode.Icon = hopAddon.buttonChangeMode:CreateTexture("changemodebuttex","OVERLAY")
hopAddon.buttonChangeMode.Icon:SetSize(14,14)
hopAddon.buttonChangeMode.Icon:SetPoint("CENTER",0,0)
hopAddon.buttonChangeMode.Icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")
hopAddon.buttonChangeMode.tooltip = HOPADDON_CHANGEMODE
-- override on enter, onhide event is inside template
hopAddon.buttonChangeMode:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT", 0, -25)
	GameTooltip:SetText(HOPADDON_CHANGEMODE, 1, 1, 1, true)
	GameTooltip:Show()
end)
]]--

-- hop/search mode toggle button
hopAddon.buttonChangeMode:SetScript("OnClick", function(btn)
	FinishHopSearch()
	FinishCustomSearch()
	HelpPlate_Hide(true)
	hopAddon.favouritesFrame:Hide()
	hopAddon.searchFrame.holderCatFilters:Hide()
	
	if hopAddon.hopFrame:IsShown() then
		hopAddon.hopFrame:Hide()
		hopAddon.searchFrame:Show()
	else
		hopAddon.hopFrame:Show()
		hopAddon.searchFrame:Hide()
	end
	
	PlaySound("igMainMenuOptionCheckBoxOn")
end)



HoppingFrame_HelpPlate = {
	FramePos = { x = 0, y = -20 },
	FrameSize = { width = HOPADDON_WIDTH, height = HOPADDON_HEIGHT },
	[1] = { ButtonPos = { x = 140,  y = 20 }, HighLightBox = { x = 50, y = 0, width = 140, height = 23 },  ToolTipDir = "UP",   ToolTipText = HOPADDON_HOPHELP_1 },
	[2] = { ButtonPos = { x = 200,  y = -15 },  HighLightBox = { x = 15, y = -25, width = 210, height = 24 },  ToolTipDir = "RIGHT",  ToolTipText = HOPADDON_HOPHELP_2 },
	[3] = { ButtonPos = { x = 45,  y = -56},  HighLightBox = { x = 15, y = -50, width = 100, height = 24 },  ToolTipDir = "DOWN",		ToolTipText = HOPADDON_HOPHELP_3 },
	[4] = { ButtonPos = { x = 155,  y = -56 }, HighLightBox = { x = 125, y = -50, width = 100, height = 24 }, ToolTipDir = "DOWN",   ToolTipText = HOPADDON_HOPHELP_4 },
}

SearchingFrame_HelpPlate = {
	FramePos = { x = 0, y = -20 },
	FrameSize = { width = HOPADDON_WIDTH, height = 120 },
	[1] = { ButtonPos = { x = 200,  y = -15 },  HighLightBox = { x = 15, y = -25, width = 210, height = 24 },  ToolTipDir = "RIGHT",  ToolTipText = HOPADDON_SEARCHHELP_1 },
	[2] = { ButtonPos = { x = 200,  y = -40},  HighLightBox = { x = 15, y = -50, width = 210, height = 24 },  ToolTipDir = "RIGHT",		ToolTipText = HOPADDON_SEARCHHELP_2 },
	[3] = { ButtonPos = { x = 95,  y = -75 }, HighLightBox = { x = 5, y = -90, width = 230, height = 20 }, ToolTipDir = "DOWN",   ToolTipText = HOPADDON_SEARCHHELP_3 },
	[4] = { ButtonPos = { x = 95,  y = -120 }, HighLightBox = { x = 5, y = -110, width = 230, height = 60 }, ToolTipDir = "RIGHT",   ToolTipText = HOPADDON_SEARCHHELP_4 },
}


hopAddon.buttonHelp = CreateFrame("Button","helpButton",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonHelp:SetSize(25,25)
hopAddon.buttonHelp:SetPoint("TOPRIGHT",-25,4)
hopAddon.buttonHelp.Icon = hopAddon.buttonHelp:CreateTexture("helpTex","OVERLAY")
hopAddon.buttonHelp.Icon:SetSize(16,16)
hopAddon.buttonHelp.Icon:SetPoint("CENTER",0,0)
hopAddon.buttonHelp.Icon:SetTexture("Interface\\QuestFrame\\QuestTypeIcons")
hopAddon.buttonHelp.Icon:SetTexCoord(unpack(QUEST_TAG_TCOORDS["COMPLETED"]))
-- override on enter, onhide event is inside template
hopAddon.buttonHelp:SetScript("OnClick", function(btn)
	if not HelpPlate_IsShowing(HoppingFrame_HelpPlate) and hopAddon.hopFrame:IsShown() then
		HelpPlate_Show(HoppingFrame_HelpPlate,hopAddon,hopAddon.buttonHelp,true)
	elseif not HelpPlate_IsShowing(SearchingFrame_HelpPlate) and hopAddon.searchFrame:IsShown() then
		HelpPlate_Show(SearchingFrame_HelpPlate,hopAddon,hopAddon.buttonHelp,true)		
	else
		HelpPlate_Hide(true)
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

hopAddon.buttonHelp:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT", 0, -25)
	GameTooltip:SetText(MAIN_HELP_BUTTON_TOOLTIP, 1, 1, 1, true)
	GameTooltip:Show()	
end)

-- close button in the topright corner
hopAddon.closeButton = CreateFrame("Button", nil, hopAddon,"BrowserButtonTemplate")
hopAddon.closeButton:SetSize(25,25)
hopAddon.closeButton:SetPoint("TOPRIGHT",-4,4)
hopAddon.closeButton.Icon = hopAddon.closeButton:CreateTexture(nil,"OVERLAY")
hopAddon.closeButton.Icon:SetSize(14,14)
hopAddon.closeButton.Icon:SetPoint("CENTER",0,0)
hopAddon.closeButton.Icon:SetTexture("Interface\\Buttons\\UI-StopButton")
hopAddon.closeButton:SetScript("OnClick", function(btn)
	hopAddon.favouritesFrame:Hide()
	hopAddon:Hide()
end)

hopAddon_LFGWarning.btn:SetScript("OnClick", function(btn)
	FinishHopSearch()
	FinishCustomSearch()
end)

local customOptions = hopAddon.optionsFrame.customSearchOptionsFrame

local function ServerHop_EventSystem(self, event, ...)
	local arg1 = ...
	if event == "PLAYER_LOGIN" then	
		if ServerHopPosition ~= nil then
			hopAddon:ClearAllPoints()	
			hopAddon:SetPoint(ServerHopPosition[1],ServerHopPosition[2],ServerHopPosition[3])
			if ServerHopPosition[4] then
				hopAddon:Show()
			end
		end
				
		hopAddon.searchFrame.dropDown.activeValue = 6
		hopAddon.searchFrame.dropDown.text:SetText(C_LFGList.GetCategoryInfo(hopAddon.searchFrame.dropDown.activeValue))

		if ServerHopSettings ~= nil then
			customOptions.tankCheckButton:SetChecked(ServerHopSettings[1])
			customOptions.dpsCheckButton:SetChecked(ServerHopSettings[2])
			customOptions.healCheckButton:SetChecked(ServerHopSettings[3])
			customOptions.soundCheckButton:SetChecked(ServerHopSettings[4])
			customOptions.endlessCheckBox:SetChecked(ServerHopSettings[5])
			
			if ServerHopSettings["NON_AUTO_GROUPS"] ~= nil then
				hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:SetChecked(ServerHopSettings["NON_AUTO_GROUPS"])
			end
			if ServerHopSettings["NON_AUTO_GROUPS_WAIT"] ~= nil then
				hopAddon.optionsFrame.hopSearchOptionsFrame.sliderQueueWait:SetValue(ServerHopSettings["NON_AUTO_GROUPS_WAIT"])
			end
			if hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked() then
				Slider_Enable(hopAddon.optionsFrame.hopSearchOptionsFrame.sliderQueueWait)
			else
				HOPADDON_QUEUE_INTERVAL = 1
			end
			
			if ServerHopSettings["BLACKLIST_DURATION"] ~= nil then
				hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:SetValue(ServerHopSettings["BLACKLIST_DURATION"])
			end
			
			if ServerHopSettings["STATUS_FRAME"] ~= nil and ServerHopSettings["STATUS_FRAME"] == false then
				hopAddon.optionsFrame.globalOptionsFrame.statusCheckButton:SetChecked(false)
			end
			if ServerHopSettings["DEFAULT_MODE"] ~= nil and ServerHopSettings["DEFAULT_MODE"] == false then
				hopAddon.hopFrame:Show()
				hopAddon.searchFrame:Hide()
			end
			if ServerHopSettings["FLASH_TASKBAR"] ~= nil and ServerHopSettings["FLASH_TASKBAR"] == false then
				customOptions.taskbarOption:SetChecked(false)
			end
			if ServerHopSettings["HOP_TO_PVP"] ~= nil then
				UIDropDownMenu_SetSelectedID(hopAddon.hopFrame.pvpDrop, ServerHopSettings["HOP_TO_PVP"])
				UIDropDownMenu_SetText(hopAddon.hopFrame.pvpDrop, hopAddon_serverTypeDropTable[ServerHopSettings["HOP_TO_PVP"]])
			end
			if ServerHopSettings["MINIMAP_SETTINGS"] ~= nil then
				hopAddon.var.minimapDB.global.minimap = ServerHopSettings["MINIMAP_SETTINGS"]
				if ServerHopSettings["MINIMAP_SETTINGS"].hide == true then
					hopAddon.optionsFrame.globalOptionsFrame.MinimapCheckButton:SetChecked(false)
				end
			end
			if ServerHopSettings["CHAT_NOTIFICATIONS"] ~= nil then
				hopAddon.optionsFrame.globalOptionsFrame.chatNotifButton:SetChecked(ServerHopSettings["CHAT_NOTIFICATIONS"])
			end
		end
		
		
		hopAddon_MiniMapInit()
		C_LFGList.RequestAvailableActivities();
		hopAddon_GatherPvPRealms(GetCurrentRegion())
		
	elseif event == "PLAYER_LOGOUT" then
	
		local point, relativeTo, relativePoint, xOfs, yOfs = hopAddon:GetPoint()
		
		ServerHopPosition = {}
		
		ServerHopPosition[1]=point
		ServerHopPosition[2]=xOfs
		ServerHopPosition[3]=yOfs
		ServerHopPosition[4]=hopAddon:IsShown()

		ServerHopSettings = {}
		
		ServerHopSettings[1] = customOptions.tankCheckButton:GetChecked()
		ServerHopSettings[2] = customOptions.dpsCheckButton:GetChecked()
		ServerHopSettings[3] = customOptions.healCheckButton:GetChecked()
		ServerHopSettings[4] = customOptions.soundCheckButton:GetChecked()
		ServerHopSettings[5] = customOptions.endlessCheckBox:GetChecked()
		
		ServerHopSettings["NON_AUTO_GROUPS"] = hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked()
		ServerHopSettings["NON_AUTO_GROUPS_WAIT"] = ceil(hopAddon.optionsFrame.hopSearchOptionsFrame.sliderQueueWait.value)
		ServerHopSettings["BLACKLIST_DURATION"] = hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime.value
		ServerHopSettings["STATUS_FRAME"] = hopAddon.optionsFrame.globalOptionsFrame.statusCheckButton:GetChecked()
		ServerHopSettings["DEFAULT_MODE"] = hopAddon.searchFrame:IsShown()
		ServerHopSettings["FLASH_TASKBAR"] = customOptions.taskbarOption:GetChecked()
		ServerHopSettings["HOP_TO_PVP"] = UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.pvpDrop)
		
		local position = hopAddon.var.minimapDB.global.minimap.minimapPos
		local visibility = not hopAddon.optionsFrame.globalOptionsFrame.MinimapCheckButton:GetChecked()
		local arr = {minimapPos = position,hide = visibility, }
		ServerHopSettings["MINIMAP_SETTINGS"] = arr
		
		ServerHopSettings["CHAT_NOTIFICATIONS"] = hopAddon.optionsFrame.globalOptionsFrame.chatNotifButton:GetChecked()
		

	end
	
end

--Events
hopAddon:SetScript("OnEvent", ServerHop_EventSystem)
hopAddon:RegisterEvent("PLAYER_LOGIN")
hopAddon:RegisterEvent("PLAYER_LOGOUT")