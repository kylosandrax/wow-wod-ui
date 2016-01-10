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
			
			if(msgName and msgName == "INITIALIE̋�P  ��H  ��8  �X���=�j �E��   �E���X  �M�Q�@ ��M��E��E��E��M��ҹR �E��E�    �M�Q���+ P�U�R�E������]ԃ���D   ��`
  u�� 
  �M�P�E�PQ��������E��]�;}���   �����P
  �U�R�P�M�Q�z3�����
  �E����E���V  �$�h�� W��&�M���*} �e��8=���M���*} �e��]��E��XE��M��e܋M��uԋE�X��E��X�(��X]�(��M��E��Xփ���   �h/�wm/�r	/���   G��0�X��e�;��&����� 
  軭��P�� 
  蟶�����E������U��E�UP�@ ���)R �M�_��^[d�    ��]� �<���P
  �� 
  �U����ϋ��L���+��� /�rF�<���P
  �� 
  �(����ϋ�����+�P�� 
  �������E������M��U�MR�m���/�r4�<���P
  �� 
  �ݬ���ωE������+]���Ǭ�������jj�M�QP�����E�jj�U�R�E��E��E�P�E�������P
  �E��M��\E��\M܍<�M���Q�P�U�R�E��M��S����P
  ��,�� 
  �E��:����ˋ��1���+�P�� 
  �#�����u�E������E��M�EQ�|���jh�  hp�{j �Us{ ��j�| �I ��� ��� ��� �� ��������U��d�    j�h�J^Pd�%    ��   V��W�� 
  ��豫����u���
  �ω}�蝫�����1  ���N����E썆�
  ;�u��  ��  �#��\  t��   ��$  ���(  ��,  �}��x  �M�����i� S��������i� ���E��MȄ���  ����i� ��0  ������i� ���E��~
���
  uO�E� ��e�(��Yl,}�X�=�� ����   �M�Q�\ʋΉ}��M��ҋU�E�P�M�QR�0} �M��\M��8]���/��	  �M��\M�/���  ��P  ��H  ��X  ��=���l�����\  ����j ��h�����t�����
  ��Q�@ ���p���ǅx���   ��|����E�躴R �E��E�    ��l���Q���& �؍�h���SR�]�����]�W�����\  �E�t���
  ���
  �MЃ�D   ��8  �X��M̍�`
  u�E�P�E�PS���t����EЋ�\  ���]��E   ;�T
  ��  ����U��
��$    �U胾D   t��`  �M�;���  H;�u���
  ����
  9}�t��P
  ��M�Q��h���WR��-�����
  �E����Eԃ��t  �$�,�� W��&�M��R%} �e��8=���M��?%} �e��]�E�XE�(��E��X��M��XM��E��XE�j �E��E��E�P�M��X�Q�M��E��X.} ������   �} tW�U�Rh ֵ���f����E    ���  �E���\  Q�U�RSQ�M�����`����E�����d����E��$P�E�P�E�Q�M���`���RWPQ��h���R�=����0��E   �E��E�E�0�XE�@�E��E�;�T
  �[���� ֵ�����E������E�MQ�@ ��E�#R [�M�_^d�    ��]� jh�  hp�{j �n{ ��j�U| ���� ��� ��� ��� ����U��d�    j�h�J^P�Ed�%    W���   V���t� �@�@�@��\   ��  ���9��
  u9��
  ��  �� 
  賦������  ��x  �U�E��Ei�� ������i� ��f�E�UU�E���  S��0  W�   ��~���
  u+���\  Wɉ]��M�t���
  ���
  �E���8  �E�X���e��E�� (��Yl,}�\��M���=��X�� ��H  ��P  ��X  j �M�Q�@ ��E��M��EĉUȉU��M��}�R ���}��E�    �E�P����! P�M�Q�l���]؍U�R� ���]�M�U�E�PQR�|+} ���
  �E���E��t
