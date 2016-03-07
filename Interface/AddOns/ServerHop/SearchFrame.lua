-- MODULE FOR SEARCHING FRAME 
local var = hopAddon.var
local customOptions = hopAddon.optionsFrame.customSearchOptionsFrame

local DoSearch = false
local searchUpdated = 2.5
local ResultFrames = {}
local SearchString = ""
local SearchKeywords = {}
local FilteredGroupsList = {}
local CustomSearchBlackList = {}
local firstSearch = true

-- Holder
hopAddon.searchFrame = CreateFrame("Frame",nil,hopAddon)
hopAddon.searchFrame:SetSize(HOPADDON_WIDTH,HOPADDON_HEIGHT)
hopAddon.searchFrame:SetPoint("BOTTOM",0,0)

hopAddon.searchFrame.background = hopAddon.searchFrame:CreateTexture(nil,"BORDER")
hopAddon.searchFrame.background:SetSize(HOPADDON_WIDTH+106,HOPADDON_HEIGHT-10)
hopAddon.searchFrame.background:SetPoint("BOTTOM",1,5)
hopAddon.searchFrame.background:SetTexture("Interface\\Challenges\\challenges-besttime-bg")

hopAddon.searchFrame.stringSearching = hopAddon.searchFrame:CreateFontString("searchstatus", "OVERLAY", "QuestFont_Shadow_Huge")
hopAddon.searchFrame.stringSearching:SetPoint("BOTTOM",0,72)
hopAddon.searchFrame.stringSearching:SetText(HOPADDON_SEARCHPAUSED)
hopAddon.searchFrame.stringSearching:SetTextColor(1, 0.914, 0.682, 1)

-- Searching animation block
hopAddon.searchFrame.Waitdot2 = hopAddon.searchFrame:CreateTexture("Waitdot2","ARTWORK")
hopAddon.searchFrame.Waitdot2:SetPoint("BOTTOM",0,45)
hopAddon.searchFrame.Waitdot2:SetAtlas("groupfinder-waitdot",true)
hopAddon.searchFrame.Waitdot2:SetVertexColor(1,1,1,0)

hopAddon.searchFrame.Waitdot1 = hopAddon.searchFrame:CreateTexture("Waitdot2","ARTWORK")
hopAddon.searchFrame.Waitdot1:SetPoint("CENTER", "Waitdot2", -16,0)
hopAddon.searchFrame.Waitdot1:SetAtlas("groupfinder-waitdot",true)
hopAddon.searchFrame.Waitdot1:SetVertexColor(1,1,1,0)

hopAddon.searchFrame.Waitdot3 = hopAddon.searchFrame:CreateTexture("Waitdot2","ARTWORK")
hopAddon.searchFrame.Waitdot3:SetPoint("CENTER", "Waitdot2",16,0)
hopAddon.searchFrame.Waitdot3:SetAtlas("groupfinder-waitdot",true)
hopAddon.searchFrame.Waitdot3:SetVertexColor(1,1,1,0)

hopAddon.searchFrame.anim = hopAddon.searchFrame:CreateAnimationGroup("Searching")
hopAddon.searchFrame.anim:SetLooping("REPEAT")

local function AddAlphaAnimation(child,delay,dur,order,from,to)
	local a = hopAddon.searchFrame.anim:CreateAnimation("ALPHA")
	a:SetChildKey(child) 
	a:SetStartDelay(delay)
	a:SetDuration(dur)
	a:SetOrder(order)
	a:SetFromAlpha(from)
	a:SetToAlpha(to)
end

AddAlphaAnimation("Waitdot1",0.50,0.15,1,0,1)
AddAlphaAnimation("Waitdot2",0.50,0.15,2,0,1)
AddAlphaAnimation("Waitdot3",0.50,0.15,3,0,1)
AddAlphaAnimation("Waitdot1",0.50,0.15,4,1,0)
AddAlphaAnimation("Waitdot2",0.50,0.15,4,1,0)
AddAlphaAnimation("Waitdot3",0.50,0.15,4,1,0)

-- Dungeons drop list mush be shown only when dungeons selected
hopAddon.searchFrame.dungeonsDrop = CreateFrame("Frame", "dungeonsDrop", hopAddon.searchFrame, "UIDropDownMenuTemplate")
local dDrop = hopAddon.searchFrame.dungeonsDrop
dDrop:SetPoint("BOTTOM",0,35)
dDrop.activeValue = 0
dDrop:Hide()

-- Raids drop list must be shown only when raids selected
hopAddon.searchFrame.raidsDrop = CreateFrame("Frame", "raidsDrop", hopAddon.searchFrame, "UIDropDownMenuTemplate")
local rDrop = hopAddon.searchFrame.raidsDrop
rDrop:SetPoint("BOTTOM",0,35)
rDrop.activeValue = 0
rDrop:Hide()


-- Dropdown to select category to search in

hopAddon.searchFrame.dropDown = CreateFrame("Frame", "CategoryDrop", hopAddon.searchFrame, "UIDropDownMenuTemplate")
hopAddon.searchFrame.dropDown:SetPoint("BOTTOM",-10,8)
UIDropDownMenu_SetWidth(hopAddon.searchFrame.dropDown,180)
hopAddon.searchFrame.dropDown.text = hopAddon.searchFrame.dropDown:CreateFontString(nil, "OVERLAY", "GameFontNormal")
hopAddon.searchFrame.dropDown.text:SetSize(136,12)
hopAddon.searchFrame.dropDown.text:SetPoint("RIGHT",hopAddon.searchFrame.dropDown,"RIGHT",-42,3)
hopAddon.searchFrame.dropDown.text:SetJustifyH("RIGHT")

-- custom search dropdown init
local CategoryList = {}

