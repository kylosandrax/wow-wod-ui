-- ResolveStatus v1.3
local f = CreateFrame("Frame")
local config = CreateFrame("Frame")

f.ResolveData = {}
f.DamageData = {}
f.StatusBar = {}
f.LastReport = {}
f.ResolveMax = 0
f.DamageMax = 0
f.fightStart = 0
f.fightEnd = 0
f.player = (UnitName("player")).." - "..(GetRealmName())
f.label = "|cffFF6633ResolveStatus: |r"

local db
local ResolveName = (GetSpellInfo(158300))

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
f:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
f:RegisterUnitEvent("UNIT_AURA","player")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")

f:SetScript("OnEvent", 
function(self, event, ...) 
	if self[event] then
		self[event](...)
	end
end)

local 	max,min,random,tinsert,strformat,UnitStat,UnitAura,GetRealZoneText = 
		max,min,random,tinsert,string.format,UnitStat,UnitAura,GetRealZoneText

local function isTank()
	return IsPlayerSpell(158298)
end

local function shutdown()
	f:SetScript("OnEvent",nil)
	f.StatusBar:Hide()
	SlashCmdList["RESOLVESTATUS"] = nil
end

local function toggle(flag)
	if flag then
		f:RegisterUnitEvent("UNIT_AURA","player")
		f:RegisterEvent("PLAYER_REGEN_ENABLED")
		f:RegisterEvent("PLAYER_REGEN_DISABLED")
		local PlayerInInstance, InstanceType = IsInInstance()
		if (not ResolveStatusDB.instance) or (ResolveStatusDB.instance and (InstanceType == "party" or InstanceType == "raid")) then
			if (not ResolveStatusDB.combat) or (ResolveStatusDB.combat and InCombatLockdown()) then
				f.StatusBar:Show()
			elseif ResolveStatusDB.combat and (not InCombatLockdown()) then
				f.StatusBar:Hide()
			end
		else
			f.StatusBar:Hide()
		end
	else
		f:UnregisterEvent("UNIT_AURA")
		f:UnregisterEvent("PLAYER_REGEN_ENABLED")
		f:UnregisterEvent("PLAYER_REGEN_DISABLED")
		f.StatusBar:Hide()
	end
end

local function formatTime(timenum)
	local text = ""
	local minutes = math.floor(timenum/60);
	local seconds = math.fmod(timenum,60);
	local text = tostring(timenum);
	if minutes > 0 then
		text = strformat("%d min:%d sec",minutes,seconds)
	elseif seconds > 0 then
		text = strformat("%d sec",seconds)
	end
	return text == "" and "0" or text
end

local function getBoolean(val)
	if val then
		return true
	else
		return false
	end
end

local function ResolveReport(ResolveMax, ResolveAverage, DamageMax, DamageAverage, FightDuration)
	wipe(f.LastReport)
	local zone = GetRealZoneText()
	db[zone] = db[zone] or {}
	local fight = {}
	if ResolveMax > 0 then
		tinsert(f.LastReport,{"Max Resolve:",tostring(ResolveMax).."%"})
		if ResolveStatusDB.keepSession then tinsert(fight,{"MaxResolve",ResolveMax}) end
	end
	if ResolveAverage > 0 then
		tinsert(f.LastReport,{"Avg Resolve:",tostring(floor(ResolveAverage)).."%"})
		if ResolveStatusDB.keepSession then tinsert(fight,{"AvgResolve",floor(ResolveAverage)}) end
	end
	if DamageMax > 0 then
		tinsert(f.LastReport,{"Max Damage:",tostring(DamageMax)})
		if ResolveStatusDB.keepSession then tinsert(fight,{"MaxDamage",DamageMax}) end
	end
	if DamageAverage > 0 then
		tinsert(f.LastReport,{"Avg Damage:",tostring(floor(DamageAverage))})
		if ResolveStatusDB.keepSession then tinsert(fight,{"AvgDamage",floor(DamageAverage)}) end
	end
	if FightDuration > 0 then
		local FightDurationText = formatTime(FightDuration)
		tinsert(f.LastReport,{"Fight duration:",tostring(FightDurationText)})
		if ResolveStatusDB.keepSession then tinsert(fight,{"Duration",FightDurationText}) end
	end
	if ResolveStatusDB.keepSession then tinsert(db[zone],fight) end
	if ResolveStatusDB.spam then
		DEFAULT_CHAT_FRAME:AddMessage(f.label.."Report")
		for i,v in ipairs(f.LastReport) do
			DEFAULT_CHAT_FRAME:AddMessage(v[1].." "..v[2])
		end
	end
end

local function SaveResolveCoordinates()
	ResolveStatusDB.PositionX, ResolveStatusDB.PositionY = f.StatusBar:GetCenter()
end

local function SetDefaultValues()
	if not (ResolveStatusDB.locked == true or ResolveStatusDB.locked == false) then
		ResolveStatusDB.locked = false
	end
	if not (ResolveStatusDB.border == true or ResolveStatusDB.border == false) then
		ResolveStatusDB.border = true
	end
	if not (ResolveStatusDB.combat == true or ResolveStatusDB.border == combat) then
		ResolveStatusDB.combat = false
	end
	if not (ResolveStatusDB.instance == true or ResolveStatusDB.instance == false) then
		ResolveStatusDB.instance = false
	end
	if not (ResolveStatusDB.spam == true or ResolveStatusDB.spam == false) then	
		ResolveStatusDB.spam = false
	end
	if not (ResolveStatusDB.keepSession == true or ResolveStatusDB.keepSession == false) then	
		ResolveStatusDB.keepSession = false
	end
	if not ResolveStatusDB.bgalpha then
		ResolveStatusDB.bgalpha = 1
	end
	if not ResolveStatusDB.width then
		ResolveStatusDB.width = 200
	end
	if not ResolveStatusDB.height then
		ResolveStatusDB.height = 20
	end
	if not ResolveStatusDB.fontsize then
		ResolveStatusDB.fontsize = 12
	end
	if not ResolveStatusDB.fontpath then
		ResolveStatusDB.fontpath = "Default"
	end
