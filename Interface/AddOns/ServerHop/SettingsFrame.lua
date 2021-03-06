﻿-- SETTINGS MODULE --

-- options frame
hopAddon.optionsFrame = CreateFrame("Frame","hopOptions",hopAddon)
hopAddon.optionsFrame:SetFrameLevel(10)
hopAddon.optionsFrame:SetSize(400,425)
hopAddon.optionsFrame:SetPoint("CENTER",UIParent,"CENTER",0,0)
hopAddon.optionsFrame:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 32, edgeSize = 32, 
					insets = { left = 11, right = 11, top = 12, bottom = 10 }});
hopAddon.optionsFrame:Hide()

hopAddon.optionsFrame.header = hopAddon.optionsFrame:CreateTexture(nil,"ARTWORK")
hopAddon.optionsFrame.header:SetSize(300,68)
hopAddon.optionsFrame.header:SetPoint("TOP",0,12)
hopAddon.optionsFrame.header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")

hopAddon.optionsFrame.headerString = hopAddon.optionsFrame:CreateFontString("headerString", "OVERLAY", "GameFontNormal")
hopAddon.optionsFrame.headerString:SetPoint("TOP",0,-4)
hopAddon.optionsFrame.headerString:SetText("Server Hop v"..SERVERHOP_VERSION)

hopAddon.optionsFrame.closeButton = CreateFrame("Button", "optionsInFrameCloseBut", hopAddon.optionsFrame,"BrowserButtonTemplate")
hopAddon.optionsFrame.closeButton:SetSize(25,25)
hopAddon.optionsFrame.closeButton:SetPoint("TOPRIGHT",-6,-6)
hopAddon.optionsFrame.closeButton.Icon = hopAddon.optionsFrame.closeButton:CreateTexture("optionsClosetex","OVERLAY")
hopAddon.optionsFrame.closeButton.Icon:SetSize(14,14)
hopAddon.optionsFrame.closeButton.Icon:SetPoint("CENTER",0,0)
hopAddon.optionsFrame.closeButton.Icon:SetTexture("Interface\\Buttons\\UI-StopButton")
hopAddon.optionsFrame.closeButton:SetScript("OnClick", function(btn)
	hopAddon.optionsFrame:Hide()
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

hopAddon.optionsFrame:SetMovable(true)
hopAddon.optionsFrame:EnableMouse(true)
hopAddon.optionsFrame:RegisterForDrag("LeftButton")
hopAddon.optionsFrame:SetScript("OnDragStart", hopAddon.optionsFrame.StartMoving)
hopAddon.optionsFrame:SetScript("OnDragStop", hopAddon.optionsFrame.StopMovingOrSizing)


-- Author Notes Frame
hopAddon.optionsFrame.optionsAuthor = CreateFrame("Frame",nil,hopAddon.optionsFrame)
local authorFrame = hopAddon.optionsFrame.optionsAuthor
authorFrame:SetBackdrop({ 
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
					tile = true, tileSize = 16, edgeSize = 16, 
					insets = { left = 5, right = 5, top = 5, bottom = 5 }});
authorFrame:SetSize(360,75)
authorFrame:SetPoint("BOTTOM",0,20)
authorFrame:SetBackdropBorderColor(0.6,0.6,0.6,1)
authorFrame:Show()

authorFrame.updateString = authorFrame:CreateFontString("updateString", "OVERLAY", "GameFontNormal")
authorFrame.updateString:SetWidth(330)
authorFrame.updateString:SetJustifyH("LEFT")
authorFrame.updateString:SetPoint("TOPLEFT",15,-15)
authorFrame.updateString:SetText(HOPADDON_UPDATESTRING)

authorFrame.linkBox = CreateFrame("EditBox", nil, authorFrame, "LFGListEditBoxTemplate")
authorFrame.linkBox:SetPoint("BOTTOM",0,10)
authorFrame.linkBox:SetSize(320,20)
authorFrame.linkBox:SetText("http://www.curse.com/addons/wow/server-hop")
authorFrame.linkBox:SetScript("OnTextChanged", function(self,userInput)
	authorFrame.linkBox:SetText("http://www.curse.com/addons/wow/server-hop")
end)

-- TAB LIST --
hopAddon.optionsFrame.tabList = CreateFrame("Frame",nil,hopAddon.optionsFrame)
local optionTabs = hopAddon.optionsFrame.tabList
optionTabs:SetBackdrop({ 
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
					tile = true, tileSize = 16, edgeSize = 16, 
					insets = { left = 5, right = 5, top = 5, bottom = 5 }});

optionTabs:SetSize(110,160)
optionTabs:SetPoint("TOPLEFT",20,-30)
optionTabs:Show()

local tabList = {}

local function CreateOptionsTab(index,text)
	-- creating tab
	local frame = CreateFrame("Frame",nil,hopAddon.optionsFrame)
	frame:SetBackdrop({ 
						edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 5, right = 5, top = 5, bottom = 5 }});

	frame:SetSize(240,290)
	frame:SetPoint("TOPRIGHT",-20,-30)
	frame:SetBackdropBorderColor(0.6,0.6,0.6,1)
	frame:Hide()
	
	-- creating button
	local button = CreateFrame("Button", nil, optionTabs)
	button:SetSize(110,25)
	button:SetPoint("TOPLEFT",0,-5-index*25)

	local highlightTexture = button:CreateTexture()
	highlightTexture:SetPoint("TOPLEFT",2,0)
	highlightTexture:SetPoint("BOTTOMRIGHT",-2,1)
	highlightTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
	button:SetHighlightTexture(highlightTexture,"ADD")

	button.textName = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	button.textName:SetSize(156,36)
	button.textName:SetPoint("LEFT",button,"LEFT",8,0)
	button.textName:SetJustifyH("LEFT")
	button.textName:SetText(text)
	
	button.textName:SetTextColor(1,0.82,0,1)

	button:SetScript("OnClick",function(btn)
		-- Hiding all
		for i=1,#tabList do
			tabList[i].frame:Hide()
			tabList[i].button.textName:SetTextColor(1,0.82,0,1)
		end
		
		-- Showing selected
		frame:Show()
		button.textName:SetTextColor(1,1,1,1)
	end)
	
	t = {}
	t.frame = frame
	t.button = button
	
	table.insert(tabList,t)
	
	return frame,button