hopAddon.searchFrame.dropDown.initialize = function(self, level)

    if not level then return end
    wipe(CategoryList)
    if level == 1 then
		local categories = C_LFGList.GetAvailableCategories();
		for i=1, #categories do
			local categoryID = categories[i];
			local name, separateRecommended, autoChoose, preferCurrentArea = C_LFGList.GetCategoryInfo(categoryID);

			CategoryList.text = name;
			CategoryList.value = categoryID;
			CategoryList.func = hopAddon.searchFrame.dropDown_OnClick;
			CategoryList.checked = self.activeValue == CategoryList.value;
			--CategoryList.tooltipTitle = "bla"
			--CategoryList.tooltipText = "blabla"
			--CategoryList.tooltipOnButton = 1
			UIDropDownMenu_AddButton(CategoryList, 1);
		end
	end
	
end

UIDropDownMenu_SetAnchor(hopAddon.searchFrame.dropDown,0,10,"TOPRIGHT",hopAddon.searchFrame.dropDown,"BOTTOMRIGHT")

-- Category filter options

hopAddon.searchFrame.holderCatFilters = CreateFrame("Button",nil,hopAddon.searchFrame)
local h = hopAddon.searchFrame.holderCatFilters
h:SetSize(210,90)
h:SetPoint("CENTER",-10,-5)
h:SetBackdrop({bgFile = "Interface\\FrameGeneral\\UI-Background-Rock", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 256, edgeSize = 24, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
h:SetFrameLevel(10)
h:Hide()

h.timeEdit = CreateFrame("EditBox","searchFrameTimeEdit",h,"InputBoxInstructionsTemplate")
h.timeEdit:SetSize(40,22)
h.timeEdit:SetPoint("TOPLEFT",140,-15)
h.timeEdit:SetAutoFocus(false)
h.timeEdit:SetNumeric(true)
h.timeEdit:SetMaxLetters(4)
h.timeEdit:SetText("90")
h.timeEdit:SetScript("OnEnterPressed",function(self)
	if h.timeEdit:GetText() == "" then
		h.timeEdit:SetText("90")
	end
	EditBox_ClearFocus(self)
end)
h.timeEdit:SetScript("OnEscapePressed",function(self)
	EditBox_ClearFocus(self)
end)
h.timeEdit:SetScript("OnDisable", function(self)
	self:SetTextColor(0.5,0.5,0.5,1)
end)
h.timeEdit:SetScript("OnEnable", function(self)
	self:SetTextColor(1,1,1,1)
end)
h.timeEdit:Disable()

h.timeCheck = CreateFrame("CheckButton","searchFrameTimeCheck",h,"ChatConfigCheckButtonTemplate")
h.timeCheck:SetPoint("TOPLEFT",15,-15)
h.timeCheck:SetHitRectInsets(0,-90,0,0)
getglobal(h.timeCheck:GetName() .. 'Text'):SetText(HOPADDON_TIMEOPTION)
h.timeCheck.tooltip = HOPADDON_TIMETOOLTIP
h.timeCheck:SetChecked(false)
h.timeCheck:SetScript("OnClick",function(self)
	if h.timeEdit:IsEnabled() then
		h.timeEdit:Disable()
	else
		h.timeEdit:Enable()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

h.ilvlEdit = CreateFrame("EditBox","searchFrameilvlEdit",h,"InputBoxInstructionsTemplate")
h.ilvlEdit:SetSize(40,22)
h.ilvlEdit:SetPoint("TOPLEFT",140,-35)
h.ilvlEdit:SetAutoFocus(false)
h.ilvlEdit:SetNumeric(true)
h.ilvlEdit:SetMaxLetters(3)
h.ilvlEdit:SetText("630")
h.ilvlEdit:SetScript("OnEnterPressed",function(self)
	if h.ilvlEdit:GetText() == "" then
		h.ilvlEdit:SetText("630")
	end
	EditBox_ClearFocus(self)
end)
h.ilvlEdit:SetScript("OnEscapePressed",function(self)
	EditBox_ClearFocus(self)
end)
h.ilvlEdit:SetScript("OnDisable", function(self)
	self:SetTextColor(0.5,0.5,0.5,1)
end)
h.ilvlEdit:SetScript("OnEnable", function(self)
	self:SetTextColor(1,1,1,1)
end)
h.ilvlEdit:Disable()

h.ilvlCheck = CreateFrame("CheckButton","searchFrameilvlCheck",h,"ChatConfigCheckButtonTemplate")
h.ilvlCheck:SetPoint("TOPLEFT",15,-35)
h.ilvlCheck:SetHitRectInsets(0,-90,0,0)
getglobal(h.ilvlCheck:GetName() .. 'Text'):SetText(HOPADDON_ITEMLEVEL)
h.ilvlCheck.tooltip = HOPADDON_ITEMLEVELTOOLTIP
h.ilvlCheck:SetChecked(false)
h.ilvlCheck:SetScript("OnClick",function(self)
	if h.ilvlEdit:IsEnabled() then
		h.ilvlEdit:Disable()
	else
		h.ilvlEdit:Enable()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

h.autoInvCheck = CreateFrame("CheckButton","searchFrameacceptCheck",h,"ChatConfigCheckButtonTemplate")
h.autoInvCheck:SetPoint("TOPLEFT",15,-55)
getglobal(h.autoInvCheck:GetName() .. 'Text'):SetText(HOPADDON_SEARCH_AUTOINVITE)
h.autoInvCheck.tooltip = HOPADDON_SEARCHAUTOINVITETOOLTIP
h.autoInvCheck:SetChecked(false)

hopAddon.searchFrame.buttonCatFilters = CreateFrame("Button","catFiltersBtn",hopAddon.searchFrame,"BrowserButtonTemplate")
local b = hopAddon.searchFrame.buttonCatFilters
b:SetSize(24,24)
b:SetPoint("RIGHT",hopAddon.searchFrame.dropDown,8,3)
b.Icon = b:CreateTexture("butOptionsTex","OVERLAY")
b.Icon:SetSize(14,14)
b.Icon:SetPoint("CENTER",0,0)
b.Icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
b.tooltip = HOPADDON_ADDITIONALFILTERS
-- override on enter, onhide event is inside template
b:SetScript("OnClick", function(self,button)
	if h:IsShown() then
		h:Hide()
	else
		h:Show()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")	
end)

b:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, -25)
	GameTooltip:SetText(self.tooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)


-- Search box
hopAddon.searchFrame.searchBox = CreateFrame("EditBox", nil, hopAddon.searchFrame, "SearchBoxTemplate")
hopAddon.searchFrame.searchBox:SetPoint("TOPLEFT", hopAddon, "BOTTOMLEFT", 10, 2)
hopAddon.searchFrame.searchBox:SetAutoFocus(false)
hopAddon.searchFrame.searchBox:EnableMouse(true)
hopAddon.searchFrame.searchBox:SetSize(HOPADDON_WIDTH-34, 24)
hopAddon.searchFrame.searchBox:SetMaxLetters(256)

hopAddon.searchFrame.searchBox:SetScript("OnEditFocusGained", function(frame)
	hopAddon.searchFrame.SearchString = frame:GetText()
end)
hopAddon.searchFrame.searchBox:SetScript("OnEscapePressed", function(frame)
	frame:ClearFocus()
	frame:SetText(hopAddon.searchFrame.SearchString)
end)

-- search box clear button
hopAddon.searchFrame.searchBox.clearButton:Show()
hopAddon.searchFrame.searchBox.clearButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
	if DoSearch then
		GameTooltip:SetText(HOPADDON_STOPSEARCH, 1, 1, 1, true)
	else
		GameTooltip:SetText(HOPADDON_CLEARSEARCH, 1, 1, 1, true)	
	end
	GameTooltip:Show()
end)

hopAddon.searchFrame.searchBox.clearButton:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- results attached to search frame
local function ResultFrame_OnEnter(self)
	local resultID = self.result;
	local id, activityID, name, comment, voiceChat, iLvl, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers, autoinv = C_LFGList.GetSearchResultInfo(resultID);
	local activityName, shortName, categoryID, groupID, minItemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
	local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, -40);
	GameTooltip:SetText(name, 1, 1, 1, true);	
	GameTooltip:AddLine(activityName);
	if autoinv then
		GameTooltip:AddLine(HOPADDON_AUTOINVITE, 0.25, 0.75, 0.25, true)
	end	
	if ( comment ~= "" ) then
		GameTooltip:AddLine(string.format(LFG_LIST_COMMENT_FORMAT, comment), LFG_LIST_COMMENT_FONT_COLOR.r, LFG_LIST_COMMENT_FONT_COLOR.g, LFG_LIST_COMMENT_FONT_COLOR.b, true);
	end
	GameTooltip:AddLine(" ");
	if ( iLvl > 0 ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_ILVL, iLvl));
	end
	if ( voiceChat ~= "" ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_VOICE_CHAT, voiceChat), nil, nil, nil, true);
	end
	if ( iLvl > 0 or voiceChat ~= "" ) then
		GameTooltip:AddLine(" ");
	end

	if ( leaderName ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_LEADER, leaderName));
	end
	if ( age > 0 ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_AGE, SecondsToTime(age, false, false, 1, false)));
	end

	if ( leaderName or age > 0 ) then
		GameTooltip:AddLine(" ");
	end

	GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS, numMembers, memberCounts.TANK, memberCounts.HEALER, memberCounts.DAMAGER));

	if ( numBNetFriends + numCharFriends + numGuildMates > 0 ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_TOOLTIP_FRIENDS_IN_GROUP);
		GameTooltip:AddLine(LFGListSearchEntryUtil_GetFriendList(resultID), 1, 1, 1, true);
	end

	local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(resultID);
	if ( completedEncounters and #completedEncounters > 0 ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_BOSSES_DEFEATED);
		for i=1, #completedEncounters do
			GameTooltip:AddLine(completedEncounters[i], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		end
	end
	
	local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(id);

	GameTooltip:AddLine(" ");
	
	if pendingStatus == "applied" or appStatus == "applied" then
		GameTooltip:AddDoubleLine(HOPADDON_CANCELAPP,HOPADDON_RMB,0.75, 0.25, 0);
	elseif pendingStatus == "invited" or appStatus == "invited" then
		GameTooltip:AddDoubleLine(HOPADDON_DECLINEAPP,HOPADDON_RMB,0.75, 0.25, 0);
	else
		GameTooltip:AddDoubleLine(HOPADDON_APPLY,HOPADDON_LMB,0.25, 0.75, 0.25);
		GameTooltip:AddDoubleLine(HOPADDON_BLACKLIST,HOPADDON_RMB,0.75, 0.25, 0);
	end

	GameTooltip:Show();
end

-- MAIN FUNCTIONS --

local function SplitKeywords(keyword)
	SearchKeywords = {}
	for i in string.gmatch(keyword, "%S+") do
		if i ~= "-" then
			table.insert(SearchKeywords,i)
		end
	end
end

local function RemoveDelisted()
	local i=#FilteredGroupsList
	while i > 0 do
		local id, action, caption, desc, voice, ilvl, ctime, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(FilteredGroupsList[i])
		local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(FilteredGroupsList[i])
		
		if delisted or appStatus == "invitedeclined" or appStatus == "declined" or appStatus == "timedout"
		or appStatus == "cancelled" or pendingStatus == "cancelled" or appStatus == "failed" 
		then
			ResultFrames[i]:Hide()
			--print("Delisted "..caption.." delisted: "..delisted.." "..appStatus.." "..pendingStatus)
			table.remove(FilteredGroupsList,i)
		end
		i = i - 1
	end
	
	if #FilteredGroupsList == 0 then 
		var.addonSearchRequest = true
		DoSearch = true
		searchUpdated = 2.5
	end
end


local function UpdateSearchFrames()
	-- update left frames
	for i=1,#FilteredGroupsList do
		local frame = ResultFrames[i]
		frame.result = FilteredGroupsList[i]

		local id, action, caption, desc, voice, ilvl, ctime, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(frame.result)
		
		-- party name
		frame.textName:SetText(caption)
		
		-- autoinvite text color indication
		if autoinv then
			frame.textName:SetTextColor(0.25,0.75,0.25,1)
		else
			frame.textName:SetTextColor(1,0.82,1,1)
		end
		
		-- party members count
		frame.textCount:SetText(pcount)
		
		-- party members icon
		frame.icon:SetVertexColor(1,1,1,1)				
		if (bnetfr > 0) then
			frame.icon:SetAtlas("groupfinder-icon-friend")		
		elseif (charfr > 0) then
			frame.icon:SetAtlas("groupfinder-icon-friend")		
		elseif (guild > 0 ) then
			frame.icon:SetAtlas("groupfinder-waitdot")
			frame.icon:SetVertexColor(0,1,0,1)	
		else
			frame.icon:SetAtlas("groupfinder-waitdot")
		end
		
		-- frame backdrop
		frame:SetBackdropColor(0,0,0,1)
		frame.icon:Show()
		frame.iconRedx:Hide()
		frame.iconGreenChck:Hide()
		frame.spinner:Hide()
		local id, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(frame.result)

		if pendingStatus == "applied" or appStatus == "applied" then
			frame:SetBackdropColor(0.25,0.75,0.25,1)
			frame.icon:Hide()
			frame.spinner:Show()
			frame.spinner.Anim:Play()
		elseif pendingStatus == "invited" or appStatus == "invited" then
			frame:SetBackdropColor(0.25,0.75,0.25,1)
			frame.iconGreenChck:Show()
		elseif appStatus == "invitedeclined" or appStatus == "declined" or appStatus == "timedout" then
			frame.iconRedx:Show()
		end
		
		frame:Show()
	end
	-- hide unused frames
	for i=#FilteredGroupsList+1,HOPADDON_MAX_RESULTS do
		ResultFrames[i]:Hide()
	end
end


local function CustomSearch()
	hopAddon.searchFrame.stringSearching:SetText(HOPADDON_SEARCHING)
	hopAddon.searchFrame.anim:Play()
	UpdateSearchFrames()
	
	local active, activityID, ilvl, name, comment, voiceChat, duration, autoAccept = C_LFGList.GetActiveEntryInfo()
	if not name then
		hopAddon_LFGWarning:Show()
	end
	-- always just search category results, filter in the filter function
	FullScaleSearch(hopAddon.searchFrame.dropDown.activeValue,"",0,0)
end


local function CheckForBlackList(caption,ctime)
	
	local bl = false -- flagging for blacklist detection
	local epsilon = 2 -- blacklisting by name and creation time, time can give a small error
	for k,v in pairs(CustomSearchBlackList) do
		for key,value in pairs(v) do
			if key == caption then
				if (value <= GetTime()-ctime+epsilon) and (value >= GetTime()-ctime-epsilon) then
					--print("Blacklist match: "..key.." "..value)
					bl = true
				end
			end				
		end
		if bl then break end
	end

	return bl
end

--[[
	Force launches when user changes filter
	Launches by searchresultrecieved event
]]
local function FilterCustomSearchResults()
	FilteredGroupsList = {}
	
	if not var.addonSearchRequest then UpdateSearchFrames() return end
	
	-- manage keywords once
	local minusKeywords = {}
	local plusKeywords = {}
	for k,word in pairs(SearchKeywords) do
		if string.sub(word,1,1)=="-" then
			table.insert(minusKeywords,string.sub(word,2))
		else
			table.insert(plusKeywords,word)
		end
	end
		
	local count, list = C_LFGList.GetSearchResults()
	if count > HOPADDON_MAX_RESULTS then count = HOPADDON_MAX_RESULTS end
	
	for i = 1,count do
		-- checking for overlapping bugs for each element
		if list[i] ~= nil then
			local id, action, caption, desc, voice, ilvl, ctime, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(list[i])
			
			local passedTimeFilter = true
			if hopAddon.searchFrame.holderCatFilters.timeCheck:GetChecked() and ctime > tonumber(hopAddon.searchFrame.holderCatFilters.timeEdit:GetText()) then
				passedTimeFilter = false
			end
			
			local passedIlvlFilter = true
			if hopAddon.searchFrame.holderCatFilters.ilvlCheck:GetChecked() and ilvl < tonumber(hopAddon.searchFrame.holderCatFilters.ilvlEdit:GetText()) then
				passedIlvlFilter = false
			end
			
			local passedAutoInvFilter = true
			if hopAddon.searchFrame.holderCatFilters.autoInvCheck:GetChecked() and not autoinv then
				passedAutoInvFilter = false
			end
			
			local foundInBlackList = false
			if not passedTimeFilter or not passedIlvlFilter or not passedAutoInvFilter then
				foundInBlackList = true
			else
				foundInBlackList = CheckForBlackList(caption,ctime)
			end
			-- if not blacklisted use filters
			if not foundInBlackList then
			
				local InstanceIdFilter = 0
				-- dungeon filter
				if hopAddon.searchFrame.dropDown.activeValue == 2 then
						InstanceIdFilter = dDrop.activeValue
				-- raid filter
				elseif hopAddon.searchFrame.dropDown.activeValue == 3 then
						InstanceIdFilter = rDrop.activeValue
				end
				
				local passedInstanceFilter = true
				if InstanceIdFilter ~= 0 then		
					if action == InstanceIdFilter then
						-- this group activity match instanceID
					else
						passedInstanceFilter = false
					end
				end

				if passedInstanceFilter then
					-- add action name to searchstring for quests, dungeons and raids
					-- WITH FILTERS ONLY QUESTS
					-- DO WE EVEN NEED TO SCAN ACTION NAMES NOW?
					local actionName = ""
					if hopAddon.searchFrame.dropDown.activeValue == 1 
					--or hopAddon.searchFrame.dropDown.activeValue == 2 
					--or hopAddon.searchFrame.dropDown.activeValue == 3
					then
						actionName = C_LFGList.GetActivityInfo(action)
					end
					
					-- this is the string we're searching in
					local app = actionName:lower().." "..caption:lower().." "..desc:lower();
					
					-- check for "-keyword"
					local antiPassed = true
						for k,word in pairs(minusKeywords) do
							if app:find(word) then
								antiPassed = false
								break
							end
						end				
					
					if antiPassed then
						-- if user entered any keywords, check them
						if #plusKeywords > 0 then
							-- check for other keywords
							for k,word in pairs(plusKeywords) do
								if app:find(word) then
									table.insert(FilteredGroupsList,id)
									break
								end
							end
						else -- groups're already sorted by all previous filters
							table.insert(FilteredGroupsList,id)
						end				
					end
				
				end
			end
		end
	end
	-- if there're groups that meet conditions, show them
	if #FilteredGroupsList > 0 then
		hopAddon.searchFrame.stringSearching:SetText(HOPADDON_SEARCHPAUSED)
		hopAddon.searchFrame.anim:Stop()
		hopAddon_LFGWarning:Hide()
		
		DoSearch = false
		var.addonSearchRequest = false
		searchUpdated = 0
		UpdateSearchFrames()
		if customOptions.soundCheckButton:GetChecked() then
			--PlaySound("UI_GroupFinderReceiveApplication","Master")
			PlaySoundFile("Interface\\AddOns\\ServerHop\\sounds\\found_1.ogg","Master")
		end
		if customOptions.taskbarOption:GetChecked() then
			FlashClientIcon()
		end
		hopAddon:Show()
	else -- request new search
		if var.addonSearchRequest then
			DoSearch = true
			if firstSearch then
			searchUpdated = 2.5
				firstSearch = false
			end
		end
	end
end


function FinishCustomSearch()
	var.addonSearchRequest = false

	SearchKeywords = {}
	DoSearch = false
	FilteredGroupsList = {}
	CustomSearchBlackList = {}
	UpdateSearchFrames()
	hopAddon.searchFrame.stringSearching:SetText(HOPADDON_SEARCHPAUSED)	
	hopAddon.searchFrame.anim:Stop()
	hopAddon_LFGWarning:Hide()
	searchUpdated = 2.5	
end



-- LATE FUNCTIONS --

function hopAddon.searchFrame.dropDown_OnClick(self, arg1, arg2, checked)
	local prevValue = hopAddon.searchFrame.dropDown.activeValue
	hopAddon.searchFrame.dropDown.activeValue = self.value;
	CloseDropDownMenus();

	if prevValue ~= self.value then
		dDrop:Hide()
		dDrop.activeValue = 0
		rDrop:Hide()
		rDrop.activeValue = 0
		if self.value == 2 then	dDrop:Show()
		elseif self.value == 3 then rDrop:Show()
		end
		
		hopAddon.searchFrame.dropDown.text:SetText(C_LFGList.GetCategoryInfo(self.value))
		
		CustomSearch()
		FinishCustomSearch()
	end
end

-- Groups dropdown list set up
function hopAddon.searchFrame.dungeonsDrop_OnClick(self,arg1,arg2,checked)
	dDrop.activeValue = self.value

	if self.value == 0 then
		UIDropDownMenu_SetText(dDrop,NONE)
	else
		UIDropDownMenu_SetText(dDrop,C_LFGList.GetActivityInfo(self.value))
	end
	CloseDropDownMenus()
	hopAddon_searchBox_OnEnter(hopAddon.searchFrame.searchBox)
end

local dDropList = {
	-- classic
	[18] = 0,[50] = 0,[51] = 0,[52] = 0,
	[53] = 0,[54] = 0,[55] = 0,[56] = 0,
	[57] = 0,[58] = 0,[59] = 0,[60] = 0,
	[61] = 0,[62] = 0,[63] = 0,[64] = 0,
	[65] = 0,[66] = 0,[77] = 0,[78] = 0,
	-- bc
	[67] = 1,[94] = 1,[68] = 1,[93] = 1,
	[69] = 1,[95] = 1,[70] = 1,[90] = 1,
	[71] = 1,[92] = 1,[72] = 1,[81] = 1,
	[73] = 1,[85] = 1,[74] = 1,[84] = 1,
	[75] = 1,[86] = 1,[76] = 1,[87] = 1,
	[79] = 1,[89] = 1,[80] = 1,[88] = 1,
	[81] = 1,[98] = 1,[82] = 1,[97] = 1,
	[83] = 1,[96] = 1,[99] = 1,[100] = 1,
	-- wotlk
	[101] = 2,[128] = 2,[102] = 2,[117] = 2,
	[103] = 2,[127] = 2,[104] = 2,[119] = 2,
	[105] = 2,[120] = 2,[106] = 2,[121] = 2,
	[107] = 2,[118] = 2,[108] = 2,[122] = 2,
	[109] = 2,[123] = 2,[110] = 2,[124] = 2,
	[111] = 2,[125] = 2,[112] = 2,[126] = 2,
	[113] = 2,[129] = 2,[114] = 2,[130] = 2,
	[115] = 2,[131] = 2,[116] = 2,[132] = 2,
	-- cata
	[133] = 3,[146] = 3,[134] = 3,[144] = 3,
	[135] = 3,[143] = 3,[136] = 3,[142] = 3,
	[137] = 3,[141] = 3,[138] = 3,[140] = 3,
	[139] = 3,[147] = 3,[148] = 3,[149] = 3,
	[150] = 3,[151] = 3,[152] = 3,[153] = 3,
	[154] = 3,
	-- pandaria
	[155] = 4,[163] = 4,[156] = 4,[164] = 4,
	[157] = 4,[165] = 4,[158] = 4,[166] = 4,
	[159] = 4,[171] = 4,[160] = 4,[167] = 4,
	[168] = 4,[169] = 4,[170] = 4,[363] = 4,
	[364] = 4,
	-- draenor normal
	[21] = 100,[22] = 100,[23] = 100,[24] = 100,
	[25] = 100,[26] = 100,[27] = 100,[28] = 100,
	[395] = 100, -- random
	-- draenor heroic
	[29] = 200,[30] = 200,[31] = 200,[32] = 200,
	[33] = 200,[34] = 200,[35] = 200,[36] = 200,
	[396] = 200, -- random
	-- draenor CM
	[179] = 300,[180] = 300,[181] = 300,[182] = 300,
	[183] = 300,[184] = 300,[185] = 300,[186] = 300,
	-- draenor mythic
	[401] = 400,[402] = 400,[403] = 400,[404] = 400,
	[405] = 400,[406] = 400,[407] = 400,[408] = 400,
	
}

function dDrop.initialize(self,level)
	local info = UIDropDownMenu_CreateInfo()

	if (not level or level == 1) then
		-- no filter
		info.text = NONE;
		info.value = 0;	
		info.func = hopAddon.searchFrame.dungeonsDrop_OnClick
		info.hasArrow = false;
		info.checked = false
		UIDropDownMenu_AddButton(info);
		-- old content
		info.text = HOPADDON_OLDCONTENT
		info.value = "1"
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- normal
		info.text = PLAYER_DIFFICULTY1
		info.value = 100
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)		
		-- heroic
		info.text = PLAYER_DIFFICULTY2
		info.value = 200
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- draenor challenge modes
		info.text = PLAYER_DIFFICULTY5
		info.value = 300
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- mythic
		info.text = PLAYER_DIFFICULTY6
		info.value = 400
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)	
	elseif (level == 2) then
		local groupAct = C_LFGList.GetAvailableActivities(2, nil, 0,"")
		
		-- creating expansions
		if UIDROPDOWNMENU_MENU_VALUE == "1" then
			for i=0,4 do
				info.text = _G["EXPANSION_NAME"..i]
				info.value = "2"..i
				info.func = nil
				info.hasArrow = true
				info.checked = false
				UIDropDownMenu_AddButton(info,level)
			end	
		end
		
		for i=1, #groupAct do
			local activityID = groupAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = dDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == expac then
				info.text = fullName
				info.value = activityID
				info.func = hopAddon.searchFrame.dungeonsDrop_OnClick
				info.hasArrow = false;
				info.checked = (self.activeValue == info.value)
				UIDropDownMenu_AddButton(info,level)
				end
			end

		end
	elseif (level == 3) then
		local groupAct = C_LFGList.GetAvailableActivities(2, nil, 0,"")
	
		for i=1, #groupAct do
			local activityID = groupAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = dDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == "2"..expac then
				info.text = fullName
				info.value = activityID
				info.func = hopAddon.searchFrame.dungeonsDrop_OnClick
				info.hasArrow = false;
				info.checked = (self.activeValue == info.value)
				UIDropDownMenu_AddButton(info,level)
				end
			end

		end	
	end