end

local function ResetResolveStatus()
	ResolveStatusDB.locked = false
	ResolveStatusDB.border = true
	ResolveStatusDB.combat = false
	ResolveStatusDB.instance = false
	ResolveStatusDB.spam = false	
	ResolveStatusDB.keepSession = false
	ResolveStatusDB.PositionX, ResolveStatusDB.PositionY = nil
	ResolveStatusDB.bgalpha = 1
	ResolveStatusDB.width = 200
	ResolveStatusDB.height = 20
	ResolveStatusDB.fontsize = 12
	ResolveStatusDB.fontpath = "Default"
end

local function createResolveStatusBar()
	local bar = CreateFrame("StatusBar", "ResolveStatus_StatusBar", UIParent)
	
	SetDefaultValues()
	
	-- Set bar dimensions
	bar:SetWidth(ResolveStatusDB.width)
	bar:SetHeight(ResolveStatusDB.height)
	bar:SetOrientation("HORIZONTAL")
	
	-- Set bar position
	bar:ClearAllPoints()
	if (ResolveStatusDB.PositionX and ResolveStatusDB.PositionY) then
		bar:SetPoint("CENTER","UIParent","BOTTOMLEFT",ResolveStatusDB.PositionX, ResolveStatusDB.PositionY)
	else
		bar:SetPoint("CENTER",nil,"CENTER")
	end
	bar:SetClampedToScreen(true)
	
	-- Set background color
	bar:SetBackdrop({
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
		tile = true,
		tileSize = 16,
	})
	bar:SetBackdropColor(0,0,0,ResolveStatusDB.bgalpha or 1)
	
	-- Set bar texture and color
	bar:SetStatusBarTexture([[Interface\TARGETINGFRAME\UI-StatusBar]],"ARTWORK")
	bar:GetStatusBarTexture():SetVertexColor(255/255, 0/255, 0/255, 1)
	
	-- Set border texture
	local border = bar:CreateTexture(nil, "OVERLAY")
	border:SetPoint("CENTER")
	border:SetWidth(bar:GetWidth()*1.05)
	border:SetHeight(bar:GetHeight()*1.28)
	border:SetTexture([[Interface\Tooltips\UI-StatusBar-Border]])
	bar.Border = border
	if not ResolveStatusDB.border then
		bar.Border:Hide()
	end
	
	-- Set text
	local bartext = bar:CreateFontString(nil, "OVERLAY")
	bar.Text = bartext
	if bar.Text:SetFont("Interface\\AddOns\\ResolveStatus\\Fonts\\"..ResolveStatusDB.fontpath,ResolveStatusDB.fontsize) then
		bar.Text:SetFont(ResolveStatusDB.fontpath,ResolveStatusDB.fontsize)
	else
		bar.Text:SetFont("Fonts\\FRIZQT__.TTF",ResolveStatusDB.fontsize)
	end

	bar.Text:SetPoint("CENTER",bar,"CENTER",0,0)
	bar.Text:SetTextColor(1,1,1,0.85)
	
	bar:SetMinMaxValues(0,1)
	bar:SetValue(0)
	
	bar:SetMovable(true);
	bar:RegisterForDrag("LeftButton");

	bar:SetScript("OnDragStart",function(self, button) if not bar.locked then self:StartMoving() end end);
	bar:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); SaveResolveCoordinates() end);
	bar:SetScript("OnEnter", 
	function(self)
		if InCombatLockdown() then return end
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); 
		GameTooltip:SetClampedToScreen(true);
		GameTooltip:ClearLines();
		GameTooltip:SetText("|TInterface\\Icons\\Ability_Paladin_ShieldofVengeance:16|t Resolve Report", 1, 0.4, 0.4, 1)
		if #(f.LastReport) > 0 then
			for i,v in ipairs(f.LastReport) do 
				GameTooltip:AddDoubleLine(v[1],v[2],1,0.8,0,0.4,0.8,0.8); 
			end 
		end
		GameTooltip:Show()
	end);
	bar:SetScript("OnLeave", function(self) GameTooltip_Hide() end);
	bar:EnableMouse(true)
	if not ResolveStatusDB.locked then
		bar.locked = nil
	else
		bar.locked = true
	end

	bar:Show();  

	return bar;
end

