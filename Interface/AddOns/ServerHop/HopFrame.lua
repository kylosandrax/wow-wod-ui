-- MODULE FOR HOPPING FRAME --

-- Holder frame
hopAddon.hopFrame = CreateFrame("Frame",nil,hopAddon)
local hopFrame = hopAddon.hopFrame
hopAddon.hopFrame:SetSize(HOPADDON_WIDTH,HOPADDON_HEIGHT)
hopAddon.hopFrame:SetPoint("BOTTOM",0,0)
hopAddon.hopFrame.lastUpdate = 0
hopAddon.hopFrame.queueUpdate = 0
hopAddon.hopFrame:Hide()

hopAddon.hopFrame.background = hopAddon.hopFrame:CreateTexture(nil,"BORDER")
hopAddon.hopFrame.background:SetSize(HOPADDON_WIDTH+106,HOPADDON_HEIGHT-10)
hopAddon.hopFrame.background:SetPoint("BOTTOM",1,5)
hopAddon.hopFrame.background:SetTexture("Interface\\Challenges\\challenges-besttime-bg")

hopAddon.hopFrame.stringRealm = hopAddon.hopFrame:CreateFontString("realmname", "OVERLAY", "QuestFont_Shadow_Huge")
hopAddon.hopFrame.stringRealm:SetPoint("BOTTOM",0,72)
hopAddon.hopFrame.stringRealm:SetTextColor(1, 0.914, 0.682, 1)
hopAddon.hopFrame.stringRealm:SetText(GetRealmName())

-- list of options 
hopAddon.hopFrame.pvpDrop = CreateFrame("Frame", "hopFramepvpDrop", hopAddon.hopFrame, "UIDropDownMenuTemplate")
local pvpD = hopAddon.hopFrame.pvpDrop
pvpD:SetPoint("BOTTOMLEFT",0,35)
function hopAddon.hopFrame.pvpDrop_OnClick(self)
	UIDropDownMenu_SetSelectedID(pvpD, self:GetID())
end
-- list of options in droplist
hopAddon_serverTypeDropTable = {
	COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP,
	COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE,
	ALL
}
pvpD.initialize = function(self,level)
	if not level then return end
	local info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(hopAddon_serverTypeDropTable) do
		info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = v
		info.func = hopAddon.hopFrame.pvpDrop_OnClick
		UIDropDownMenu_AddButton(info,level)
	end
end
UIDropDownMenu_Initialize(pvpD, pvpD.initialize)
UIDropDownMenu_SetSelectedID(pvpD, 3)
UIDropDownMenu_SetText(pvpD,ALL)
UIDropDownMenu_SetWidth(pvpD,70)



-- Dropdown to select party size to hop in
hopAddon.hopFrame.dropDown = CreateFrame("Frame", "CountDrop", hopAddon.hopFrame, "UIDropDownMenuTemplate")
hopAddon.hopFrame.dropDown:SetPoint("BOTTOMRIGHT",0,35)
function hopAddon.hopFrame.dropDown_OnClick(self)
	UIDropDownMenu_SetSelectedID(hopAddon.hopFrame.dropDown, self:GetID())
end
-- list of options in droplist
local groupSizeList = {
	PARTY.." 1-4",
	RAID.." 6-40",
	HOPADDON_ANYSIZE
}
hopAddon.hopFrame.dropDown.initialize = function(self,level)
	if not level then return end
	local info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(groupSizeList) do
		info = UIDropDownMenu_CreateInfo()
		info.text = v
		info.value = v
		info.func = hopAddon.hopFrame.dropDown_OnClick
		UIDropDownMenu_AddButton(info,level)
	end
end
UIDropDownMenu_Initialize(hopAddon.hopFrame.dropDown, hopAddon.hopFrame.dropDown.initialize)
UIDropDownMenu_SetSelectedID(hopAddon.hopFrame.dropDown, 3)
UIDropDownMenu_SetText(hopAddon.hopFrame.dropDown,HOPADDON_ANYSIZE)
UIDropDownMenu_SetWidth(hopAddon.hopFrame.dropDown,100)
UIDropDownMenu_SetAnchor(hopAddon.hopFrame.dropDown,0,10,"TOPRIGHT",hopAddon.hopFrame.dropDown,"BOTTOMRIGHT")