end

UIDropDownMenu_Initialize(dDrop, dDrop.initialize)
UIDropDownMenu_SetSelectedID(dDrop, 0)
UIDropDownMenu_SetText(dDrop,NONE)
UIDropDownMenu_SetWidth(dDrop,180)


-- Raids dropdown list set up
function hopAddon.searchFrame.raidsDrop_OnClick(self,arg1,arg2,checked)
	rDrop.activeValue = self.value

	if self.value == 0 then
		UIDropDownMenu_SetText(rDrop,NONE)
	else
		UIDropDownMenu_SetText(rDrop,C_LFGList.GetActivityInfo(self.value))
	end
	CloseDropDownMenus()
	hopAddon_searchBox_OnEnter(hopAddon.searchFrame.searchBox)
end

local rDropList = {
	-- classic
	[9] = 0,[293] = 0,[294] = 0,[295] = 0,
	-- bc
	[45] = 1,[296] = 1,[297] = 1,[298] = 1,
	[299] = 1,[300] = 1,[301] = 1,
	-- wotlk
	[43] = 2,[44] = 2,[46] = 2,[47] = 2,
	[48] = 2,[49] = 2,[302] = 2,[303] = 2,
	[304] = 2,[305] = 2,[306] = 2,[307] = 2,
	[308] = 2,[309] = 2,[310] = 2,[311] = 2,
	-- cata
	[313] = 3,[316] = 3,[317] = 3,[318] = 3,
	[319] = 3,[320] = 3,[321] = 3,[322] = 3,
	[323] = 3,[324] = 3,[325] = 3,[326] = 3,
	[327] = 3,[328] = 3,[329] = 3,[330] = 3,
	[331] = 3,[332] = 3,[333] = 3,[334] = 3,
	-- pandaria
	[4] = 4,[41] = 4,[42] = 4,[335] = 4,
	[336] = 4,[337] = 4,[338] = 4,[339] = 4,
	[340] = 4,[341] = 4,[342] = 4,[343] = 4,
	[344] = 4,[345] = 4,[346] = 4,[347] = 4,
	[348] = 4,[349] = 4,[350] = 4,[397] = 4,
	-- draenor
	[37] = 100,[38] = 100,[39] = 200,[40] = 200,
	[399] = 100,[400] = 200,[409] = 300,[410] = 300,
	-- draenor outdoors
	[398] = 400,	
}