function UpdateResolveStatusBar()
	-- set lock state
	f.StatusBar.locked = ResolveStatusDB.locked
	
	-- set border state
	if ResolveStatusDB.border then f.StatusBar.Border:Show() else f.StatusBar.Border:Hide()	end
	
	-- show or hide based on configuration and current situation
	local PlayerInInstance, InstanceType = IsInInstance()
	if (not ResolveStatusDB.instance) or (ResolveStatusDB.instance and (InstanceType == "party" or InstanceType == "raid")) then
		if (not ResolveStatusDB.combat) or (ResolveStatusDB.combat and InCombatLockdown()) then
			f.StatusBar:Show()
		elseif ResolveStatusDB.combat and (not InCombatLockdown()) then
			f.StatusBar:Hide()
		end
	else
		f.StatusBar:Hide()
	end
	
	-- set position
	if (ResolveStatusDB.PositionX and ResolveStatusDB.PositionY) then
		f.StatusBar:ClearAllPoints();
		f.StatusBar:SetPoint("CENTER","UIParent","BOTTOMLEFT",ResolveStatusDB.PositionX, ResolveStatusDB.PositionY)
	else
		f.StatusBar:ClearAllPoints();
		f.StatusBar:SetPoint("CENTER",nil,"CENTER",0,0)
	end
	
	-- set opacity
	f.StatusBar:SetBackdropColor(0,0,0,ResolveStatusDB.bgalpha)
	
	-- set size (bar and border)
	f.StatusBar:SetWidth(ResolveStatusDB.width)
	f.StatusBar.Border:SetWidth(ResolveStatusDB.width*1.05)
	f.StatusBar:SetHeight(ResolveStatusDB.height)
	f.StatusBar.Border:SetHeight(ResolveStatusDB.height*1.28)
	
	-- set font, font size and position
	if f.StatusBar.Text:SetFont("Interface\\AddOns\\ResolveStatus\\Fonts\\"..ResolveStatusDB.fontpath,ResolveStatusDB.fontsize) then
		f.StatusBar.Text:SetFont("Interface\\AddOns\\ResolveStatus\\Fonts\\"..ResolveStatusDB.fontpath,ResolveStatusDB.fontsize)
	else
		f.StatusBar.Text:SetFont("Fonts\\FRIZQT__.TTF",ResolveStatusDB.fontsize)
	end
	f.StatusBar.Text:SetPoint("CENTER",f.StatusBar,"CENTER",0,0)
end

local function SlashHandler(command)
	-- Open Interface\Add-on menu if user types "/rslv" or "/resolvestatus"
	if command == "" then
		InterfaceOptionsFrame_Show()
		InterfaceOptionsFrame_OpenToCategory(config)
	end
end