end

-- Global options frame
hopAddon.optionsFrame.globalOptionsFrame,optionTabs.buttonGlobal = CreateOptionsTab(0,GRAPHICS_LABEL)
local globalOptions = hopAddon.optionsFrame.globalOptionsFrame
optionTabs.buttonGlobal.textName:SetTextColor(1,1,1,1)
globalOptions:Show()

globalOptions.stringGlobalOptions = globalOptions:CreateFontString("globalOptions","OVERLAY","GameFontNormal")
globalOptions.stringGlobalOptions:SetPoint("TOPLEFT",15,-15)
globalOptions.stringGlobalOptions:SetText(GRAPHICS_LABEL)

globalOptions.MinimapCheckButton = CreateFrame("CheckButton","MinimapCheck",globalOptions,"ChatConfigCheckButtonTemplate")
globalOptions.MinimapCheckButton:SetPoint("TOPLEFT",15,-35)
getglobal(globalOptions.MinimapCheckButton:GetName() .. 'Text'):SetText(HOPADDON_MINIMAPOPTIONS)
globalOptions.MinimapCheckButton.tooltip = HOPADDON_MINIMAPOPTIONS_DESCR
globalOptions.MinimapCheckButton:SetChecked(true)

globalOptions.MinimapCheckButton:SetScript("OnClick", function(btn)
	hopAddon.var.minimapDB.global.minimap.hide = not hopAddon.var.minimapDB.global.minimap.hide
	if hopAddon.var.minimapDB.global.minimap.hide then
		hopAddon.minimap:Hide("ServerHopMinimapButton")
	else
		hopAddon.minimap:Show("ServerHopMinimapButton")	
	end
	PlaySound("igMainMenuOptionCheckBoxOn")		
end)

globalOptions.statusCheckButton = CreateFrame("CheckButton","statusCheckBtn",globalOptions,"ChatConfigCheckButtonTemplate")
globalOptions.statusCheckButton:SetPoint("TOPLEFT",15,-65)
getglobal(globalOptions.statusCheckButton:GetName() .. 'Text'):SetText(HOPADDON_SHOWSTATUSOPTION)
globalOptions.statusCheckButton.tooltip = HOPADDON_SHOWSTATUSTOOLTIP
globalOptions.statusCheckButton:SetChecked(true)

