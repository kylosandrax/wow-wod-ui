CrossRealmAssist = LibStub("AceAddon-3.0"):NewAddon("CrossRealmAssist", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0")
local addon = CrossRealmAssist;
local wholib = LibStub:GetLibrary('LibWho-2.0'):Library()
local ScrollingTable = LibStub("ScrollingTable");
local ldb = LibStub("LibDataBroker-1.1")
local minimapIcon = LibStub("LibDBIcon-1.0")
local db

local homeRealm, realmSep, gui, btRefresh, btSettings, btQuick, btManual, lbRealm, lbStatus, playerName, lfgui, lfgTabSelected, lfgTable, lbThrottle, curLfgGroup, sheduledScan, wasInGroup, inInstance
local settingsMenu
local hintShown
local cbHideGroups, cbHideRaids, cbHideNoAutoinv

local tabs = {}
local curRealmStat, curPartyStat
local scanstate=0
local recentRealms={}
local recentgroups={}
local autoScanGroups={}
local active=false
local allLanguageTable={}

local lfgGroups={
    6, -- Custom
    10, -- Ashran
    1, -- Quests
    3, -- Raids
    8 -- BGs
}

local StatusTable = {
    ["invited"]="Invited",
    ["declined"]="Declined",
    ["timedout"]="Timed out",
    ["applied"]="Applied",
    ["cancelled"]="Join cancelled",
    ["inviteaccepted"]="Joined",
    ["_init"]="Join request",
    ["_skip"]="Skipped"
}
local DefaultWidgetPos = {x=0, y=200, to="CENTER"}
local SettingsDefaults={
    global={
        minimap = {},
        widgetPos=DefaultWidgetPos,
        quickJoinHint = true,
        quickJoin={[6]=1,[10]=1},
        allLanguages = true
    }
}


-- Utils functions

local function PlayerName(fullname)
    fullname = fullname or "???-???"
    local name, realm = strsplit(realmSep, fullname)
    realm = realm or homeRealm;
    return name, realm;
end

local function canJoinGroup()
    return (not IsInGroup()) or (UnitIsGroupLeader('player') and not IsInRaid())
end

local function sortByWeight(a,b)
    return b.weight < a.weight
end


-- UI functions

local function createIcon(owner, icon, id)
    local image = owner:CreateTexture(nil, "BACKGROUND")
    image:SetWidth(16)
    image:SetHeight(16)
    image:SetTexture(icon)
    image:SetPoint("TOPLEFT",owner,"TOPLEFT",id*16,0)
    return image
end

local function setupWidget(widget, parameters, x, y)
    if parameters then
        for key,value in pairs(parameters) do widget[key](widget,value) end
    end
    if y then
        widget:SetPoint("TOPLEFT",widget:GetParent(),"TOPLEFT",x,-y)
    end
    return widget
end

local function ShowTooltip(widget)
    GameTooltip:SetOwner(widget, widget.TooltipAnchor)
    GameTooltip:ClearLines()
    widget:TooltipFactory()
    GameTooltip:Show()
end

local function HideTooltip(widget)
    GameTooltip:Hide()
end

local function setupTooltip(widget, anchor, factory)
    widget.TooltipAnchor = anchor;
    widget.TooltipFactory = factory;
    widget:SetScript("OnEnter", ShowTooltip)
    widget:SetScript("OnLeave", HideTooltip)
end

local function TabClick(tab)
    if tab == lfgTabSelected then return end
    addon.LfgScan(tab.searchID)
end

local function changeTab(tab)
    PanelTemplates_DeselectTab(lfgTabSelected)
    lfgTabSelected = tab
    PanelTemplates_SelectTab(lfgTabSelected)
end

local function realmToolip()
    if not curRealmStat then return end
    local players = curRealmStat.players;
    local threshold = curRealmStat.threshold
    GameTooltip:AddLine("Players in zone: "..players)
    if not curRealmStat.complete then
        GameTooltip:AppendText("+")
    end
    for i=1,curRealmStat.realms do
        local data = curRealmStat[i]
        local percent = math.ceil(100 * data.count / players - 0.5) .. "%";
        if data.count >= threshold then
            GameTooltip:AddDoubleLine(data.realm, percent, 0,1,0,0,1,0)
        else
            GameTooltip:AddDoubleLine(data.realm, percent, 0.5,0.5,0.5,0.5,0.5,0.5)
        end
    end
end

local function ClearRealmHistory()
    recentRealms = {}
    addon:updateCurrentRealm()
    if lfgTable then lfgTable:Refresh() end
end







-- LFG list data providers, filters and tooltips

local lfgScanInProgress=false
local hasLfgListChanges=false

local function addTooltipLineIcon(predicat, text, icon, r, g, b, wrap)
    if predicat then
        GameTooltip:AddLine(text, r, g, b, wrap)
        if icon then GameTooltip:AddTexture(icon) end
    end
end

local function WeightLfgItem(id, forAutoJoin)
    local _, action, caption, desc, voice, ilvl, time, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(id)
    if delisted then return 0 end
    local name,realm = PlayerName(fullname);
    if forAutoJoin then
        if not autoinv or pcount >= 35 or pcount <= 5 or recentgroups[fullname] then return 0 end
    end

    local autoinvWeight = autoinv and 5 or 2

    local visCoef = 1
    if recentgroups[fullname] then
        local ago = GetTime() - recentgroups[fullname].time;
        visCoef = math.min(1,ago/600)
    end

    local leaderRealm = 3 -- recently visited realms
    local realmVis = recentRealms[realm]
    local leaderRealm = 3;
    if realmVis then
        local ago = GetTime() - realmVis
        leaderRealm = 1 + 2*math.min(1,ago/600);
    end

    local countWeight = 4 -- count weight
    if pcount >= 39 or pcount <= 1 then countWeight = 1
    elseif pcount >= 35 or pcount <= 5 then countWeight = 2
    elseif pcount >= 30 or pcount <= 10 then countWeight = 3
    else countWeight = 4 end

    local ageWeight = 2
    if time > 1200 then ageWeight = 4
    elseif time > 300 then ageWeight = 3 end

    return leaderRealm * countWeight * visCoef * autoinvWeight * ageWeight;
end

local function AddLfgGroupInfo(id, short)
    local _, action, caption, desc, voice, ilvl, time, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(id)
    local friends = bnetfr+charfr+guild
    GameTooltip:ClearLines()
    GameTooltip:AddLine(caption,1,1,1)
    addTooltipLineIcon(desc ~= "", desc, nil, 0.5, 0.5, 0.5, true)
    local name, realm = PlayerName(fullname)
    GameTooltip:AddDoubleLine("Players:",pcount)
    GameTooltip:AddDoubleLine("Leader:",name)
    GameTooltip:AddDoubleLine("Leader realm:",realm)
    if recentRealms[realm] then
        local ago = GetTime() - recentRealms[realm]
        GameTooltip:AddDoubleLine("Realm visited",SecondsToTime(ago, false, false, 1, false).." ago",1,0.5,0,1,0.5,0)
    else
        GameTooltip:AddDoubleLine(" ","Realm not visited!",0,0,0,0,1,0)
    end
    if not short then
        addTooltipLineIcon(ilvl > 0, "Min. ilvl: "..ilvl, READY_CHECK_WAITING_TEXTURE, 1, 1, 0)
        addTooltipLineIcon(voice ~= "", "Voice: "..voice, READY_CHECK_WAITING_TEXTURE, 1, 1, 0)
        addTooltipLineIcon(friends > 0, "Friends: "..friends, READY_CHECK_WAITING_TEXTURE, 1, 1, 0)
        addTooltipLineIcon(autoinv, "Autoinvite!", READY_CHECK_READY_TEXTURE, 0, 1, 0)
        local visitinfo = recentgroups[fullname]
        if visitinfo then
            local ago = GetTime() - visitinfo.time;
            GameTooltip:AddDoubleLine(StatusTable[visitinfo.status] or visitinfo.status,SecondsToTime(ago, false, false, 1, false).." ago",1,0,0,1,0,0)
            GameTooltip:AddTexture(READY_CHECK_NOT_READY_TEXTURE)
        end
    end
    GameTooltip:Show()
end

local function ShowLfgInfo(rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, ...)
    if not realrow then return end
    local rowdata = scrollingTable:GetRow(realrow);
    GameTooltip:SetOwner(rowFrame, "ANCHOR_BOTTOMLEFT",-10,25)
    AddLfgGroupInfo(rowdata.id);
end

local function updateTableData(rowFrame, cellFrame, data, cols, row, realrow, column, fShow, table, ...)
    if fShow then
        local rowdata = table:GetRow(realrow);
        local icons = cellFrame.icons
        local _, action, caption, desc, voice, ilvl, time, bnetfr, charfr, guild, delisted, fullname, pcount, autoinv = C_LFGList.GetSearchResultInfo(rowdata.id)
        if not icons then
            local miscdata = createIcon(cellFrame,READY_CHECK_WAITING_TEXTURE,0)
            local autoinv = createIcon(cellFrame,READY_CHECK_READY_TEXTURE, 1)
            local visited = createIcon(cellFrame,READY_CHECK_NOT_READY_TEXTURE, 2)
            icons = {misc=miscdata, autoinv=autoinv, visited=visited}
            cellFrame.icons = icons
        end
        icons.misc:SetShown(voice ~= "" or bnetfr > 0 or charfr > 0 or guild > 0 or ilvl > 0)
        icons.autoinv:SetShown(autoinv)
        icons.visited:SetShown(recentgroups[fullname])
        if GameTooltip:GetOwner() == rowFrame then ShowLfgInfo(rowFrame, cellFrame, data, cols, row, realrow, column, table) end
    end
end

local function updateGroupName(id)
    return select(3, C_LFGList.GetSearchResultInfo(id))
end

local function updateGroupCount(id)
    return select(13, C_LFGList.GetSearchResultInfo(id))
end

local function updateGroupRealm(id)
    local name = select(12, C_LFGList.GetSearchResultInfo(id))
    local pname, realm = PlayerName(name);
    return realm
end

local COLOR_YELLOW = {r=1,g=1,b=0,a=1}
local COLOR_GREEN = {r=0,g=1,b=0,a=1}
local function updateRealmColor(id)
    local name = select(12, C_LFGList.GetSearchResultInfo(id))
    local pname, realm = PlayerName(name);
    return recentRealms[realm] and COLOR_YELLOW or COLOR_GREEN;
end

local function filterTable(self, row)
    local _, _, _, _, _, _, _, _, _, _, delisted, _, pcount, autoinv = C_LFGList.GetSearchResultInfo(row.id)
    if delisted then return false end;
    if pcount > 5 and cbHideRaids:GetChecked() then return false end;
    if pcount <= 5 and cbHideGroups:GetChecked() then return false end;
    if not autoinv and cbHideNoAutoinv:GetChecked() then return false end;
    return true;
end

function addon:UpdateResponseData(event, result)
    if not lfgTable then return end
    if select(11, C_LFGList.GetSearchResultInfo(result)) then
        lfgTable:SetFilter(filterTable)
    end
    hasLfgListChanges = true
end

local function refreshLFGList()
    if lfgScanInProgress or not lfgTable then return end
    local count, list = C_LFGList.GetSearchResults()
    local tableData = {}
    for i = 1,count do
        local rid = list[i];
        if not rid then break end
        local data = list[i];
        local cols = {}
        local row = {rid}
        cols[1] = {value=updateGroupName,args=row}
        cols[2] = {value=updateGroupCount,args=row}
        cols[3] = {value=updateGroupRealm,args=row,color=updateRealmColor,colorargs=row}
        cols[4] = {}
        table.insert(tableData, {cols=cols,id=rid,weight=WeightLfgItem(rid)})
    end
    table.sort(tableData, sortByWeight);
    lfgTable:SetData(tableData)
    if #tableData == 0 then
        lbThrottle:SetText("No groups found")
    end
end

local function JoinGroup(rid)
    local tank, heal, dd = C_LFGList.GetAvailableRoles()
    local noHealTank = not db.global.applyAsDD;
    addon:SetGroupJoinStatus(rid, "_init")
    C_LFGList.ApplyToGroup(rid, "", tank and noHealTank, heal and noHealTank, dd)
end

local function TableCellClick(rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, ...)
    if not realrow or not canJoinGroup() then return end
    local rowdata = scrollingTable:GetRow(realrow);
    JoinGroup(rowdata.id)
end






-- Addon functions and gui constructors

function addon.ShowMmTooltip(tooltip)
    tooltip:AddLine("Cross Realm Assist",1,1,1)
    tooltip:Show()
end

--[[function addon.MmClick(self, button)
    if button == "RightButton" then
        addon.ShowSettings(self)
    else
        addon:Activate()
    end
end]]

function addon:OnInitialize()
    db = LibStub("AceDB-3.0"):New("CrossRealmAssistDB", SettingsDefaults)
    local minimapData = ldb:NewDataObject("CrossRealmAssistMinimapIcon",{
        type = "data source",
        text = "Cross Realm Assist",
        icon = "Interface/Icons/INV_Misc_GroupNeedMore",
        OnClick = addon.Activate,
        OnTooltipShow = addon.ShowMmTooltip
    })
    minimapIcon:Register("CrossRealmAssistMinimapIcon", minimapData, db.global.minimap)
end

function addon:OnEnable()
    realmSep = _G.REALM_SEPARATORS
    playerName = UnitName("player")
    homeRealm = GetRealmName()
    addon:RegisterChatCommand("cra", "Activate")
    addon:RegisterChatCommand("crossrealmassist", "Activate")
end

function addon:OnDisable()
    addon:Deactivate()
end

function addon:Activate()
    if active then return end
    active=true
    wasInGroup = IsInGroup()
    if not gui then addon:CreateUI() end
    addon:updateCurrentRealm();
    addon:RefreshZoneAndClearHistory();
    gui:Show()
    addon:RegisterEvent("ZONE_CHANGED_NEW_AREA", "RefreshZoneAndClearHistory")
    addon:RegisterEvent("SCENARIO_UPDATE", "RefreshZoneAndClearHistory")
    addon:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED", "LfgResponseData")
    addon:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED", "UpdateResponseData")
    addon:RegisterEvent("LFG_LIST_SEARCH_FAILED", "LfgScanFailed")
    addon:RegisterEvent("GROUP_ROSTER_UPDATE", "updatePartyInfo")
    addon:RegisterEvent("LFG_LIST_APPLICATION_STATUS_UPDATED", "updateAppStatus")
    addon.LfgScan(addon.GetNextAutoScanCategory() or 1)
end

function addon:Deactivate()
    if not active then return end
    active = false
    gui:Hide()
    if lfgui then lfgui:Hide() end
    scanstate = 0
    lfgScanInProgress = false
    addon:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
    addon:UnregisterEvent("SCENARIO_UPDATE")
    addon:UnregisterEvent("PLAYER_REGEN_ENABLED")
    addon:UnregisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED")
    addon:UnregisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED")
    addon:UnregisterEvent("LFG_LIST_SEARCH_FAILED")
    addon:UnregisterEvent("GROUP_ROSTER_UPDATE")
    addon:UnregisterEvent("LFG_LIST_APPLICATION_STATUS_UPDATED")
end

function addon:SetStatus(status)
    if status then
        lbStatus:SetText(status)
    else
        lbStatus:SetText("")
    end
end

local function stopMovingWidget()
    gui:StopMovingOrSizing()
    local point,_,_,x,y = gui:GetPoint(1);
    db.global.widgetPos = {x=x,y=y,to=point}
end

function addon:CreateUI()
    gui = setupWidget(CreateFrame("Frame","CrossRealmAssistMainUI",nil,"InsetFrameTemplate3"), {SetFrameStrata="LOW",SetWidth=208,SetHeight=60,EnableMouse=true,SetMovable=true,SetClampedToScreen=true})
    local title = setupWidget(CreateFrame("Frame",nil,gui), {SetWidth=190,SetHeight=18,EnableMouse=true,RegisterForDrag="LeftButton"}, 0, 6);
    title:SetScript("OnDragStart", function() gui:StartMoving() end)
    title:SetScript("OnDragStop", stopMovingWidget)
    gui:SetScript("OnHide", addon.Deactivate)
    setupTooltip(title, "ANCHOR_TOP", realmToolip)

    lbRealm = setupWidget(gui:CreateFontString(nil,"BACKGROUND", "GameFontNormal"), {SetWidth=200,SetHeight=18}, 0, 6)
    lbStatus = setupWidget(gui:CreateFontString(nil,"BACKGROUND", "GameFontHighlightSmallLeft"), {SetWidth=200,SetHeight=10}, 6, 23)

    btQuick = setupWidget(CreateFrame("Button",nil,gui,"UIMenuButtonStretchTemplate"),{SetWidth=90,SetHeight=20,SetText="Quick join"},4,36)
    btQuick:RegisterForClicks("RightButtonUp","LeftButtonUp")
    btQuick:SetScript("OnClick",addon.DoAutoAction)
    setupTooltip(btQuick, "ANCHOR_BOTTOM", addon.actionTooltip)
    btManual = setupWidget(CreateFrame("Button",nil,gui,"UIMenuButtonStretchTemplate"),{SetWidth=90,SetHeight=20,SetText="Manual join"},94,36)
    btManual:SetScript("OnClick",addon.ShowManualLfg)
    setupWidget(CreateFrame("Button",nil,gui,"UIPanelCloseButton"),{EnableMouse=true,SetWidth=20,SetHeight=20},188,0)

    btRefresh = setupWidget(CreateFrame("Button",nil,gui,"UIPanelSquareButton"),{SetWidth=20,SetHeight=20},184,16)
    btRefresh.icon:SetTexture("Interface/BUTTONS/UI-RefreshButton")
    btRefresh.icon:SetTexCoord(0,1,0,1);
    btRefresh:SetScript("OnClick",addon.RefreshZone)

    btSettings = setupWidget(CreateFrame("Button",nil,gui,"UIPanelSquareButton"),{SetWidth=20,SetHeight=20},184,36)
    btSettings.icon:SetTexture("Interface/Worldmap/Gear_64Grey")
    btSettings.icon:SetTexCoord(0.1,0.9,0.1,0.9);
    btSettings:SetScript("OnClick",addon.ShowSettings)

    local savedPos = db.global.widgetPos
    gui:SetPoint(savedPos.to,savedPos.x,savedPos.y)
    addon:UpdateAutoButtonStatus()

    local languages = C_LFGList.GetAvailableLanguageSearchFilter()
    for i=1,#languages do
        allLanguageTable[languages[i]] = true;
    end
end

function addon:ShowManualLfg()
    if not lfgui then addon:CreateLFGUI() end
    lfgui:Show()
end

function addon.lfgUpdate()
    if hasLfgListChanges then
        lfgTable:Refresh()
        hasLfgListChanges = false
    end
end

function addon.refreshList()
    lfgTable:SetFilter(filterTable)
end

function addon:CreateLFGUI()
    lfgui = setupWidget(CreateFrame("Frame","CrossRealmAssistJoinUI",nil,"UIPanelDialogTemplate"), {SetFrameStrata="DIALOG",SetWidth=405,SetHeight=323,EnableMouse=true,SetMovable=true})
    lfgui.title:SetText("Click to join group")
    lfgui:SetScript("OnUpdate",addon.lfgUpdate)
    local titlereg = lfgui:CreateTitleRegion()
    titlereg:SetAllPoints(lfgui.title)
    addon:CreateTabs()

    lfgTable = ScrollingTable:CreateST({
        {name="Title",width=160},
        {name="#",width=30,align="CENTER"},
        {name="Realm",width=120,align="RIGHT"},
        {name="",width=50,DoCellUpdate=updateTableData}
    },15,16,nil,lfgui);

    lfgTable:RegisterEvents({OnEnter=ShowLfgInfo,OnLeave=HideTooltip,OnClick=TableCellClick})

    setupWidget(lfgTable.frame, nil, 10, 45);
    lfgTable.frame:SetBackdrop(nil)
    lfgui:SetPoint("CENTER",0,0)
    refreshLFGList()

    lbThrottle = setupWidget(lfgui:CreateFontString(nil,"BACKGROUND", "GameFontHighlightSmall"), {SetWidth=300}, 50, 100)
    lbThrottle:Hide();

    local btRefresh = setupWidget(CreateFrame("Button",nil,lfgui,"UIPanelSquareButton"),{SetWidth=22,SetHeight=22},379,27)
    btRefresh.icon:SetTexture("Interface/BUTTONS/UI-RefreshButton")
    btRefresh.icon:SetTexCoord(0,1,0,1);
    btRefresh:SetScript("OnClick",addon.refreshLfgCurrent)

    setupWidget(CreateFrame("Frame",nil,lfgui,"HorizontalBarTemplate"),{SetWidth=392,SetHeight=2}, 8, 294)
    local text = setupWidget(lfgui:CreateFontString(nil,"BACKGROUND", "GameFontHighlightSmall"), {SetText="Hide:"}, 20, 302)

    cbHideGroups = setupWidget(CreateFrame("CheckButton",nil,lfgui,"UICheckButtonTemplate"),{SetWidth=22,SetHeight=22})
    cbHideGroups:SetPoint("TOPLEFT",text,"TOPRIGHT",5,7)
    cbHideGroups:SetScript("OnClick",addon.refreshList)
    text = setupWidget(lfgui:CreateFontString(nil,"BACKGROUND", "GameFontHighlightSmall"), {SetText="5p Groups"})
    text:SetPoint("TOPLEFT",cbHideGroups,"TOPRIGHT",0,-7)

    cbHideRaids = setupWidget(CreateFrame("CheckButton",nil,lfgui,"UICheckButtonTemplate"),{SetWidth=22,SetHeight=22})
    cbHideRaids:SetPoint("TOPLEFT",text,"TOPRIGHT",5,7)
    cbHideRaids:SetScript("OnClick",addon.refreshList)
    text = setupWidget(lfgui:CreateFontString(nil,"BACKGROUND", "GameFontHighlightSmall"), {SetText="Raids"})
    text:SetPoint("TOPLEFT",cbHideRaids,"TOPRIGHT",0,-7)

    cbHideNoAutoinv = setupWidget(CreateFrame("CheckButton",nil,lfgui,"UICheckButtonTemplate"),{SetWidth=22,SetHeight=22})
    cbHideNoAutoinv:SetPoint("TOPLEFT",text,"TOPRIGHT",5,7)
    cbHideNoAutoinv:SetScript("OnClick",addon.refreshList)
    text = setupWidget(lfgui:CreateFontString(nil,"BACKGROUND", "GameFontHighlightSmall"), {SetText="Groups w/o Autoinvite"})
    text:SetPoint("TOPLEFT",cbHideNoAutoinv,"TOPRIGHT",0,-7)
end

function addon:CreateTabs()
    local prevTab
    for i=1,#lfgGroups do
        local tab = CreateFrame("Button","$parentTab"..i,lfgui,"CharacterFrameTabButtonTemplate")
        tab:SetText((C_LFGList.GetCategoryInfo(lfgGroups[i])));
        tab.searchID = i;
        tab:SetID(i);
        PanelTemplates_TabResize(tab, 0)
        if i == 1 then
            tab:SetPoint("TOPLEFT", lfgui, "BOTTOMLEFT", 10, 7)
            lfgTabSelected = tab
        else
            tab:SetPoint("TOPLEFT", prevTab, "TOPRIGHT",-15,0)
        end
        if curLfgGroup == i then
            PanelTemplates_SelectTab(tab)
        else
            PanelTemplates_DeselectTab(tab)
        end
        tab:SetScript("OnClick", TabClick)
        tabs[i] = tab
        prevTab = tab
    end
end

-- LFG scanning routine

function addon.refreshLfgCurrent()
    addon.LfgScan(curLfgGroup)
end

function addon.GetNextAutoScanCategory()
    for i=1,#lfgGroups do
        if not autoScanGroups[i] and db.global.quickJoin[lfgGroups[i]] and i ~= curLfgGroup then return i end
    end
    return nil
end

function addon.LfgScan(group)
    if lfgTable then
        lfgTable:SetData({})
        changeTab(tabs[group])
    end
    lfgScanInProgress = true
    curLfgGroup = group
    local languages = db.global.allLanguages and allLanguageTable or C_LFGList.GetLanguageSearchFilter();
    C_LFGList.Search(lfgGroups[curLfgGroup],"",nil,nil,languages)
end

function addon:LfgScanFailed(event, reason)
    reason = reason or "Unknown reason";
    if reason == "throttled" then
        addon:ScheduleTimer(addon.LfgScan, 2, curLfgGroup)
    end
    if lbThrottle then
        if reason == "throttled" then
            lbThrottle:SetText("LFG scan is delayed (throttled).\nThis page will update automatically...")
        else
            lbThrottle:SetText("Scan failed ("..reason..")")
        end
        lbThrottle:Show()
    end
end

function addon:LfgResponseData()
    lfgScanInProgress = false;
    addon:UpdateAutoButtonStatus()
    if lbThrottle then lbThrottle:Hide() end
    refreshLFGList()
end

function addon:updateAppStatus(event, id, status, oldstatus)
    if status == "invited" then
        LFGListInviteDialog_Accept(LFGListInviteDialog)
    end
    addon:UpdateAutoButtonStatus()
    addon:SetGroupJoinStatus(id, status)
end

function addon:SetGroupJoinStatus(id, status)
    local name = select(12, C_LFGList.GetSearchResultInfo(id))
    if name then
        recentgroups[name] = {status=status, time=GetTime()}
    end
end

function addon:RealmVisited(realm, head)
    recentRealms[realm] = GetTime()
end

function addon:updatePartyInfo()
    curPartyStat = {}
    local inGroup = IsInGroup()
    if inGroup then
        if IsInRaid() then
            for i=1, MAX_RAID_MEMBERS do
                addon:AddUnitIdStat("raid"..i, curPartyStat)
            end
        else
            for i=1, MAX_PARTY_MEMBERS do
                addon:AddUnitIdStat("party"..i, curPartyStat)
            end
        end
    end
    if inGroup ~= wasInGroup  then
        addon:RefreshZone(true)
        wasInGroup = inGroup
        addon:UpdateAutoButtonStatus()
    end
end




-- Zone scanning routine

function addon:LeaveCombat()
    addon:UnregisterEvent("PLAYER_REGEN_ENABLED")
    scanstate = 0
    addon:ScanRealm();
end

function addon:RefreshZoneAndClearHistory()
    ClearRealmHistory()
    addon:RefreshZone(true)
end

function addon:RefreshZone(shedule)
    local inst, instType = IsInInstance()
    inInstance = (inst or instType ~= "none")
    if inInstance then
        lbRealm:SetText("Instanced zone")
        curRealmStat = nil
        inInstance = true
    else
        inInstance = false;
        if scanstate == 0 then
            addon:ScanRealm()
        elseif shedule == true and scanstate == 2 then
            addon:SetStatus("Rescan sheduled...")
            scanstate = 3
        end
    end
    addon:UpdateAutoButtonStatus()
end

function addon:ScanRealm()
    if scanstate > 0 then return end
    if InCombatLockdown() then
        addon:RegisterEvent("PLAYER_REGEN_ENABLED","LeaveCombat")
        scanstate = 1
        addon:SetStatus("Scan sheduled after combat...");
        return
    end
    scanstate = 2
    addon:SetStatus("Scanning current realm...");
    local searchString = _G.WHO_TAG_ZONE .. '"' .. GetZoneText() .. '"';
    wholib:Who(searchString, {callback = "ScanResult", handler=addon})
end

function addon:ScanResult(query, results, complete)
    local realms = {}
    for _, player in ipairs(results) do
        addon:AddRealmStat(player.Name, realms);
    end
    curRealmStat = addon:GetRealmStat(realms);
    curRealmStat.complete = complete
    addon:updateCurrentRealm();
    local rescan = scanstate == 3
    scanstate = 0;
    if rescan then addon:ScanRealm() end
end

function addon:AddRealmStat(name, realms)
    if (name == playerName) then return end
    local _, realm = strsplit(realmSep, name)
    realm = realm or homeRealm
    realms[realm] = (realms[realm] or 0) + 1
end

function addon:AddUnitIdStat(unitid, realms)
    local name, realm = UnitName(unitid);
    if not name then return end
    if realm == "" then realm = homeRealm end
    realm = realm or homeRealm
    realms[realm] = (realms[realm] or 0) + 1
end

function addon:GetRealmStat(realms)
    local rcount = 0;
    local stat = {};
    local pcount = 0;
    if realms then
        for realm,count in pairs(realms) do
            table.insert(stat,{realm=realm,count=count})
            rcount = rcount + 1;
            pcount = pcount + count;
        end
    end
    if rcount > 1 then
        table.sort(stat, function(a,b) return a.count > b.count end)
        stat.max = stat[1].count
    else stat.max = 0 end
    stat.players = pcount;
    stat.realms = rcount;
    return stat;
end

function addon:updateCurrentRealm()
    addon:SetStatus();
    if not curRealmStat or curRealmStat.realms < 1 then
        lbRealm:SetText("Unknown realm (No players)")
        return;
    end

    local bestRealm = curRealmStat[1]
    addon:RealmVisited(bestRealm.realm, true)
    local prevThreshold = math.min(bestRealm.count/3,10)
    local mixCount = 0
    for i=2,curRealmStat.realms do
        local data = curRealmStat[i]
        if data.count >= prevThreshold then
            mixCount = mixCount + 1
            addon:RealmVisited(data.realm)
            prevThreshold = math.min(data.count/3,10)
        end
    end
    curRealmStat.threshold = prevThreshold

    if (mixCount > 0) then
        lbRealm:SetText("Mixed "..bestRealm.realm.." +"..mixCount)
    else
        lbRealm:SetText(bestRealm.realm)
    end
end






-- Auto action button

local action

local LeaveGroup = {
    func = LeaveParty;
    tooltip = function(self)
        local partyStat = addon:GetRealmStat(curPartyStat)
        GameTooltip:AddLine("Players in party "..partyStat.players)
        local max = partyStat.max;
        for i=1,#partyStat do
            local data = partyStat[i]
            local percent = math.ceil(100 * data.count / partyStat.players - 0.5) .. "%";
            local pmax = data.count/max;
            local green = 0.5 + pmax * 0.5;
            local gray = 0.5 * (1-pmax)
            GameTooltip:AddDoubleLine(data.realm, percent, gray,green,gray,gray,green,gray)
        end
        GameTooltip:AddLine("Click to leave party",1,0.5,0)
    end,
    text = "Leave group"
}

local CancelJoin = {
    func = function()
        local apps = C_LFGList.GetApplications();
        if apps[1] then
            C_LFGList.CancelApplication(apps[1])
        end
    end,
    tooltip = "Cancel your current join application",
    text = "Cancel join"
}

local QuickJoin = {
    func = function(self, button)
        if button == "RightButton" then
            addon:SetGroupJoinStatus(self.groupToJoin, "_skip")
        else
            local delisted = select(11, C_LFGList.GetSearchResultInfo(self.groupToJoin))
            if delisted == false then
                JoinGroup(self.groupToJoin)
            else
                addon:SetStatus("Group just delisted")
            end
        end
    end,
    findGroup = function()
        local count, list = C_LFGList.GetSearchResults()
        local best
        local bestvalue = 0
        for i = 1,count do
            local rid = list[i];
            if not rid then break end
            local value = WeightLfgItem(rid, true);
            if value > bestvalue then
                best = rid
                bestvalue = value
            end
        end
        return best
    end,
    tooltip = function(self)
        AddLfgGroupInfo(self.groupToJoin, true)
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("Click to join","Right click to skip",0,1,0,1,0.5,0)
    end,
    text = "Quick join"
}

local ScanNext = {
    func = function(self)
        autoScanGroups[curLfgGroup] = 1
        addon.LfgScan(self.category)
    end,
    tooltip = function(self)
        GameTooltip:AddLine("Scan "..(C_LFGList.GetCategoryInfo(lfgGroups[self.category])))
    end,
    text = "Scan more"
}

local NeedReset = {
    func = function()
        wipe(autoScanGroups);
        local categoryToScan = addon.GetNextAutoScanCategory()
        if categoryToScan then
            addon.LfgScan(categoryToScan)
        end
    end,
    tooltip = "Scan again",
    text = "Restart scan"
}

local Wait = {
    tooltip = "Scan in progress",
    text = "Wait..."
}

local ShowQuickHint = {
    tooltip = "Quick Join",
    text = "Quick Join",
    func = function()
        StaticPopupDialogs["CROSS_REALM_ASSIST"] = {
            text = "Quick Join button will automatically join you to a random group with autoinvite and medium number of players. You never join same group twice, you need to clear join history to do so. This message can be disabled in options.",
            button1 = OKAY,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("CROSS_REALM_ASSIST")
        hintShown = true;
    end
}

function addon.DoAutoAction(widget, button)
    addon:SetStatus()
    if action and action.func then
        action:func(button)
    end
    addon:UpdateAutoButtonStatus()
end

function addon.actionTooltip()
    local tooltip = action.tooltip
    if type(tooltip) == 'function' then
        tooltip(action)
    else
        GameTooltip:AddLine(tooltip)
    end
end

function addon:UpdateAutoButtonStatus()
    if not btQuick then return end
    btQuick:Enable()
    if IsInGroup() then
        action = LeaveGroup;
    elseif C_LFGList.GetNumApplications() > 0 then
        action = CancelJoin;
    elseif lfgScanInProgress then
        action = Wait
    elseif not hintShown and db.global.quickJoinHint then
        action = ShowQuickHint;
    else
        local group = QuickJoin.findGroup();
        if group then
            action = QuickJoin;
            QuickJoin.groupToJoin = group
        else
            local categoryToScan = addon.GetNextAutoScanCategory()
            if (categoryToScan) then
                action = ScanNext;
                ScanNext.category = categoryToScan
            else
                action = NeedReset;
            end
        end
    end
    btQuick:SetText(action.text)
    if GameTooltip:GetOwner() == btQuick then
        ShowTooltip(btQuick)
    end
end






-- Settings

local function toggleMinimapIcon(btn, arg1, arg2, checked)
    local hidden = not checked;
    db.global.minimap.hide = hidden;
    if hidden then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Type |cffffffff/cra |cffff0000in chat to open Cross Realm Assist without minimap button");
        minimapIcon:Hide("CrossRealmAssistMinimapIcon")
    else
        minimapIcon:Show("CrossRealmAssistMinimapIcon")
    end
end

local function toggleQuickJoinHint(btn, arg1, arg2, checked)
    db.global.quickJoinHint = checked
end

local function toggleQuickJoin(btn, arg1, arg2, checked)
    db.global.quickJoin[arg1] = checked
end

local function toggleAllLanguages(btn, arg1, arg2, checked)
    db.global.allLanguages = checked
end

local function toggleApplyAsDD(btn, arg1, arg2, checked)
    db.global.applyAsDD = checked
end

local function ClearJoinHistory()
    recentgroups = {}
    addon:UpdateAutoButtonStatus()
    if lfgTable then lfgTable:Refresh() end
end

--[[local function resetPos()
    db.global.widgetPos = DefaultWidgetPos
    if gui then
        gui:ClearAllPoints()
        gui:SetPoint(DefaultWidgetPos.to,DefaultWidgetPos.x,DefaultWidgetPos.y)
    end
end]]

local function initMenu(self, level)
    if not level then return end
    if level == 1 then
        UIDropDownMenu_AddButton({text="Clear realm history",notCheckable=1,func=ClearRealmHistory}, level)
        UIDropDownMenu_AddButton({text="Clear join history",notCheckable=1,func=ClearJoinHistory}, level)
        UIDropDownMenu_AddButton({disabled=1,notCheckable=1}, level)
        UIDropDownMenu_AddButton({isTitle=1,text="Settings",notCheckable=1}, level)
        UIDropDownMenu_AddButton({text="Show Minimap Button",checked=not db.global.minimap.hide, func=toggleMinimapIcon,keepShownOnClick=true,isNotRadio=true}, level)
        UIDropDownMenu_AddButton({text="All language groups",checked=db.global.allLanguages, func=toggleAllLanguages,keepShownOnClick=true,isNotRadio=true}, level)
        UIDropDownMenu_AddButton({text="Apply to groups as DD only",checked=db.global.applyAsDD, func=toggleApplyAsDD,keepShownOnClick=true,isNotRadio=true}, level)
        UIDropDownMenu_AddButton({text="Show Quick Join Hint",checked=db.global.quickJoinHint, func=toggleQuickJoinHint,keepShownOnClick=true,isNotRadio=true}, level)
        UIDropDownMenu_AddButton({text="Quick join categories",notCheckable=1,hasArrow=1,value="qjc",keepShownOnClick=true}, level)
    elseif level == 2 then
        if UIDROPDOWNMENU_MENU_VALUE == "qjc" then
            for i=1,#lfgGroups do
                local groupId = lfgGroups[i]
                UIDropDownMenu_AddButton({text=(C_LFGList.GetCategoryInfo(groupId)),checked=db.global.quickJoin[groupId],arg1=groupId,func=toggleQuickJoin,keepShownOnClick=true,isNotRadio=true}, level)
            end
        end
    end
end

function addon.ShowSettings(frame)
    if not settingsMenu then
        settingsMenu = CreateFrame("Frame", "CrossRealmAssistMenu")
        settingsMenu.displayMode = "MENU"
        settingsMenu.initialize = initMenu
    end
    ToggleDropDownMenu(1, nil, settingsMenu, frame, 10, 0)
end