function CreateResolveConfig()
	if configOpenRunOnce then
		return
	end
	configOpenRunOnce = true
	config.name = "Resolve Status"
	config:Hide()
	InterfaceOptions_AddCategory(config)
		
	-- Simple function to round numbers
	local SimpleRound = function(val,valStep)
		return floor(val/valStep)*valStep
	end
	
	-- Window title
	config.title = config:CreateFontString("ResolveConfigTitleFont", "ARTWORK", "GameFontNormal")
	config.title:SetFont(GameFontNormal:GetFont(), 16)
	config.title:SetPoint("TOPLEFT", config, 10, -10)
	config.title:SetText("Resolve Status")
	
	-- Reset button
	config.ButtonReset = CreateFrame("Button", "ResolveStatusButtonReset", config, "OptionsButtonTemplate")
	config.ButtonReset:SetPoint("BOTTOMLEFT", config, "BOTTOMLEFT", 15, 15)
	config.ButtonReset:SetSize(125,35)
	config.ButtonReset:SetText("Reset to default")
	config.ButtonReset:SetScript("OnClick", function(self)
		ResetResolveStatus()
		UpdateResolveStatusBar()
		config.ButtonLocked:SetChecked(ResolveStatusDB.locked)
		config.ButtonBorder:SetChecked(ResolveStatusDB.border)
		config.ButtonCombat:SetChecked(ResolveStatusDB.combat)
		config.ButtonInstance:SetChecked(ResolveStatusDB.instance)
		config.ButtonReportToSelf:SetChecked(ResolveStatusDB.spam)
		config.ButtonSessionLogging:SetChecked(ResolveStatusDB.keepSession)
		config.SliderAlpha:SetValue(ResolveStatusDB.bgalpha*100)
		config.SliderWidth:SetValue(ResolveStatusDB.width)
		config.BoxWidth:SetNumber(ResolveStatusDB.width)
		config.SliderHeight:SetValue(ResolveStatusDB.height)
		config.BoxHeight:SetNumber(ResolveStatusDB.height)
		config.SliderFontSize:SetValue(ResolveStatusDB.fontsize)
		config.BoxFontSize:SetNumber(ResolveStatusDB.fontsize)
		config.BoxFontPath:SetText(ResolveStatusDB.fontpath)
    end)

	-- Lock config
	config.ButtonLocked = CreateFrame("CheckButton", "ResolveStatusButtonLocked", config, "InterfaceOptionsCheckButtonTemplate")
	config.ButtonLocked:SetPoint("TOPLEFT", config, 10, -28)
	config.ButtonLocked:SetChecked(ResolveStatusDB.locked)
	config.ButtonLocked:SetScript("OnClick", function(self)
		if self:GetChecked() then
			ResolveStatusDB.locked = true
			UpdateResolveStatusBar()
		else
			ResolveStatusDB.locked = false
			UpdateResolveStatusBar()
		end
	end)
	config.TextLocked = config:CreateFontString("ResolveStatusTextLocked", "ARTWORK", "GameFontNormal")
	config.TextLocked:SetFont(GameFontNormal:GetFont(), 12)
	config.TextLocked:SetPoint("LEFT", config.ButtonLocked, 30, 0)
	config.TextLocked:SetText("|cffffffffLock bar|r")
	
	-- Border config
	config.ButtonBorder = CreateFrame("CheckButton", "ResolveStatusButtonBorder", config, "InterfaceOptionsCheckButtonTemplate")
	config.ButtonBorder:SetPoint("TOPLEFT", config, 10, -46)
	config.ButtonBorder:SetChecked(ResolveStatusDB.border)
	config.ButtonBorder:SetScript("OnClick", function(self)
		if self:GetChecked() then
			ResolveStatusDB.border = true
			UpdateResolveStatusBar()
		else
			ResolveStatusDB.border = false
			UpdateResolveStatusBar()
		end
	end)
	config.TextBorder = config:CreateFontString("ResolveStatusTextBorder", "ARTWORK", "GameFontNormal")
	config.TextBorder:SetFont(GameFontNormal:GetFont(), 12)
	config.TextBorder:SetPoint("LEFT", config.ButtonBorder, 30, 0)
	config.TextBorder:SetText("|cffffffffShow border|r")
	
	-- Show in combat config
	config.ButtonCombat = CreateFrame("CheckButton", "ResolveStatusButtonCombat", config, "InterfaceOptionsCheckButtonTemplate")
	config.ButtonCombat:SetPoint("TOPLEFT", config, 10, -64)
	config.ButtonCombat:SetChecked(ResolveStatusDB.combat)
	config.ButtonCombat:SetScript("OnClick", function(self)
		if self:GetChecked() then
			ResolveStatusDB.combat = true
			UpdateResolveStatusBar()
		else
			ResolveStatusDB.combat = false
			UpdateResolveStatusBar()
		end
	end)
	config.TextCombat = config:CreateFontString("ResolveStatusTextCombat", "ARTWORK", "GameFontNormal")
	config.TextCombat:SetFont(GameFontNormal:GetFont(), 12)
	config.TextCombat:SetPoint("LEFT", config.ButtonCombat, 30, 0)
	config.TextCombat:SetText("|cffffffffShow in combat only|r")

	-- Show in instance config
	config.ButtonInstance = CreateFrame("CheckButton", "ResolveStatusButtonInstance", config, "InterfaceOptionsCheckButtonTemplate")
	config.ButtonInstance:SetPoint("TOPLEFT", config, 10, -82)
	config.ButtonInstance:SetChecked(ResolveStatusDB.instance)
	config.ButtonInstance:SetScript("OnClick", function(self)
		if self:GetChecked() then
			ResolveStatusDB.instance = true
			UpdateResolveStatusBar()
		else
			ResolveStatusDB.instance = false
			UpdateResolveStatusBar()
		end
	end)
	config.TextInstance = config:CreateFontString("ResolveStatusTextInstance", "ARTWORK", "GameFontNormal")
	config.TextInstance:SetFont(GameFontNormal:GetFont(), 12)
	config.TextInstance:SetPoint("LEFT", config.ButtonInstance, 30, 0)
	config.TextInstance:SetText("|cffffffffShow in Instance only|r")

	-- Show report config
	config.ButtonReportToSelf = CreateFrame("CheckButton", "ResolveStatusButtonReportToSelf", config, "InterfaceOptionsCheckButtonTemplate")
	config.ButtonReportToSelf:SetPoint("TOPLEFT", config, 10, -100)
	config.ButtonReportToSelf:SetChecked(ResolveStatusDB.spam)
	config.ButtonReportToSelf:SetScript("OnClick", function(self)
		if self:GetChecked() then
			ResolveStatusDB.spam = true
			UpdateResolveStatusBar()
		else
			ResolveStatusDB.spam = false
			UpdateResolveStatusBar()
		end
	end)
	config.TextReportToSelf = config:CreateFontString("ResolveStatusTextReportToSelf", "ARTWORK", "GameFontNormal")
	config.TextReportToSelf:SetFont(GameFontNormal:GetFont(), 12)
	config.TextReportToSelf:SetPoint("LEFT", config.ButtonReportToSelf, 30, 0)
	config.TextReportToSelf:SetText("|cffffffffDisplay report in chat|r")

	-- Show session logging config
	config.ButtonSessionLogging = CreateFrame("CheckButton", "ResolveStatusButtonSessionLogging", config, "InterfaceOptionsCheckButtonTemplate")
	config.ButtonSessionLogging:SetPoint("TOPLEFT", config, 10, -118)
	config.ButtonSessionLogging:SetChecked(ResolveStatusDB.keepSession)
	config.ButtonSessionLogging:SetScript("OnClick", function(self)
		if self:GetChecked() then
			ResolveStatusDB.keepSession = true
			UpdateResolveStatusBar()
		else
			ResolveStatusDB.keepSession = false
			UpdateResolveStatusBar()
		end
	end)
	config.TextSessionLogging = config:CreateFontString("ResolveStatusTextSessionLogging", "ARTWORK", "GameFontNormal")
	config.TextSessionLogging:SetFont(GameFontNormal:GetFont(), 12)
	config.TextSessionLogging:SetPoint("LEFT", config.ButtonSessionLogging, 30, 0)
	config.TextSessionLogging:SetText("|cffffffffSave session reports in 'SavedVariables'|r")

	-- Show opacity config
	config.SliderAlpha = CreateFrame("Slider", "ResolveStatusSliderAlpha", config, "OptionsSliderTemplate")
	config.SliderAlpha:SetPoint("TOPLEFT", config, 10, -160)
	config.SliderAlpha.textLow = _G["ResolveStatusSliderAlpha".."Low"]
	config.SliderAlpha.textHigh = _G["ResolveStatusSliderAlpha".."High"]
	config.SliderAlpha.text = _G["ResolveStatusSliderAlpha".."Text"]
	config.SliderAlpha:SetMinMaxValues(0,100)
	config.SliderAlpha.minValue, config.SliderAlpha.maxValue = config.SliderAlpha:GetMinMaxValues() 
	config.SliderAlpha.textLow:SetText(config.SliderAlpha.minValue)
	config.SliderAlpha.textHigh:SetText(config.SliderAlpha.maxValue)
	config.SliderAlpha.text:SetText("Background opacity")
	config.SliderAlpha:SetValue(ResolveStatusDB.bgalpha*100)
	config.SliderAlpha:SetValueStep(5)
	config.SliderAlpha:SetScript("OnValueChanged", function(self,value)
		config.SliderAlpha:SetValue(SimpleRound (value,config.SliderAlpha:GetValueStep()))
		ResolveStatusDB.bgalpha = (config.SliderAlpha:GetValue()/100)
		UpdateResolveStatusBar()
    end)
	config.SliderAlpha:SetScript("OnMouseWheel", function(self, delta)
		if delta > 0 then
			self:SetValue(self:GetValue() + 5)
		else
			self:SetValue(self:GetValue() - 5)
		end
    end)

	-- Show width config
	config.SliderWidth = CreateFrame("Slider", "ResolveStatusSliderWidth", config, "OptionsSliderTemplate")
	config.SliderWidth:SetPoint("TOPLEFT", config, 10, -190)
	config.SliderWidth.textLow = _G["ResolveStatusSliderWidth".."Low"]
	config.SliderWidth.textHigh = _G["ResolveStatusSliderWidth".."High"]
	config.SliderWidth.text = _G["ResolveStatusSliderWidth".."Text"]
	config.SliderWidth:SetMinMaxValues(50,600)
	config.SliderWidth.minValue, config.SliderWidth.maxValue = config.SliderWidth:GetMinMaxValues() 
	config.SliderWidth.textLow:SetText(config.SliderWidth.minValue)
	config.SliderWidth.textHigh:SetText(config.SliderWidth.maxValue)
	config.SliderWidth.text:SetText("Bar width")
	config.SliderWidth:SetValue(ResolveStatusDB.width)
	config.SliderWidth:SetValueStep(1)
	config.SliderWidth:SetScript("OnValueChanged", function(self,value)
		config.SliderWidth:SetValue(SimpleRound (value,config.SliderWidth:GetValueStep()))
		ResolveStatusDB.width = (config.SliderWidth:GetValue())
		config.BoxWidth:SetNumber(ResolveStatusDB.width)
		UpdateResolveStatusBar()
    end)
	config.SliderWidth:SetScript("OnMouseWheel", function(self, delta)
		if delta > 0 then
			self:SetValue(self:GetValue() + 5)
		else
			self:SetValue(self:GetValue() - 5)
		end
    end)
	
	config.ButtonWidthMinus = CreateFrame("Button", "ResolveStatusButtonWidthMinus", config, "OptionsButtonTemplate")
	config.ButtonWidthMinus:SetPoint("LEFT", config.SliderWidth, "RIGHT", 10, 0)
	config.ButtonWidthMinus:SetSize(25,20)
	config.ButtonWidthMinus:SetText("-")
	config.ButtonWidthMinus:SetScript("OnClick", function(self)
		if config.SliderWidth:GetValue() > 50 then
			config.SliderWidth:SetValue(config.SliderWidth:GetValue()-1)
			ResolveStatusDB.width = (config.SliderWidth:GetValue())
			config.BoxWidth:SetNumber(ResolveStatusDB.width)
			UpdateResolveStatusBar()
		end
    end)
	
	config.BoxWidth = CreateFrame("EditBox", "ResolveStatusBoxWidth", config, "InputBoxTemplate")
	config.BoxWidth:SetPoint("LEFT", config.ButtonWidthMinus,"RIGHT", 5, 0)
	config.BoxWidth:SetSize(25, 20)
	config.BoxWidth:SetNumeric(true)
	config.BoxWidth:SetAutoFocus(false)
	config.BoxWidth:SetScript("OnEnterPressed", function(self)
		SetWidth = self:GetNumber()
		if SetWidth then
			if SetWidth < 50 then
				self:SetNumber(50)
				ResolveStatusDB.width = 50
				config.SliderWidth:SetValue(ResolveStatusDB.width)
				UpdateResolveStatusBar()
			elseif SetWidth > 600 then
				ResolveStatusDB.width = 600
				self:SetNumber(600)
				config.SliderWidth:SetValue(ResolveStatusDB.width)
				UpdateResolveStatusBar()
			else
				ResolveStatusDB.width = SetWidth
				config.SliderWidth:SetValue(ResolveStatusDB.width)
				UpdateResolveStatusBar()
			end
		end
		self:ClearFocus()
	end)
	
	config.ButtonWidthPlus = CreateFrame("Button", "ResolveStatusButtonWidthPlus", config, "OptionsButtonTemplate")
	config.ButtonWidthPlus:SetPoint("LEFT", config.BoxWidth, "RIGHT", 0, 0)
	config.ButtonWidthPlus:SetSize(25,20)
	config.ButtonWidthPlus:SetText("+")
	config.ButtonWidthPlus:SetScript("OnClick", function(self)
		if config.SliderWidth:GetValue() < 600 then
			config.SliderWidth:SetValue(config.SliderWidth:GetValue()+1)
			ResolveStatusDB.width = (config.SliderWidth:GetValue())
			config.BoxWidth:SetNumber(ResolveStatusDB.width)
			UpdateResolveStatusBar()
		end
    end)
	
	-- Show height config
	config.SliderHeight = CreateFrame("Slider", "ResolveStatusSliderHeight", config, "OptionsSliderTemplate")
	config.SliderHeight:SetPoint("TOPLEFT", config, 10, -220)
	config.SliderHeight.textLow = _G["ResolveStatusSliderHeight".."Low"]
	config.SliderHeight.textHigh = _G["ResolveStatusSliderHeight".."High"]
	config.SliderHeight.text = _G["ResolveStatusSliderHeight".."Text"]
	config.SliderHeight:SetMinMaxValues(10,100)
	config.SliderHeight.minValue, config.SliderHeight.maxValue = config.SliderHeight:GetMinMaxValues() 
	config.SliderHeight.textLow:SetText(config.SliderHeight.minValue)
	config.SliderHeight.textHigh:SetText(config.SliderHeight.maxValue)
	config.SliderHeight.text:SetText("Bar height")
	config.SliderHeight:SetValue(ResolveStatusDB.height)
	config.SliderHeight:SetValueStep(1)	
	config.SliderHeight:SetScript("OnValueChanged", function(self,value)
		config.SliderHeight:SetValue(SimpleRound (value,config.SliderHeight:GetValueStep()))
		ResolveStatusDB.height = (config.SliderHeight:GetValue())
		config.BoxHeight:SetNumber(ResolveStatusDB.height)
		UpdateResolveStatusBar()
    end)
	config.SliderHeight:SetScript("OnMouseWheel", function(self, delta)
		if delta > 0 then
			self:SetValue(self:GetValue() + 5)
		else
			self:SetValue(self:GetValue() - 5)
		end
    end)
	
	config.ButtonHeightMinus = CreateFrame("Button", "ResolveStatusButtonHeightMinus", config, "OptionsButtonTemplate")
	config.ButtonHeightMinus:SetPoint("LEFT", config.SliderHeight, "RIGHT", 10, 0)
	config.ButtonHeightMinus:SetSize(25,20)
	config.ButtonHeightMinus:SetText("-")
	config.ButtonHeightMinus:SetScript("OnClick", function(self)
		if config.SliderHeight:GetValue() > 10 then
			config.SliderHeight:SetValue(config.SliderHeight:GetValue()-1)
			ResolveStatusDB.height = (config.SliderHeight:GetValue())
			config.BoxHeight:SetNumber(ResolveStatusDB.height)
			UpdateResolveStatusBar()
		end
    end)
	
	config.BoxHeight = CreateFrame("EditBox", "ResolveStatusBoxHeight", config, "InputBoxTemplate")
	config.BoxHeight:SetPoint("LEFT", config.ButtonHeightMinus,"RIGHT", 5, 0)
	config.BoxHeight:SetSize(25, 20)
	config.BoxHeight:SetNumeric(true)
	config.BoxHeight:SetAutoFocus(false)
	config.BoxHeight:SetScript("OnEnterPressed", function(self)
		SetHeight = self:GetNumber()
		if SetHeight then
			if SetHeight < 10 then
				self:SetNumber(10)
				ResolveStatusDB.height = 10
				config.SliderHeight:SetValue(ResolveStatusDB.height)
				UpdateResolveStatusBar()
			elseif SetHeight > 100 then
				self:SetNumber(100)
				ResolveStatusDB.height = 100
				config.SliderHeight:SetValue(ResolveStatusDB.height)
				UpdateResolveStatusBar()
			else
				ResolveStatusDB.height = SetHeight
				config.SliderHeight:SetValue(ResolveStatusDB.height)
				UpdateResolveStatusBar()
			end
		end
		self:ClearFocus()
	end)
	
	config.ButtonHeightPlus = CreateFrame("Button", "ResolveStatusButtonHeightPlus", config, "OptionsButtonTemplate")
	config.ButtonHeightPlus:SetPoint("LEFT", config.BoxHeight, "RIGHT", 0, 0)
	config.ButtonHeightPlus:SetSize(25,20)
	config.ButtonHeightPlus:SetText("+")
	config.ButtonHeightPlus:SetScript("OnClick", function(self)
		if config.SliderHeight:GetValue() < 600 then
			config.SliderHeight:SetValue(config.SliderHeight:GetValue()+1)
			ResolveStatusDB.height = (config.SliderHeight:GetValue())
			config.BoxHeight:SetNumber(ResolveStatusDB.height)
			UpdateResolveStatusBar()
		end
    end)
	
	-- Show font size config
	config.SliderFontSize = CreateFrame("Slider", "ResolveStatusSliderFontSize", config, "OptionsSliderTemplate")
	config.SliderFontSize:SetPoint("TOPLEFT", config, 10, -250)
	config.SliderFontSize.textLow = _G["ResolveStatusSliderFontSize".."Low"]
	config.SliderFontSize.textHigh = _G["ResolveStatusSliderFontSize".."High"]
	config.SliderFontSize.text = _G["ResolveStatusSliderFontSize".."Text"]
	config.SliderFontSize:SetMinMaxValues(7,30)
	config.SliderFontSize.minValue, config.SliderFontSize.maxValue = config.SliderFontSize:GetMinMaxValues() 
	config.SliderFontSize.textLow:SetText(config.SliderFontSize.minValue)
	config.SliderFontSize.textHigh:SetText(config.SliderFontSize.maxValue)
	config.SliderFontSize.text:SetText("Font size")
	config.SliderFontSize:SetValue(ResolveStatusDB.fontsize)
	config.SliderFontSize:SetValueStep(1)
	config.SliderFontSize:SetScript("OnValueChanged", function(self,value)
		config.SliderFontSize:SetValue(SimpleRound (value,config.SliderFontSize:GetValueStep()))
		ResolveStatusDB.fontsize = (config.SliderFontSize:GetValue())
		config.BoxFontSize:SetNumber(ResolveStatusDB.fontsize)
		UpdateResolveStatusBar()
    end)
	config.SliderFontSize:SetScript("OnMouseWheel", function(self, delta)
		if delta > 0 then
			self:SetValue(self:GetValue() + 1)
		else
			self:SetValue(self:GetValue() - 1)
		end
    end)
	
	config.ButtonReset = CreateFrame("Button", "ResolveStatusButtonReset", config, "OptionsButtonTemplate")
	config.ButtonReset:SetPoint("LEFT", config.SliderFontSize, "RIGHT", 10, 0)
	config.ButtonReset:SetSize(25,20)
	config.ButtonReset:SetText("-")
	config.ButtonReset:SetScript("OnClick", function(self)
		if config.SliderFontSize:GetValue() > 7 then
			config.SliderFontSize:SetValue(config.SliderFontSize:GetValue()-1)
			ResolveStatusDB.fontsize = (config.SliderFontSize:GetValue())
			config.BoxFontSize:SetNumber(ResolveStatusDB.fontsize)
			UpdateResolveStatusBar()
		end
    end)
	
	config.BoxFontSize = CreateFrame("EditBox", "ResolveStatusBoxFontSize", config, "InputBoxTemplate")
	config.BoxFontSize:SetPoint("LEFT", config.ButtonReset,"RIGHT", 5, 0)
	config.BoxFontSize:SetSize(25, 20)
	config.BoxFontSize:SetNumeric(true)
	config.BoxFontSize:SetAutoFocus(false)
	config.BoxFontSize:SetScript("OnEnterPressed", function(self)
		SetHeight = self:GetNumber()
		if SetHeight then
			if SetHeight < 7 then
				self:SetNumber(7)
				ResolveStatusDB.fontsize = 7
				config.SliderFontSize:SetValue(ResolveStatusDB.fontsize)
				UpdateResolveStatusBar()
			elseif SetHeight > 30 then
				self:SetNumber(30)
				ResolveStatusDB.fontsize = 30
				config.SliderFontSize:SetValue(ResolveStatusDB.fontsize)
				UpdateResolveStatusBar()
			else
				ResolveStatusDB.fontsize = SetHeight
				config.SliderFontSize:SetValue(ResolveStatusDB.fontsize)
				UpdateResolveStatusBar()
			end
		end
		self:ClearFocus()
	end)
	
	config.ButtonFontSizePlus = CreateFrame("Button", "ResolveStatusButtonFontSizePlus", config, "OptionsButtonTemplate")
	config.ButtonFontSizePlus:SetPoint("LEFT", config.BoxFontSize, "RIGHT", 0, 0)
	config.ButtonFontSizePlus:SetSize(25,20)
	config.ButtonFontSizePlus:SetText("+")
	config.ButtonFontSizePlus:SetScript("OnClick", function(self)
		if config.SliderFontSize:GetValue() < 30 then
			config.SliderFontSize:SetValue(config.SliderFontSize:GetValue()+1)
			ResolveStatusDB.fontsize = (config.SliderFontSize:GetValue())
			config.BoxFontSize:SetNumber(ResolveStatusDB.fontsize)
			UpdateResolveStatusBar()
		end
    end)
	
	-- Show font selection
	config.TextFontPath = config:CreateFontString("ResolveStatusTextFontPath", "ARTWORK", "GameFontNormal")
	config.TextFontPath:SetFont(GameFontNormal:GetFont(), 12)
	config.TextFontPath:SetPoint("TOPLEFT", config, 15, -280)
	config.TextFontPath:SetText("|cffffffffFont file (.ttf format)|r")
	
	config.BoxFontPath = CreateFrame("EditBox", "ResolveStatusBoxFontPath", config, "InputBoxTemplate")
	config.BoxFontPath:SetPoint("TOPLEFT", config.TextFontPath,"BOTTOMLEFT", 0, 0)
	config.BoxFontPath:SetSize(250, 30)
	config.BoxFontPath:SetAutoFocus(false)
	config.BoxFontPath:SetScript("OnEnterPressed", function(self)
		SelectedFont = self:GetText()
		if not (SelectedFont == "" or SelectedFont == "Default" or SelectedFont == "default" or SelectedFont == "DEFAULT") then
			 if string.find(SelectedFont,"\.ttf$") then
				fontpath = SelectedFont
			else
				fontpath = SelectedFont.."\.ttf"
			end
			if f.StatusBar.Text:SetFont("Interface\\AddOns\\ResolveStatus\\Fonts\\"..fontpath,ResolveStatusDB.fontsize) then
				ResolveStatusDB.fontpath = fontpath
				UpdateResolveStatusBar()
				self:SetText(ResolveStatusDB.fontpath)
			else
				self:SetText("Invalid file")
			end
		else
			ResolveStatusDB.fontpath = "Default"
			UpdateResolveStatusBar()
			self:SetText("Default")
		end
		self:ClearFocus()
	end)
	config.BoxFontPath:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT"); 
		GameTooltip:ClearLines();
		GameTooltip:SetText("|t Font file from '\\ResolveStatus\\Fonts' directory", 1, 1, 1, 1)
		GameTooltip:Show()
	end);
	config.BoxFontPath:SetScript("OnLeave", function(self) GameTooltip_Hide() end);
	
	config.TextFontExample = config:CreateFontString("ResolveStatusTextFontExample", "ARTWORK", "GameFontNormal")
	config.TextFontExample:SetFont(GameFontNormal:GetFont(), 10)
	config.TextFontExample:SetPoint("TOPLEFT", config.BoxFontPath,"BOTTOMLEFT", 0, 0)
	config.TextFontExample:SetJustifyH("LEFT")
	config.TextFontExample:SetText("|cDDDDDDDDExample: 'big_noodle_titling.ttf'|nType 'Default' or leave blank to reset|r")

	-- Refresh pannel on display
	config:SetScript("OnShow", function(self)
		self.ButtonLocked:SetChecked(ResolveStatusDB.locked)
		self.ButtonBorder:SetChecked(ResolveStatusDB.border)
		self.ButtonCombat:SetChecked(ResolveStatusDB.combat)
		self.ButtonInstance:SetChecked(ResolveStatusDB.instance)
		self.ButtonReportToSelf:SetChecked(ResolveStatusDB.spam)
		self.ButtonSessionLogging:SetChecked(ResolveStatusDB.keepSession)
		self.SliderAlpha:SetValue(ResolveStatusDB.bgalpha*100)
		self.SliderWidth:SetValue(ResolveStatusDB.width)
		self.BoxWidth:SetNumber(ResolveStatusDB.width)
		self.SliderHeight:SetValue(ResolveStatusDB.height)
		self.BoxHeight:SetNumber(ResolveStatusDB.height)
		self.SliderFontSize:SetValue(ResolveStatusDB.fontsize)
		self.BoxFontSize:SetNumber(ResolveStatusDB.fontsize)
		if not (ResolveStatusDB.fontpath == "Default") then
			self.BoxFontPath:SetText(ResolveStatusDB.fontpath)
		else
			self.BoxFontPath:SetText("Default")
		end
	end)
