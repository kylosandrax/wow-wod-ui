-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_WoWuction                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_wowuction           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- register this file with Ace Libraries
local TSM = select(2, ...)
TSM = LibStub("AceAddon-3.0"):NewAddon(TSM, "TSM_WoWuction", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillMaster_WoWuction") -- loads the localization table
local private = {}


StaticPopupDialogs["TSM_WOWUCTION_NO_DATA_POPUP"] = {
	text = "|cffff0000WARNING:|r TSM_WoWuction doesn't currently have any pricing data. Either download the TSM Desktop Application from |cff99ffffhttp://tradeskillmaster.com|r to automatically update TSM_WoWuction's data, or download data from |cff99ffffhttp://wowuction.com|r directly.",
	button1 = OKAY,
	timeout = 0,
	hideOnEscape = false,
}

local tooltipDefaults = {
	marketValue = true,
	medianPrice = false,
	dailySold = true,
	regionMarketValue = true,
	regionMedianPrice = false,
	regionDailyAvg = false,
}

-- Called once the player has loaded WOW.
function TSM:OnInitialize()
	-- register this module with TSM
	TSM:RegisterModule()
end

-- registers this module with TSM by first setting all fields and then calling TSMAPI:NewModule().
function TSM:RegisterModule()
	TSM.priceSources = {
		{ key = "wowuctionMarket", label = L["WoWuction Realm Market Value"], callback = private.GetData, arg = "marketValue" },
		{ key = "wowuctionMedian", label = L["WoWuction Realm Median Price"], callback = private.GetData, arg = "medianPrice" },
		{ key = "wowuctionMarketErr", label = L["WoWuction Realm Market STD Deviation"], callback = private.GetData, arg = "marketValueErr" },
		{ key = "wowuctionMedianErr", label = L["WoWuction Realm Median STD Deviation"], callback = private.GetData, arg = "medianPriceErr" },
		{ key = "wowuctionRegionMarket", label = L["WoWuction Region Market Value"], callback = private.GetData, arg = "regionMarketValue" },
		{ key = "wowuctionRegionMedian", label = L["WoWuction Region Median Price"], callback = private.GetData, arg = "regionMedianPrice" },
		{ key = "wowuctionRegionMarketErr", label = L["WoWuction Region Market STD Deviation"], callback = private.GetData, arg = "regionMarketValueErr" },
		{ key = "wowuctionRegionMedianErr", label = L["WoWuction Region Median STD Deviation"], callback = private.GetData, arg = "regionMedianPriceErr" },
	}
	TSM.tooltip = {callbackLoad="LoadTooltip", callbackOptions="LoadTooltipOptions", defaults=tooltipDefaults}

	TSMAPI:NewModule(TSM)
end

function TSM:OnEnable()
	local CURRENT_REALM = strlower(GetRealmName())
	local extractedData = {}
	local hasData = false
	
	
	local realmAppData, regionAppData
	local appData = TSMAPI.AppHelper and TSMAPI.AppHelper:FetchData("WOWUCTION_MARKET_DATA") -- get app data from TSM_AppHelper if it's installed
	if appData then
		for _, info in ipairs(appData) do
			local realm, data = unpack(info)
			if realm == "Global" then
				regionAppData = assert(loadstring(data))()
			elseif TSMAPI.AppHelper:IsCurrentRealm(realm) then
				realmAppData = assert(loadstring(data))()
			end
		end
	end
	
	if realmAppData or regionAppData then
		extractedData.lastUpdate = (realmAppData and realmAppData.downloadTime) or (regionAppData and regionAppData.downloadTime)
		hasData = true
		if realmAppData then
			for _, itemData in ipairs(realmAppData.data) do
				local itemID = itemData[1]
				extractedData[itemID] = extractedData[itemID] or {}
				for i=2, #itemData do
					local key = realmAppData.fields[i]
					if key == "dailySoldX100" then
						key = "dailySold"
						itemData[i] = itemData[i] / 100
					end
					extractedData[itemID][key] = itemData[i]
				end
			end
		end
		if regionAppData then
			for _, itemData in ipairs(regionAppData.data) do
				local itemID = itemData[1]
				extractedData[itemID] = extractedData[itemID] or {}
				for i=2, #itemData do
					local key = regionAppData.fields[i]
					if key == "regionAvgDailyQuantityX100" then
						key = "regionAvgDailyQuantity"
						itemData[i] = itemData[i] / 100
					end
					extractedData[itemID][key] = itemData[i]
				end
			end
		end
	elseif TSM.data then
		for realm, data in pairs(TSM.data) do
			if strlower(realm) == CURRENT_REALM and data.alliance then
				hasData = true
				extractedData = data.alliance
				extractedData.lastUpdate = data.lastUpdate
			end
		end
	end
	if not hasData then
		TSMAPI.Util:ShowStaticPopupDialog("TSM_WOWUCTION_NO_DATA_POPUP")
	end

	TSM.data = nil
	private.data = extractedData
end

local TOOLTIP_STRINGS = {
	marketValue = {L["Realm Market Value:"], L["Realm Market Value x%d:"]},
	medianPrice = {L["Realm Median Price:"], L["Realm Median Price x%d:"]},
	regionMarketValue = {L["Region Market Value:"], L["Region Market Value x%s:"]},
	regionMedianPrice = {L["Region Median Price:"], L["Region Median Price x%s:"]},
}
local function InsertTooltipValueLine(itemString, quantity, key, lines, moneyCoins, options, data)
	local value = data[key] or 0
	if not options[key] or value <= 0 then return end
	local errValue = data[key.."Err"]
	if not errValue then return end
	local strings = TOOLTIP_STRINGS[key]
	TSMAPI:Assert(strings, "Could not find tooltip strings for :"..tostring(key))
	
	local leftStr = "  "..(quantity > 1 and format(strings[2], quantity) or strings[1])
	local rightStr = TSMAPI:MoneyToString(value*quantity, "|cffffffff", "OPT_PAD", moneyCoins and "OPT_ICON" or nil).." (+/-"..TSMAPI:MoneyToString(errValue*quantity, "|cffffffff", "OPT_PAD", moneyCoins and "OPT_ICON" or nil)..")"
	tinsert(lines, {left=leftStr, right=rightStr})
end
function TSM:LoadTooltip(itemString, quantity, options, moneyCoins, lines)
	local itemID = TSMAPI.Item:ToItemID(itemString)
	if not itemID then return end
	local data = private.GetData(itemID)
	if not data then return end
	local numStartingLines = #lines
	
	-- add realm market value
	InsertTooltipValueLine(itemString, quantity, "marketValue", lines, moneyCoins, options, data)
	-- add realm median price
	InsertTooltipValueLine(itemString, quantity, "medianPrice", lines, moneyCoins, options, data)
	-- add realm daily sold
	if options.dailySold and data.dailySold and data.dailySold > 0 then
		tinsert(lines, {left="  "..L["Realm Avg Daily Sold Qty:"], right="|cffffffff"..data.dailySold})
	end
	-- add region market value
	InsertTooltipValueLine(itemString, quantity, "regionMarketValue", lines, moneyCoins, options, data)
	-- add region median price
	InsertTooltipValueLine(itemString, quantity, "regionMedianPrice", lines, moneyCoins, options, data)
	-- add region daily quantity
	if options.regionDailyAvg and data.regionAvgDailyQuantity and data.regionAvgDailyQuantity > 0 then
		tinsert(lines, {left="  "..L["Region Avg Daily Qty:"], right="|cffffffff"..data.regionAvgDailyQuantity})
	end
	
	-- add the header if we've added at least one line
	
	if #lines > numStartingLines then
		local lastScan = private.data and private.data.lastUpdate
		local rightStr = L["Not Scanned"]
		if lastScan then
			rightStr = format(L["%s ago"], SecondsToTime(time() - lastScan))
		end
		tinsert(lines, numStartingLines+1, {left="|cffffff00TSM WoWuction:|r", right="|cffffffff"..rightStr.."|r"})
	end
end

function private.GetData(itemID, key)
	if type(itemID) ~= "number" then itemID = TSMAPI.Item:ToItemID(itemID) end

	local data
	if not (private.data and private.data[itemID] and (not key or private.data[itemID][key])) then return end

	data = private.data[itemID]

	if key then
		return data[key] > 0 and data[key]
	else
		return data
	end
end

function TSM:LoadTooltipOptions(container, options)
	local page = {
		{
			type = "SimpleGroup",
			layout = "Flow",
			fullHeight = true,
			children = {
				{
					type = "CheckBox",
					label = L["Display realm market price in tooltip."],
					settingInfo = { options, "marketValue" },
					relativeWidth = 1,
					tooltip = L["If checked, the market value of the item will be shown"],
				},
				{
					type = "CheckBox",
					label = L["Display realm median price in tooltip."],
					settingInfo = { options, "medianPrice" },
					relativeWidth = 1,
					tooltip = L["If checked, the median price of the item will be shown."],
				},
				{
					type = "CheckBox",
					label = L["Display realm average daily sold quantity in tooltip."],
					settingInfo = { options, "dailySold" },
					relativeWidth = 1,
					tooltip = L["If checked, the average daily sold quantity for your realm will be shown."],
				},
				{
					type = "CheckBox",
					label = L["Display region market value in tooltip."],
					settingInfo = { options, "regionMarketValue" },
					relativeWidth = 1,
					tooltip = L["If checked, the market value across the region of the item will be shown."],
				},
				{
					type = "CheckBox",
					label = L["Display region median price in tooltip."],
					settingInfo = { options, "regionMedianPrice" },
					relativeWidth = 1,
					tooltip = L["If checked, the median price across the region of the item will be shown."],
				},
				{
					type = "CheckBox",
					label = L["Display region average daily quantity in tooltips."],
					settingInfo = { options, "regionDailyAvg" },
					relativeWidth = 1,
					tooltip = L["If checked, the average daily quantity across the region will be shown."],
				},
			},
		},
	}

	TSMAPI.GUI:BuildOptions(container, page)
end