function rDrop.initialize(self,level)
	local info = UIDropDownMenu_CreateInfo()

	if (not level or level == 1) then
		-- no filter
		info.text = NONE;
		info.value = 0;	
		info.func = hopAddon.searchFrame.raidsDrop_OnClick
		info.hasArrow = false;
		info.checked = false
		UIDropDownMenu_AddButton(info);
		-- old content
		info.text = HOPADDON_OLDCONTENT
		info.value = "1"
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- outdoors
		local fullName = C_LFGList.GetActivityInfo(398)
		info.text = fullName
		info.value = 398
		info.func = hopAddon.searchFrame.raidsDrop_OnClick
		info.hasArrow = false;
		info.checked = (self.activeValue == info.value)
		UIDropDownMenu_AddButton(info,level)
		-- ogre raid
		info.text = GetMapNameByID(994)
		info.value = 100
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- orc raid
		info.text = GetMapNameByID(988)
		info.value = 200
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		-- demon raid
		info.text = GetMapNameByID(1026)
		info.value = 300
		info.func = nil
		info.hasArrow = true
		info.checked = false
		UIDropDownMenu_AddButton(info,level)
		
	elseif (level == 2) then
		local raidAct = C_LFGList.GetAvailableActivities(3, nil, 0,"")
		
		-- creating expansions
		if UIDROPDOWNMENU_MENU_VALUE == "1" then
			for i=0,4 do
				info.text = _G["EXPANSION_NAME"..i]
				info.value = "3"..i
				info.func = nil
				info.hasArrow = true
				info.checked = false
				UIDropDownMenu_AddButton(info,level)
			end	
		end
		
		for i=1,#raidAct do
			local activityID = raidAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = rDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == expac then
					info.text = fullName
					info.value = activityID
					info.func = hopAddon.searchFrame.raidsDrop_OnClick
					info.hasArrow = false;
					info.checked = (self.activeValue == info.value)
					UIDropDownMenu_AddButton(info,level)
				end
			end
		end

	elseif (level == 3) then
		local raidAct = C_LFGList.GetAvailableActivities(3, nil, 0,"")
		-- low level raids
		for i=1, #raidAct do
			local activityID = raidAct[i];
			local fullName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			
			local expac = rDropList[activityID]
			if expac then
				if UIDROPDOWNMENU_MENU_VALUE == "3"..expac then
					info.text = fullName
					info.value = activityID
					info.func = hopAddon.searchFrame.raidsDrop_OnClick
					info.hasArrow = false;
					info.checked = (self.activeValue == info.value)
					UIDropDownMenu_AddButton(info,level)
				end
			end
		end
	end