-- Button to hop to the next realm 
hopAddon.hopFrame.buttonHop = CreateFrame("Button",nil,hopAddon.hopFrame,"UIGoldBorderButtonTemplate")
hopAddon.hopFrame.buttonHop:SetSize(100,24)
hopAddon.hopFrame.buttonHop:SetPoint("BOTTOM",55,15)
hopAddon.hopFrame.buttonHop:SetText(HOPADDON_NEXTREALM)

--[[
hopAddon.hopFrame.buttonHop.spinner = CreateFrame("Frame",nil,hopAddon.hopFrame.buttonHop,"LoadingSpinnerTemplate")
hopAddon.hopFrame.buttonHop.spinner:SetSize(80,80)
hopAddon.hopFrame.buttonHop.spinner:SetPoint("CENTER", 0,0)
hopAddon.hopFrame.buttonHop.spinner.Anim:Play()
]]

-- Button to hop to the last blacklisted realm
hopAddon.hopFrame.buttonHopBack = CreateFrame("Button",nil,hopAddon.hopFrame,"UIGoldBorderButtonTemplate")
hopAddon.hopFrame.buttonHopBack:SetSize(100,24)
hopAddon.hopFrame.buttonHopBack:SetPoint("BOTTOM",-55,15)
hopAddon.hopFrame.buttonHopBack:SetText(HOPADDON_LASTBUTTON)
hopAddon.hopFrame.buttonHopBack:Disable()

-- rewriting hyperlink function to react on serverhop links
local origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow

ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...
	if type(text) == "string" and text:match("sehop") and not IsModifiedClick() then
		ShowServerChatInfo(text)
	else
		return origChatFrame_OnHyperlinkShow(...)
	end
end

function ShowServerChatInfo(text)
	local _,grname,grdesc,_ = strsplit("*",text)
	local realmName = string.match(text,'%[(.+)%]')
	
	ShowUIPanel(ItemRefTooltip)
	if (not ItemRefTooltip:IsVisible()) then
		ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE")
	end
	ItemRefTooltip:ClearLines()
	ItemRefTooltip:AddLine("\124cff71d5ff"..realmName.."\124r",1,1,1,1)
	ItemRefTooltip:AddLine(" ",1,1,1,1)
	ItemRefTooltip:AddLine("\124cff"..grname.."\124r",1,1,1,1)
	if grdesc ~= "" then
		ItemRefTooltip:AddLine(grdesc,1,1,1,1)
	end
	ItemRefTooltip:Show()
end



-- MAIN FUNCTIONS --
HOPADDON_QUEUE_INTERVAL = 1
local SEARCH_INTERVAL = 2.5
-----------
hopFrame.firstTime = true
hopFrame.hopRequest = false
local BlackList = {} -- list of pairs {realm name = time last visited}
local HopList= {} -- sorted list of groups available for server hopping
local lastUpdate = 0 -- update timer
local lastServer = nil -- last server you've hopped to


local hopSearch = false -- should addon queue hopSearch
local queue = false -- should addon queue for groups
local backSearch = false -- start searching for a last server you've hopped on


local function HopSearch()
	hopAddon_LFGWarning:Show()

	HopList = {}
	FullScaleSearch(6,"",0,0)
end

 function PlayerRealm(fullname)
    fullname = fullname or "???-???"
    local name, realm = strsplit(_G.REALM_SEPARATORS, fullname)
    realm = realm or GetRealmName();
    return realm;
end


