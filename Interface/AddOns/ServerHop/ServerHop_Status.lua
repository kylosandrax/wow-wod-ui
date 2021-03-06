﻿hopAddon.hopStatus = CreateFrame("Frame",nil,hopAddon)
local hopStatus = hopAddon.hopStatus

hopStatus:SetPoint("LEFT",hopAddon,"RIGHT",-4,0)
hopStatus:SetFrameStrata("HIGH")
hopStatus:SetWidth(125)
hopStatus:SetHeight(120)
hopStatus:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
					tile = true, tileSize = 16, edgeSize = 16, 
					insets = { left = 5, right = 5, top = 5, bottom = 5 }});
hopStatus:SetBackdropColor(1,1,1,1);

hopStatus:Hide()
-- There are 2 different modes:
--
-- addon status if searching
-- group info if in group


-- Mode 1: Group info
hopStatus.groupStatusFrame = CreateFrame("Frame","groupStatus",hopStatus)
local groupStatusFrame = hopStatus.groupStatusFrame
groupStatusFrame:SetAllPoints(hopStatus)

-- group name button
groupStatusFrame.groupName = CreateFrame("Button",nil,groupStatusFrame)
local button = groupStatusFrame.groupName
button:SetSize(115,20)
button:SetPoint("TOP",0,-5)
button.text = button:CreateFontString(nil,"ARTWORK","GameFontNormal")
button.text:SetAllPoints(button)
button.text:SetText(HOPADDON_NOTLFGGROUP)

button:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(HOPADDON_NOTLFGGROUP)
	
	local active, activityID, ilvl, name, comment, voiceChat, duration, autoAccept = C_LFGList.GetActiveEntryInfo()
	
	if active then
		GameTooltip:SetText(name)
		if ( comment ~= "" ) then
			GameTooltip:AddLine(string.format(LFG_LIST_COMMENT_FORMAT, comment), LFG_LIST_COMMENT_FONT_COLOR.r, LFG_LIST_COMMENT_FONT_COLOR.g, LFG_LIST_COMMENT_FONT_COLOR.b, true);
		end
	end

	if UnitIsGroupLeader("player") then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(LFG_LIST_AUTO_ACCEPT,HOPADDON_LMB,0.25, 0.75, 0)
	end
	GameTooltip:Show()
end)
button:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

button:SetScript("OnClick", function(btn)
	local active, activityID, iLevel, name, comment, voiceChat, expiration, oldAutoAccept = C_LFGList.GetActiveEntryInfo()
	if ( not active ) then
		return
	end
	
	C_LFGList.UpdateListing(activityID, name, iLevel, voiceChat, comment, not(oldAutoAccept))
end)

function groupStatusFrame.UpdateGroup(name,autoAccept)
	if name then
		button.text:SetText(name)
		
		if autoAccept
		then button.text:SetTextColor(0.25,0.75,0.25,1)
		else button.text:SetTextColor(1, 0.82, 0, 1)
		end
	else
		button.text:SetText(HOPADDON_NOTLFGGROUP)
		button.text:SetTextColor(1,0.82,0,1)
	end
end

-- player count row, make a new frame for tooltip over whole row
groupStatusFrame.playerCountFrame = CreateFrame("Frame","playerCountFrame",groupStatusFrame)
local playerCountFrame = groupStatusFrame.playerCountFrame
playerCountFrame:SetSize(125,24)
playerCountFrame:SetPoint("TOP",0,-20)

playerCountFrame.dpsIcon = playerCountFrame:CreateTexture(nil,"ARTWORK")
local frame = playerCountFrame.dpsIcon
frame:SetSize(17,17)
frame:SetPoint("RIGHT", -7,0)
frame:SetAtlas("groupfinder-icon-role-large-dps")

playerCountFrame.dpsCount = playerCountFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
local frame = playerCountFrame.dpsCount
frame:SetSize(17,14)
frame:SetPoint("RIGHT", playerCountFrame.dpsIcon, "LEFT", -1,0)
frame:SetText("0")