end

UIDropDownMenu_Initialize(rDrop, rDrop.initialize)
UIDropDownMenu_SetSelectedID(rDrop, 0)
UIDropDownMenu_SetText(rDrop,NONE)
UIDropDownMenu_SetWidth(rDrop,180)


function hopAddon_searchBox_OnEnter(frame)
	frame:ClearFocus()

	if IsInGroup() or IsInRaid() then
		if customOptions.endlessCheckBox:GetChecked() then
			return
		end
	end
	
	var.addonSearchRequest = true
	firstSearch = true
	
	SplitKeywords(frame:GetText():lower())
	if #SearchKeywords == 0 then
		hopAddon.searchFrame.searchBox.clearButton:Show()
	end

	CustomSearchBlackList = {}
	
	-- first, check if we have available groups in current results
	FilterCustomSearchResults()
end

hopAddon.searchFrame.searchBox:SetScript("OnEnterPressed", hopAddon_searchBox_OnEnter)

hopAddon.searchFrame.searchBox.clearButton:SetScript("OnClick", function(btn)
	if DoSearch then
		-- just pause search
		FinishCustomSearch()
		GameTooltip:SetText(HOPADDON_CLEARSEARCH,1,1,1,true)
	else
		-- also clear field
		SearchBoxTemplateClearButton_OnClick(btn)
		hopAddon.searchFrame.SearchString = ""
		FinishCustomSearch()
	end
end)