globalOptions.statusCheckButton:SetScript("OnClick", function(btn)
	if hopAddon.hopStatus:IsShown() then
		hopAddon.hopStatus:Hide()
	elseif IsInGroup() or IsInRaid() then
		hopAddon.hopStatus:Show()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")
end)

globalOptions.chatNotifButton = CreateFrame("CheckButton","SHChatNotifCheckBtn",globalOptions,"ChatConfigCheckButtonTemplate")
globalOptions.chatNotifButton:SetPoint("TOPLEFT",15,-95)
getglobal(globalOptions.chatNotifButton:GetName() .. 'Text'):SetText(HOPADDON_NOTIFCHECK)
globalOptions.chatNotifButton.tooltip = HOPADDON_NOTIFTOOLTIP
globalOptions.chatNotifButton:SetChecked(true)

globalOptions.autoAcceptButton = CreateFrame("CheckButton","autoacceptCheckBtn",globalOptions,"ChatConfigCheckButtonTemplate")
globalOptions.autoAcceptButton:SetPoint("TOPLEFT",15,-125)
getglobal(globalOptions.autoAcceptButton:GetName() .. 'Text'):SetText(HOPADDON_AUTOACCEPT)
globalOptions.autoAcceptButton.tooltip = HOPADDON_AUTOACCEPTTOOLTIP
globalOptions.autoAcceptButton:SetChecked(false)
globalOptions.autoAcceptButton:SetScript("OnEnter",function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,5);
	GameTooltip:SetText(self.tooltip,nil,nil,nil,nil,1);
	GameTooltip:AddLine(HOPADDON_NONSAVESETTING,1,0,0)
	GameTooltip:Show()
end)

-- Custom Search options
hopAddon.optionsFrame.customSearchOptionsFrame,optionTabs.customButton = CreateOptionsTab(1,HOPADDON_SEARCHMODE)
local customOptions = hopAddon.optionsFrame.customSearchOptionsFrame

-- Apply to group role checkmarks
customOptions.rolesString = customOptions:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
customOptions.rolesString:SetPoint("TOPLEFT",15,-15)
customOptions.rolesString:SetText(LFG_TOOLTIP_ROLES )

customOptions.tankCheckButton = CreateFrame("CheckButton","CheckBTank",customOptions,"ChatConfigCheckButtonTemplate")
customOptions.tankCheckButton:SetHitRectInsets(0,-60,0,0)
customOptions.tankCheckButton:SetPoint("TOPLEFT",15,-35)
getglobal(customOptions.tankCheckButton:GetName() .. 'Text'):SetText(TANK)
customOptions.tankCheckButton.tooltip = HOPADDON_ROLETOOLTIP
customOptions.tankCheckButton:SetChecked(true)

customOptions.dpsCheckButton = CreateFrame("CheckButton","CheckBDPS",customOptions,"ChatConfigCheckButtonTemplate")
customOptions.dpsCheckButton:SetHitRectInsets(0,-60,0,0)
customOptions.dpsCheckButton:SetPoint("TOPLEFT",15,-55)
getglobal(customOptions.dpsCheckButton:GetName() .. 'Text'):SetText(DAMAGER)
customOptions.dpsCheckButton.tooltip = HOPADDON_ROLETOOLTIP
customOptions.dpsCheckButton:SetChecked(true)

customOptions.healCheckButton = CreateFrame("CheckButton","CheckBHeal",customOptions,"ChatConfigCheckButtonTemplate")
customOptions.healCheckButton:SetHitRectInsets(0,-60,0,0)
customOptions.healCheckButton:SetPoint("TOPLEFT",15,-75)
getglobal(customOptions.healCheckButton:GetName() .. 'Text'):SetText(HEALER)
customOptions.healCheckButton.tooltip = HOPADDON_ROLETOOLTIP
customOptions.healCheckButton:SetChecked(true)

-- Notifications group
customOptions.notifyString = customOptions:CreateFontString("notifystring", "OVERLAY", "GameFontNormal")
customOptions.notifyString:SetPoint("TOPLEFT",100,-15)
customOptions.notifyString:SetText(HOPADDON_NOTIFY)