playerCountFrame.healerIcon = playerCountFrame:CreateTexture(nil,"ARTWORK")
local frame = playerCountFrame.healerIcon
frame:SetSize(17,17)
frame:SetPoint("RIGHT", playerCountFrame.dpsCount, "LEFT", -4,0)
frame:SetAtlas("groupfinder-icon-role-large-heal")

playerCountFrame.healerCount = playerCountFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
local frame = playerCountFrame.healerCount
frame:SetSize(17,14)
frame:SetPoint("RIGHT", playerCountFrame.healerIcon, "LEFT", -1,0)
frame:SetText("0")

playerCountFrame.tankIcon = playerCountFrame:CreateTexture(nil,"ARTWORK")
local frame = playerCountFrame.tankIcon
frame:SetSize(17,17)
frame:SetPoint("RIGHT", playerCountFrame.healerCount, "LEFT", -4,0)
frame:SetAtlas("groupfinder-icon-role-large-tank")

playerCountFrame.tankCount = playerCountFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
local frame = playerCountFrame.tankCount
frame:SetSize(17,14)
frame:SetPoint("RIGHT", playerCountFrame.tankIcon, "LEFT", -1,0)
frame:SetText("0")

playerCountFrame.playerCount = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)

playerCountFrame:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(string.format(LFG_LIST_MEMBER_COUNT,playerCountFrame.playerCount))
	GameTooltip:Show()
end)
playerCountFrame:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

function playerCountFrame.setPlayerCount(tankCount, healerCount, dpsCount)
	playerCountFrame.playerCount = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
	
	playerCountFrame.tankCount:SetText(tankCount)
	playerCountFrame.healerCount:SetText(healerCount)
	playerCountFrame.dpsCount:SetText(dpsCount)
end

-- group type row (raid or group)
groupStatusFrame.groupType = groupStatusFrame:CreateFontString("groupType", "OVERLAY", "GameFontNormal")
local frame = groupStatusFrame.groupType
frame:SetWidth(125)
frame:SetPoint("TOP",0,-44)
frame:SetText(HOPADDON_INGROUP)
frame:SetTextColor(1,1,1,1)

function groupStatusFrame.SetRaid(israid,leader)
	
	if israid then
		if leader then frame:SetText(RAID_LEADER) else
			frame:SetText(HOPADDON_INRAID)
		end
	else
		if leader then frame:SetText(PARTY_LEADER) else
			frame:SetText(HOPADDON_INGROUP)
		end
	end
end

-- convert group button
groupStatusFrame.convertToParty = CreateFrame("Button",nil,groupStatusFrame,"UIGoldBorderButtonTemplate")
local button = groupStatusFrame.convertToParty
button:SetSize(100,24)
button:SetPoint("BOTTOM",0,35)
button:SetText(CONVERT_TO_PARTY)
button:Hide()
button:SetScript("OnClick", function(btn)
	ConvertToParty()
end)

-- convert to raid button
groupStatusFrame.convertToRaid = CreateFrame("Button",nil,groupStatusFrame,"UIGoldBorderButtonTemplate")
local button = groupStatusFrame.convertToRaid
button:SetSize(100,24)
button:SetPoint("BOTTOM",0,35)
button:SetText(CONVERT_TO_RAID)
button:Hide()
button:SetScript("OnClick", function(btn)
	ConvertToRaid()
end)



-- exit group button
groupStatusFrame.leaveButton = CreateFrame("Button",nil,groupStatusFrame,"UIGoldBorderButtonTemplate")
local button = groupStatusFrame.leaveButton
button:SetSize(100,24)
button:SetPoint("BOTTOM",0,10)
button:SetText(PARTY_LEAVE)

groupStatusFrame.leaveButton:SetScript("OnClick", function(btn)
	LeaveAndBlackList()
	hopAddon.hopStatus:Hide()
end)