local function MakeResultFrame(index)
	local frame = CreateFrame("Button",nil,hopAddon.searchFrame.searchBox)
	frame:SetSize(208,40)
	if index == 1 then
		frame:SetPoint("TOP", hopAddon.searchFrame.searchBox, "BOTTOM",-5,0)
	else
		frame:SetPoint("TOP", ResultFrames[index-1], "BOTTOM")	
	end

	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 2, right = 2, top = 2, bottom = 2 }});
	frame:SetBackdropColor(0,0,0,1);
	
	local highlightTexture = frame:CreateTexture()
	highlightTexture:SetPoint("TOPLEFT",-2,5)
	highlightTexture:SetPoint("BOTTOMRIGHT",2,-7)
	highlightTexture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
	frame:SetHighlightTexture(highlightTexture,"ADD")

	frame.icon	= frame:CreateTexture(nil,"OVERLAY")
	frame.icon:SetSize(20,20)
	frame.icon:SetPoint("RIGHT", frame, "RIGHT", -8,0)

	frame.iconRedx	= frame:CreateTexture(nil,"OVERLAY")
	frame.iconRedx:SetSize(20,20)
	frame.iconRedx:SetPoint("RIGHT", frame, "RIGHT", -8,0)
	frame.iconRedx:SetAtlas("groupfinder-icon-redx")

	frame.iconGreenChck	= frame:CreateTexture(nil,"OVERLAY")
	frame.iconGreenChck:SetSize(20,20)
	frame.iconGreenChck:SetPoint("RIGHT", frame, "RIGHT", -8,0)
	frame.iconGreenChck:SetAtlas("Tracker-Check")
	
	frame.spinner = CreateFrame("Frame",nil,frame,"LoadingSpinnerTemplate")
	frame.spinner:SetSize(40,40)
	frame.spinner:SetPoint("RIGHT", frame, "RIGHT", 0,0)
	
	frame.textName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frame.textName:SetSize(156,36)
	frame.textName:SetPoint("LEFT",frame,"LEFT",8,0)
	frame.textName:SetJustifyH("LEFT")
	frame.textName:SetText("")

	frame.textCount = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	frame.textCount:SetSize(17,14)
	frame.textCount:SetPoint("RIGHT",frame.icon,"LEFT",0,0)
	frame.textCount:SetText("")
	
	frame.result = 0
	
	frame:SetScript("OnEnter", ResultFrame_OnEnter)
	frame:SetScript("OnLeave", function(self) GameTooltip:Hide() end);	
	frame:RegisterForClicks("AnyUp")
	frame:SetScript("OnClick", function(self,button,down)
	
		if button == "LeftButton" then
			local apps = C_LFGList.GetApplications();
			local total = 0
			for i=1, #apps do
				local id, appStatus, pendingStatus,appDuration = C_LFGList.GetApplicationInfo(apps[i]);
				if appDuration == 0 and pendingStatus == "applied" then
					-- phantom groups fix
					-- phantom groups have 0 duration and applied pending
				else
					if pendingStatus == "applied" or appStatus == "applied"
					or pendingStatus == "invited" or appStatus == "invited" then
						total = total + 1
					end
				end
			end
			
			local active, activityID, ilvl, name, comment, voiceChat, duration, autoAccept = C_LFGList.GetActiveEntryInfo()
			
			if total < 5 and ((not IsInGroup() and not IsInRaid()) or UnitIsGroupLeader('player')) and not name then
				PlaySound("igMainMenuOptionCheckBoxOn")
				local tank, heal, dd = C_LFGList.GetAvailableRoles()
				tank = tank and customOptions.tankCheckButton:GetChecked()
				heal = heal and customOptions.healCheckButton:GetChecked()
				dd = dd and customOptions.dpsCheckButton:GetChecked()
				C_LFGList.ApplyToGroup(self.result, "", tank, heal, dd)

				table.remove(FilteredGroupsList,index)
				if #FilteredGroupsList > 0 then
					UpdateSearchFrames()
					if #FilteredGroupsList >= index then
						ResultFrame_OnEnter(self)
					end
				else
					self:Hide()
					var.addonSearchRequest = true
					DoSearch = true
					searchUpdated = 2.5
				end	
			else
				PlaySound("ui_garrison_architecttable_buildingplacementerror")			
			end
		end
		
		if button == "RightButton" then
			local id, action, caption, desc, voice, ilvl, ctime, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(self.result)
			local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(self.result);
			
			if appStatus == "applied" or pendingStatus == "applied" then
				C_LFGList.CancelApplication(self.result)
			elseif pendingStatus == "invited" or appStatus == "invited" then
				LFGListInviteDialog.DeclineButton:Click()
			else
				local t={}
				t[caption]=GetTime()-ctime
				--print("Blacklisted "..caption)
				table.insert(CustomSearchBlackList,t)
				table.remove(FilteredGroupsList,index)
			end
			
			if #FilteredGroupsList > 0 then
				UpdateSearchFrames()
				if #FilteredGroupsList >= index then
					ResultFrame_OnEnter(self)
				end
			else
				self:Hide()
				var.addonSearchRequest = true
				DoSearch = true
				searchUpdated = 2.5
			end	
			PlaySound("igMainMenuOptionCheckBoxOn")
		end
	end)
	
	frame:Hide()
	ResultFrames[index]=frame
