SERVERHOP_VERSION = GetAddOnMetadata("ServerHop", "Version")

-- GUI
HOPADDON_WIDTH = 240
HOPADDON_HEIGHT = 110
HOPADDON_HEIGHTOPTIONS = 100
-- globals
HOPADDON_MAX_RESULTS = 100 -- C_LFGList.GetSearchResults() return count and list, #list is always capped at 100 ):


hopAddon = CreateFrame("Frame",nil,UIParent)
hopAddon:SetPoint("CENTER",0,0)
hopAddon:SetFrameStrata("HIGH")
hopAddon:SetFrameLevel(1)
hopAddon:SetWidth(HOPADDON_WIDTH)
hopAddon:SetHeight(HOPADDON_HEIGHT)
hopAddon:SetBackdrop({bgFile = "Interface\\FrameGeneral\\UI-Background-Rock", 
					edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", 
					tile = true, tileSize = 200, edgeSize = 24, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
hopAddon:SetBackdropColor(1,1,1,1);
hopAddon:SetMovable(true)
hopAddon:EnableMouse(true)
hopAddon:RegisterForDrag("LeftButton")
hopAddon:SetScript("OnDragStart", hopAddon.StartMoving)
hopAddon:SetScript("OnDragStop", hopAddon.StopMovingOrSizing)
hopAddon:Hide()

hopAddon:SetScript("OnHide",function(self)
		HelpPlate_Hide(true)
end)

-- Toggle button attached to LFGListFrame
local toggleButton = CreateFrame("Button",nil,LFGListFrame,"UIPanelButtonTemplate")
toggleButton:SetSize(70,22)
toggleButton:SetPoint("BOTTOM",LFGListFrame,"BOTTOM",-4,5)
toggleButton:SetText(" ServerHop")
toggleButton:SetScript("OnClick", function(btn)
	if hopAddon:IsShown() then
		hopAddon:Hide()
	else
		hopAddon:Show()
	end
end)

toggleButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(HOPADDON_TOGGLE)
	GameTooltip:Show()
end)
toggleButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

-- Attaching warning frame to LFGList
hopAddon_LFGWarning = CreateFrame("Button",nil,LFGListFrame)
local f = hopAddon_LFGWarning
f:SetPoint("TOPRIGHT",-5,-25)
f:SetPoint("BOTTOMLEFT",-1,26)
f:SetFrameStrata("HIGH")
f:Hide()

f.bg = f:CreateTexture(nil, "BACKGROUND")
f.bg:SetAllPoints(f)
f.bg:SetAtlas("groupfinder-background",true)

f.label = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
f.label:SetSize(305,0)
f.label:SetPoint("CENTER",0,0)
f.label:SetText(HOPADDON_SEARCHINGWARNING)

f.btn = CreateFrame("Button",nil,f,"UIPanelButtonTemplate")
f.btn:SetSize(70,22)
f.btn:SetPoint("CENTER",0,-35)
f.btn:SetText(YES)



SLASH_SERVERHOP1 = "/sh" SLASH_SERVERHOP2 = "/serverhop"
SlashCmdList["SERVERHOP"] = function(msg, editbox)
	hopAddon:Show()
end

hopAddon.minimap = LibStub("LibDBIcon-1.0")
-- Variables
hopAddon.var = CreateFrame("Frame")
-- Custom Search Declarations
hopAddon.var.addonSearchRequest = false
hopAddon.var.pvpList = {}
hopAddon.var.minimapDB = {
	global = {
		minimap = {hide = false}
	}
}

-- Functions
function hopAddon_GatherPvPRealms(region)
	hopAddon.var.pvpList = {}
	for k,v in pairs(hopAddon_Realmlist) do
		if v.region == region and v.pvp == true then
			local blizzname = v.name:gsub("[%s]+", "")
			hopAddon.var.pvpList[blizzname] = true
		end
	end
end


function FullScaleSearch(selection, str, filter1, filter2)
	--print("Called search")
	local lang={}
	for k,v in pairs(C_LFGList.GetAvailableLanguageSearchFilter()) do lang[v]=true end
	C_LFGList.ClearSearchResults()
	C_LFGList.Search(selection, str, filter1, filter2, lang)
end

function NotInGroup()
    return (not IsInGroup() and not IsInRaid())
end

function canJoinGroup()
    return (not IsInGroup()) or (UnitIsGroupLeader('player') and not IsInRaid())
end

function hopAddon_GetRealm(region, name)
	for index, info in pairs(hopAddon_Realmlist) do
		if info.region == region and info.name == name then
			return info;
		end
	end
	
	return nil;
end