��t��u�M��!} �e��8=��E��];�T
  �  �[���]��P
  �� 
  �������ϋ�����+�P�� 
  �����ϋ�����P���ӭ�����
  �;�~�ˋ��
  +�;�|��+Ë]��+х��|  ��x���R��p���R�U�RP��P
  Q�P�M�Q�`�����
  �E����E����  �$���� W��}�*�}���� } �e�8=���}���� } �e�]�E�XE�(���X�p����X���x����X��\�p����E��G�XE�E��XE��M��M��\M��E��8]�/���   �M��\M�/���   �U�R�E�P�M�Q�)} ����tljj��`���R�E�P��������  �Eԃ�j QQ�$�U�R��`���P�> �E����t'�E�� �E��@�E��@�E��@�E��E�XE�@��0�E�]�E;�T
  ������}��E������MQ�@ ��}�&R _[�M�^d�    ��]� jh�  hp�{j � j{ ��j��| ��� � ��� �� ����U��d�    j�h�J^Pd�%    ��S����\  ��   �M�E�PQ�h������U�R������j jP���.��������   V�u����   ��8
  W�<��M����{ �E�   �U�R�����{ �E�M�F�N�E������M��
�{ �WR�� 
  ����G�M�P��{ �E�   P����{ �E������M����{ �G�F�O�}�N��t����{ �Uj R�E�P ���_^�   [�M�d�    ��]� �M�3�[d�    ��]� ���������U��j�h�J^d�    Pd�%    QV��u��E������~r�P��R{ ���M��F   �F    � ^d�    ��]����������U��j�h0K^d�    Pd�%    ��$V�u�FWP�M����{ �E�    h(^��M����{ �=��{P�׃�����   h$^��M���{ P�׃�����   h ^��M���{ P�׃�����   h�?��M��i�{ P�׃���t|h�|�M��R�{ P�׃�����   �E�MPQ�M���{ �E��U�jR�u������M��
�{ P�N��{ P�E�P�'+P ���E������{ P�����{ �E��M����{ �$�M�UQR�M��#�{ �E��M���{ P����{ �E� �M����{ �E������M���{ �M�_^d�    ��]�����U��d�    j�hHK^Pd�%    V�uW�};�t$�
��$    �I �E��������b�{ ���u;�u�M�_d�    ^��]��������̸0�� � �������̸p�� � ��������V��F0�    j��  �N�N3�h�   P�F   �N�N�N�N �F(   �F$�O{ ���F,�`��^���������������U��j�hhK^d�    Pd�%    QV��u��E������~r�P�,P{ ���E�F   �F    � t	V�P{ ���M��^d�    ��]� ������U��j�h�K^d�    Pd�%    ��VW3��l������u�;�t0�u�}�����{ �E��~�~�E�����_��^�M�d�    ��]ËM��_^d�    ��]��U��d�    j�h�K^Pd�%    VW���E������}����{ �~,�`tjh)  hp�{j ��d{ ��j��{ W���3���F�W�Ή~�2���F�M�_d�    ^��]� ��+�V���	  ��L  ��6����L  j Q�M{ ��ǆL      ^�������������U���S�]V����
  .�=��W�}��DzWS�������\   t-��裐���E����   �M�Q���ҋMj �E�PQWS������WS�������_^[��]� �����������U��V����\  Wt1���
  ;��
  u#�}W虠����t�M�UQRW������_^]� _3�^]� �������U��d�    j�h�K^Pd�%    ��$  V����\  0u3�^�M�d�    ��]� S�^ �o���P�H� QRP�������4���������������;�*�u;�*���   ;��   ;K��   W�}�M�Q��W��������\  tY�M��>�{ �E�   �UR�E�PW���������t'�E������M��t�{ _[�   ^�M�d�    ��]� �E������M��M�{ ��\   t;�M�Q���i��������;�t�S���
  ���
  ������ǆ�
     ���
  �_[3�^�M�d�    ��]� �M�[3�^d�    ��]� S�ًCV�4@W�;���;�t���þ����0;�u�P�| ��_^[��������������S�ًCV�4@W�;���;�t��胾����0;�u�_^�C    [��U��UV��N;�vU�����;�BF����WP�| �MQ�N�����W��QP������N�����QP�y����R�q| �� �>_^]� ������U��Vj���P{ �H���     �@   ��t�UW�:�9�R�Q_�� 0�� ��@�m� ��^]� �����U��j�h!L^d�    Pd�%    ��SVW��3��}��K�������u���t�u��E�����{ �E�3��F�F�E����EP��� �{ �C�E������M�>�{ �M��_^[d�    ��]� ���������U��d�    j�h8L^Pd�%    V�q���AW�E��}�����{ �~,�`tjh)  hp�{j �$`{ ��j���{ W���B.���F�W�Ή~��-���F�M�_d�    ^��]� �������������U��d�    j�hXL^Pd�%    V�E������u�~r�P��I{ ���M��F   �F    � d�    ^��]��������������K1�������������U��j�h�L^d�    Pd�%    QSV��W�u��0^��E�   ��@  (��+����	  ��<  ��L  P����.���O�j P�,H{ ���O$3���<  ��@  �E����
  虻���E����
  芻���E���`
  �{����E���T
  ��P
  �<���;�t���X�����0;�u�P
  P�| ���E� �� 
  �3����E��������Uu���M�_^[d�    ��]������ ������������̋����������������At��\   t�   �3����������U���V���Fu%��*���*��uh�*�PQ���������^��]� S�]W3���\   tS�   衚����t�F$�N �V(RPQ�o�E���\  tP��uS���w�����t@��\  t7�U�RS�0������E�P���b���j jP����������t�V$�F �N(QRP���*���*�h�*�QR�u���6���_[��^��]� �����������U��j�h�L^d�    Pd�%    ��tSV�ً�T
  ��P
  �4vW�8����E�;�t�I ��虹����0;�u�E�3��x9�@  ��  ��\  ��   #�uP�� 
  ����_^[�M�d�    ��]Ë��ɷ����<  WPR�M��H����}�P�� 
  �Y����E������M�������\  t��4
  �� 
  � ������:  ���
  �E�   u�l{ ��
u�u�E�P�M����} �u��� 
  P�M��M�{ �E���\  �t�    t���3�P�M�VQ�7������M��|�{ P�M���} �u苳<  �> �E�    ��  �}� �E�t���ڲ���E�3��E�U�R�M�QPV���q����E��0���K  ��
u�t0�E�   �-  �� us+�<  j�j
P�� 
  �E�����P�� 
  �E�蟞���UЋ�VR�� 
  轰���E�F��tVP�E�P�� 
  ����P�� 
  蘰����<  �U؍t�  �}�t�Kk{ ���E��E�    u�E�   +�<  �E������΍4�E�PVQ�MԍM�Q�M��u��K�{ P�U�R�� 
  �ۥ������   �I �U؋E���t��~��<  �L���"t��(uH�E���<  ȉMȍp�����   �U�R��G����߃�����   ����� �$���� �UԍM�QVR�E�P�M�蹼{ P�M�Q�� 
  �I������q����uЋƉE���<  3ɀ< ��Qj
P�� 
  �;����ȋE܉MЃ��tA��8
  �p���8	u>�E�Vj j-P�� 
  �	���P�� 
  �-���F��E�;E�u��E��Q�� 
  �������M�VQ�� 
  ������E�F��t�U�VPR�� 
  �����P�� 
  �ڮ����<  u��> �~����E�P�� 
  �y����E��M����{ �E������M�辽} �M�_^[d�    ��]Ð��� ��           �����U���<V����\     ��   ����   SW�M�Q���ҍM���} �]��M���} �]���L  �	   ��P  �_��	��$    ����H  ��=���P  ��X  �E�P�� 
  �M�P�M�Q�U��E��MЉ]ԉ]��E������E���/E�w�E�/E�v7��L  �ϸgfff���������;��ËΉ�P  ����+����e���_[^��]���������������U��j�hM^d�    Pd�%    ��,S�_$���X�MfW��E�fE�fW�PfE���{ P��P ������   �M�Q���� �U�;u>�M�;Hu6�U�;Pu.�M�;Hu&j j �
���U�jR�_	����[�M�d�    ��]�V�u�W�}�j��E{ �H���     �@   ��t�1�y�E�� 0�� �E��@�m� �E�    �K��Rd�E�P�E�P���E������E���t*�H蠰����u�E��P�HQ����V�A{ ���E�    _^�M�[d�    ��]��������������U��S�]V���+�gfff��F��W�����9Fu	@P�������F���;��E��Ps����QR��������F_^[]� SR��������F_^[]� ��������������U��j�hIM^d�    Pd�%    ��SVW��3��u��EP�M��O�{ �E��O�t���؉]���t �]��E�����{ �E�3��C�C�E���M�Q�����{ �G�E� �M�� �{ 3ɉN�N�;�t
�p��V��w�7�E������M���{ �M�_��^[d�    ��]� ���������������U��j�hhM^d�    Pd�%    Q�VW���@�}����u�A��@    �q���A�E�����{ �~,�`tjh)  hp�{j �T{ ��j��{ W����"���F�W�Ή~�h"���F�M�_^d�    ��]������U��j�h�M^d�    Pd�%    Q�EV��j�j �F   �F    P�u�� ������E������M��^d�    ��]� ��������̸Т� � ��������U��j�h�M^d�    Pd�%    QW��3�9O��   SV���I 3ɋ�C�]��;�u�O��H�w���G�E����e�{ �~,�`��   S���`������   ��+3��v�   �ȃ���N$�����u~�N�S�Ή^�&����ts3ҋ�+�v�Ѓ��ȋF$��²�����"
ʈ�F� �O���^[�M�_d�    ��]�jh)  hp�{j �S{ ��j���{ jh�  ��jh�  ��jh�  ���������$�������������U��j�h�M^d�    Pd�%    Q�EV��j�j �F   �F    P�u�� �3����E������M��^d�    ��]� ���������U��V��������Et	V�<{ ����^]� ���������������U���4V��T   ��   ��L  ����   ��\  ���P  �E�P�ҋ�H  ��P  ��=���X  �E̸   �U��E܉E�R�� 
  �M�P�M�Q�E��M��E��Y�����M���} �E�����v��T  ��\  ��P  ���[�����������\     t$����   �M�Q���ҋ�@t�M�Q���  R���Ћ�����^��]���������U��d�    j�h�M^Pd�%    ��4V��<  ��t5�M��I �:u��t�P:Qu������u�3����������  �E�P�@��u�+�S�XW�]������   ��@  ��uW�0������;�}WP��<  P���������@  ��<  ��@  �M��<  PQR��2�����   ��~%��`{ ��	uh:  ��S ��9�H  u	�\  ��\  t{��<  SP�<c{ ����~f3���~`��<  j�h�^�Q���{����u>��<  �Dj}P���{����t$��<  +�+ǋ؋ES�R�Q�9{ ����]�G;�|���\  �������������P@j���҅�u��P@j���҅�u����\  t����<  j WP�M��*����E�    P�� 
  �7����E������M��������\  t
ǆ4
     ��������}��E���   WP���҅�_[u+�� V��������ȋB@j�Ѕ�tV������������ �M�^d�    ��]� ��������U�싁\  �UV�����;�^t$��t����\  �u���]� �����\  �c���]� ���������������U��d�    j�h`N^Pd�%    ��T
  �U��4H��y3��;���W�<@���P
  3�3ɉ}�M��E�9G�<  S�]V��I �O�4��>�  �M��Y�{ �E�   �V�ŰF�EЋNQ��苆��F�M�P��{ �E�P�M��2�{ �E��M��v�{ �M�+�gfff��C�������9Cu	@P��������C����<��}�E ;�s5���4��M�M�}��E���tNV�����{ �E��V�W�F�G�E��0�M�M��}��E���t�U�R���ȱ{ �E��ẺG�MЉO�E��E��   CE��E������M�趹{ �E�}�@�E�;G������E�^[�M�_d�    ��]� �������������U����UV���  ���  �E��ER�M�P���Vt���U��\��  � �|�8]�T�/�w�U��\��  T�/�v���%���^��]� ��������������U��j�h�N^d�    Pd�%    QV���E�    ���E�̉e�P謰{ �E��E� ���������E������M謸{ �M��d�    ^��]� ������������������������U��j�h�N^d�    Pd�%    Q�EV�E�    �uj�j �F   �F    P��� �,����E�    �M��E�   ��^d�    ��]��������������U��j�h�N^d�    Pd�%    QSVW���w3ۉ�_�_�_�F0j��  �    h�   P�}��N�N�F   �^�^�^�^ �F(   �F$�4{ ���F,�`�]��w�E������M��_^[d�    ��]�������U��j�h�N^d�    Pd�%    QV��u��E�    �����E������N�V���M�^d�    ��]��������U��j�hO^d�    Pd�%    ��Vj(�9{ ���N���    �F   �u��M��E�    ��t"�Ej�j �A   �A    P� �����E� �E������M��^d�    ��]� �����������U��d�    j�h8O^Pd�%    ��S3�V��\  ��<  ��@  ��D  W�}���	  ���	  ���
  ���
  ���	  ��   ���	  ��$  ���	  ��(  ���	  ��,  ���	  ��H  ���	  ��L  ��P  9��	  t��\  9��	  t
��\      ���	  ��`  9��	  t��\     �
��\  ����ه�	  ٞX  9��	  t	��\   ���\  �9��	  t��\  �   �
��\  ������	  ��T  ��\  9��	  t�tZ����Ή�\  �R����H���	  �����;�t;�t�������Ή�\  �&���9��	  t��\     �
��\  �������	  ��t��t��\  �����
��\     ��t��t��\  �����
��\     9��	  t	��\  ���\  �����   j����W���0  ه�	  ٞ�
  �� 
  ه�	  ٞ�
  ��4  ��8  ه
  ٞ�
  ه
  ٞ�
  ه
  ٞd  ه
  ٞh  ه
  ٞl  ه 
  ٞp  �ة{ P�E�P���R ���]��>j��轩{ ���   P���҃���}��M��ĳ{ �M��
  ���
  ���
  ���
  _^[d�    ��]� ���������U��j�h�O^d�    Pd�%    Q�ESVW�}��MPQW�Ήu������3ۉ]��� 
  �0^��֗���E���P
  ��T
  ��X
  �E���`
  豗���E����
  袗���E����
  蓗���E�W���g����E������M�_��^[d�    ��]� �����������U��j�h�O^d�    Pd�%    Q�ESVW�}P��W�u�����3ۉ]��� 
  �0^������E���P
  ��T
  ��X
  �E���`
  ������E����
  �����E����
  �ٖ���E�W�������E������M�_��^[d�    ��]� �U��j�h(P^d�    Pd�%    ���ESVWP�M�膶{ �E�    h�^��M��ҧ{ �5��{P�փ���u�Mh�{腾{ �Sh�|�M�覧{ P�փ���u<�]3�93t3�Ð��xh�^�Q���{����u�MW���̻{ ���<� ��uЍM�Q�M��D�{ ��]����U؋̉e�R�.�{ �E��M���]������E� �M��0�{ �E������M��!�{ �M�_^d�    [��]�U��j�hHP^d�    Pd�%    ��VW�}�GP�M��Ĩ{ �E�    �O����h(^��M�踦{ �5��{P�փ���tEh$^��M�蛦{ P�փ���t.h ^��M�脦{ P�փ���th�?��M��m�{ P�փ���uh�{���'�{ �E������M��X�{ �M�_^d�    ��]���������U��j�hsP^d�    Pd�%    QSVW���w3ۉ�_�_�_�F0j��  �    h�   P�}��N�N�F   �^�^�^�^ �F(   �F$�,{ ���F,�`�]��w�E������M��_^[d�    ��]�������U��j�h�P^d�    Pd�%    QV��u��E�   �����E������N����M�^d�    ��]��������U��EVP���!����� p�� ����AТ� ^]� ���������U��j�h�P^d�    Pd�%    ���   V�ufW��E�fE�fW�P��fE��Ѥ{ P�P ������  W�����x�M�Q�ω}��)� �U�;u�M�;Hu�U�;Pu�M�;H��  h��講��������  S3�SjJ�F��������   ���T�{ P�M�����]��U�R�E�P��������E�j(�^0{ ���N����F   �uȉM��E�;�tj�S�A   �YW�������E��E��u�p�� �M�AТ� �E��U��J�~E�f�E��~E�URf�E؋�@d�U�R���E��M�vg���]��}�r�M�Q�D+{ ���E�   �]��]��E������M������   ���   ;�t�����t�   �3��O�U�R��H��;�t;�tWh������S��S�E�P��0���Q��������E�   ��0���R���:��jhp�{�D ���E�������0����i���[_�M�3�^d�    ��]� ����U��j�h1Q^d�    Pd�%    ��SV��W�]��X�{ 3��u��K�K�{ �E��s�s�s �s$�{�w�F0�    j��  �N�N3�h�   P�}��F   �N�N�N�N �F(   �F$�1){ ���F,�`�E��w�E������M�_^��[d�    ��]�������U��j�hqQ^d�    Pd�%    ��V��W�u��E�   �~�}��E����&����E��O�����E� �N�Ϋ{ �E����������{ �M�_^d�    ��]�U��d�    j�h�Q^Pd�%    �E� �� HSVW�}��t)��u�����MWQ���ϟ���M�d�    _^[��]� ������w���Ǯ �$��Ʈ j ���������-t	����  ����  ��芺���   �M�d�    _^[��]� ���
   �i  �U�R��W�ت�����E�P���
������
  PQ���˸���   �M�d�    _^[��]� W���[������  �M�d�    _^[��]� ��\  �����U�R�_S�f������M���{ �E�   �EP�M�QS���E    ������t-�}u'�E������M��4�{ �   �M�d�    _^[��]� �E������M���{ �����M�3�螡{ �E�   �UR�E�P�OQ�Ή]�A�������   �E��u�U�R��f������   �   ��u�E�P�;������   �~��uW�M�Q���p�����ti�   �b��u]�M���{ �E��U�R�M��H�{ P�P ����t,Q�ĉe�     �E�j�M��!�{ P�E��������   �E��M��#�{ ���
   th�*�ǆ�
      ��������   �E������M���{ �ËM�d�    _^[��]� �M��r�{ �E�
   �EP�M�Q�WR���E    ������t�}uW�E�P���ۣ���E������M�茨{ �M�_^3�d�    [��]� �I Į ^Į �Į XŮ �Į �Ʈ �î  ��������U��j�hHR^d�    Pd�%    ���  VW������E�    �.����E�   j � �� �������PV�a8� hP�� h@�� V�8� hP�� V��8� �}�ǃ� �P�@��u�j+�PWV�g� ����uW��������{ V�e� �u�������Q���k�{ �E�   �E�   ��(����U��E��������E���8����z���E�������K�{ �E� ������<�{ �M��_^d�    ��]�����������U��Q�EP�=| ���E��E���y��=���^���]�������U��E��t�j P�}R ]�����������U���t��EP���Q ]�������������U��E����j P�l}R ]�����������U������EP��Q ]������������̋���������������U���E���M���A�X�A�@�X]� ����������U��E�A���|�X��I�QW�W�W�� �H�P]� ���U����E�Q�I�@�Y�(�E(��Y`(��Y��\�(��Y��X��(��Yx�Y��\��8�Y�(��Yu�X�(��Yu�\�(��Yx�X��u��u�Y�(��Y8�X��}�u(��Yx�X��u��E(��Yu�(��Y��\�(��Y}��X�(��Y��X��u�(��YU��Y��u�}(��Yu��\��}�u(��Y}��Y��Y��\��I�XM��X�(��Y]��Y��X��X��X���I�X��H�I�X��H��]� ����������U��E� �H�\I�\�P�\Q�Y�Y��Y��X��Y��X��Y�/�r	�   ]� 3�]� �������������U��E� ��@�Y�@�E�Y� �Y�@�Y�@�Y�I�Q�Y(��Y�(��Y��X�(��Y��X��Q���^�/�s'��=��^��Y��Y��Y��Q�I�Y]� ��������������U��E����j P�,zR ]�����������U������EP�n�Q ]�������������U����M���A�X�A�X�A�X�A�X�A�X�A�X�A�X�A �X ]� U����%��|�䫯�諯�쫯W�V�u�^0�X0}�n(�v,W�W��]�(��Y�(��Y��X�(��Y��X��Q���^�/��m��u��E��M��U�s-��=��^�(��Y�(��Y��Y��e��E��]��EP�M�Q�VR�E�P��} ����u^��]ËM�U�E�EQ�N`R�V\���D$�E��$P�FXQ�NPRPj Q�O����(�   ^��]����̡�+���t���	  �HQ��=	 Y�������U��]�G� �������U���+���t���	  ��t�M�H]����K���@8��������U��EP�Wi �M���H(]���������̡�+����	  �����U����M���Q�P�Q�P�Q�P�Q�P�Q�P�Q�P�Q�P�Q �P �Q$�P$�Q(�P(�Q,�P,�~A0f�@0�~A8f�@8�~A@f�@@�~AHf�@H�QP�PP�AT�XT�AX�XX�A\�X\�A`�X`�Ad�Xd]� ��U����M���A�X�A�X�A�X�A�X�A�X�A�X]� ������������U����M���A�X�A�X�A�X�A�X�A�X�A�X]� �����������̋��������������̋��������������̋��������������̋��������������̋�������������̋A�������������U��Ei�$  ]� ��������������U���Ek�h�  ]� �����������̋�������������̋�������������̋�������������̋�������������̋�������������̋Au�   �3�Ë�������������̋�������������̋Au�   �3�Ë�������������̋��������������U��EVj ���t�P�yuR ���^]� U��Q��M�Q��t��E���Q ��]����̋��������������U��EVj �����P�)uR ���^]� U��Q��M�Q�����E��h�Q ��]����̋�������������̋����  f��@    ��������������̋A�������������U��EVj �����P�tR ���^]� U��Q��M�Q�����E����Q ��]����̋��������������3���A�A�����̋���������������U��EP���{ ��]� �������������U��Ei�$  P��{ ��]� �������U��U���u3�]� ��;�   s�i�  �  3�9��I#�]� ���������̋A������������̋���������������U����M���Q�P�Q�P�Q�P�Q�P�Q�P�Q�P�Q�P�Q �P �Q$�P$�Q(�P(�Q,�P,�~A0f�@0�~A8f�@8�~A@f�@@�~AHf�@H�QP�PP�AT�XT�AX�XX�A\�X\�A`�X`�Ad�Xd]� ��U����M���A�X�A�X�A�X�A�X�A�X�A�X�A�X�A �X �A$�X$]� ����������U����M���A�X�A�X�A�X]� ��������������U����M���A�X�A�X�A�X�A�X�A�X�A�X]� ������������U����M���A�X�A�X�A�X�A�X]� ��������U����M���A�X�A�X�A�X�A�X�A�X�A�X]� �����������̋��������������3�;�tg���  f��  3�f��  ��   ��  ��  ;�v#3�k�h�  Bf�P��� ������;�   rߋ�   ��  k�h���  f�L����U��E�8��tX� ����Vf��  f�p��  f��  f;�  u)���$    ����  f�  ���hf9�  t�8�t���  ^]� ������U��U���u3�]� ��;�   s�k�h�  3�9��I#�]� �������������U��E���  Vf9u3�f���  �U�2�	�U�hf� ��  W���  f;�_t f90w�2�>�u��h�2f� f�0f;�  v�3�^]� ��^]� ���V��V��{ %�    w  ��f��  ^��V��   =��  r3�^�SW�< ����  r���  ��   ��  ��k�hh�   SPQ�{ ��   ��  ����;�s#��    k�h�  Af�H��� ������;�r㋖  ���  f�D�f��   ��+�   ��   _[f��  ��  �   ^�������������������������U��E]��������̋���������������U���+����	  �Ek�h�  ]���̋���������������U��U��+���`	  ���u3�]���;�   s�i�  �  3�9��I#�]����U����=��|�i�E��Y�aW�W�W���X�`�h�qW��IW��AW�(��Y��E��Y��\�(��Y��X��}��Y��E�(��Y��\�(��Y��X�(��Y��}�Y��u�(��Y��u�\��}��Y��X��}��Y��X��}��Y��X��M(��Y�(��Y��\��}�Y��X��M��}�(��YM��X��M��}��Y�(��Y��\��}�Y��X�(��Y��X��Y��U��Y��\��U�Y��X��U��Y��X��P�H�@��]� ��������������U���,�%��|��I�Q�q�i�yW��YW�W��}�W�W�W�(�(��Y��Y��\��u�(��Y��X��}��Y��e�(��Y��\�(��Y��X�(��Y��}��Y�(��Y��u��\��}��Y��X��}��Y��X��}��u��Y��Y��X��m��Y�(��Y��\��}��X�(��Y��X��u��u��Y�(��Y��\��u��Y��X�(��Y��X��m��m��Y��Y��\��Y��X�E�p�u(��Ym��X��(�e��`(��Y��e��m��Y��\�(��Y��X��}�Y��Y��\�(��Y��X��}��Y��Y��\��}�Y��X��}��Y��e��e��Y��X��}�Y��X��e�e��Y�(��Y��\��}�Y��X�(��Y��X��}��Y��e�(��Y��\��}�Y��X�(��Y��E�Y����|�Y��I�\��X��E��Y��X��E��XE��Xm��Y��X��Xe�(�W�/�r:/�r5�A (�W�/�r%/�r �A$(�W�/�r/�r�   ��]� 3���]� ���������V�z� �54����V���i �����j � �j j �# j 讈 �Y���V胏+ �3 �i���y��菧 �Z���e� �@�Q�* ���0 �������H0�H4�H8��+����	  ������H�H^���������U��V�u�FP��Hi ��E�,;���0;��F�4;��F�8;��V�<;�� �@;��@�D;��@���H;��@�L;�^]��������������U��E�,;��E� �0;��@�4;��@�8;��H�E�<;�� �@;��@�D;��@�H;��@�L;�]�������������P ��t#�r���@4��+�k�h���	  ��  �D�jh�  hp�{j �${ ��j�w�{ ������̋���������������U��V�u�> W�}t�FPW�V�p ����t	_�   ^]Ã>Su;�FP�_Sj �FWP��p ����t ��   �^�G�^�[�^�O_�N^]�j �Fj PW�G�i ����t=�FP�_Sj�FWP�L�p ��^���G�   �^�[�^�W�V_�   ^]��[�^�G�^�G�^�G�F�   �䫯�F�諯�F �쫯_�F$3�^]���������U��j�h�R^d�    Pd�%    ��$W��ES�]j ��C�C����P�fR �E�E�    �HH��  �H�QQ��  �I�y ��  V�q���!W��   Htjh  hp�{j ��"{ ��j譺{ �F����j P�LfR ���}��E�� ��   �G� ��t�j P�&fR �E��E�����S �(.�j P�
fR �E��E����  �	��t(�y ~"`  P�E�P�N����� ��@�[�@�[�E��M���(���E��M��G�����F��F�[�F �[�E� �M�Q�����}��   �F��t�j P�}eR �E��E����o�S �(.�j P�aeR ���}��E����  � ��t)�x ~#��`  R�E�P�N�s���� ��@�[�@�[�E��M�Q�(.��}��m�Q �E� �U���t��E�U�P�T�Q �E_^�E������MQ��E������UR�����E�)�Q �M�[d�    ��]�����������U��j�h�R^d�    Pd�%    Q�E��t�VWj P�   �dR ���u��E�    ���l�S P�&M������u	���X�S 3��E������M�Q��t��u���Q �M��_^d�    ��]������������U��j�h�R^d�    Pd�%    ��@�E����W3�WP��cR �E��H;�u!�M�Q�����9�Q �G_�M�d�    ��]�9yt �����U�R��Q 3�_�M�d�    ��]�S�Y�]�;�u$�����E�P���Q [�   _�M�d�    ��]É}�}�9{��   �}�V�H�Q�ru���!��   H��   �v����WV�2cR ���u؉}��~ ~13ۋ��F�| ~�P�]�������u�E�   G��;~|֋]��E������M�Q�����u��:�Q �}� u43��E�E�   @�E�;C}�E��W����VR���������u��E�   ^�����E�P���Q �M�E�[_d�    ��]ÍM��E�{ �E�   W�E�VP�_Q ���E��j Q�U�R��P �����E��FP���[�{ �PQ���P�{ P�U�h _�R葋{ ���E��M��B�{ �E��M��6�{ jh�  hp�{j �s{ ��j�9�{ ���������U��E� V�u��@�^�@�^��+���F��^]���������̋���������������U����M���A�X�A�X�A�X�A�X�A�X�A�X�A�X�A �X �A$�X$]� ���������̋�3ɉ�H�H���̋A�������������U��Q����U;�BAi�$  P�}�{ ��]� ������U��U���t��;�   sk�h�  9uP�w���]� ���U��E�PRP����]� ������������U��Ei��   ]� �����������������������������̋���������������U��V��W�}���O�N�W�V�G�F�G�^�O�GQ�^�N�G�^����ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ��ه�   ٞ�   ه   ٞ   ه  _ٞ  ^]� ��������������U���SVW����}��+�k�h�E����	  ��  �L>�M�������U�;u
j��,������E��H8;L>u�����T>R�� �E�P�e=i �M���	  �����t��;�   s��  �9uP������hL_�j jj�s{ ��_^[��]������������U��E؃�(P�q�p �U�M�QR��������]��������������U���8�E�P�A�p �E� �E��@�E��@�E��'���M�Q�U�R�E��L�������u�����]ËEЋ�]��������U��E��   VW�}��t�G��u�> t�F(PW�t�p ����t_�   ^��]���G�E��G�E��G�XE��T����\EP��X����E��$f���E���T����U��\���\����E���d�����`���W�(�(��Y�(��Y��X�(��Y��X��Q���^�/���h�����l�����p���s3��=��^��Y���h����Y��Y���l�����p���(ă>S�]��t�����x���uR�M�Q�UR�FP��\���P�C�} ����t3��E�^(�G�^,�G�^0�O�N4��t	�E�� [_�   ^��]Ë���	��R��X���P�4j+ ��^(���G�^,�G�^0�O�N4����   �E��t	�E�� �E��   �F�E��F�E��F�E��F�E��F�E��F�E��F�E��F �E��F$�E��F<�E��F@�E��FD��x��X���R�R+ ���FL��FL�����Eԋ�|����U��E��FP�E܉NT�M�[�F\_�F8�VX�N`�   ^��]�W��F8�   �䫯�F<�諯�F@�쫯����FD[�FL�FP�FT�FX�F\�F`_3�^��]������������U���d_��E�U���D$�0}�$j	�HQRP������]��������U���   �� �����K�Q ��u���]�V��#���u�F��^(��XM�\P}P��X����U��]��M��U��]��E���b���M��U��E��]��\���\����M��\���d�����`����U��\�(��Y�(��Y��X�(��Y��X��%�^��Q�/���h�����l�����p���rW��0�%�=��^��Y��Y��Y���h�����l�����p����E��X���j Q��t�����x����Cg+ ����t�E�^��]��F^��]�������������U���   V�q������ڱQ �u��u&�䫯��諯�F�쫯�F�E��X�@�@(��X�=��\P}P��X����U��]��M��U��]��E��Ka���M��U��E��]��\���\����M��\���d�����`����U��\�(��Y�(��Y��X�(��Y��X��%�^��Q�/���h�����l�����p���rW��0�%�=��^��Y��Y��Y���h�����l�����p�����X���j Q��t����e+ ����t"�E���E��F�E��F^��]��䫯��諯�F�쫯�F^��]�����U���+�SV���	  W�}���  3��d$ ���  f;�u
��  3����hfA��  ���  f;�tf;�w��8�ufA��hf;�v�_^3�[]Å�t�;xu�_^[]������������̋���������������U��V��W�}���O�N�W�V�G�F�G�^�O�GQ�^�N�G�^�����ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ه�   ٞ�   ��ه�   ٞ�   ه   ٞ   ه  _ٞ  ^]� �������������̋P�ش{ Y��������A    ���������U��Ei��   ]� ��������������U��d�    j�hS^Pd�%    ��V��   u$��   t	������u���^�M�d�    ��]���  S��W��k�h�  �E�f�GjhW�}�f��  ��z ���}����M���  �  ��É�Q;�uf�  ��  ��ˉf�  �  ��  ���  f;�tf;E�sf�E�f��  ��M�_[^d�    ��]��������U��SV�uWV�������E��  ��  �    ��~��  fփ�  ���  ���  ���  ���  ���  ���  ���  ���  ���  ���  ���  ���  �    �_^��[]� �S�܃������U�k�l$��j�h S^d�    Pd�%    S��(VW�J����KQ��迫Q �J����{W�q�������U��5����N�U�H0�P4�x8�0���F�E܍E�P�E�0   ��S ��S j菊 �NQ������j �P�P�! � �L� ��]�����P�������P�!1i �������E܋ j P�QR �E��E�    ���   �NP���   �VTـ�   �^X�E����������E�E�P��Q �x� ����j�W�[ j �KQ�� ��+����	  ���G    �E܋ ����j P�QR �E��E�   ��+��I8;Nd��   ���   �O�����   ���   �\��   W�/�v�M���E��������$P��| ���E��E̅�y��=���^��U����   �E�    �M��]��XE��Y�|�E�f��f�E��,EЅ�3���+��I8ȋE�Nd�E����������U�R�E���Q �M�_d�    ^��]��[������U��j�h@S^d�    Pd�%    ��SVW������MQ���r�Q ��+����	  �������+��M�؋��	  ��k�h�  j Q�U�j0R��KQ ���E�    ����n{ Phh_�j jj�Ee{ ���E������M��x{ �}�E����j ���PD��iOR �E�E�   P��Ci ���E������M�U�M����R��Q �E,�M(�U$P�E Q�MR�UP�EQ�MRPWQ�VR�p@i W�Z� ��,�����M��t��t3�MW�H0�X4�x8���p �M����tQW�Q�����������@<   �M�_�Fd    ^��[d�    ��]���������U��j��v��P� A������������x8�t�X����EjP�������]���������U��V��P��{ ���Et	V��z ����^]� ���������U��j�hhS^d�    Pd�%    ���M�M�M3��E�M�E�;�t	�UR������E������M�d�    ��]����������������U��d�    j�h�S^Pd�%    �E��;E��   S�]V�M���  W�M�u��d$ �E �]��E�    ��tl��x���R��� ����E��ƀ��  �    ��~ fփ�  �H���  �P���  �H���  �P���  �H���  �p���  �    ���E�������$  ��$  ��x����]�u�;U�Z���_^��[�M�d�    ��]ËM�Ed�    ��]�������U��UV��N;�vD�����;�BFi�$  WP��{ �V�Mi�$  ���QW�RP�����P��{ ���>_^]� �������U��� ���O ��tVV��������tH��[�P��{����8  ��t.�V��&������t �U�R���1�^ P�E�P��蕸^ P������^��]��������U��j�h�S^d�    Pd�%    ����+���8	  S�]�E���  ���  �U�f�E�R�E�P�E�    �*������   VW�d$ �}��t{��  ���tp����j P�pKR ���u��E�    ��  f��x1�;F }+i��   F���  PQ���{����tU�E������U�R��E������E�P�����u��n�Q �E�M�Q��8	  �U�R�*�����`���_^[�M�d�    ��]Ë��   ���  �E����������U�R�u���Q _^�M�[d�    ��]����������U���SVW���������  �5�+���8	  3�;���  P�}%���E�;���  ���	  �u��}�9{�k  �}����$    ��su����   ��   ���  ���t(��[�P��{����8  ��t�W�$������ub�U��B8+��  ��<vnV��������  �����u3��)��[�Q��{����8  ��u3��
�W�J$�����E��H8���  ��t����8_ ��uW��<_ ������   �FHtdHuy�E����   ���   �\��   �\��   ���   �\��   ���   �Y��Y��X��Y��X��Y�/�r!_��^[��]ËE��   P���   �������uߋE��E�$  @�E�;C�����_^3�[��]���������̋H4��P8�W�@<V�G��������t)���  ���t�G���  ���t����  ���t�G95<��t#��tj j �������  PQ�(B ���5<��^��������������U���S��+�V���  觡Q ��uR��+�j Q�U����  Rf�E��E�    �Й ������   ��I ��+��u�j P�M�Q��詙 ����u���+��P�uS P��Fi ��������   W�F�}���������	  �E����~ �u$j j P�G	 �F��;�tj j P�G	 ���^�}�;~tZ�~;�t9�VR�f�������uW�jQ�$Ph\��W�Xj ���F�$W���] ��FP�-�������t����a �^�E�_;FtP�F�Z	 ��^[��]��U��d�    j�h T^Pd�%    ��S�]VW����+��uy��G�������9Gu	@P��������G���i�$  ʉM�;�s@i�$  �3��U�E�U�M�E�;�tV�n����E������G_^[�M�d�    ��]� 3��U�E�U�M�   �u�;�tS�1����E�����w�M�_^[d�    ��]� ����U���+���$  S���	  ����   �MVQ������������E�~ �P�uh�   ������VPfօd�����l���������M�����    ��p���ǅ|���    ǅt���    t"���   h�   R�E�Pǅt���   �~�����������Q�K�l���^[��]�������U��d�    j�h!T^Pd�%    SVW�}jWjh$  ��z ���Eh   PV�"����E��   k�hj Wh�   P���z ��,�Ή�  ǆ  h   ��   ����V�d{ %�    w  f��  �\f��K��3�� ��3ɉE;�t�E�M��H�H�E��������7�C�O�O�C;�t�x�K�O��;�M�{_��^d�    [��]������������U��V�u���tc�\f����t��$    9t	�@��u��
��tP�y1�����   ��  QR��z �ǀ      ���   QP��z ���    ^]��������������U��j�hFT^d�    Pd�%    ��VW�6q ��q �zp �5�+�h   �T�O Ph�}�9������	  ���Ƹ	  j�u��0�O Pjj$�F�z �3ɉH�������B�>������W�>�W��B�6�����u�M�t��N�N�E��M�_^d�    ��]�����S��+�VW���  3����	  ���  f;�u
��  3����hfF��  ��f;�tf;�w�?�uVfF��hf;�v񍃴	  P�c������	  �HQ�D�{ �_�O ���	  PR�B�z ��ǃ�	      �`9q ��#q _^[�S�p ��t��P��������_�����������������̍�   ����������U��j�h�T^d�    Pd�%    QV��u��E�   ���   �Ok{ �E��Nt�Ck{ �E��Nh�7k{ �E��N\�+k{ �E��NP�k{ �E��ND�k{ �E��N8�k{ �E��N,��j{ �E� �N ��j{ �E������N��j{ �M�^d�    ��]��U��j�h�T^d�    Pd�%    Q�M��E��������%����M�d�    ��]��������U��j�h�T^d�    Pd�%    ��SVWh�g��H�����������	 3ɋ�3�+��M��M�tHtHu�E�   ��   ��E�   9MtHh�i����������ȋB$j ��hP���Ȓ������ȋB$j ��h���谒������ȋB$j ��h�i�蘒���M���R$��Q����hP���~�������ȋB$S��h����g����M��R$��Q����W���/�	    P�E�P耛R �E�    h�c��O��������7j �M��>_{ ���   P�����E������M��Di{ �M�_^[d�    ��]����Wh�g����������'P ��t?j ����	 ��t��ȋB$j ��Vj����	 ����tj j����	 ��B$j ����^j �A�����_�������������j�)���Y��������j h�a��D������B����ujj	�0&P ����t\h�a��?������@th���h  �W�R ��P�n7	 �jh�a�������h�g��#�����j j���U�	 j ����Y�������������U���x���]���' ��Vh�g�����h�a���蹐�����@t����	 ��uj h�a��x����^�^�-����������������U��VWh*�豐���}����`���u�`�Pj ���� ��_���u��_�Pj����� ��_���u��_�Pj���� ��_^h���th�   �<�R ��P�S6	 ��]�h�   �$�R ��P�;6	 ��]�������U��VWh�g������}����W����	 ��t6j W����	 h�a�詏�����@tj �I�����_^]Ë�ȋB$j��_^]����U��V�uV���������YZ���@��9t�P��� �@����QV��f��oJ��^]�������������U��d�    j�h U^Pd�%    ��VWh r����'����������u#����   j hp�{����_^�M�d�    ��]�j�V�2�a ��������   �SP�M�Q��ya ���E�    �j ����[{ ���   P���҃���}��M���e{ [9~tN����P�i�W �P�FPQ�U�R��|a ���E�   �M��v[{ Pht����������{ �}��M��ve{ �M�_^d�    ��]�������U��d�    j�hpU^Pd�%    ��@VWhv���������������u��P$j ����_^�M�d�    ��]�������4  �M�Q�U�R�M�Q�U�RWP�N�a �����  �E܋M�PQ�������}� �E�u$��u �}��u�P�B$����_^�M�d�    ��]Ë�B$Sj����h8���P���h(|����D���hx����8�������}���؋B$����   j�Ћ�B$j ���Ћ�B$j ����h@��融������B$��j���ЋM�Q����W���U�R����	 �E�j P�M�j1Q�7Q ���E�    �M���Y{ Ph�  �ڮR ��P�U�R譓R �E�hH��诌�������7j �M��Y{ P���   �����E� �M��c{ �E������M��c{ [_^�M�d�    ��]�j �ЋE�j ����   �RP�M�Q�*5X �����E� 		handler(...)
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
ez ���F$    ����V���� 
  t9W�>�����������;N u�P;V$u���  ��P���W����	j ���<��_���  ���;�t��+�@9Bv���  ���  ^�����U����M���A�X�A�X�Q�P�Q�P�Q�P�Q�P�Q�P�Q �P �Q$�P$�Q(�P(�Q,�P,�Q0�P0�A4�X4�A8�X8�A<�X<�Q@�P@�ID�HD]� ���������̡D����t3�9HX���HX������������U����=D�� tQ�EVP�g�W ������t=�yuQ �E��|���}��E�   �E��m��}�U���p�  �m���x��t�  ^��]������������̋��@    ������̋�������������̋��������������U��M��P@�]� ��������������̋�������������̋A�������������3�9A����������U��E�M:�r��]����������������U��E3�V9Pt,9Pt�H�P�Q�H�P�Q^]� �p�V�@�^]� 9Pt�p�V�P�Q^]� ��Q^]� �����̋�3ɉ�H�H�H�����������������U��E3�V9P@t,9P<t�H@�P<�Q<�H<�P@�Q@^]� �p@�V<�@@�^]� 9P<t�p<�V@�P<�Q^]� ��Q^]� ������U��E�M�	�\�YM�U�X�
]��������������U��U��5ŝ�i�� ��3��U
i�� �	3��Ui�� 3�i�� #�]� �U����M���Q�P�Q�P�Q�P�A�X�A�X�A�X�A�X�Q �P �Q$�P$�Q(�P(�Q,�P,�Q0�P0�Q4�P4�I8�H8]� �����������̋��������������U����M��@    ]� �����������3��A
   �D   �A�A�A  �A�A�`����������3��A
   �P   �A�A�A  �A�A�`����������U��y�`tjhT  hp�{j ��z ��j��i{ �E�A]� �������������U��y�`tjh  hp�{j ���z ��j�i{ �E�A]� �������������U���M��]� ̋��������������� �������������� ��������������    �A    ��̋�3ɉH<�H@�����̋A������������̋��     �@    �U���PV�������U�����c���������  �V�^�Y^ �~�N�v�Yv �n��=��^E�(��Yf�\�(��Y~�Yf�\��Y��\��~�}�(��Y�(��YV �\���u�(��Yv (��Y~�\��}��Y~�}��Y��u��u��]��]�(��Y~�\��}��Y~�Y��]��]��}��u��u��Y�(��Y~�YN�\��]��]��u��u��Yv(��YV�Y~�Y��]��]��Y��\��\��Y��Y��Y��Y��e��~E��m��]��M��U�E�M�f� �~E�f�@�~E�f�@�~E�f�@�H ^��]� �E�~�������f� �~���f�@�~���f�@�~���f�@�P ^��]� ��U��j�h&V^d�    Pd�%    QV��h�   �Fj P�u��    �+u �����   �M� �E�   ǆ@      ǆH      �E������M��^d�    ��]�����������W����@�����@��������������̋�����H�H�����V��نh  Wٞ0  ��(
  نl  Wٞ4  نp  ٞ8  نt  ٞ<  � (������u[��4  ��8  ��<  ��0  �0/}�X��\��\��X�_��@  ��D  ��H  ��L  ^�W�8c��ـh  ٞ@  ��ـl  _ٞD  ـp  ٞH  ـt  ٞL  ^���U�칈f������EP�g������]��������������������U��j�h@V^d�    Pd�%    ��dSVh8  �لR ��=��u��3�SjV�M��E��E�   �E��E��E�   �E�   �E�����]��E�P�M�Q�U�R肊�����E������M��)��� ���M��Y8=���   S�\���  �\M�E슆  jV�M��E��M��E�f�]��]�E��9���E�   �ESj�SjQ�$�M�Q�U�R�E�P�M�Q�U�R��]����(�E������M���(���M�^[d�    ��]� ����U��d�    j�hcV^Pd�%    ��   S���� 
  VW�a  ��t   �E�    ��  ���  ��    h8  �f�R ��=���j �E��   j������W�M��E�   �E��EȉẺE��E��D���E�    �E�P�M�Q�U�R�������E������M��
(��� ���M��Y8=��F�j �\��N��\M�E�jW��\����E��M܈E�f�E�  �E� �E������E�   �Ej j�j jQ�$�M�Q�U�R�E�P��\���Q�U�R�p\����(�E�������\����k'���E�@��  �E�;�t  �����_^[�M�d�    ��]� 3�9�t  ~1��t  ��   t�EQ�$V������G��  ;�t  |Ջ��  ���t(;�t  } �Ei�  Q��t  �$P��������M�_^[d�    ��]� ��������������S�܃������U�k�l$���(V�sW�����)| �]��E��Y8=����E��E��| �]��C��XU��E��Y8=��XF��\��P�\��E��Y��Y��Y��X��^���=��\��Y��|�E��E�    f��f�E��,E���y3��=�   ~��   ��`  :�r��_^��]��[� ����U���\S���� 
  �T  �E��I  ��=�VW���������E�    �MԉM��E��r��tN��r�� u��r��   t�E�Ph$d����t*�M�Qhd�j��� ��������E�E�   ���   W��M܉M��E���   �F�U�RPj�� ��H  �X�@  �Y8=���@  �E��A�XA�Y8=����E��f}| �8=��E��m��]��X�u��\��\�(��Y�(��Y��X��Q���c�/�s��=��^�(��Y��Y�(�(؃�(��YE�(��YM��X��X��T$�E��M��$��{ �]���{V�u�M�Q��@  ���}������@  ��H  ��/�v�M��/�v�U���E��F��D  /���L  v�M��/�v�U���E�U܍E�jP�E�,   �U��< �����  �E��\��|�M��\��|j j �M�Q�U��E��X�|�M��X�|R�E��M��U4���l,}�Yd��U(��Y��|��/��M�v(}� �\��Et=j j�j j j�j Q�$h(��h ���E�P�M�j�Q�k����E�\E���0�E�~M�f�M��~M�f�M��M�M��=��E�M�+E�=   �t%����������   �M���z| �]��M���z| �]��E��Y8=��M��U�\�=��Y8=��Y��Y��U��\��U��U��\��U��U��X��E��X��E��E�Ũ��   t6�M�j�j j j�Q�$j Q�$h(��h ���E�P�M�j�Q� ����+j j�j j j�j Q�$h(��h ���U�R�E�j�P�#����M�U��0WQ�MR�E�PQ���h���_^[��]� ���������������U���H�E�PhLd�j�E������E������� �M�U�jR�E�,   �M��: ������  �E�s �YHd��Y8=��YԜ|�XE�E�E�s �Hd��M�\Dd��Y��Y8=��YԜ|�XEj �E�\Dd�j �E�P�M��M��E��X��X�Q�M��E��1���l,}�Yd��U(��Y��|��/�v(��\��~E�f�E��~E�f�E��Ԝ|�E��=��E�E�+E��M�=   �t%��������ux�M��vx| �]��M��{x| �]��E��Y8=��Y��|�U��M��Y8=��Y��|�\��U��U��\��U��U��X��E��X��U��E��E�X@d�j�j j j�Q�$�E�j Q�$h(��h ���E�P�M�j�Q腷����0��]� ������������U���V���~4 �  �~$ �  �S(��\��M��Oj �E�(�P�^�\��X��X�S�]��E��M����| ������   ��O�\N�v�F�\vfnn(��=��Mfnf,[��\��^���^��Y��m��\��\��Y�[�Q�Y��Y��Y���\�T- �|�l$�D$�$V�6�����������.�=����Dz�F4   �S���[^��]��������������U���0V�5D�����  �W���  �����E�9��  ��   ���  S�E�P�M��E����  Q���E�������]�D��3��	��$    �����  ���  ���  ���  �U�;M�ux�U�R�E�P���E��M��k���j j �M�Q�U�R�
0�����e��E��M�(��Yl,}�X�=����\��L$��E��$PQ�������D������<�P���[_^��]� �������U��d�    j�hxV^Pd�%    �ES���VW;�t=����j P�MR ���u�E�    �E��tfHtGHt(�]������EP�u�~tQ �ËM�d�    _^[��]ËF`h   P�kU �����]��MQ�6�F`h
  P�kU �����]��UR��F`h	  P�ekU �����]��EP�����u�tQ �M��_^d�    [��]���������U��j�h�V^d�    Pd�%    QVW�}���O^ ����j P�]R ���u��E�    ���JN^ ����uh   �;������H<QW��1\ ����t �F`h	  P�jU �����E������U�R�h
  �F`P�jU �����E������E�P�����u��:sQ �M��_^d�    ��]���������U��SV�u�F�����F�����^W�}�G��G�^�G�^�G�F�O�3Ƀ;��N�W0�V(�G<�^4�G@�^8�GD�^<�G4�F,�WH�V@�G8�F0�WP�V$�NDu&�G ;�tSPj�Z� ����u�G SPj�G� ��he  �:uR ��9u�~0 u��D��F8�O$�N�W(�V�GL�F �OP_�N$��^[]��U����M���A�X�A�X�Q�P�Q�P�Q�P�Q�P�Q�P�Q �P �Q$�P$�Q(�P(�Q,�P,�Q0�P0�A4�X4�A8�X8�A<�X<�Q@�P@�ID�HD]� ���������̋��������������U��M��P@�]� ��������������̋�������������̋A�������������3�9A����������U��E� �M����M��]����������̋�3��@
   � D   �H�H�@  �H�@�`�������̋�3��@
   � P   �H�H�@  �H�@�`��������U���M��]� �U���M��]� ̋��������������U��y(�`tjh�   hp�{j 豻z ��j�wS{ �E�A �A$    ]� �����̋A������������̋�����H�H�     ���������������U�싉   �E�]� ��������������U�싉$  �E�]� ��������������U��E���$  ]� ��������������U��U���t�D���H��t���I@9Pt��u�3�]��������U��VW�}j W�2i �5D���Ѓ����t�N��t���I@9PtM��u�V3���t@�w�ʋR@9qu)�/Ar�I/�r�G/Ar
�I/�s��u�_^]Ë�_^]���������������W�V����P  ��T  نP  ٞX  WنT  3�ٞ\  Ɔ`  ���
  ǆ�  ����ǆ�  ����9��  ujWjj �*�z �����  ���  ��=��@ 5� ��(
  �� 
  ��d  ��h  ��l  ��t  ���*�t��*���*�h�*�RP�c&���`f���0  �df���4  �hf���8  �lf���<  �`f���@  �df���D  �hf���H  �lf���L  ���  ���  ���  _ǆp  ����^�����U��j�h�V^d�    Pd�%    Q�E�USVW�ًMPQR�ˉ]�������E�    �Xd���t  ��   �d$ W�ǆ  ����Ɔ  �ǆ      h   V��   ��  跡z ����  Oy���������E������M�_^��[d�    ��]� ��������U��j�h�V^d�    Pd�%    Q�M��Xd��E�����������M�d�    ��]�����U��E��
u	�   ]� ��t��%t�3Ƀ�����]� ����U��j�h�V^d�    Pd�%    QV��u��Xd��E������O����Et	V賡z ���M��^d�    ��]� �������������U��j�hW^d�    Pd�%    Q�ESVW�ًMPQ�ˉ]�� ���E�    �Xd���t  ��   ���    W�ǆ  ����Ɔ  �ǆ      h   V��   ��  �'�z ����  Oy����d����E������M�_^��[d�    ��]� �������̃��t�D���H��t���I@9Pt��u�3���������������̋��   ���t�D���I��t���I@9Pt��u�3��������̡D����t�@��t����ȋ@@9Q t�Q �Q ��u����������U���H�=D�� t"�EP�M�Q�����D����P���  �_�����]������������U����E��P�M�D��S�Y�U����Q  �EVW���E�P�U��M���[@;V�  �~4 �D���HP�M��
  �~$ �   (��\�j �U��]�(�R�~�\��X��X�W�]��U��M���s| ������   ��M��\N�v�F�\vfnn(��=��E�fnf,[��\��^��E��^��Y��m��\��Y��\�[��Y�� �|P�Y��Y���\�T��l$�D$�$V�;�����������.�=����Dz�F4   �X����E�������_^[��]�����U���M��]� �U��U��5ŝ�i�� V��3��u
i�� 3��ui�� 3�i�� #�I���3���t9Pt%��� ��u�jh  hp�{j 踳z ��j�~K{ ��u
�U�^]� �E�^]� ������U��U��5ŝ�i�� V��3��u
i�� 3��ui�� 3Ƌui�� #��I��^��t��    9Pt� ��u�3�]� ���������������U��y(�`tjh�   hp�{j ��z ��j��J{ �E�A �A$    ]� ������U��ES��V�C�{(�`W�<�    tjh  hp�{j 诲z ��j�uJ{ ;{t�CWP�K�Ӻ���C�C    �{�C_^��C    []� ���U��j�hAW^d�    Pd�%    ��V3�������E�;�t"�E�u��p<�p@�E�����^�M�d�    ��]ËM��^d�    ��]����U��]鷁��������̋A�������������U��j�haW^d�    Pd�%    ��V3��M����E�;�t#�E�u�����H�H�0�M�^�M�d�    ��]ËM��^d�    ��]���U��]�7����������U��j�h�W^d�    Pd�%    ��SVW���}�3ۉ]��w�u��E����׸���E��^�^�]���^�E������M��__^[d�    ��]���������U��j�h�W^d�    Pd�%    ����3�S�E���H�M��P�U�
�J�E��J�J�   �]��
�J�J�B �J�J�B�`�E���H�H�E������M�[d�    ��]�����������U��UV���ŝ�i�� W��3��}
i�� 3��}i�� �A3�i�� #1_��^��t9Pt� ��u�3�]� �M��P�����   ]� ��U��j�h�W^d�    Pd�%    ��VW���O3��g����E�;�t�E�u��p<�p@�E��������E���P�V�H�N�P�V�@�^�@�^�@�^�@�^�H �N �P$�V$�H(�N(�P,�V,�H0�N0�P4�M�V4�@8�F8�G_��^d�    ��]� ���������U���I�I]��~���U��A�x�`tjhT  hp�{j ��z ��j��F{ �U�P�y8�`t	jh�   �҉Q0�A4    ]� ��������������U��Q�EV;�s�q���9 u@��;�r�3�^]� ��^]� U��j�hX^d�    Pd�%    ��VW���O3������E�;�t�E�u�����H�H�0�M����M�EQ�N�F������G�M�_��^d�    ��]� �U��EV��NP��}���N^]� ������U��]�7�����������[�������������̋AH������������;��������������U��j�h>X^d�    Pd�%    ����3�S�E���H�M��P�U�
�J�E��J�J�   �]��
�J�J�B �J�J�B�`�E���H�H�E������M�[d�    ��]�����������U��j�h~X^d�    Pd�%    ��SVW���}�3ۉ]�S�B����E�   �w�u��E���蚴���E��^�^�E���^�E������M��__^[d�    ��]�����������U��UV���ŝ�i�� W��3��}
i�� 3��}i�� �A3�i�� #1_��^��t9Pt� ��u�3�]� �M��P�����   ]� ��U��EV�p3�W;�t49Pt%�x�։z�P�x�z�I�IP��{��_��^]� ���W�P�(9Pt �x�W�P�I�Q�IP�{��_��^]� �Q�I��IP�{��_��^]� �������������U��EVP������3҉P@�P<�N;�t�A@�N�H<�F^]� ��F^]� �������U��EV�p@3�W;�t49P<t%�x<�։z<�P<�x@�z@�I�IP�{��_��^]� ���W<�P@�(9P<t �x<�W@�P<�I�Q�IP��z��_��^]� �Q�I��IP��z��_��^]� �������������U��d�    j�h�X^Pd�%    ��V��M��5ŝ�i�� ��3��U
i�� 3��Ui�� 3�i�� W�>#��F����t9Htd� ��u��NS3��	����E���t�E�]�����H�H��M��؋M�EQ�K�C������V�F����N��[_^�M�d�    ��]� �UR�H������M�_^d�    ��]� ��������U��V��M�с�ŝ�iғ W��3��}
iғ 3��}iғ �F3�iғ #����t9Ht%� ��u�3��RQ�������NW�Wy���N_^]� ��������������3�9At�QV��t�q�΃9 u@��;�r�3�^Ë�^�������U��ES�]VW�8��O�W��MR������?��t�E�8_^[]� ���5ŝ�i�� �M��3��Mi�� 3��Mi�� 3��Ni�� #@;�s�v����$    �: u@��;�r�U_3�^�[]� ���U_^�[]� �����̋�B@���u�I�A�IR�Fx����@<    �I�IR�2x������z�������������U��ESVWP���O�{ ������}�   V�K�g���3���~��K��    @;�|�S_J^�[]� ����U��V��N��u<W�}W�N�&����F�x�`tjh  hp�{j ��z ��j�?{ �x��_3���~��V��    @;�|�I��F    ^]� ����y�������������U��j�h�X^d�    Pd�%    ����3�V�E���H�M��P�U�
�J�E��J�J�E��
�J�J�B �J�J�B�`�E���H�H�E�   �@0   �E������M�^d�    ��]�U��j�h&Y^d�    Pd�%    ��SVW���}��E�   3�S������E�   �w�u��E����V����E��^�^�E���^�E������M��__^[d�    ��]�������U��VW���$����}9Gue�G������t[��+���8	  ��tKP�������tA�G��\��   �\��   ��P  ��T  نP  ٞX  نT  ٞ\  _^]� �U���DVW�}������   �E��E�jP�E�,   � �����   he  �n]R ��9thh  �]]R ��9t3���   ��w���x< u
�E��  S�]S���\�����u,�M$�U �E�EQ�MRPQQ�$S���U���[_^��]�$ �E� ����=��������U��E�����   ���  ��+��H�������������+���+ȉM��E�y��=��E�H"}�U���c��E��Y��|�X��Y��|�]��,�u!jj h�  �_\R ��Ph ���`���|����]���`  �Y�|�E� �H����i� (��Y8=��\��\����E��M�3ۃ�p  ��X��XˈM��E��M���   ��0  �Y| �]�0  �Y| �]���=��]��\�0  �U��\�4  (��^E��^M��Y��Y��]��]��\�0  �U��U��\�4  �Y��Y��]��U؍]�3��Et�E P����P�)�������j j �M�Q�U�R�c������tP��p  ���  �XE(�Y��|j�j SP�EQ�$�Ej Q�$h(���M�Q�M�U�RPQ�>����5��p  �Ej j�j SR�Uj Q�$h(���E�P�E�M�QRP�W����M��U$�E ��0Q�MR�UPQR��虻��[_^��]�$ ���tV��[�P��{����8  ��t<�V�������t0����,^ ��t%V�t��������t��+���8	  ��tP�����3����U��j�h@Y^d�    Pd�%    ��d�D���@`SVW�M���  j jh�  ��YR ��P��+ ���E����������;��X  ��[�Q��{����8  ���9  �V�
������)  �M�Q����Q^ � �E��@�E�������D��� � �U����  ���$    �E����H� P�M��|�^ �����u�;���  ��[�R��{� � ��8  ����  �V�u���������  ���$.^ ���y  �M�Q���AQ^ �U9U��b  Q�ċωe�� 3����PY ��u2���   �u)Q�ċ�� �����PY ��u�E�PW�'��������  �Q�uW �����  ���2+^ ����  ���   ����j P�&�Q ���u��E�    �F`h  P�LU j P�� q ����u�]������U�R�u��HUQ �  ���   P�����������u�]��{  VW��������t�]��e  ���   h` h  ��  SQ�S�p �]싖�   h` h  SR�9�p �]���d��E��M��E��\M��\E��� �Y��Y��X������M�v�E��Y�/���  �E�/�d�v�Y�/���  ���   h` h  SP��p ����to�M�Q�������M��E��������uT���   h` h  SR��p �]���}� �`  �E��Y�/E��M  �0/}Q�E��$P�X������M�VQ�	+ �����9E�u�E��  ��O ��tW��������E�W���������t,���)^ ��t!jj h�  �MVR ��Ph ���`���j����U�VR��	+ �E����   h` h  SP��p ������ċ�F�e�� 5�����MY ��t3�W�j^ ����u��t�   �3��E��u؍M�Q�U��E��E�R���E�����W��EԋUQ�$��U�h�   P�M�QWQ�$�E�P�M�QR��������E� �M��
{ �E������M��Ci���}� �����M�_^d�    [��]� ������U��j�hXY^d�    Pd�%    ��4�D���@`�M���  Vj jh�  �UR ��P��+ ���E��p�W ���u����  SW��u�V����������  �F����v  ��+���8	  ���b  P蕻�������R  ��[����   Q��{����8  ���d  �\c��ދ��d  �   ����   �4��E�H#�i��  ��,���P�V�h ����t�l���Y8=��\ e��E�j
��O ����t����+^ ��u�h���E��U�R���h�d�j�]܉]��r� �u����   ���   ���E�P�M�Q���E��M������M��K { �E�   �E����   Q�$h�   R�E�PjQ�M��M��$�U�R�E�PQ�������]��M��\{ �u�V��W ���E���V���_[^�M�d�    ��]� ��U��d�    j�hxY^Pd�%    �D����4�@`S����  Vj jh�  ��RR ��P��
+ ���E�� ������u�����  WV�������E��E�    ��u�M�QV�OsW �����%��������G  �U��E�RP�~sW �������,  ���#  ���  ���  ���  ����   ����   ����   ����   ����   ����   ����   ����   ����   �M��#S^ ��t����   ����   �M�Q���he�j�u܉u��e� ���   ���   ���U�R�E�P���E��M������M��A�z �E�   W��EQ���   �$� �E�h�   Q�U�Rj Q�$�M�Q�U�RP�������u��M��T{ �E�@�E���@�����_^�M�[d�    ��]� �U��j�h�Y^d�    Pd�%    ��d�D���@` �M���  V�=��������t6��[�Q��{����8  ��t�V�C�����t����Q^ ���v  W�9Q j jh�  �E��PR ��P�+ ���E���mW �����@  SW�D��������  �� �  3�P�]���p ����t"�@�P(�H�E��@�E��M��U������  ��y警��P�G<P��\ ������  �w���u	�E�    �e��[�Q��{����8  ��u�E��E�V�O����E���t6�u��E�P���*H^ �H� �E��@�M����E��zE^ ���C  �U�;U�7  ���������@<�O<PQ�\ ��������WF�ẺE��E�   �E�    ��������t�E�   �E�  �;W�-������t�E�   �E�   ��M���t�jN^ ��t�E�   �E�Q   ��d�/�@�  ��   �E���   �M���t�!^ ��u�M���O^ ��tfW�g9Q ����t�E��pc��U�RQj�:� ���M� �_��u�U�R��u�E��`c�Q�<hTe��5��u�E�PhHe��&�M�Qh,e�����   t	�y�O ��t�U�Rhe�j��� ���E��]܍E�P�M��E��E�Q���E��\����u�;�t�  �E�����tM��p�  ;�vC��t�  ��+�+ƉE��E�y��=��M��E��y��=����]��E��Y��|�,��E�j �M�WQ�P���E�   W��U��G���$R�U�P�E� �EԍM�QRQ�$�M�Q�U�RP�������E������M��_{ W��jW �����������[_^�M�d�    ��]� ���������U��j�h�Y^d�    Pd�%    ��@�D���@`�M���  Vj jh�  ��LR ��P��+ ���E�� ���������[  ��[�Q��{����8  ���<  �V�������,  �M�Q����D^ � �E��@�E��j �0����  SW���I �u���VlP�U��gW ������  �Q茋^ �������t+��[�R��{� � ��8  ��t�W菲������  �~,���  �F$��~���w  ��	�n  �M9N�b  �F(��W  �E��\F�M��\N��d��^�Y��Y��X��F</�v	/��  �F@/�v	/��  � t�   uS����������a�������   �~(��]��N�U�R�E���P�˃��E��M��z����M����z �E�    �F8���t"�V4�M�QPR�%3R ����uhp�{�M��Q
{ �F,�E��N0�M���O ��t�F���t�V$PR�*������E�W��Q�$h�   P���^ �U��U��P�M�QWQ�$�E�P�M�QR��������E������M���z �}� ����_[^�M�d�    ��]� ���������U��QVW�M�3��gW ����t`S�]��    V���������uG;�tV��gW ������u�[_^��]� �� �  P�jj ������t����9Fu�M���V����[_^��]� ��U��E�J���;  ���q� �$��q� �� 
  �   فP  PٙX  فT  ٙ\  ����   �и   ]� �� 
  ��   ����   �и   ]� �b� j j�j�����P�������   ]� �� 
  ��   �@��u�k����   ]� ��uj�����   ]� ��uj�����   ]� ��u`j�����   ]� ���  tG�P���   �Ѕ�t8�   ]� �� 
  t&�@,��t���u��=���l  �   ]� 3�]� �q� }q� �p� �p� �p� �p� �q� �q� �q�   �����������U���   VW�=D�����H������t��+���8	  ��t