end

for i=1,HOPADDON_MAX_RESULTS do MakeResultFrame(i) end


-- EVENT FUNCTIONS --


local function SearchFrame_EventSystem(self, event, ...)
	local arg1 = ...

	if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
		FilterCustomSearchResults()
	end
	
	if event == "LFG_LIST_SEARCH_RESULT_UPDATED" or event == "LFG_LIST_JOINED_GROUP" then
		if hopAddon.optionsFrame.globalOptionsFrame.autoAcceptButton:GetChecked() then
			local apps = C_LFGList.GetApplications();
			for i=1, #apps do
				local id, status, pendingStatus = C_LFGList.GetApplicationInfo(apps[i]);
				if status == "invited" and not pendingStatus then
					LFGListInviteDialog.AcceptButton:Click()
					break
				end
			end
			
			LFGListInviteDialog:Hide()
		end	
	end
			
	if event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
		if #FilteredGroupsList > 0 then
			RemoveDelisted()
			UpdateSearchFrames()
		end
	end
	
	if event == "GROUP_ROSTER_UPDATE" then
		-- Stopping search in a group
		if var.addonSearchRequest then
			if customOptions.endlessCheckBox:GetChecked() then
				FinishCustomSearch()
			end
		end		
	end
	if event == "PLAYER_LEVEL_UP" then
		UIDropDownMenu_Initialize(rDrop, rDrop.initialize)
		UIDropDownMenu_Initialize(dDrop, dDrop.initialize)
	end

end


local backgroundScanner = CreateFrame("Frame")
backgroundScanner:RegisterEvent("")
--Events
backgroundScanner:SetScript("OnEvent", SearchFrame_EventSystem)
backgroundScanner:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
backgroundScanner:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
backgroundScanner:RegisterEvent("LFG_LIST_JOINED_GROUP")
backgroundScanner:RegisterEvent("GROUP_ROSTER_UPDATE")
backgroundScanner:RegisterEvent("PLAYER_LEVEL_UP")


local function OnUpdate(self,elapsed)
	if var.addonSearchRequest and DoSearch then
		searchUpdated = searchUpdated + elapsed
		
		-- HARDTESTED: blizzard allows to throw 2 search results per 5 seconds	
		-- for customSearch we just get results when they should be available
		if searchUpdated > 2.5 then
			CustomSearch()
			searchUpdated = 0
		end
	
	end
end

backgroundScanner:SetScript("OnUpdate",OnUpdate)