function LeaveAndBlackList()
	local index = GetNumGroupMembers()
	local name, server
	
	if IsInRaid() then
		for i=1,index do
			if UnitIsGroupLeader("raid"..i) then
				name,server = UnitName("raid"..i)
				-- why the hell does it return server as "" on other people, but on you returns nil???
				if server == "" or server == nil then
					server = GetRealmName()
				end
				BlackList[server]=GetTime()
				break
			end
		end
	else
		for i=1,4 do
			if UnitIsGroupLeader("party"..i) then
				name,server = UnitName("party"..i)
				if server == "" then
					server = GetRealmName()
				end
				BlackList[server]=GetTime()
				break
			end
		end
	end
	
	if server ~= GetRealmName() then
		lastServer = server
	end

	local blackCount = 0
	for k,v in pairs(BlackList) do
		if GetTime()-v < hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:GetValue() then
			blackCount = blackCount + 1
		end
	end
	hopAddon.optionsFrame.hopSearchOptionsFrame.blacklistString:SetText(HOPADDON_INBLACKLIST.." |cFFFFFFFF"..blackCount.."|r")
	
	LeaveParty()
end


function FinishHopSearch()
	hopFrame.hopRequest = false	
	hopSearch = false
	queue = false
	hopAddon.hopFrame.lastUpdate = 0
	backSearch = false
		
	if (lastServer ~= nil) then
		hopAddon.hopFrame.buttonHopBack:Enable()
	end
	hopAddon.hopFrame.buttonHop:SetText(HOPADDON_NEXTREALM)
	hopAddon.hopFrame.buttonHop:Enable()
	hopAddon_LFGWarning:Hide()
end