end

function f.PLAYER_LOGIN()
	local _, PlayerClass = UnitClass("player")
	if not (PlayerClass == "WARRIOR" or PlayerClass == "DRUID" or PlayerClass == "DEATHKNIGHT" or PlayerClass == "PALADIN" or PlayerClass == "MONK") then
		shutdown()
	end
	if PlayerClass == "DRUID" then
		f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	end
	f:RegisterEvent("PLAYER_ALIVE")
	local text = "0% (0)"
	f.StatusBar:SetMinMaxValues(0,240)
	f.StatusBar:SetValue(0)
	f.StatusBar.Text:SetText(text)
	f:UnregisterEvent("PLAYER_LOGIN")
	toggle(isTank())
end

function f.UPDATE_SHAPESHIFT_FORM()
	local form = GetShapeshiftFormID()
	if form and form == BEAR_FORM then
		toggle(true)
	else
		toggle(false)
	end
end

function f.PLAYER_ENTERING_WORLD()
	toggle(isTank())
end
f.ACTIVE_TALENT_GROUP_CHANGED = f.PLAYER_ENTERING_WORLD
f.PLAYER_SPECIALIZATION_CHANGED = f.PLAYER_ENTERING_WORLD

function f.PLAYER_ALIVE()
	f:UnregisterEvent("PLAYER_ALIVE")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	toggle(isTank())
