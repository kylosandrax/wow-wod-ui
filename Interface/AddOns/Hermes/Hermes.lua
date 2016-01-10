local AddonName, Hermes = ...
local LIB_AceAddon = LibStub("AceAddon-3.0") or error("Required library AceAddon-3.0 not found")
_G[AddonName] = LIB_AceAddon:NewAddon(Hermes, AddonName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceComm-3.0", "AceSerializer-3.0")

local L = LibStub('AceLocale-3.0'):GetLocale('Hermes')
local LIB_AceConfigRegistry = LibStub("AceConfigRegistry-3.0") or error("Required library AceConfigRegistry-3.0 not found")
local LIB_AceConfig = LibStub("AceConfig-3.0") or error("Required library AceConfig-3.0 not found")
local LIB_AceDB = LibStub("AceDB-3.0") or error("Required library AceDB-3.0 not found")
local LIB_AceConfigDialog = LibStub("AceConfigDialog-3.0")  or error("Required library AceConfigDialog-3.0 not found")

local HERMES_VERSION = GetAddOnMetadata(AddonName, "X-Curse-Packaged-Version") or "(dev)"
local HERMES_VERSION_STRING = AddonName.." "..HERMES_VERSION

Hermes.HERMES_VERSION_STRING = HERMES_VERSION_STRING

--default all modules to disabled
Hermes:SetDefaultModuleState(false)
local MOD_Reincarnation = nil
local MOD_Talents = nil

local dbp
local dbg

local core = {}

local Player = {}
local Senders = {}
local Abilities = {}
local AbilityInstances = {}
local Plugins = {}
local Events = {}
local Players = {}						-- used while monitoring combat log to keep track of all player abilities

local INVALIDATE_TIME_THRESHOLD = 2		-- number of seconds to use in determining whether saved values using GetTime() are no longer reliable

local PLAYER_IS_WARLOCK = false

local REQUIREMENT_KEYS = {
	--note that class isn't a requirement because it's specified by the spell
	PLAYER_LEVEL	= 10,
	PLAYER_NAMES	= 15,
	PLAYER_RACE		= 20,
	TALENT_NAME		= 25,
	TALENT_SPEC		= 30,
	TALENT_SPEC_INVERT		= 35,
}

local REQUIREMENT_VALUES = {
	["PLAYER_LEVEL"]	= L["Player Level"],
	["PLAYER_RACE"]		= L["Player Race"],
	["PLAYER_NAMES"]	= L["Player Names"],
	["TALENT_NAME"]		= L["Talent Name"],
	["TALENT_SPEC"]		= L["Specialization"],
}

local ADJUSTMENT_KEYS = {
	PLAYER_NAME		= 5,
	PLAYER_LEVEL	= 10,
	TALENT_NAME		= 25,
	TALENT_SPEC		= 30,
}

local ADJUSTMENT_VALUES = {
	["PLAYER_NAME"]		= L["Player Name"],
	["PLAYER_LEVEL"]	= L["Player Level"],
	["TALENT_NAME"]		= L["Talent Name"],
	["TALENT_SPEC"]		= L["Specialization"],
}

local SCAN_FREQUENCY = 0.06
local DELTA_THRESHOLD_FOR_REMAINING_CHANGE = 3

local MAX_PLAYER_LEVEL = GetMaxPlayerLevel()
local MAX_TALENT_RANK = 5
local SPELL_AUTOSET_THRESHOLD = 30		-- ignore any cooldowns happening earlier than this many seconds from the time the sender registered itself

--local independent class lookup, used mostly to keep message size down when sending messages.
local CLASS_ENUM = {
	[1]		= "ANY",
	[2]		= "DEATHKNIGHT",
	[3]		= "DRUID",
	[4]		= "HUNTER",
	[5]		= "MAGE",
	[6]		= "MONK",
	[7]		= "PALADIN",
	[8]		= "PRIEST",
	[9]		= "ROGUE",
	[10]	= "SHAMAN",
	[11]	= "WARLOCK",
	[12]	= "WARRIOR",
}

local SPECIALIZATION_IDS = {
	["DEATHKNIGHT"] = {
		[250] = "Blood",
		[251] = "Frost",
		[252] = "Unholy"
	},
	
	["DRUID"] = {
		[102] = "Balance",
		[103] = "Feral",
		[104] = "Guardian",
		[105] = "Restoration"
	},
	-- Hunter
	["HUNTER"] = {
		[253] = "Beast Mastery",
		[254] = "Marksmanship",
		[255] = "Survival"
	},

	-- Mage
	["MAGE"] = {
		[62] = "Arcane",
		[63] = "Fire",
		[64] = "Frost"
	},

	-- Monk
	["MONK"] = {
		[268] = "Brewmaster",
		[269] = "Windwalker",
		[270] = "Mistweaver"
	},
	
	-- Paladin
	["PALADIN"] = {
		[65] = "Holy",
		[66] = "Protection",
		[67] = "Retribution"
	},

	-- Priest
	["PRIEST"] = {
		[256] = "Discipline",
		[257] = "Holy",
		[258] = "Shadow",
	},

	-- Rogue
	["ROGUE"] = {
		[259] = "Assassination",
		[260] = "Combat",
		[261] = "Subtlety"
	},

	-- Shaman
	["SHAMAN"] = {
		[262] = "Elemental",
		[263] = "Enhancement",
		[264] = "Restoration"
	},

	-- Warlock
	["WARLOCK"] = {
		[265] = "Affliction",
		[266] = "Demonology",
		[267] = "Destruction"
	},

	-- Warrior
	["WARRIOR"] = {
		[71] = "Arms",
		[72] = "Fury",
		[73] = "Protection"
	}
}

local MESSAGE_ENUM = {
	[1]		= "INITIALIZE_SENDER",
	[2]		= "INITIALIZE_RECEIVER",
	[3]		= "REQUEST_SPELLS",
	[4]		= "UPDATE_SPELLS",
}

local HERMES_SEND_COMM = "HermesS1"
local HERMES_RECEIVE_COMM = "HermesR1"

local Sender = nil
local Receiving = false

local ITEM_NAME_TIMER = nil
local ITEM_NAME_THROTTLE = 20									--how often to scan server for itme name info, three times a minute currently

local COOLDOWN_SCAN_TIMER = nil
local COOLDOWN_SCAN_FREQUENCY_INITIAL = 10						--Used the throttle oneself when first starting up sending.
																--This is to allow time for all the receivers in the raid to request their spells.
																--This results in fewer SPELL_UPDATES being sent when first starting up
local COOLDOWN_SCAN_FREQUENCY = 1
local COOLDOWN_DELTA_THRESHOLD = COOLDOWN_SCAN_FREQUENCY * 5	--used to avoid sending messages for cooldowns that have expired normally
																--and used to determine whether cooldowns have decreased unexpectedly
																--(such as from tier set bonusus or anything else that might reduce a cooldown)
local ITEM_NOT_IN_IVENTORY_OR_EQUIPPED = -50000				--arbritrary value to indicate when a sender doesn't have an item

local LOCALIZED_CLASS_NAMES = {}
FillLocalizedClassList(LOCALIZED_CLASS_NAMES)

--Special handling for soulstone
local SPELLID_SOULSTONERESURRECTION = 20707
local SPELLID_SOULSTONERESURRECTION_WHENDEAD = 95750
local ITEMID_SOULSTONE = -5232
local STARTTIME_SOULSTONERESURRECTION = nil

local DEFAULT_SPELLS = {
	{"ANY",			59752,	nil},					-- Every Man for Himself
	{"ANY",			20594,	nil},					-- Stoneform: this is the spell in the spellbook
	--{"ANY",			65116,	nil},				-- Stoneform: this is the buff spell effect
	
	{"DRUID",		22812,	nil},					-- Barkskin
	{"DRUID",		22842,	nil},					-- Frenzied Regeneration
	{"DRUID",		29166,	nil},					-- Innervate
	{"DRUID",		20484,	nil},					-- Rebirth
	{"DRUID",		61336,	nil},					-- Survival Instincts
	{"DRUID",		740,	nil},					-- Tranquility
	{"DRUID",		33891,	nil},					-- Tree of Life
	{"DRUID",		5211,	nil},					-- Mighty Bash
	{"DRUID",		102351,	nil},					-- Cenarion Ward (Talent - 5.0)
	{"DRUID",		102342,	nil},					-- Ironbark (5.0)
	{"DRUID",		124974,	nil},					-- Nature's Vigil
	{"DRUID",		106898,	nil},					-- Stampeding Roar
	
	{"HUNTER",		34477,	nil},					-- Misdirection
	{"HUNTER",		172106,	nil},					-- Aspect of the Fox
	
	{"MAGE",		45438,	nil},					-- Ice Block
	{"MAGE",		31687,	nil},					-- Summon Water Elemental
	{"MAGE",		80353,	nil},					-- Time Warp
	{"MAGE",		2139,	nil},					-- Counterspell
	{"MAGE",		159916,	nil},					-- Amplify Magic
	
	{"MONK",		115176,	nil},					-- Zen Meditation
	{"MONK",		116849,	nil},					-- Life Cocoon
	{"MONK",		115310,	nil},					-- Revival
	                                                   
	{"PALADIN",		31850,	nil},					-- Ardent Defender
	{"PALADIN",		31821,	nil},					-- Devotion Aura
	{"PALADIN",		498,	nil},					-- Divine Protection
	{"PALADIN",		642,	nil},					-- Divine Shield
	{"PALADIN",		1044,	nil},					-- Hand of Freedom
	{"PALADIN",		1022,	nil},					-- Hand of Protection
	{"PALADIN",		6940,	nil},					-- Hand of Sacrifice
	{"PALADIN",		1038,	nil},					-- Hand of Salvation
	{"PALADIN",		114039,	nil},					-- Hand of Purity
	{"PALADIN",		633,	nil},					-- Lay on Hands
	{"PALADIN",		20066,	nil},					-- Repentance
	{"PALADIN",		86659,	nil},					-- Guardian of Ancient Kings
	{"PALADIN",		96231,	nil},					-- Rebuke
	{"PALADIN",		853,	nil},					-- Hammer of Justice
	{"PALADIN",		105593,	nil},					-- Fist of Justice (5.0.4)
	                                                   
	{"PRIEST",		64843,	nil},					-- Divine Hymn
	{"PRIEST",		47788,	nil},					-- Guardian Spirit
	{"PRIEST",		64901,	nil},					-- Hymn of Hope
	{"PRIEST",		33206,	nil},					-- Pain Suppression
	{"PRIEST",		109964,	nil},					-- Spirit Shell (added in 5.0.4)
	{"PRIEST",		73325,	nil},					-- Leap of Faith
	{"PRIEST",		62618,	nil},					-- Power Word:Barrier
	{"PRIEST",		15286,	nil},					-- Vampiric Embrace
	{"PRIEST",		108968,	nil},					-- Void Shift
	{"PRIEST",		108920,	nil},					-- Void Tendrils (5.0.4)
	{"PRIEST",		113277,	nil},					-- Tranquility: Symbiosis (5.0.4)
	                                                   
	{"ROGUE",		2094,	nil},					-- Blind
	{"ROGUE",		31224,	nil},					-- Cloak of Shadows
	{"ROGUE",		57934,	nil},					-- Tricks of the Trade
	{"ROGUE",		1766,	nil},					-- Kick
	{"ROGUE",		114018,	nil},					-- Shroud of Concealment
	{"ROGUE",		76577,	nil},					-- Smoke Bomb
	                                                   
	{"SHAMAN",		2825,	"Horde"},				-- Bloodlust
	{"SHAMAN",		32182,	"Alliance"},			-- Heroism
	{"SHAMAN",		20608,	nil},					-- Reincarnation
	{"SHAMAN",		16190,	nil},					-- Mana Tide Totem
	{"SHAMAN",		98008,	nil},					-- Spirit Link Totem
	{"SHAMAN",		57994,	nil},					-- Wind Shear
	{"SHAMAN",		108280,	nil},					-- Healing Tide Totem
	{"SHAMAN",		5394,	nil},					-- Healing Stream Totem
	{"SHAMAN",		108281,	nil},					-- Ancestral Guidance
	                                                   
	{"WARLOCK",		698,	nil},					-- Ritual of Summoning
	{"WARLOCK",		29893,	nil},					-- Ritual of Souls
	{"WARLOCK",		20707,	nil},					-- Soulstone Resurrection
	                                                   
	{"WARRIOR",		871,	nil},					-- Shield Wall
	{"WARRIOR",		64382,	nil},					-- Shattering Throw
	{"WARRIOR",		12975,	nil},					-- Last Stand
	{"WARRIOR",		97462,	nil},					-- Rallying Cry
	{"WARRIOR",		6552,	nil},					-- Pummel
	{"WARRIOR",		102060,	nil},					-- Disrupting Shout
	{"WARRIOR",		114028,	nil},					-- Mass Spell Reflection
	{"WARRIOR",		114207, nil},					-- Skull Banner
	{"WARRIOR",		114203, nil},					-- Demoralizing Banner
	                                                   
	{"DEATHKNIGHT",	49576,	nil},					-- Death Grip
	{"DEATHKNIGHT",	48792,	nil},					-- Icebound Fortitude
	{"DEATHKNIGHT",	48707,	nil},					-- Anti-Magic Shell
	{"DEATHKNIGHT",	61999,	nil},					-- Raise Ally
	{"DEATHKNIGHT",	42650,	nil},					-- Army of the Dead
	{"DEATHKNIGHT",	49222,	nil},					-- Bone Shield
	{"DEATHKNIGHT",	55233,	nil},					-- Vampiric Blood
	{"DEATHKNIGHT",	46584,	nil},					-- Raise Dead
	{"DEATHKNIGHT",	51052,	nil},					-- Anti-Magic Zone
	{"DEATHKNIGHT",	47528,	nil},					-- Mind Freeze			--new
	{"DEATHKNIGHT",	47476,	nil},					-- Strangulate			--new
	{"DEATHKNIGHT",	49028,	nil},					-- Dancing Rune Weapon
	{"DEATHKNIGHT",	49039,	nil},					-- Lichborne
	{"DEATHKNIGHT",	48743,	nil},					-- Death Pact
}

local DEFAULT_ITEMS = {
	{"ANY",		62471,	"Alliance"},				--Mirror of Broken Images
	{"ANY",		62466,	"Horde"},					--Mirror of Broken Images
}

local EQUIPPABLE_SLOTS = {
	"AmmoSlot",
	"BackSlot",
	"ChestSlot",
	"FeetSlot",
	"Finger0Slot",
	"Finger1Slot",
	"HandsSlot",
	"HeadSlot",
	"LegsSlot",
	"MainHandSlot",
	"NeckSlot",
	"SecondaryHandSlot",
	"ShirtSlot",
	"ShoulderSlot",
	"TabardSlot",
	"Trinket0Slot",
	"Trinket1Slot",
	"WaistSlot",
	"WristSlot",
}

local SHARED_COOLDOWNS = {
	--this table holds cooldowns for abilities that are shared with other abilities such as Last Stand and Rallying Cry.
	--It's only needed for Spell Monitor users so only used with VirtualInstances
	[12975] = 97462,	--Last Stand			-->		Rallying Cry
	[97462] = 12975,	--Rallying Cry			-->		Last Stand
}

local COMBAT_LOGGING_INSTRUCTIONS = L["COMBAT_LOGGING_INSTRUCTIONS"]

local function _tableIndex(tbl, item)
	for index, i in ipairs(tbl) do
		if(i == item) then
			return index
		end
	end

	return nil
end

local function _deleteIndexedTable(tbl, item)
	local index = _tableIndex(tbl, item) 
	if not index then error("failed to locate item in table") end
	tremove(tbl, index)
end

local function _deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

local function _tableCount(tbl)
	local cnt = 0
	for k, v in pairs(tbl) do
		cnt = cnt + 1
	end
	return cnt
end

local function _tableMerge(t1, t2)
	for k,v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				_tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--------------------------------------------------------------------
-- API
--------------------------------------------------------------------
function Hermes:RegisterHermesPlugin(name, OnEnableCallback, OnDisableCallback, OnSetProfileCallback, OnGetBlizzOptionsTable)
	--make sure that plugins table is created
	if not name then
		error("plugin name cannot be nil")
	end
	
	--check to make sure it's not already registered
	if Plugins[name] then
		error("plugin already registered: "..tostring(name))
	end
	
	--update the plugin state in the profile, default is enabled
	if dbp.pluginState[name] == nil then
		dbp.pluginState[name] = true
	end
	
	--register the plugin
	Plugins[name] = {
		OnEnableCallback = OnEnableCallback,
		OnDisableCallback = OnDisableCallback,
		OnSetProfileCallback = OnSetProfileCallback,
		OnGetBlizzOptionsTable = OnGetBlizzOptionsTable,
	}
end

function Hermes:IsSenderAvailable(sender)
	--don't count visibility if sender is also player
	if Player.name ~= sender.name then
		if sender.visible and sender.online == true and sender.dead == false then
			return true
		end
	else
		--if you're here, then you're connected and in range :P
		if sender.dead == false then
			return true
		end
	end
	
	return false
end

function Hermes:GetPlayerStatus()
	return Player.name, Player.class, Player.raid, Player.party, Player.battleground
end

function Hermes:GetAbilityStats(ability)
	local min_available_time = nil
	local instances_total = 0
	local instances_oncooldown = 0
	local instances_available = 0
	local instances_unavailable = 0
	local is_available = 0
	
	for _, instance in ipairs(AbilityInstances) do
		if instance.ability == ability then
			local senderAvailable = Hermes:IsSenderAvailable(instance.sender) --does not take ability being on cooldown into account, just whether they're alive, online, and visible
			
			--set instances_total
			instances_total = instances_total + 1
			
			--instances_unavailable
			if not senderAvailable then
				instances_unavailable = instances_unavailable + 1
			end
			
			--update min_available_time, but only if the sender is available and there is a remaining time
			if senderAvailable and instance.remaining then
				if not min_available_time then
					min_available_time = instance.remaining
				else
					if instance.remaining < min_available_time then
						min_available_time = instance.remaining
					end
				end
			end
			
			if senderAvailable and not instance.remaining then
				instances_available = instances_available + 1
			end
			
			if senderAvailable and instance.remaining then
				instances_oncooldown = instances_oncooldown + 1
			end
			
		end
	end

	return min_available_time, instances_total, instances_oncooldown, instances_available, instances_unavailable
end

function Hermes:UnregisterHermesEvent(event, key)
	--check for valid key
	if not key then
		error("hermes event key cannot be nil")
	end
	
	if Events[event][key] then
		Events[event][key] = nil
	end
end

function Hermes:RegisterHermesEvent(event, key, handler)
	--check for valid key
	if not key then
		error("hermes event key cannot be nil")
	end
	
	--check for valid event
	if not Events[event] then
		error("unknown hermes event: "..tostring(event))
	end
	
	--if nil handler, act like an unregister
	if not handler then
		Hermes:UnregisterHermesEvent(event, key)
		return
	end
	
	--register the event, replaces any other registrations for the given ekey
	Events[event][key] = handler
end

function Hermes:GetClassColorRGB(class)
	local number = tonumber(class)
	if(number) then --they used the enum number
		local classColorRGB
		if(class == 1) then
			classColorRGB = RAID_CLASS_COLORS["PRIEST"] --white
		else
			classColorRGB = RAID_CLASS_COLORS[CLASS_ENUM[class]]
		end
		return classColorRGB
	else --they used the enum value
		local classColorRGB
		if(class == "ANY") then
			classColorRGB = RAID_CLASS_COLORS["PRIEST"] --white
		else
			classColorRGB = RAID_CLASS_COLORS[class]
		end
		return classColorRGB
	end
end

function Hermes:GetClassColorHEX(class)
	local number = tonumber(class)
	if(number) then --they used the enum number
		local classColorRGB
		if(class == 1) then
			classColorRGB = RAID_CLASS_COLORS["PRIEST"] --white
		else
			classColorRGB = RAID_CLASS_COLORS[CLASS_ENUM[class]]
		end
		local classColorHex = format("FF%02x%02x%02x", 
			classColorRGB.r * 255,
			classColorRGB.g * 255,
			classColorRGB.b * 255)
		return classColorHex
	else --they used the enum value
		local classColorRGB
		if(class == "ANY") then
			classColorRGB = RAID_CLASS_COLORS["PRIEST"] --white
		else
			classColorRGB = RAID_CLASS_COLORS[class]
		end
		local classColorHex = format("FF%02x%02x%02x", 
			classColorRGB.r * 255,
			classColorRGB.g * 255,
			classColorRGB.b * 255)
		return classColorHex
	end
end

function Hermes:GetSpecializationNameFromId(id)
	if (id == nil) then return "Nil" end
	for class,specializations in pairs(SPECIALIZATION_IDS) do
		for specializationId, specializationName in pairs(specializations) do
			if (specializationId == id) then return specializationName end
		end
	end
	
	return "Unknown"
end

function Hermes:GetClassColorString(text, class)
	return "|c"..Hermes:GetClassColorHEX(class)..text.."|r"
end

function Hermes:AbilityIdToBlizzId(id)
	if(id >= 0) then
		return id, "spell"
	elseif(id < 0) then
		return abs(id), "item"
	end
end

function Hermes:IsSending()
	return Sender ~= nil
end

function Hermes:IsReceiving()
	return Receiving
end

function Hermes:ReloadBlizzPluginOptions()
	core:BlizOptionsTable_Plugins()
end

function Hermes:GetInventoryList()
	local inventory = {}
	for _, i in ipairs(dbp.spells) do
		inventory[i.id] = i.enabled
	end
	for _, i in ipairs(dbp.items) do
		inventory[i.id] = i.enabled
	end
	
	return inventory
end

function Hermes:GetInventoryDetail(id)
	--prevent hermes lua errors from bad plugins
	if not id then
		return nil
	end
	
	local _, t = self:AbilityIdToBlizzId(id)
	
	if t == "spell" then
		for index, spell in ipairs(dbp.spells) do
			if spell.id == id then
				return spell.id, spell.name, spell.class, spell.icon, spell.enabled
			end
		end
	elseif t == "item" then
		for index, item in ipairs(dbp.items) do
			if item.id == id then
				return item.id, item.name, item.class, item.icon, item.enabled
			end
		end
	else
		error("unknown type")
	end
end

function Hermes:GetAbilityMetaDataValue(id, key)
	if dbg.spellmetadata then
		local metadata = dbg.spellmetadata[id]
		if metadata then
			return metadata[key]
		end
	end
	
	return nil
end

do
--communication
Events["OnStartSending"] = {}
Events["OnStopSending"] = {}
Events["OnStartReceiving"] = {}
Events["OnStopReceiving"] = {}
		
--senders
Events["OnSenderAdded"] = {}
Events["OnSenderRemoved"] = {}
Events["OnSenderVisibilityChanged"] = {}
Events["OnSenderOnlineChanged"] = {}
Events["OnSenderDeadChanged"] = {}
Events["OnSenderAvailabilityChanged"] = {}
		
--player
Events["OnPlayerGroupStatusChanged"] = {}
		
--abilities
Events["OnAbilityAdded"] = {}
Events["OnAbilityRemoved"] = {}
Events["OnAbilityAvailableSendersChanged"] = {}
Events["OnAbilityTotalSendersChanged"] = {}
		
--ability instances
Events["OnAbilityInstanceAdded"] = {}
Events["OnAbilityInstanceRemoved"] = {}
Events["OnAbilityInstanceStartCooldown"] = {}
Events["OnAbilityInstanceUpdateCooldown"] = {}
Events["OnAbilityInstanceStopCooldown"] = {}
Events["OnAbilityInstanceAvailabilityChanged"] = {}

--inventory
Events["OnInventorySpellAdded"] = {}
Events["OnInventoryItemAdded"] = {}
Events["OnInventorySpellRemoved"] = {}
Events["OnInventoryItemRemoved"] = {}
Events["OnInventorySpellChanged"] = {}
Events["OnInventoryItemChanged"] = {}

end
	
--------------------------------------------------------------------
-- HERMES
--------------------------------------------------------------------
local PLAYER_ENTERED_WORLD = nil
function Hermes:PLAYER_ENTERING_WORLD()				--used only for one time player initialization that has to happen after player is logged in.
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	--initialize static properties for player
	core:InitializePlayer()
	
	PLAYER_ENTERED_WORLD = true

	if RegisterAddonMessagePrefix(HERMES_SEND_COMM) == false then
		--register failed for some reason
		local message = L["|cFFFF0000Hermes Warning|r"].." ".."Failed to register addon prefix: "..HERMES_SEND_COMM
		Hermes:Print(message)
	end
		
	if RegisterAddonMessagePrefix(HERMES_RECEIVE_COMM) == false then
		--register failed for some reason
		local message = L["|cFFFF0000Hermes Warning|r"].." ".."Failed to register addon prefix: "..HERMES_RECEIVE_COMM
		Hermes:Print(message)
	end
	
	if(dbp.configMode == true and dbp.enabled == true) then
		--show the warning message, but only if we're not in a part or raid
		if GetNumGroupMembers() == 0 and GetNumSubgroupMembers() == 0 then
			core:ShowHermesTestModeMessage()
			core:StartTestMode()
		else
			dbp.configMode = false
			core:UpdateCommunicationsStatus()
		end
	else
		core:UpdateCommunicationsStatus()
	end
end

function Hermes:GROUP_ROSTER_UPDATE()
	core:UpdateCommunicationsStatus()
end

function Hermes:ACTIVE_TALENT_GROUP_CHANGED()
	--force a hard reboot
	core:Shutdown()
	core:Startup()
end

local REINCARNATION = 20608
function core:OnReincarnationUsed(unit, name, guid)
	--don't process yourself
	if (name == Player.name) then
		return
	end
	
	local dataExists = dbg.durations[REINCARNATION]
	
	if dataExists and dataExists ~= false then
		local player = Players[guid]
		if not player then
			return
		end
		
		local duration = player.spellcache[REINCARNATION]
		if not duration then
			return
		end

		--update the cooldowns table for the player and ability
		core:SetPlayerCooldown(player, REINCARNATION, duration)

		local sender = core:FindSenderByName(name)
		local ability = core:FindTrackedAbilityById(REINCARNATION)
		if sender and sender.virtual and core:CanCreateVirtualInstance(ability) then
			core:AddVirtualInstance(player.name, player.class, REINCARNATION, duration)
		end
	end
end

--There are some spells such as Stoneform that only trigger a SPELL_AURA_APPLIED event.
--And there are some spells such as Every Man for Himself that trigger an a SPELL_AURA_APPLIED followed by a SPELL_CAST_SUCCESS event, or possibly vice vers
--This value is used to remember that we created an instance for SPELL_AURA_APPLIED and to make sure we don't fire an additonal one for a subsequent SPELL_CAST_SUCCESS
--The assumption is that since we're only allowing these two events that we'll over ever get two in a row (maybe three for SPELL_RESURRECT)
-- but once see the first one we fire the virtual instance, and we don't fire any more until we get a different spell id.
local _lastSpell = nil
local _lastPlayer = nil

local function ConvertSpellIdIfSoulstone(spellID)
	if spellID == SPELLID_SOULSTONERESURRECTION or spellID == SPELLID_SOULSTONERESURRECTION_WHENDEAD then
		return SPELLID_SOULSTONERESURRECTION
	else
		return spellID
	end
end

local is42 = tonumber((select(4, GetBuildInfo()))) > 40100
if is42 then
	function Hermes:COMBAT_LOG_EVENT_UNFILTERED(_, _, event, _, sourceGUID, sourceName, _, _, _, _, _, _, spellID, ...)
		core:ProcessCombatLogEvent(event, sourceGUID, sourceName, spellID)
	end
else
	function Hermes:COMBAT_LOG_EVENT_UNFILTERED(_, _, event, _, sourceGUID, sourceName, _, _, _, _, spellID, ...)
		core:ProcessCombatLogEvent(event, sourceGUID, sourceName, spellID)
	end
end

function core:ProcessCombatLogSpell(spellID, sourceGUID, sourceName, shared)
	local dataExists = dbg.durations[spellID]
	
	--this is a spell that we have an autoset value or numerical duration for
	if dataExists and dataExists ~= false then
		--find the player
		local player = Players[sourceGUID]
		
		if player then
			--see if this player qualifies for this spell, and get the duration
			local duration = player.spellcache[spellID]
			if duration then
				--update the cooldowns table for the player and ability
				core:SetPlayerCooldown(player, spellID, duration)

				local sender = core:FindSenderByName(sourceName)
				local ability = core:FindTrackedAbilityById(spellID)
				
				if sender and sender.virtual and core:CanCreateVirtualInstance(ability) then
					--prevent from adding the same spell for the same player more than once
					if _lastSpell ~= spellID or _lastPlayer ~= sourceName then
						core:AddVirtualInstance(player.name, player.class, spellID, duration)
					end
			
					--store the last spell and player captured
					if not shared then
						_lastSpell = spellID
						_lastPlayer = sourceName
					end
				end
			else
				_lastSpell = nil
				_lastPlayer = nil
			end
		else
			_lastSpell = nil
			_lastPlayer = nil
		end
	end
	
	--now process any shared cooldowns as well
	if not shared then
		--look for any shared cooldowns and add that if necessary too
		local sharedId = SHARED_COOLDOWNS[spellID]
		if sharedId then
			core:ProcessCombatLogSpell(sharedId, sourceGUID, sourceName, true)
		end
	end
end

function core:ProcessCombatLogEvent(event, sourceGUID, sourceName, spellID)
	--print(tostring(event)..", "..tostring(sourceGUID)..", "..tostring(sourceName)..", "..tostring(spellID))
	if event ~= "SPELL_RESURRECT" and event ~= "SPELL_CAST_SUCCESS" and event ~= "SPELL_AURA_APPLIED" then
		_lastSpell = nil
		_lastPlayer = nil
		return
	end
	--ignore weird stuff that we don't know can happen or not
	if not sourceName or not spellID or not sourceGUID then
		_lastSpell = nil
		_lastPlayer = nil
		return
	end

	--special case for soulstone tracking on the addon runners end.
	if PLAYER_IS_WARLOCK and sourceName == Player.name and ((spellID == SPELLID_SOULSTONERESURRECTION and event == "SPELL_AURA_APPLIED") or (spellID == SPELLID_SOULSTONERESURRECTION_WHENDEAD and event == "SPELL_RESURRECT")) then
		STARTTIME_SOULSTONERESURRECTION = GetTime() --remember when the spell was cast
	end
	
	--don't process yourself
	if (sourceName == Player.name) then
		_lastSpell = nil
		_lastPlayer = nil
		return
	end
	
	--this function will convert, if necessary, the spell if from 20707 or 95750 to 20707 which is what Hermes uses to track Soulstones.
	--Note that 20707 is the spell that's cast via SPELL_AURA_APPLIED when warlock puts SS on player that is alive.
	--Note that 95750 is the spell that's cast via SPELL_RESURRECT when warlock puts SS on player that is dead (battle res).
	spellID = ConvertSpellIdIfSoulstone(spellID)
	
	self:ProcessCombatLogSpell(spellID, sourceGUID, sourceName)
end

function Hermes:OnEnable()
	core:Startup()
end

function Hermes:OnDisable()
	core:Shutdown()
end

-- Only called once, do all one time init stuff here
function Hermes:OnInitialize()
	--load the absolute bare essentials for options. These merge with options saved already
	core:LoadDefaultOptions()
	
	--create a reference to the profile table
	dbp = self.db.profile
	dbg = self.db.global
	
	self:UpgradeDatabase()
	
	--initialize option tables
	core:LoadBlizOptions()

	self:LoadTalentDatabase() -- Lets front load the talents into the cache

	--if the time is unreliable, then wipe out all cooldowns from db
	if core:SyncServerTimeToClient() then
		core:WipeAllCooldowns()
	end
	
	--create the frame which uses OnUpdate event to manage spell durations and OnUpdate events
	core:InitializeAbilityInstanceFrame()
	
	--setup profile events
	self.db.RegisterCallback(self, "OnNewProfile", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	
	--initialize Reincarnation module
	MOD_Reincarnation = self:GetModule("HermesReincarnation")
	MOD_Reincarnation:SetCallback(function(unit, name, guid) core:OnReincarnationUsed(unit, name, guid) end)
	
	MOD_Talents = self:GetModule("HermesTalents")
	MOD_Talents:SetProfile(dbg)
	MOD_Talents:SetOnRemove(function(guid, unit, name) core:TalentRemove(guid, unit, name) end)
	MOD_Talents:SetOnUpdate(function(guid, unit, info) core:TalentUpdate(guid, unit, info) end)
	MOD_Talents:SetOnClassTalentsUpdated(function(class) core:UpdateSMSClass(class, nil) end)
end

function Hermes:UpgradeDatabase()
	--------------------------
	-- v2.2 to v2.3 changes
	--------------------------
	--add new spellmetadata table
	if not dbg.spellmetadata then
		dbg.spellmetadata = {}
	end

	--convert cooldowns using autoduration, autduration feature has been removed
	for id, duration in pairs(dbg.durations) do
		--autodurations table may have already been removed
		if dbg.autodurations and duration == true and dbg.autodurations[id] then
			dbg.durations[id] = dbg.autodurations[id]
		elseif dbg.autodurations and duration == false or duration == true then
			dbg.durations[id] = nil --test the crap out of this!!!
		end
	end
	--remove the autodurations table
	dbg.autodurations = nil
	--fix the bug in 40200-2 where DG cooldown was wrong
	local paladin = dbg.classes["PALADIN"]
	if paladin then
		if paladin.schema == 40200 and paladin.revision < 3 then
			core:UpdateSMSClass("PALADIN", 1)
		end
	end
end

function Hermes:LoadTalentDatabase(reset)
	if not dbg.classes then dbg.classes = {} end

	local classCount = GetNumClasses()
		
	for classId = 1, classCount do
		local classDisplayName, classTag, classId = GetClassInfo(classId)
		local dbClass = dbg.classes[classTag]
		if not dbClass then 
			dbg.classes[classTag] = { talents = { } }; 
			dbClass = dbg.classes[classTag]; 
		end
		
		local talentCount = 6 -- GetNumTalents(classId)
		local talents = dbClass["talents"]

		if #talents < talentCount or reset == true then
			talents = { }
			talents.schema = Hermes.SPELL_MONITOR_SCHEMA.schema
			talents.revision = Hermes.SPELL_MONITOR_SCHEMA.revision

			for tier = 1, talentCount do
				for talentIndex = 1, 3 do
					for group = 1, GetNumSpecializationsForClassID(classId) do
						local talentId, name, texture, selected, available = GetTalentInfo(talentCount, talentIndex, group, true, null)
						tinsert(dbClass.talents, name)
					end
				end
			end
			
			core:UpdateSMSClass(classTag, false);
		end
	end
end

function Hermes:OnProfileChanged()
	dbp = self.db.profile
	dbg = self.db.global
	
	self:UpgradeDatabase()
	
	MOD_Talents:SetProfile(dbg)
	
	self:Disable()
	
	core:UpdateBlizOptionsTableReferences() --update table references, otherwise they'll be pointing to old tables for the prior profile

	self:Enable()
	
	if dbp.configMode == true then
		core:ShowHermesTestModeMessage()
	end
end

function Hermes:OnReceiverComm(prefix, serialized, channel, sender)
	if(prefix == HERMES_RECEIVE_COMM) then
		--when toggling config mode, it's possible to get stale messages from players after having already set config mode.
		--So if in config mode, make sure that the message if a message from yourself, sent to the whisper channel
		if dbp.configMode  == true and channel ~= "WHISPER" and sender ~= Player.name then
			--ignore the message
			return
		end
		
		local success, msg = self:Deserialize(serialized)
		if(success) then
			local msgEnum = msg[1]
			local msgContent = msg[2]
			local msgName = MESSAGE_ENUM[msgEnum]
			
			if(msgName and msgName == "INITIALIEÌ‹†P  ‹H  ó†8  óXÁóà=“j ‰Eˆ¸   óEÈó†X  ‰M„Q‹@ ÑóMŒóE‰E”‰E˜óMœèÒ¹R ‰EğÇEü    ‹MˆQ‹Èè+ PU„R‰EÜèÀìÿÙ]ÔƒÄƒ¾D   †`
  u† 
  ‹MÜPE°PQ‹ÎèÅêÿÿØEÌÙ]Ü;}äà   Áã‹†P
  UÀRÃPM„Qèz3ìÿ‹†Ğ
  óEÀƒÄóEèƒø‡V  ÿ$…h® WÀë&M°èú*} ØeèØ8=“ëM°èç*} ØeèÙ]ìóEìóXEÈóM°óeÜ‹MäóuÔ‹EóXÈóE´óXÄ(ÙóX]À(ĞóM óE¤óXÖƒù„›   óh/Åwm/èr	/Õ‡ƒ   GƒÃ0óXæóeÜ;ùŒ&ÿÿÿ 
  è»­ëÿP 
  èŸ¶ëÿ‹ğÇEüÿÿÿÿ‹UğE‰UP‹@ ÑèÁ)R ‹Mô_‹Æ^[d‰    ‹å]Â <Áç¾P
   
  èU­ëÿ‹Ï‹ØèL­ëÿ+Ãëó /ÈrF<Áç¾P
   
  è(­ëÿ‹Ï‹Øè­ëÿ+ÃP 
  è¶ëÿ‹ğÇEüÿÿÿÿ‹MğU‰MRémÿÿÿ/Ãr4<Áç¾P
   
  èİ¬ëÿ‹Ï‰Eèã¬ëÿ‹Ø+]‹ÏèÇ¬ëÿÃéÿÿÿjjMĞQPè²ãìÿóE jjUØREÈóEÈóE¤PóEÌèãìÿ‹†P
  óEĞóMÔó\EØó\MÜ<MàÁçQÇPU„RóEàóMäèSìÿ‹P
  ƒÄ, 
  ‰Eßè:¬ëÿ‹Ë‹øè1¬ëÿ+ÇP 
  è#µëÿ‹ğuÇEüÿÿÿÿ‹EğM‰EQé|şÿÿjh¸  hpà{j èUs{ ƒÄjè| I ùŒ® ùŒ® şŒ® ® ÌÌÌÌÌÌÌÌU‹ìd¡    jÿhˆJ^Pd‰%    ì”   V‹ñW¾ 
  ‹Ïè±«ëÿ…Àu¾è
  ‹Ï‰}Øè«ëÿ…À„1  ‹ÎèNŸìÿ‰Eì†è
  ;øu‹  ‹†  ë#ö†\  t‹   ‹†$  ë‹(  ‹†,  ¶}‹–x  ‰MÜÁé¯ÏiÉ SÁé‹ÚÁë¯ËiÉ Áé‰EğˆMÈ„É„¯  Áè¯ÇiÀ ‹¾0  ÁèÁê¯ÂiÀ ÁèˆEó…ÿ~
ƒ¾Ô
  uO‹Eó óğe­(ĞóYl,}óXà=“ó ‹‹˜   M¤Qó\Ê‹Î‰}àóM´ÿÒ‹UìE„PM¤QRèœ0} óMŒó\M„ó8]ƒÄ/Á‡	  óMó\Mˆ/Á‡ö  ‹†P  ‹H  ó†X  óà=“‰…lÿÿÿ‹†\  Áè÷Ğj ‰hÿÿÿó…tÿÿÿó†
  ƒàQ‹@ ÑópÿÿÿÇ…xÿÿÿ   ‰…|ÿÿÿóE€èº´R ‰EìÇEü    ‹lÿÿÿQ‹Èè& ‹Ø•hÿÿÿSR‰]¼è ìÿÙ]¸WÀƒÄö†\  óEĞtóÜ
  ó†Ø
  óMĞƒ¾D   ó8  óXÈóMÌ†`
  u‹EØPE¤PS‹ÎètåÿÿØEĞ‹\  ƒãÙ]äÇE   ;¾T
  ·  Áâ‰Uèë
¤$    ‹Uèƒ¾D   t‹†`  ‹Mà;Èˆ  H;Èu¾
  ë¾è
  9}Øt‹¾P
  úMÀQ•hÿÿÿWRèÒ-ìÿ‹†Ğ
  óEÀƒÄóEÔƒø‡t  ÿ$…,”® WÀë&M¤èR%} ØeÔØ8=“ëM¤è?%} ØeÔÙ]óEóXEÌ(ÈóE¤óXÁóM¨óXMäóE”óXEÀj E„óEœóEÄPM”óXÁQóM˜óE èX.} ƒÄ…À„…   ƒ} tWUÜRh Öµ‹ÎèfæÿÿÇE    ‹œ  óE”‹†\  QU„RSQ‹MÈÁèó…`ÿÿÿóE˜ƒàó…dÿÿÿóE´ó$PEğP‹EìQ‹M¼•`ÿÿÿRWPQ•hÿÿÿRè=ìÿƒÄ0ëÇE   ‹EàóEäƒEè0óXE¸@‰EàóEä;†T
  Œ[şÿÿ¹ ÖµèòëÿÇEüÿÿÿÿ‹EìMQ‹@ Ñ‰Eè•#R [‹Mô_^d‰    ‹å]Â jh¸  hpà{j èn{ ƒÄjèU| ¡’® ¡’® ¦’® ¹’® ÌÌÌÌU‹ìd¡    jÿh¨J^P‹Ed‰%    WÀì”   V‹ñ…Àtó ó@ó@ó@ö†\   „á  ƒÈÿ9†À
  u9†Ä
  „Ê   
  è³¦ëÿ…À„·  ‹x  °UˆEò¶EiÀı ÁèÁé¯ÁiÀ ÁèfÇEğUUˆEó„À„  S‹0  Wº   …Û~ƒ¾Ô
  u+Úö†\  WÉ‰]èóMätó†Ü
  óØ
  óEäó†8  ‹EóXÁóğe­óEàó (ĞóYl,}ó\ÊóMÔóà=“óXÁó ‹H  ‹†P  ó†X  j ‰M¸Q‹@ Ñ‰E¼óMÀóEÄ‰UÈ‰UÌóMĞè}°R ‹ø‰}ÜÇEü    ‹E¼P‹ÏèÆ! PM¸QèlìÿÙ]ØU¸Rè ìÿÙ]ì‹M‹UE¨PQRè|+} ‹†Ô
  óEäƒÄóEƒøt
ƒøtƒøu‹Mèò!} ØeìØ8=“ØEäÙ];T
    [Áã‰]‹¾P
   
  ûèû¤ëÿ‹Ï‹Øèò¤ëÿ+ÃP 
  èä­ëÿ‹Ï‹Øèë¤ëÿP‹ÏèÓ­ëÿ‹À
  Ã;Ù~‹Ë‹–Ä
  +Ë;Â|‹Â+Ã‹]‹Ğ+Ñ…Ò|  •xÿÿÿR•pÿÿÿRU€RP‹†P
  QÃPM¸Qè`ìÿ‹†Ğ
  óE€ƒÄóEƒø‡‘  ÿ$…œ˜® WÀ‹}ë*‹}‹Ïèû } ØeØ8=“ë‹}‹Ïèæ } ØeÙ]óEóXEà(ÈóóX…pÿÿÿóXÁóxÿÿÿóXÈó\pÿÿÿóEˆóGóXEóEŒóXEìóMóM°ó\M¨óE”ó8]/Á‡—   óM´ó\M¬/Á‡„   U˜RE¨PMˆQè½)} ƒÄ…Àtljj•`ÿÿÿRE˜PèÂØìÿ‹œ  óEÔƒÄj QQó$UğR…`ÿÿÿPè> ‹EƒÄ…Àt'óE˜ó óEœó@óE ó@óE¤ó@‹EèóEóXEØ@ƒÃ0‰Eè‰]óE;†T
  Œôıÿÿ‹}ÜÇEüÿÿÿÿMQ‹@ Ñ‰}è&R _[‹Mô^d‰    ‹å]Â jh¸  hpà{j è j{ ƒÄjèæ| ‹ÿó–® ó–® û–® —® ÌÌÌÌU‹ìd¡    jÿhàJ^Pd‰%    ƒìS‹Ùöƒ\  „ù   ‹MEìPQèhÖìÿƒÄUìR‹Ëèšòÿÿj jP‹Ëè.áÿÿƒøÿ„É   V‹u…ö„¦   ‹‹8
  W‹<MØè×Í{ ÇEü   UØR‹ÎèÕ×{ ‹Eä‹Mè‰F‰NÇEüÿÿÿÿMØè
Ö{ ‹WR‹ 
  èë¡ëÿGMàPèÛ{ ÇEü   P‹Îè×{ ÇEüÿÿÿÿMàèÑÕ{ ‹G‰F‹O‹}‰N…ÿt‹Îè—Ë{ Uj R‰Eè‰P ƒÄ‰_^¸   [‹Môd‰    ‹å]Â ‹Mô3À[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìjÿhøJ^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿƒ~r‹PèÜR{ ƒÄ‹MôÇF   ÇF    Æ ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìjÿh0K^d¡    Pd‰%    ƒì$V‹u‹FWPMèèÄÌ{ ÇEü    h(^MèèÀÊ{ ‹=Œˆ{Pÿ×ƒÄ…À„É   h$^MèèŸÊ{ Pÿ×ƒÄ…À„®   h ^Mèè„Ê{ Pÿ×ƒÄ…À„“   h°?MèèiÊ{ Pÿ×ƒÄ…Àt|h¼|MèèRÊ{ Pÿ×ƒÄ…À…‘   ‹E‹MPQMÜè„Ù{ ÆEüUÜjRèuàÿÿƒÄMÜè
Ê{ PNèÊ{ PEĞPè'+P ƒÄÆEü‹ÈèéÉ{ P‹ÎèÁà{ ÆEüMĞèõÓ{ ë$‹M‹UQRMÜè#Ù{ ÆEüMÜè·É{ P‹Îèà{ ÆEü MÜèÃÓ{ ÇEüÿÿÿÿMèè´Ó{ ‹Mô_^d‰    ‹å]ÃÌÌÌÌU‹ìd¡    jÿhHK^Pd‰%    V‹uW‹};÷t$ë
¤$    I ÇEüÿÿÿÿ‹ÎèbÓ{ ƒÆ‰u;÷uè‹Mô_d‰    ^‹å]ÃÌÌÌÌÌÌÌÌ¸0‚® Â ÌÌÌÌÌÌÌÌ¸p‚® Â ÌÌÌÌÌÌÌÌV‹ñF0¹    j‰€  ‰N‰N3Éhÿ   PÇF   ‰N‰N‰N‰N ÇF(   ‰F$è¼O{ ƒÄÇF,ğ`‹Æ^ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhhK^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿƒ~r‹Pè,P{ ƒÄöEÇF   ÇF    Æ t	VèP{ ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌU‹ìjÿh™K^d¡    Pd‰%    ƒìVW3ÿèl„àÿ‹ğ‰uğ;÷t0‰uì‰}ü‹Îè¶É{ ÆEü‰~‰~ÇEüÿÿÿÿ_‹Æ^‹Môd‰    ‹å]Ã‹Mô‹Ç_^d‰    ‹å]ÃÌU‹ìd¡    jÿh¸K^Pd‰%    VW‹ñÇEüÿÿÿÿ‹}‹Ïè³Ñ{ ~,ğ`tjh)  hpà{j èçd{ ƒÄjè­ü{ W‹Îè3àÿ‹F‰W‹Î‰~è•2àÿÿF‹Mô_d‰    ^‹å]Â ¡Ä+ÕV‹°¬	  ‹L  èé6àÿ‹L  j Qè«M{ ƒÄÇ†L      ^ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìS‹]V‹ñó†
  .à=“ŸW‹}öÄDzWSèÃÃìÿö†\   t-‹Îè£ìÿ‰E‹‹˜   MğQ‹ÎÿÒ‹Mj EğPQWS‹ÎèõÿÿWS‹ÎèÔğÿÿ_^[‹å]Â ÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹ñö†\  Wt1‹†À
  ;†Ä
  u#‹}Wè™ ìÿ…Àt‹M‹UQRW‹Îèµùÿÿ_^]Â _3À^]Â ÌÌÌÌÌÌÌU‹ìd¡    jÿhğK^Pd‰%    ì$  V‹ñö†\  0u3À^‹Môd‰    ‹å]Â S^ èºoàÿ‹PH‹ QRPĞıÿÿè4Ğãÿ‹…Ğıÿÿ‹Ôıÿÿ;à*­u;ä*­„à   ;…Ø   ;K…Ï   W‹}MìQƒÇWè¢ÏìÿƒÄö†\  tYMØè>Ç{ ÇEü   UREØPW‹Îèçşÿÿ…Àt'ÇEüÿÿÿÿMØètÏ{ _[¸   ^‹Môd‰    ‹å]Â ÇEüÿÿÿÿMØèMÏ{ ö†\   t;MìQ‹Îèiëÿÿ‹øƒÈÿ;øt¼S‰†À
  ‰†Ä
  èîáÿƒÄÇ†È
     ‰¾Ì
  ë•_[3À^‹Môd‰    ‹å]Â ‹Mô[3À^d‰    ‹å]Â S‹Ù‹CV4@W‹;Áæ÷;şt‹ÏèÃ¾ëÿƒÇ0;şuò‹Pè| ƒÄ_^[ÃÌÌÌÌÌÌÌÌÌÌÌÌÌS‹Ù‹CV4@W‹;Áæ÷;şt‹Ïèƒ¾ëÿƒÇ0;şuò_^ÇC    [ÃÌU‹ì‹UV‹ñ‹N;ÑvU‹ÁÑèÁ;ÂBÂ‰F€ÀÀWPè„| ‹MQ‹N‹ø‹‰WQPèËßÿÿ‹N‹‰QPèyúÿÿ‹Rèq| ƒÄ ‰>_^]Â ÌÌÌÌÌÌU‹ìVj‹ñèP{ HƒÄÇ     Ç@   …Ét‹UW‹:‰9‹R‰Q_‰Ç 0‚® ‹Ç@ğm® ‹Æ^]Â ÌÌÌÌÌU‹ìjÿh!L^d¡    Pd‰%    ƒìSVW‹Ù3ÿ‰}ü‹KèÃàÿ‹ğ‰uğ…öt‰uìÆEü‹ÎèÅ{ ÆEü3À‰F‰FˆEü‹şEP‹Ïè Ï{ ÿCÇEüÿÿÿÿMè>Í{ ‹Mô‹Ç_^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh8L^Pd‰%    V‹qƒÈÿAW‰Eü‹}‹ÏèğÌ{ ~,ğ`tjh)  hpà{j è$`{ ƒÄjèê÷{ W‹ÎèB.àÿ‹F‰W‹Î‰~èÒ-àÿÿF‹Mô_d‰    ^‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhXL^Pd‰%    VÇEüÿÿÿÿ‹uƒ~r‹PèÿI{ ƒÄ‹MôÇF   ÇF    Æ d‰    ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌéK1àÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh¾L^d¡    Pd‰%    QSV‹ñW‰uğÇ0^ÇEü   ƒ¾@  (‹Ä+Õ‹’¬	  ‹†<  ‹ºL  P‹ÏèÉ.àÿÿOëj Pè,H{ ƒÄÿO$3À‰†<  ‰†@  ÆEüè
  è™»ëÿÆEü
  èŠ»ëÿÆEü`
  è{»ëÿÆEü‹¾T
  ‹P
  <Áçû;ßt‹ËèX»ëÿƒÃ0;ßuò‹†P
  Pè¥| ƒÄÆEü  
  è3»ëÿÇEüÿÿÿÿ‹ÎèUuìÿ‹Mô_^[d‰    ‹å]ÃÌÌÌÌÂ ÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌöAtö\   t¸   Ã3ÀÃÌÌÌÌÌÌÌÌU‹ìƒìV‹ñöFu%¡ä*­‹à*­‹uhè*­PQ‹ÎèåÊãÿ‹Æ^‹å]Â S‹]W3ÿö†\   tS¿   è¡šìÿ…Àt‹F$‹N V(RPQëo‹Eøö†\  tP…ÿuS‹Îèwšìÿ…Àt@ö†\  t7UøRSè0ÊìÿƒÄEøP‹Îèbæÿÿj jP‹ÎèöÔÿÿƒøÿt‹V$‹F N(QRPë‹ä*­‹à*­hè*­QR‹u‹Îè6Êãÿ_[‹Æ^‹å]Â ÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhèL^d¡    Pd‰%    ƒìtSV‹Ù‹³T
  ƒP
  4vW‹8Áæ÷‰EÌ;ştI ‹Ïè™¹ëÿƒÇ0;şuò‹EÌ3ÿ‰x9»@  „À  ‹‹\  Ñé¾   #ÎuP‹ 
  èØëÿ_^[‹Môd‰    ‹å]Ã‹ËèÉ·ÿÿ‹“<  WPRM€èH®ëÿ‰}üP‹ 
  èY¸ëÿÇEüÿÿÿÿM€è¹ëÿöƒ\  t‰³4
  ‹ 
  è •ëÿ…À„:  ƒ»Ğ
  ÇEä   uè“l{ ƒø
u‰uä‹EäPM¼èßÃ} ‰uü‹ƒ 
  PM°èMÍ{ ÆEü‹ƒ\  ¨t©    t‹Æë3ÀPM°VQè7ÂÿÿƒÄM°è|¾{ PM¼è“À} ‰uè‹³<  €> ÇEì    „‚  ƒ}è ‹Eìt‹ÎèÚ²ÿÿ‰Eì3À‰EèUÄRMàQPV‹ËèqËÿÿ‹EàŠ0„É„K  €ù
ut0ÇEè   é-  €ù us+³<  jÆj
P‹ 
  ‰EØè®ÏëÿP‹ 
  ‰EĞèŸëÿ‹UĞ‹ğVR‹ 
  è½°ëÿ‹EìF…ÀtVP‹EØP‹ 
  è„ĞëÿP‹ 
  è˜°ëÿ‹‹<  ‹UØtéµ  ƒ}ätèKk{ ƒø‹EàÇEØ    uÇEØ   +³<  ÇEÜÿÿÿÿ‹Î4EÜPVQ‰MÔMğQM°‰uĞèK½{ PU¼R‹ 
  èÛ¥ëÿ…À„•   I ‹UØ‹Eğ…Òt…À~‹‹<  ŠLÿ€ù"t€ù(uH‰Eğ‹‹<  È‰MÈpÿ…Ò„½   UÈRèûGÒÿƒÀßƒÄƒø‡¢   ¶€¼©® ÿ$…´©® ‹UÔMÜQVREğPM°è¹¼{ PM¼Q‹ 
  èI¥ëÿ…À…qÿÿÿ‹uĞ‹Æ‰Eğ‹“<  3É€< ”ÁQj
P‹ 
  è;Îëÿ‹È‹EÜ‰MĞƒøÿtA‹“8
  p‹‚ƒ8	u>‹EğVj j-P‹ 
  è	ÎëÿP‹ 
  è-¯ëÿFë‹Eğ;EÔu™‹EĞë‘Q‹ 
  èáœëÿ‹ğ‹MĞVQ‹ 
  èÿ®ëÿ‹EìF…Àt‹UğVPR‹ 
  èÆÎëÿP‹ 
  èÚ®ëÿ‹³<  uğ€> …~ıÿÿ‹EÌP‹ 
  èyÔëÿÆEüM°èÍÅ{ ÇEüÿÿÿÿM¼è¾½} ‹Mô_^[d‰    ‹å]Ã‚¨® ©®           ÌÌÌÌÌU‹ìƒì<V‹ñ÷†\     „ä   ‹‹˜   SWMàQ‹ÎÿÒMàèí} Ù]øMàèò} Ù]ü‹†L  ¿	   ‰†P  _øë	¤$    ‹ÿ‹H  óà=“‹–P  óX  EğP† 
  ‰MÄPMÄQ‰UÈóEÌóMĞ‰]Ô‰]ØóEÜèÅìÿóEğƒÄ/EøwóEô/Eüv7‹L  ¯Ï¸gfff÷éÁú‹ÂÁèÂ;Ã‹Ã‹Î‰†P  è¯úÿÿ+û…ÿeÿÿÿ_[^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhM^d¡    Pd‰%    ƒì,Sè_$ëÿ‹X‹MfWÀEÈfEĞfWÀPfEØèº{ PèèP ƒÄ…À„á   MàQ‹Ëè‚é ‹UĞ;u>‹MÔ;Hu6‹UØ;Pu.‹MÜ;Hu&j j è
ûÿUÈjRè_	ûÿƒÄ[‹Môd‰    ‹å]ÃV‹uÈW‹}ÌjèŞE{ HƒÄÇ     Ç@   …Ét‰1‰y‰EğÇ 0‚® ‹EğÇ@ğm® ÇEü    ‹K‹‹RdEğPEĞPÿÒÇEüÿÿÿÿ‹Eğ…Àt*Hè °Óÿ…Àu‹Eğ‹PHQ‹ğÿÒVèA{ ƒÄÇEğ    _^‹Mô[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìS‹]V‹ñ‹Ë+¸gfff÷é‹FÁúW‹úÁïú9Fu	@P‹Îèôÿÿ‹F‹€;ø‹E‘Ps¿QRèßÓÿÿƒÄÿF_^[]Â SRèËÓÿÿƒÄÿF_^[]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhIM^d¡    Pd‰%    ƒìSVW‹ù3ö‰uüEPMàèOº{ ÆEü‹Oè£tàÿ‹Ø‰]ğ…Ût ‰]ìÆEü‹Ëèì¹{ ÆEü3À‰C‰CÆEü‹óMàQ‹ÎèßÃ{ ÿGÆEü Màè Â{ 3É‰N‰N‹;Át
‰p‹‰Vë‰w‰7ÇEüÿÿÿÿMèôÁ{ ‹Mô_‹Æ^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhhM^d¡    Pd‰%    Q‹VW‹ø‹@‰}ğ‰…Àu‰AëÇ@    ‹qƒÈÿA‰Eü‹Ïè†Á{ ~,ğ`tjh)  hpà{j èºT{ ƒÄjè€ì{ W‹ÎèØ"àÿ‹F‰W‹Î‰~èh"àÿÿF‹Mô_^d‰    ‹å]ÃÌÌÌÌÌU‹ìjÿhˆM^d¡    Pd‰%    Q‹EV‹ñjÿj ÇF   ÇF    P‰uğÆ èãäÖÿÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌ¸Ğ¢® Â ÌÌÌÌÌÌÌÌU‹ìjÿh¨M^d¡    Pd‰%    QW‹ù3É9O„¼   SVëëI 3É‹‹C‰]ğ‰;Áu‰Oë‰H‹wƒÈÿG‰Eü‹ËèeÀ{ ~,ğ`…Š   S‹Îè`àÿ…À„—   ‹Ã+3Ò÷vº   ‹ÈƒáÓâ‹N$ÁèŠ„Ğu~‹N‰S‹Î‰^è&àÿ…Àts3Ò‹Ã+÷v‹Ğƒà‹È‹F$ÁêÂ²ÒâŠÊöÑ"
ÊˆÿFƒ …Oÿÿÿ^[‹Mô_d‰    ‹å]Ãjh)  hpà{j èS{ ƒÄjèÑê{ jhÓ  ëájhØ  ëØjh³  ëÏÌÌÌÌÌÌé«$àÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhÈM^d¡    Pd‰%    Q‹EV‹ñjÿj ÇF   ÇF    P‰uğÆ è3ãÖÿÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìV‹ñèõòÿÿöEt	Vè©<{ ƒÄ‹Æ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒì4V‹ñƒ¾T   „˜   ‹†L  ‹‹’˜   ƒ¦\  ı‰†P  EèPÿÒ‹†H  ‹P  óà=“óX  ‰EÌ¸   Uø‰EÜ‰EàR† 
  ‰MĞPMÌQóEÔóMØóEäèYìÿƒÄMèèş} ÙEøßñİØv‹–T  ƒ\  ‰–P  ‹Îè[ôÿÿ‹Îè´øÿÿ÷†\     t$‹‹    MøQ‹ÎÿÒ‹‹@tMøQ–Ì  R‹ÎÿĞ‹ÎèÓÿÿ^‹å]ÃÌÌÌÌÌÌÌÌU‹ìd¡    jÿhèM^Pd‰%    ƒì4V‹ñ‹†<  …Àt5‹MëI Š:u„ÒtŠP:QuƒÀƒÁ„Òuä3ÀëÀƒØÿ…À„ú  ‹EPŠ@„Éuù+ÂSXW‰]ğ‹ûƒû¿   ‹†@  …ÀuWè0ÑÿÿƒÄë;Ç}WP‹†<  PèÉÑÿÿƒÄ‰¾@  ‰†<  ‹†@  ‹M‹–<  PQRèó2ÒÿƒÄ¿   ƒû~%èÁ`{ ƒø	uh:  èòS ƒÄ9†H  u	¾\  …¾\  t{‹†<  SPè<c{ ƒÄƒû~f3ÿ…Û~`‹<  jÏhÔ^Qÿˆˆ{ƒÄ…Àu>‹–<  Dj}Pÿ„ˆ{ƒÄ…Àt$‹<  +Á+Ç‹Ø‹ESRÏQè9{ ƒÄû‹]ğG;û| ‹†\  Áèƒà÷ØÀƒà‹ø‹‹P@j‹ÎÿÒ…Àu‹‹P@j‹ÎÿÒ…ÀuƒÏö†\  tƒÏ‹†<  j WPMÀè*¡ëÿÇEü    P 
  è7«ëÿÇEüÿÿÿÿMÀèø«ëÿö†\  t
Ç†4
     ‹Îèîüÿÿ‹}‹‹E‹’œ   WP‹ÎÿÒ…ÿ_[u+ƒÆ Vèäàÿ‹ƒÄ‹È‹B@jÿĞ…ÀtVèãçàÿƒÄ‹Èèùû ‹Mô^d‰    ‹å]Â ÌÌÌÌÌÌÌÌU‹ì‹\  ‹UV‹ğÑîƒæ;Ö^t$…ÒtƒÈ‰\  èuñÿÿ]Â ƒàı‰\  ècñÿÿ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh`N^Pd‰%    ‹T
  ‹Uƒì4H…Òy3Àë;Ğ‹ÂW<@Áç¹P
  3À3É‰}è‰Mğ‰Eì9G†<  S‹]VëI ‹O‹4ƒ>…  MÀèY²{ ÇEü   ‹V‰UÌ‹F‰EĞ‹NQ‹Ïè‹†ëÿFMÔPèÀ{ ÆEüPMÀè2¼{ ÆEüMÔèvº{ MÀ+¸gfff÷é‹CÁú‹òÁîò9Cu	@P‹Ëèßëÿÿ‹C‹€<‘‰}ÆE ;ğs5¶4M‰Mä‰}àÆEü…ÿtNV‹Ïèú±{ ÆEü‹V‰W‹F‰GÆEüë0M‰Mà‰}äÆEü…ÿtUÀR‹ÏèÈ±{ ÆEü‹EÌ‰G‹MĞ‰OÆEüÆEü¸   CEğÇEüÿÿÿÿMÀè¶¹{ ‹Eì‹}è@‰Eì;G‚Óşÿÿ‹Eğ^[‹Mô_d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒì‹UV‹ñ‹†Ô  ‹Ø  ‰Eø‹ER‰MüP‹ÎèVtìÿóUøó\–Ô  ó ˆ|ó8]TĞ/ÑwóUüó\–Ø  TĞ/Ñv‹Îè%úÿÿ^‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh€N^d¡    Pd‰%    QV‹ñÇEü    ƒìE‹Ì‰eğPè¬°{ ÆEüÆEü ‹Îèöÿÿ‹ğÇEüÿÿÿÿMè¬¸{ ‹Mô‹Æd‰    ^‹å]Â ÌÌÌÌÌÌÌÌÌé»öÿÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh±N^d¡    Pd‰%    Q‹EVÇEğ    ‹ujÿj ÇF   ÇF    P‹ÎÆ è,ÜÖÿÇEü    ‹MôÇEğ   ‹Æ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhËN^d¡    Pd‰%    QSVW‹ùw3Û‰‰_‰_‰_F0j‰€  ¹    hÿ   P‰}ğ‰N‰NÇF   ‰^‰^‰^‰^ ÇF(   ‰F$è€4{ ƒÄÇF,ğ`‰]ü‰wÇEüÿÿÿÿ‹Mô‹Ç_^[d‰    ‹å]ÃÌÌÌÌÌÌU‹ìjÿhëN^d¡    Pd‰%    QV‹ñ‰uğÇEü    è…öÿÿÇEüÿÿÿÿNèVàÿ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌU‹ìjÿhO^d¡    Pd‰%    ƒìVj(è9{ ‹ğNƒÄÇ    ÇF   ‰uğ‰MìÇEü    …Ét"‹Ejÿj ÇA   ÇA    PÆ è©ÚÖÿÆEü ÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh8O^Pd‰%    ƒìS3ÛV‹ñ‰\  ‰<  ‰@  ‰D  W‹}‹‡¬	  ‹¨	  ‰Ğ
  ‰†Ô
  ‹‡¸	  ‰†   ‹À	  ‰$  ‹—¼	  ‰–(  ‹‡Ä	  ‰†,  ‹È	  ‰H  ‹‡Ì	  ‰†L  ‰†P  9Ÿà	  tƒ\  9Ÿä	  t
\      ‹—ô	  ‰–`  9Ÿ´	  t\     ë
¦\  ÿşÿÿÙ‡°	  ÙX  9Ÿì	  t	ƒ\   ëƒ¦\  ß9Ÿğ	  t\  €   ë
¦\  ÿÿÿ‹‡Ğ	  ‰†T  ‹†\  9ŸĞ	  t¨tZƒàı‹Î‰†\  èRëÿÿëH‹Ô	  ‹ĞÑêƒâ;Êt;ËtƒÈëƒàı‹Î‰†\  è&ëÿÿ9ŸØ	  t\     ë
¦\  ÿıÿÿ‹‡Ü	  ƒøtƒøt¦\  ÿûÿÿë
\     ƒøtƒøt¦\  ÿ÷ÿÿë
\     9Ÿè	  t	ƒ\  ëƒ¦\  û‹‹”   j‹ÎÿÒWÀ‰0  Ù‡ø	  ÙØ
   
  Ù‡ü	  ÙÜ
  ó†4  ó†8  Ù‡
  Ùà
  Ù‡
  Ùä
  Ù‡
  Ùd  Ù‡
  Ùh  Ù‡
  Ùl  Ù‡ 
  Ùp  èØ©{ PEèPèîåR ƒÄ‰]ü‹>j‹Èè½©{ ‹—   P‹ÎÿÒƒÏÿ‰}üMèèÄ³{ ‹Mô‰¾À
  ‰¾Ä
  ‰¾Ì
  ‰È
  _^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìjÿhO^d¡    Pd‰%    Q‹ESVW‹}‹ñ‹MPQW‹Î‰uğèü‚ìÿ3Û‰]ü 
  Ç0^èÖ—ëÿÆEü‰P
  ‰T
  ‰X
  ÆEü`
  è±—ëÿÆEü
  è¢—ëÿÆEüè
  è“—ëÿÆEüW‹ÎègüÿÿÇEüÿÿÿÿ‹Mô_‹Æ^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhşO^d¡    Pd‰%    Q‹ESVW‹}P‹ñW‰uğèâ©ìÿ3Û‰]ü 
  Ç0^è—ëÿÆEü‰P
  ‰T
  ‰X
  ÆEü`
  è÷–ëÿÆEü
  èè–ëÿÆEüè
  èÙ–ëÿÆEüW‹Îè­ûÿÿÇEüÿÿÿÿ‹Mô_‹Æ^[d‰    ‹å]Â ÌU‹ìjÿh(P^d¡    Pd‰%    ƒì‹ESVWPMäè†¶{ ÇEü    hä^MäèÒ§{ ‹5Œˆ{PÿÖƒÄ…Àu‹Mhê{è…¾{ ëSh¼|Mäè¦§{ PÿÖƒÄ…Àu<‹]3ö93t3‹Ã‹‹xhÜ^QÿŒˆ{ƒÄ…Àu‹MWƒÁèÌ»{ ƒÆƒ<³ ³uĞMäQMØèD©{ ³ˆ]üƒìUØ‹Ì‰eğRè.©{ ÆEü‹MƒÁˆ]üèœîÿÿÆEü MØè0±{ ÇEüÿÿÿÿMäè!±{ ‹Mô_^d‰    [‹å]ÃU‹ìjÿhHP^d¡    Pd‰%    ƒìVW‹}‹GPMèèÄ¨{ ÇEü    Oèïÿÿh(^Mèè¸¦{ ‹5Œˆ{PÿÖƒÄ…ÀtEh$^Mèè›¦{ PÿÖƒÄ…Àt.h ^Mèè„¦{ PÿÖƒÄ…Àth°?Mèèm¦{ PÿÖƒÄ…Àuhê{‹Ïè'½{ ÇEüÿÿÿÿMèèX°{ ‹Mô_^d‰    ‹å]ÃÌÌÌÌÌÌÌÌU‹ìjÿhsP^d¡    Pd‰%    QSVW‹ùw3Û‰‰_‰_‰_F0j‰€  ¹    hÿ   P‰}ğ‰N‰NÇF   ‰^‰^‰^‰^ ÇF(   ‰F$è°,{ ƒÄÇF,ğ`‰]ü‰wÇEüÿÿÿÿ‹Mô‹Ç_^[d‰    ‹å]ÃÌÌÌÌÌÌU‹ìjÿh“P^d¡    Pd‰%    QV‹ñ‰uğÇEü   èµîÿÿÇEüÿÿÿÿNè†àÿ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌU‹ì‹EVP‹ñè!øÿÿ‰Ç p‚® ‹‹ÆÇAĞ¢® ^]Â ÌÌÌÌÌÌÌÌÌU‹ìjÿhçP^d¡    Pd‰%    ìÄ   V‹ufWÀEäfEäfWÀP‹ÎfEìèÑ¤{ PèP ƒÄ…À„Ù  WèÚëÿ‹xMĞQ‹Ï‰}àè)Ô ‹Uä;u‹Mè;Hu‹Uì;Pu‹Mğ;H„  h Çè¬›àÿƒÄ…À„‰  S3ÛSjJèFâÿƒÄ…À„ë   ‹ÎèT¤{ PMè›×ÿ‰]üURE¬PèËõÿÿ‹øÆEüj(è^0{ ‹ğNƒÄ‰ÇF   ‰uÈ‰MÌÆEü;ËtjÿSÇA   ‰YWˆèúÑÖÿÆEüÆEü‰uÇp‚® ‹MÇAĞ¢® ÆEü‹Uà‹Jó~EäfÖEĞó~EìURfÖEØ‹‹@dUĞRÿĞÆEüMèvgçÿˆ]üƒ}Àr‹M¬QèD+{ ƒÄÇEÀ   ‰]¼ˆ]¬ÇEüÿÿÿÿMèå¡Öÿé‡   ‹œ   ;Ëtè¡ëÿ…Àt¾   ë3ö‹OUäRèØHæÿ;ót;ÃtWh Çè†×àÿS‹ğSEäP0ÿÿÿQèÂÔèÿƒÄÇEü   •0ÿÿÿR‹Îè:üÿjhpà{èD ƒÄÇEüÿÿÿÿ0ÿÿÿèi”äÿ[_‹Mô3À^d‰    ‹å]Â ÌÌÌÌU‹ìjÿh1Q^d¡    Pd‰%    ƒìSV‹ÙW‰]ğèX¤{ 3ö‰uüKèK¤{ ÆEü‰s‰s‰s ‰s${wF0¹    j‰€  ‰N‰N3Éhÿ   P‰}ìÇF   ‰N‰N‰N‰N ÇF(   ‰F$è1){ ƒÄÇF,ğ`ÆEü‰wÇEüÿÿÿÿ‹Mô_^‹Ã[d‰    ‹å]ÃÌÌÌÌÌÌU‹ìjÿhqQ^d¡    Pd‰%    ƒìV‹ñW‰uğÇEü   ~‰}ìÆEü‹Ïè&ëÿÿÆEüOèúàÿÆEü NèÎ«{ ÇEüÿÿÿÿ‹ÎèÀ«{ ‹Mô_^d‰    ‹å]ÃU‹ìd¡    jÿhàQ^Pd‰%    ‹E‹ ƒì HSVW‹}‹ñt)ƒèuè‹ìÿÿ‹MWQ‹ÎèÏŸìÿ‹Môd‰    _^[‹å]Â ‹ƒÀşƒøw×¶ˆÇ® ÿ$ìÆ® j èíıÿ‹ƒÄƒÿ-t	ƒÿ…  …À„•  ‹ÎèŠºÿÿ¸   ‹Môd‰    _^[‹å]Â ƒ¾È
   „i  UìRƒÇWèØªìÿƒÄEìP‹Îè
Çÿÿ‹Ì
  PQ‹ÎèË¸ÿÿ¸   ‹Môd‰    _^[‹å]Â W‹Îè[Úÿÿ…À„  ‹Môd‰    _^[‹å]Â ö†\  „ÿÿÿUìR_SèfªìÿƒÄMÔè¢{ ÇEü   EPMÔQS‹ÎÇE    è­Ùÿÿ…Àt-ƒ}u'ÇEüÿÿÿÿMÔè4ª{ ¸   ‹Môd‰    _^[‹å]Â ÇEüÿÿÿÿMÔèª{ éşÿÿMÔ3Ûè¡{ ÇEü   UREÔPOQ‹Î‰]èAÙÿÿ…À„¶   ‹EƒøuUÔR¹ˆf­èó™ïÿ»   é–   ƒøuEÔPè;åÿÿƒÄ»   ë~ƒøuWMÔQ‹Îèpúÿÿ…Àti»   ëbƒøu]Mèè¡{ ÆEüUèRMÔèHŸ{ PèP ƒÄ…Àt,Q‹Ä‰eÇ     ÆEüjMèè!Ÿ{ PÆEüèçğÿƒÄ»   ÆEüMèè#©{ ƒ¾È
   thà*­Ç†È
      èÖåàÿƒÄ»   ÇEüÿÿÿÿMÔèï¨{ ‹Ã‹Môd‰    _^[‹å]Â MÔèr { ÇEü
   EPMÔQWR‹ÎÇE    èØÿÿ…Àtƒ}uWEÔP‹ÎèÛ£ÿÿÇEüÿÿÿÿMÔèŒ¨{ ‹Mô_^3Àd‰    [‹å]Â I Ä® ^Ä® ­Ä® XÅ® ĞÄ® †Æ® åÃ®  ÌÌÌÌÌÌÌÌU‹ìjÿhHR^d¡    Pd‰%    ìä  VWıÿÿÇEğ    è.ûÿÿÇEü   j è ¾ ‹ğ…ıÿÿPVèa8 hP¾® h@½® Vè¡8 hPš® VèÖ8 ‹}‹ÇƒÄ PŠ@„Éuùj+ÂPWVè˜g ƒÄ…ÀuWıÿÿèõ±{ Vèe ‹uƒÄıÿÿQ‹ÎèkŸ{ ÇEğ   ÇEü   •(ıÿÿ‰UìÆEü‹Êè©æÿÿÆEü8ıÿÿèzàÿÆEüıÿÿèK§{ ÆEü ıÿÿè<§{ ‹Mô‹Æ_^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ìQ‹EPè=| ƒÄ‰EüÛEü…ÀyØ˜=“Øø^‹å]ÃÌÌÌÌÌÌU‹ì‹E‹°tÖj Pè¬}R ]ÃÌÌÌÌÌÌÌÌÌÌU‹ì‹°tÖEPèîîQ ]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹øÅÜj Pèl}R ]ÃÌÌÌÌÌÌÌÌÌÌU‹ì‹øÅÜEPè®îQ ]ÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìóE‹Á‹MÙÙÙAÙXÙAó@ÙX]Â ÌÌÌÌÌÌÌÌÌÌU‹ì‹EÙAó‡|ÙXóóIóQWÃWËWÓó óHóP]Â ÌÌÌU‹ìƒì‹EóQóIó@óYó(óE(áóY`(úóYøó\ç(ÅóYÃóXàó(øóYxóYêó\ïó8óYù(óóYuóXî(ğóYuó\÷(ûóYxóX÷óuøóuóYñ(øóY8óXşó}óu(úóYxóX÷óuü‹E(ñóYuø(úóYıó\÷(øóY}üóX÷(ûóYüóX÷óuä(òóYUüóYôóuó}(ğóYuøó\şó}óu(ùóY}üóYÅóYÌó\ÁóIóXMäóX÷(ûóY]øóYıóXÂóX÷óXÃóóIóXÎóHóIóXÈóH‹å]Â ÌÌÌÌÌÌÌÌÌÌU‹ì‹Eó óHó\Ió\óPó\QóYóYÉóYÀóXÈóYÒóXÊóYÛ/Ùr	¸   ]Â 3À]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EÙ ÙÙ@ÙYÙ@‹EÙYÙ ÙYÙ@ÙYÙ@ÙYóIóQóY(ÂóYÂ(áóYáóXÄ(ãóYãóXÄóQàóğ^/Äs'óà=“ó^ÄóYĞóYÈóYØóQóIóY]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹ğÊÜj Pè,zR ]ÃÌÌÌÌÌÌÌÌÌÌU‹ì‹ğÊÜEPènëQ ]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙA ÙX ]Â U‹ìƒìó%‡|óä«¯óè«¯óì«¯WÄV‹uó^0óX0}ón(óv,WÌWÔó]ì(ØóYØ(áóYáóXÜ(âóYâóXÜóQãóğ^/ÜómäóuèóEğóMôóUøs-óà=“ó^Ü(ãóYà(ÃóYÁóYÚóeğóEôó]øEPMüQVREäPè˜ü} ƒÄ…Àu^‹å]Ã‹M‹UóE‹EQ‹N`R‹V\ƒìóD$óEüó$P‹FXQ‹NPRPj Qè‘OãÿƒÄ(¸   ^‹å]ÃÌÌÌÌ¡Ä+Õ…Àt‹€¸	  ‹HQèÈ=	 YÃÌÌÌÌÌÌU‹ì]éG„ ÌÌÌÌÌÌÌU‹ì¡Ä+Õ…Àt‹€¸	  …Àt‹M‰H]ÃÌÌèKëÿ‹@8ÃÌÌÌÌÌÌÌU‹ì‹EPè”Wi ‹MƒÄ‰H(]ÃÌÌÌÌÌÌÌÌÌ¡Ä+Õ‹€¸	  ÃÌÌÌÌU‹ì‹Á‹M‹‰‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q ‰P ‹Q$‰P$‹Q(‰P(‹Q,‰P,ó~A0fÖ@0ó~A8fÖ@8ó~A@fÖ@@ó~AHfÖ@H‹QP‰PPÙATÙXTÙAXÙXXÙA\ÙX\ÙA`ÙX`ÙAdÙXd]Â ÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙX]Â ÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙX]Â ÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EiÀ$  ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì·EkÀh  ]Â ÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹Au¸   Ã3ÀÃ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹Au¸   Ã3ÀÃ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EVj ‹ñ‹°tÖPèyuR ‰‹Æ^]Â U‹ìQ‹MüQ‹°tÖ‰Eüè¸æQ ‹å]ÃÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EVj ‹ñ‹øÅÜPè)uR ‰‹Æ^]Â U‹ìQ‹MüQ‹øÅÜ‰EüèhæQ ‹å]ÃÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹Á¹ÿÿ  f‰Ç@    ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EVj ‹ñ‹ğÊÜPè©tR ‰‹Æ^]Â U‹ìQ‹MüQ‹ğÊÜ‰EüèèåQ ‹å]ÃÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ3À‰‰A‰AÃÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EPèÔÔ{ ƒÄ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EiÀ$  PèÔ{ ƒÄ]Â ÌÌÌÌÌÌÌU‹ì‹Uƒúÿu3À]Â ·Â;   sïiÀ    3É9•ÁI#Á]Â ÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹M‹‰‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q ‰P ‹Q$‰P$‹Q(‰P(‹Q,‰P,ó~A0fÖ@0ó~A8fÖ@8ó~A@fÖ@@ó~AHfÖ@H‹QP‰PPÙATÙXTÙAXÙXXÙA\ÙX\ÙA`ÙX`ÙAdÙXd]Â ÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙA ÙX ÙA$ÙX$]Â ÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙX]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙX]Â ÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙX]Â ÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙX]Â ÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ3Ò;Êtg¸ÿÿ  f‰  3Àf‰  ‹   ‰‘  ‰  ;Âv#3ÀkÀh  Bf‰P·ÒÇ ÿÿÿÿ‹Â;   rß‹‘   ‹  kÒh¹ÿÿ  f‰LœÃÌÌU‹ì‹Eƒ8ÿ·tXÇ ÿÿÿÿVf‹±  f‰pÿ  f‰‘  f;‘  u)ë¤$    ºÿÿ  f‘  ‹òƒèhf9±  tƒ8ÿtáÿ‰  ^]Â ÌÌÌÌÌÌU‹ì‹Uƒúÿu3À]Â ·Â;   sïkÀh  3É9•ÁI#Á]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Eºÿÿ  Vf9u3Òf‰‹±  ‹U‰2ë	‹Uƒhfÿ ·±  W¿ÿÿ  f;÷_t f90w‹2ƒ>ÿuƒÆh‰2fÿ f‹0f;±  vå3À^]Â ‹Æ^]Â ÌÌÌV‹ñVè{ %ÿ    w  ƒÄf‰†  ^ÃÌV‹ñ‹†   =şÿ  r3À^ÃSW< ÿşÿ  r¿şÿ  ‹†   ‹  ‹ßkÛhh€   SPQè¼{ ·   ‰†  ‹ÁƒÄ;Çs#›    kÀh†  Af‰H·ÉÇ ÿÿÿÿ‹Á;Çrã‹–  ¸ÿÿ  f‰Dœf‹   ‹×+–   ‰¾   _[f‰  ‰–  ¸   ^ÃÌÌÌÌÌÌÌÌÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E]ÃÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì¡Ä+Õ‹ˆ´	  ·EkÀh  ]ÃÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹U¡Ä+Õ‹ˆ`	  ƒúÿu3À]Ã·Â;   sñiÀ    3É9•ÁI#Á]ÃÌÌÌU‹ìƒìó=‡|ói‹EóóYóaWßWçW×óóXó`óhóqW÷óIWÏóAWÇ(ùóYüóEøóYÃó\Ç(ıóYşóXÇó}øóYúóEä(ÆóYÄó\Ç(ùóYıóXÇ(ùóYúó}óYËóuğ(ûóYşóuó\÷ó}øóYıóX÷ó}ğóYúóXÏó}øóYüóXÏóM(øóYü(ÎóYËó\Ïó}óYúóXÏóMüó}ü(ÍóYMäóXùóMäó}ğóYÌ(şóYúó\Ïó}óYûóXÏ(ıóYøóXÏóYÂóUäóYÓó\ÂóUóYÔóXÂóUğóYîóXÅóPóHó@‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒì,ó%‡|óóIóQóqóióyWüóYWôWìó}ôWÄWÌWÔ(ç(ıóYúóYáó\çóuì(ûóYşóXçó}ôóYøóeà(æóYâó\ç(ıóYûóXç(ıóYøó}üóYé(ùóYşóuüó\÷ó}ôóYûóX÷ó}ìóYøóXïó}ôóuèóYñóYúóXïómüóYè(üóYúó\÷ó}àóXõ(ëóYïóXõóuìóuèóYğ(ïóYêó\îóuüóYñóXî(óóYôóXîómğómüóYàóYùó\çóYêóXå‹Eópóu(ëóYmèóXåó(óeôó`(üóYúóeøómüóYñó\÷(ıóYûóX÷ó}óYøóYêó\ï(üóYûóXïó}üóYàóYùó\çó}óYûóXçó}üóYøóeèóeøóYáóXçó}óYúóXçóeóeèóYá(ıóYúó\çó}óYøóXç(şóYûóXçó}èóYøóeÔ(æóYâó\çó}óYùóXç(ıóYèóEóYÂó‡|óYñóIó\îóXèóEèóYÃóXèóEÔóXEìóXmôóYûóXçóXeğ(ÙWÚ/Ãr:/Èr5óA (ÈWÊ/ár%/Är óA$(ÈWÊ/ér/År¸   ‹å]Â 3À‹å]Â ÌÌÌÌÌÌÌÌÌVèzç è54ëÿ‹ğVèı…i èèìàÿj è èj j è# j è®ˆ èYïÿVèƒ+ è3 èiéÿèyÿÿè§ èZıÿèe‚ ‹@‹Qè* ƒÄè0 è½ëÿƒÉÿ‰H0‰H4‰H8‹Ä+Õ‹‚¸	  ¹şÿÿÿ‰H‰H^ÃÌÌÌÌÌÌÌÌU‹ìV‹u‹FPèàHi ‹‹E‰,;¯óó0;¯óFó4;¯óFó8;¯‹V‰<;¯ó ó@;¯ó@óD;¯ó@ƒÄóH;¯ó@óL;¯^]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E£,;¯‹Eó ó0;¯ó@ó4;¯ó@ó8;¯‹H‹E‰<;¯ó ó@;¯ó@óD;¯ó@óH;¯ó@óL;¯]ÃÌÌÌÌÌÌÌÌÌÌÌèP …Àt#èrëÿ·@4‹Ä+ÕkÀh‹‘´	  ‹Š  DÃjhÚ  hpà{j è±${ ƒÄjèw¼{ ÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹uƒ> W‹}tFPWèVØp ƒÄ…Àt	_¸   ^]Ãƒ>Su;FP_Sj FWPèœÂp ƒÄ…Àt Ù¸   Ù^ÙGÙ^Ù[Ù^‹O_‰N^]Ãj Fj PWèGi ƒÄ…Àt=FP_SjFWPèLÂp ÙÙ^ƒÄÙG¸   Ù^Ù[Ù^‹W‰V_Ç   ^]ÃÙ[Ù^ÙGÙ^ÙGÙ^‹G‰FÇ   óä«¯óFóè«¯óF óì«¯_óF$3À^]ÃÌÌÌÌÌÌÌÌU‹ìjÿhR^d¡    Pd‰%    ƒì$WÀ‹ES‹]j óóCóC‹˜´ÛPè¿fR ‰EÇEü    ‹HH„Ç  ‹H‹QQ„¸  ‹Iƒy   V‹q‹ƒè!W„ï   Htjh  hpà{j èç"{ ƒÄjè­º{ ‹F‹øÅÜj PèLfR ‹ø‰}èÆEüƒ „   ‹G‹ ‹°tÖj Pè&fR ‰EìÆEü‹ÈèßS ‹(.±j Pè
fR ‰EğÆEü‹ˆ˜  ‹	…Ét(ƒy ~"`  PEÜPNèéÿÿÙ ÙÙ@Ù[Ù@Ù[ÆEüMğèÃ(ãÿÆEüMìèGğÿÿëÙFÙÙFÙ[ÙF Ù[ÆEü MìQ‹øÅÜ‰}ìé•   ‹F‹°tÖj Pè}eR ‰EğÆEü‹ÈèoŞS ‹(.±j PèaeR ‹ø‰}èÆEü‹‡˜  ‹ …Àt)ƒx ~#—`  REĞPNèsèÿÿÙ ÙÙ@Ù[Ù@Ù[ÆEüMìQ‹(.±‰}ìèmÖQ ÆEü ‹Uğ‹°tÖEì‰UìPèTÖQ ‹E_^ÇEüÿÿÿÿMQëÇEüÿÿÿÿUR‹˜´Û‰Eè)ÖQ ‹Mô[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ìjÿh¨R^d¡    Pd‰%    Q‹E‹°tÖVWj P¿   èdR ‹ğ‰uğÇEü    ‹ÎèlİS Pè&MãÿƒÄ…Àu	‹ÎèXİS 3ÿÇEüÿÿÿÿMğQ‹°tÖ‰uğèÕQ ‹Mô‹Ç_^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhàR^d¡    Pd‰%    ƒì@‹E‹˜´ÛW3ÿWPèòcR ‰Eğ‹H;Ïu!MğQ‹˜´Ûè9ÕQ G_‹Môd‰    ‹å]Ã9yt ‹˜´ÛUğRèÕQ 3À_‹Môd‰    ‹å]ÃS‹Y‰]à;ßu$‹˜´ÛEğPèèÔQ [¸   _‹Môd‰    ‹å]Ã‰}ì‰}ä9{Å   ‰}èV‹H‹Q‹ruè‹ƒè!„’   H…Å   ‹v‹øÅÜWVè2cR ‹ğ‰uØ‰}üƒ~ ~13Û‹ÿ‹Fƒ| ~‹Pè]şÿÿƒÄ…ÀuÇEì   GƒÃ;~|Ö‹]àÇEüÿÿÿÿMÜQ‹øÅÜ‰uÜè:ÔQ ƒ}ì u43ÿ‹EäEè   @‰Eä;C}‹EğéWÿÿÿ‹VRèşıÿÿƒÄ…ÀuÕÇEì   ^‹˜´ÛEğPèğÓQ ‹Mô‹Eì[_d‰    ‹å]ÃMÌèEƒ{ ÇEü   WE´VPè“_Q ‹øÆEü‹j QUÀRèP ƒÄ‹ØÆEü‹FP‹Ïè[{ ‹PQ‹ËèP{ PUÌh _Rè‘‹{ ƒÄÆEüMÀèB‹{ ÆEüM´è6‹{ jhæ  hpà{j ès{ ƒÄjè9¶{ ÌÌÌÌÌÌÌÌÌU‹ì‹EÙ V‹uÙÙ@Ù^Ù@Ù^èá+ëÿ‰F‹Æ^]ÃÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙAÙXÙA ÙX ÙA$ÙX$]Â ÌÌÌÌÌÌÌÌÌÌ‹Á3É‰‰H‰HÃÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Q‹ÂÑèÂ‹U;ÂBÂ‰AiÀ$  Pè}Á{ ƒÄ]Â ÌÌÌÌÌÌU‹ì‹Uƒúÿt·Â;   skÀh  9uPèwïÿÿ]Â ÌÌÌU‹ì‹EPRPèğÿÿ]Â ÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EiÀĞ   ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹ñW‹}‹‰‹O‰N‹W‰V‹G‰FÙGÙ^OÙGQÙ^NÙGÙ^è‚ìÿÿÙ‡„   Ù„   Ù‡ˆ   Ùˆ   Ù‡Œ   ÙŒ   Ù‡   Ù   Ù‡”   Ù”   Ù‡˜   Ù˜   Ù‡œ   Ùœ   Ù‡    Ù    Ù‡¤   Ù¤   Ù‡¨   Ù¨   Ù‡¬   Ù¬   Ù‡°   Ù°   Ù‡´   Ù´   Ù‡¸   Ù¸   Ù‡¼   Ù¼   Ù‡À   ÙÀ   Ù‡Ä   ÙÄ   Ù‡È   ÙÈ   Ù‡Ì   ÙÌ   Ù‡Ğ   ÙĞ   Ù‡Ô   ÙÔ   Ù‡Ø   ÙØ   Ù‡Ü   ÙÜ   Ù‡à   Ùà   Ù‡ä   Ùä   Ù‡è   Ùè   Ù‡ì   Ùì   Ù‡ğ   Ùğ   Ù‡ô   Ùô   Ù‡ø   Ùø   ‹ÆÙ‡ü   Ùü   Ù‡   Ù   Ù‡  _Ù  ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìSVWè’ëÿ·}‹Ä+Õkÿh‰Eø‹ƒ´	  ‹°  L>‰MüèÊõäÿ‹Uü;u
jÿè,úåÿƒÄ‹Eø‹H8;L>uèôÿÿ‹T>Rèî ‹EüPèe=i ‹M‹›´	  ƒÄƒùÿt·Á;ƒ   s‹ƒ  Ç9uP‹Ëè•ìÿÿhL_j jjè•s{ ƒÄ_^[‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìEØƒì(PèqÎp ‹UMØQRè¤õÿÿƒÄ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒì8EÈPèAÎp ‹Eó óEğó@óEôó@óEøèŒ'ëÿMÈQUğR‰EüèLõÿÿƒÄ…ÀuƒÈÿ‹å]Ã‹EĞ‹å]ÃÌÌÌÌÌÌÌU‹ì‹Eì´   VW‹}…ÀtÙGÙ‹uƒ> tF(PWètÍp ƒÄ…Àt_¸   ^‹å]Ãó‹GóEôóGóEøóGóXEó…Tÿÿÿó\EPXÿÿÿóEğè$fÿÿóEôóTÿÿÿóUğó\Óó…\ÿÿÿóEøódÿÿÿó…`ÿÿÿWÀ(È(ÙóYÙ(àóYàóXÜ(âóYâóXÜóQãóğ^/Üó…hÿÿÿólÿÿÿó•pÿÿÿs3óà=“ó^ÜóYÃó…hÿÿÿóYËóYÓólÿÿÿó•pÿÿÿ(Äƒ>S‹]ó…tÿÿÿ‰xÿÿÿuRMèQURFP…\ÿÿÿPèCå} ƒÄ…Àt3Ù‹EÙ^(ÙGÙ^,ÙGÙ^0‹O‰N4…Àt	óEğó [_¸   ^‹å]Ã‹ÓÁê	ƒâR…XÿÿÿPè4j+ ÙÙ^(ƒÄÙGÙ^,ÙGÙ^0‹O‰N4…À„ä   ‹E…Àt	óE”ó óE°Ç   óFóE´óFóE¸óFóE¼óFóEÀóFóEÄóFóEÈóFóEÌóF óEĞóF$óEœóF<óE óF@óE¤óFD„Ûx•XÿÿÿRè´R+ ƒÄ‰FLëÇFLÿÿÿÿ‹EÔ‹|ÿÿÿ‹UØóE”‰FP‹EÜ‰NT‹Mà[‰F\_óF8‰VX‰N`¸   ^‹å]ÃWÀóF8Ç   óä«¯óF<óè«¯óF@óì«¯ƒÈÿóFD[‰FL‰FP‰FT‰FX‰F\‰F`_3À^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìód_‹E‹UƒìóD$ó0}ó$j	HQRPè¼üÿÿƒÄ]ÃÌÌÌÌÌÌÌU‹ìì¨   èâ ëÿ‹ÈèK³Q ƒøuÙî‹å]ÃVèê#ëÿ‹uóFóó^(ÈóXMó\P}PXÿÿÿóUèó]ìóMğóUôó]øóEüèßbÿÿóMèóUìóEôó]ğó\Áó\ÿÿÿóMøó\Êódÿÿÿó•`ÿÿÿóUüó\Ó(ÙóYÙ(àóYàóXÜ(âóYâóXÜó%ğ^óQÛ/ãó…hÿÿÿólÿÿÿó•pÿÿÿrWÛë0ó%à=“ó^ãóYÄóYÌóYÔó…hÿÿÿólÿÿÿó•pÿÿÿ‹EXÿÿÿj Qótÿÿÿ‰…xÿÿÿèCg+ ƒÄ…ÀtÙE”^‹å]ÃÙF^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìì¨   Vèqÿêÿ‹ÈèÚ±Q ‹uƒøu&óä«¯óóè«¯óFóì«¯óF‹EóóXó@‹@(ÈóXà=“ó\P}PXÿÿÿóUèó]ìóMğóUôó]øóEüèKaÿÿóMèóUìóEôó]ğó\Áó\ÿÿÿóMøó\Êódÿÿÿó•`ÿÿÿóUüó\Ó(ÙóYÙ(àóYàóXÜ(âóYâóXÜó%ğ^óQÛ/ãó…hÿÿÿólÿÿÿó•pÿÿÿrWÛë0ó%à=“ó^ãóYÄóYÌóYÔó…hÿÿÿólÿÿÿó•pÿÿÿXÿÿÿj Qótÿÿÿè¸e+ ƒÄ…Àt"óEœóóE óFóE¤óF^‹å]Ãóä«¯óóè«¯óFóì«¯óF^‹å]ÃÌÌÌÌU‹ì‹Ä+ÕSV‹²´	  W‹}¹ÿÿ  3Àd$ ºÿÿ  f;Êu
‹†  3ÉëƒÀhfA·–  »ÿÿ  f;Ótf;Êwƒ8ÿufAƒÀhf;Êvñ_^3À[]Ã…Àtõ;xu±_^[]ÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹ñW‹}‹‰‹O‰N‹W‰V‹G‰FÙGÙ^OÙGQÙ^NÙGÙ^èòİÿÿÙ‡„   Ù„   Ù‡ˆ   Ùˆ   Ù‡Œ   ÙŒ   Ù‡   Ù   Ù‡”   Ù”   Ù‡˜   Ù˜   Ù‡œ   Ùœ   Ù‡    Ù    Ù‡¤   Ù¤   Ù‡¨   Ù¨   Ù‡¬   Ù¬   Ù‡°   Ù°   Ù‡´   Ù´   Ù‡¸   Ù¸   Ù‡¼   Ù¼   Ù‡À   ÙÀ   Ù‡Ä   ÙÄ   Ù‡È   ÙÈ   Ù‡Ì   ÙÌ   Ù‡Ğ   ÙĞ   Ù‡Ô   ÙÔ   Ù‡Ø   ÙØ   Ù‡Ü   ÙÜ   Ù‡à   Ùà   Ù‡ä   Ùä   Ù‡è   Ùè   Ù‡ì   Ùì   Ù‡ğ   Ùğ   Ù‡ô   Ùô   Ù‡ø   Ùø   ‹ÆÙ‡ü   Ùü   Ù‡   Ù   Ù‡  _Ù  ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹PèØ´{ YÃÌÌÌÌÌÌÇA    ÃÌÌÌÌÌÌÌÌU‹ì‹EiÀĞ   ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhS^Pd‰%    ƒìV‹ñƒ¾   u$ƒ¾   t	è»ãÿÿ…ÀuƒÈÿ^‹Môd‰    ‹å]Ã·†  S·ØW‹ûkÿh¾  ‰Eğf‹GjhW‰}ìf‰†  è…ùz ƒÄ‰}èƒÉÿ‰Mü·†    ÁàÃ‰Q;Áuf–  ·  ÁáË‰f–  –  ·†  ºÿÿ  f;Âtf;Eğsf‹Eğf‰†  ‹‹Mô_[^d‰    ‹å]ÃÌÌÌÌÌÌÌU‹ìSV‹uWV‹Ùèòÿÿ‹EÆ  »  ¹    ó¥ó~€ˆ  fÖƒˆ  ‹ˆ  ‰‹  ‹”  ‰“”  ‹ˆ˜  ‰‹˜  ‹œ  ‰“œ  ‹ˆ   ‰‹   °¤  »¤  ¹    ó¥_^‹Ã[]Â ÌS‹ÜƒìƒäğƒÄU‹k‰l$‹ìjÿh S^d¡    Pd‰%    Sƒì(VWèJùêÿ‹KQ‹Èè¿«Q èJÌßÿ‹{Wèqûÿÿ‹ğ‹‰Uìè5ùêÿ‹N‹Uì‰H0‰P4‰x8è±0ıÿ‹F‰EÜEØPÇEØ0   è¨S è—S jèŠ ‹NQèÆíåÿèj ‹P‹Pè¦! è‘ èLŠ è×]ÿÿè¢êÿPèŒéÿè×ëÿPè!1i ‹˜´ÛƒÄ‰EÜ‹ j Pè›QR ‰EÌÇEü    ‹ˆ¤   ‰NP‹¨   ‰VTÙ€¬   Ù^XÇEüÿÿÿÿ‹˜´Û‰EìEìPè½ÂQ èxÃ èÔàÿjÿWè[ j ‹KQèÑ ‹Ä+Õ‹º¸	  ƒÄÇG    ‹EÜ‹ ‹˜´Ûj PèQR ‰EèÇEü   ‹Ä+Õ‹I8;Nd‚¬   ‹ˆŒ   ‰Oƒùÿ„š   ó€”   ó\€   WÉ/ÈvóMìëóEìèÒ÷êÿƒÀ$Pèé| ƒÄ‰EÌÛEÌ…ÀyØ˜=“Øø^‹Uèó‚   ÇEÜ    ØMìÙ]ìóXEìóYÕ|óEĞfïÀfÖEÔó,EĞ…À3À‹Ä+Õ‹I8È‹Eè‰NdÇEüÿÿÿÿ‹˜´ÛUÜR‰EÜè˜ÁQ ‹Mô_d‰    ^‹å]‹ã[ÃÌÌÌÌÌU‹ìjÿh@S^d¡    Pd‰%    ƒìSVWèıöêÿ‹MQ‹Èèr©Q ¡Ä+Õ‹ˆ´	  èÒûÿÿ‹Ä+Õ‹M‹Ø‹‚´	  ·óköh°  j QUèj0Rè÷KQ ƒÄÇEü    ‹ÈèÆn{ Phh_j jjèEe{ ƒÄÇEüÿÿÿÿMèè³x{ ‹}‹E‹˜´Ûj ƒÿÿPDûèiOR ‰EÇEü   PèÙCi ƒÄÇEüÿÿÿÿ‹MU‰M‹˜´ÛRèšÀQ ‹E,‹M(‹U$P‹E Q‹MR‹UP‹EQ‹MRPWQVRèp@i WèZç ƒÄ,èöêÿ‹Mƒùtƒùt3‹MW‰H0‰X4‰x8èãÃp ‹MƒÄƒùtQWèQüÿÿƒÄèÙõêÿÇ@<   ‹Mô_ÇFd    ^‹Ã[d‰    ‹å]ÃÌÌÌÌÌÌÌÌU‹ìjÿèvêÿPè AéÿƒÄèêÿè“õêÿƒx8ÿtèXäÿÿ‹EjPèíûÿÿƒÄ]ÃÌÌÌÌÌÌÌÌU‹ìV‹ñ‹Pèâ®{ ƒÄöEt	Vèõz ƒÄ‹Æ^]Â ÌÌÌÌÌÌÌÌÌU‹ìjÿhhS^d¡    Pd‰%    ƒìMó‰Mì‹M3ÀˆEó‰Mè‰Eü;Èt	‹URèäúÿÿÇEüÿÿÿÿ‹Môd‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh˜S^Pd‰%    ‹Eƒì;E„Ò   S‹]VM°ˆ  W‰Mì‰uğd$ ÆE ‰]èÇEü    …Ûtl–xşÿÿR‹Ëè íÿÿ‹EğƒÆ€»  ¹    ó¥ó~ fÖƒˆ  ‹H‰‹  ‹P‰“”  ‹H‰‹˜  ‹P‰“œ  ‹H‰‹   p»¤  ¹    ó¥‹ğÇEüÿÿÿÿÆ$  Ã$  –xşÿÿ‰]‰uğ;U…Zÿÿÿ_^‹Ã[‹Môd‰    ‹å]Ã‹Mô‹Ed‰    ‹å]ÃÌÌÌÌÌÌU‹ì‹UV‹ñ‹N;ÑvD‹ÁÑèÁ;ÂBÂ‰FiÀ$  WPè­{ ‹V‹MiÒ$  ‹ø‹QWĞRPèªşÿÿ‹Pè­{ ƒÄ‰>_^]Â ÌÌÌÌÌÌÌU‹ìƒì èõşO …ÀtVVè»êÿ‹ğƒşÿtH¡ø[ÖPÿ‚{‹‹‹€8  …Àt.‹VèÂ&åÿ‹ğ…öt UğR‹Îè1”^ PEàP‹Îè•¸^ PèâÿÿƒÄ^‹å]ÃÌÌÌÌÌÌÌU‹ìjÿh¸S^d¡    Pd‰%    ƒì¡Ä+Õ‹ˆ8	  S‹]‰Eì…É„  ¸ÿÿ  Uäf‰EàREàPÇEä    è®*ëÿ…À„Ş   VWd$ ‹}ä…ÿt{‹‡  ƒøÿtp‹ğÊÜj PèpKR ‹ğ‰uèÇEü    ·‡  f…Àx1˜;F }+iÀĞ   F‹¤  PQÿŒˆ{ƒÄ…ÀtUÇEüÿÿÿÿUğRëÇEüÿÿÿÿEğP‹ğÊÜ‰uğèn¼Q ‹EìMäQ‹ˆ8	  UàRè*ëÿ…À…`ÿÿÿ_^[‹Môd‰    ‹å]Ã‹ˆ   ‰‹œ  ÇEüÿÿÿÿ‹ğÊÜUìR‰uìè¼Q _^‹Mô[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìƒìSVWèâêÿƒøÿ„§  ‹5Ä+Õ‹8	  3ÿ;Ï„‘  Pè}%åÿ‰Eô;Ç„€  ‹¸	  ‰uø‰}ğ9{„k  ‰}üë¤$    ‹suüƒ¾˜   „²   ‹¾œ  ƒÿÿt(¡ø[ÖPÿ‚{‹‹‹€8  …Àt‹Wè $åÿ‹ø…ÿub‹Uø‹B8+†   ƒø<vnVèóıÿÿ‹¾œ  ƒÄƒÿÿu3ÿë)‹ø[ÖQÿ‚{‹‹‹€8  …Àu3ÿë
‹WèJ$åÿ‹ø‹Eø‹H8‰   …ÿt‹Ïèñ8_ ƒøuWèö<_ ƒÄ…À…‚   ‹FHtdHuy‹Eôó€¨   óˆ¬   ó\°   ó\†¬   ó°   ó\–´   ó¸   óYÉóYÀóXÈóYÒóXÊóYÛ/Ùr!_‹Æ^[‹å]Ã‹Eô¨   P„   èİÛÿÿ…Àuß‹EğEü$  @‰Eğ;C…¢şÿÿ_^3À[‹å]ÃÌÌÌÌÌÌÌÌÌ‹H4‰‹P8‰W‹@<V‰Gèşÿÿ‹ğ…öt)‹†  ƒøÿt‰G‹†ˆ  ƒøÿt‰‹†Œ  ƒøÿt‰G95<ŞÊt#…ötj j èÅêÿ‹”  PQè(B ƒÄ‰5<ŞÊ^ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìS‹Ä+ÕV‹˜  è§¡Q ƒøuR‹Ä+Õj QUø¸ÿÿ  Rf‰EøÇEü    èĞ™ ƒÄ…À„ş   ëI ¡Ä+Õ‹uüj PMøQƒÆè©™ ƒÄ…Àuâëè+êÿPèuS PèÏFi ƒÄ‹ğ…ö„»   WF}ìèæşÿÿ‹³¸	  ‹EìƒËÿƒ~ ‰u$j j Pè¨G	 ‹FƒÄ;Ãtj j Pè”G	 ƒÄ‰^‹}ğ;~tZ‰~;ût9‹VRèfØÿÿƒÄ…ÀuWÀjQó$Ph\±¯WèXj ƒÄ‰Fë$W‹Èè¸] ë‹FPè-ØÿÿƒÄ…Àt‹ÈèÏa ‰^‹Eô_;FtP‰FèZ	 ƒÄ^[‹å]ÃÌU‹ìd¡    jÿh T^Pd‰%    ƒìS‹]VW‹ù‹Ë+¸¹uy÷é‹GÁú‹òÁîò9Gu	@P‹Ïè÷ùÿÿ‹G‹‹ÈiÉ$  Ê‰Mğ;ğs@iö$  ò3ÀUˆE‰Uì‰Mè‰Eü;ÈtVènóÿÿÇEüÿÿÿÿÿG_^[‹Môd‰    ‹å]Â 3ÀUˆE‰Uè‰Mì¾   ‰uü;ÈtSè1óÿÿÇEüÿÿÿÿw‹Mô_^[d‰    ‹å]Â ÌÌÌÌU‹ì¡Ä+Õì$  S‹˜¸	  …Û„˜   ‹MVQÜıÿÿèÃïÿÿ‹Eó~ ‹P‹uh€   …äşÿÿVPfÖ…dÿÿÿ‰•lÿÿÿèÆäÑÿ‹MƒÄƒ¾¸    ‰pÿÿÿÇ…|ÿÿÿ    Ç…tÿÿÿ    t"‹–È   h€   RE€PÇ…tÿÿÿ   è~äÑÿƒÄÜıÿÿQKèlşÿÿ^[‹å]ÃÌÌÌÌÌÌU‹ìd¡    jÿh!T^Pd‰%    SVW‹}jWjh$  èîz ‹ğ‹Eh   PVè"äÑÿ‹E‰†   kÀhj Wh€   PèØíz ƒÄ,‹Î‰†  Ç†  h   ‰¾   èÓÿÿVè²d{ %ÿ    w  f‰†  ‹\fà‹KƒÄ3ÿè¾ àÿ3É‰E;Át‰E‰Mü‰H‰HÇEüÿÿÿÿ‹ø‰7ÿC‰O‰O‹C;Át‰x‹K‰Oë‰;‹Mô‰{_‹Æ^d‰    [‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹u‹…Òtc‹\fà‹…Àt¤$    9t	‹@…Àuõë
…ÀtPèy1âÿ‹‹ˆ   ‹  QRè´éz ‹Ç€      ‹‹ˆ   QPè™éz ƒÄÇ    ^]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhFT^d¡    Pd‰%    ƒìVWè¾6q èùq èzp ‹5Ä+Õh   èTğO Ph€}è9şÿÿ‰†´	  ƒÄÆ¸	  j‰uğè0ğO Pjj$èFìz ‰3É‰H‹ƒÈÿ‰‹‰B‹>ºşÿÿÿ‰W‹>‰W‹‰B‹6ƒÄƒÆ‰uì‰Müt‰‰N‰N‰Eü‹Mô_^d‰    ‹å]ÃÌÌÌÌS‹Ä+ÕVW¾ÿÿ  3ÿ‹ƒ´	  ¹ÿÿ  f;ñu
‹¸  3öëƒÇhfF·€  ‹Ñf;Âtf;ğwƒ?ÿuVfFƒÇhf;ğvñƒ´	  Pècşÿÿ‹ƒ¸	  ‹HQèD£{ è_ïO ‹“¸	  PRèBèz ƒÄÇƒ¸	      è`9q èû#q _^[éS¬p …ÿt°‹PèçãÿÿƒÄé_ÿÿÿÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ   ÃÌÌÌÌÌÌÌÌÌU‹ìjÿhÁT^d¡    Pd‰%    QV‹ñ‰uğÇEü   €   èOk{ ÆEüNtèCk{ ÆEüNhè7k{ ÆEüN\è+k{ ÆEüNPèk{ ÆEüNDèk{ ÆEüN8èk{ ÆEüN,èûj{ ÆEü N èïj{ ÇEüÿÿÿÿNèàj{ ‹Mô^d‰    ‹å]ÃÌU‹ìjÿhÛT^d¡    Pd‰%    Q‰MğÇEüÿÿÿÿƒÁè%ÿÿÿ‹Môd‰    ‹å]ÃÌÌÌÌÌÌÌU‹ìjÿhøT^d¡    Pd‰%    ƒìSVWhØgÉèH—àÿ‹ğƒÄ‹ÎèŒş	 3É‹ø3Û+Á‰Mğ‰MìtHtHuÇEì   ë»   ëÇEğ   9MtHhàiÉèà’àÿ‹ƒÄ‹È‹B$j ÿĞhP†ÉèÈ’àÿ‹ƒÄ‹È‹B$j ÿĞhÀ¢Éè°’àÿ‹ƒÄ‹È‹B$j ÿĞhàiÉè˜’àÿ‹Mğ‹‹R$ƒÄQ‹ÈÿÒhP†Éè~’àÿ‹ƒÄ‹È‹B$SÿĞhÀ¢Éèg’àÿ‹Mì‹‹R$ƒÄQ‹ÈÿÒW‹Îè/ı	    PEàPè€›R ÇEü    hÈcÉèO’àÿƒÄ‹ø‹7j Màè>_{ ‹–   P‹ÏÿÒÇEüÿÿÿÿMàèDi{ ‹Mô_^[d‰    ‹å]ÃÌÌÌWhØgÉè–àÿƒÄ‹øè›'P …Àt?j ‹Ïè®ü	 …Àt‹‹È‹B$j ÿĞVj‹Ïè•ü	 ‹ğ…ötj j‹Ïèş	 ‹‹B$j ‹ÎÿĞ^j èAşÿÿƒÄ_ÃÌÌÌÌÌÌÌÌÌÌÌÌjè)şÿÿYÃÌÌÌÌÌÌÌj hÀaÉèDõÿƒÄÃèBõÿ…Àujj	è0&P ƒÄ…Àt\hÀaÉè?‘àÿƒÄö@th”³­h  èW³R ƒÄPèn7	 ëjhÀaÉèğõÿƒÄhØgÉè#•àÿƒÄj j‹ÈèUı	 j èıÿÿYÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìèxÿÿÿ]éÒÕ' ÌÌVhØgÉèå”àÿhÀaÉ‹ğè¹àÿƒÄö@t‹Îèü	 ƒøuj hÀaÉèxõÿƒÄ^Ã^é-ÿÿÿÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìVWh*¶è±àÿ‹}ƒÄ‹ğ¸`…ÿu¸`Pj ‹Îè® ¸ä_…ÿu¸Ì_Pj‹Îèù­ ¸°_…ÿu¸œ_Pj‹Îèá­ …ÿ_^h”³­thè   è<²R ƒÄPèS6	 ƒÄ]Ãhé   è$²R ƒÄPè;6	 ƒÄ]ÃÌÌÌÌÌÌU‹ìVWhØgÉèñ“àÿ‹}ƒÄ‹ğW‹Îè¡ú	 …Àt6j W‹Îèü	 hÀaÉè©àÿƒÄö@tj èIüÿÿƒÄ_^]Ã‹‹È‹B$jÿĞ_^]ÃÌÌÌU‹ìV‹uVèàÿƒÄ‹ÈèYZäÿ‹@ŞÊ9t‰PƒÁè„ ‹@ŞÊƒÁQV¹ˆf­èoJïÿ^]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh U^Pd‰%    ƒìVWh rÉ‹ñè'àÿƒÄ‹øƒşÿu#‹‹   j hpà{‹ÏÿÒ_^‹Môd‰    ‹å]ÃjÿVè2a ‹ğƒÄ…ö„   ‹SPMèQèØya ƒÄÇEü    ‹j ‹ÈèÃ[{ ‹“   P‹ÏÿÒƒÏÿ‰}üMèèÊe{ [9~tNèÿêÿPèiõW ‹P‹FPQUèRèø|a ƒÄÇEü   Mèèv[{ PhtÉèë‘àÿƒÄ‹Èè{ ‰}üMèève{ ‹Mô_^d‰    ‹å]ÃÌÌÌÌÌÌU‹ìd¡    jÿhpU^Pd‰%    ƒì@VWhvÉ‹ùè÷àÿƒÄ‹ğƒÿÿu‹‹P$j ‹ÎÿÒ_^‹Môd‰    ‹å]Ãè½êÿ…À„4  MàQUğRMìQUØRWPèN¸a ƒÄ…À„  ‹EÜ‹MØPQè¶ëşÿƒÄƒ}ì ‰Eäu$…Àu ƒ}ğÿu‹P‹B$‹ÎÿĞ_^‹Môd‰    ‹å]Ã‹‹B$Sj‹ÎÿĞh8€ÉèPàÿh(|É‹øèDàÿhxÉ‹ğè8àÿ‹ƒÄƒ}ğÿ‹Ø‹B$‹Ï„Û   jÿĞ‹‹B$j ‹ÎÿĞ‹‹B$j ‹ËÿĞh@‚Éèàÿ‹ğ‹‹B$ƒÄj‹ÎÿĞ‹MğQ‹ÎèÃWäÿ‹UğR‹ÎèÖ	 ‹Eğj PMÀj1Qè7Q ƒÄÇEü    MÀèÕY{ Ph”  èÚ®R ƒÄPUÌRè­“R ÆEühH„Éè¯ŒàÿƒÄ‹ø‹7j MÌèY{ P‹†   ‹ÏÿĞÆEü MÌè§c{ ÇEüÿÿÿÿMÀè˜c{ [_^‹Môd‰    ‹å]Ãj ÿĞ‹Eìj …À¹   ™RPM´Qè*5X ƒÄ‹øÇEü 		handler(...)
	end
end

--------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------
function core:GetItemInfoFromPlayerCache(itemId, itemName)
	local id, name, icon
	
	if(itemId) then
		name = GetItemInfo(itemId)
		id = itemId
		icon = GetItemIcon(itemId)
		
	elseif(itemName) then
		local link
		name, link = GetItemInfo(itemName)
		if(name) then
			--borrowed expressions from ItemId, thank you
			local justItemId = string.gsub(link, ".-\124H([^\124]*)\124h.*", "%1");
			local type, itemid, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":",justItemId);
			id = tonumber(itemid) --todo, extract id from link
			icon = GetItemIcon(id)
		end
	end
	
	return id, name, icon
end

function core:GetItemInfo(requestid, requestname)
	local id, name, icon
	if(requestid) then
		--this method will always return a value if the id exists
		icon = GetItemIcon(requestid)
		--the item by that id exists, but it's not in the local or server cache, try to query again later.
		if(icon) then --try to lookup item again
			--item exists, see if we have the name in cache, could return nil
			id, name = core:GetItemInfoFromPlayerCache(requestid, nil)
		end
	else
		id, name, icon = core:GetItemInfoFromPlayerCache(nil, requestname)
	end
	
	return id, name, icon
end

function core:GetClassEnum(classFileName)
	for i, class in ipairs(CLASS_ENUM) do
		if(class:upper() == classFileName:upper()) then
			return i
		end
	end
	error("Failed to locate class enum")
end

function core:GetMessageEnum(messageName)
	for i, msg in ipairs(MESSAGE_ENUM) do
		if(msg == messageName) then
			return i
		end
	end
	error("Failed to locate message enum")
end

function core:KillCooldownScanTimer()
	if(COOLDOWN_SCAN_TIMER) then
		Hermes:CancelTimer(COOLDOWN_SCAN_TIMER, true)
		COOLDOWN_SCAN_TIMER = Hermes:ScheduleTimer("OnUpdateSenderCooldowns", 0.1, nil) --convert to one shot timer
		Hermes:CancelTimer(COOLDOWN_SCAN_TIMER, true) --cancel again, we don't care if it ran or not
		COOLDOWN_SCAN_TIMER = nil
	end
end

function core:StartCooldownScanTimer(delay)
	COOLDOWN_SCAN_TIMER = Hermes:ScheduleRepeatingTimer("OnUpdateSenderCooldowns", delay, delay)
end

function core:GetLocalizedClassName(classToken)
	local localizedClassName
	if(classToken == "ANY") then
		return L["Any"]
	else
		return LOCALIZED_CLASS_NAMES[classToken]
	end
end

function core:SortProfileSpells(a, b)
	return a.name < b.name
end

function core:SortProfileItems(a, b)
	return a.name < b.name
end

function core:GetSpellID(spell)
	local matches = {}
	for i = 1, 100000 do
		local name, rank, icon, powerCost, _, powerType, castingTime, minRange, maxRange = GetSpellInfo(i)
		if name == spell then
			tinsert(matches, i)
		end
	end
	
	return matches
end

function core:EncodeAbilityId(id, trackertype)	--spells have positive id's, items have negative id's, returns the type and a positive id
	if(trackertype == "spell") then
		return abs(id)
	elseif(trackertype == "item") then
		return abs(id) * -1
	else
		error("unknown encode type")
	end
end

function core:GetNextItemIdToCache(currentId)
	local lastIndex = nil
	local nextIndex = nil
	for i, item in ipairs(dbp.items) do
		if(lastIndex and item.caching) then
			nextIndex = i
			break
		end
		if(item.id == currentId) then
			lastIndex = i
		end
	end
	
	--it's possible there weren't any items needing caching ocurring after the last item,
	--so start from beginning and take the first match. This will also restart the current item if it's the first one
	if(lastIndex and not nextIndex) then
		for i, item in ipairs(dbp.items) do
			if(item.caching) then
				nextIndex = i
				break
			end
		end
	end
	
	if(nextIndex) then
		return dbp.items[nextIndex].id
	end
end

function core:KillItemNameTimer()
	if(ITEM_NAME_TIMER) then
		Hermes:CancelTimer(ITEM_NAME_TIMER, true)
		ITEM_NAME_TIMER = nil
	end
end

function core:StartItemNameTimer(id)
	--don't kick off the timer if it's already running, it's smart enough to restart itself
	if(ITEM_NAME_TIMER == nil) then
		--if it wasn't already running, then make the first one 10 seconds for quicker initial response of a new item
		ITEM_NAME_TIMER = Hermes:ScheduleTimer("OnUpdateItemNameTimer", 5, id)
	end
end

--------------------------------------------------------------------
-- Special Handling for DK Rune Cooldowns
-- Only spells using runes that actually have a cooldown need to be listed
-- This algorithm will only work properly so long as all cooldowns using
-- runes are greater than the rune duration of 10 (or 9 depending on talents) seconds.
--------------------------------------------------------------------
local runeSpells = {
	[51052] = 0, -- Anti-Magic Zone -- 2 min
	[42650] = 0, -- Army of the Dead -- 10 min
	[49222] = 0, -- Bone Shield -- 1 min
	[43265] = 0, -- Death and Decay -- 30 sec
	[50977] = 0, -- Death Gate 1 min
	[51271] = 0, -- Pillar of Frost -- 1 min
	[48982] = 0, -- Rune Tap -- 30 sec
	[47476] = 0, -- Strangulate -- 2 min
}

function core:AdjustForRunes(tracker)
	local runeSpell = runeSpells[tracker.id]
	if (runeSpell and tracker.duration and tracker.duration <= 10) then --10 seconds is good enough. Checking for talents and 9 is not worth the trouble
		return true
	end
	
	return false
end

------------------------------------------------------------------
-- GENERAL HELPERS
------------------------------------------------------------------
function core:ShowHermesTestModeMessage()
	local message = "|cff19FF19Hermes: "..L["Config Mode"].."|r\n\n"
	message = message ..L["Hermes is running in Config Mode."].."\r\n"..L["Toggle it on or off in the 'General' settings tab."].."\n\n"
	StaticPopupDialogs["HermesConfigMode"] = {
		preferredIndex = 3,
		text = message, 
		button1 = L["Edit Settings"],
		button2 = L["Close"],
		timeout = 0,
		whileDead = 1, 
		hideOnEscape = 1, 
		OnAccept = function() core:OpenConfigWindow() end,
		OnCancel = function() end
	}
	StaticPopup_Show("HermesConfigMode")
	dbp.welcome = true
end

function core:ShowMessageBox(text)
	StaticPopupDialogs["HermesMessageBox"] = {
		preferredIndex = 3,
		text = text, 
		button1 = L["Close"],
		timeout = 0,
		whileDead = 1, 
		hideOnEscape = 1, 
		OnAccept = function() end
	}
	StaticPopup_Show("HermesMessageBox")
end

function core:StartTestMode()
	--set the test mode bit
	dbp.configMode = true
	
	--we may already be a raid or party or some such, stop sending and receiving if we are so they we start with a clean slate
	if Hermes:IsSending() == true then
		core:StopSending()
	end
	if Hermes:IsReceiving() == true  then
		core:StopReceiving()
	end
	
	--force sending and receiving to start in test mode
	core:UpdateCommunicationsStatus()
end

function core:StopTestMode()
	--set the test mode bit
	dbp.configMode = false
	
	--make sure we completely reset the sending/receiving state
	core:StopSending()
	core:StopReceiving()
	
	--force sending and receiving to start (if applicable)
	core:UpdateCommunicationsStatus()
end

function core:PrintTable(myTable)
	if (myTable == nil) then Hermes:Print("NIL"); return; end
	
	for key, value in pairs(myTable) do
		if (type(value) == "table") then
			core:PrintTable(value);
		elseif (value ~= nil) then
			if (type(value) == "boolean") then
				value = tostring(value)
			end
			Hermes:Print(key .. ": " .. value);
		elseif (key ~= nil) then
			Hermes:Print(key .. ": value is nil");
		end
	end
end

------------------------------------------------------------------
-- PLUGIN API
------------------------------------------------------------------
function core:EnablePlugins()
	for name, plugin in pairs(Plugins) do
		--only startup plugins that are enabled or don't exist in the profile (assumes they're new)
		if dbp.pluginState[name] == nil then
			dbp.pluginState[name] = true
		end
		if dbp.pluginState[name] == true then
			core:EnablePlugin(name)
		end
	end
ez ƒÄÇF$    ÃÌÌÌV‹ñö† 
  t9Wè>Öèÿ‹øèçâßÿ‹;N u‹P;V$u‹†   ƒàP‹ÏèWÕèÿë	j ‹Ïè<éÿ_‹†Ä  ƒÉÿ;Át‹Ä+Õ@9Bv‰Ä  ‰À  ^ÃÌÌÌÌU‹ì‹Á‹MÙÙÙAÙXÙAÙX‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q ‰P ‹Q$‰P$‹Q(‰P(‹Q,‰P,‹Q0‰P0ÙA4ÙX4ÙA8ÙX8ÙA<ÙX<‹Q@‰P@‹ID‰HD]Â ÌÌÌÌÌÌÌÌÌÌ¡DŞÊ…Àt3É9HX”Á‰HXÃÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìƒ=DŞÊ tQ‹EVPèg¨W ‹ğƒÄ…öt=èyuQ ÙEØÕ|‹ÈÙ}ş·Eş   ‰EøÙmøß}ô‹Uô‰†p—  ÙmşƒÀx‰†t—  ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÇ@    ÃÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹M‹‹P@‰]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ3À9A”ÀÃÌÌÌÌÌÌÌU‹ìŠEŠM:ÁrŠÁ]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E3ÒV9Pt,9Pt‹H‹P‰Q‹H‹P‰Q^]Â ‹p‰V‹@‰^]Â 9Pt‹p‰V‹P‰Q^]Â ‰‰Q^]Â ÌÌÌÌÌÌ‹Á3É‰‰H‰H‰HÃÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E3ÒV9P@t,9P<t‹H@‹P<‰Q<‹H<‹P@‰Q@^]Â ‹p@‰V<‹@@‰^]Â 9P<t‹p<‰V@‹P<‰Q^]Â ‰‰Q^]Â ÌÌÌÌÌÌU‹ì‹E‹Mó	ó\óYM‹UóXó
]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹U¶Â5ÅiÀ“ ¶Ö3Â¶U
iÀ“ ‹	3Â¶UiÀ“ 3ÂiÀ“ #Á]Â ÌU‹ì‹Á‹M‹‰‹Q‰P‹Q‰P‹Q‰PÙAÙXÙAÙXÙAÙXÙAÙX‹Q ‰P ‹Q$‰P$‹Q(‰P(‹Q,‰P,‹Q0‰P0‹Q4‰P4‹I8‰H8]Â ÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Á‹M‰Ç@    ]Â ÌÌÌÌÌÌÌÌÌÌÌ3ÀÇA
   ÇD   ‰A‰AÇA  ‰AÇAğ`ÃÌÌÌÌÌÌÌÌÌ3ÀÇA
   ÇP   ‰A‰AÇA  ‰AÇAğ`ÃÌÌÌÌÌÌÌÌÌU‹ìyğ`tjhT  hpà{j èÒz ƒÄjè×i{ ‹E‰A]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìyğ`tjh  hpà{j èÑÑz ƒÄjè—i{ ‹E‰A]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹‹Mˆ]Â Ì‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÂ ÌÌÌÌÌÌÌÌÌÌÌÌÌÂ ÌÌÌÌÌÌÌÌÌÌÌÌÌÇ    ÇA    ÃÌÌ‹Á3É‰H<‰H@ÃÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÇ     Ç@    ÃU‹ìƒìPV‹ñè²æÿÿÙUüÙáÙcÙÉßñİØ†£  óVó^óY^ ó~óNóvóYv ónóà=“ó^Eü(âóYfó\Ü(çóY~óYfó\æóYêó\ïó~ó}ü(ñóYò(×óYV ó\òóóu¼(òóYv (ùóY~ó\÷ó}üóY~ó}øóYØóuÀóuøó]Ôó]¼(úóY~ó\÷ó}üóY~óYØó]àó]Àó}øóuÄóuøóYØ(ùóY~óYNó\÷ó]äó]ÄóuÈóuüóYv(úóYVóY~óYØó]èó]ÈóYàó\Ïó\ÖóYèóYØóYÈóYĞóeØó~EÔómÜó]ìóMğóUô‹E‹MôfÖ ó~EÜfÖ@ó~EäfÖ@ó~EìfÖ@‰H ^‹å]Â ‹Eó~€ª¯‹ ª¯fÖ ó~ˆª¯fÖ@ó~ª¯fÖ@ó~˜ª¯fÖ@‰P ^‹å]Â ÌÌU‹ìjÿh&V^d¡    Pd‰%    QV‹ñh   Fj P‰uğÇ    è+u ƒÄ˜   èM½ ÇEü   Ç†@      Ç†H      ÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌWÀ‹ÁÇ@ÿÿÿÿó@ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁƒÉÿ‰H‰HÃÌÌÌÌV‹ñÙ†h  WÙ0  ¾(
  Ù†l  WÙ4  Ù†p  Ù8  Ù†t  Ù<  è (àÿƒÄ…Àu[ó4  ó–8  ó<  ó¦0  ó0/}óXÈó\Ğó\ØóXà_ó¦@  óD  ó–H  óL  ^ÃWè8càÿÙ€h  Ù@  ƒÄÙ€l  _ÙD  Ù€p  ÙH  Ù€t  ÙL  ^ÃÌÌU‹ì¹ˆf­èÓïÿ‹EPèŠgàÿƒÄ‹È]éïæÿÿÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh@V^d¡    Pd‰%    ƒìdSVh8  èÙ„R óà=“‹uƒÄ3ÛSjVM‰EÀÇEÄ   óEÈóEÌÇEĞ   ÇEÔ   óEØè¶ëÿ‰]üEäPMQUÀRè‚ŠëÿƒÄÇEüÿÿÿÿMè€)ëÿ¡ ¬¯óMäóY8=“ó†   Só\Áó  ó\Mè‰EìŠ†  jVMóEÜóMàˆEïf‰]ğˆ]òˆEóè9ëÿÇEü   óESjÿSjQó$MğQUìREÜPMQUÀRèè]ëÿƒÄ(ÇEüÿÿÿÿMèæ(ëÿ‹Mô^[d‰    ‹å]Â ÌÌÌÌU‹ìd¡    jÿhcV^Pd‰%    ì˜   S‹Ùöƒ 
  VW„a  ƒ»t   ÇEè    »  ³€  ›    h8  èfƒR óà=“ƒÄj ‰E¼¸   j¾ôşÿÿWMŒÇEÀ   óEÄóEÈ‰EÌ‰EĞóEÔèDëÿÇEü    EàPMŒQU¼Rè‰ëÿƒÄÇEüÿÿÿÿMŒè
(ëÿ¡ ¬¯óMàóY8=“óFôj ó\ÁóNøó\Mä‰EìŠjW\ÿÿÿóEØóMÜˆEïfÇEğ  ÆEò ˆEóèÆëÿÇEü   óEj jÿj jQó$MğQUìREØP\ÿÿÿQU¼Rèp\ëÿƒÄ(ÇEüÿÿÿÿ\ÿÿÿèk'ëÿ‹Eè@Æ  ‰Eè;ƒt  ŒÒşÿÿ_^[‹Môd‰    ‹å]Â 3ÿ9»t  ~1³t  ƒ¾   tóEQó$V‹ËèıÿÿGÆ  ;»t  |Õ‹ƒÀ  ƒøÿt(;ƒt  } óEiÀ  Q„t  ó$P‹ËèÁüÿÿ‹Mô_^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌS‹ÜƒìƒäğƒÄU‹k‰l$‹ìƒì(V‹sW‹ù‹Îè)| Ù]üóEüóY8=“‹ÎóEüóEôè| Ù]ø‹CóóXUüóEøóY8=“óXFóó\ÊóPó\ĞóEôóYÀóYÒóYÉóXÑó^Ğóà=“ó\ÂóY¤Ò|óEàÇEì    fïÀfÖEäó,Eà…Ày3Àë=ÿ   ~¸ÿ   Š`  :ÁrŠÁ_^‹å]‹ã[Â ÌÌÌÌU‹ìƒì\S‹Ùöƒ 
  „T  ‹E¨„I  óà=“VW‹øÑïƒÉÿƒçÇEô    ‰MÔ‰MØóE¾ør­¨tN¾Ør­¨ u¾¸r­©   tEÔPh$dë¨Àt*MÔQhdjèÌò óƒÄƒÉÿóEÇEô   ƒ»È   WÀ‰MÜ‰MàóEì„õ   ‹FUÜRPjèˆò óƒH  óXƒ@  óY8=“‹@  óEäóAóXAóY8=“ƒÄóEèèf}| Ø8=“‹EóómäÙ]ìóXóuèó\Õó\Ş(ÃóYÃ(ÊóYÊóXÁóQÈóc/Ásóà=“ó^Á(ÈóYÊóYÃ(Ñ(Øƒì(ÂóYEì(ËóYMìóXÅóXÎóT$óEäóMèó$èºÒ{ Ù]ìƒÄë{V‹uMÜQƒ@  ‹Îè}áÿÿóó‹@  ó“H  ƒÄ/ÈvóMäë/ÂvóUäëóEäóFó‹D  /Èó“L  vóMèë/ÂvóUèëóEè‹UÜEøjPÇEø,   ‰Uüè< ƒÄ…À„  óEäó\°Ò|óMèó\°Ò|j j M¤QU´óE´óXğœ|óM¸óXğœ|RóE¼óMÀèU4ìÿól,}óYdóU(ÁóY ‡|ƒÄ/ĞóMüv(Âƒ}ô ó\ÁóEt=j jÿj j jÿj Qó$h(¬¯h ¬¯E¤PMÔjÿQèk¸ëÿóEó\EüƒÄ0óEó~M¤fÖMÄó~M¬fÖMÌóMóMóà=“‹EóMô+Eô=   €t%ÿÿÿƒøÒ÷Ú…‚   MÄè÷z| Ù]ğMÄèüz| Ù]ôóEğóY8=“óMôóUó\à=“óY8=“óYÂóYÊóUÄó\ĞóUÄóUÈó\ÑóUÈóUÌóXĞóEĞóXÁóEĞóEóUÌƒ»È   t6óMìjÿj j jÿQó$j Qó$h(¬¯h ¬¯EÄPMÜjÿQè ºëÿë+j jÿj j jÿj Qó$h(¬¯h ¬¯UÄREÜjÿPè#·ëÿ‹M‹UƒÄ0WQ‹MREäPQ‹Ëèhİÿÿ_^[‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìHEèPhLdjÇEèÿÿÿÿÇEìÿÿÿÿè¬î ‹MèUğjRÇEğ,   ‰Môè: ƒÄ…À„×  óEè¿s óYHdóY8=“óYÔœ|óXEóEóEè‡s óHdóMó\DdóYÂóY8=“óYÔœ|óXEj óEó\Ddj E¸PMÈóMÈóEÌóXÊóXÂQóMĞóEÔè‹1ìÿól,}óYdóU(ÈóY ‡|ƒÄ/Ñv(Êó\Èó~E¸fÖEØó~EÀfÖEàóÔœ|óEóà=“‹EóEü+EüóMô=   €t%ÿÿÿƒøÒ÷ÚuxMØèvx| Ù]øMØè{x| Ù]üóEøóY8=“óY ‡|óUØóMüóY8=“óY ‡|ó\ĞóUØóUÜó\ÑóUÜóUàóXĞóEäóXÁóUàóEäóEóX@djÿj j jÿQó$óEôj Qó$h(¬¯h ¬¯EØPMèjÿQè…·ëÿƒÄ0‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìV‹ğƒ~4 …  ƒ~$ „  óS(Èó\ÊóMğóOj Eğ(ÙP^ó\ÚóXÂóXÊSó]ôóEøóMüèÀ€| ƒÄ…À„²   óóOó\NóvóFó\vfnn(óà=“‹Mfnf,[íó\Ãó^Ğóó^ÎóYÍómğó\ëó\ÃóYê[äQóYÂóYÄóYìƒìó\èT- ˆ|ól$óD$ó$Vè6àÿÿƒÄ‹Æèœãÿÿ.à=“ŸöÄDzÇF4   èSêÿÿ[^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒì0V‹5DŞÊƒ¾Œ  ÿW‹ù„  è®Îêÿ‰Eü9†Œ  …ğ   ó†€  SEìPMôóEôó†„  Q‹ÏóEøèÅÜÿÿ‹]¡DŞÊ3öë	¤$    ‹ÿ‹ŒÔ  ó”Ø  ó„È  óŒÌ  óUà;MüuxUôREìP‹ÏóEìóMğèkÜÿÿj j MäQUôRè
0ìÿóóğe­‹Eø‹Mô(ĞóYl,}óXà=“ƒÄó\ÊóL$óóEàó$PQ‹Ïè‘ûÿÿ¡DŞÊƒÆƒş<ŒPÿÿÿ[_^‹å]Â ÌÌÌÌÌÌÌU‹ìd¡    jÿhxV^Pd‰%    ‹ESƒËÿVW;Ãt=‹°¼Öj PèMR ‹ğ‰uÇEü    ‹EƒètfHtGHt(‰]ü‹°¼ÖEP‰uè~tQ ‹Ã‹Môd‰    _^[‹å]Ã‹F`h   PèkU ƒÄ‹ø‰]üMQë6‹F`h
  PèkU ƒÄ‹ø‰]üURë‹F`h	  PèekU ƒÄ‹ø‰]üEP‹°¼Ö‰uètQ ‹Mô‹Ç_^d‰    [‹å]ÃÌÌÌÌÌÌÌÌU‹ìjÿh˜V^d¡    Pd‰%    QVW‹}‹ÏèO^ ‹°¼Öj Pè]R ‹ğ‰uğÇEü    ‹ÏèJN^ ‹øƒÿuh   ë;è÷ßéÿ‹H<QWèı1\ ƒÄ…Àt ‹F`h	  Pè¸jU ƒÄ‹øÇEüÿÿÿÿUğRëh
  ‹F`Pè˜jU ‹øƒÄÇEüÿÿÿÿEğP‹°¼Ö‰uğè:sQ ‹Mô‹Ç_^d‰    ‹å]ÃÌÌÌÌÌÌÌÌU‹ìSV‹uÇFÿÿÿÿÇFÿÿÿÿ^W‹}ÙGÙÙGÙ^ÙGÙ^‹G‰F‹O‰3Éƒ;ÿ‰N‹W0‰V(ÙG<Ù^4ÙG@Ù^8ÙGDÙ^<‹G4‰F,‹WH‰V@‹G8‰F0‹WP‰V$‰NDu&‹G ;ÁtSPjèZç ƒÄ…Àu‹G SPjèGç ƒÄhe  è:uR ƒÄ9uƒ~0 uóøDóF8‹O$‰N‹W(‰V‹GL‰F ‹OP_‰N$‹Æ^[]ÃÌU‹ì‹Á‹MÙÙÙAÙXÙAÙX‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q‰P‹Q ‰P ‹Q$‰P$‹Q(‰P(‹Q,‰P,‹Q0‰P0ÙA4ÙX4ÙA8ÙX8ÙA<ÙX<‹Q@‰P@‹ID‰HD]Â ÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹M‹‹P@‰]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ3À9A”ÀÃÌÌÌÌÌÌÌU‹ì‹EÙ ‹MÙØáØMŞÁ]ÃÌÌÌÌÌÌÌÌÌÌ‹Á3ÉÇ@
   Ç D   ‰H‰HÇ@  ‰HÇ@ğ`ÃÌÌÌÌÌÌÌ‹Á3ÉÇ@
   Ç P   ‰H‰HÇ@  ‰HÇ@ğ`ÃÌÌÌÌÌÌÌU‹ì‹‹Mˆ]Â ÌU‹ì‹‹Mˆ]Â Ì‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìy(ğ`tjhß   hpà{j è±»z ƒÄjèwS{ ‹E‰A ÇA$    ]Â ÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁƒÉÿ‰H‰HÇ     ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹‰   ‹E‰]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹‰$  ‹E‰]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹‰‘$  ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Uƒúÿt¡DŞÊ‹H…Ét‹Á‹I@9Pt…Éuò3À]ÃÌÌÌÌÌÌÌU‹ìVW‹}j Wè°2i ‹5DŞÊ‹ĞƒÄƒúÿt‹N…Ét‹Á‹I@9PtM…Éuò‹V3À…Òt@‹w‹Ê‹R@9qu)ó/AróI/ÈróG/Ar
óI/Ès…ÒuÉ_^]Ã‹Á_^]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌWÀV‹ñó†P  ó†T  Ù†P  ÙX  WÙ†T  3ÿÙ\  Æ†`  ÿ‰¾
  Ç†À  ÿÿÿÿÇ†Ä  ÿÿÿÿ9¾ü  ujWjj è*¦z ƒÄ‰†ü  ‹†ü  óà=“Ç@ 5¯ (
  ‰¾ 
  ó†d  ó†h  ó†l  ‰¾t  ùà*­t‹ä*­¡à*­hè*­RPèc&ãÿó`fàó†0  ódfàó†4  óhfàó†8  ólfàó†<  ó`fàó†@  ódfàó†D  óhfàó†H  ólfàó†L  ‰¾Ì  ‰¾Ğ  ‰¾È  _Ç†p  ÿÿÿÿ^ÃÌÌÌÌU‹ìjÿh¸V^d¡    Pd‰%    Q‹E‹USVW‹Ù‹MPQR‹Ë‰]ğèìôëÿÇEü    ÇXd³t  ¿ÿ   d$ WÀÇ†  ÿÿÿÿÆ†  ÿÇ†      h   Vó†   ó†  è·¡z ƒÄÆ  Oy»‹ËèôıÿÿÇEüÿÿÿÿ‹Mô_^‹Ã[d‰    ‹å]Â ÌÌÌÌÌÌÌÌU‹ìjÿhØV^d¡    Pd‰%    Q‰MğÇXdÇEüÿÿÿÿèÂÎëÿ‹Môd‰    ‹å]ÃÌÌÌÌU‹ì‹Eƒø
u	¸   ]Â ƒøtòƒø%tí3Éƒø”Á‹Á]Â ÌÌÌÌU‹ìjÿhøV^d¡    Pd‰%    QV‹ñ‰uğÇXdÇEüÿÿÿÿèOÎëÿöEt	Vè³¡z ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhW^d¡    Pd‰%    Q‹ESVW‹Ù‹MPQ‹Ë‰]ğè ìÿÇEü    ÇXd³t  ¿ÿ   ë›    WÀÇ†  ÿÿÿÿÆ†  ÿÇ†      h   Vó†   ó†  è' z ƒÄÆ  Oy»‹ËèdüÿÿÇEüÿÿÿÿ‹Mô_^‹Ã[d‰    ‹å]Â ÌÌÌÌÌÌÌÌƒúÿt¡DŞÊ‹H…Ét‹Á‹I@9Pt…Éuò3ÀÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹„   ƒúÿt‹DŞÊ‹I…Ét‹Á‹I@9Pt…Éuò3ÀÃÌÌÌÌÌÌÌ¡DŞÊ…Àt‹@…ÀtƒÊÿ‹È‹@@9Q t‰Q ‰Q …ÀuìÃÌÌÌÌÌÌÌÌU‹ìƒìHƒ=DŞÊ t"‹EPM¸Qè”÷ÿÿ‹DŞÊƒÄPÁ€  è_øÿÿ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìƒì‹E‹‹P‰Mô‹DŞÊS‹Y‰Uø…Û„Q  óEVWë‹E‹PóUôóMø‹ó‹[@;V…  ƒ~4 ¡DŞÊŠHPˆMü…
  ƒ~$ „   (Úó\Øj Uäó]ä(ÙR~ó\ØóXĞóXÈWó]èóUìóMğèÊs| ƒÄ…À„·   óóMøó\NóvóFó\vfnn(óà=“‹Eüfnf,[íó\Ãó^ĞóEôó^ÎóYÍómäó\ëóYêó\Ã[äóYÂó ˆ|PóYÄóYìƒìó\èTêól$óD$ó$Vè;ÓÿÿƒÄ‹Æè¡Öÿÿ.à=“ŸöÄDzÇF4   èXİÿÿóE…Û…»şÿÿ_^[‹å]ÃÌÌÌÌU‹ì‹‹Mˆ]Â ÌU‹ì‹U¶Â5ÅiÀ“ V¶ö3Æ¶u
iÀ“ 3Æ¶uiÀ“ 3ÆiÀ“ #‹I‹3ö…Àt9Pt%‹ğ‹ …Àuójh  hpà{j è¸³z ƒÄjè~K{ …öu
‹U‰^]Â ‹E‰^]Â ÌÌÌÌÌÌU‹ì‹U¶Â5ÅiÀ“ V¶ö3Æ¶u
iÀ“ 3Æ¶uiÀ“ 3Æ‹uiÀ“ #‰‹I‹^…Àt›    9Pt‹ …Àuõ3À]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìy(ğ`tjhß   hpà{j è³z ƒÄjèÇJ{ ‹E‰A ÇA$    ]Â ÌÌÌÌÌÌU‹ì‹ES‹ÙV‰C{(ğ`W<…    tjh  hpà{j è¯²z ƒÄjèuJ{ ;{t‹CWPKèÓºßÿ‰CÇC    ‰{‹C_^‰ÇC    []Â ÌÌÌU‹ìjÿhAW^d¡    Pd‰%    ƒìV3öèÍÑßÿ‰Eğ;Æt"‰Eì‰uü‰p<‰p@ÇEüÿÿÿÿ^‹Môd‰    ‹å]Ã‹Mô‹Æ^d‰    ‹å]ÃÌÌÌU‹ì]é·ßÿÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhaW^d¡    Pd‰%    ƒìV3öèMÑßÿ‰Eğ;Æt#‰Eì‰uüƒÉÿ‰H‰H‰0‰Mü^‹Môd‰    ‹å]Ã‹Mô‹Æ^d‰    ‹å]ÃÌÌU‹ì]é7ßÿÌÌÌÌÌÌÌU‹ìjÿh–W^d¡    Pd‰%    ƒìSVW‹ù‰}ğ3Û‰]üw‰uìÆEü‹Îè×¸ßÿÆEü‰^‰^ˆ]ü‰‰^ÇEüÿÿÿÿ‹Mô‰‰__^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌU‹ìjÿhÆW^d¡    Pd‰%    ƒì‹Á3ÉS‰Eğ‰‰H‰MüP‰Uì‰
‰JÆEü‰J‰J»   ˆ]ü‰
‰J‰JÇB ‰J‰JÇBğ`ÆEü‰‰H‰HÇEüÿÿÿÿ‹Mô[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ì‹UV¶òöÅiö“ W¶ş3÷¶}
iö“ 3÷¶}iö“ ‹A3÷iö“ #1_‹°^…Àt9Pt‹ …Àuõ3À]Â ‹MƒÀPè»òÿÿ¸   ]Â ÌÌU‹ìjÿháW^d¡    Pd‰%    ƒìVW‹ù‹O3öègÏßÿ‰Eğ;Æt‰Eì‰uü‰p<‰p@ÇEüÿÿÿÿ‹ğ‹E‹‰‹P‰V‹H‰N‹P‰VÙ@Ù^Ù@Ù^Ù@Ù^Ù@Ù^‹H ‰N ‹P$‰V$‹H(‰N(‹P,‰V,‹H0‰N0‹P4‹Mô‰V4‹@8‰F8ÿG_‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìÿI‹I]éñ~ßÿÌU‹ì‹Axğ`tjhT  hpà{j è¯z ƒÄjèäF{ ‹U‰Py8ğ`t	jhß   ëÒ‰Q0ÇA4    ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹Q‹EV;Âs‹q†ƒ9 u@ƒÁ;Âró3À^]Â ‹†^]Â U‹ìjÿhX^d¡    Pd‰%    ƒìVW‹ù‹O3öèÎßÿ‰Eğ;Æt‰Eì‰uüƒÉÿ‰H‰H‰0‰Mü‹ğ‹M‹EQN‰FèøğÿÿÿG‹Mô_‹Æ^d‰    ‹å]Â ÌU‹ì‹EV‹ñ‹NPèŞ}ßÿÿN^]Â ÌÌÌÌÌÌU‹ì]é7ûÿÿÌÌÌÌÌÌÌé[€ßÿÌÌÌÌÌÌÌÌÌÌÌ‹AH‰ÃÌÌÌÌÌÌÌÌÌé;€ßÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh>X^d¡    Pd‰%    ƒì‹Á3ÉS‰Eğ‰‰H‰MüP‰Uì‰
‰JÆEü‰J‰J»   ˆ]ü‰
‰J‰JÇB ‰J‰JÇBğ`ÆEü‰‰H‰HÇEüÿÿÿÿ‹Mô[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ìjÿh~X^d¡    Pd‰%    ƒìSVW‹ù‰}ğ3Û‰]üSèBúÿÿÇEü   w‰uìÆEü‹Îèš´ßÿÆEü‰^‰^ÆEü‰‰^ÇEüÿÿÿÿ‹Mô‰‰__^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ì‹UV¶òöÅiö“ W¶ş3÷¶}
iö“ 3÷¶}iö“ ‹A3÷iö“ #1_‹°^…Àt9Pt‹ …Àuõ3À]Â ‹MƒÀPèïÿÿ¸   ]Â ÌÌU‹ì‹EV‹p3ÒW;òt49Pt%‹x‹Ö‰z‹P‹x‰zÿI‹IPèİ{ßÿ_‹Æ^]Â ‹ş‰W‹Pë(9Pt ‹x‰W‹PÿI‰Q‹IPè®{ßÿ_‹Æ^]Â ‰QÿI‰‹IPè•{ßÿ_‹Æ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EVP‹ñè±ûÿÿ3Ò‰P@‰P<‹N;Êt‰A@‹N‰H<‰F^]Â ‰‰F^]Â ÌÌÌÌÌÌÌU‹ì‹EV‹p@3ÒW;òt49P<t%‹x<‹Ö‰z<‹P<‹x@‰z@ÿI‹IPè{ßÿ_‹Æ^]Â ‹ş‰W<‹P@ë(9P<t ‹x<‰W@‹P<ÿI‰Q‹IPèŞzßÿ_‹Æ^]Â ‰QÿI‰‹IPèÅzßÿ_‹Æ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh¡X^Pd‰%    ƒìV‹ñ‹M¶Á5ÅiÀ“ ¶Õ3Â¶U
iÀ“ 3Â¶UiÀ“ 3ÂiÀ“ W‹>#ø‹F‹¸…Àt9Htd‹ …Àuõ‹NS3Ûè	Êßÿ‰Eğ…Àt‰Eì‰]üƒÉÿ‰H‰H‰‰Mü‹Ø‹M‹EQK‰Cèúìÿÿ‹VÿF‹º‰‹N‰¹[_^‹Môd‰    ‹å]Â ‹URHèÊìÿÿ‹Mô_^d‰    ‹å]Â ÌÌÌÌÌÌÌÌU‹ìV‹ñ‹M¶ÑòÅiÒ“ W¶ı3×¶}
iÒ“ 3×¶}iÒ“ ‹F3×iÒ“ #‹…Àt9Ht%‹ …Àuõ3ÿ‹RQ‹Îèõÿÿ‹NWèWyßÿÿN_^]Â ‹øëßÌÌÌÌÌÌÌÌÌÌ3À9At‹QV…Òt‹q‹Îƒ9 u@ƒÁ;Âró3À^Ã‹†^ÃÌÌÌÌÌÌU‹ì‹ES‹]VW‹8‹ñ‹OW‰‹MRèßëÿÿ‹?…ÿt‹E‰8_^[]Â ‹¶Á5ÅiÀ“ ‰M¶Í3Á¶MiÀ“ 3Á¶MiÀ“ 3Á‹NiÀ“ #@;Ás‹v†¤$    ƒ: u@ƒÂ;Áró‹U_3À^‰[]Â ‹†‹U_^‰[]Â ÌÌÌÌÌÌ‹‹B@‰…ÀuÿI‰A‹IRèFxßÿÃÇ@<    ÿI‹IRè2xßÿÃÌéËzßÿÌÌÌÌÌÌÌÌÌÌÌU‹ì‹ESVWP‹ÙèO°{ ‹ğƒÄƒş}¾   VKègõÿÿ3À…ö~‹KÇ    @;Æ|ñ‹S_J^‰[]Â ÌÌÌÌU‹ìV‹ñ‹N…Éu<W‹}WNè&õÿÿ‹Fxğ`tjh  hpà{j èç§z ƒÄjè­?{ ‰x‹Ï_3À…É~‹VÇ‚    @;Á|ñI‰ÇF    ^]Â ÌÌéûyßÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhæX^d¡    Pd‰%    ƒì‹Á3ÉV‰Eğ‰‰H‰MüP‰Uì‰
‰JÆEü‰J‰JÆEü‰
‰J‰JÇB ‰J‰JÇBğ`ÆEü‰‰H‰HÇEü   Ç@0   ÇEüÿÿÿÿ‹Mô^d‰    ‹å]ÃU‹ìjÿh&Y^d¡    Pd‰%    ƒìSVW‹ù‰}ğÇEü   3ÛSèşóÿÿÇEü   w‰uìÆEü‹ÎèV®ßÿÆEü‰^‰^ÆEü‰‰^ÇEüÿÿÿÿ‹Mô‰‰__^[d‰    ‹å]ÃÌÌÌÌÌÌU‹ìVW‹ñè$´êÿ‹}9GueèGµéÿƒøÿt[‹Ä+Õ‹‰8	  …ÉtKPèìÄäÿ…ÀtAóGóó\€¬   ó\ˆ¨   óP  ó†T  Ù†P  ÙX  Ù†T  Ù\  _^]Â ÌU‹ìƒìDVW‹}‹‹ñƒøÿ„   ‰EğEìjPÇEì,   è“ ƒÄ…À„   he  èn]R ƒÄ9thh  è]]R ƒÄ9t3ÿë¿   èØwáÿƒx< u
öE„À  S‹]S‹Îè\Àÿÿ…Àu,‹M$‹U ‹EóEQ‹MRPQQó$S‹ÎèUÜÿÿ[_^‹å]Â$ ‹E‹ ¬¯óà=“Ñèƒà€Ëÿ‰Uü‰Eğ…ÿ„   ÿ†Ì  ¡Ä+Õ‹H¸‰ˆˆˆ÷áÁê‹ÂÁà+ÂÀÀ+È‰MôÛEôyØ˜=“öEØH"}ÙUôØˆcóEôóYüˆ|óXÃóY¤Ò|Ù]øó,Øu!jj h»  è_\R ƒÄPh §Æ¹`ÛÊè|åşÿó]ø¶`  óYğœ|‹Eó óH¶Ó¯ÊiÉ (ÓóY8=“ó\Âó\ÊÁéóEÜóMà3Ûƒ¾p  ÿóXÃóXËˆMÿóEäóMè„Œ   0  èY| Ù]ô0  èƒY| Ù]øóà=“ó]Üó\0  óUàó\–4  (Áó^Eôó^MøóYØóYÑó]Ìó]äó\0  óUĞóUèó\–4  óYØóYÑó]ÔóUØ]Ì3ÿöEt‹E PèºèÿPè)ÜäÿƒÄ‹øj j M¼QUÜRècìÿƒÄ…ÿtP‹†p  ó‡°  óXE(óYüˆ|jÿj SP‹EQó$óEj Qó$h(¬¯MüQ‹MU¼RPQè>˜ëÿë5‹–p  óEj jÿj SR‹Uj Qó$h(¬¯EüP‹EM¼QRPèW•ëÿ‹Mğ‹U$‹E ƒÄ0Q‹MR‹UPQR‹Îè™»ÿÿ[_^‹å]Â$ ƒşÿtV¡ø[ÖPÿ‚{‹‹‹€8  …Àt<‹VèÉÀäÿ…Àt0‹Èèş,^ …Àt%Vèt¹èÿƒÄƒøÿt‹Ä+Õ‹‰8	  …ÉtPèÁäÿÃ3ÀÃÌÌU‹ìjÿh@Y^d¡    Pd‰%    ƒìd¡DŞÊö@`SVW‰MØ…‡  j jhœ  èÒYR ƒÄPèÉ+ ƒÄ‰EĞè±éÿ‹ğƒËÿ;ó„X  ‹ø[ÖQÿ‚{‹‹‹€8  …À„9  ‹Vè
Àäÿ…À„)  MQ‹ÈèçQ^ ó óE¬ó@óE°è°éÿ‹¡DŞÊ‹ ‹ ‰Uä…À„ğ  ë¤$    ‹EèƒËÿ‹H‹ P‰Mèè|˜^ ‹ğƒÄ‰uÔ;ó„¹  ‹ø[ÖRÿ‚{‹ ‹ ‹€8  …À„š  ‹Vèu¿äÿ‹ø…ÿ„ˆ  ‹Ïè$.^ …À…y  MQ‹ÏèAQ^ ‹U9Uœ…b  Q‹Ä‹Ï‰eàÇ 3ôÿÿè¢PY …Àu2ö‡„   €u)Q‹Ä‹ÏÇ ®ñÿÿè…PY …Àu‹EäPWè'ÆÿÿƒÄ…À„  ‹QèuW ƒÄ…À…  ‹Ïè2+^ …À…÷  ‹‡   ‹°¼Öj Pè&äQ ‹ğ‰uğÇEü    ‹F`h  Pè¬LU j Pèô q ƒÄ…Àu‰]ü‹°¼ÖUìR‰uìèHUQ é   ‹‡Œ   PèçØäÿ‹ğƒÄ…öu‰]üé{  VWèï»ÿÿƒÄ…Àt‰]üée  ‹Œ   h` h    SQèSêp Ù]ì‹–Œ   h` h  SRè9êp Ù]àÙèdóE¬óM°ÙEìó\M”ó\EƒÄ óYÉóYÀóXÈßñİØóMÜvóEìóYÀ/Á‡Û  óEà/èdvóYÀ/È‡À  ‹†Œ   h` h  SPè»êp ƒÄ…ÀtoMQè›äÿÿƒÄM‰EàèıÁÿÿ…ÀuT‹–Œ   h` h  SRè‚ép Ù]ìƒÄƒ}à „`  óEìóYÀ/EÜ†M  ó0/}QEó$PèXéÿÿƒÄMÈVQè	+ ƒÈÿƒÄ9EÈu‰Eüé  è³ÉO …ÀtWèÉßÿÿƒÄ‰EÈWèİÃÿÿƒÄ…Àt,‹Ïè)^ …Àt!jj h¼  èMVR ƒÄPh §Æ¹`ÛÊèjßşÿU VRèĞ	+ ÆEü‹†Œ   h` h  SPèµép ÷ØöƒÄ‹Ä‹ÏF‰eàÇ 5ôÿÿèëMY …Àt3öWèj^ ƒÄ…Àu…öt¿   ë3ÿóE‹uØM¸QUÀóEÀóE”R‹ÎóEÄèºÿÿWÀ‹EÔ‹UQó$ó‹UĞhÿ   PM QWQó$E¸PMÈQR‹ÎèÎ÷ÿÿÆEü M è‚
{ ÇEüÿÿÿÿMğèCiäÿƒ}è …üÿÿ‹Mô_^d‰    [‹å]Â ÌÌÌÌÌÌU‹ìjÿhXY^d¡    Pd‰%    ƒì4¡DŞÊö@`‰Mè…á  Vj jhœ  èUR ƒÄPèû+ ƒÄ‰Eäèp¦W ‹ğ‰uì…ö„°  SWë‹uìVè¦ÓéÿƒÄ…À„‚  ‹Fƒøÿ„v  ‹Ä+Õ‹‰8	  …É„b  Pè•»äÿ‹ø…ÿ„R  ‹ø[Ö‹·ˆ   Qÿ‚{‹‹‹€8  ‹ŠŠd  ó\c·Ş‹óÓî‹Šd  ¸   Óà‹Š   ‹4±óEğH#ÃiÀø  ğè,ªêÿPèVÀh ƒÄ…ÀtólŞÊóY8=“ó\ eóEğj
è»ÆO ƒÄ…Àt‹Îèİ+^ ƒøuóhŞÊóEğUÜRƒËÿhìdj‰]Ü‰]àèrÆ ‹uèó‡¨   ó¬   ƒÄEÌPMÔQ‹ÎóEÔóMØèó·ÿÿMÀèK { ÇEü   óEğ‹—ˆ   Qó$hÿ   REÀPjQ‹Mó‹Mäó$UÌREÜPQ‹Îè§õÿÿ‰]üMÀè\{ ‹uìVèã¥W ƒÄ‰Eì…À…Vşÿÿ_[^‹Môd‰    ‹å]Â ÌÌU‹ìd¡    jÿhxY^Pd‰%    ¡DŞÊƒì4ö@`S‹Ù…Á  Vj jhœ  èäRR ƒÄPèÛ
+ ƒÄ‰Eäè ªéÿ‹ğ‰uìƒşÿ„  WVèë‹åÿƒÄ‰EèÇEğ    ë‹uì‹MğQVèOsW ƒÄ‹ğè%øÿÿ‹ø…ÿ„G  ‹Uğ‹EìRPè~sW ‹ğƒÄƒş„,  ƒş„#  ƒş„  ƒş„  ƒş„  ƒş„ÿ   ƒş„ö   ƒş„í   ƒş„ä   ƒş„Û   ƒş„Ò   ƒş„É   ƒş„À   ƒş„·   ‹Mèè#S^ …Àtƒş„¢   …ö„š   MÜQƒÎÿhej‰uÜ‰uàèeÄ ó‡¨   ó¬   ƒÄUÌREÔP‹ËóEÔóMØèéµÿÿMÀèAşz ÇEü   WÀ‹EQ‹ˆ   ó$ó ‹Eähÿ   QUÀRj Qó$MÌQUÜRP‹ËèŸóÿÿ‰uüMÀèT{ ‹Eğ@‰Eğƒø@Œˆşÿÿ_^‹Mô[d‰    ‹å]Â ÌU‹ìjÿh˜Y^d¡    Pd‰%    ƒìd¡DŞÊö@` ‰MÜ…º  Vè=¨éÿ‹ğƒşÿt6‹ø[ÖQÿ‚{‹‹‹€8  …Àt‹VèC·äÿ…Àt‹ÈèèQ^ …À…v  Wè9Q j jhœ  ‰EØè™PR ƒÄPè+ ƒÄ‰EÔèõmW ‹ø…ÿ„@  SWèDÏéÿƒÄ…À…  ‹‡    3ÛP‰]äèÈp ƒÄ…Àt"ó@‹P(‹HóE ó@óE¤‰M¬‰Uä‹ÚöÃ…×  „Ûyè­¦éÿP‹G<PèÃ\ ƒÄ…À„¹  ‹wƒşÿu	ÇEğ    ëe‹ø[ÖQÿ‚{‹‹‹€8  …Àu‰EğëE‹VèO¶äÿ‰Eğ…Àt6‹uğEP‹Îè*H^ ‹Hó óE ó@‰M¬‹ÎóE¤èzE^ …À…C  ‹U¬;U…7  Áëƒãè¹éÿ‹@<‹O<PQè\ ‹ğ÷ŞöƒÈÿWF‰EÌ‰EĞÇEì   ÇEè    èêêÿƒÄ…ÀtÇEè   ÇEì  ë;Wè-êÿƒÄ…ÀtÇEè   ÇEì‘   ë‹Mğ…ÉtèjN^ …ÀtÇEè   ÇEìQ   óèd/‡@–  ‡Œ   öEä…‚   ‹Mğ…Étè!^ …Àu‹MğèñO^ …ÀtfWèg9Q ƒÄ…Àt‹Eè‹…pcUÌRQjè:Á ƒÄƒMì ë_…ÛuUÌR…öu‹Eè‹…`cQë<hTeë5…öuEÌPhHeë&MÌQh,eëö‡¨   t	èyÁO …ÀtUÌRhejèÕÀ ƒÄóE ‹]ÜE¼PMÄóEÄóE¤Q‹ËóEÈè\²ÿÿ‹uØ;·t—  ÆEàÿÒ÷ÚtM‹—p—  ;òvC‹‡t—  ‹È+Ê+Æ‰EäÛEäyØ˜=“‰MäÛEä…ÉyØ˜=“ŞùÙ]äóEäóY¤Ò|ó,ÀˆEàj M°WQèPêÿÇEü   WÀ‹Uà‹GƒÄó$R‹UìP‹Eó ‹EÔM°QRQó$M¼QUÌRP‹Ëè®ïÿÿÇEüÿÿÿÿM°è_{ WèùjW ‹øƒÄ…ÿ…Âüÿÿ[_^‹Môd‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìjÿh¸Y^d¡    Pd‰%    ƒì@¡DŞÊö@`‰Mì…Š  Vj jhœ  èäLR ƒÄPèÛ+ ƒÄ‰Eèè ¤éÿ‹ğƒşÿ„[  ‹ø[ÖQÿ‚{‹‹‹€8  …À„<  ‹Vè³äÿ…À„,  MÀQ‹ÈèûD^ ó óE´ó@óE¸èj ‹0…ö„ÿ  SWëëI ‹uğ‹‹VlP‰UğèŸgW ƒÄ…À…Î  ‹QèŒ‹^ ‹øƒÄƒÿÿt+‹ø[ÖRÿ‚{‹ ‹ ‹€8  …Àt‹Wè²äÿ…À…‘  ƒ~,ÿ„‡  ‹F$…À~ƒøw  ƒø	„n  ‹M9N…b  ‹F(¨…W  óE´ó\FóM¸ó\Nóèd^óYÀóYÉóXÈóF</Âv	/Á‡  óF@/Âv	/È‡  ¨ t©   uSèûØÿÿƒÄ‹Ëèa¶ÿÿ…À„ã   ¶~(ó‹]ìóNUĞREØÁïP‹ËƒçóEØóMÜèz¯ÿÿMÄèÒ÷z ÇEü    ‹F8ƒøÿt"‹V4MÄQPRè%3R ƒÄ…Àuhpà{MÄèQ
{ ‹F,‰Eà‹N0‰Mäè¾O …Àt‹Fƒøÿt‹V$PRè*ÓÿÿƒÄ‰EàWÀ‹Qó$hÿ   Pèş‰^ ‹Uó‹UèƒÄPMÄQWQó$EĞPMàQR‹ËèÕìÿÿÇEüÿÿÿÿMÄè†ÿz ƒ}ğ …şÿÿ_[^‹Môd‰    ‹å]Â ÌÌÌÌÌÌÌÌÌU‹ìQVW‰Mü3ÿè°gW ‹ğ…öt`S‹]›    VèúÈéÿƒÄ…ÀuG;ûtVèÈgW ‹ğƒÄ…öuß[_^‹å]Â ‹†    Pèjj ‹ğƒÄ…ötèìŸêÿ9Fu‹MüƒÆVè«ëÿÿ[_^‹å]Â ÌÌU‹ì‹E‹Jƒú‡;  ¶’øq¯ ÿ$•Ôq¯ ö 
  „   ÙP  PÙ™X  ÙT  Ù™\  ‹‹‚„   ÿĞ¸   ]Â ö 
  „ç   ‹‹‚ˆ   ÿĞ¸   ]Â èbü j jÿjÿè éÿPèá‰éÿƒÄ¸   ]Â ö 
  „¥   ‹@ƒøuèk©ÿÿ¸   ]Â ƒøujè¶şÿÿ¸   ]Â ƒøujè¡şÿÿ¸   ]Â ƒøu`jèŒşÿÿ¸   ]Â ö   tG‹P‹‚Œ   ÿĞ…Àt8¸   ]Â ö 
  t&‹@,ƒøtƒøuóà=“ól  ¸   ]Â 3À]Â q¯ }q¯  p¯ Ùp¯ Ğp¯ ùp¯ Íq¯ q¯ Íq¯   ÌÌÌÌÌÌÌÌÌÌÌU‹ììœ   VW‹=DŞÊ‹ñèHŸéÿƒøÿt‹Ä+Õ‹‰8	  …Ét
Pèí®äÿ…Àu_3À^‹å]Ãóˆ¨   ó†P  óXÁóEôó†T  óX€¬   óEøèN¯O ƒøtƒøt
ƒøtƒøu=‹G‰Eü…Àt3ÛEü‹OÙúÙ]üè=E| ØMüOØ8=“Ù]ôè9E| ØMüØ8=“Ù]øó~€ª¯óMô¡ ª¯óEøW‡|W‡|fÖUĞó~ˆª¯fÖUØó~ª¯fÖUàó~˜ª¯fÖUè‰EğóMèóEìèê´ÿÿóEøèÔ> óEüóEøèÑ> ó~€ª¯ó~5ª¯ó~%ˆª¯ó~˜ª¯ó¾l  óY¾d  ó-à=“¡ ª¯fÖ]¬fÖ]ˆó~˜ª¯fÖu¼ó^ïfÖu˜óuĞfÖMÄóMüW‡|óUÈóYUØfÖ] ó]ÔfÖe´(şóYuüóYøfÖe(ãóYáóXçó}ØóY}ÄóXç(ûóYøóXşóuàóXúóUÀóYÓó]´óY]ĞóXÓ‰EÌó]ÌóY]ØóXÓó•lÿÿÿóUÜóYĞóYñóXòóUäóYUÄóXòóUà‰E¨óµpÿÿÿóYĞóYMìóUøó]øóUÜóYUüóXÚóUäóYUÈó]øóXÚóUÜóYU´óUøóUàóYUÀótÿÿÿó]øóXÚóUäóYUÌóXÚ(ĞóYUèóYEìóXÊóUğóYUÄóXÊó|ÿÿÿóMüóYMèóXÁóMğ(ÑóYUÈóYMÌóXÂóU´óYUèóE€óEÀóYEìóXÂóU”óXÁólÿÿÿóE„(ÄóYÅóxÿÿÿóY×óXĞóE óYÁóXĞóEŒóYÄ(ßóYİóXÃó]¤óYÙóXÃó]œóYßó}óYüóe¨óYáóM”óYtÿÿÿóXßóXÜ(æóYåóXÌóe óY¥xÿÿÿóXÌóeŒóYæóµtÿÿÿóYõóXæóu¤óYµxÿÿÿóXæóuœóYµtÿÿÿóuüóuóYµpÿÿÿó}üóXşóu¨óYµxÿÿÿóXşóu”óYu€ó}äó½|ÿÿÿóYıóX÷óuüóu óYu„ó}üóXşóuŒóYµ|ÿÿÿó}èó}€óYıóm¤óYm„óX÷óXõómœóYm€óuìóuóYµ|ÿÿÿóXîóu¨óYu„óXîómğ(èóY-°ª¯(òóY5¤ª¯óXî(óóY5¼ª¯óXî(ğóY5´ª¯óm¬(êóY-¨ª¯óY¬ª¯óXõó-Àª¯(ûóYÄª¯óYıóX÷óu°ó5¸ª¯óYÆóXÂóXÃóE´(ÔóY°ª¯(ÁóY¤ª¯óXĞóEä(ØóY¼ª¯óXÓóU¸(ÜóY´ª¯(ÑóY¨ª¯óY¬ª¯óXÓ(ØóYÄª¯óYİóXÓóYæóXÌóXÈóEèóU¼(ĞóY¤ª¯óMÀóMì(ÙóY°ª¯óXÚóUğ(âóY%¼ª¯óXÜó]Ä(ØóY¬ª¯óY¨ª¯(áóY%´ª¯óXÜ(âóYÄª¯x  óYÎóXÁóXÂóEÌó~E¬‹UÌfÖó~E´fÖAó~E¼óYåfÖAóXÜó]Èó~EÄE¬fÖAP‰Q è¸¸ÿÿó~ fÖ†œ  ó~@fÖ†¤  ó~@fÖ†¬  ó~@fÖ†´  ‹H _‰¼  ¸   ^‹å]ÃÌU‹ìS‹]‹ƒè VW‹}‹ñtHuWèR÷ÿÿ…Àt_^[]Â èÒ²ÿÿWS‹Îèyêëÿ_^[]Â ÌÌU‹ìd¡    jÿhàZ^Pd‰%    ì¨  SVWè*˜éÿƒËÿ;Ã„Î   èú—éÿPè„Ø ƒÄ‹ğèj)Q …Àt9;ót5‹ \Öj Vè„ÌQ ‰EìÇEü    ‹H;ËEñ‰]ü‹ \Ö‰EğEğPè½=Q ‹DŞÊ9qDtw9qHtr‰qHM¼VQè:S ÇEü   ‹DŞÊ‹BDPMÔQèö9S ƒÄÆEüUÔRM¼è£íz …Àu¡DŞÊÇ@L    ë	‹DŞÊ‰qDÆEüMÔèõz ‰]üM¼èõz ‹DŞÊ‹ALƒè t@Hu‹Ä+Õ‹BÛB…ÀyØ˜=“Ø4s­ØA@ÙQ@ÙèÙÉßñİØrSóà=“ÇAL   ë=‹Ä+Õ‹BÛB…ÀyØ˜=“Ø4s­Øi@ÙQ@ÙîßñİØr‹QHWÀ‰QD‰YHÇAL   óA@è¼–éÿ‹ø‰}ì;û„J  M°èìz ÇEü   ¡DŞÊ‹@D;Ãt&PMàQèê8S ƒÄÆEüPM°èêõz ÆEüMàè.ôz ‹ø[ÖRÿ‚{‹ ‹ ‹€8  …À„Ï   ‹Wèw¥äÿ‹ğ…ö„½   Vè§R^ ƒÄ…À„¬   MQ‹ÎèA7^ ‹PRèhªh ƒÄj j jPèi«h ƒÄPEÔPèÌ¡z ƒÄÆEühÈ
hŠ  è–>R ƒÄPMÈQèi#R ƒÄ‹ğ³ˆ]üj MÔèuéz P‹Îèméz PUàRèƒR ƒÄÆEüPM°èõz ˆ]üMàèXóz ÆEüMÈèLóz ÆEüMÔè@óz hğ¢ÆèàÿƒÄhpŞÊM°‹ğè4ëz …Àu1‹PM°èõèz P‹ƒ   ‹ÎÿĞh€   M°èíèz PhpŞÊèÂhÑÿƒÄ¡DŞÊ‹   óH@óY¤Ò|‰Mğó,ÑˆUó‹Mğ‰   óH@‹–$  óY¤Ò|‰Uğó,ÁˆEó‹MğhèŞµ‰$  ètàÿ‹Ø‹‹B$ƒÄj‹ËÿĞÆ…¼ıÿÿ èøWáÿƒx@ tPh€   3É•ŒşÿÿRQQjh   f‰Œşÿÿÿğƒ{…Àt(j j jÿ…ŒşÿÿP¼ıÿÿh€   QèlpÑÿƒÄÆ…;şÿÿ M¼èºéz ÆEüè±¬O ‹DŞÊ9Bd„  è¬O ‹DŞÊ‰AdèÿQêÿ‹@‹ph   •@şÿÿj RÇ…<şÿÿ    è\+ ƒÄÔşÿÿè~s ÆEü
3À‰…|ÿÿÿ‰E„ÆEü‹‹P<şÿÿQ‹ÎÿÒ‹‹P‹ÎÿÒ…À…f  ìşÿÿèoçz PMÈèöz ÆEüƒì‹ÄMÈ‰eğQPè hj ƒÄÆEü•ÜşÿÿREÔPÆEüèÅEO ƒÄÆEüMÈè6ñz MÔjQèkışÿ‹DŞÊ‹BdPM”Qèh— ƒÄ‹ğÆEüheh¤  èğ;R ƒÄPUÈRèÃ R ƒÄ‹øÆEüj ‹ÎèÑæz PMÔèÈæz P‹Ïè°æz PEàPèÖR ƒÄÆEüMÈè·ğz ÆEüM”è«ğz j ƒìP‰eğ‹ÌèŒåÿÆEüƒì‹Ì‰eŒè+èz ÆEüƒìUà‹Ì‰e RèVèz ÆEüÆEüLıÿÿèCsæÿÆEü…Lıÿÿj PèñsßÿƒÄÆEüLıÿÿèosßÿÆEüMàè3ğz ÆEüMÔè'ğz ‹}ìÆEüÔşÿÿ‰M Ç…ÔşÿÿÀû|ÆEüÿÿÿèşïz ÆEüìşÿÿèïïz M¤è‡çz ÆEü‹DŞÊ‹BdPM”Qè – ƒÄ‹ğÆEüèò«O P‹Îèªåz PU¤h„eRèëïz ƒÄÆEüM”èœïz ¡ø[ÖPÿ‚{‹‹‹€8  …À„ê   ‹Wèæ äÿ‹ø…ÿ„Ø   WèN^ ƒÄ…À„­   j j jWè_N^ ƒÄPUàRèRz ƒÄÆEühlehŠ  è:R ƒÄPEÈPèïR ƒÄ‹ğÆEü j Màèüäz P‹Îèôäz PM”Qè
R ƒÄÆEü!PM¤èšğz ÆEü M”èŞîz ÆEüMÈèÒîz èMTáÿƒx@ thheM¤èzûz ÆEüMàè®îz WèˆM^ ƒÄ…Àthpà{M¤èäøz M¤èläz PM¼èCûz •¼ıÿÿRM¼è4ûz ‹3j M¼èXäz P‹†   ‹ËÿĞ‹DŞÊÁ  èLü* ÆEüM¤è@îz ÆEüM¼è4îz ÇEüÿÿÿÿM°è%îz ‹Mô_^d‰    [‹å]ÃÌÌÌÌU‹ìjÿhøZ^d¡    Pd‰%    ƒìèĞ«O Ù]ğè¬O …À„”   Vèéÿ‹ğƒşÿ„‚   ¡ø[ÖPÿ‚{‹‹‹€8  …Àth‹VèŸäÿ…Àt\‹ÈèÂ0^ Pè,¤h ƒÄƒøÿtG‹˜´Ûj PèVÄQ ‰EìÇEü    ó€´   /cvóEğÇEüÿÿÿÿ‹˜´ÛUìR‰Eìè}5Q ^‹MôÙEğd‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìQV‹ñèÿÿÿÙUüÙ–h  Ø¦d  ÙáÙôœ|ÙÉßñİØv*ó†d  óMüó\ÈóY„cóXÈód  ^‹å]ÃóEüó†d  ^‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìƒì W‹}…ÿ„*  ¡DŞÊƒ¸Œ  ÿ„  S˜€  è€êÿ9C…  Vh-ÇèÜàÿ‹ğƒÄ‹Îè0ïÿÿEğP‹ÏèÅ/^ MèQP‹Îè™›ÿÿUøRS‹Îè›ÿÿóEøó\EèóMüó\MìƒìóD$ó$èÆŠ{ Ù]èşiêÿƒÀ$Pè‚{ ƒÄ‰EüÛEü…ÀyØ˜=“Ø cEàP‹ÏØ%8=“Ø¨eØEÙ]è?/^ ‹DŞÊÙ ‹‘  ’Ùœ‘È  ”‘È  Ù@¾   ÙZÙ@ÙZ‹@ÙE‰B‹  €Ùœ‘Ø  ‹  @™÷ş^‰‘  [_‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì]éWÒÿÿÌÌÌÌÌÌÌU‹ì‹EVP‹ñè‘Îÿÿ3Ò‰P@‰P<‹N;Êt‰A@‹N‰H<‰F^]Â ‰‰F^]Â ÌÌÌÌÌÌÌU‹ì]é×ÒÿÿÌÌÌÌÌÌÌU‹ì]éWÓÿÿÌÌÌÌÌÌÌU‹ì]é7ÔÿÿÌÌÌÌÌÌÌ3À9At‹QV…Òt‹q‹Îƒ9 u@ƒÁ;Âró3À^Ã‹†^ÃÌÌÌÌÌÌU‹ì]é§ÔÿÿÌÌÌÌÌÌÌVW‹ñ3ÿ9~t)ëI ‹‹A@‰;Çu‰~ë‰x<ÿNQ‹NèMßÿ9~uÜ_^ÃÌÌÌÌÌÌÌÌÌU‹ìjÿh[^d¡    Pd‰%    Q‹Á3ÉP‰‰H‰H‰HV‰EğÇB
   ÇD   ‰J‰JÇB  ‰JÇBğ`‰Mü‰PÇEüÿÿÿÿ‹Mô^d‰    ‹å]ÃÌU‹ìjÿh;[^d¡    Pd‰%    QV‹ñ‰uğÇEü    è%ÿÿÿÇEüÿÿÿÿNèfOßÿ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌU‹ìƒìPV‹ñ3ÀW9Ft"‹V…Òt‹~‹ÏI ƒ9 …›   @ƒÁ;Ârï3À‰Eø…À„€   ‹ÿE°PMüQUøR‹ÎèMÓÿÿ‹Mü¶ÑòÅiÒ“ ¶ı3×¶}şiÒ“ 3×¶}ÿiÒ“ ‹F3×iÒ“ #‹…Àt9Ht3‹ …Àuõ3ÿ‹RQ‹Îè4Èÿÿ‹NWèûKßÿÿNƒ}ø u‚_^‹å]Ã‹‡égÿÿÿ‹øëÑU‹ìjÿh[[^d¡    Pd‰%    QV‹ñN‰uğèiÔÿÿ3À‰Eü‰F‰‰FÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]ÃÌÌÌÌU‹ìjÿh±[^d¡    Pd‰%    ƒìSVW‰MğÇEüÿÿÿÿy‰}ğÇEü   3ÛS‹ÏèÁÈÿÿÇEü   w‰uìÆEü‹ÎèƒßÿÆEü‰^‰^ÆEü‰‰^ÇEüÿÿÿÿ‹Mô‰‰__^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìV‹ñ‹‹ˆ   Ç†t      ÿÒ‹ÎèÏùÿÿÙ–h  ‹EÙd  óà=“ó†l  …Àt+WÀó†P  ó†T  Ù†P  ÙX  Ù†T  Ù\  Ç† 
     …Àt
Ç† 
     ¶† 
  Ñèƒàh  Ç†È      ‰†
  èC2R ‰†p  ‹E(
  ƒÄ^;ÈtPR‹P‹ RPèlçâÿ]Â ÌÌÌÌÌÌÌÌU‹ìjÿh\^d¡    Pd‰%    ìø   S3ÛW‰Mğ9]t¡DŞÊ‹H‰Më‹DŞÊ‹B‰E‹};û„\  ƒÈÿV‰…lÿÿÿ‰…pÿÿÿèıˆéÿ‹ğƒşÿ„;  ‹ø[ÖQÿ‚{‹‹‹€8  ;Ã„  ‹Vèû—äÿ‹ğ;ó„
  èœˆéÿPè&É ‰EØƒÄ…8ÿÿÿP‹ÎèÂ)^ ó…8ÿÿÿSóEĞó…<ÿÿÿjhœ  óEÔè+1R ƒÄPè"é* ‰EäƒÄ3À9_t‹W;Óv‹w‹Î9u@ƒÁ;Ârô3À‰Eè;Ã„‰  ë‹†ëîë¤$    ‹}\ÿÿÿQ•XÿÿÿREèP‹ÏèÄÏÿÿ‹M9hÿÿÿ…E  ó\ÿÿÿóEĞó•`ÿÿÿó\ÁóM¬óMÔó\ÊóYÀóYÉóXÈóE/èdóU°óMìv{/Èvv‹E€3ÿƒøÿ„ç  ‹øÜSPè*¼Q ‹ğ‰µTÿÿÿ‰]ü‹EØ;†Ì   t‹U€PRèºa ƒÄ…Àt} PF  v¿   ÇEüÿÿÿÿ‹øÜEÌP‰uÌè<-Q ;û„„  óMìóE”/èdv	/Á‡h  9]ˆtT\ÿÿÿQèW½ÿÿƒÄ\ÿÿÿ‹ğè·šÿÿ…Àu4;ó„;  óE˜/Eì†,  ó0/}Q•\ÿÿÿó$Rè2ÂÿÿƒÄƒ½|ÿÿÿÿt6¡DŞÊ‹ ‹0;ót)‹=‚{I ‹‹vPè¥n^ ƒÄƒøÿt	‹ø[ÖQÿ×;óuàMÀèèÛz ÇEü   ‹tÿÿÿƒùÿ„E  ‹…xÿÿÿƒøÿ„6  QP•ÿÿÿRè…R ƒÄÆEüPMÀèµåz ÆEüÿÿÿèöãz hŠ  èÜ.R ƒÄ9…xÿÿÿ…ğ   ‹…tÿÿÿPèŸh ‹ğƒÄƒşÿ„Ö   èîBa …À„‘   SSjHÿÿÿVQèµ‘z ÆEü‹•xÿÿÿhÈ
R…üşÿÿPèYR ƒÄ ‹ğÆEüSHÿÿÿèdÙz P‹Îè\Ùz P,ÿÿÿQèoûQ ƒÄÆEüPMÀèÿäz ÆEü,ÿÿÿè@ãz ÆEüüşÿÿè1ãz ÆEüHÿÿÿë3Vèÿ`êÿ‹ø   R…ÿÿÿPèªh ƒÄÆEüPMÀè¬äz ÆEüÿÿÿèíâz ‹uğM¤QU¬R‹Îè’ÿÿWÀQó$óE3À9]„hÿ   •ÀjÿMÀQU¤PQ‹Mäó$R…lÿÿÿPQ‹ÎèİÏÿÿ9]œ„  M´3ÿè*Úz ÆEü	èáJW ‹ğ;ó„Ü   ¤$    Vè*¬éÿƒÄ…Àua‹Uœ‹ÓêöÂtUhpà{M´xèWÚz …Àuh¬eM´èöîz S… ÿÿÿVPèÈìéÿƒÄÆEü
‹Èèú×z PM´èÑîz ÆEü	 ÿÿÿèâz VèœJW ‹ğƒÄ;óuƒ;ûtTƒÎÿhh  ‰uÜ‰uàèÌ,R WÀó$óEóXèdhÿ   VM´QjQ‹Mäó$U¤‰EÜREÜPQ‹Mğ‰]àèÛÎÿÿÆEüM´èáz ÇEüÿÿÿÿMÀè€áz 9]è…‡ûÿÿ^‹Mô_[d‰    ‹å]Â ÌÌÌÌU‹ì¡DŞÊö@`V‹ñu-óEW‹}j WQó$èúÿÿóEjWQ‹Îó$èúÿÿ_^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh8\^Pd‰%    ¡DŞÊƒìHS3Û;Ã„  VW‹}ƒÎÿ;şt‹@;Ãt‹ÿ‹ğ‹@@9~„  ;ÃuîƒÎÿ‹EWÀPMQU¼R‰u¬‰u°‰u´‰u¸óE¼óEÀóEÄóEÈ‰uÌ‰]Ğ‰]Ô‰]Ø‰]Ü‰]àèµÁh ƒÄM¼è)| ÙîÙÉßéİØŸöÄD‹†   M¼èğ(| ÙîÙÉßéİØŸöÄD{p‹E‹U‹M‰E´‰uÌREu¬‰]Ü‰M¬‰}°‰]äè+›ÿÿ‹EPMèQè>/S ƒÄ‰]üMèèğÕz Pj,èXrP ‹DŞÊƒÄ‹ÖƒÁR‰E¸èôÿÿÇEüÿÿÿÿMèèÒßz _^[‹Môd‰    ‹å]Ã9]tê9^4uåÇF4   èœÿÿ‹Mô_^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhX\^Pd‰%    ¡DŞÊƒì\S‹X…Û„İ   èéÿPè	Â ƒÉÿƒÄ‰Eì;Á„Á   3ÀV‰M¨‰M¬9Ct‹S…Òt‹s‹Îƒ9 …­   @ƒÁ;Ârï3À‰Eğ…À„ˆ   WM˜QUèREğP‹ËèìÈÿÿ‹u¼ƒşÿta‹øÜj Vè¶µQ ‹ø‰}àÇEü    ‹Eì;‡Ì   tPVèHa ƒÄ…Àt‹M‹EèMÜU˜RP‹ËèüÆÿÿÇEüÿÿÿÿMäQ‹øÜ‰}äèÃ&Q ƒ}ğ …zÿÿÿ_^‹Mô[d‰    ‹å]Ã‹†éUÿÿÿU‹ìQ¡DŞÊ…À„]  ƒ} ‹Ä+ÕS‹Yt»   ƒÀhPèaËßÿƒÄ…À„3  ‹DŞÊÂp  RèDËßÿƒÄ…À„  h-Çè/ËßÿƒÄ…À„  ¡DŞÊVp  WPèRàÿh-Ç‹ğèFàÿ‹‹R$‹ø¶GÁè÷ĞƒÄƒàP‹ÎÿÒ…Û„¾   I ‹Îè©ïÿÿÙUüÙ–h  Ø¦d  ÙáÙôœ|ÙÉßñİØv'ó†d  óMüó\ÈóY„cóXÈód  ëóEüó†d  ‹ÏèOïÿÿÙUüÙ—h  Ø§d  ÙáÙôœ|ÙÉßñİØv'ó‡d  óMüó\ÈóY„cóXÈód  ëóEüó‡d  K…Eÿÿÿ_^[‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhx\^d¡    Pd‰%    ƒìLhĞØµè‹àÿ‹ƒÄ‹È‹B$j ÿĞhàÆèsàÿ‹ƒÄ‹È‹B$jÿĞèæÿÿ‹Ä+Õ‹APèıÿÿj èşÿÿ‹Ä+Õ‹R‹DŞÊ‹ÂƒÄ+A‰UÜ‰EØÛEØyØ˜=“Ù0/}ÙÉßñİØ†   Vj j ‰Qè3'R ‹˜tÚƒÄPè³Q ‹ğ‰uØÇEü    óFhóEèè	}êÿ‹DŞÊ‰Eà‹A…À„;  SWë‹Eä‹P@‹Ø‰]ğ‰UäèMDW ‹ğ‰uì…ö„Æ   ë‹uìVè•¥éÿƒÄ…À„(  ‹^ƒûÿ„   ¡Ä+Õ‹8	  …Òt~·û;º   ssŠŠd  ‹÷Óî‹Šd  ¸   Óà‹Š   ‹4±H#ÇiÀT  90uBó„0¨   ‹UàóEĞó„0¬   ‹EğóEÔ;Pu‹DŞÊ¶QPóUèR}Ğè'¬ÿÿƒÄ‹uìVèËCW ƒÄ‰Eì…À…?ÿÿÿ‹]ğƒÎÿ9s t9‹MÜ+K0ù  v+‹{ hµ   èç%R ƒÄ;øt‹Øõ°j j j j WèŒwQ ‰s ƒ}ä …Ïşÿÿ‹uØ_[ÇEüÿÿÿÿ‹˜tÚUØR‰uØèá"Q ^‹Môd‰    ‹å]Ãè-éÿ‹@<‹N<PQè0á[ ƒÄ…À„Tÿÿÿ‹–    RèÙE ‹~ƒÄ‹Øƒÿÿu3Àë&¡ø[ÖPÿ‚{‹‹‹€8  …Àt‹Wè¶‹äÿ…Àu
…Û„	ÿÿÿë…ÛtóC‹SóE¸óCóE¼‰UÄ…Àt$M¨Q‹Èèk^ ó ‹PóE¸ó@óE¼‰UÄ‹Eğ‹MÄ;H…²şÿÿ‹DŞÊ¶BQóE¸óUèóEÈóE¼P‹Eğ}ÈóEÌè¤ªÿÿƒÄé{şÿÿÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìS‹DŞÊƒÃW‹;‰]ü…ÿtsVëI ‹E‹÷‰}ø‹@9FuXƒ~ ÿt2‹^ hµ   èM$R ƒÄ;Øt‹Øõ°j j j j SèòuQ ‹]üÇF ÿÿÿÿ‹N$j QèUz ‹UøƒÄR‹ËÇF$    èØÀÿÿ…ÿu”^_[‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh˜\^d¡    Pd‰%    Qƒ=DŞÊ „®  SV‹uVèc^ ‹Ø¡DŞÊ‹ ‹ ƒÄ…Àt9„‡  ‹@…Àuñƒşÿ„w  ‹ø[ÖQÿ‚{‹‹‹€8  …À„X  ‹Vèî‰äÿ‹ğ…ö„F  ‹†   ‹°¼ÖWj Pè/¯Q ‹ø‰}ğÇEü    ‹GƒÀşƒø‡‰   ¶€P˜¯ ÿ$…D˜¯ ‹G`hÓ PèˆU ƒÄ…Àuf‹ÎèJ^ @ƒøLwY¶ˆh˜¯ ÿ$\˜¯ ‹G`hÒ PèXU ƒÄ…Àu6ÇEüÿÿÿÿé®   ÇEüÿÿÿÿ‹°¼ÖUğR‰}ğèüQ _^[‹Môd‰    ‹å]Ã‹¶Œ   ƒşÿt¡Ä+Õ‹ˆ8	  …Ét
Vè{‰äÿ…Àu*ÇEüÿÿÿÿ‹°¼ÖEğP‰}ğè®Q _^[‹Môd‰    ‹å]Ã‹„   ƒÏÿ;×t&‹5DŞÊ‹F…ÀtI 9P‹@@t…Àuôë‹Sèš¥èÿ‰}üMğèÿ5äÿ_^[‹Môd‰    ‹å]Ã‹ÿ*—¯ {—¯ ¥—¯  I o—¯ Z—¯ ¥—¯              ÌÌÌÌÌÌÌÌÌÌÌ¡DŞÊ…Àt‹‹…Àt9t‹@…ÀuõÃ…ÀtPèi½ÿÿÃÌÌÌÌÌÌÌÌU‹ìƒ=DŞÊ t;‹EPèa^ ‹DŞÊƒÄ…Ét%‹	‹…Òt›    9t	‹R…Òuõ]Ã…ÒtRè½ÿÿ]ÃÌÌÌÌÌÌÌU‹ì‹EƒìHƒx0 „ƒ   S‹]¶ÓòÅiÒ“ VW¶ÿ3×¶}iÒ“ ‹5DŞÊ‹F3×¶}iÒ“ 3×iÒ“ #‹@‹…Àt"9Xt‹ …ÀuõëƒÀPM¸è—«ÿÿ‹Mü‹U‰JD‹E‹NPSèá½ÿÿ_^[‹å]Ã‹M‹DŞÊPQ‹JèÇ½ÿÿ‹å]ÃÌÌÌU‹ì‹UV¶òöÅiö“ W¶ş3÷¶}
iö“ 3÷¶}iö“ 3÷iö“ ƒ} t#¡DŞÊ‹H#1‹A‹°…Àt99Pt.‹ …Àuõ_^]Ã‹DŞÊ‹I#1‹A‹°…Àt9Pt
‹ …Àuõ_^]ÃRè#¾ÿÿ_^]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìHƒ=DŞÊ t:V‹uE¸VPèÃ©ÿÿ‹NƒÄƒ~, tQU¸Rè}şÿÿƒÄ^‹å]Ã‹EèPQèÿÿÿƒÄ^‹å]ÃÌÌÌék~èÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhÃ\^d¡    Pd‰%    Q‹Á3ÉP‰‰H‰H‰HV‰EğÇB
   ÇD   ‰J‰JÇB  ‰JÇBğ`‰Mü‰P¹   ‰Mü‰H,ÇEüÿÿÿÿ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌU‹ìjÿhã\^d¡    Pd‰%    QV‹ñ‰uğÇEü   èéÿÿÇEüÿÿÿÿNèV9ßÿ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌéëèÿÿÌÌÌÌÌÌÌÌÌÌÌéÛéÿÿÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh]^d¡    Pd‰%    QSV‹ñWN‰uğè¿ÿÿ3Û‰]ü‰^‰‰^ÇEü   FHºğ`Ç@
   Ç P   ‰X‰XÇ@  ‰X‰PÆEü‰F9PtjhT  hpà{SèMfz ƒÄjèşz ‹M‰H9V8t	jhß   ë×‹U‰N0R‹Î‰^4èş½ÿÿjèn{ ‹øƒÄƒÿ}¿   WNè³ÿÿ3À;û~‹N‰@;Ç|õ‹FH‰ÇEüÿÿÿÿ‹Mô_‹Æ^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿht]^d¡    Pd‰%    ƒìSV‹ñW‰uğÇEü   è‘èÿÿ3Ûˆ]üNHèÔ7ßÿÇEüÿÿÿÿ~‰}ğÇEü   S‹Ïèˆ²ÿÿÇEü   w‰uìÆEü‹ÎèàlßÿÆEü‰^‰^ÆEü‰‰^ÇEüÿÿÿÿ‹Mô‰‰__^[d‰    ‹å]ÃU‹ìjÿh¬]^d¡    Pd‰%    ƒìS3ÛV‹ñ‰‰^‰^‰^NA‰‰Y‰Y‰Yº   W‹ú‰uğ‰MìÇ@
   Ç D   ‰X‰XfÇ@ f‰x‰XÇ@ğ`‰]ü‰A¸   ‰Eü‰A,‰Uüóà=“‰FXƒÏÿ3ÀóF@‰~D‰~H‰~L‰~T‰^\‰F`‰^d‹ä*­¡à*­hè*­RNhPèFÑâÿ‹ä*­¡à*­hè*­Rp  Pè)Ñâÿ‹ä*­¡à*­hè*­Rx  PèÑâÿWÀ‰¾  ‰¾”  ‰¾Ô  ó†Ø  ‰¾è  ó†ì  ‰¾ü  ó†   ‰  hğàµ  èİá* ÆEüfÇFPÿs‰}ü‹Mô_‹Æ^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìSVW‹ù3ö‰·Ì  è+qêÿ‹Ø‰·t  èNO ‹uóóğe­(ÈóYl,}óXà=“…ÀSEó\Ñ‹ÏóóUP…  èËÀÿÿóóğe­(ÈóYl,}óXà=“SMQó\Ñ‹ÏóUóèƒÍÿÿóóğe­(ÈóYl,}óXà=“Uó\ÑR‹ÏóUóèLÇÿÿóóğe­¡DŞÊ(ĞóYl,}óXà=“óö@`ó\ÊóMu%j SQ‹Ïó$èèÿÿóEjSQ‹Ïó$è èÿÿóóğe­(ÈóYl,}óXà=“SMQó\Ñ‹ÏóUóè¸ÈÿÿURëyè½¿ÿÿóóğe­(ÈóYl,}óXà=“SMQó\Ñ‹ÏóUóèuÌÿÿóóğe­(ÈóYl,}óXà=“SUó\ÑR‹ÏóUóè=ÈÿÿEPóóğe­(ÈóYl,}óXà=“ó\Ñ‹ÏóUóèæÃÿÿóóğe­(ĞóYl,}óXà=“Qó\Ê‹Ïóó$è2•ÿÿƒ¿Ì   v!ƒ¿Ğ   u+è;şÿ‹Ì  ‰Ğ  _^[]Â ‹—Ì  ‰—Ğ  _^[]Â ‹‡Ì  ‰‡Ğ  _^[]Â ÌÌU‹ììì   SVW‹Ùè}’ÿÿ‹Ä+Õ°ÿˆEúŠƒ`  j fÇEøÿÿˆEû‹Qjhš  ‰U°è_R ƒÄPèVĞ* WÀƒÄ‰E¸j …4ÿÿÿó…tÿÿÿó…xÿÿÿóà=“Ptÿÿÿó…|ÿÿÿóE€è¤| ènêÿ‹DŞÊ‹y‰E´…ÿ„ö  ë‹}ô‹E´‹W@‰Uô9G…Õ  ƒÿ„Ë  ó“„  óYWó›x  óY_ó‹|  óYOóXÓóX“  óUÄó“ˆ  óYWóXÑóX“”  ³0  ‹ÎóUÈè'| Ø8=“Ù‹ÎØEÄŞÁÙ]üè | Ø8=“óEüÙEÈóEÔØƒ4  MìQUœŞÁR‹ËÙ]ØóGóEœóGóE èo{ÿÿóGEäPM¤óE¤óGQ‹ËóE¨èL{ÿÿóGUÜRE”óE”óGP‹ËóE˜è){ÿÿ‹EÔ‹MØóEÜóUÔ/Â‰E¼‰MÀ‰EÌ‰MĞw(èëóm¼óMàóeÀ/Ìw(á/ĞvóEÌó]Ğ/Ùw(ÙóUä/Õw(êóMè/Ìw(á/Âw(Â/Ùw(ÙóUì/Õw(êóMğ/Ìw(á/Âw(Â/Ùw(Ùj M„VQóm„óeˆóEŒó]è1| ƒÄ…À„÷   ƒÎÿ9w uèI‚ÿÿ9w „á   ‹U°‹E‰W0ó óğe­(ĞóYl,}óXà=“ó\ÊóM¬ó 3öë¤$    ÙD5Ô‹0  Ø!Ù]üèL| Ø}ü‹0  Ùœ5TÿÿÿÙD5ØØ£4  Ù]üè:| Ø}ü„5ÿÿÿPD5ÔPÙœ5XÿÿÿèÎëÿƒÆƒÄƒş |£‹W óE¬4ÿÿÿQ‹‹p  R…TÿÿÿPQQ‹M¸ó$h(¬¯UøR‹W…ÿÿÿPQRèB^ëÿƒÄ(ƒ}ô …ıÿÿ‹uV‹Ëèºùÿÿ‹C ;-Çu‹K$;-ÇuV‹Ëèœÿÿ_^[‹å]Â ÌÌÌU‹ì¡DŞÊV‹ñ…Àt(ƒxX t"‹EW‹}WPè¼ëÿ‹ÎèvÌÿÿ…ÀtW‹Îèúûÿÿ_^]Â ÌÌÌÌU‹ìjÿhÈ]^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿèesèÿöEt	Vè	Gz ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌU‹ìjÿh^^d¡    Pd‰%    QV‹ñ‰uğÇEü      è_Ô* ÇEüÿÿÿÿƒÆ‰uğÇEü   ‹ÎèTŞÿÿÇEüÿÿÿÿNè•.ßÿ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌU‹ì‹DŞÊ…Ét<‹ATV‹u;Æt0ƒøÿt(‹	è¬rèÿ¡DŞÊ‹HèÿŞÿÿ‹DŞÊ‹IèñŞÿÿ‹DŞÊ‰qT^]ÃÌÌÌÌÌU‹ìjÿh(^^d¡    Pd‰%    Q‹EV‹ñ‹MPQ‹Î‰uğèâôÿÿÇEü    ÇFh   ÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌU‹ìjÿhH^^d¡    Pd‰%    Q‰MğÇEüÿÿÿÿè˜õÿÿ‹Môd‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ìjÿh¤^^d¡    Pd‰%    QSVWh	  èšIz ƒÄ‰Eğ3Û‰]ü;Ãt	‹Èèäõÿÿë3ÀÇEüÿÿÿÿj£DŞÊèmIz ‹ğƒÄ‰uğ¿   ‰}ü;ót(èt}| ‰‰^‰^‰^ÆEü‰~‰‰^‰^‰FÆEüë3öÇEüÿÿÿÿ¡DŞÊjp‰0èIz ‹ğƒÄ‰uğ»   ‰]ü…ötj j‹Îè«óÿÿÆEü‰~hˆ]üë3öÇEüÿÿÿÿ‹DŞÊjp‰qèÖHz ‹ğƒÄ‰uğ»   ‰]ü…ötj j‹ÎègóÿÿÆEü‰~hˆ]üë3öÇEüÿÿÿÿ¡DŞÊ‰xX_‰pHh^[ùàÆt‹äÆ¡àÆhèÆRPèâÆâÿ¡DŞÊˆp  ùè Æt‹ì Æ¡è Æhğ ÆRPè¸Æâÿ¡DŞÊˆx  ùø¤Æt‹ü¤Æ¡ø¤Æh ¥ÆRPèÆâÿ¡DŞÊp  Pè^³ßÿƒÄ…Àt<‹DŞÊÁx  QèE³ßÿƒÄ…Àt#¡DŞÊx  Rp  j PèeóßÿƒÄ‹Èèûİÿÿ‹Môd‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh¸^^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿèEóÿÿöEt	VèICz ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌU‹ìjÿhü^^d¡    Pd‰%    QV‹ñW‰uğÇEü      èĞ* ÇEüÿÿÿÿ~‰}ğÇEü   ‹Ïè“ÚÿÿÇEüÿÿÿÿOèÔ*ßÿöEt	VèÈBz ƒÄ‹Mô_‹Æ^d‰    ‹å]Â ÌU‹ìjÿhT_^d¡    Pd‰%    QV‹5DŞÊ…ö„H  ƒ=À+Õuè
¢ÿÿSW‹~…ÿta‹÷‹@ƒËÿ9^ t2‹^ hµ   è¦R ƒÄ;Øt‹Øõ°j j j j SèKaQ ÇF ÿÿÿÿƒËÿ‹F$j Pèö@z ƒÄÇF$    …ÿu¨‹5DŞÊëƒËÿNèµÙÿÿ¡DŞÊ‹03ÿ‰x‰uğ;÷t‰]ü‹Îè8nèÿVèâAz ¡DŞÊƒÄ‹p‰8‰uğ;÷t‰]ü‹Îè´ñÿÿVè¾Az ¡DŞÊƒÄ‹p‰x‰uğ;÷t‰]ü‹ÎèñÿÿVè™Az ¡DŞÊƒÄ‹ğ‰x‰uğÇEü   ˆ  èÏ* ‰]ü~‰}ğÇEü   ‹ÏèÙÿÿ‰]üOèU)ßÿVèOAz ƒÄ_ÇDŞÊ    [‹Mô^d‰    ‹å]ÃÌ¡Ä+ÕW‹¸¬	  hXGÉèš°ßÿƒÄ…ÀthXGÉè)ìßÿ‹ƒÄ‹È‹B$VÿĞ‰·l  _ÃÌÌÌÌU‹ì¡Ä+ÕV‹°¬	  ƒ¾h   uW‹}…ÿ~è›MO Ç‰†h  _‹Ä+Õ‹±¬	  hXGÉè,°ßÿƒÄ…Àt"hXGÉè»ëßÿ‹ƒÄ‹È‹B$jÿĞÇ†l     ^]Ã¡Ä+ÕV‹°¬	  …öt=hXGÉèæ¯ßÿƒÄ…Àt"hXGÉèuëßÿ‹ƒÄ‹È‹B$j ÿĞÇ†l      Ç†h      ^ÃÌ¡Ä+ÕV‹°¬	  …öt=hXGÉè–¯ßÿƒÄ…Àt"hXGÉè%ëßÿ‹ƒÄ‹È‹B$j ÿĞÇ†l      Ç†h      ^ÃÌ¡Ä+ÕV‹°¬	  …öt=hXGÉèF¯ßÿƒÄ…Àt"hXGÉèÕêßÿ‹ƒÄ‹È‹B$j ÿĞÇ†l      Ç†h      ^ÃÌU‹ìd¡    jÿhh_^Pd‰%    ¡Ä+ÕƒìV‹°¬	  …ö„â   ƒ¾l   „Õ   èLO ‹h  …Éu/h`IÉè{êßÿ‹ƒÄj ‹È‹‚   hpà{ÿĞ^‹Môd‰    ‹å]Ã;Ár/h`IÉèHêßÿ‹ƒÄj ‹È‹‚   høå|ÿĞ^‹Môd‰    ‹å]Ã+È¸‰ˆˆˆ÷á‹òWMèÁîèÌ¸z ÇEü    FVMèh(|QèUÁz h`IÉèëéßÿƒÄ‹ø‹7j MèèÚ¶z ‹–   P‹ÏÿÒÇEüÿÿÿÿMèèàÀz _‹Mô^d‰    ‹å]ÃVèš>åÿh  è`tO ¡Ä+Õ‹°¬	  ƒÄ…öt=hXGÉèÄ­ßÿƒÄ…Àt"hXGÉèSéßÿ‹ƒÄ‹È‹B$j ÿĞÇ†l      Ç†h      ^ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌVèj êÿ‹@‹H‹‹‚„  j ÿĞ‹Ä+Õ‹±¬	  …öt=hXGÉèN­ßÿƒÄ…Àt"hXGÉèİèßÿ‹ƒÄ‹È‹B$j ÿĞÇ†l      Ç†h      ^ÃÌÌÌÌÌÌÌÌÌU‹ì‹‘8  ‹E;u‹‰<  ;Hu¸   ¶À]Â 3À¶À]Â U‹ì‹E‰à0  ]Â 8  ÃÌÌÌÌÌÌÌÌÌU‹ì‹Q‹E;u‹I;Hu¸   ¶À]Â 3À¶À]Â ÌÌÌÌÌÌAÃÌÌÌÌÌÌÌÌÌÌÌÌ3ÀÇÿÿÿÿ‰A‰A‰A‰AÃÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhˆ_^d¡    Pd‰%    QV‹ñ‰uğèÜ@ ÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]ÃÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìì  PQ•øıÿÿRèÙÁâÿ…øıÿÿPèí«ßÿƒÄ…Àt"‹•üıÿÿ‹…øıÿÿ şÿÿQRP‹Îèê¾âÿ‹Æ‹å]Ã‹ä*­‹à*­hè*­QR‹ÎèÊ¾âÿ‹Æ‹å]ÃÌÌÌÌV‹ñW3ÿƒÈÿ‰†  ‰†  ‰¾  ‰¾  ‰¾  ‰¾  ‰¾   ‰¾$  ¡ä*­‹à*­hè*­PQ(  èj¾âÿ‹ä*­¡à*­hè*­RP0  èM¾âÿ‹ä*­‹à*­hè*­QR8  è/¾âÿ¡ä*­‹à*­hè*­PQ@  è¾âÿ‹ä*­¡à*­hè*­RPH
  èõ½âÿ‹ä*­‹à*­hè*­QRP  è×½âÿ¡ä*­‹à*­hè*­PQX  èº½âÿ‹ä*­¡à*­hè*­RP`  è½âÿ‹ä*­‹à*­hè*­QRh  è½âÿ¡ä*­‹à*­hè*­PQp  èb½âÿ‹ä*­¡à*­hè*­RPx  èE½âÿ‹ä*­‹à*­hè*­QR€  è'½âÿ¡ä*­‹à*­hè*­PQˆ  è
½âÿ‹ä*­¡à*­hè*­RP  èí¼âÿ‹ä*­‹à*­hè*­QR˜  èÏ¼âÿ¡ä*­‹à*­hè*­PQ    è²¼âÿ‹ä*­¡à*­hè*­RP¨"  è•¼âÿ‹ä*­‹à*­hè*­QR°$  èw¼âÿ¡ä*­‹à*­hè*­PQÈ*  èZ¼âÿ‹ä*­¡à*­hè*­RPĞ,  è=¼âÿ‹ä*­‹à*­hè*­QRØ.  è¼âÿ‰¾à0  ‰¾ä0  _‹Æ^ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhÈ_^Pd‰%    ƒì@SVWè­êÿ‹p‹^è¢êÿ‹@‹H‹‹PÿÒ‹}…Àt‹‹P OQ‹ÎÿÒ…Àt‹MG8Pè½z ë4‹Mj Qj UÜWRè=„ ƒÄÇEü    ‹MPèê¼z ÇEüÿÿÿÿMÜè+»z ‹‹P|wVM´Q‹ËÿÒÇEü   ƒÀPMèèç²z ÆEüMÈèûºz ÆEüM¼èïºz Mèèç°z ‹}…ÀtMèèÈ°z Ph®|Wè»z ƒÄó~ƒì‹ÄfÖ ó~FfÖ@èÍØîÿ‹ğ‹EVPèáÆşÿVWèÚÆşÿƒÄ ÇEüÿÿÿÿMèèˆºz ‹Mô_^d‰    [‹å]Â ÌÌÌÌÌÁ8  QèdãßÿƒÄÇ€
      ÃÌÌÌÌÌÌÇÿÿÿÿÇ0
      Ç4
  ÿÿÿÿÃÌÌÌÌÌU‹ìì  S‹]VW‹ù¸Ô}‹ËµøıÿÿÇÿÿÿÿÇ‡0
      Ç‡4
  ÿÿÿÿèûÿÿO;ÈtPR‹P‹ RPèºâÿ¸,f‹ËµøıÿÿèÚúÿÿ  ;ÈtPR‹P‹ RPèğ¹âÿ¸$f‹Ëµøıÿÿè®úÿÿ  ;ÈtPR‹P‹ RPèÄ¹âÿ¸pY‹Ëµøıÿÿè‚úÿÿ   ;ÈtPR‹P‹ RPè˜¹âÿ¸f‹ËµøıÿÿèVúÿÿ(  _^[;ÈtPR‹P‹ RPèi¹âÿ‹å]Â ÌÌÌU‹ìƒìVPè³åßÿ‹ğó†h  óEìó†l  óEğó†p  óEôó†t  ƒÄMìóEøèr| Ù]üóEüƒìóD$WÀ‹Îó$èò“
 ÙEüØMóüˆ|ƒìóD$‹ÎÙ$èÑ’
 ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìPQUøRÇEøÿÿÿÿÇEüÿÿÿÿè‘DU ‹MƒÄEøPQèQáßÿƒÄ‹ÈèGı 3Àƒ}øÿ•À‹å]ÃÌÌÌÌÌÌÌÌÌÌU‹ìƒìVW‹ù·x  Vè:¥ßÿƒÄ…Àt~VèÍàßÿ‹ğ‹‹P$ƒÄƒ¿à0   ‹Îu
j ÿÒ_^‹å]ÃjÿÒƒÈÿ‰Eø‰Eü‹‡à0  HtHtHu=EøPhxfëMøQhXfë	UøRh8fèşy ƒÄ…Àt‹Eø‰†”  ‹Mü‰˜  _^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhğ_^Pd‰%    ƒì ƒ} SVW‹Ùu
ƒ} u3ÿë¿   ƒÈ*  Pèÿßßÿ‹ğ‹‹B$ƒÄW‹ÎÿĞ‹Ğ,  Qèäßßÿ‹M‹‹R$ƒÄQ‹ÈÿÒÃØ.  SèÈßßÿ‹ƒÄ‹È‹B$WÿĞ…ÿ„±   Màè‹®z ÇEü    ‹M‹UjQREÔPèQZ ƒÄÆEüMÔèÂ¬z …ÀtMÔè¦¬z PMàhdú€Qèç¶z ƒÄMàèœ¬z ƒÏÿ…Àt1UìRMà‰}ì‰}ğèc¬z PèÍx ‹Eì‹MğƒÄ‰†”  ‰˜  jëj ‹‹B$‹ÎÿĞÆEü MÔèM¶z ‰}üMàèB¶z ‹Mô_^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìV‹ñWƒÈÿ¾x  W‰Eø‰Eüè!£ßÿƒÄ…ÀtVEøPh˜fè<x ƒÄ…ÀtAèÀ¸Òÿ‹   +È‹†$  Â‰Eôx'…Ét!WèŞßÿ‹MøƒÄ‰ˆ”  ‹Uü_‰˜  ^‹å]Ã‹Îèmıÿÿ_^‹å]ÃÌÌÌÌÌÌÌU‹ìƒìV‹ğVè¡¢ßÿƒÄ…ÀtVètŞßÿ‹ğ‹‹P$ƒÄ‹Îƒÿÿuj ÿÒ3À^‹å]ÃjÿÒjEøWPÇEøÿÿÿÿÇEüÿÿÿÿèjAU ƒÄMøQƒÆ Vè*ŞßÿƒÄ‹Èè ú 3Àƒ}øÿ^•À‹å]ÃÌÌ…Àtƒøtƒøt¸   Ã3ÀÃÌÌÌÌÌÌÌÌÌ3À9ßÊ”À£ßÊÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ3À¹ ËVpúƒşw‹±HÕÿÿ;2u‹±LÕÿÿë	‹1;2u‹q;rtÁ(=  @ùØ²Í|ÉƒÈÿ^ÃÌÌÌÌÌÌÌÌÌÌÌÌVPèé<^ ƒÄ‹ğè¯Véÿ;ğ^uè5!éÿhà*­è˜% YÃÌÌÌÌÌÌÌÌÌS‹Ùƒ;ÿ„–   ƒ»4
   uoVWè4Gèÿ‹ø‹Ïè»yèÿ‹ğ…öt/VèÿªW ƒÄ…Àt"Vè’W ƒÄƒøuVèD³ ƒÄj ‹Ïè(tèÿë(‹Pè^<^ ƒÄ‹ğè$Véÿ;ğuè« éÿhà*­è—% ƒÄ_^ƒÃSèÃÜßÿ‹ƒÄj j‹È‹‚¤   j ÿĞ[ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh`^d¡    Pd‰%    QV‹ñ‰uğè«z ÇEü    Nè«z ÆEüNè«z ÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìjÿhN`^d¡    Pd‰%    QV‹ñ‰uğÇEü   Nè³z ÆEü Nè³z ÇEüÿÿÿÿ‹Îèø²z ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ì‹E…Àt‹¸ PÌ9ˆ  t(=  =èÍ|ì3À]ÃÌÌÌÌÌÌÌU‹ì‹EPèä<^ ‹ÈƒÄ¸Ë9t(=  =Ì|ğ3À]ÃÌÌÌÌÌÌU‹ì‹M¸ËëI 9t2(=  =Ì|ğ‹Mùà*­t‹ä*­¡à*­hè*­RPè~²âÿ3À]Ã‹MƒÀ;ÈtPR‹P‹ RPè`²âÿ¸   ]ÃÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhh`^Pd‰%    ‹EPƒì‹Ì‰eè‡©z ÇEü    èëêÿ‹M‹U‹@jQRÇEüÿÿÿÿ‹Èè Şıÿ‹Môd‰    ‹å]ÃÌÌV‹5ßÊ3Ò3É9–Ü	  ~+†@  ¤$    Ç@øÿÿÿÿ‰Pü‰‰P‰PAƒÀ;Ü	  |â^ÃU‹ì¡ßÊì  …À„¥   ‰ˆ(  H;Ît‹FVR‹PRè}±âÿhÈfVøıÿÿèœ²âÿ‹ßÊÁ  …øıÿÿ;Èt‹…üıÿÿ• şÿÿR‹•øıÿÿPRè<±âÿh¬f…øıÿÿPğûÿÿèU²âÿ‹ßÊÁ   •ğûÿÿ;Êt‹•ôûÿÿ…øûÿÿP‹…ğûÿÿRPèõ°âÿ‹å]ÃÌU‹ìjÿhˆ`^d¡    Pd‰%    ì  ÇEü    ¡ßÊ…ÀuÇEüÿÿÿÿMès°z ‹Môd‰    ‹å]Ãhäf  Pìıÿÿè¿±âÿ…ìıÿÿPècßÿƒÄ…ÀtºVìıÿÿWQèÙßÿƒÄ‹ø‹7j Mèı¥z ‹–   P‹ÏÿÒÇEüÿÿÿÿMè°z ‹Mô_^d‰    ‹å]ÃÌÌÌU‹ì¡ßÊì  …ÀtF‹ôeR   Pøıÿÿè5±âÿ…øıÿÿPèÙœßÿƒÄ…ÀtøıÿÿQèÆÚßÿ‹ƒÄ‹È‹B$j ÿĞ‹å]ÃÌÌÌÌU‹ì¡ßÊì  …ÀtI‹ôeR   PøıÿÿèÕ°âÿ…øıÿÿPèyœßÿƒÄ…ÀtøıÿÿQèfÚßÿ‹ƒÄ‹È‹‚”   j ÿĞ‹å]ÃÌU‹ì¡ßÊì0  …À„Ø   hg  PĞıÿÿèt°âÿ…ĞıÿÿPèœßÿƒÄ…À„«   ĞıÿÿQè¡×ßÿ‹ßÊó€Ø  Â   RóEìè‚Üßÿó€Ğ  óEÜó€Ø  ¡ßÊ  PóEäèX×ßÿó€Ì  óEğó€Ğ  óEôó€Ô  óEøóEì(Èó\MÜƒÄMøQó\ÁóXEäóEü‹‹RtMğQ‹ÈÿÒ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì¡ßÊì0  …À„Ó   hDg0  PØıÿÿèt¯âÿ…ØıÿÿPè›ßÿƒÄ…À„¦   h$gØıÿÿQĞûÿÿèF¯âÿ•ĞûÿÿRèêšßÿƒÄ…Àt|…ĞûÿÿPèwÛßÿó€Ğ  ØıÿÿóEìó€Ø  QóEäèQÖßÿó€Ì  óEğó€Ğ  óEôó€Ô  óEøóEìóXEäƒÄMøQóEü‹‹RtMğQ‹ÈÿÒ‹å]ÃÌÌÌU‹ìƒìƒ=ßÊ „€   V‹uVèCšßÿƒÄ…ÀtVèÖÕßÿ‹ƒÄ‹È‹B$j ÿĞ‹ßÊÁ0  ;Ît‹FVR‹PRè(­âÿ¡ßÊ‹€(  iÀ(=  Ë‹Qèz7^ ‰EüèrNéÿPjUôRh£   èqı ƒÄ^‹å]ÃÌÌÌÌÌÌÌÌÌU‹ì¡ßÊƒì…Àt2‹€(  iÀ(=  Ë‹ Pè(7^ ‰Eüè NéÿPjMôQjmè"ı ƒÄ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌhà*­èö% YÃÌÌÌÌU‹ì¡ßÊƒì…ÀtB‹€(  iÀ(=  Ë‹ ƒøÿt*PèÃ6^ ƒÄ‰Eüƒøÿtè³MéÿPjEôPhw  è²ü ƒÄ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌéëßÿÌÌÌÌÌÌÌÌÌÌÌU‹ìƒ=ßÊ tZ‹EPè»ÔßÿƒÄ‹ÈèaŸãÿ…ÀxC‹ßÊ;Ü	  }5€‹„‘8  V´‘8  h”³­Pè’z ‹FƒÄ…Àt‹N‹VQRÿĞƒÄ^]ÃÌÌÌÌÌÌÌÌU‹ìƒ=ßÊ tFV‹uVèJÔßÿƒÄ‹Èèğãÿ…Àx0‹ßÊ;Ü	  }"€„8  ‹H…Ét‹P‹@RPVÿÑƒÄ^]Ã¹ˆf­^]é ‚îÿ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EiÀ  ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EiÀ  PèŞáz ƒÄ]Â ÌÌÌÌÌÌÌ2ÀÃÌÌÌÌÌÌÌÌÌÌÌÌÌ2ÀÃÌÌÌÌÌÌÌÌÌÌÌÌÌ2ÀÃÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹PV‹ñH‹ QRP‹Îèuªâÿ‹M‰  ‹Æ^]Â ÌÌÌÌÌU‹ì‹E]ÃÌÌÌÌÌÌÌÌU‹ìVW‹}‹‹ñ‹OGPQR‹Îè4ªâÿ‹‡  ‰†  _‹Æ^]Â ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh¨`^d¡    Pd‰%    QV‹ñ‹†  Pƒì‹Ì‰eğè@¡z ÇEü    è¤	êÿ‹M‹@jQVÇEüÿÿÿÿ‹Èè¼Õıÿ‹Môd‰    ^‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌV‹ñ  è²êÿÿ‹Æ^ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌS‹ÜƒìƒäğƒÄU‹k‰l$‹ìƒì(V‹ñÇ†  ÿÿÿÿÇ†à0      ó~Ø>ÕWfÖ†  ó~à>Õ¾(  WfÖ†  èã•ßÿƒÄ…ÀtFWèvÑßÿó¤Ò|‹ˆx  óEà‰MüÇEì    ƒÄfïÀfÖEäó,MàˆMÿ‹Uü‰x  ˆˆ{  ¾P  WèŠ•ßÿƒÄ…ÀtFWèÑßÿó¤Ò|‹ˆx  óEà‰MüÇEì    ƒÄfïÀfÖEäó,MàˆMÿ‹Uü‰x  ˆˆ{  Æ  Vè1•ßÿƒÄ…ÀtVèÖßÿƒÄ‹ÈèÚÃ _^‹å]‹ã[ÃÌU‹ìì  SVW‹ùè½şÿÿ‹]¸”h‹ËµøıÿÿèØèÿÿ(  ;ÈtPR‹P‹ RPèî§âÿ¸Œh‹Ëµøıÿÿè¬èÿÿ0  ;ÈtPR‹P‹ RPèÂ§âÿ¸Ô}‹Ëµøıÿÿè€èÿÿ8  ;ÈtPR‹P‹ RPè–§âÿ¸„h‹ËµøıÿÿèTèÿÿ@  ;ÈtPR‹P‹ RPèj§âÿ¸xh‹Ëµøıÿÿè(èÿÿH
  ;ÈtPR‹P‹ RPè>§âÿ¸$f‹ËµøıÿÿèüçÿÿP  ;ÈtPR‹P‹ RPè§âÿ¸lh‹ËµøıÿÿèĞçÿÿX  ;ÈtPR‹P‹ RPèæ¦âÿ¸dh‹Ëµøıÿÿè¤çÿÿ`  ;ÈtPR‹P‹ RPèº¦âÿ¸Th‹Ëµøıÿÿèxçÿÿh  ;ÈtPR‹P‹ RPè¦âÿ¸Hh‹ËµøıÿÿèLçÿÿp  ;ÈtPR‹P‹ RPèb¦âÿ¸8h‹Ëµøıÿÿè çÿÿx  ;ÈtPR‹P‹ RPè6¦âÿ¸(h‹Ëµøıÿÿèôæÿÿ€  ;ÈtPR‹P‹ RPè
¦âÿ¸h‹ËµøıÿÿèÈæÿÿˆ  ;ÈtPR‹P‹ RPèŞ¥âÿ¸üg‹Ëµøıÿÿèœæÿÿ  ;ÈtPR‹P‹ RPè²¥âÿ¸pY‹Ëµøıÿÿèpæÿÿ˜  ;ÈtPR‹P‹ RPè†¥âÿ¸ôg‹ËµøıÿÿèDæÿÿ    ;ÈtPR‹P‹ RPèZ¥âÿ¸èg‹Ëµøıÿÿèæÿÿ¨"  ;ÈtPR‹P‹ RPè.¥âÿ¸Øg‹Ëµøıÿÿèìåÿÿ°$  ;ÈtPR‹P‹ RPè¥âÿ¸Àg‹ËµøıÿÿèÀåÿÿ¸&  ;ÈtPR‹P‹ RPèÖ¤âÿ¸¨g‹Ëµøıÿÿè”åÿÿÀ(  ;ÈtPR‹P‹ RPèª¤âÿ¸Œg‹Ëµøıÿÿèhåÿÿ;øt‹PH‹ QRP‹Ïè‚¤âÿ¸€g‹Ëµøıÿÿè@åÿÿÈ*  ;ÈtPR‹P‹ RPèV¤âÿ¸pg‹ËµøıÿÿèåÿÿĞ,  ;ÈtPR‹P‹ RPè*¤âÿ¸hg‹ËµøıÿÿèèäÿÿØ.  _^[;ÈtPR‹P‹ RPèû£âÿ‹å]Â ÌÌÌÌÌU‹ìS‹]V‹óiö(=  Æ(ßÊ;÷t‹O‹GPQR‹ÎèÄ£âÿCúWƒøw  ‰  èzûÿÿ^[]Ãğ2  ‰ô2  è%éÿÿ^[]ÃÌƒù
w9AúiÉ(=  ƒøwÁ0áÊéúÿÿÁËÇÿÿÿÿÇ0
      Ç4
  ÿÿÿÿÃÌVW‹ø‹÷iö(=  †(ßÊPè¸Ëßÿ‹ƒÄ‹È‹B$j ÿĞƒÿ
w.ƒÇúƒÿw_0áÊ^é°ùÿÿƒÈÿ‰†ËÇ†HË    ‰†LË_^ÃÌÌÌÌU‹ì‹EV‹ñ;ğtPè}3åÿ‹Æ^]Â ÌÌÌÌÌÌU‹ì‹ßÊ…ÉuƒÈÿ]Ã‹QV3ÀW…Òt2‹	‹uÁ¨   ‹9;}u‹y;}u‹y;}u9qt@Á  ;ÂrÙƒÈÿ_^]ÃÌÌÌÌÌÌÌÌÌÌU‹ìS‹]VW¿úÿÿÿ¾LËƒ; uK†ÜÂÿÿPèÌÊßÿ‹ƒÄ‹È‹B$j ÿĞOƒù
w)ƒÿwäÄÿÿèÆøÿÿëÇ†ÌõÿÿÿÿÿÿÇFü    ÇÿÿÿÿGWƒÃÆ(=  ƒú|_^[]ÃÌÌÌÌÌÌU‹ìd¡    jÿh9a^Pd‰%    ì\  èêÿ‹H‹‹PÿÒ…ÀuƒÈÿ‹Môd‰    ‹å]ÃSVWèvêÿ‹@‹H‹‹u‹˜   3ÿWVÿÒ‰}ğ9~†g  ‰}ì‹]ì¹%   ‹ó½˜şÿÿƒ˜   ó¥P0ÿÿÿèŠ# ÇEü   ó~ƒ8  fÖEĞó~ƒ@  fÖEØ‹‹H  ‰MàÇEü   •8ÿÿÿRèİW ƒÄ…ÀuW‹}‹u‹U‹];=Ø>Õu#;Ü>Õu¡à>Õ‹ä>Õ;Ğu;ñt~;Ğu;ñt ;½8ÿÿÿu;<ÿÿÿu;•@ÿÿÿu;µDÿÿÿtVƒÎÿ‰uü…0ÿÿÿ‰EèÇ…0ÿÿÿÀû|ÇEü	   hÿÿÿèT z ‰uüHÿÿÿèF z ‹Eğ‹MEìP  @‰Eğ;AsW‹ñééşÿÿƒÎÿ‰uü•0ÿÿÿ‰UèÇ…0ÿÿÿÀû|ÇEü   hÿÿÿèşŸz ‰uüHÿÿÿèğŸz ‹Eğ_^[‹Môd‰    ‹å]ÃƒÎÿ‹Mô_‹Æ^[d‰    ‹å]ÃÌÌÌÌÌÌ‹ßÊÁ0  ùà*­t¡ä*­‹à*­hè*­PRèÕŸâÿ¡ßÊÇ€Ü	      éÑíÿÿÌ¡ßÊ…Àt9ˆ0  ùà*­t¡ä*­‹à*­hè*­PRè’Ÿâÿ¡ßÊÇ€Ü	      éíÿÿÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhXa^Pd‰%    ¡ßÊì(  …À„Á  V°0  ‹;à*­u‹N;ä*­„   è0íÿÿh°hVÔıÿÿè? âÿ•ÔıÿÿRèã‹ßÿƒÄ…À„s  …ÔıÿÿSPèkÌßÿ‹€T  ‹ßÊ‹U3ÛƒÄ‰Eì‰‘Ü	  ‰]ğ…À„  ‹uW3ÿÆ  ¤$    MÜè–z ÇEü    Sh hPè•z ƒÄP…ÔıÿÿPÌûÿÿè¯ŸâÿÇEüÿÿÿÿMÜè0z ÌûÿÿQèD‹ßÿƒÄ…À„–   •ÌûÿÿRè-Éßÿ‹MğƒÄ‹Ø;M}r‹Vü¡ßÊ‰”8  ‹‰”<  ‹V‰”@  ‹V‰”D  ‹VQ‹Ë‰”H  èb‘ãÿ‹   j Nğ‰Eèè“z P‹Eè‹‹ËÿÒöFth¬¯‹Ëè"ù jëj ‹‹P$‹ËÿÒ‹]ğCÆ0  ƒÇ‰]ğ;]ì‚úşÿÿ_è4ïÿÿ¡ßÊ0  PèÆßÿ‹ƒÄ‹È‹B$jÿĞ[^‹Môd‰    ‹å]ÃÌÌÌÌÌÌU‹ì‹Q‹ÂÑèÂ‹U;ÂBÂ‰AiÀ  PèMÔz ƒÄ]Â ÌÌÌÌÌÌU‹ì‹E‹PV‹uH‹ QRP‹Îè$âÿ‹M‰  ‹Æ^]ÃÌÌÌÌÌÌU‹ìjÿh„a^d¡    Pd‰%    ƒìSVh  èÉz ‹ğ^ƒÄÇ    ÇF   ‰uğ‰]ìÇEü    …Ût>W‹}‹O‹GPQR‹Ëè­œâÿ‹‡  ‰ƒ  ÇEüÿÿÿÿ_‹Æ^[‹Môd‰    ‹å]Â ÇEüÿÿÿÿ‹Mô‹Æ^[d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌ¸€Å¯ Â ÌÌÌÌÌÌÌÌjè)z ƒÄÇ     Ç@   Â ÌÌÌÌÌÌ¸ Æ¯ Â ÌÌÌÌÌÌÌÌjèùz ƒÄÇ     Ç@   Â ÌÌÌÌÌÌ¸Æ¯ Â ÌÌÌÌÌÌÌÌU‹ìd¡    jÿh˜a^Pd‰%    V‹u‹†  Pƒì‹Ì‰eè “z ÇEü    è„ûéÿ‹M‹@jQVÇEüÿÿÿÿ‹ÈèœÇıÿ‹Môd‰    ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌV‹ñ  èòÿÿƒÈÿ‰†ğ2  Ç† =      ‰†$=  ^ÃÌÌÌÌÌÌÌU‹ìVW‹}‹ñ…ÿtGë3ÀPNèR©åÿ‹‡X  ‰†X  ‹\  ‰\  ‹—`  ‡h  h  ‰–`  ;ÈtPè˜+åÿ_‹Æ^]Â U‹ìjÿhãa^d¡    Pd‰%    ƒìhVWèúéÿ‹p‹~MŒè`+ ÇEü    ‹‹¬   MŒQ‹ÏÿÒ‹Îè’Ò …ÀteEàP‹ÎèÃ¿ ‹‹M;uQ‹P;QuI‹P;QuA‹@;Au9‹¬   …Ét/ƒy  u)è\* ‹øèVşàÿ;xt‹v‹>èGşàÿ‹H‹—d  Q‹ÎÿÒ¸   ‰EüMœ‰MğˆEüU¸‰UğˆEü‹ÊèØ™z ÇEüÿÿÿÿMŒèÉ™z ‹Mô_^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìjÿhb^d¡    Pd‰%    ƒì‹ESV‹ÙW‰]è…ÀtP‰Uğë
ÇEğ    ‹UğC‹ò‹ø¹%   Â˜   ó¥Rˆ˜   ‰EìèÁ ÇEü   ‹Mğó~8  ‹EìfÖ€8  ó~@  fÖ€@  ‹‰H  ‰ˆH  ÇEü   ‹EÇôh‹X  ‰“X  ‹ˆ\  ‰‹\  ‹`  h  P‹h  ‰“`  èC ÇEüÿÿÿÿ‹Mô_^‹Ã[d‰    ‹å]Â ÌÌÌÌÌÌÌ¡ßÊ…À„¾   Hùà*­t¡ä*­‹à*­hè*­PRèÁ˜âÿ¡ßÊˆ  ùà*­t¡ä*­‹à*­hè*­PRè—˜âÿ¡ßÊˆ   ùà*­t¡ä*­‹à*­hè*­PRèm˜âÿ¡ßÊˆ0  Ç€(  ÿÿÿÿùà*­t¡ä*­‹à*­hè*­PRè9˜âÿ¡ßÊÇ€Ü	      é5æÿÿÃÌÌÌÌé+ÿÿÿÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh8b^Pd‰%    ‹EƒìWƒÏÿ;Ç„¢   ƒøş„™   V‰EèEPMìQUäRÇEä   ÇE   èšZU ƒÄ‰EğÇEü    ‹Eğ…ÀtPMä‰}ä‰}è‹”  QRjè>T ‹Eä‹u‹MèƒÄ‰‰N‰}üƒ}ì tUìRè7U ƒÄ‹Æ^_‹Môd‰    ‹å]Ã¡ $­‹u‹$$­‰ëÄ‹ $­‹E‹$$­‰‹Mô‰P_d‰    ‹å]ÃÌU‹ìd¡    jÿhXb^Pd‰%    ‹EƒìWƒÏÿ;Ç„¢   ƒøş„™   V‰EèEPMìQUäRÇEä   ÇE   èªYU ƒÄ‰EğÇEü    ‹Eğ…ÀtPMä‰}ä‰}è‹˜  QRjèNS ‹Eä‹u‹MèƒÄ‰‰N‰}üƒ}ì tUìRè+6U ƒÄ‹Æ^_‹Môd‰    ‹å]Ã¡ $­‹u‹$$­‰ëÄ‹ $­‹E‹$$­‰‹Mô‰P_d‰    ‹å]ÃÌU‹ìd¡    jÿhxb^Pd‰%    ‹EƒìWƒÏÿ;Ç„¢   ƒøş„™   V‰EèEPMìQUäRÇEä   ÇE   èºXU ƒÄ‰EğÇEü    ‹Eğ…ÀtPMä‰}ä‰}è‹œ  QRjè^R ‹Eä‹u‹MèƒÄ‰‰N‰}üƒ}ì tUìRè;5U ƒÄ‹Æ^_‹Môd‰    ‹å]Ã¡ $­‹u‹$$­‰ëÄ‹ $­‹E‹$$­‰‹Mô‰P_d‰    ‹å]ÃÌU‹ìd¡    jÿh˜b^Pd‰%    ‹EƒìWƒÏÿ;Ç„¢   ƒøş„™   V‰EèEPMìQUäRÇEä   ÇE   èÊWU ƒÄ‰EğÇEü    ‹Eğ…ÀtPMä‰}ä‰}è‹   QRjènQ ‹Eä‹u‹MèƒÄ‰‰N‰}üƒ}ì tUìRèK4U ƒÄ‹Æ^_‹Môd‰    ‹å]Ã¡ $­‹u‹$$­‰ëÄ‹ $­‹E‹$$­‰‹Mô‰P_d‰    ‹å]ÃÌU‹ìjÿhÈb^d¡    Pd‰%    ƒìMó‰Mì‹M3ÀˆEó‰Mè‰Eü;Èt	‹URè$úÿÿÇEüÿÿÿÿ‹Môd‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh'c^P‹Ed‰%    ƒì;E„  S‹]VMóW‰MäÆEó ‰]à3É‰Mü;Ù„³   ;ÁtP‰Uìë‰Mì‹ÑC‹ò‹ø¹%   Â˜   ó¥Rˆ˜   ‰Eèè¥ ÆEü‹Mì‹Eèó~8  fÖ€8  ó~@  fÖ€@  ‹‘H  ‰H  ÆEü‹EÇôh‹ˆX  ‰‹X  ‹\  ‰“\  ‹ˆ`  h  ‰‹`  P‹h  è- ÆEü ‹EÇEüÿÿÿÿ  Ã  ‰]‰E;E…ÿÿÿ_^‹Ã[‹Môd‰    ‹å]Ã‹Mô‹Ed‰    ‹å]ÃÌU‹ìQ¹°Ô¯ ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸°Ô¯ ÃÌÌÌÌÌÌÌÌÌÌ¸°Ó¯ Â ÌÌÌÌÌÌÌÌU‹ìQ‹E;E„×   S‹]VWÃ    d$ …ÀtP‰Uüë
ÇEü    ‹Uü»hÿÿÿ¹%   ‹òó¥Š˜   ;ÙtQ‹Ëè‰"åÿ‹E‹Uüó~‚8  fÖƒ    ó~‚@  fÖƒ¨   ‹ŠH  ‰‹°   ‹X  ‰“¸   ‹ˆ\  ‰‹¼   ‹`  ‰“À   h  ‹È   ;Êt	Rè"åÿ‹EE    Ã  ‰E;E…<ÿÿÿ_^[‹E‹å]ÃÌÌU‹ì‹E‹MPQèPöÿÿƒÄ]Â ÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh`c^P‹Ed‰%    ó~ ƒìS‹ÙVfÖƒ  ó~@W³€  VfÖƒ  èÈ}ßÿƒÄ…Àt7»  Wèµ}ßÿƒÄ…Àt$VèH¹ßÿ‹ƒÄ‹È‹B$j ÿĞWèt¾ßÿƒÄ‹ÈèJ¬ ³    Vè~}ßÿƒÄ…ÀtVè1¹ßÿ‹ƒÄ‹È‹B$jÿĞ³X  VèW}ßÿƒÄ…ÀtVèê¸ßÿ‹ƒÄ‹È‹B$j ÿĞ³`  Vè0}ßÿƒÄ…ÀtVèÃ¸ßÿ‹ƒÄ‹È‹B$j ÿĞ‹ËÇƒà0      è´×ÿÿƒÈÿ3É9E³˜  •ÁV‰ƒ  ‹ù‰}èâ|ßÿƒÄ…ÀtQ…ÿt‹Mè¯…z …Àt¿   ë3ÿVè|¸ßÿ‹ƒÄ‹È‹B$WÿĞVèi¸ßÿ‹MƒÄ‹ø‹7j èX…z ‹–   P‹ÏÿÒ‹}³    Vè~|ßÿƒÄ…À„   …ÿtƒ} t¿   ë3ÿVè¸ßÿ‹ƒÄ‹È‹B$WÿĞ‹Mj j jQUèRè*=z ƒÄÇEü    ‹Èèù„z PMÜè“z ÆEüMèèôz VèÎ·ßÿƒÄ‹ø‹7j MÜè½„z P‹†   ‹ÏÿĞÇEüÿÿÿÿMÜèÃz ³Ø.  Vè×{ßÿƒÄ…ÀtVèj·ßÿ‹‹R$3ÉƒÄ9M•ÁQ‹ÈÿÒƒ}(ÿu‹EPè¦AW ƒÄ‰E(‹0  Qè4·ßÿ“¨"  R‹ğèF·ßÿƒÄƒ} ‹ø™   ‹E(PMàQèZøÿÿ‹‰–”  ‹@‹ƒÄ‰†˜  ‹B$j‹ÎÿĞ‹Mj j jQUÜRè(<z ƒÄÇEü   ‹Èè÷ƒz PMèè’z ÆEüMÜèòz ‹7j MèèÆƒz P‹†   ‹ÏÿĞ‹‹E,‹R$P‹ÏÿÒƒÏÿ‰}üMèèÀz ë‹‹P$j ‹ÎÿÒ‹‹P$j ‹ÏÿÒƒÏÿ‹E(PMàQè˜øÿÿ“@  R‹ğèJ¶ßÿ‹‰ˆ”  ‹VƒÄƒ} ‰˜  ‰}ì‰}ğtd‹u‹E÷ŞöPƒæèáV MàVQÇEà   ‰EäèóQU ‹ğƒÄ3ÿƒşÿt"Vh èŒU ƒÄ…ÀtVh èúU ƒÄ‹øUìRWjèùI ƒÄƒ8  PèúµßÿƒÄMì‹ğQ‹ÎèêÑ ‹‹‚”   j‹ÎÿĞ³P  VèğyßÿƒÄ…ÀtVèƒµßÿ‹ƒÄ‹È‹B$j ÿĞ»(  WèÉyßÿƒÄ…Àt=Wè\µßÿ‹ƒÄ‹È‹B$jÿĞ‹M(QUàRè±ôÿÿW‹ğè9µßÿ‹‰ˆ”  ‹VƒÄ‰˜  ³°$  VèyyßÿƒÄ…ÀtVè,µßÿ‹ƒÄ‹È‹B$j ÿĞÃ¸&  ¾   I SèJyßÿƒÄ…ÀtSèµßÿ‹ƒÄ‹È‹B$j ÿĞÃ  NuÖ‹Mô_^[d‰    ‹å]Â( ÌÌÌU‹ìjÿh°c^d¡    Pd‰%    ƒìHS‹]ó~ƒ    V‹ñfÖ†  ó~ƒ¨   WfÖ†  è¸ëéÿ‹@‰Eè3À‰†   ‰†$  9ƒ@  t‹‹8  ‰   ‹“<  ‰–$  ¾€  WèˆxßÿƒÄ…Àt7  SèuxßÿƒÄ…Àt$Wè´ßÿ‹ƒÄ‹È‹B$j ÿĞSè4¹ßÿƒÄ‹Èè
§ ¾    Wè>xßÿƒÄ…Àt;(  Sè+xßÿƒÄ…Àt(WèŞ³ßÿ‹ƒÄ‹È‹B$jÿĞSèª³ßÿ‹ƒÄ‹È‹B$jÿĞ3ÿ‰}ğèâêéÿ‹H‹‹BÿĞ…ÀtH‹Mè‹Y‹‹B‹ËÿĞ…Àu2ó~†  ‹‹RE¸fÖE¸ó~†  P‹ËfÖEÀÿÒÇEğ   …Àu‰}ğX  SèwßÿƒÄ…ÀtSè#³ßÿ‹Mğ‹‹R$ƒÄQ‹ÈÿÒ†`  PègwßÿƒÄ…Àt[‹M3À9¹à   •À‹ø†`  Pèä²ßÿ‹ƒÄ‹È‹B$WÿĞSè1wßÿƒÄ…Àt%…ÿu9}ğt¿   ë3ÿSè²²ßÿ‹ƒÄ‹È‹B$WÿĞ‹Îè®ÑÿÿMÈÇ†  ÿÿÿÿèlz ÇEü    MÔè]z ÆEüèÄééÿ‹H‹‹BÿĞ…Àt‹M‹UQÂ˜   REÔPMÈQ‹ÎèÉÍÿÿhøhh¬  èjÔQ ƒÄPU¼Rè=¹Q ƒÄ‹øÆEüj MÈèJz PMÔèAz P‹Ïè9z PE¬PèO¡Q ƒÄÆEüM¼è0‰z ˜  Qè²ßÿƒÄ‹Ø‹;j M¬èó~z ‹—   P‹ËÿÒ¾    WèvßÿƒÄ…Àtj‹E‹ˆì   j j jQU¼Rèì6z ƒÄÆEü‹Èè¾~z PMàèUz ÆEüM¼è¹ˆz Wè“±ßÿƒÄ‹Ø‹;j Màè‚~z P‹‡   ‹ËÿĞÆEüMàè‹ˆz ‹Eƒ¸ô    t‹ˆğ   ‰MëÇE    ‹˜   ‰]ğƒûÿu‹URèv;W ƒÄ‰Eğ‹ØEäSPètğÿÿ(  Q‹øèö°ßÿ‹‰”  ‹OUäSR‰ˆ˜  è;ñÿÿ‹ø†H
  PèÍ°ßÿ‹‰ˆ”  ‹W‰˜  †0  Pè°°ßÿ¨"  Q‹øèÂ°ßÿƒÄ ƒ} ‹Ø’   ‹UğREäPèÖñÿÿ‹‰”  ‹P‹ƒÄ‰—˜  ‹P$j‹ÏÿÒ‹Ej j jPMàQè¤5z ƒÄÆEü‹Èèv}z PM¼èŒz ÆEü
Màèq‡z ‹;j M¼èE}z ‹—   P‹ËÿÒ‹‹P$j‹ËÿÒÆEüM¼èC‡z ë‹‹P$j ‹ÏÿÒ‹‹P$j ‹ËÿÒ‹EğPMäQèòÿÿ–@  R‹øèĞ¯ßÿ‹‹]‰ˆ”  ‹WƒÄ‹˜   ‰˜  èNÿ ÷ØÀƒà‹ø‹ƒä   Pè‰ÚV MìWQÇEì   ‰EğèuKU ‹øƒÈÿƒÄ3Û‰Eä‰Eè;øt"Wh èU ƒÄ…ÀtWh ètU ƒÄ‹ØUäRSjèsC †8  Pèw¯ßÿƒÄMä‹øQ‹ÏègË ‹‹‚”   j‹ÏÿĞ¾P  WèmsßÿƒÄ…ÀtWè ¯ßÿ‹ƒÄ‹È‹B$j ÿĞ¾H
  WèFsßÿƒÄ…ÀtWèÙ®ßÿ‹ƒÄ‹È‹B$j ÿĞ¾°$  WèsßÿƒÄ…ÀtWèÒ®ßÿ‹ƒÄ‹È‹B$j ÿĞÆ¸&  ¿   VèórßÿƒÄ…ÀtVèÆ®ßÿ‹ƒÄ‹È‹B$j ÿĞÆ  OuÖÆEüM¬è£…z ÆEü MÔè—…z ÇEüÿÿÿÿMÈèˆ…z ‹Mô_^[d‰    ‹å]Â ÌÌÌÌÌS‹ÜƒìƒäğƒÄU‹k‰l$‹ìjÿhëc^d¡    Pd‰%    Sƒì8VW‹ù‰}Ü3À‰Eü‰‡à0  èúÌÿÿ·8  Vè>rßÿƒÄ…À„É   Vè®ßÿ‹s‰Eà‹C÷ŞöPƒæè§ØV MèVQÇEè   ‰Eìè“IU ‹ğƒÈÿƒÄ‰EÔ‰EØÇEì    ;ğt#Vh èU ƒÄ…ÀtVh èU ƒÄ‰Eì‹EìUÔRPjèˆA ‹uàƒÄMÔQ‹Îè‡É ói‹–x  óEÀ‰UìÇEÌ    fïÀfÖEÄó,EÀˆEï‹Mì‰x  ˆ†{  ·˜  Vè^qßÿƒÄ…Àt$Vè­ßÿ‹0ƒÄj K‰Eàèzz ‹Mà‹–   PÿÒ·(  Vè'qßÿƒÄ…ÀtFVèº¬ßÿói‹ˆx  óEÀ‰MìÇEÌ    ƒÄfïÀfÖEÄó,MÀˆMï‹Uì‰x  ˆˆ{  ·P  VèÎpßÿƒÄ…ÀtFVèa¬ßÿói‹ˆx  óEÀ‰MìÇEÌ    ƒÄfïÀfÖEÄó,MÀˆMï‹Uì‰x  ˆˆ{  ·`  VèupßÿƒÄ…ÀtVè¬ßÿ‹ƒÄ‹È‹B$jÿĞ·X  VèNpßÿƒÄ…ÀtVèá«ßÿ‹K‹‹R$ƒÄQ‹ÈÿÒ·    Vè%pßÿƒÄ…Àtf‹C j j jPMäQèû0z ƒÄÆEü‹ÈèÍxz PMĞèd‡z ÆEüMäèÈ‚z Vè¢«ßÿ‹0ƒÄj MĞ‰Eàèxz ‹Mà‹–   PÿÒÆEü MĞè˜‚z ·¸&  ÇEì   Vè¥oßÿƒÄ…ÀtVèx«ßÿ‹ƒÄ‹È‹B$j ÿĞÆ  ÿMìuÔƒ{0ÿu‹K$Qèp5W ƒÄ‰C0‹S0REÔPèmêÿÿ‹ğ‡(  Pèïªßÿ‹‰ˆ”  ‹V‰˜  ‹C0PMÔQè1ëÿÿ—H
  R‹ğèÃªßÿ‹‰ˆ”  ‹V‰˜  ‡0  Pè¦ªßÿÇ¨"  W‹ğè¸ªßÿƒÄ ƒ{$ ‹ø’   ‹K0QUÔRèÌëÿÿ‹‰”  ‹P‹ƒÄ‰–˜  ‹P$j‹ÎÿÒ‹C$j j jPMĞQèš/z ƒÄÆEü‹Èèlwz PMäè†z ÆEüMĞègz ‹7j Mäè;wz ‹–   P‹ÏÿÒ‹‹P$j‹ÏÿÒÆEü Mäè9z ë‹‹P$j ‹ÎÿÒ‹‹P$j ‹ÏÿÒ‹C0PMÔQèìÿÿ‹UÜÂ@  R‹ğèÃ©ßÿ‹‰ˆ”  ‹VƒÄ‰˜  ÇEüÿÿÿÿKèà€z ‹Mô_d‰    ^‹å]‹ã[Â, ÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhd^d¡    Pd‰%    QV‹uVè½mßÿƒÄ…ÀtVèğ¨ßÿƒÄ‹Èè6tãÿ‹ğèàéÿ‹@‹HÇEğ    ÇEü    ‹‹€ü   UğR‹–\  R‹–X  RÿĞÇEüÿÿÿÿ‹Eğ…Àt*HèymÒÿ…Àu‹Eğ‹PHQ‹ğÿÒVèáıy ƒÄÇEğ    ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌÌU‹ì‹UV‹ñ‹N;ÑvX‹ÁÑèÁ;ÂBÂ‰FiÀ  WPè·z ‹V‹MiÒ  ‹ø‹QWĞRPè
ìÿÿ‹N‹iÉ  ÈQPèöû÷ÿ‹Rèş¶z ƒÄ ‰>_^]Â ÌÌÌU‹ì‹EVP‹ñè±âÿÿ‰Ç °Ó¯ ‹‹ÆÇA€Å¯ ^]Â ÌÌÌÌÌÌÌÌÌU‹ìV‹ñ‹FiÀ  W‹}WP  Qè=íÿÿ‹ViÒ  RPè{û÷ÿƒÄÿN‹Ç_^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹MPQèPäÿÿƒÄ]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh(d^d¡    Pd‰%    QSV‹ñW3ÿ‰uğ‰>‰~‰~‰}ü¡ä*­‹à*­hè*­PNRèè~âÿ¡ä*­‹à*­hè*­P  RèË~âÿ¡ä*­‹à*­hè*­P   Rè®~âÿƒËÿ‰(  ¡ä*­‹à*­hè*­P0  Rèˆ~âÿ‰¾Ü	  †@  O‰Xø‰xü‰8‰x‰xƒÀIuì‰]ü‹Mô_‹Æ^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhHd^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹N‹iÉ  ÈQPèú÷ÿ‹Rèµz ‹MôƒÄ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhhd^Pd‰%    ƒìV3ö;şu3À^‹Môd‰    ‹å]Ãèxİéÿ‹H‹‹PÿÒ…ÀtÜS‰uä‰uè‰uì‰uüèXİéÿ‹@‹H‹‹@UğRUäRÿĞ‹]è3É;ŞvB‹EäƒÀd$ ‹·¸  Pø;0u!‹·¼  ;pu‹·À  ;pu‹·Ä  ;ptDA    ;ËrÈÇEüÿÿÿÿ‹Eè€‹EäÁáÈQPèŒ…æÿ‹UäRè#´z ƒÄ[3À^‹Môd‰    ‹å]Ã‹M;ÊtRèåÿÇEüÿÿÿÿ‹Eè€‹EäÁáÈQPèE…æÿ‹UäRèÜ³z ‹MôƒÄ[¸   ^d‰    ‹å]ÃÌÌÌÌS‹ÜƒìƒäğƒÄU‹k‰l$‹ìd¡    jÿh°d^Pd‰%    SƒìXVW‹ù·€  VèAißÿƒÄ…ÀtA‡  Pè.ißÿƒÄ…Àt.VèÁ¤ßÿ‹ƒÄ‹È‹B$jÿĞ‡  Pèç©ßÿƒÄj j‹Èè¹Ü 8  QèÍ¤ßÿ‹KƒÄ‰Eàèô ‹S÷Øö‹BLPƒæè\ÏV MèVQÇEè   ‰EìèH@U ‹ğƒÈÿƒÄ‰EØ‰EÜÇEì    ;ğt#Vh èÔU ƒÄ…ÀtVh èBU ƒÄ‰Eì‹EìUØRPjè=8 ƒÄMØQ‹Màè>À MÀèÖrz ÇEü    MÌèÇrz ÆEü‹Sj REÌPMÀQ‹ÏèN¿ÿÿhøhh¬  èïÅQ ƒÄPUäRèÂªQ ƒÄ‹ğÆEüj MÀèÏpz PMÌèÆpz P‹Îè¾pz PE´PèÔ’Q ƒÄÆEüMäèµzz ˜  Qè‰£ßÿ‹0ƒÄj M´‰Eìè‡pz ‹Mì‹–   PÿÒ·ˆ  VèŸgßÿƒÄ…À„  Vèn£ßÿƒÄƒ{ ‹ğtènÚéÿ‹@‹H‹‹PÿÒ…Àt¸   ë3À‹P‹B$‹ÎÿĞ‹Eà‹ˆx  ‰Mì3É‰M¬9KtzóióE fïÀfÖE¤ó,U ˆUï9ü  ujQjj è’ùy ƒÄ‰†ü  ‹K‹†ü  Q‹ÎÇ  î¯ èrmãÿ‹Có~€p  fÖ‡  ó~€x  ‹EàfÖ‡  ëó¤Ò|óE fïÀfÖE¤ó,U ˆUï‹MìŠUï·    ‰ˆx  Vˆ{  èfßÿƒÄ…Àtoƒ{ ti‹C‹HTj j jQU¤Rè['z ƒÄÆEü‹Èè-oz PMäèÄ}z ÆEüM¤è(yz Vè¢ßÿ‹0ƒÄj Mä‰Eàèğnz ‹MàP‹†   ÿĞÆEüMäèøxz ·P  VèfßÿƒÄ…ÀtVèŸ¡ßÿ‹ƒÄ‹È‹B$j ÿĞ·H
  VèåeßÿƒÄ…ÀtVèx¡ßÿ‹ƒÄ‹È‹B$j ÿĞ·`  Vè¾eßÿƒÄ…ÀtVèQ¡ßÿ‹ƒÄ‹È‹B$j ÿĞ·(  Vè—eßÿƒÄ…ÀtVè*¡ßÿ‹ƒÄ‹È‹B$j ÿĞÆEüM´èPxz ÆEü MÌèDxz ÇEüÿÿÿÿMÀè5xz ‹Mô_d‰    ^‹å]‹ã[Â U‹ìƒ=ßÊ tFV‹ğiö(=  W¾(ßÊWèeßÿƒÄ…Àt'Wè± ßÿ‹ƒÄ‹È‹B$jÿĞ‹M‹UQR0áÊèpûÿÿ_^]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhèd^Pd‰%    ƒì8ƒ=ßÊ SW„À  ‹}iÿ(=  Ÿ(ßÊSè¡dßÿƒÄ…À„   Sè0 ßÿ‹ƒÄ‹È‹B$jÿĞÇEğ    èf×éÿ‹H‹‹BÿĞ…ÀtMèS×éÿ‹@‹X‹‰Eğ‹B‹ËÿĞ…Àu+‹‹REP‹ËÿÒ…Àt‹Eğ‹€¬   …Àtƒx  ÇEğ   tÇEğ    ‹Mè£ÓÿÿMÔè‹nz ÇEü    Màè|nz ÆEüj VMàQUÔR0áÊè»ÿÿhøhh¬  è£ÁQ ƒÄPE¼Pèv¦Q ƒÄ‰EìÆEüj MÔè‚lz PMàèylz ‹MìPèplz PMÈQè†Q ƒÄÆEüM¼ègvz ‹Îè ğ ‹U ó~EfÖ‡@ãÊó~ERP‹ÎfÖ‡HãÊèªî ‹NT‹UğP‹EPQR‹Îè†î P‹FLPƒìUÈ‹Ì‰eìRèğmz ÆEüÆEü0áÊèğÿÿÆEüMÈèñuz ÆEü Màèåuz ÇEüÿÿÿÿMÔèÖuz ‹Mô_d‰    [‹å]ÃÌÌÌÌÌÌU‹ìjÿhde^d¡    Pd‰%    ìÄ  SVW3ÿ‹Ù‰]ì‰}à‰}ä‰}è‰}üó~ƒ  ƒì‹ÄfÖ ó~ƒ  fÖ@Eà‰eğPè²Óÿÿ‹‹  Q‹ğè$İV ‹ØƒÄ;ßuƒşÿtèÁ«P ö@t*èf´ßÿÇEüÿÿÿÿ‹Uä‹EàiÒP  ĞRPè/æÿ‹EàPéÅ  è¼éÿ‰EğèÕéÿ‹x¹ˆf­è—Lîÿ‹Eğ;Ãu4‹‹B‹ÏÿĞ…Àt¨‹¿¤   èèÔéÿ‹M‹@j	Ç˜   WQ‹Èèahıÿé  …À„™  …Û„‘  ƒÎÿ9°P’  …_  9°X’  …S  ‹‹B‹ÏÿĞ…À„  ‹‡¬   3ö;Æ„ô   9p „ë   ‹O³¸  VèØåÿ…Àtp€ıÿÿèù÷åÿÆEü‹O‹‹R …€ıÿÿPVÿÒ‹Eì‹ˆ  Qƒì‹Ì‰eğè¼kz ÆEüè#Ôéÿ‹M‹@j•€ıÿÿRQÆEü‹ÈèØŠıÿÆEü €ıÿÿè‰yåÿé=  ‹Uì‹‚  ‹MPQ•ÀıÿÿRèÊÖÿÿƒÄPMè.ôÿÿÆEüó~fÖEĞó~FfÖEØè²Óéÿ‹@‹H‹‹@dURUĞRÿĞÆEü MèA-æÿéÕ  ‰uÔ‰uØ‰uÜÆEü‹‹‹’˜   VEÔP‹ÏÿÒ€şÿÿè€7ÿÿÆEü3ÿ9uØvnëI ‹EÔÆP0üÿÿè¿×åÿÆEüĞüÿÿQ‹¸  èÙåÿ„ÀuÆEü0üÿÿèf
åÿGÆP  ;}Ørºë!•0üÿÿR€şÿÿèFåÿÆEü0üÿÿè7
åÿ‹Eì‹ˆ  Qƒì‹Ì‰eğè`jz ÆEüèÇÒéÿ‹M‹@jj•€şÿÿRQÆEü‹ÈèzZıÿÆEü€şÿÿèë	åÿÆEü MÔèWæÿéÓ   ‹Uì‹‚  Pƒì‹Ì‰eğj SQè¿ÂV ƒÄÆEüècÒéÿ‹U‹HRÆEü è£¾üÿé—   èi±ßÿ‰uüMàè¾Væÿ‹Môd‰    _^[‹å]Â ƒşÿto‹EäH…öy3öë;ğ~‹ğiöP  uà€şÿÿVèÖåÿ³	ˆ]üjÿƒì‹Ì‰eğè{iz ÆEü
èâÑéÿ‹U‹@jj€şÿÿQRˆ]ü‹Èè–YıÿÆEü €şÿÿè	åÿh”³­h  èˆ¼Q ƒÄPèŸ@ ‹Eì8  Pèšßÿ‹ƒÄj j‹È‹‚¤   j ÿĞÇEüÿÿÿÿ‹Mä‹EàiÉP  ÈQPèP+æÿ‹UàRè§¨z ‹MôƒÄ_^d‰    [‹å]Â ÌU‹ìjÿh¸e^d¡    Pd‰%    ƒìDS3ÛVW‹ù‰]ä‰]è‰]ì‰]üó~‡  ƒì‹ÄfÖ ó~‡  fÖ@Eä‰eğPè(Ïÿÿ‹  Q‹ğèšØV ‹øƒÄ‰}ğ;ûu*ƒşÿu%ÇEüÿÿÿÿ‹Uè‹EäiÒP  ĞRPè*æÿ‹EäPé  è?éÿ;Ãt;ût;ø„Ú  ƒşÿtMè…Ğéÿ‹@‹şiÿP  }äM°Q‹ÈèÌ• ‹—    ;u%‹¤   ;Hu‹—¨   ;Pu‹¬   ;H„tÿÿÿSjJèõÖàÿƒÄ…À„u  èuåÿ…À„h  MØè¥gz ÆEüMÌè™gz ³ˆ]üj j EÀjƒşÿtv‹MäiöP  ”˜   RPè¿8 ƒÄÆEü‹Èè±ez PMØh}Qèòoz ƒÄˆ]üMÀè¤oz ƒìUØ‹Ì‰eğRèsgz ÆEüuäMÀÆ    VQˆ]üèùÃN ƒÄÆEüë~‹uğó~†¸  Æ¸  U°RfÖE°ó~FPfÖE¸èV. ƒÄÆEü‹Èè(ez PMØh}Qèioz ƒÄˆ]üMÀèoz ƒìUØ‹Ì‰eğRèêfz ÆEüVEÀPˆ]üèyÃN ƒÄÆEüPMÌè™pz ˆ]üMÀèŞnz h Çè™ßÿƒÄjMÌ‹ğè¥dz P‹Îèç ÆEüMÌè±nz ÆEü MØè¥nz ÇEüÿÿÿÿ‹Mè‹EäiÉP  ÈQPè‰(æÿ‹UäRèà¥z ‹MôƒÄ_^d‰    [‹å]Â ÌÌÌÌÌÌÌÌÌÌU‹ìì  ƒ=ßÊ u	èy­ßÿ‹å]ÃV‹uVè;™ßÿ‹\  ƒÄˆ`  ‹€X  QRPøıÿÿèXnâÿ•øıÿÿè=¹ÿÿƒøÿu
è3­ßÿ^‹å]Ã‹ÈiÉ(=  VÁ0áÊè*øÿÿ^‹å]ÃÌÌÌÌÌU‹ìd¡    jÿh f^Pd‰%    ƒìS‹]VW‹ù‹Ë+¸à~÷é‹GÁú‹òÁîò9Gu	@P‹Ïè—íÿÿ‹G‹‹ÈiÉ  Ê‰Mğ;ğs@iö  ò3ÀUˆE‰Uì‰Mè‰Eü;ÈtVè®ÓÿÿÇEüÿÿÿÿÿG_^[‹Môd‰    ‹å]Â 3ÀUˆE‰Uè‰Mì¾   ‰uü;ÈtSèqÓÿÿÇEüÿÿÿÿw‹Mô_^[d‰    ‹å]Â ÌÌÌÌU‹ì‹EViÀ  ‹u‹V‹iÒ  ÁPÑR  PèÔÚÿÿ‹NiÉ  QPèé÷ÿƒÄÿN^]ÃÌÌÌÌÌÌÌÌÌ¸Pğ¯ Â ÌÌÌÌÌÌÌÌU‹ìjÿhf^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹N‹iÉ  ÈQPè¶è÷ÿ‹Rè¾£z ƒÄöEt	Vèïéy ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌS‹ÜƒìƒäğƒÄU‹k‰l$‹ìd¡    jÿhÇf^Pd‰%    Sìø   V‹ñW¾€  WèYßÿƒÄ…Àt=†  PèûXßÿƒÄ…Àt*Wè”ßÿ‹ƒÄ‹È‹B$j ÿĞ†  Pè´™ßÿƒÄ‹ÈèŠ‡ †    Pè¾XßÿƒÄ…ÀtA¾(  Wè«XßÿƒÄ…Àt.†    PèX”ßÿ‹ƒÄ‹È‹B$jÿĞWè$”ßÿ‹ƒÄ‹È‹B$jÿĞ¾`  WèjXßÿƒÄ…ÀtWèı“ßÿ‹ƒÄ‹È‹B$j ÿĞ3À‰Eä‰Eì‹C‹x‹ˆX–  ‰MèƒÿÿtO‹ø[ÖRÿ‚{‹ ‹ ‹€8  …Àt4‹Wè`äÿ…Àt(ƒ}èt"Q‹ÌÇ3óÿÿ‹È‰eàè³­X …Àt¸   ‰Eä‰Eè¾h  WèØWßÿƒÄ…ÀtWèë—ßÿ‹Mä‹‹R$ƒÄQ‹ÈÿÒ¾p  Wè¯WßÿƒÄ…À„‘   Wè>“ßÿ‹ø‹C‹ƒÄƒ¸X–   ‹B$‹Ïuj ÿĞëmjÿĞMØèôaz ÇEü    ‹Eèƒøuhœië$ƒ{ t&ƒètHt
Huh€iëhdiëhHiMØèbtz MØèê_z P‹ÏèBëÿÇEüÿÿÿÿMØèóiz †X  PèWßÿƒÄ…À„Ÿ   ƒ}ä u}èáÉéÿ‹H‹‹BÿĞ…ÀtjèÎÉéÿ‹@‹x‹‰Eì‹B‹ÏÿĞ…ÀuH‹Có~€¸  ‹‹RfÖEÀó~€À  EÀP‹ÏfÖEÈÿÒ…Àt‹Eì‹€¬   …Àtƒx  ÇEì   tÇEì    †X  Pè’ßÿ‹Mì‹‹R$ƒÄQ‹ÈÿÒ‹†  PèÑV ƒÄ…Àu‰†à0  ‹Îèí°ÿÿ‹{‹W‰  èŒvéÿƒÄM´‰Eìè`z ÇEü   M¨è`z ÆEüøşÿÿè ê ÆEü•øşÿÿRè0ëÿÿƒÄj …Àt…øşÿÿPM¨QU´R‹Îèñ¬ÿÿë)‹CPMÄQè¹V ƒÄÆEüPM´èBjz ÆEüMÄè†hz ƒ}ì th@iM´è3uz høhh¬  èT³Q ƒÄPUÄRè'˜Q ƒÄ‹øÆEüj M´è4^z PM¨è+^z P‹Ïè#^z PEœPè9€Q ƒÄÆEüMÄèhz ˜  Qèîßÿ‹8ƒÄj Mœ‰EèèÜ]z ‹Mè‹—   PÿÒ¾    WèUßÿƒÄ…Àtl‹C‹ˆP–  j j jQUÄRèÔz ƒÄÆEü	‹Èè¦]z PMØè=lz ÆEüMÄè¡gz Wè{ßÿ‹8ƒÄj MØ‰Eèèi]z ‹MèP‹‡   ÿĞÆEüMØèqgz ‹{‹OQÇEäÿÿÿÿè^bX ƒÄ…Àt	‹Œ   ‰Uä‹‡    Pè¢Ò ƒÄ…Àt‹Hd‰Mäƒ}äÿu‹—T–  RèCW ƒÄ‰Eä‹EäPMÜQè@Ïÿÿ–(  R‹øèÂßÿ‹‰ˆ”  ‹W‰˜  ‹EäPMÜQèĞÿÿ‹ø†H
  Pè–ßÿ‹‰”  ‹O‰ˆ˜  †H
  Pèyßÿ‹ƒÄ‹È‹B$jÿĞ0  Qè_ßÿ–¨"  R‹øèqßÿ‰Eè‹CƒÄƒ¸T–      ‹MäQUÜRè~Ğÿÿ‹‰”  ‹P‹ƒÄ‰—˜  ‹P$j‹ÏÿÒ‹C‹ˆT–  j j jQUØRèFz ƒÄÆEü‹Èè\z PMÄè¯jz ÆEüMØèfz ‹Eè‹8j MÄèä[z ‹Mè‹—   PÿÒ‹Mè‹‹P$jÿÒÆEüMÄèàez ë‹‹P$j ‹ÏÿÒ‹Mè‹‹P$j ÿÒ‹EäPMÜQèºĞÿÿ–@  R‹øèlßÿ‹‰ˆ”  ‹W‹K‰˜  ƒÈÿ‰EÜ‰Eàj EÜPQèãéÿ–8  Rèwßÿ‹øƒÄEÜP‹Ïègª ‹‹’”   3À9Eì‹Ï”ÀPÿÒ¾P  WèfRßÿƒÄ…ÀtSWèùßÿ‹ø‹‹P$ƒÄj‹ÏÿÒó¤Ò|‹‡x  óEÀ‰EèÇEÌ    fïÀfÖEÄó,EÀˆEë‹Mè‰x  ˆ‡{  ƒ}ì Q†P  u‹Só‚@–  ëWÀó$è¥«ÿÿƒÄ¾°$  WèÖQßÿƒÄ…À„¿   Wè…ßÿƒÄ‹øè[ß ‹‰EìP‹B$‹ÏÿĞƒ}ì tO‹Kö¤  tCh(ih…  è]¯Q ƒÄPUÄRè0”Q ƒÄÆEü‹Á   ‰Mìj ‹Èè%Zz P‹Eì‹‹ÏÿÒëAhih…  è¯Q ƒÄPEÄPèí“Q ƒÄÆEü‹Á   ‰Mìj ‹ÈèâYz ‹UìP‹‹ÏÿĞÆEüMÄèìcz ¾¸&  WÇ†ä0      èöPßÿƒÄ…À„å   ƒ=ßÊ t:‹÷ÇEì   ë¤$    hijèöO ‹øƒÄ‹Æè®ÿÿÆ  ÿMìuİé¢   èÌ ‹…ÉtHë‹Mìƒy$‹Ql‰Uìu1‹A;†  u&‹ription",
				name = "",
				width = "full",
				order = 10,
			},
		
			---------------------
			-- PLAYERNAME
			---------------------
			playerName = {
				type = "input",
				name = L["Player Name"],
				order = 15,
				width = "normal",
				hidden = ADJUSTMENT_KEYS[newAdjustmentTemplate.type] ~= ADJUSTMENT_KEYS.PLAYER_NAME,
				get = function(info) return newAdjustmentTemplate.playerName end,
				set = function(info, value)
					local playerName = strtrim(value)
					if string.len(playerName) > 0 then
						newAdjustmentTemplate.playerName = playerName
					else
						newAdjustmentTemplate.playerName = nil
					end
					self:BlizOptionsTable_Spells()
				end,
			},
			---------------------
			-- LEVEL
			---------------------
			level = {
				type = "range",
				min = 10, max = 85, step = 1,
				name = L["Level"],
				order = 15,
				width = "normal",
				hidden = ADJUSTMENT_KEYS[newAdjustmentTemplate.type] ~= ADJUSTMENT_KEYS.PLAYER_LEVEL,
				get = function(info) return newAdjustmentTemplate.level end,
				set = function(info, value)
					newAdjustmentTemplate.level = value
					self:BlizOptionsTable_Spells()
				end,
			},
			
			---------------------
			-- TALENT SPEC
			---------------------
			talentSpecDropDown = {
				type = "select",
				name = L["Primary Tree"],
				order = 15,
				style = "dropdown",
				width = "normal",
				hidden = ADJUSTMENT_KEYS[newAdjustmentTemplate.type] ~= ADJUSTMENT_KEYS.TALENT_SPEC,
				values = _specializations,
				get = function(info) return newAdjustmentTemplate.specialization end,
				set = function(info, value)
					newAdjustmentTemplate.specialization = value
					self:BlizOptionsTable_Spells()
				end,
			},
			spacer1B = {
				type = "description",
				name = "|TInterface\\BUTTONS\\UI-GuildButton-PublicNote-Up:0:0:0:0|t "..L["|cFFFF3333Missing Talents:|r Hermes has yet to inspect a player of this class for talent information. Try again later when this class is in your group."],
				width = "double",
				order = 18,
				fontSize = "medium",
				hidden = not (tablelength(_specializations) == 0 and ADJUSTMENT_KEYS[newAdjustmentTemplate.type] == ADJUSTMENT_KEYS.TALENT_SPEC),
			},
			---------------------
			-- TALENT NAME
			---------------------
			talentNameDropDown = {
				type = "select",
				name = L["Talent Name"],
				order = 15,
				style = "dropdown",
				width = "normal",
				hidden = ADJUSTMENT_KEYS[newAdjustmentTemplate.type] ~= ADJUSTMENT_KEYS.TALENT_NAME,
				values = _talentNameKeys,
				get = function(info) return newAdjustmentTemplate.selectedIndex end,
				set = function(info, value)
					newAdjustmentTemplate.selectedIndex = value
					newAdjustmentTemplate.talentIndex = _talentNameValues[value].index
					newAdjustmentTemplate.talentName = _talentNameValues[value].name

					self:BlizOptionsTable_Spells()
				end,
			},
			spacer2B = {
				type = "description",
				name = "",
				width = "full",
				order = 20,
			},
			
			---------------------
			-- OFFSET
			---------------------
			spacer5A = {
				type = "description",
				name = "",
				width = "full",
				order = 30,
			},
			offset = {
				type = "input",
				name = L["Cooldown Offset"],
				order = 50,
				width = "normal",
				get = function(info)
					if(newAdjustmentTemplate.offset ~= nil) then
						return format("%.0f", newAdjustmentTemplate.offset)
					else
						return ""
					end
				end,
				hidden = newAdjustmentTemplate.type == nil,
				set = function(info, value)
					local n = tonumber(value, 10)
					
					if n then --go ahead and allow offset's of zero
						newAdjustmentTemplate.offset = n
					else
						newAdjustmentTemplate.offset = n
					end
					self:BlizOptionsTable_Spells()
				end,
			},
			
			spacerFinal = {
				type = "description",
				name = "",
				width = "full",
				order = 99,
			},
			---------------------
			-- ADD BUTTON
			---------------------
			add = {
				type = "execute",
				name = L["Add"],
				width = "normal",
				order = 100,
				disabled = core:IsAdjustmentTemplateComplete() == false,
				func = function()
					--create the requirement
					local key = ADJUSTMENT_KEYS[newAdjustmentTemplate.type]
					
					local adjustment = {
						k = key,
						offset = newAdjustmentTemplate.offset,
					}
					
					if key == ADJUSTMENT_KEYS.PLAYER_NAME then
						adjustment.name = newAdjustmentTemplate.playerName
					elseif key == ADJUSTMENT_KEYS.PLAYER_LEVEL then
						adjustment.level = newAdjustmentTemplate.level
					elseif key == ADJUSTMENT_KEYS.TALENT_SPEC then
						adjustment.specialization = newAdjustmentTemplate.specialization
						adjustment.specializationName = _specializations[newAdjustmentTemplate.specialization]
					elseif key == ADJUSTMENT_KEYS.TALENT_NAME then
						adjustment.talentIndex = _talentNameKeys[newAdjustmentTemplate.talentIndex]
						adjustment.talentName = _talentNameKeys[newAdjustmentTemplate.talentName]
					else
						error("unknown key")
					end
	
					-- make sure a table exists for this spell
					if not dbg.adjustments[spellId] then
						dbg.adjustments[spellId] = {}
					end
					
					--store the adjustment
					tinsert(dbg.adjustments[spellId], adjustment)
					
					--reset the template
					ResetAdjustmentTemplate()
					
					--update everything
					self:ResetNonHermesPlayers()
					
					--update display
					LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					self:BlizOptionsTable_Spells()
				end,
			},
		},
	}
	
	optionTables.args.Spells.args[tostring(spellId)] = {
		type = "group",
		inline = true,
		name = "|T"..spell.icon..":0:0:0:0|t "..spell.name.." "..L["Adjustments"],
		order = 15,
		args = {

		},
	}
	
	for id, a in pairs(dbg.adjustments) do
		if id == spellId then
			for index, adjustment in ipairs(a) do
				--process the name
				local adjustmentName
				local key = adjustment.k

				if key == ADJUSTMENT_KEYS.PLAYER_NAME then
					adjustmentName = format(L["Offset cooldown by |cFF00FF00%s|r if player name is |cFF00FF00%s|r"], tostring(adjustment.o), tostring(adjustment.name))
				elseif key == ADJUSTMENT_KEYS.PLAYER_LEVEL then
					adjustmentName = format(L["Offset cooldown by |cFF00FF00%s|r if player level is at least |cFF00FF00%s|r"], tostring(adjustment.o), tostring(adjustment.level))
				elseif key == ADJUSTMENT_KEYS.TALENT_SPEC then
					adjustmentName = format(L["Offset cooldown by |cFF00FF00%s|r if player specced |cFF00FF00%s|r"], tostring(adjustment.offset), Hermes:GetSpecializationNameFromId(adjustment.specialization))
				elseif key == ADJUSTMENT_KEYS.TALENT_NAME then
					adjustmentName = format(L["Offset cooldown by |cFF00FF00%s|r if player has |cFF00FF00%s|r or more points in |cFF00FF00"]..tostring(adjustment.talname).."|r", tostring(adjustment.o), tostring(adjustment.talrank))
				else
					error("unknown key")
				end
	
				optionTables.args.Spells.args[tostring(spellId)].args[tostring(index)] = {
					type = "group",
					inline = true,
					name = "",
					order = 5,
					args = {
						name = {
							type = "description",
							name = adjustmentName,
							order = 5,
							width = "normal",
							desc = tostring(spellId),
						},
						delete = {
							type = "execute",
							name = L["Delete"],
							width = "normal",
							order = 15,
							desc = adjustmentName,
							func = function()
								tremove(a, index)
								--update everything
								self:ResetNonHermesPlayers()
								LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
								self:BlizOptionsTable_Spells()
							end,
						},
					},
				}
			end
		end
	end
end

local _showingInstructions
function core:LoadBlizOptions()
	optionTables = {
		handler = core,
		type="group",
		childGroups = "tab",
		name = HERMES_VERSION_STRING,
		args = {
			General = {
				name = L["General"],
				type="group",
				order = 0,
				args = { },
			},
			Spells = {
				name=L["Spells"],
				type="group",
				childGroups="tab",
				order = 1,
				disabled = function() return dbp.enabled == false end,
				args = { }
			},
			Items = {
				name=L["Items"],
				type="group",
				childGroups="tab",
				order = 2,
				disabled = function() return dbp.enabled == false end,
				args = { }
			},
			Maintenance = {
				name=L["Maintenance"],
				type="group",
				childGroups="tab",
				order = 99,
				disabled = function() return dbp.enabled == false end,
				args = { }
			},
		},
	}
	
	core:BlizOptionsTable_General()
	core:BlizOptionsTable_Maintenance()
	
	LIB_AceConfig:RegisterOptionsTable(HERMES_VERSION_STRING, optionTables)
	LIB_AceConfig:RegisterOptionsTable(AddonName.." ".."Command Line", slashCommands, {"hermes"})
	
	core.blizzOptionsFrame = LIB_AceConfigDialog:AddToBlizOptions(HERMES_VERSION_STRING, HERMES_VERSION_STRING)
	
	optionTables.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(Hermes.db)
	optionTables.args.Profiles.order = -1
	
	LIB_AceConfigDialog:SetDefaultSize(HERMES_VERSION_STRING, 800, 550)
end

function core:UpdateBlizOptionsTableReferences()
	--core:BlizOptionsTable_General()
	core:BlizOptionsTable_Spells()
	core:BlizOptionsTable_Items()
	core:BlizOptionsTable_PluginList()
	core:BlizOptionsTable_Plugins()
end

function core:BlizOptionsTable_General()
	if(optionTables.args.General.args) then
		wipe(optionTables.args.General.args)
		optionTables.args.General.args = {}
	end
	
	local instructionsText = L["Instructions"].." >>"
	if _showingInstructions then
		instructionsText = "<< "..L["Instructions"]
	end
	
	optionTables.args.General.args["General"] = {
		type = "group",
		name = L["General"],
		inline = true,
		order = 0,
		args = {
			EnableHermes = {
				type = "toggle",
				name = L["Enable Hermes"],
				width = "normal",
				get = function(info) return dbp.enabled end,
				order = 0,
				set = "OnSetEnabled",
			},
			ConfigMode = {
				type = "toggle",
				name = L["Config Mode"],
				width = "normal",
				disabled = function() return dbp.enabled == false end,
				get = function(info) return dbp.configMode end,
				order = 5,
				set = "OnSetTestMode",
			},
		}
	}
	
	optionTables.args.General.args["Communication"] = {
		type = "group",
		name = L["Communication"],
		inline = true,
		order = 1,
		disabled = function() return dbp.enabled == false end,
		args = {
			EnableSender = {
				type = "toggle",
				name = L["Enable Sending"],
				width = "normal",
				get = function(info) return dbp.sender.enabled end,
				disabled = function() return dbp.configMode == true or dbp.enabled == false end,
				order = 20,
				set = "OnSetEnableSender",
			},
			Spacer2A = {
				type = "description",
				name = "",
				width = "double",
				order = 25,
			},
			Spacer2B = {
				type = "description",
				name = "",
				width = "full",
				order = 30,
			},
			EnableReceiver = {
				type = "toggle",
				name = L["Enable Receiving"],
				width = "normal",
				get = function(info) return dbp.receiver.enabled end,
				disabled = function() return dbp.configMode == true or dbp.enabled == false end,
				order = 35,
				set = "OnSetEnableReceiver",
			},
			Spacer3A = {
				type = "description",
				name = "",
				width = "double",
				order = 40,
			},
			Spacer3B = {
				type = "description",
				name = "",
				width = "full",
				order = 45,
			},
			EnableParty = {
				type = "toggle",
				name = L["Enable Party Support"],
				get = function(info) return dbp.enableparty end,
				disabled = function() return dbp.configMode == true or dbp.enabled == false end,
				order = 50,
				set = "OnSetEnablePartySupport",
			},
			Spacer4A = {
				type = "description",
				name = "",
				width = "double",
				order = 55,
			},
			Spacer4B = {
				type = "description",
				name = "",
				width = "full",
				order = 60,
			},
		},
	}
	
	optionTables.args.General.args["CombatLogging"] = {
		type = "group",
		name = L["Spell Monitor"],
		inline = true,
		order = 2,
		disabled = function() return dbp.enabled == false end,
		args = {
			Spacer1A = {
				type = "description",
				name = L["Capture spell cooldowns for players without Hermes"],
				width = "full",
				order = 1,
				fontSize = "medium",
			},
			Spacer1B = {
				type = "description",
				name = "",
				width = "full",
				order = 2,
			},
			enabled = {
				type = "toggle",
				name = L["Enabled"],
				desc = L["Capture spell cooldowns for players without Hermes"],
				width = "normal",
				get = function(info) return dbp.combatLogging end,
				disabled = function() return dbp.enabled == false end,
				order = 5,
				set = function(info, value)
					--fire up or stop combat logging
					dbp.combatLogging = value
					
					if value == false then
						--prevent the user from drilling into the spell monitor detail pages, this just reset the state
						CONFIGURE_SETTINGS.mode = "list"
						CONFIGURE_SETTINGS.spell = nil
						CONFIGURE_SETTINGS.spellid = nil
					end
					
					LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					self:BlizOptionsTable_Spells()
					core:ResetNonHermesPlayers()
					core:OnSpellMonitorStatusChanged() --make sure the appropriate mods are running for spell monitor to work
				end,
			},
			InstructionsButton = {
				type = "execute",
				name = instructionsText,
				width = "normal",
				order = 15,
				desc = "",
				func = function()
					if _showingInstructions then
						_showingInstructions = nil
					else
						_showingInstructions = 1
					end
					--LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					core:BlizOptionsTable_General()
				end,
			},
			SpacerB = {
				type = "header",
				name = "",
				width = "double",
				order = 20,
				hidden = _showingInstructions == nil,
			},
			SpacerC = {
				type = "description",
				name = COMBAT_LOGGING_INSTRUCTIONS,
				width = "full",
				order = 25,
				fontSize = "medium",
				hidden = _showingInstructions == nil,
			},
		},
	}
	
	optionTables.args.General.args["PluginList"] = {
		name = L["Registered Plugins"],
		type = "group",
		inline = true,
		order = 4,
		disabled = function() return dbp.enabled == false end,
		args = {
		},
	}

	core:BlizOptionsTable_PluginList()
end

function core:CreateMissingSpellList()
	local result = {}
	--create a list of missing spells
	local playerAlliance = select(1, UnitFactionGroup("player"))
	for i, default in ipairs(DEFAULT_SPELLS) do
		local class = default[1]
		local spellid = default[2]
		local alliance = default[3]
		
		if(not alliance or (alliance and alliance == playerAlliance)) then
			--see if spell exists
			local exists = false
			for _, s in ipairs(dbp.spells) do
				if(s.id == spellid) then
					exists = true
					break
				end
			end
			
			if(exists == false) then
				local spell = core:FindSpellName(class, spellid)
				if(spell) then
					tinsert(result, spell)
				end
			end
		end
	end
	
	return result
end

local _expandMissingSpells = false
local _expandTalentStatus = false

function core:BlizOptionsTable_Maintenance()
	if(optionTables.args.Maintenance.args) then
		wipe(optionTables.args.Maintenance.args)
		optionTables.args.Maintenance.args = {}
	end
	
	if _expandMissingSpells == false then
		optionTables.args.Maintenance.args["UpgradeOptions"] = {
			name = L["Default Spells"],
			type = "group",
			inline = true,
			order = 5,
			args = {
				expand = {
					type = "execute",
					name = L["Show"].." >>",
					width = "normal",
					order = 5,
					disabled = function() return dbp.enabled == false end,
					func = function()
						_expandMissingSpells = true
						core:BlizOptionsTable_Maintenance()
					end,
				},
				spacer1 = {
					type = "description",
					name = L["List any default spells not in your inventory."],
					order = 10,
					width = "double",
				},
				spacer2 = {
					type = "description",
					name = "",
					order = 15,
					width = "full",
				},
			},
		}
	else
		optionTables.args.Maintenance.args["UpgradeOptions"] = {
			name = L["Default Spells"],
			type = "group",
			inline = true,
			order = 5,
			args = {
				expand = {
					type = "execute",
					name = "<< "..L["Hide"],
					width = "normal",
					order = 5,
					disabled = function() return dbp.enabled == false end,
					func = function()
						_expandMissingSpells = false
						core:BlizOptionsTable_Maintenance()
					end,
				},
				spacer1 = {
					type = "description",
					name = L["List any default spells not in your inventory."],
					order = 10,
					width = "double",
				},
				spacer2 = {
					type = "description",
					name = "",
					order = 15,
					width = "full",
				},
				list = {
					name = "",
					type = "group",
					inline = true,
					order = 20,
					args = {},
				},
			},
		}
		
		local spells = self:CreateMissingSpellList()
		local list = optionTables.args.Maintenance.args.UpgradeOptions.args.list.args
		for _, spell in ipairs(spells) do
			local item = {
				name = "",
				type = "group",
				inline = true,
				order = 20,
				args = {
					name = {
						type = "description",
						name = Hermes:GetClassColorString(spell.name, spell.class),
						order = 5,
						width = "normal",
						fontSize = "medium",
					},
					add = {
						type = "execute",
						name = L["Add"],
						width = "normal",
						order = 10,
						func = function()
							--add to db
							spell.enabled = false
							tinsert(dbp.spells, spell)
							--sort the spells
							sort(dbp.spells, function(a, b) return core:SortProfileSpells(a, b) end)
							--update spell monitor related data if available for this spell
							self:UpdateSMSSpellCooldown(spell.id, nil)
							self:UpdateSMSSpellMetadata(spell.id, nil)
							self:UpdateSMSSpellRequirements(spell.id, spell.class, nil)
							self:UpdateSMSSpellAdjustments(spell.id, spell.class, nil)
							core:FireEvent("OnInventorySpellAdded", spell.id)
							core:BlizOptionsTable_SpellList()
							core:BlizOptionsTable_Maintenance()
						end,
					},
				},
			}
			tinsert(list, item)
		end
	end
	
	optionTables.args.Maintenance.args.md = {
		name = L["Spell Metadata"],
		type = "group",
		inline = true,
		order = 15,
		args = {
			md = {
				type = "execute",
				name = L["Update Metadata"],
				width = "normal",
				order = 10,
				disabled = function() return dbp.enabled == false end,
				func = function()
					--refresh all the spells in case it's stale
					for _, spell in ipairs(dbp.spells) do
						core:UpdateSMSSpellMetadata(spell.id, 1)
					end
					Hermes:Print("Spell metadata has been refreshed.")
				end,
			},
			spacer3 = {
				type = "description",
				name = L["Updates the metadata for the spells in your inventory with the latest values."],
				order = 15,
				width = "double",
			},
			spacer4 = {
				type = "description",
				name = "",
				order = 20,
				width = "full",
			},
		},
	}

	if _expandTalentStatus == false then
		optionTables.args.Maintenance.args["SpellMonitor"] = {
			type = "group",
			name = L["Spell Monitor"].." ( |cFF00FF00"..L["latest version"].." "..tostring(Hermes.SPELL_MONITOR_SCHEMA.schema).."-"..tostring(Hermes.SPELL_MONITOR_SCHEMA.revision).."|r )",
			order = 10,
			inline = true,
			args = {
				expand = {
					type = "execute",
					name = L["Show"].." >>",
					width = "normal",
					order = 5,
					disabled = function() return dbp.enabled == false end,
					func = function()
						_expandTalentStatus = true
						core:BlizOptionsTable_Maintenance()
					end,
				},
				spacer1 = {
					type = "description",
					name = L["Show spell monitor status for each class."],
					order = 10,
					width = "double",
				},
				spacer2 = {
					type = "description",
					name = "",
					order = 12,
					width = "full",
				},
			},
		}
	else
		optionTables.args.Maintenance.args["SpellMonitor"] = {
			type = "group",
			name = L["Spell Monitor"].." ( |cFF00FF00"..L["latest version"].." "..tostring(Hermes.SPELL_MONITOR_SCHEMA.schema).."-"..tostring(Hermes.SPELL_MONITOR_SCHEMA.revision).."|r )",
			order = 10,
			inline = true,
			args = {
				expand = {
					type = "execute",
					name = "<< "..L["Hide"],
					width = "normal",
					order = 5,
					disabled = function() return dbp.enabled == false end,
					func = function()
						_expandTalentStatus = false
						core:BlizOptionsTable_Maintenance()
					end,
				},
				spacer1 = {
					type = "description",
					name = L["Show spell monitor status for each class."],
					order = 10,
					width = "double",
				},
				spacer2 = {
					type = "description",
					name = "",
					order = 12,
					width = "full",
				},
				status = {
					type = "group",
					name = "",
					order = 15,
					inline = true,
					args = {
						
					},
				},
				header = {
					type = "header",
					name = "",
					order = 20,
					width = "full",
				},
				description = {
					type = "description",
					name = L["A full reset clears all cached talents, races, cooldowns, requirements and adjustments. Useful if Blizzard changes talents for any classes. Hermes will automatically rebuild talents and races while in a party or raid, and apply the latest cooldowns, requirements and adjustments."],
					order = 25,
					width = "double",
				},
				spacer3 = {
					type = "description",
					name = "",
					order = 30,
					width = "full",
				},
				clearcache = {
					type = "execute",
					name = L["Full Reset"],
					width = "double",
					order = 35,
					disabled = function() return dbp.enabled == false end,
					confirm = function() return L["All talents, races, cooldowns, requirements, and adjustment will be reset."] end,
					func = function()
						--wipe all the tables
						if dbg.races then dbg.races = {} end
						if dbg.classes then dbg.classes = {} end
						if dbg.adjustments then dbg.adjustments = {} end
						if dbg.requirements then dbg.requirements = {} end
						if dbg.cooldowns then dbg.cooldowns = {} end

						Hermes:LoadTalentDatabase(true)

						Hermes:Print(L["Reset complete."])
						
						
						--go ahead and manually queue up a talent update for yourself, so you at least get your own spells
						-- MOD_Talents:QueueTalentQuery("player") --one class is better than none!
						--update options
						core:BlizOptionsTable_Maintenance()
					end,
				},
			},
		}
		
		local status = optionTables.args.Maintenance.args.SpellMonitor.args.status.args
		for key, class in pairs(LOCALIZED_CLASS_NAMES) do
			local schemaname
			local talents = dbg.classes[key]
			local disabled = false
			if talents then
				if not talents.schema then
					schemaname = "|cFFFF0000"..L["Requires update"].."|r"
				else
					if talents.schema == Hermes.SPELL_MONITOR_SCHEMA.schema then
						if talents.revision == Hermes.SPELL_MONITOR_SCHEMA.revision then
							schemaname = "|cFF00FF00"..tostring(talents.schema).."-"..tostring(talents.revision).."|r"
						else
							schemaname = "|cFFFFA000"..tostring(talents.schema).."-"..tostring(talents.revision).."|r"
						end
					else
						schemaname = "|cFFFF0000"..tostring(talents.schema).."-"..tostring(talents.revision).."|r"
					end
				end
			else
				schemaname = L["No Talent Cache"]
				disabled = true
			end
			
			local item = {
				type = "group",
				name = "",
				inline = true,
				args = {
					class = {
						type = "description",
						name = Hermes:GetClassColorString(class, key),
						order = 5,
						width = "normal",
						fontSize = "medium",
					},
					updateclassschema = {
						type = "execute",
						name = schemaname,
						width = "normal",
						order = 10,
						desc = L["Click to replace talent related cooldowns, requirements and adjustments with the latest version."],
						disabled = disabled,
						func = function()
							self:UpdateSMSClass(key, 1) --force it
							--update options
							core:BlizOptionsTable_Maintenance()
							Hermes:Print(L["Done!"])
						end,
					},
				},
			}
			
			tinsert(status, item)
		end
	end
end

function core:BlizOptionsTable_Spells()
	if(optionTables.args.Spells.args) then
		wipe(optionTables.args.Spells.args)
		optionTables.args.Spells.args = {}
	end
	
	--if Spell Scanning got disabled, then reset mode back to list since no details pages are supported
	--if not dbp.combatLogging or dbp.combatLogging and dbp.combatLogging == false then
	--	CONFIGURE_SETTINGS.mode = "list"
	--	CONFIGURE_SETTINGS.spell = nil
	--	CONFIGURE_SETTINGS.spellid = nil
	--end
	
	if CONFIGURE_SETTINGS.mode == "spellmonitor" then
		core:BlizOptionsTable_SpellDetail()
	elseif CONFIGURE_SETTINGS.mode == "config" then
		core:BlizOptionsTable_SpellConfig()
	elseif CONFIGURE_SETTINGS.mode == "metadata" then
		core:BlizOptionsTable_SpellMetadata()
	elseif CONFIGURE_SETTINGS.mode == "list" then
		core:BlizOptionsTable_SpellList()
	elseif CONFIGURE_SETTINGS.mode == "requirements" then
		core:BlizOptionsTable_SpellRequirements()
	elseif CONFIGURE_SETTINGS.mode == "adjustments" then
		core:BlizOptionsTable_SpellAdjustments()
	else
		core:BlizOptionsTable_SpellList()
	end
end

function core:BlizOptionsTable_SpellList()
	if(optionTables.args.Spells.args) then
		wipe(optionTables.args.Spells.args)
	end

	--setup basic class structure
	for classEnum, className in ipairs(CLASS_ENUM) do
		
		local classGroup = {
			type = "group",
			inline = true,
			name = Hermes:GetClassColorString(core:GetLocalizedClassName(className), className),
			order = classEnum,
			args = { }
		}
		
		local groupHasSpells = false
		for i, spell in ipairs(dbp.spells) do
			local BASECOOLDOWN = dbg.durations[spell.id]
			local configureButtonName = L["Spell Monitor"].." |T"..""..":-0:-0:-0:-0|t" --forces a gap the same size as any other icon
			if BASECOOLDOWN ~= nil then
				configureButtonName = L["Spell Monitor"].." |T".."Interface\\RAIDFRAME\\ReadyCheck-Ready"..":0:0:0:0|t"
			end
			
			if(spell.class == className) then
				groupHasSpells = true

				classGroup.args[tostring(spell.id)] = {
					type = "group",
					inline = true,
					name = "",
					order = i,
					args = {
						name = {
							type = "toggle",
							name = "|T"..spell.icon..":0:0:0:0|t "..spell.name,
							order = 0,
							width = "double",
							desc = tostring(spell.id),
							get = function() return spell.enabled end,
							set = function(info, value)
								if(spell.enabled) then
									spell.enabled = false
									core:FireEvent("OnInventorySpellChanged", spell.id)
									if(Receiving == true) then
										core:StopTrackingAbility(spell)
									end
								else
									spell.enabled = true
									core:FireEvent("OnInventorySpellChanged", spell.id)
									if(Receiving == true) then
										core:StartTrackingAbility(spell)
									end
								end
							end,
						},
						configure = {
							type = "execute",
							name = "Configure",
							width = "normal",
							order = 10,
							desc = spell.name,
							func = function()
								CONFIGURE_SETTINGS.mode = "config"
								CONFIGURE_SETTINGS.spell = spell
								CONFIGURE_SETTINGS.spellid = spell.id

								LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
								self:BlizOptionsTable_Spells()
							end,
						},
					}
				}
			end
		end
		
		if(groupHasSpells) then
			optionTables.args.Spells.args[className] = classGroup
		end
	end
	
	optionTables.args.Spells.args.Create = {
		type="group",
		name= L["Add Spell"],
		inline = true,
		order = 0,
		args = {
			ClassSelect = {
				type = "select",
				name = L["Class"],
				order = 1,
				style = "dropdown",
				width = "normal",
				values = function()
					local values = {}
					values[L["-- Select --"]] = L["-- Select --"]
					for i, classFileName in ipairs(CLASS_ENUM) do
						values[classFileName] = Hermes:GetClassColorString(core:GetLocalizedClassName(classFileName), classFileName)
					end
					return values
				end,
				get = function(info) return newSpellTemplate.class end,
				set = function(info, value) newSpellTemplate.class = value end,
			},
			SpellNameOrId = {
				type = "input",
				name = L["Name or ID"],
				order = 2,
				width = "normal",
				get = function(info)
					if(newSpellTemplate.name ~= nil) then
						return newSpellTemplate.name
					elseif(newSpellTemplate.id ~= nil) then
						return format("%.0f", newSpellTemplate.id)
					else
						return ""
					end
				end,
				set = function(info, value)
					local n = tonumber(strtrim(value))
					local s = strtrim(value)
					if(strlen(s) == 0) then s = nil end
					if(n and n ~= 0) then
						newSpellTemplate.id = n
						newSpellTemplate.name = nil
					else
						newSpellTemplate.id = nil
						newSpellTemplate.name = s
					end
				end,
			},
			AddSpellButton = {
				type = "execute",
				name = L["Add Spell"],
				width = "normal",
				order = 3,
				func = function()
					if core:AddSpell(tonumber(newSpellTemplate.id), newSpellTemplate.name, newSpellTemplate.class) then
						--reset the entered data
						newSpellTemplate.id = nil
						newSpellTemplate.name = nil
						
						--force the config window to update with latest spell info
						LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
						core:BlizOptionsTable_Spells()
						core:BlizOptionsTable_Maintenance()
					end
				end,
				disabled = function()
					--ensure that a class is selected and that spell evaluates to a spell id or name
					return newSpellTemplate.class == L["-- Select --"] or (not newSpellTemplate.name and not newSpellTemplate.id)
				end,
			},
		}
	}
end

function core:BlizOptionsTable_SpellDetail()
	local spellId = CONFIGURE_SETTINGS.spellid
	local spell = CONFIGURE_SETTINGS.spell

	local BASECOOLDOWN = dbg.durations[spellId]
	
	optionTables.args.Spells.args.listButton = {
		type = "execute",
		name = "<< "..L["List"],
		width = "normal",
		order = 5,
		func = function()
			CONFIGURE_SETTINGS.mode = "list"
			CONFIGURE_SETTINGS.spell = nil
			CONFIGURE_SETTINGS.spellid = nil
			LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
			self:BlizOptionsTable_Spells()
		end,
	}

	optionTables.args.Spells.args.configButton = {
		type = "execute",
		name = "<< "..L["Configure"],
		width = "normal",
		order = 6,
		func = function()
			CONFIGURE_SETTINGS.mode = "config"
			LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
			core:BlizOptionsTable_Spells()
		end,
	}
	
	optionTables.args.Spells.args[tostring(spellId)] = {
		type = "group",
		inline = true,
		name = "|T"..spell.icon..":0:0:0:0|t "..spell.name.." "..L["Details"],
		order = 15,
		args = {
			duration = {
				type = "input",
				name = L["Base Cooldown"],
				order = 5,
				width = "normal",
				get = function(info)
					if BASECOOLDOWN == nil then
						return ""
					else
						return format("%.0f", BASECOOLDOWN)
					end
				end,
				set = function(info, value)
					local n = tonumber(value)
					if n and n > 0 then --don't allow negative numbers here
						--user entered a real number
						dbg.durations[spellId] = n
					else
						dbg.durations[spellId] = nil
					end

					LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					self:BlizOptionsTable_Spells()
					self:ResetNonHermesPlayers()
				end,
			},
			spacer1A = {
				type = "description",
				name = "",
				width = "full",
				order = 8,
			},
			spacer1B = {
				type = "description",
				name = "",
				width = "full",
				order = 15,
			},
			requirements = {
				type = "execute",
				name = L["Requirements"].." >>",
				width = "normal",
				order = 20,
				disabled = BASECOOLDOWN == nil,
				func = function()
					CONFIGURE_SETTINGS.mode = "requirements"
					LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					self:BlizOptionsTable_Spells()
				end,
			},
			spacer2A = {
				type = "description",
				name = "",
				width = "full",
				order = 25,
			},
			adjustments = {
				type = "execute",
				name = L["Adjustments"].." >>",
				width = "normal",
				disabled = BASECOOLDOWN == nil,
				order = 30,
				func = function()
					CONFIGURE_SETTINGS.mode = "adjustments"
					LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					self:BlizOptionsTable_Spells()
				end,
			},
			spacer3A = {
				type = "description",
				name = "",
				width = "full",
				order = 35,
			},
		},
	}

	optionTables.args.Spells.args.status = {
		type = "group",
		inline = true,
		name = "Status",
		order = 20,
		args = {
			noBaseCooldown = {
				type = "description",
				name = L["|cFFFF2200Base Cooldown Required:|r A Base Cooldown is required to enable Spell Monitor support."],
				width = "full",
				order = 10,
				fontSize = "medium",
				hidden = function()
					return BASECOOLDOWN ~= nil
				end,
			},
			tracking = {
				type = "description",
				name = L["|cFF00FF00Spell Monitor Enabled!"],
				width = "full",
				order = 20,
				fontSize = "medium",
				hidden = function()
					return BASECOOLDOWN == nil
				end,
			},
		},
	}
end

function core:BlizOptionsTable_Items()
	if(optionTables.args.Items.args) then
		wipe(optionTables.args.Items.args)
	end

	--setup basic class structure
	for classEnum, className in ipairs(CLASS_ENUM) do
		
		local classGroup = {
			type = "group",
			inline = true,
			name = Hermes:GetClassColorString(core:GetLocalizedClassName(className), className),
			order = classEnum,
			args = { }
		}
		
		local groupHasItems = false
		for i, item in ipairs(dbp.items) do
			if(item.class == className) then
				groupHasItems = true
				classGroup.args[tostring(item.id)] = {
					type = "group",
					inline = true,
					name = "",
					order = i,
					args = {
						name = {
							type = "toggle",
							name = "|T"..item.icon..":0:0:0:0|t "..item.name,
							order = 0,
							width = "double",
							desc = tostring(Hermes:AbilityIdToBlizzId(item.id)),
							get = function() return item.enabled end,
							set = function(info, value)
								if(item.enabled) then
									item.enabled = false
									core:FireEvent("OnInventoryItemChanged", item.id)
									if(Receiving == true) then
										core:StopTrackingAbility(item)
									end
								else
									item.enabled = true
									core:FireEvent("OnInventoryItemChanged", item.id)
									if(Receiving == true) then
										core:StartTrackingAbility(item)
									end
								end
							end,
						},
						DeleteButton = {
							type = "execute",
							name = L["Delete"],
							width = "normal",
							order = 2,
							desc = item.name,
							func = function()
								core:DeleteItem(item)
								LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
								core:BlizOptionsTable_Items()
							end,
							confirm = function() return L["Item will be deleted. Continue?"] end,
						}
					}
				}
			end
		end
		
		if(groupHasItems) then
			optionTables.args.Items.args[className] = classGroup
		end
	end
	
	optionTables.args.Items.args.Create = {
		type ="group",
		name = L["Add Item"],
		inline = true,
		order = 0,
		args = {
			ClassSelect = {
				type = "select",
				name = L["Class"],
				order = 1,
				style = "dropdown",
				width = "normal",
				values = function()
					local values = {}
					values[L["-- Select --"]] = L["-- Select --"]
					for i, classFileName in ipairs(CLASS_ENUM) do
						values[classFileName] = Hermes:GetClassColorString(core:GetLocalizedClassName(classFileName), classFileName)
					end
					return values
				end,
				get = function(info) return newItemTemplate.class end,
				set = function(info, value) newItemTemplate.class = value end,
			},
			ItemNameOrId = {
				type = "input",
				name = L["Name or ID"],
				order = 2,
				width = "normal",
				get = function(info)
					if(newItemTemplate.name ~= nil) then
						return newItemTemplate.name
					elseif(newItemTemplate.id ~= nil) then
						return format("%.0f", newItemTemplate.id)
					else
						return ""
					end
				end,
				set = function(info, value)
					local n = tonumber(strtrim(value))
					local s = strtrim(value)
					if(strlen(s) == 0) then s = nil end
					if(n and n ~= 0) then
						newItemTemplate.id = n
						newItemTemplate.name = nil
					else
						newItemTemplate.id = nil
						newItemTemplate.name = s
					end
				end,
			},
			AddItemButton = {
				type = "execute",
				name = L["Add Item"],
				width = "normal",
				order = 3,
				func = function()
					if core:AddItem(tonumber(newItemTemplate.id), newItemTemplate.name, newItemTemplate.class) then
						--reset the entered data
						newItemTemplate.id = nil
						newItemTemplate.name = nil
						
						--force the config window to update with latest spell info
						LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
						core:BlizOptionsTable_Items()
					end
				end,
				disabled = function()
					--ensure that a class is selected and that spell evaluates to a spell id or name
					return newItemTemplate.class == L["-- Select --"] or (not newItemTemplate.name and not newItemTemplate.id)
				end,
			}
		}
	}
end

function core:BlizOptionsTable_PluginList()
	if optionTables.args.General.args.PluginList.args then
		wipe(optionTables.args.General.args.PluginList.args)
	end
	
	for name, _ in pairs(Plugins) do
		optionTables.args.General.args.PluginList.args[name] = {
			type = "toggle",
			name = name,
			width = "full",
			get = function(info)
				return dbp.pluginState[name] == true
			end,
			order = 5,
			set = function(info, value)
				--start or stop the plugin based on change in state
				if value == false then
					core:DisablePlugin(name)
					dbp.pluginState[name] = false
					--reload the options
					LIB_AceConfigRegistry:NotifyChange(HERMES_VERSION_STRING)
					core:BlizOptionsTable_Plugins()
				else
					--for now, just restart hermes until I figure out a better solution to handle an addon being enabled while hermes is already running
					core:Shutdown()
					dbp.pluginState[name] = true
					core:Startup()
				end
			end,
		}
	end
end

function core:BlizOptionsTable_Plugins() --NOTE, DefaultUI addon is calling this directly, need to make into API
	local index = 5
	for name, plugin in pairs(Plugins) do
		--reset prior table if it existed
		if optionTables.args[name] then
			optionTables.args[name] = nil
		end
				
		if dbp.pluginState[name] == true then
			--the selected plugin is enabled
			local pluginOptions = nil
			--see if it has an options callback
			if plugin.OnGetBlizzOptionsTable then
				pluginOptions = plugin.OnGetBlizzOptionsTable()
			end
				
			--see if the options callback returned a table
			if pluginOptions then
				--manually control how to disable it
				pluginOptions.disabled = function() return dbp.enabled == false end
				optionTables.args[name] = pluginOptions
				optionTables.args[name].order = index
			end
			
			index = index + 1
		end
	end
end

function core:OnSetEnabled(info, value)
	dbp.enabled = value
	if(value == true) then
		core:Startup()
	else
		core:Shutdown()
	end
end

function core:OnSetTestMode(info, value)
	dbp.configMode = value
	
	if dbp.configMode == true then
		core:StartTestMode()
	else
		core:StopTestMode()
	end
end

function core:OnSetEnablePartySupport(info, value)
	dbp.enableparty = value
	core:UpdateCommunicationsStatus()
end

function core:OnSetEnableSender(info, value)
	dbp.sender.enabled = value
	core:UpdateCommunicationsStatus()
end

function core:OnSetEnableReceiver(info, value)
	dbp.receiver.enabled = value
	core:UpdateCommunicationsStatus()
end

-------------------------------------------------------------------
-- Talents
-------------------------------------------------------------------
function core:TalentUpdate(guid, unit, info)
	--only process players when we know everything we need to know
	if info.name and info.class_id then
		--update races table if missing, we want this even if unit is player
		core:ProcessRace(info.name)
		--see if this class needs spell monitor defaults
		--core:UpdateSMSClass(class, nil) --don't force an update
		
		--don't add yourself to Players or try to do any processing on it
		if not UnitIsUnit(unit, "player") then
			--process the player changes
			local player = core:ProcessPlayer(guid, info)
			--rebuild the spell duration table for the player
			core:BuildPlayerSpellCache(player, guid)
			--clear any cooldowns that are no longer reliable
			core:ResyncCooldowns(player)
			--if we're receiving, then we may need to reset this sender
			local sender = core:FindSenderByName(player.name)
			if Hermes:IsReceiving() and sender and sender.virtual then
				--the sender exists if this is true
				core:RemoveSender(sender)
			end
			
			if Hermes:IsReceiving() then
				local sender = core:FindSenderByName(player.name)
				if not sender then
					local classEnum = core:GetClassEnum(player.class)
					core:AddSender(player.name, classEnum, 1, info)
					--now go ahead and fire off a virtual instance for each spell
					for id, duration in pairs(player.spellcache) do
						local ability = core:FindTrackedAbilityById(id)
						local canCreateVirtualInstance = core:CanCreateVirtualInstance(ability)
						if canCreateVirtualInstance then
							local remaining = core:GetPlayerCooldown(player, id)
							core:AddVirtualInstance(player.name, player.class, id, remaining)
						end
					end
				end
			end
		end
	end
end

function core:TalentRemove(guid, unit, name)
	--remove from Players if it exists
	Players[guid] = nil
end

-------------------------------------------------------------------
-- Spell Monitor Schema
-------------------------------------------------------------------
function core:UpdateSMSSpellCooldown(id, replace)
	--------------------------
	--update cooldowns
	--------------------------
	local exists = dbg.durations[id]
	local cd = Hermes.SPELL_MONITOR_SCHEMA.cooldowns[id]
	if cd and (replace or not exists) then
		dbg.durations[id] = cd --update cooldown for this spell belonging to this class
	end
end

function core:UpdateSMSSpellMetadata(id, replace)
	--------------------------
	--update metadata
	--------------------------
	local schemametadata = Hermes.SPELL_MONITOR_SCHEMA.spellmetadata[id]
	
	if schemametadata then
		--make sure table exists
		local metadata = dbg.spellmetadata[id]
		if not metadata then
			dbg.spellmetadata[id] = {}
			metadata = dbg.spellmetadata[id]
		end
		
		--create/update as needed
		for schemakey, schemavalue in pairs(schemametadata) do
			--look for match
			local exists = nil
			for key, value in pairs(metadata) do
				if key == schemakey then
					exists = 1
				end
			end
			
			if not exists or replace then
				metadata[schemakey] = schemavalue
			end
		end
	end
end

function core:UpdateSMSSpellRequirements(id, class, replace)
	--------------------------
	--update requirements
	--------------------------
	local schemareqs = Hermes.SPELL_MONITOR_SCHEMA.requirements[id]

	if schemareqs then
		local requirements = dbg.requirements[id]
		if not requirements then
			dbg.requirements[id] = {}
			requirements = dbg.requirements[id]
		end
		
		local exists = nil
		for _, r in ipairs(requirements) do
			if r.k == REQUIREMENT_KEYS.PLAYER_LEVEL or r.k == REQUIREMENT_KEYS.TALENT_NAME or r.k == REQUIREMENT_KEYS.TALENT_SPEC then
				exists = 1
				break
			end
		end
		
		--if they don't exist, or we are going to replace them
		if not exists or replace then
			--remove existing
			if exists then
				local i = 1
				while i <= #requirements do
					local key = requirements[i].k
					if key == REQUIREMENT_KEYS.PLAYER_LEVEL or key == REQUIREMENT_KEYS.TALENT_NAME or key == REQUIREMENT_KEYS.TALENT_SPEC then
						tremove(requirements, i)
					else
						i = i + 1
					end
				end
			end

			--create new
			for _, schemareq in ipairs(schemareqs) do
				local k = schemareq.k
				if k == REQUIREMENT_KEYS.PLAYER_LEVEL then
					tinsert(requirements, { k = k, level = schemareq.level })
				elseif k == REQUIREMENT_KEYS.TALENT_NAME then
					local talents = dbg.classes[class]
					if talents then --will be nil for "ALL" class
						local talentIndex = schemareq.talentIndex -- talents.name[schemareq.talentIndex] --find the name of the talent by index
						if talentIndex then
							tinsert(requirements, { k = k, talentIndex = talentIndex })
						end
					end
				elseif k == REQUIREMENT_KEYS.TALENT_SPEC then
					local talents = dbg.classes[class]
					if talents then --will be nil for "ALL" class
						local specializationId = schemareq.specialization;
						if specializationId then
							tinsert(requirements, { k = k, specializationId = specializationId })
						end
					end
				end
			end
		end
	end
end

function core:UpdateSMSSpellAdjustments(id, class, replace)
	local schemaadjs = Hermes.SPELL_MONITOR_SCHEMA.adjustments[id]
	
	--if there are adjustments in the schema, then they are guaranteed to be any of PLAYER_LEVEL, TALENT_NAME, and TALENT_SPEC
	if schemaadjs then
		local adjustments = dbg.adjustments[id]
		if not adjustments then
			dbg.adjustments[id] = {}
			adjustments = dbg.adjustments[id]
		end
		
		--look for adjustments set to PLAYER_LEVEL, TALENT_NAME, or TALENT_SPEC
		local exists
		for _, a in ipairs(adjustments) do
			if a.k == ADJUSTMENT_KEYS.PLAYER_LEVEL or a.k == ADJUSTMENT_KEYS.TALENT_NAME or a.k == ADJUSTMENT_KEYS.TALENT_SPEC then
				exists = 1
				break
			end
		end
		
		--if they don't exist, or we are going to replace them
		if not exists or replace then
			--remove existing
			if exists then
				local i = 1
				while i <= #adjustments do
					local key = adjustments[i].k
					if key == ADJUSTMENT_KEYS.PLAYER_LEVEL or key == ADJUSTMENT_KEYS.TALENT_NAME or key == ADJUSTMENT_KEYS.TALENT_SPEC then
						tremove(adjustments, i)
					else
						i = i + 1
					end
				end
			end
			
			--create new
			for _, schemaadj in ipairs(schemaadjs) do
				local k = schemaadj.k
				if k == ADJUSTMENT_KEYS.PLAYER_LEVEL then
					tinsert(adjustments, { k = k, level = schemaadj.level, o = schemaadj.o })
				elseif k == ADJUSTMENT_KEYS.TALENT_NAME then
					local talents = dbg.classes[class]
					if talents then --will be nil for "ALL" class
						local talname = talents.name[schemaadj.talname] --find the name of the talent by index
						if talname then
							tinsert(adjustments, { k = k, talname = talname, talrank = schemaadj.talrank, o = schemaadj.o })
						end
					end
				elseif k == ADJUSTMENT_KEYS.TALENT_SPEC then
					local talents = dbg.classes[class]
					if talents then --will be nil for "ALL" class
						local specialization = schemaadj.specialization
						if specialization then
							tinsert(adjustments, { k = k, specialization = specialization, offset = schemaadj.offset })
						end
					end
				end
			end
		end
	end
end

function core:UpdateSMSClass(class, replace)
	--note that unless I start calling this method from outside TalentUpdate, class will never actually be "ANY".
	--also not sure how I'm going to handle spells belinging to the ANY class like racials. Maybe I just won't support them for now.
	if class and class ~= "ANY" then --class talents must be available and not set to "ANY"
		local talents = dbg.classes[class] --don't assume talents exist
		if talents then
			--only update if no schema set, always let the user choose when to update SMS, never do it for them.
			if not talents.schema or replace then
				--loop through all spell in inventory
				for _, spell in ipairs(dbp.spells) do
					--only process if the class of the spell matches the class of the scanned talents
					if spell.class == class then

						self:UpdateSMSSpellCooldown(spell.id, replace)
						core:UpdateSMSSpellMetadata(spell.id, replace)
						self:UpdateSMSSpellRequirements(spell.id, class, replace)
						self:UpdateSMSSpellAdjustments(spell.id, class, replace)
					end
				end
				
				--last step is to set the applied schema
				talents.schema = Hermes.SPELL_MONITOR_SCHEMA.schema
				talents.revision = Hermes.SPELL_MONITOR_SCHEMA.re ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh{^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹…Àt(Hè\Ñÿ…ÀuW‹>‹OGPÿÑWèÆ y ƒÄ_Ç    ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh8{^d¡    Pd‰%    QVW‹}‹‹ñ‰uğ‰…ÀtHèİÑÿÇEü    ‹G‰F‹O‰NÇEüÿÿÿÿ‹Mô_‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhX{^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹…Àt(Hè|Ñÿ…ÀuW‹>‹OGPÿÑWèæy ƒÄ_Ç    ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhx{^d¡    Pd‰%    QVW‹}‹‹ñ‰uğ‰…ÀtHèıÑÿÇEü    ‹G‰F‹O‰NÇEüÿÿÿÿ‹Mô_‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh˜{^d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹…Àt(HèœÑÿ…ÀuW‹>‹OGPÿÑWèy ƒÄ_Ç    ‹Mô^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìQ¹ğ·° ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸ğ·° ÃÌÌÌÌÌÌÌÌÌÌU‹ìQ¹ «° ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸ «° ÃÌÌÌÌÌÌÌÌÌÌU‹ìQ¹@¢° ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸@¢° ÃÌÌÌÌÌÌÌÌÌÌU‹ìQ¹p¥° ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸p¥° ÃÌÌÌÌÌÌÌÌÌÌU‹ìQ¹À¶° ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸À¶° ÃÌÌÌÌÌÌÌÌÌÌU‹ìQ¹Ğ¯° ¶Á5ÅiÀ“ ‰Mü¶Uş¶Í3Á¶MÿiÀ“ 3ÂiÀ“ 3ÁiÀ“ ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌ¸Ğ¯° ÃÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh¸{^Pd‰%    VÇEüÿÿÿÿ‹uƒ~r‹PèOy ƒÄ‹MôÇF   ÇF    Æ d‰    ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhØ{^Pd‰%    VÇEüÿÿÿÿ‹uƒ~r‹Pèïy ƒÄ‹MôÇF   ÇF    Æ d‰    ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿhû{^Pd‰%    VÇEüÿÿÿÿ‹uƒ~r‹FPèy ƒÄ‹Mô3ÀÇF   ‰FˆFd‰    ^‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌ¸à ° Â ÌÌÌÌÌÌÌÌ¸ ¡° Â ÌÌÌÌÌÌÌÌU‹ì‹E‹M‹UP‹QPèú¯ÿÿƒÄ]ÃÌÌÌÌÌU‹ì‹EPè¤´ÿÿƒÄ]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹‹UQRèN¶ÿÿƒÄ]ÃÌÌÌÌÌÌÌÌÌU‹ì‹E‹M‹UP‹QPè¸ÿÿƒÄ]ÃÌÌÌÌÌU‹ì‹EPèÄ½ÿÿƒÄ]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹‹UQRè¿ÿÿƒÄ]ÃÌÌÌÌÌÌÌÌÌU‹ì‹E‹MPQjjè,»ÿÿƒÄ]ÃÌÌÌÌÌÌÌU‹ì‹E‹MPQjj è»ÿÿƒÄ]ÃÌÌÌÌÌÌÌU‹ì‹E‹M‹PRèåÿÿƒÄ]Â ÌÌÌÌÌÌÌU‹ì‹EPèØÿÿƒÄ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹M‹UP‹EQ‹RQè&ÏÿÿƒÄ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹M‹UP‹EQ‹RQè&ÒÿÿƒÄ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EPèTãÿÿƒÄ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹M‹UP‹QPè:ÜÿÿƒÄ]Â ÌÌÌU‹ìjÿh¤|^d¡    Pd‰%    ì¤  SVPıÿÿèÕåÿÇEü    Mè&“y ÇEü   èŠûèÿ‹@‹H‹‹@ •PıÿÿR‹URÿĞ…ÀuÇEü   é  3öè[ûèÿ‹@‹H‹‹R… şÿÿPÿÒ…Àt¾   è9ûèÿ‹@‹H$‹‹@•PıÿÿRÿĞ÷ØÀ@Pj VPıÿÿQU¸Rèì[ ƒÄÆEüMÔè’y ‹ğ³ˆ]üM¸èÎy Ph}Vè›y ‹Ì‰eğPèWŸy ÆEü… şÿÿPMàQˆ]üè0ïM ƒÄ³	ˆ]üMÔè šy ‹Eƒè „Ø   H…¬  èÈşßÿƒx „  htnh   è_åP ƒÄPU¬Rè2ÊP ƒÄ‹ğÆEüj Màè?y P‹Îè'y PEÔPèM²P ƒÄÆEüM¬è.šy MàjQèc¦ıÿó~… şÿÿƒÄUÄfÖEÄó~…şÿÿRMìfÖEÌè*ñÿÿÆEüèúèÿ‹p…øşÿÿPMìQMàèËy Ph |UÔRj‹Îè¸ ÆEüMìéË   è÷ıßÿƒ8 „Í   hdnh   èäP ƒÄPE PèbÉP ƒÄ‹ğÆEü
j Màèoy P‹ÎèWy PMÔQè}±P ƒÄÆEüM è^™y UàjRè“¥ıÿó~… şÿÿƒÄEÄfÖEÄó~…şÿÿPMğfÖEÌèúïÿÿÆEüè1ùèÿ‹pøşÿÿQUğRMàèûy Ph |EÔPj ‹Îèè ÆEüMğè,„èÿˆ]üMÔèá˜y ÆEüMàèÕ˜y ÆEüM¸èÉ˜y ÇEü   Mèº˜y ÇEüÿÿÿÿPıÿÿèh˜äÿ‹Mô^d‰    [‹å]ÃÌÌÌÌÌÌÌÌU‹ìd¡    jÿhÀ|^Pd‰%    ƒìƒ} …É   h„nh   èLãP ƒÄPEèPèÈP ƒÄÇEü    è€üßÿƒx „…   jèOy Ç     ¹   ‰H‰EÇ `y° ‹UƒÄÇBPI° ˆMüèøèÿ‹@j h YàMQUèRj‹Èè˜ ÆEü ‹E…Àt,Hè…Ñÿ…Àu‹E‹PVHQ‹ğÿÒVè|y ƒÄ^ÇE    ÇEüÿÿÿÿMèè¢—y ‹Môd‰    ‹å]ÃÌÌÌÌU‹ìd¡    jÿh0}^Pd‰%    ƒìTƒ} SVW…†  ƒ} …|  hÈnh   è?âP ƒÄPE¸PèÇP ƒÄÇEü    MÄèĞy ÆEü‹u‹†   »   …Àt1jj S`  QU¬RèõW ƒÄÆEüPMÄè¥˜y ÆEüM¬èé–y M¬èy ‹øˆ]üMÄèÄŒy Ph}Wè—y ‹Ì‰ePèM›y ÆEü†  PMĞQˆ]üè&ëM ƒÄÆEüM¬è—–y UĞjRèÌ¢ıÿƒÄFPMèè]y ÆEüMèjQè®¢ıÿƒÄMÜèy ³ˆ]üƒ¾    t>j Mèè;Œy PMĞè2Œy PM¸è)Œy PU¬Rè?®P ƒÄÆEü	PMÜèÏ—y ˆ]üM¬ëch¨nh   èøàP ƒÄPE PèËÅP ƒÄ‹ğÆEü
j MèèØ‹y P‹ÎèĞ‹y PM¬Qèæ­P ƒÄÆEüPMÜèv—y ÆEü
M¬èº•y ˆ]üM è¯•y jèÈy Ç     Ç@   ‰EÇ py° ‹UƒÄÇB`I° ÆEüèŒõèÿ‹ph YàEPMèèX‹y PhœnMÜQj‹ÎèE ˆ]ü‹E…Àt*Hèƒ‚Ñÿ…Àu‹EP‹ğ‹@RÿĞVèëy ƒÄÇE    ÆEüMÜè•y ÆEüMèè	•y ÆEüM