customOptions.soundCheckButton = CreateFrame("CheckButton","CheckBSound",customOptions,"ChatConfigCheckButtonTemplate")
customOptions.soundCheckButton:SetPoint("TOPLEFT",100,-35)
getglobal(customOptions.soundCheckButton:GetName() .. 'Text'):SetText(ENABLE_SOUND)
customOptions.soundCheckButton.tooltip = HOPADDON_SOUNDTOOLTIP
customOptions.soundCheckButton:SetChecked(true)

customOptions.taskbarOption = CreateFrame("CheckButton","CheckTaskbar",customOptions,"ChatConfigCheckButtonTemplate")
customOptions.taskbarOption:SetPoint("TOPLEFT",100,-60)
getglobal(customOptions.taskbarOption:GetName() .. 'Text'):SetText(HOPADDON_TASKBAROPTION)
customOptions.taskbarOption.tooltip = HOPADDON_TASKBARTOOLTIP
customOptions.taskbarOption:SetChecked(true)


-- Search options
customOptions.optionsString = customOptions:CreateFontString("optionsString", "OVERLAY", "GameFontNormal")
customOptions.optionsString:SetPoint("TOPLEFT",15,-110)
customOptions.optionsString:SetText(HOPADDON_SEARCHOPTIONS)

customOptions.endlessCheckBox = CreateFrame("CheckButton","CheckBEndless",customOptions,"ChatConfigCheckButtonTemplate")
customOptions.endlessCheckBox:SetPoint("TOPLEFT",15,-130)
getglobal(customOptions.endlessCheckBox:GetName() .. 'Text'):SetText(HOPADDON_ENDLESSCHECK)
customOptions.endlessCheckBox.tooltip = HOPADDON_ENDLESSTOOLTIP
customOptions.endlessCheckBox:SetChecked(false)


-- Hop Search options
hopAddon.optionsFrame.hopSearchOptionsFrame,optionTabs.hopButton = CreateOptionsTab(2,HOPADDON_HOPMODE)
local hopOptions = hopAddon.optionsFrame.hopSearchOptionsFrame

hopOptions.string = hopOptions:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
hopOptions.string:SetPoint("TOPLEFT",15,-15)
hopOptions.string:SetText(ADVANCED_OPTIONS..":")

hopOptions.autoInviteCheck = CreateFrame("CheckButton","CheckAutoinv",hopOptions,"ChatConfigCheckButtonTemplate")
hopOptions.autoInviteCheck:SetPoint("TOPLEFT",15,-35)
getglobal(hopOptions.autoInviteCheck:GetName() .. 'Text'):SetText(HOPADDON_AUTOINVITE_OPTIONS)
hopOptions.autoInviteCheck.tooltip = HOPADDON_AUTOINVITE_TOOLTIP
hopOptions.autoInviteCheck:SetChecked(false)

hopOptions.sliderQueueWait = CreateFrame("Slider","hopAddon_sliderQueueWait",hopOptions,"OptionsSliderTemplate")
local slider = hopOptions.sliderQueueWait
slider:SetSize(140,17)
slider:SetPoint("TOPLEFT",38,-70)

local name = slider:GetName()
_G[name.."Low"]:SetText("1 "..SECONDS);
_G[name.."High"]:SetText("15 "..SECONDS);
slider.type = CONTROLTYPE_SLIDER;
_G[name.."Text"]:SetFontObject("GameFontNormal");
_G[name.."Text"]:SetJustifyH("LEFT")
_G[name.."Text"]:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 4);
slider:SetMinMaxValues(1,15)
slider:SetValueStep(1)
slider:SetScript("OnValueChanged", function(self,value)
	self.value = value;
	_G[name.."Text"]:SetText(HOPADDON_QUEUEWAITTIME.." ("..ceil(value).." "..SECONDS..")")
	HOPADDON_QUEUE_INTERVAL = ceil(value)
		
	if (self:IsVisible()) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

end)

slider:SetValue(5)

Slider_Disable(slider)