end

function f.ADDON_LOADED(...)
	local addon = ...;
	if addon == "ResolveStatus" then
		ResolveHistoryDB = {}
		ResolveHistoryDB[f.player] = {}
		db = ResolveHistoryDB[f.player]
		ResolveStatusDB = ResolveStatusDB or {["keepSession"] = false, ["scale"] = 1, ["border"] = true}
		f.StatusBar = createResolveStatusBar()
		SlashCmdList["RESOLVESTATUS"] = SlashHandler
		SLASH_RESOLVESTATUS1 = "/resolvestatus"
		SLASH_RESOLVESTATUS2 = "/rslv"
		f:UnregisterEvent("ADDON_LOADED")
		CreateResolveConfig()
	end
end

function f.UNIT_AURA(...) 
	local n,_,_,_,_,dur,expi,_,_,_,id,_,_,_,val1,val2,val3 = UnitAura("player", ResolveName, nil, "HELPFUL");
	local ResolveValue,DamageTaken
	
	ResolveValue = val1 or 0
	DamageTaken = val2 or 0
	
	f.ResolveMax = ResolveValue > f.ResolveMax and ResolveValue or f.ResolveMax
	f.DamageMax = DamageTaken > f.DamageMax and DamageTaken or f.DamageMax
	tinsert(f.ResolveData,ResolveValue)
	tinsert(f.DamageData,DamageTaken)
	
	f.StatusBar:SetValue(ResolveValue)
	f.StatusBar.Text:SetText(strformat("%s%% (%s)",ResolveValue,DamageTaken))