P������u_3�^��]����   ��P  �X��E���T  �X��   �E��N�O ��t��t
��t��u=�G�E���t3�E���O���]��=E| �M��O�8=��]��9E| �M��8=��]��~����M������E�W��|W��|f�U��~���f�U��~���f�U��~���f�U�E��M��E������E���> �E��E���> �~����~5����~%����~�����l  �Y�d  �-�=�����f�]�f�]��~���f�u��^�f�u��u�f�M��M�W��|�U��YU�f�]��]�f�e�(��Yu��Y�f�e�(��Y��X��}��Y}��X�(��Y��X��u��X��U��Y��]��Y]��XӉE��]��Y]��X���l����U��Y��Y��X��U��YU��X��U��E���p����Y��YM��U��]��U��YU��X��U��YU��]��X��U��YU��U��U��YU���t����]��X��U��YU��X�(��YU��YE��X��U��YU��X���|����M��YM��X��M�(��YU��YM��X��U��YU��E��E��YE��X��U��X���l����E�(��Y���x����Y��X��E��Y��X��E��Y�(��Y��X��]��Y��X��]��Y��}��Y��e��Y��M��Y�t����X��X�(��Y��X��e��Y�x����X��e��Y���t����Y��X��u��Y�x����X��u��Y�t����u��u��Y�p����}��X��u��Y�x����X��u��Yu��}���|����Y��X��u��u��Yu��}��X��u��Y�|����}��}��Y��m��Ym��X��X��m��Ym��u��u��Y�|����X��u��Yu��X��m�(��Y-���(��Y5����X�(��Y5����X�(��Y5����m�(��Y-����Y����X��-���(��YĪ��Y��X��u��5����Y��X��X��E�(��Y���(��Y����X��E�(��Y����X��U�(��Y���(��Y����Y����X�(��YĪ��Y��X��Y��X��X��E��U�(��Y����M��M�(��Y����X��U�(��Y%����X��]�(��Y����Y���(��Y%����X�(��YĪ���x  �Y��X��X��E��~E��U�f��~E�f�A�~E��Y�f�A�X��]��~EčE�f�AP�Q 踸���~ fֆ�  �~@fֆ�  �~@fֆ�  �~@fֆ�  �H _���  �   ^��]��U��S�]��� VW�}��tHuW�R�����t_^[]� �Ҳ��WS���y���_^[]� ��U��d�    j�h�Z^Pd�%    ��  SVW�*������;���   �����P�� �����j)Q ��t9;�t5� \�j V��Q �E��E�    �H;�E�]�� \��E��E�P�=Q �D��9qDtw9qHtr�qH�M�VQ�:S �E�   �D���BDP�M�Q��9S ���E��U�R�M���z ��u�D���@L    �	�D���qD�E��M���z �]��M���z �D���AL�� t@Hu��+��B�B��y��=��4s��A@�Q@��������rS��=��AL   �=��+��B�B��y��=��4s��i@�Q@������r�QHW��QD�YH�AL   �A@輖�����}�;��J  �M���z �E�   �D���@D;�t&P�M�Q��8S ���E�P�M����z �E��M��.�z ��[�R��{� � ��8  ����   �W�w���������   V�R^ ������   �M�Q���A7^ �PR�h�h ��j j jP�i�h ��P�E�P�̡z ���E�h�
�h�  �>R ��P�M�Q�i#R �����]�j �M��u�z P���m�z P�U�R�R ���E�P�M���z �]��M��X�z �E��M��L�z �E��M��@�z h�������hp���M����4�z ��u1�P�M����z P���   ����h�   �M����z Php����h�����D����   �H@�Y��|�M��,шU�M���   �H@��$  �Y��|�U��,��E�M�h�޵��$  �t���؋�B$��j����ƅ���� ��W���x@ tPh�   3ɍ�����RQQjh   f���������{��t(j j j�������P������h�   Q�lp����ƅ;��� �M���z �E�豬O �D��9Bd�  蝬O �D���Ad��Q���@�ph�   ��@���j Rǅ<���    �\+ ���������~s �E�
3���|����E��E���P��<���Q���ҋ�P���҅��f  �������o�z P�M���z �E����čMȉe�QP� hj ���E�������R�E�P�E���EO ���E��M��6�z �M�jQ�k����D���BdP�M�Q�h� �����E�h�e�h�  ��;R ��P�U�R�� R �����E�j �����z P�M����z P����z P�E�P��R ���E��M���z �E��M���z j ��P�e���茏���E����̉e��+�z �E����U��̉e�R�V�z �E��E���L����Cs���E���L���j P��s�����E���L����os���E��M��3�z �E��M��'�z �}��E��������M�ǅ������|�E���������z �E����������z �M���z �E��D���BdP�M�Q� � �����E���O P����z P�U�h�e�R���z ���E��M���z ��[�P��{����8  ����   �W����������   W�N^ ������   j j jW�_N^ ��P�U�R�R�z ���E�hle�h�  �:R ��P�E�P��R �����E� j �M����z P�����z P�M�Q�
R ���E�!P�M���z �E� �M����z �E��M����z �MT���x@ thhe��M��z�z �E��M���z W�M^ ����thp�{�M����z �M��l�z P�M��C�z ������R�M��4�z �3j �M��X�z P���   ���ЋD����  �L�* �E��M��@�z �E��M��4�z �E������M��%�z �M�_^d�    [��]�����U��j�h�Z^d�    Pd�%    ���ЫO �]���O ����   V�����������   ��[�P��{����8  ��th�V������t\����0^ P�,�h �����tG����j P�V�Q �E��E�    ���   /�c�v�E��E����������U�R�E��}5Q ^�M��E�d�    ��]������������U��QV�������U�ٖh  ئd  �����|������v*��d  �M��\��Y�c��X���d  ^��]��E���d  ^��]����������U��� W�}���*  �D�����  ��  S���  耍��9C�  Vh-������������0����E�P����/^ �M�QP��虛���U�RS��荛���E��\E��M��\M���D$�$�Ɗ{ �]��i����$P��{ ���E��E���y��=���c��E�P���%8=���e��E�]�?/^ �D��� ��  ��ٜ��  ����  �@�   �Z�@�Z�@�E�B��  ��ٜ��  ��  @���^��  [_��]����������������U��]�W����������U��EVP������3҉P@�P<�N;�t�A@�N�H<�F^]� ��F^]� �������U��]������������U��]�W����������U��]�7����������3�9At�QV��t�q�΃9 u@��;�r�3�^Ë�^�������U��]�����������VW��3�9~t)��I ��A@�;�u�~��x<�NQ�N�M��9~u�_^����������U��j�h[^d�    Pd�%    Q��3ɍP��H�H�HV�E��B
   �D   �J�J�B  �J�B�`�M��P�E������M�^d�    ��]��U��j�h;[^d�    Pd�%    QV��u��E�    �%����E������N�fO���M�^d�    ��]��������U���PV��3�W9Ft"�V��t�~�ύI �9 ��   @��;�r�3��E�����   ���E�P�M�Q�U�R���M����M��с�ŝ�iғ ��3��}�iғ 3��}�iғ �F3�iғ #����t9Ht3� ��u�3��RQ���4����NW��K���N�}� u�_^��]Ë��g�������U��j�h[[^d�    Pd�%    QV��N�u��i���3��E��F��F�E������M��^d�    ��]�����U��j�h�[^d�    Pd�%    ��SVW�M��E������y�}��E�   3�S��������E�   �w�u��E��������E��^�^�E���^�E������M��__^[d�    ��]����������U��V�����   ǆt      �ҋ������ٖh  �Eٞd  ��=���l  ��t+W���P  ��T  نP  ٞX  نT  ٞ\  ǆ 
     ��t
ǆ 
     �� 
  ���h�  ǆ�      ��
  �C2R ��p  �E��(
  ��^;�t�PR�P� RP�l���]� ��������U��j�h\^d�    Pd�%    ���   S3�W�M�9]t�D���H�M��D���B�E�};��\  ���V��l�����p��������������;  ��[�Q��{����8  ;��  �V�������;��
  蜈��P�&� �E؃���8���P����)^ ��8���S�E���<���jh�  �E��+1R ��P�"�* �E��3�9_t�W;�v�w��9u@��;�r�3��E�;���  ��������$    �}��\���Q��X���R�E�P��������M9�h����E  ��\����E���`����\��M��M��\��Y��Y��X��E�/�d��U��M�v{/�vv�E�3������  ���SP�*�Q ����T����]��E�;��   t�U�PR�a ����t�}�PF  v�   �E���������E�P�u��<-Q ;���  �M��E�/�d�v	/��h  9]�tT��\���Q�W�������\�����跚����u4;��;  �E�/E��,  �0/}Q��\����$R�2�������|����t6�D��� �0;�t)�=�{�I ��vP�n^ �����t	��[�Q��;�u��M����z �E�   ��t�������E  ��x�������6  QP�����R�R ���E�P�M���z �E���������z h�  ��.R ��9�x�����   ��t���P��h ���������   ��Ba ����   SSj��H���VQ赑z �E���x���h�
�R������P�YR �� ���E�S��H����d�z P���\�z P��,���Q�o�Q ���E�P�M����z �E���,����@�z �E��������1�z �E���H����3V��`�����   R�����P��h ���E�P�M���z �E���������z �u��M�Q�U�R������W�Q�$�E3�9]�h�   ��j��M�Q�U�PQ�M��$R��l���PQ�������9]��  �M�3��*�z �E�	��JW ��;���   ��$    V�*�������ua�U������tUhp�{�M��x�W�z ��uh�e��M����z S�� ���VP��������E�
�����z P�M����z �E�	�� �����z V�JW ����;�u�;�tT���hh  �u܉u���,R W��$�E�X�d�h�   V�M�QjQ�M��$�U��E�R�E�PQ�M��]�������E��M���z �E������M���z 9]������^�M�_[d�    ��]� ����U��D���@`V��u-�EW�}j WQ�$�����EjWQ���$����_^]� �������������U��d�    j�h8\^Pd�%    �D����HS3�;��  VW�}���;�t�@;�t�����@@9~�  ;�u����EW�P�MQ�U�R�u��u��u��u��E��E��E��Eȉủ]Љ]ԉ]؉]܉]���h ���M��)| �������؟��D��   �M���(| �������؟��D{p�E�U�M�E��u�R�E�u��]܉M��}��]��+����EP�M�Q�>/S ���]��M����z Pj,�XrP �D�����փ�R�E������E������M����z _^[�M�d�    ��]�9]t�9^4u��F4   �����M�_^[d�    ��]�����������U��d�    j�hX\^Pd�%    �D����\S�X����   ����P�	� ������E�;���   3�V�M��M�9Ct�S��t�s�΃9 ��   @��;�r�3��E�����   W�M�Q�U�R�E�P��������u����ta���j V趵Q ���}��E�    �E�;��   tPV�Ha ����t�M�E�M܍U�RP��������E������M�Q����}���&Q �}� �z���_^�M�[d�    ��]Ë��U���U��Q�D�����]  �} ��+�S�Yt�   ��hP�a��������3  �D����p  R�D��������  h-��/��������  �D��Vp  WP�R��h-����F����R$���G���Ѓ���P���҅���   �I �������U�ٖh  ئd  �����|������v'��d  �M��\��Y�c��X���d  ��E���d  ���O����U�ٗh  اd  �����|������v'��d  �M��\��Y�c��X���d  ��E���d  K�E���_^[��]���������������U��j�hx\^d�    Pd�%    ��Lh�ص�������ȋB$j ��h����s������ȋB$j��������+��AP����j ������+��R�D����+A�U܉E��E�y��=��0/}��������  Vj j �Q�3'R ��t���P��Q ���u��E�    �Fh�E��	}���D���E��A���;  SW���E�P@�؉]��U��MDW ���u����   ��u�V蕥�������(  �^�����   ��+���8	  ��t~��;�   ss��d  ���d  �   ����   �4�H#�i�T  90uB��0�   �U��E���0�   �E��E�;Pu�D���QP�U�R�}��'������u�V��CW ���E���?����]����9s t9�M�+K0��  v+�{ h�   ��%R ��;�t����j j j j W�wQ �s �}� ������u�_[�E�������t��U�R�u���"Q ^�M�d�    ��]��-����@<�N<PQ�0�[ �����T����� �  R��E �~���؃��u3��&��[�P��{����8  ��t�W趋����u
���	������t�C�S�E��C�E��Uą�t$�M�Q���k^ � �P�E��@�E��UċE��M�;H������D���BQ�E��U��E��E�P�E��}��E�褪�����{���������������U���S�D����W�;�]���tsV��I �E���}��@9FuX�~ �t2�^ h�   �M$R ��;�t����j j j j S��uQ �]��F �����N$j Q�Uz �U���R���F$    �������u�^_[��]��������������U��j�h�\^d�    Pd�%    Q�=D�� ��  SV�uV�c^ �ءD��� � ����t9��  �@��u����w  ��[�Q��{����8  ���X  �V���������F  ���   ����Wj P�/�Q ���}��E�    �G�������   ��P�� �$�D�� �G`h� P�U ����uf���J�^ @��LwY��h�� �$�\�� �G`h� P�XU ����u6�E������   �E����������U�R�}���Q _^[�M�d�    ��]Ë��   ���t��+���8	  ��t
V�{�����u*�E����������E�P�}��Q _^[�M�d�    ��]Ë��   ���;�t&�5D���F��t�I 9P�@@t��u���S蚥���}��M���5��_^[�M�d�    ��]Ë�*�� {�� ���  �I o�� Z�� ���              ����������̡D����t����t9t�@��u�Å�tP�i������������U��=D�� t;�EP�a^ �D������t%�	���t��    9t	�R��u�]Å�tR����]��������U��E��H�x0 ��   S�]�Ӂ�ŝ�iғ VW��3��}iғ �5D���F3��}iғ 3�iғ #�@����t"9Xt� ��u����P�M�藫���M��U�JD�E�NPS����_^[��]ËM�D��PQ�J�ǽ����]����U��UV���ŝ�i�� W��3��}
i�� 3��}i�� 3�i�� �} t#�D���H#1�A����t99Pt.� ��u�_^]ËD���I#1�A����t9Pt
� ��u�_^]�R�#���_^]����������������U���H�=D�� t:V�u�E�VP�é���N���~, tQ�U�R�}�����^��]ËE�PQ������^��]�����k~�������������U��j�h�\^d�    Pd�%    Q��3ɍP��H�H�HV�E��B
   �D   �J�J�B  �J�B�`�M��P�   �M��H,�E������M�^d�    ��]�������U��j�h�\^d�    Pd�%    QV��u��E�   �����E������N�V9���M�^d�    ��]����������������������������������������U��j�h]^d�    Pd�%    QSV��W�N�u�����3ۉ]��^��^�E�   �FH��`�@
   � P   �X�X�@  �X�P�E��F9PtjhT  hp�{S�Mfz ��j��z �M�H9V8t	jh�   �׋U�N0R�Ή^4�����j�n{ ������}�   W�N����3�;�~�N��@;�|��FH��E������M�_��^[d�    ��]� ������������U��j�ht]^d�    Pd�%    ��SV��W�u��E�   ����3ۈ]��NH��7���E������~�}��E�   S��舲���E�   �w�u��E�����l���E��^�^�E���^�E������M��__^[d�    ��]�U��j�h�]^d�    Pd�%    ��S3�V���^�^�^�N�A��Y�Y�Y�   W���u��M��@
   � D   �X�Xf�@ f�x�X�@�`�]��A�   �E��A,�U���=��FX���3��F@�~D�~H�~L�~T�^\�F`�^d��*���*�h�*�R�NhP�F�����*���*�h�*�R��p  P�)�����*���*�h�*�R��x  P����W����  ���  ���  ���  ���  ���  ���  ��   ��  h����  ���* �E�f�FP�s�}��M�_��^[d�    ��]��������������U��SVW��3����  �+q���؉�t  �N�O �u���e�(��Yl,}�X�=���S�E�\ы���UP�  ��������e�(��Yl,}�X�=�S�MQ�\ы��U��������e�(��Yl,}�X�=��U�\�R���U��L������e��D��(��Yl,}�X�=���@`�\��Mu%j SQ���$�����EjSQ���$� ������e�(��Yl,}�X�=�S�MQ�\ы��U������UR�y轿�����e�(��Yl,}�X�=�S�MQ�\ы��U��u������e�(��Yl,}�X�=�S�U�\�R���U��=����EP���e�(��Yl,}�X�=��\ы��U���������e�(��Yl,}�X�=�Q�\ʋ���$�2������   v!���   u+�;�����  ���  _^[]� ���  ���  _^[]� ���  ���  _^[]� ��U����   SVW���}�����+����E���`  j f�E����E��Qjh�  �U��_R ��P�V�* W����E�j ��4�����t�����x�����=�P��t�����|����E��| �n���D���y�E�����  ��}�E��W@�U�9G��  ����  ���  �YW��x  �Y_��|  �YO�X��X��  �U����  �YW�X��X��  ��0  ���U��'| �8=�����E����]�� | �8=��E��E��E�؃4  �M�Q�U���R���]��G�E��G�E��o{���G�E�P�M��E��GQ���E��L{���G�U�R�E��E��GP���E��){���EԋM��E��U�/E��M��ẺM�w(���m��M��e�/�w(�/�v�E��]�/�w(��U�/�w(��M�/�w(�/�w(�/�w(��U�/�w(��M�/�w(�/�w(�/�w(�j �M�VQ�m��e��E��]��1| ������   ���9w u�I���9w ��   �U��E�W0� ��e�(��Yl,}�X�=��\��M�� 3����$    �D5ԍ�0  �!�]��L| �}���0  ٜ5T����D5�أ4  �]��:| �}���5���P�D5�Pٜ5X������������� |��W �E���4���Q��p  R��T���PQQ�M��$h(���U�R�W�����PQR�B^����(�}� �����uV�������C ;-�u�K$;-�uV������_^[��]� ���U��D��V���t(�xX t"�EW�}WP荼�����v�����tW�������_^]� ����U��j�h�]^d�    Pd�%    QV��u��E������es���Et	V�	Gz ���M��^d�    ��]� ���U��j�h^^d�    Pd�%    QV��u��E�    ��  �_�* �E��������u��E�   ���T����E������N�.���M�^d�    ��]�������U��D����t<�ATV�u;�t0���t(�	�r���D���H������D���I������D���qT^]������U��j�h(^^d�    Pd�%    Q�EV��MPQ�Ήu�������E�    �Fh   �E������M��^d�    ��]� ����������U��j�hH^^d�    Pd�%    Q�M��E����������M�d�    ��]�����������U��j�h�^^d�    Pd�%    QSVWh	  �Iz ���E�3ۉ]�;�t	��������3��E�����j�D���mIz �����u�   �}�;�t(�t}| ��^�^�^�E��~��^�^�F�E��3��E������D��jp�0�Iz �����u�   �]���tj j�������E��~h�]��3��E������D��jp�q��Hz �����u�   �]���tj j���g����E��~h�]��3��E������D���xX_�p�Hh^[�����t�������h��RP������D����p  ����t������h��RP�����D����x  �����t��������h ��RP�����D��p  P�^�������t<�D����x  Q�E�������t#�D����x  Rp  j P�e�������������M�d�    ��]��������������U��j�h�^^d�    Pd�%    QV��u��E������E����Et	V�ICz ���M��^d�    ��]� ���U��j�h�^^d�    Pd�%    QV��W�u��E�    ��  ��* �E������~�}��E�   �������E������O��*���Et	V��Bz ���M�_��^d�    ��]� �U��j�hT_^d�    Pd�%    QV�5D�����H  �=�+�u�
���SW�~��ta����@���9^ t2�^ h�   �R ��;�t����j j j j S�KaQ �F ��������F$j P��@z ���F$    ��u��5D�������N�����D���03��x�u�;�t�]����8n��V��Az �D�����p�8�u�;�t�]�������V�Az �D�����p�x�u�;�t�]�������V�Az �D�������x�u��E�   ��  ��* �]��~�}��E�   �������]��O�U)��V�OAz ��_�D��    [�M�^d�    ��]�̡�+�W���	  hXG�蚰������thXG��)�������ȋB$V�Љ�l  _�����U���+�V���	  ��h   uW�}��~�MO ǉ�h  _��+����	  hXG��,�������t"hXG���������ȋB$j��ǆl     ^]á�+�V���	  ��t=hXG���������t"hXG��u�������ȋB$j ��ǆl      ǆh      ^�̡�+�V���	  ��t=hXG�薯������t"hXG��%�������ȋB$j ��ǆl      ǆh      ^�̡�+�V���	  ��t=hXG��F�������t"hXG����������ȋB$j ��ǆl      ǆh      ^��U��d�    j�hh_^Pd�%    ��+���V���	  ����   ��l   ��   �LO ��h  ��u/h`I��{������j �ȋ��   hp�{��^�M�d�    ��]�;�r/h`I��H������j �ȋ��   h��|��^�M�d�    ��]�+ȸ�������W�M����̸z �E�    FV�M�h(|Q�U�z h`I�����������7j �M��ڶz ���   P�����E������M����z _�M�^d�    ��]�V�>��h�  �`tO ��+����	  ����t=hXG��ĭ������t"hXG��S�������ȋB$j ��ǆl      ǆh      ^����������������V�j ���@�H����  j �Ћ�+����	  ��t=hXG��N�������t"hXG����������ȋB$j ��ǆl      ǆh      ^����������U�싑8  �E;u��<  ;Hu�   ��]� 3���]� U��E���0  ]� ��8  ����������U��Q�E;u�I;Hu�   ��]� 3���]� �����̍A�������������3�������A�A�A�A������������U��j�h�_^d�    Pd�%    QV��u���@ �E������M��^d�    ��]����̋���������������U���  PQ������R�����������P��������t"�������������� ���QRP�������Ƌ�]Ë�*���*�h�*�QR���ʾ���Ƌ�]�����V��W3������  ��  ��  ��  ��  ��  ��   ��$  ��*���*�h�*�PQ��(  �j�����*���*�h�*�RP��0  �M�����*���*�h�*�QR��8  �/�����*���*�h�*�PQ��@  ������*���*�h�*�RP��H
  �������*���*�h�*�QR��P  �׽����*���*�h�*�PQ��X  躽����*���*�h�*�RP��`  蝽����*���*�h�*�QR��h  ������*���*�h�*�PQ��p  �b�����*���*�h�*�RP��x  �E�����*���*�h�*�QR���  �'�����*���*�h�*�PQ���  �
�����*���*�h�*�RP���  ������*���*�h�*�QR���  �ϼ����*���*�h�*�PQ���   貼����*���*�h�*�RP���"  蕼����*���*�h�*�QR���$  �w�����*���*�h�*�PQ���*  �Z�����*���*�h�*�RP���,  �=�����*���*�h�*�QR���.  �������0  ���0  _��^���������������U��d�    j�h�_^Pd�%    ��@SVW����p�^����@�H��P�ҋ}��t��P �OQ���҅�t�M�G8P��z �4�Mj Qj �U�WR�=� ���E�    �MP��z �E������M��+�z ��P|�wV�M�Q�����E�   ��P�M���z �E��M����z �E��M���z �M���z �}��t�M��Ȱz Ph�|W��z ���~����f� �~Ff�@��������EVP�����VW������� �E������M�舺z �M�_^d�    [��]� ����́�8  Q�d�����ǀ
      ������������ǁ0
      ǁ4
  ����������U���  S�]VW����}�ˍ����������Ǉ0
      Ǉ4
  ���������O;�t�PR�P� RP�����,f��ˍ������������  ;�t�PR�P� RP�����$f��ˍ�����������  ;�t�PR�P� RP�Ĺ���pY��ˍ�����������   ;�t�PR�P� RP蘹���f��ˍ������V�����(  _^[;�t�PR�P� RP�i�����]� ���U���VP��������h  �E���l  �E���p  �E���t  ���M��E��r| �]��E����D$W����$��
 �E��M���|���D$���$�ђ
 ^��]�������������U���PQ�U�R�E������E������DU �M���E�PQ�Q��������G� 3��}������]�����������U���VW����x  V�:�������t~V���������P$�����0   ��u
j ��_^��]�j�҃���E��E����0  HtHtHu=�E�Phxf���M�QhXf��	�U�Rh8f���y ����t�E����  �M����  _^��]����������������U��d�    j�h�_^Pd�%    �� �} SVW��u
�} u3���   ���*  P���������B$��W���Ѝ��,  Q������M��R$��Q���ҁ��.  S���������ȋB$W�Ѕ���   �M�苮z �E�    �M�UjQR�E�P�QZ ���E��M��¬z ��t�M�覬z P�M�hd��Q��z ���M�蜬z �����t1�U�R�M��}�}��c�z P��x �E�M������  ���  j�j ��B$�����E� �M��M�z �}��M��B�z �M�_^[d�    ��]� ���������������U���V��W�����x  W�E��E��!�������tV�E�Ph�f��<x ����tA�������   +ȋ�$  E�x'��t!W�����M������  �U�_���  ^��]Ë��m���_^��]��������U���V��V衢������tV�t�������P$���΃��uj ��3�^��]�j��j�E�WP�E������E������jAU ���M�Q�� V�*�������� � 3��}��^����]��̅�t��t��t�   �3�����������3�9�����������������������3�� �V�p���w��H���;2u��L����	�1;2u�q;rt��(=  @��ز�|Ƀ��^�������������VP��<^ �����V��;�^u�5!��h�*���% Y����������S�ك;���   ��4
   uoVW�4G�������y������t/V���W ����t"V蒎W ����uV�D� ��j ���(t���(�P�^<^ �����$V��;�u� ��h�*�聗% ��_^��S��������j j�ȋ��   j ��[�������������U��j�h`^d�    Pd�%    QV��u���z �E�    �N��z �E��N��z �E������M��^d�    ��]����������U��j�hN`^d�    Pd�%    QV��u��E�   �N��z �E� �N��z �E����������z �M�^d�    ��]����������U��E��t�� P�9�  t(=  =��|�3�]��������U��EP��<^ �ȃ���9t(=  =��|�3�]�������U��M����I 9t2(=  =��|��M���*�t��*���*�h�*�RP�~���3�]ËM��;�t�PR�P� RP�`����   ]����������U��d�    j�hh`^Pd�%    �EP���̉e臩z �E�    �����M�U�@jQR�E�������� ����M�d�    ��]���V�5��3�3�9��	  ~+��@  ��$    �@������P���P�PA��;��	  |�^�U������  ����   ��(  �H;�t�F�VR�PR�}���h�f�V������蜲�������  ������;�t�������� ���R������PR�<���h�f�������P�������U��������   ������;�t������������P������RP�������]��U��j�h�`^d�    Pd�%    ��  �E�    �����u�E������M�s�z �M�d�    ��]�h�f�  P������迱��������P�c�������t�V������WQ���������7j �M���z ���   P�����E������M��z �M�_^d�    ��]����U������  ��tF���e�R   P�������5���������P�ٜ������t������Q���������ȋB$j �Ћ�]�����U������  ��tI���e�R   P�������հ��������P�y�������t������Q�f�������ȋ��   j �Ћ�]��U������0  ����   hg�  P�������t���������P����������   ������Q����������  ��   R�E��������  �E����  ���  P�E��X������  �E����  �E����  �E��E�(��\M܃��M�Q�\��XE��E���Rt�M�Q���ҋ�]���������������U������0  ����   hDg�0  P�������t���������P����������   h$g�������Q�������F���������R��������t|������P�w������  �������E����  Q�E��Q������  �E����  �E����  �E��E��XE���M�Q�E���Rt�M�Q���ҋ�]����U����=�� ��   V�uV�C�������tV���������ȋB$j �Ћ����0  ;�t�F�VR�PR�(��������(  i�(=  ��Q�z7^ �E��rN��Pj�U�Rh�   �q� ��^��]����������U��������t2��(  i�(=  �� P�(7^ �E�� N��Pj�M�Qjm�"� ����]������������h�*����% Y�����U��������tB��(  i�(=  �� ���t*P��6^ ���E����t�M��Pj�E�Phw  �� ����]���������������������������U��=�� tZ�EP���������a�����xC���;��	  }5�����8  V���8  h���P�z �F����t�N�VQR�Ѓ�^]���������U��=�� tFV�uV�J�������������x0���;��	  }"�����8  �H��t�P�@RPV�у�^]ù�f�^]頂�����������������̋A������������̋���������������U��Ei�  ]� ��������������U��Ei�  P���z ��]� �������2���������������2���������������2��������������̋��������������U��E�PV��H� QRP���u����M��  ��^]� �����U��E]���������U��VW�}���O�GPQR���4�����  ��  _��^]� ����������������U��j�h�`^d�    Pd�%    QV��  P���̉e��@�z �E�    �	���M�@jQV�E������������M�d�    ^��]� �������������������������������������������V��  ������^���������������S�܃������U�k�l$���(V��ǆ  ����ǆ�0      �~�>�Wfֆ  �~�>���(  Wfֆ  ��������tFW�v������|��x  �E��M��E�    ��f��f�E��,M��M��U���x  ��{  ��P  W芕������tFW�������|��x  �E��M��E�    ��f��f�E��,M��M��U���x  ��{  �Ɛ  V�1�������tV����������� _^��]��[��U���  SVW�������]��h��ˍ������������(  ;�t�PR�P� RP������h��ˍ�����������0  ;�t�PR�P� RP�§����}�ˍ�����������8  ;�t�PR�P� RP薧����h��ˍ������T�����@  ;�t�PR�P� RP�j����xh��ˍ������(�����H
  ;�t�PR�P� RP�>����$f��ˍ������������P  ;�t�PR�P� RP�����lh��ˍ������������X  ;�t�PR�P� RP�����dh��ˍ�����������`  ;�t�PR�P� RP躦���Th��ˍ������x�����h  ;�t�PR�P� RP莦���Hh��ˍ������L�����p  ;�t�PR�P� RP�b����8h��ˍ������ �����x  ;�t�PR�P� RP�6����(h��ˍ�������������  ;�t�PR�P� RP�
����h��ˍ�������������  ;�t�PR�P� RP�ޥ����g��ˍ������������  ;�t�PR�P� RP貥���pY��ˍ������p������  ;�t�PR�P� RP膥����g��ˍ������D������   ;�t�PR�P� RP�Z�����g��ˍ������������"  ;�t�PR�P� RP�.�����g��ˍ�������������$  ;�t�PR�P� RP������g��ˍ�������������&  ;�t�PR�P� RP�֤����g��ˍ������������(  ;�t�PR�P� RP誤����g��ˍ������h���;�t�P�H� QRP��肤����g��ˍ������@������*  ;�t�PR�P� RP�V����pg��ˍ������������,  ;�t�PR�P� RP�*����hg��ˍ�������������.  _^[;�t�PR�P� RP�������]� �����U��S�]V��i�(=  ��(��;�t�O��GPQR���ģ���C�W��w��  ��  �z���^[]Í��2  ���2  �%���^[]�̃�
w9�A�i�(=  ��w��0��������������ǁ0
      ǁ4
  ������VW����i�(=  ��(��P��������ȋB$j �Ѓ�
w.�����w_��0��^����������ǆH�    ��L�_^�����U��EV��;�tP�}3����^]� ������U������u���]ËQV3�W��t2�	�u���   �9;}u�y;}u�y;}u9qt@��  ;�rك��_^]�����������U��S�]VW������L��; uK������P���������ȋB$j �ЍO��
w)��w������������ǆ���������F�    �����G�W����(=  ��|�_^[]�������U��d�    j�h9a^Pd�%    ��\  ����H��P�҅�u����M�d�    ��]�SVW�v���@�H��u���   3�WV�҉}�9~�g  �}�]�%   �󍽘������   �P��0����# �E�   �~�8  f�E��~�@  f�E؋�H  �M��E�   ��8���R��W ����uW�}�u�U�];=�>�u#;�>�u��>���>�;�u;�t~;�u;�t ;�8���u;�<���u;�@���u;�D���tV����u���0����E�ǅ0�����|�E�	   ��h����T�z �u���H����F�z �E��M�E�P  @�E�;AsW�����������u���0����U�ǅ0�����|�E�   ��h������z �u���H�����z �E�_^[�M�d�    ��]Ã���M�_��^[d�    ��]������̋����0  ���*�t��*���*�h�*�PR�՟�����ǀ�	      �����̡����t9��0  ���*�t��*���*�h�*�PR蒟�����ǀ�	      ������������������U��d�    j�hXa^Pd�%    �����(  ����  V��0  �;�*�u�N;�*���  �0���h�h�V�������?���������R���������s  ������SP�k�����T  ����U3ۃ��E쉑�	  �]����  �uW3���  ��$    �M���z �E�    Sh�h�P蕞z ��P������P������诟���E������M��0�z ������Q�D���������   ������R�-����M�����;M}r�V������8  ���<  �V��@  �V��D  �VQ�ˉ�H  �b�����   j �N��E�莓z P�E������Fth�����"� j�j ��P$���ҋ]�C��0  ���]�;]������_�4������0  P��������ȋB$j��[^�M�d�    ��]�������U��Q����U;�BAi�  P�M�z ��]� ������U��E�PV�u�H� QRP���$����M��  ��^]�������U��j�h�a^d�    Pd�%    ��SVh  ��z ���^���    �F   �u��]��E�    ��t>W�}�O��GPQR��譜����  ��  �E�����_��^[�M�d�    ��]� �E������M��^[d�    ��]� ���������̸�ů � ��������j�)z ���     �@   � �����̸ Ư � ��������j��z ���     �@   � �����̸Ư � ��������U��d�    j�h�a^Pd�%    V�u��  P���̉e� �z �E�    �����M�@jQV�E������������M�d�    ^��]��������������V��  ����������2  ǆ =      ��$=  ^��������U��VW�}���t�G�3�P�N�R�����X  ��X  ��\  ��\  ��`  ��h  ��h  ��`  ;�tP�+��_��^]� U��j�h�a^d�    Pd�%    ��hVW�����p�~�M��`+ �E�    ����   �M�Q���ҋ��� ��te�E�P���ÿ ��M;uQ�P;QuI�P;QuA�@;Au9���   ��t/�y  u)�\* ���V���;xt�v�>�G����H��d  Q���Ҹ   �E��M��M��E��U��U��E����ؙz �E������M��əz �M�_^d�    ��]����������U��j�hb^d�    Pd�%    ���ESV��W�]��t�P�U��
�E�    �U��C����%   �   �R���   �E��� �E�   �M��~�8  �E�fր8  �~�@  fր@  ��H  ��H  �E�   �E��h���X  ��X  ��\  ��\  ��`  h  P��h  ��`  �C �E������M�_^��[d�    ��]� ������̡������   �H���*�t��*���*�h�*�PR����������  ���*�t��*���*�h�*�PR藘�������   ���*�t��*���*�h�*�PR�m��������0  ǀ(  �������*�t��*���*�h�*�PR�9������ǀ�	      �5���������+��������������U��d�    j�h8b^Pd�%    �E��W���;���   �����   V�E�EP�M�Q�U�R�E�   �E   �ZU ���E��E�    �E���tP�M�}�}苐�  QRj�>T �E�u�M����N�}��}� t�U�R�7U ����^_�M�d�    ��]á $��u�$$���ċ $��E�$$���M�P_d�    ��]��U��d�    j�hXb^Pd�%    �E��W���;���   �����   V�E�EP�M�Q�U�R�E�   �E   �YU ���E��E�    �E���tP�M�}�}苐�  QRj�NS �E�u�M����N�}��}� t�U�R�+6U ����^_�M�d�    ��]á $��u�$$���ċ $��E�$$���M�P_d�    ��]��U��d�    j�hxb^Pd�%    �E��W���;���   �����   V�E�EP�M�Q�U�R�E�   �E   �XU ���E��E�    �E���tP�M�}�}苐�  QRj�^R �E�u�M����N�}��}� t�U�R�;5U ����^_�M�d�    ��]á $��u�$$���ċ $��E�$$���M�P_d�    ��]��U��d�    j�h�b^Pd�%    �E��W���;���   �����   V�E�EP�M�Q�U�R�E�   �E   ��WU ���E��E�    �E���tP�M�}�}苐�  QRj�nQ �E�u�M����N�}��}� t�U�R�K4U ����^_�M�d�    ��]á $��u�$$���ċ $��E�$$���M�P_d�    ��]��U��j�h�b^d�    Pd�%    ���M�M�M3��E�M�E�;�t	�UR�$����E������M�d�    ��]����������������U��d�    j�h'c^P�Ed�%    ��;E�  S�]V�M�W�M��E� �]�3ɉM�;���   ;�t�P�U���M�эC����%   �   �R���   �E�� �E��M�E��~�8  fր8  �~�@  fր@  ��H  ��H  �E��E��h���X  ��X  ��\  ��\  ��`  h  ��`  P��h  �- �E� �E�E�����  ��  �]�E;E����_^��[�M�d�    ��]ËM�Ed�    ��]��U��Q��ԯ ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸�ԯ ����������̸�ӯ � ��������U��Q�E;E��   S�]VW�à   �d$ ��t�P�U��
�E�    �U���h����%   ��󥍊�   ;�tQ���"���E�U��~�8  fփ�   �~�@  fփ�   ��H  ���   ��X  ���   ��\  ���   ��`  ���   ��h  ���   ;�t	R�"���E�E    ��  �E;E�<���_^[�E��]���U��E�MPQ�P�����]� ���������U��d�    j�h`c^P�Ed�%    �~ ��S��Vfփ  �~@W���  Vfփ  ��}������t7���  W�}������t$V�H�������ȋB$j ��W�t��������J� ���   V�~}������tV�1�������ȋB$j�Ѝ�X  V�W}������tV��������ȋB$j �Ѝ�`  V�0}������tV�ø������ȋB$j �Ћ�ǃ�0      �������3�9E���  ��V��  ���}��|������tQ��t�M诅z ��t�   �3�V�|�������ȋB$W��V�i����M�����7j �X�z ���   P���ҋ}���   V�~|��������   ��t�} t�   �3�V��������ȋB$W�ЋMj j jQ�U�R�*=z ���E�    �����z P�M�萓z �E��M���z V�η�������7j �M�轄z P���   �����E������M��Îz ���.  V��{������tV�j�����R$3Ƀ�9M��Q���҃}(�u�EP�AW ���E(��0  Q�4������"  R���F������} ����   �E(P�M�Q�Z�������  �@������  �B$j���ЋMj j jQ�U�R�(<z ���E�   �����z P�M�莒z �E��M���z �7j �M��ƃz P���   ���Ћ�E,�R$P���҃���}��M����z ���P$j ���ҋ�P$j ���҃���E(P�M�Q������@  R���J�������  �V���} ���  �}�}�td�u�E���P����V �M�VQ�E�   �E���QU ����3����t"Vh �U ����tVh ��U �����U�RWj��I ����8  P��������M��Q����� ����   j���Ѝ�P  V��y������tV胵������ȋB$j �Ѝ�(  W��y������t=W�\�������ȋB$j�ЋM(Q�U�R����W���9�������  �V�����  ���$  V�yy������tV�,�������ȋB$j �Ёø&  �   �I S�Jy������tS��������ȋB$j �Ё�  Nu֋M�_^[d�    ��]�( ���U��j�h�c^d�    Pd�%    ��HS�]�~��   V��fֆ  �~��   Wfֆ  �����@�E�3���   ��$  9�@  t��8  ��   ��<  ��$  ���  W�x������t7���  S�ux������t$W��������ȋB$j ��S�4��������
� ���   W�>x������t;��(  S�+x������t(W�޳������ȋB$j��S誳������ȋB$j��3��}�������H��B�Ѕ�tH�M�Y��B���Ѕ�u2�~�  ��R�E�f�E��~�  P��f�E����E�   ��u�}���X  S�w������tS�#����M���R$��Q���ҍ�`  P�gw������t[�M3�9��   ������`  P��������ȋB$W��S�1w������t%��u9}�t�   �3�S貲������ȋB$W�Ћ������M�ǆ  �����l�z �E�    �M��]�z �E�������H��B�Ѕ�t�M�UQ�   R�E�P�M�Q�������h�h�h�  �j�Q ��P�U�R�=�Q �����E�j �M��Jz P�M��Az P���9z P�E�P�O�Q ���E��M��0�z ���  Q�������؋;j �M���~z ���   P���ҍ��   W�v������tj�E���   j j jQ�U�R��6z ���E����~z P�M��U�z �E��M�蹈z W蓱�����؋;j �M��~z P���   �����E��M�苈z �E���    t���   �M��E    ���   �]����u�UR�v;W ���E��؍E�SP�t�����(  Q�����������  �O�U�SR���  �;�������H
  P�Ͱ������  �W���  ��0  P谰�����"  Q���°���� �} ����   �U�R�E�P���������  �P������  �P$j���ҋEj j jP�M�Q�5z ���E����v}z P�M���z �E�
�M��q�z �;j �M��E}z ���   P���ҋ�P$j�����E��M��C�z ���P$j ���ҋ�P$j ���ҋE�P�M�Q������@  R���Я����]���  �W�����   ���  �N� ����������   P��V �M�WQ�E�   �E��uKU �������3ۉE�E�;�t"Wh �U ����tWh �tU ���؍U�RSj�sC ��8  P�w������M��Q���g� ����   j���Ѝ�P  W�ms������tW� �������ȋB$j �Ѝ�H
  W�Fs������tW�ٮ������ȋB$j �Ѝ��$  W�s������tW�Ү������ȋB$j �ЁƸ&  �   V��r������tV�Ʈ������ȋB$j �Ё�  Ou��E��M�装z �E� �M�藅z �E������M�舅z �M�_^[d�    ��]� �����S�܃������U�k�l$��j�h�c^d�    Pd�%    S��8VW���}�3��E����0  �������8  V�>r��������   V�����s�E��C���P����V �M�VQ�E�   �E��IU ��������EԉE��E�    ;�t#Vh �U ����tVh �U ���E�E�U�RPj�A �u����M�Q���� �i���x  �E��U��E�    f��f�E��,E��E�M쉎x  ��{  ���  V�^q������t$V�����0��j �K�E��zz �M����   P�ҍ�(  V�'q������tFV躬���i���x  �E��M��E�    ��f��f�E��,M��M�U쉐x  ��{  ��P  V��p������tFV�a����i���x  �E��M��E�    ��f��f�E��,M��M�U쉐x  ��{  ��`  V�up������tV��������ȋB$j�Ѝ�X  V�Np������tV�����K��R$��Q���ҍ��   V�%p������tf�C j j jP�M�Q��0z ���E�����xz P�M��d�z �E��M��Ȃz V被���0��j �MЉE��xz �M����   P���E� �M�蘂z ���&  �E�   V�o������tV�x�������ȋB$j �Ё�  �M�uԃ{0�u�K$Q�p5W ���C0�S0R�E�P�m�������(  P��������  �V���  �C0P�M�Q�1�����H
  R���ê������  �V���  ��0  P親���Ǩ"  W��踪���� �{$ ����   �K0Q�U�R���������  �P������  �P$j���ҋC$j j jP�M�Q�/z ���E����lwz P�M���z �E��M��g�z �7j �M��;wz ���   P���ҋ�P$j�����E� �M��9�z ���P$j ���ҋ�P$j ���ҋC0P�M�Q�����U܁�@  R���é������  �V�����  �E������K���z �M�_d�    ^��]��[�, �����������U��j�hd^d�    Pd�%    QV�uV�m������tV���������6t���������@�H�E�    �E�    ����   �U�R��\  R��X  R���E������E���t*�H�ym����u�E��P�HQ����V���y ���E�    �M�^d�    ��]���������U��UV��N;�vX�����;�BFi�  WP��z �V�Mi�  ���QW�RP�
����N�i�  �QP������R���z �� �>_^]� ���U��EVP�������� �ӯ ����A�ů ^]� ���������U��V��Fi�  W�}WP��  Q�=����Vi�  RP�{������N��_^]� �������������U��E�MPQ�P�����]������������U��j�h(d^d�    Pd�%    QSV��W3��u��>�~�~�}���*���*�h�*�P�NR��~����*���*�h�*�P��  R��~����*���*�h�*�P��   R�~�������(  ��*���*�h�*�P��0  R�~�����	  ��@  �O�X��x��8�x�x��Iu�]��M�_��^[d�    ��]����������������U��j�hHd^d�    Pd�%    QV��u��E������N�i�  �QP�����R��z �M��^d�    ��]�������������U��d�    j�hhd^Pd�%    ��V3�;�u3�^�M�d�    ��]��x����H��P�҅�t�S�u�u�u�u��X����@�H��@�U�R�U�R�Ћ]�3�;�vB�E���d$ ����  �P�;0u!����  ;pu����  ;pu��Đ  ;ptDA�   ;�r��E������E���E����QP茅���U�R�#�z ��[3�^�M�d�    ��]ËM;�tR����E������E���E����QP�E����U�R�ܳz �M��[�   ^d�    ��]�����S�܃������U�k�l$��d�    j�h�d^Pd�%    S��XVW�����  V�Ai������tA���  P�.i������t.V���������ȋB$j�Ѝ��  P������j j���� ��8  Q�ͤ���K���E��� �S����BLP���\�V �M�VQ�E�   �E��H@U ��������E؉E��E�    ;�t#Vh ��U ����tVh �BU ���E�E�U�RPj�=8 ���M�Q�M��>� �M���rz �E�    �M���rz �E��Sj R�E�P�M�Q���N���h�h�h�  ���Q ��P�U�R�ªQ �����E�j �M���pz P�M���pz P���pz P�E�P�ԒQ ���E��M��zz ���  Q艣���0��j �M��E��pz �M싖�   P�ҍ��  V�g�������  V�n������{ ��t�n����@�H��P�҅�t�   �3��P�B$���ЋE���x  �M�3ɉM�9Ktz�i��E�f��f�E��,U��U�9��  ujQjj ��y �����  �K���  Q��� �� �rm���C�~�p  fև  �~�x  �E�fև  ����|�E�f��f�E��,U��U�M�U�   ��x  V��{  �f������to�{ ti�C�HTj j jQ�U�R�['z ���E����-oz P�M���}z �E��M��(yz V�����0��j �M�E���nz �M�P���   ���E��M���xz ��P  V�f������tV蟡������ȋB$j �Ѝ�H
  V��e������tV�x�������ȋB$j �Ѝ�`  V�e������tV�Q�������ȋB$j �Ѝ�(  V�e������tV�*�������ȋB$j ���E��M��Pxz �E� �M��Dxz �E������M��5xz �M�_d�    ^��]��[� U��=�� tFV��i�(=  W��(��W�e������t'W豠������ȋB$j�ЋM�UQR��0���p���_^]�������������U��d�    j�h�d^Pd�%    ��8�=�� SW��  �}i�(=  ��(��S�d��������  S�0�������ȋB$j���E�    �f����H��B�Ѕ�tM�S����@�X��E��B���Ѕ�u+��R�EP���҅�t�E����   ��t�x  �E�   t�E�    �M�����M��nz �E�    �M��|nz �E�j V�M�Q�U�R��0������h�h�h�  ��Q ��P�E�P�v�Q ���E��E�j �M��lz P�M��ylz �M�P�plz P�M�Q膎Q ���E��M��gvz ��� � �U �~Efև@���~ERP��fևH���� �NT�U�P�EPQR���� P�FLP���Uȋ̉e�R��mz �E��E���0�������E��M���uz �E� �M���uz �E������M���uz �M�_d�    [��]�������U��j�hde^d�    Pd�%    ���  SVW3��ى]�}��}�}�}��~�  ����f� �~�  f�@�E��e�P������  Q���$�V �؃�;�u���t���P �@t*�f����E������U�E�i�P  �RP�/���E�P��  ����E������x��f��L���E�;�u4��B���Ѕ�t����   ������M�@j	�ǘ   WQ���ah���  ����  ����  ���9�P�  �_  9�X�  �S  ��B���Ѕ��  ���   3�;���   9p ��   �O����  V������tp������������E��O��R ������PV�ҋE싈  Q���̉e��kz �E��#����M�@j������RQ�E����؊���E� �������y���=  �U싂  �MPQ������R�������P�M�.����E��~f�E��~Ff�E������@�H��@d�UR�U�R���E� �M�A-����  �uԉu؉u��E������   V�E�P���ҍ������7���E�3�9u�vn��I �E��P��0��������E�������Q����  ������u�E���0����f
��G��P  ;}�r��!��0���R�������F����E���0����7
���E싈  Q���̉e��`jz �E�������M�@jj������RQ�E����zZ���E���������	���E� �M��W����   �U싂  P���̉e�j SQ��V ���E��c����U�HR�E� 裾���   �i����u��M��V���M�d�    _^[��]� ���to�E�H��y3��;�~��i�P  u�������V�����	�]�j����̉e��{iz �E�
������U�@jj������QR�]����Y���E� �������	��h���h  舼Q ��P�@ �E�8  P聚�����j j�ȋ��   j ���E������M�E�i�P  �QP�P+���U�R觨z �M��_^d�    [��]� �U��j�h�e^d�    Pd�%    ��DS3�VW���]�]�]�]��~�  ����f� �~�  f�@�E�e�P�(�����  Q����V �����}�;�u*���u%�E������U�E�i�P  �RP�*���E�P�  �?��;�t;�t;���  ���tM�����@��i�P  }�M�Q���̕ ���   ;u%���   ;Hu���   ;Pu���   ;H�t���SjJ����������u  �u�����h  �M��gz �E��M��gz ��]�j j �E�j���tv�M�i�P  ���   RP�8 ���E����ez P�M�h}Q��oz ���]��M��oz ���U؋̉e�R�sgz �E�u�M��Ơ   VQ�]����N ���E��~�u��~���  �Ƹ�  �U�Rf�E��~FPf�E��V. ���E����(ez P�M�h}Q�ioz ���]��M��oz ���U؋̉e�R��fz �E�V�E�P�]��y�N ���E�P�M��pz �]��M���nz h��������j�M̋��dz P���� �E��M��nz �E� �M��nz �E������M�E�i�P  �QP�(���U�R��z �M��_^d�    [��]� ����������U���  �=�� u	�y�����]�V�uV�;�����\  ����`  ��X  QRP�������Xn���������=������u
�3���^��]Ë�i�(=  V��0���*���^��]������U��d�    j�h f^Pd�%    ��S�]VW����+��~��G�������9Gu	@P�������G���i�  ʉM�;�s@i�  �3��U�E�U�M�E�;�tV�����E������G_^[�M�d�    ��]� 3��U�E�U�M�   �u�;�tS�q����E�����w�M�_^[d�    ��]� ����U��EVi�  �u�V�i�  �P�R  P������Ni�  QP�������N^]���������̸P� � ��������U��j�hf^d�    Pd�%    QV��u��E������N�i�  �QP�����R辣z ���Et	V���y ���M��^d�    ��]� ���������S�܃������U�k�l$��d�    j�h�f^Pd�%    S���   V��W���  W�Y������t=���  P��X������t*W莔������ȋB$j �Ѝ��  P贙������芇 ���   P�X������tA��(  W�X������t.���   P�X�������ȋB$j��W�$�������ȋB$j�Ѝ�`  W�jX������tW���������ȋB$j ��3��E�E�C�x��X�  �M���tO��[�R��{� � ��8  ��t4�W�`����t(�}�t"Q���3����ȉe�賭X ��t�   �E�E荾h  W��W������tW�����M��R$��Q���ҍ�p  W�W��������   W�>������C�����X�   �B$��uj ���mj�ЍM���az �E�    �E��uh�i��$�{ t&��tHt
Huh�i��hdi��hHi��M��btz �M���_z P���B���E������M���iz ��X  P�W��������   �}� u}������H��B�Ѕ�tj������@�x��E�B���Ѕ�uH�C�~���  ��Rf�E��~���  �E�P��f�E��҅�t�E싀�   ��t�x  �E�   t�E�    ��X  P�����M��R$��Q���ҋ�  P��V ����u���0  �������{�W��  �v�����M��E��`z �E�   �M��`z �E��������� �E�������R�0�����j ��t������P�M�Q�U�R�������)�CP�M�Q��V ���E�P�M��Bjz �E��M��hz �}� th@i��M��3uz h�h�h�  �T�Q ��P�U�R�'�Q �����E�j �M��4^z P�M��+^z P���#^z P�E�P�9�Q ���E��M��hz ���  Q�����8��j �M��E���]z �M苗�   P�ҍ��   W�U������tl�C��P�  j j jQ�U�R��z ���E�	���]z P�M��=lz �E��M��gz W�{����8��j �M؉E��i]z �M�P���   ���E��M��qgz �{�OQ�E������^bX ����t	���   �U䋇 �  P�� ����t�Hd�M�}��u��T�  R�CW ���E�E�P�M�Q�@�����(  R���������  �W���  �E�P�M�Q��������H
  P薏������  �O���  ��H
  P�y�������ȋB$j�Ѝ�0  Q�_������"  R���q����E�C����T�   ��   �M�Q�U�R�~�������  �P������  �P$j���ҋC��T�  j j jQ�U�R�Fz ���E����\z P�M��jz �E��M��fz �E�8j �M���[z �M苗�   P�ҋM��P$j���E��M���ez ���P$j ���ҋM��P$j �ҋE�P�M�Q������@  R���l�������  �W�K���  ����E܉E�j �E�PQ������8  R�w��������E�P���g� ����   3�9E����P�ҍ�P  W�fR������tSW���������P$��j�������|��x  �E��E��E�    f��f�E��,E��E�M艏x  ��{  �}� Q��P  u�S��@�  �W��$襫�������$  W��Q��������   W腍�������[� ��E�P�B$���Ѓ}� tO�K���  tCh(i�h�  �]�Q ��P�U�R�0�Q ���E�����   �M�j ���%Zz P�E������Ahi�h�  ��Q ��P�E�P��Q ���E�����   �M�j ����Yz �U�P������E��M���cz ���&  Wǆ�0      ��P��������   �=�� t:���E�   ���$    hi�j��O ������������  �M�u��   �� ���tH��M�y$�Ql�U�u1�A;�  u&�ription",
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
				talents.revision = Hermes.SPELL_MONITOR_SCHEMA.re ���������������U��j�h{^d�    Pd�%    QV��u��E��������t(�H�\�����uW�>�O�GP��W�� y ��_�    �M�^d�    ��]��������������U��j�h8{^d�    Pd�%    QVW�}���u����t�H�ݏ���E�    �G�F�O�N�E������M�_��^d�    ��]� ���������������U��j�hX{^d�    Pd�%    QV��u��E��������t(�H�|�����uW�>�O�GP��W��y ��_�    �M�^d�    ��]��������������U��j�hx{^d�    Pd�%    QVW�}���u����t�H������E�    �G�F�O�N�E������M�_��^d�    ��]� ���������������U��j�h�{^d�    Pd�%    QV��u��E��������t(�H蜎����uW�>�O�GP��W�y ��_�    �M�^d�    ��]��������������U��Q�� ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸� �����������U��Q� �� ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸ �� �����������U��Q�@�� ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸@�� �����������U��Q�p�� ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸p�� �����������U��Q���� ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸��� �����������U��Q�Я� ��5ŝ�i�� �M��U���3��M�i�� 3�i�� 3�i�� ��]���������������̸Я� �����������U��d�    j�h�{^Pd�%    V�E������u�~r�P�Oy ���M��F   �F    � d�    ^��]�������������U��d�    j�h�{^Pd�%    V�E������u�~r�P��y ���M��F   �F    � d�    ^��]�������������U��d�    j�h�{^Pd�%    V�E������u�~r�FP�y ���M�3��F   �F�Fd�    ^��]�������������̸࠰ � �������̸ �� � ��������U��E�M�UP�QP�������]������U��EP褴����]����������������U��E��UQR�N�����]����������U��E�M�UP�QP������]������U��EP�Ľ����]����������������U��E��UQR螿����]����������U��E�MPQjj�,�����]��������U��E�MPQjj ������]��������U��E�M�PR������]� �������U��EP������]� �������������U��E�M�UP�EQ�RQ�&�����]� ���������������U��E�M�UP�EQ�RQ�&�����]� ���������������U��EP�T�����]� �������������U��E�M�UP�QP�:�����]� ���U��j�h�|^d�    Pd�%    ��  SV��P��������E�    �M��&�y �E�   �����@�H��@ ��P���R�UR�Ѕ�u�E�   �  3��[����@�H��R�� ���P�҅�t�   �9����@�H$��@��P���R�����@Pj V��P���Q�U�R��[ ���E��M�荒y ���]��M��ΐy Ph}V��y �̉e�P�W�y �E��� ���P�M�Q�]��0�M ���	�]��M�蠚y �E�� ��   H��  ������x ��  htn�h�  �_�P ��P�U�R�2�P �����E�j �M��?�y P���'�y P�E�P�M�P ���E��M��.�y �M�jQ�c����~� ������U�f�E��~����R�M�f�E��*����E������p������P�M�Q�M��ˏy Ph |�U�Rj��� �E��M���   ������8 ��   hdn�h�  ��P ��P�E�P�b�P �����E�
j �M��o�y P���W�y P�M�Q�}�P ���E��M��^�y �U�jR蓥���~� ������E�f�E��~����P�M�f�E�������E��1����p������Q�U�R�M����y Ph |�E�Pj ���� �E��M��,����]��M���y �E��M��՘y �E��M��ɘy �E�   �M�躘y �E�������P����h����M�^d�    [��]���������U��d�    j�h�|^Pd�%    ���} ��   h�n�h�  �L�P ��P�E�P��P ���E�    �����x ��   j�Oy �     �   �H�E� `y� �U���BPI� �M������@j h Y��MQ�U�Rj��� �E� �E��t,�H������u�E�PV�HQ����V�|y ��^�E    �E������M�袗y �M�d�    ��]�����U��d�    j�h0}^Pd�%    ��T�} SVW��  �} �|  h�n�h�  �?�P ��P�E�P��P ���E�    �M��Ўy �E��u���  �   ��t1jj S��`  Q�U�R��W ���E�P�M�襘y �E��M���y �M�聎y ���]��M��Čy Ph}W��y �̉eP�M�y �E���  P�M�Q�]��&�M ���E��M�藖y �U�jR�̢�����FP�M��]�y �E��M�jQ订�����M���y ��]����   t>j �M��;�y P�M��2�y P�M��)�y P�U�R�?�P ���E�	P�M��ϗy �]��M��ch�n�h�  ���P ��P�E�P���P �����E�
j �M��؋y P���Ћy P�M�Q��P ���E�P�M��v�y �E�
�M�躕y �]��M�试y j��y �     �@   �E� py� �U���B`I� �E������ph Y��EP�M��X�y Ph�n��M�Qj���E �]��E��t*�H胂����u�E�P���@R��V��y ���E    �E��M���y �E��M��	�y �E��M