hopOptions.autoInviteCheck:SetScript("OnClick", function(self)
	if self:GetChecked() then
		Slider_Enable(slider)
		HOPADDON_QUEUE_INTERVAL = ceil(slider.value)
	else
		Slider_Disable(slider)
		HOPADDON_QUEUE_INTERVAL = 1
	end
	PlaySound("igMainMenuOptionCheckBoxOn")
end)

hopOptions.sliderBLTime = CreateFrame("Slider","hopAddon_sliderBL",hopOptions,"OptionsSliderTemplate")
local slider = hopOptions.sliderBLTime
slider:SetSize(160,17)
slider:SetPoint("BOTTOMLEFT",15,154)

slider.label = hopOptions.sliderBLTime:CreateFontString("bltimestring", "ARTWORK", "GameFontNormal")
local s = slider.label
s:SetTextColor(1,1,1)
s:SetPoint("LEFT",hopOptions.sliderBLTime,"RIGHT",2,1)
local name = slider:GetName()
_G[name.."Low"]:Hide();
_G[name.."High"]:Hide();
slider.type = CONTROLTYPE_SLIDER;
_G[name.."Text"]:SetFontObject("GameFontNormal");
_G[name.."Text"]:SetJustifyH("LEFT")
_G[name.."Text"]:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 4);
_G[name.."Text"]:SetText(HOPADDON_BLDURATION)
slider:SetMinMaxValues(30,3600)
slider:SetValueStep(30)
slider:SetScript("OnValueChanged", function(self,value)
	self.value = value;
	local minutes = math.floor(value/60)
	if minutes > 0 then
		self.label:SetText(minutes.." "..MINS_ABBR)
	else
		self.label:SetText(ceil(value).." "..SECONDS);	
	end
		
	if (self:IsVisible()) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

end)

slider:SetValue(900)

slider:SetScript("OnEnter",function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,5);
	GameTooltip:SetText(HOPADDON_HOPHELP,nil,nil,nil,nil,1);
	GameTooltip:Show()
end)
slider:SetScript("OnLeave",function(self)
	GameTooltip:Hide()
end)

hopOptions.blacklistString = hopOptions:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
hopOptions.blacklistString:SetPoint("BOTTOMLEFT",hopOptions,"BOTTOMLEFT",15,125)
hopOptions.blacklistString:SetHeight(24)
hopOptions.blacklistString:SetJustifyH("LEFT")
hopOptions.blacklistString:SetText(HOPADDON_INBLACKLIST.."|cFFFFFFFF0|r")

hopOptions.buttonClearBL = CreateFrame("Button",nil,hopOptions,"UIGoldBorderButtonTemplate")
hopOptions.buttonClearBL:SetSize(80,24)
hopOptions.buttonClearBL:SetPoint("BOTTOMRIGHT", hopOptions, "BOTTOMRIGHT", -40,125)
hopOptions.buttonClearBL:SetText(CLEAR_ALL)

local highlightTexture = hopOptions:CreateTexture()
highlightTexture:SetPoint("BOTTOM",0,110)
highlightTexture:SetTexture(1,1,1,0.2)
highlightTexture:SetSize(210,1)


hopOptions.updateString = hopOptions:CreateFontString("updateString", "OVERLAY", "GameFontNormal")
hopOptions.updateString:SetWidth(220)
hopOptions.updateString:SetJustifyH("LEFT")
hopOptions.updateString:SetPoint("BOTTOMLEFT",15,85)
hopOptions.updateString:SetText(HOPADDON_NEXTMACRO)

hopOptions.linkBox = CreateFrame("EditBox", nil, hopOptions, "LFGListEditBoxTemplate")
hopOptions.linkBox:SetPoint("BOTTOMLEFT",20,60)
hopOptions.linkBox:SetSize(180,20)
hopOptions.linkBox:SetText("/run ServerHop_HopForward()")
hopOptions.linkBox:SetScript("OnTextChanged", function(self,userInput)
	hopOptions.linkBox:SetText("/run ServerHop_HopForward()")
end)

hopOptions.updateString = hopOptions:CreateFontString("updateString", "OVERLAY", "GameFontNormal")
hopOptions.updateString:SetWidth(220)
hopOptions.updateString:SetJustifyH("LEFT")
hopOptions.updateString:SetPoint("BOTTOMLEFT",15,40)
hopOptions.updateString:SetText(HOPADDON_LASTMACRO)