end

function f.PLAYER_REGEN_ENABLED() -- out of combat
	-- Calculate average Resolve value
	local ResolveTotal, ResolveRecords, average = 0, #(f.ResolveData), 0
	if ResolveRecords > 0 then
		for _,Resolve in ipairs(f.ResolveData) do
			ResolveTotal = ResolveTotal + Resolve
		end
		ResolveAverage = ResolveTotal/ResolveRecords
	end
	
	-- Calculate average Damage taken in last 10sec
	local DamageTotal, DamageRecords, average = 0, #(f.DamageData), 0
	if DamageRecords > 0 then
		for _,damage in ipairs(f.DamageData) do
			DamageTotal = DamageTotal + damage
		end
		DamageAverage = DamageTotal/DamageRecords
	end
	
	-- Calculate fight duration
	f.fightEnd = GetTime()
	local combattime = 0
	if f.fightStart > 0 and f.fightEnd > f.fightStart then
		combattime = f.fightEnd - f.fightStart
	end
	
	ResolveReport(f.ResolveMax, ResolveAverage, f.DamageMax, DamageAverage, combattime)
	
	-- Cleanup
	wipe(f.ResolveData)
	wipe(f.DamageData)
	f.fightStart = 0
	if ResolveStatusDB.combat then
		f.StatusBar:Hide()
	end
end

function f.PLAYER_REGEN_DISABLED() -- in combat
	f.ResolveMax = 0
	f.DamageMax = 0
	f.fightStart = GetTime()
	f.fightEnd = 0
	if (not ResolveStatusDB.instance) or (ResolveStatusDB.instance and (InstanceType == "party" or InstanceType == "raid")) then
		if ResolveStatusDB.combat then
			f.StatusBar:Show()
		end
	else
		f.StatusBar:Hide()
	end
end