local function QueueGroups()
	-- queueing while being in a group will create a shadow group, also impossible
	if (IsInGroup() or IsInRaid()) then return end
	
	local apps = C_LFGList.GetApplications()
	local summ = 0
	for i=1,#apps do
		local id, appStatus, pendingStatus = C_LFGList.GetApplicationInfo(apps[i]);
		
		if appStatus == "applied" or pendingStatus == "applied" then
			C_LFGList.CancelApplication(apps[i])
			summ = summ + 1
		elseif pendingStatus == "invited" or appStatus == "invited" then
			LFGListInviteDialog.DeclineButton:Click()
			summ = summ + 1
		end
	end
	
	if summ > 0 then return end

	hopAddon.hopFrame.queueUpdate = 0

	local tank, heal, dd = C_LFGList.GetAvailableRoles()
	
	--print(#HopList.." available. Throwing requests...")
	local appliedCount = 0
	for k,v in pairs(HopList) do
		if k==6 then break end
		appliedCount = appliedCount + 1
		C_LFGList.ApplyToGroup(v, "", tank, heal, dd)
		--print("Applying "..v)
	end
	
	if #HopList > 0 then
		for i=1,appliedCount do
			table.remove(HopList,1)
		end
	else
		queue = false
		hopAddon.hopFrame.buttonHop:SetText(HOPADDON_SEARCHING)			
		hopSearch = true
	end
	
end

local function FilterHopSearchGroups()
	hopFrame.buttonHop:SetText(HOPADDON_HOPPING)

	HopList = {}
	local count, list = C_LFGList.GetSearchResults()
	if count > HOPADDON_MAX_RESULTS then count = HOPADDON_MAX_RESULTS end
	--print(count.." groups found.")
	
	if (backSearch) then
		for i = 1,count do
			if list[i]~= nil then
				local id, action, caption, desc, voice, ilvl, time, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(list[i])
				local realm = PlayerRealm(fullname)

				if fullname ~= nil and lastServer == realm then
					if UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 1 then
						if pcount < 5 then
							table.insert(HopList, id)
						end
					elseif UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 2 then
						if pcount >= 6 then
							table.insert(HopList, id)
						end
					else
						table.insert(HopList, id)
					end				
				end
			end
		end			
	else
	-- forward search
		local unfiltered = {}
		
		-- Adding all available groups that don't match blacklist
		for i = 1,count do
			if list[i] ~= nil then
				local id, action, caption, desc, voice, ilvl, time, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(list[i])
				local realm = PlayerRealm(fullname)
				if fullname ~= nil and realm ~= GetRealmName()
				and (BlackList[realm] == nil or (GetTime()-BlackList[realm] > hopAddon.optionsFrame.hopSearchOptionsFrame.sliderBLTime:GetValue())) then
					
					if (UIDropDownMenu_GetSelectedID(pvpD) == 1 and hopAddon.var.pvpList[realm] == true) or
					(UIDropDownMenu_GetSelectedID(pvpD) == 2 and hopAddon.var.pvpList[realm] == nil) or
					(UIDropDownMenu_GetSelectedID(pvpD) == 3) then
						if hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked() then
							-- if putting all groups filter autoivite on top
							if UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 1 then
								if pcount < 5 then
									unfiltered[id] = autoinv
								end
							elseif UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 2 then
								if pcount >= 6 then
									unfiltered[id] = autoinv
								end
							else
								unfiltered[id] = autoinv
							end
						elseif autoinv then
							-- if putting only autoinvite then don't need to sort
							if UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 1 then
								if pcount < 5 then
									table.insert(HopList,id)
								end
							elseif UIDropDownMenu_GetSelectedID(hopAddon.hopFrame.dropDown) == 2 then
								if pcount >= 6 then
									table.insert(HopList,id)
								end
							else
								table.insert(HopList,id)
							end
						end
						--print("Игрок: "..fullname.." Сервер: "..realm)
					end
				end		
			end
		end
		
		if hopAddon.optionsFrame.hopSearchOptionsFrame.autoInviteCheck:GetChecked() then
			-- checking unfiltered for autoinvite, putting them on top first
			for id,auto in pairs(unfiltered) do
				if auto then table.insert(HopList,id) end
			end
			-- then putting simple invites
			for id,auto in pairs(unfiltered) do
				if not auto then table.insert(HopList,id) end
			end
		end		
	end

	-- queue if found any
	if #HopList > 0 then
		hopAddon.hopFrame.queueUpdate = HOPADDON_QUEUE_INTERVAL
		queue = true
	else -- search more if couldn't find any
		hopAddon.hopFrame.buttonHop:SetText(HOPADDON_SEARCHING)
		hopSearch = true
	end
end

function ServerHop_HopForward()
	hopFrame.buttonHop:Disable()
	hopFrame.buttonHopBack:Disable()
	hopFrame.buttonHop:SetText(HOPADDON_HOPPING)

	LeaveAndBlackList()
	
	hopFrame.hopRequest = true
	
	-- make sure to get a search from category 6
	if hopFrame.firstTime then
		hopFrame.lastUpdate = SEARCH_INTERVAL
		hopFrame.buttonHop:SetText(HOPADDON_SEARCHING)
		hopSearch = true
	else
		FilterHopSearchGroups()
	end
end

function ServerHop_HopBack()
	if lastServer ~= nil then
		hopFrame.buttonHop:Disable()
		hopFrame.buttonHopBack:Disable()
		hopFrame.buttonHop:SetText(HOPADDON_HOPPING)

		LeaveParty()
		
		hopFrame.hopRequest = true
		backSearch = true
		
		-- make sure to get a search from category 6
		if hopFrame.firstTime then
			hopFrame.lastUpdate = SEARCH_INTERVAL
			hopAddon.hopFrame.buttonHop:SetText(HOPADDON_SEARCHING)
			hopSearch = true
		else
			FilterHopSearchGroups()
		end
	end
end

-- hop forward button
hopAddon.hopFrame.buttonHop:SetScript("OnClick", function(btn)
	ServerHop_HopForward()
end)

hopAddon.hopFrame.buttonHopBack:SetScript("OnClick", function(btn)
	ServerHop_HopBack()
end)

local function HopFrame_EventSystem(self, event, ...)
	local arg1 = ...

	if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
		-- even if user refreshed this list without addon, we should remember the time
		hopAddon.hopFrame.lastUpdate = 0
	
		if hopFrame.hopRequest then
			if hopSearch then
				hopFrame.firstTime = false
				hopSearch = false
				FilterHopSearchGroups()
			end
		else
			hopFrame.firstTime = true
		end
	end
	
	if event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
		if hopFrame.hopRequest then
			local apps = C_LFGList.GetApplications();
			for i=1, #apps do
				local id, status, pendingStatus = C_LFGList.GetApplicationInfo(apps[i]);
				if status == "invited" and not pendingStatus then
					LFGListInviteDialog.AcceptButton:Click()
					--print("Joining "..apps[i])
					FinishHopSearch()					
					
					for i=1, #apps-1 do
						LFGListInviteDialog.AcknowledgeButton:Click()
					end
					
					break
				end
			end
		end
	end
	if event == "LFG_LIST_SEARCH_FAILED" then
		
		-- old method used this
		
	end
	if event == "GROUP_ROSTER_UPDATE" then

	-- Checking Server Name
		local index = GetNumGroupMembers()
		local name = nil
		local server = nil
		
		if IsInRaid() then
			for i=1,index do
				if UnitIsGroupLeader("raid"..i) then
					name,server = UnitName("raid"..i)
					break
				end
			end
		elseif IsInGroup() then
			for i=1,4 do
				if UnitIsGroupLeader("party"..i) then
					name,server = UnitName("party"..i)
					break
				end
			end
		end
		
		if server == nil or server == "" then
			server = GetRealmName()
		end
		hopAddon.hopFrame.stringRealm:SetText(server)
	
	end
	if event == "LFG_LIST_JOINED_GROUP" then
		-- finish search here if it was done by other non serverhop means
		FinishHopSearch()
		-- send chat notification about hopping
		if (hopAddon.optionsFrame.globalOptionsFrame.chatNotifButton:GetChecked()) then
			local id, action, caption, desc, voice, ilvl, time, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(arg1)
			local realm = PlayerRealm(fullname)
			local ncolor = "ffd517"
			if autoinv then ncolor = "3caa3c" end
			print("[Server Hop] ["..TRANSFER.."]: \124cff71d5ff\124Hsehop:*"..ncolor..caption.."*"..desc.."*\124h["..realm.."]\124h\124r.");
		end
		-- press all buttons
		local apps = C_LFGList.GetApplications();
		for i=1, #apps-1 do
			LFGListInviteDialog.AcknowledgeButton:Click()
		end
	end
end

hopAddon.hopFrame:SetScript("OnEvent", HopFrame_EventSystem)
hopAddon.hopFrame:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
hopAddon.hopFrame:RegisterEvent("LFG_LIST_SEARCH_FAILED")
hopAddon.hopFrame:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
hopAddon.hopFrame:RegisterEvent("LFG_LIST_JOINED_GROUP")
hopAddon.hopFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

local function OnUpdate(self,elapsed)
	-- search updating should be counting all the time, resetting it on search results
	hopAddon.hopFrame.lastUpdate = hopAddon.hopFrame.lastUpdate + elapsed


	if hopFrame.hopRequest then
		hopAddon.hopFrame.queueUpdate = hopAddon.hopFrame.queueUpdate + elapsed
		
		if (hopSearch and hopAddon.hopFrame.lastUpdate > SEARCH_INTERVAL) then
			HopSearch()
			-- set to 0 instantly to prevent second update before search results event gets called
			hopAddon.hopFrame.lastUpdate = 0
		end
		
		-- Queuing for groups made found with hop search
		if (queue and hopAddon.hopFrame.queueUpdate > HOPADDON_QUEUE_INTERVAL) then
			QueueGroups()
		end
			
	end
end

local hoppingEventFrame = CreateFrame("Frame")
hoppingEventFrame:SetScript("OnUpdate",OnUpdate)

hopAddon.optionsFrame.hopSearchOptionsFrame.buttonClearBL:SetScript("OnClick", function(btn)
	BlackList = {}
	hopAddon.optionsFrame.hopSearchOptionsFrame.blacklistString:SetText(HOPADDON_INBLACKLIST.."|cFFFFFFFF0|r")
end)