hopOptions.linkBox = CreateFrame("EditBox", nil, hopOptions, "LFGListEditBoxTemplate")
hopOptions.linkBox:SetPoint("BOTTOMLEFT",20,15)
hopOptions.linkBox:SetSize(180,20)
hopOptions.linkBox:SetText("/run ServerHop_HopBack()")
hopOptions.linkBox:SetScript("OnTextChanged", function(self,userInput)
	hopOptions.linkBox:SetText("/run ServerHop_HopBack()")
end)


-- CREDITS TAB --

hopAddon.optionsFrame.aboutTab,optionTabs.aboutTabSelector = CreateOptionsTab(5,HOPADDON_CREDITS)
local aboutTab = hopAddon.optionsFrame.aboutTab

aboutTab.headerCont = aboutTab:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
aboutTab.headerCont:SetPoint("TOPLEFT",15,-15)
aboutTab.headerCont:SetJustifyH("LEFT")
aboutTab.headerCont:SetText(HOPADDON_AUTHORCONT)

aboutTab.stringCont = aboutTab:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
aboutTab.stringCont:SetPoint("TOPLEFT",15,-35)
aboutTab.stringCont:SetJustifyH("LEFT")
aboutTab.stringCont:SetTextColor(1,1,1,1)
aboutTab.stringCont:SetText("chronoexplosion@gmail.com")


aboutTab.string = aboutTab:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
aboutTab.string:SetPoint("TOPLEFT",15,-55)
aboutTab.string:SetText(HOPADDON_TESTERS)

aboutTab.helpedStringList = aboutTab:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
aboutTab.helpedStringList:SetPoint("TOPLEFT",30,-75)
aboutTab.helpedStringList:SetText("Тарики - Fordragon EU\nСтурворм - Fordragon EU\n\nТревиз - Borean Tundra EU")
aboutTab.helpedStringList:SetJustifyH("LEFT")
aboutTab.helpedStringList:SetTextColor(1,1,1,1)

aboutTab.helpedTex1 = aboutTab:CreateTexture("horde","OVERLAY")
aboutTab.helpedTex1:SetPoint("TOPLEFT",5,-70)
aboutTab.helpedTex1:SetTexture("Interface\\BattlefieldFrame\\Battleground-Horde.png")
aboutTab.helpedTex2 = aboutTab:CreateTexture("horde","OVERLAY")
aboutTab.helpedTex2:SetPoint("TOPLEFT",5,-100)
aboutTab.helpedTex2:SetTexture("Interface\\BattlefieldFrame\\Battleground-Alliance.png")

aboutTab.stringThanks = aboutTab:CreateFontString("rolestring", "OVERLAY", "GameFontNormal")
aboutTab.stringThanks:SetPoint("BOTTOMLEFT",10,10)
aboutTab.stringThanks:SetJustifyH("CENTER")
aboutTab.stringThanks:SetWidth(220)
aboutTab.stringThanks:SetText(HOPADDON_COMMUNITYTHANKS)

-- ATTACHING TO THE MAIN MODULE --

-- button on main frame
hopAddon.buttonOptions = CreateFrame("Button","optionsOnMain",hopAddon,"BrowserButtonTemplate")
hopAddon.buttonOptions:SetSize(25,25)
hopAddon.buttonOptions:SetPoint("TOPLEFT",6,4)
hopAddon.buttonOptions.Icon = hopAddon.buttonOptions:CreateTexture("butOptionsTex","OVERLAY")
hopAddon.buttonOptions.Icon:SetSize(14,14)
hopAddon.buttonOptions.Icon:SetPoint("CENTER",0,0)
hopAddon.buttonOptions.Icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
hopAddon.buttonOptions.tooltip = OPTIONS
-- override on enter, onhide event is inside template
hopAddon.buttonOptions:SetScript("OnEnter", function(button)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT", 0, -25)
	GameTooltip:SetText(OPTIONS, 1, 1, 1, true)
	GameTooltip:Show()
end)
-- toggle options frame on click
hopAddon.buttonOptions:SetScript("OnClick", function(button)
	if not hopAddon.optionsFrame:IsShown() then
		hopAddon.optionsFrame:Show()
	else
		hopAddon.optionsFrame:Hide()	
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)