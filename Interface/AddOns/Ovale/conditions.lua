--[[--------------------------------------------------------------------
    Copyright (C) 2009, 2010, 2011, 2012, 2013 Sidoine De Wispelaere.
    Copyright (C) 2012, 2013, 2014 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

local OVALE, Ovale = ...

local LibBabbleCreatureType = LibStub("LibBabble-CreatureType-3.0", true)
local LibRangeCheck = LibStub("LibRangeCheck-2.0", true)

local OvaleBestAction = Ovale.OvaleBestAction
local OvaleCompile = Ovale.OvaleCompile
local OvaleCondition = Ovale.OvaleCondition
local OvaleCooldown = Ovale.OvaleCooldown
local OvaleDamageTaken = Ovale.OvaleDamageTaken
local OvaleData = Ovale.OvaleData
local OvaleEquipment = Ovale.OvaleEquipment
local OvaleFuture = Ovale.OvaleFuture
local OvaleGUID = Ovale.OvaleGUID
local OvaleLatency = Ovale.OvaleLatency
local OvalePower = Ovale.OvalePower
local OvaleRunes = Ovale.OvaleRunes
local OvaleSpellBook = Ovale.OvaleSpellBook
local OvaleSpellDamage = Ovale.OvaleSpellDamage

local floor = math.floor
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local type = type
local wipe = wipe
local API_GetBuildInfo = GetBuildInfo
local API_GetItemCooldown = GetItemCooldown
local API_GetItemCount = GetItemCount
local API_GetNumTrackingTypes = GetNumTrackingTypes
local API_GetTime = GetTime
local API_GetTotemInfo = GetTotemInfo
local API_GetTrackingInfo = GetTrackingInfo
local API_GetUnitSpeed = GetUnitSpeed
local API_GetWeaponEnchantInfo = GetWeaponEnchantInfo
local API_HasFullControl = HasFullControl
local API_IsSpellOverlayed = IsSpellOverlayed
local API_IsStealthed = IsStealthed
local API_UnitCastingInfo = UnitCastingInfo
local API_UnitChannelInfo = UnitChannelInfo
local API_UnitClass = UnitClass
local API_UnitClassification = UnitClassification
local API_UnitCreatureFamily = UnitCreatureFamily
local API_UnitCreatureType = UnitCreatureType
local API_UnitDetailedThreatSituation = UnitDetailedThreatSituation
local API_UnitExists = UnitExists
local API_UnitHealth = UnitHealth
local API_UnitHealthMax = UnitHealthMax
local API_UnitIsDead = UnitIsDead
local API_UnitIsFriend = UnitIsFriend
local API_UnitIsPVP = UnitIsPVP
local API_UnitIsUnit = UnitIsUnit
local API_UnitLevel = UnitLevel
local API_UnitName = UnitName
local API_UnitPower = UnitPower
local API_UnitPowerMax = UnitPowerMax
local API_UnitStagger = UnitStagger
local INFINITY = math.huge

local Compare = OvaleCondition.Compare
local ParseCondition = OvaleCondition.ParseCondition
local TestBoolean = OvaleCondition.TestBoolean
local TestValue = OvaleCondition.TestValue

--[[--------------------
	Helper functions
--]]--------------------

-- Return the target's damage reduction from armor, assuming the target is boss-level.
-- This function makes heavy use of magic constants and is only valid for level 93 bosses.
local function BossArmorDamageReduction(target, state)
	-- Boss armor value empirically determined.
	local armor = 24835
	local constant = 4037.5 * state.level - 317117.5
	if constant < 0 then
		constant = 0
	end
	return armor / (armor + constant)
end

--[[
	Return the value of a parameter from the named spell's information.  If the value is the name of a
	function in the script, then return the compute the value of that function instead.
--]]
local function ComputeParameter(spellId, paramName, state)
	local si = OvaleData:GetSpellInfo(spellId)
	if si and si[paramName] then
		local name = si[paramName]
		local node = OvaleCompile:GetFunctionNode(name)
		if node then
			local timeSpan, priority, element = OvaleBestAction:Compute(node.child[1], state)
			if element and element.type == "value" then
				local value = element.value + (state.currentTime - element.origin) * element.rate
				return value
			end
		else
			return si[paramName]
		end
	end
	return nil
end

-- Return the time in seconds, adjusted by the named haste effect.
local function GetHastedTime(seconds, haste, state)
	seconds = seconds or 0
	if not haste then
		return seconds
	elseif haste == "spell" then
		return seconds / state:GetSpellHasteMultiplier()
	elseif haste == "melee" then
		return seconds / state:GetMeleeHasteMultiplier()
	else
		state:Log("Unknown haste parameter haste=%s", haste)
		return seconds
	end
end

--[[---------------------
	Script conditions
--]]---------------------

do
	-- Test if a white hit just occured
	-- 1 : maximum time after a white hit
	-- Not useful anymore. No widely used spell reset swing timer anyway

	local function AfterWhiteHit(condition, state)
		local seconds, comparator, limit = condition[1], condition[2], condition[3]
		local value = 0
		Ovale:OneTimeMessage("Warning: 'AfterWhiteHit() is not implemented.")
		return TestValue(0, INFINITY, value, state.currentTime, -1, comparator, limit)
	end

	--OvaleCondition:RegisterCondition("afterwhitehit", false, AfterWhiteHit)
end

do
	--- Check whether the player currently has an armor set bonus.
	-- @name ArmorSetBonus
	-- @paramsig number
	-- @param name The name of the armor set.
	--     Valid names: T11, T12, T13, T14, T15, T16
	--     Valid names for hybrid classes: append _caster, _heal, _melee, _tank.
	-- @param count The number of pieces needed to activate the armor set bonus.
	-- @return 1 if the set bonus is active, or 0 otherwise.
	-- @usage
	-- if ArmorSetBonus(T16_melee 2) == 1 Spell(unleash_elements)

	local function ArmorSetBonus(condition, state)
		local armorSet, count = condition[1], condition[2]
		local value = (OvaleEquipment:GetArmorSetCount(armorSet) >= count) and 1 or 0
		return 0, INFINITY, value, 0, 0
	end

	OvaleCondition:RegisterCondition("armorsetbonus", false, ArmorSetBonus)
end

do
	--- Get how many pieces of an armor set, e.g., Tier 14 set, are equipped by the player.
	-- @name ArmorSetParts
	-- @paramsig number or boolean
	-- @param name The name of the armor set.
	--     Valid names: T11, T12, T13, T14, T15.
	--     Valid names for hybrid classes: append _caster, _heal, _melee, _tank.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of pieces of the named set that are equipped by the player.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ArmorSetParts(T13) >=2 and target.HealthPercent() <60
	--     Spell(ferocious_bite)
	-- if ArmorSetParts(T13 more 1) and TargetHealthPercent(less 60)
	--     Spell(ferocious_bite)

	local function ArmorSetParts(condition, state)
		local armorSet, comparator, limit = condition[1], condition[2], condition[3]
		local value = OvaleEquipment:GetArmorSetCount(armorSet)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("armorsetparts", false, ArmorSetParts)
end

do
	--- Get the base duration of the aura in seconds if it is applied at the current time.
	-- @name BaseDuration
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The base duration in seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see BuffDuration
	-- @usage
	-- if BaseDuration(slice_and_dice_buff) > BuffDuration(slice_and_dice_buff)
	--     Spell(slice_and_dice)

	local function BaseDuration(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local value = OvaleData:GetBaseDuration(auraId, state)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("baseduration", false, BaseDuration)
	OvaleCondition:RegisterCondition("buffdurationifapplied", false, BaseDuration)
	OvaleCondition:RegisterCondition("debuffdurationifapplied", false, BaseDuration)
end

do
	--- Get the value of a buff as a number.  Not all buffs return an amount.
	-- @name BuffAmount
	-- @paramsig number
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param value Optional. Sets which aura value to return from UnitAura().
	--     Defaults to value=1.
	--     Valid values: 1, 2, 3.
	-- @return The value of the buff as a number.
	-- @see DebuffAmount
	-- @see TickValue
	-- @usage
	-- if DebuffAmount(stagger) >10000 Spell(purifying_brew)
	-- if DebuffAmount(stagger more 10000) Spell(purifying_brew)

	local function BuffAmount(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local value = condition.value or 1
		local statName = "value1"
		if value == 1 then
			statName = "value1"
		elseif value == 2 then
			statName = "value2"
		elseif value == 3 then
			statName = "value3"
		end
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = aura[statName] or 0
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffamount", false, BuffAmount)
	OvaleCondition:RegisterCondition("debuffamount", false, BuffAmount)
	OvaleCondition:RegisterCondition("tickvalue", false, BuffAmount)
end

do
	--- Get the player's combo points for the given aura at the time the aura was applied on the target.
	-- @name BuffComboPoints
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of combo points.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffComboPoints
	-- @usage
	-- if target.DebuffComboPoints(rip) <5 Spell(rip)

	local function BuffComboPoints(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = aura and aura.combo or 0
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffcombopoints", false, BuffComboPoints)
	OvaleCondition:RegisterCondition("debuffcombopoints", false, BuffComboPoints)
end

do
	--- Get the number of seconds before a buff can be gained again.
	-- @name BuffCooldown
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffCooldown
	-- @usage
	-- if BuffCooldown(trinket_stat_agility_buff) > 45
	--     Spell(tigers_fury)

	local function BuffCooldown(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain, cooldownEnding = aura.gain, aura.cooldownEnding
			cooldownEnding = aura.cooldownEnding or 0
			return TestValue(gain, INFINITY, 0, cooldownEnding, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffcooldown", false, BuffCooldown)
	OvaleCondition:RegisterCondition("debuffcooldown", false, BuffCooldown)
end

do
	--- Get the total count of the given aura across all targets.
	-- @name BuffCountOnAny
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param stacks Optional. The minimum number of stacks of the aura required.
	--     Defaults to stacks=1.
	--     Valid values: any number greater than zero.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param excludeTarget Optional. Sets whether to ignore the current target when scanning targets.
	--     Defaults to excludeTarget=0.
	--     Valid values: 0, 1.
	-- @return The total aura count.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffCountOnAny

	local function BuffCountOnAny(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local _, filter, mine = ParseCondition(condition, state)
		local excludeUnitId = (condition.excludeTarget == 1) and state.defaultTarget or nil

		local count, stacks, startChangeCount, endingChangeCount, startFirst, endingLast = state:AuraCount(auraId, filter, mine, condition.stacks, excludeUnitId)
		if count > 0 and startChangeCount < INFINITY then
			local origin = startChangeCount
			local rate = -1 / (endingChangeCount - startChangeCount)
			local start, ending = startFirst, endingLast
			return TestValue(start, ending, count, origin, rate, comparator, limit)
		end
		return Compare(count, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffcountonany", false, BuffCountOnAny)
	OvaleCondition:RegisterCondition("debuffcountonany", false, BuffCountOnAny)

	-- Deprecated.
	OvaleCondition:RegisterCondition("buffcount", false, BuffCountOnAny)
	OvaleCondition:RegisterCondition("debuffcount", false, BuffCountOnAny)
end

do
	--- Get the player's damage multiplier for the given aura at the time the aura was applied on the target.
	-- @name BuffDamageMultiplier
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The damage multiplier.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffDamageMultiplier
	-- @usage
	-- if target.DebuffDamageMultiplier(rake) <1 Spell(rake)

	local function BuffDamageMultiplier(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local baseDamageMultiplier = aura.snapshot and aura.snapshot.baseDamageMultiplier or 1
			local damageMultiplier = aura.damageMultiplier or 1
			local value = baseDamageMultiplier * damageMultiplier
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(1, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffdamagemultiplier", false, BuffDamageMultiplier)
	OvaleCondition:RegisterCondition("debuffdamagemultiplier", false, BuffDamageMultiplier)
end

do
	--- Get the current direction of an aura's stack count.
	-- A negative number means the aura is decreasing in stack count.
	-- A positive number means the aura is increasing in stack count.
	-- @name BuffDirection
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current direction.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffDirection

	local function BuffDirection(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain, start, ending, direction = aura.gain, aura.start, aura.ending, aura.direction
			return TestValue(gain, INFINITY, direction, gain, 0, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffdirection", false, BuffDirection)
	OvaleCondition:RegisterCondition("debuffdirection", false, BuffDirection)
end

do
	--- Get the total duration of the aura from when it was first applied to when it ended.
	-- @name BuffDuration
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The total duration of the aura.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffDuration

	local function BuffDuration(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = ending - start
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffduration", false, BuffDuration)
	OvaleCondition:RegisterCondition("debuffduration", false, BuffDuration)
end

do
	--- Test if an aura is expired, or will expire after a given number of seconds.
	-- @name BuffExpires
	-- @paramsig boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param seconds Optional. The maximum number of seconds before the buff should expire.
	--     Defaults to 0 (zero).
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param haste Optional. Sets whether "seconds" should be lengthened or shortened due to haste.
	--     Defaults to haste=none.
	--     Valid values: melee, spell, none.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @see DebuffExpires
	-- @usage
	-- if BuffExpires(stamina any=1)
	--     Spell(power_word_fortitude)
	-- if target.DebuffExpires(rake 2)
	--     Spell(rake)

	local function BuffExpires(condition, state)
		local auraId, seconds = condition[1], condition[2]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			seconds = GetHastedTime(seconds, condition.haste)
			if ending - seconds <= gain then
				return gain, INFINITY
			else
				return ending - seconds, INFINITY
			end
		end
		return 0, INFINITY
	end

	OvaleCondition:RegisterCondition("buffexpires", false, BuffExpires)
	OvaleCondition:RegisterCondition("debuffexpires", false, BuffExpires)

	--- Test if an aura is present or if the remaining time on the aura is more than the given number of seconds.
	-- @name BuffPresent
	-- @paramsig boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param seconds Optional. The mininum number of seconds before the buff should expire.
	--     Defaults to 0 (zero).
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param haste Optional. Sets whether "seconds" should be lengthened or shortened due to haste.
	--     Defaults to haste=none.
	--     Valid values: melee, spell, none.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @see DebuffPresent
	-- @usage
	-- if not BuffPresent(stamina any=1)
	--     Spell(power_word_fortitude)
	-- if not target.DebuffPresent(rake 2)
	--     Spell(rake)

	local function BuffPresent(condition, state)
		local auraId, seconds = condition[1], condition[2]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			seconds = GetHastedTime(seconds, condition.haste)
			if ending - seconds <= gain then
				return nil
			else
				return gain, ending - seconds
			end
		end
		return nil
	end

	OvaleCondition:RegisterCondition("buffpresent", false, BuffPresent)
	OvaleCondition:RegisterCondition("debuffpresent", false, BuffPresent)
end

do
	--- Get the time elapsed since the aura was last gained on the target.
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffGain

	local function BuffGain(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain = aura.gain or 0
			return TestValue(gain, INFINITY, 0, gain, 1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffgain", false, BuffGain)
	OvaleCondition:RegisterCondition("debuffgain", false, BuffGain)
end

do
	--- Get the player's persistent multiplier for the given aura at the time the aura was applied on the target.
	-- The persistent multiplier is snapshotted to the aura for its duration at the time the aura is applied.
	-- @name BuffPersistentMultiplier
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The persistent multiplier.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffPersistentMultiplier
	-- @usage
	-- if target.DebuffPersistentMultiplier(rake) < 1 Spell(rake)

	local function BuffPersistentMultiplier(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = aura.damageMultiplier or 1
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(1, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffpersistentmultiplier", false, BuffPersistentMultiplier)
	OvaleCondition:RegisterCondition("debuffpersistentmultiplier", false, BuffPersistentMultiplier)
end

do
	--- Get the remaining time in seconds on an aura.
	-- @name BuffRemaining
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds remaining on the aura.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffRemaining
	-- @usage
	-- if BuffRemaining(slice_and_dice) <2
	--     Spell(slice_and_dice)

	local function BuffRemaining(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			return TestValue(gain, INFINITY, 0, ending, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffremaining", false, BuffRemaining)
	OvaleCondition:RegisterCondition("debuffremaining", false, BuffRemaining)
	OvaleCondition:RegisterCondition("buffremains", false, BuffRemaining)
	OvaleCondition:RegisterCondition("debuffremains", false, BuffRemaining)
end

do
	--- Get the remaining time in seconds before the aura expires across all targets.
	-- @name BuffRemainingOnAny
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param stacks Optional. The minimum number of stacks of the aura required.
	--     Defaults to stacks=1.
	--     Valid values: any number greater than zero.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param excludeTarget Optional. Sets whether to ignore the current target when scanning targets.
	--     Defaults to excludeTarget=0.
	--     Valid values: 0, 1.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffRemainingOnAny

	local function BuffRemainingOnAny(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local _, filter, mine = ParseCondition(condition, state)
		local excludeUnitId = (condition.excludeTarget == 1) and state.defaultTarget or nil

		local count, stacks, startChangeCount, endingChangeCount, startFirst, endingLast = state:AuraCount(auraId, filter, mine, condition.stacks, excludeUnitId)
		if count > 0 then
			local start, ending = startFirst, endingLast
			return TestValue(start, INFINITY, 0, ending, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffremainingonany", false, BuffRemainingOnAny)
	OvaleCondition:RegisterCondition("debuffremainingonany", false, BuffRemainingOnAny)
	OvaleCondition:RegisterCondition("buffremainsonany", false, BuffRemainingOnAny)
	OvaleCondition:RegisterCondition("debuffremainsonany", false, BuffRemainingOnAny)
end

do
	-- Return the value of the stat from the aura snapshot at the time the aura was applied.
	local function BuffSnapshot(statName, defaultValue, condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = aura.snapshot and aura.snapshot[statName] or defaultValue
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(defaultValue, comparator, limit)
	end

	-- Return the value of the given critical strike chance from the aura snapshot at the time the aura was applied.
	local function BuffSnapshotCritChance(statName, defaultValue, condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = aura.snapshot and aura.snapshot[statName] or defaultValue
			if condition.unlimited ~= 1 and value > 100 then
				value = 100
			end
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(defaultValue, comparator, limit)
	end

	--- Get the player's attack power at the time the given aura was applied on the target.
	-- @name BuffAttackPower
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The attack power.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffAttackPower
	-- @usage
	-- if AttackPower() >target.DebuffAttackPower(rake) Spell(rake)

	local function BuffAttackPower(condition, state)
		return BuffSnapshot("attackPower", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffattackpower", false, BuffAttackPower)
	OvaleCondition:RegisterCondition("debuffattackpower", false, BuffAttackPower)

	--- Get the player's mastery effect at the time the given aura was applied on the target.
	-- @name BuffMasteryEffect
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The mastery effect.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffMasteryEffect
	-- @usage
	-- if MasteryEffect() >target.DebuffMasteryEffect(rip) Spell(rip)

	local function BuffMasteryEffect(condition, state)
		return BuffSnapshot("masteryEffect", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffmastery", false, BuffMasteryEffect)
	OvaleCondition:RegisterCondition("buffmasteryeffect", false, BuffMasteryEffect)
	OvaleCondition:RegisterCondition("debuffmastery", false, BuffMasteryEffect)
	OvaleCondition:RegisterCondition("debuffmasteryeffect", false, BuffMasteryEffect)

	--- Get the player's melee critical strike chance at the time the given aura was applied on the target.
	-- @name BuffMeleeCritChance
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The critical strike chance.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffMeleeCritChance
	-- @usage
	-- if MeleeCritChance() >target.DebuffMeleeCritChance(rake) Spell(rake)

	local function BuffMeleeCritChance(condition, state)
		return BuffSnapshotCritChance("meleeCrit", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffmeleecritchance", false, BuffMeleeCritChance)
	OvaleCondition:RegisterCondition("debuffmeleecritchance", false, BuffMeleeCritChance)

	--- Get the player's multistrike chance at the time the given aura was applied on the target.
	-- @name BuffMultistrikeChance
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The multistrike chance (in percent).
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffMultistrikeChance
	-- @usage
	-- if MultistrikeChance() >target.DebuffMultistrikeChance(rip) Spell(rip)

	local function BuffMultistrikeChance(condition, state)
		return BuffSnapshot("multistrike", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffmultistrikechance", false, BuffMultistrikeChance)
	OvaleCondition:RegisterCondition("debuffmultistrikechance", false, BuffMultistrikeChance)

	--- Get the player's ranged attack power at the time the given aura was applied on the target.
	-- @name BuffRangedAttackPower
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The ranged attack power.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffRangedAttackPower
	-- @usage
	-- if RangedAttackPower() >target.DebuffRangedAttackPower(serpent_sting_dot)
	--     Spell(serpent_sting)

	local function BuffRangedAttackPower(condition, state)
		return BuffSnapshot("rangedAttackPower", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffrangedattackpower", false, BuffRangedAttackPower)
	OvaleCondition:RegisterCondition("debuffrangedattackpower", false, BuffRangedAttackPower)

	--- Get the player's ranged critical strike chance at the time the given aura was applied on the target.
	-- @name BuffRangedCritChance
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The critical strike chance.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffRangedCritChance
	-- @usage
	-- if RangedCritChance() >target.DebuffRangedCritChance(serpent_sting_dot)
	--     Spell(serpent_sting)

	local function BuffRangedCritChance(condition, state)
		return BuffSnapshotCritChance("rangedCrit", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffrangedcritchance", false, BuffRangedCritChance)
	OvaleCondition:RegisterCondition("debuffrangedcritchance", false, BuffRangedCritChance)

	--- Get the player's spell critical strike chance at the time the given aura was applied on the target.
	-- @name BuffSpellCritChance
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The critical strike chance.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffSpellCritChance
	-- @usage
	-- if SpellCritChance() >target.DebuffSpellCritChance(moonfire) Spell(moonfire)

	local function BuffSpellCritChance(condition, state)
		return BuffSnapshotCritChance("spellCrit", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffspellcritchance", false, BuffSpellCritChance)
	OvaleCondition:RegisterCondition("debuffspellcritchance", false, BuffSpellCritChance)

	--- Get the player's spell haste at the time the given aura was applied on the target.
	-- @name BuffSpellHaste
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param id The aura spell ID.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The percent increase to spell haste.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffSpellHaste
	-- @usage
	-- if SpellHaste() >target.DebuffSpellHaste(moonfire) Spell(moonfire)

	local function BuffSpellHaste(condition, state)
		return BuffSnapshot("spellHaste", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffspellhaste", false, BuffSpellHaste)
	OvaleCondition:RegisterCondition("debuffspellhaste", false, BuffSpellHaste)

	--- Get the player's spellpower at the time the given aura was applied on the target.
	-- @name BuffSpellpower
	-- @paramsig number or boolean
	-- @param id The aura spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The spellpower.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffSpellpower
	-- @usage
	-- if Spellpower() >target.DebuffSpellpower(moonfire) Spell(moonfire)

	local function BuffSpellpower(condition, state)
		return BuffSnapshot("spellBonusDamage", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("buffspellpower", false, BuffSpellpower)
	OvaleCondition:RegisterCondition("debuffspellpower", false, BuffSpellpower)
end

do
	--- Get the number of stacks of an aura on the target.
	-- @name BuffStacks
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of stacks of the aura.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffStacks
	-- @usage
	-- if BuffStacks(pet_frenzy any=1) ==5
	--     Spell(focus_fire)
	-- if target.DebuffStacks(weakened_armor) <3
	--     Spell(faerie_fire)

	local function BuffStacks(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local value = aura.stacks or 0
			return TestValue(gain, ending, value, start, 0, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffstacks", false, BuffStacks)
	OvaleCondition:RegisterCondition("debuffstacks", false, BuffStacks)
end

do
	--- Get the total number of stacks of the given aura across all targets.
	-- @name BuffStacksOnAny
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param any Optional. Sets by whom the aura was applied. If the aura can be applied by anyone, then set any=1.
	--     Defaults to any=0.
	--     Valid values: 0, 1.
	-- @param excludeTarget Optional. Sets whether to ignore the current target when scanning targets.
	--     Defaults to excludeTarget=0.
	--     Valid values: 0, 1.
	-- @return The total number of stacks.
	-- @return A boolean value for the result of the comparison.
	-- @see DebuffStacksOnAny

	local function BuffStacksOnAny(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local _, filter, mine = ParseCondition(condition, state)
		local excludeUnitId = (condition.excludeTarget == 1) and state.defaultTarget or nil

		local count, stacks, startChangeCount, endingChangeCount, startFirst, endingLast = state:AuraCount(auraId, filter, mine, 1, excludeUnitId)
		if count > 0 then
			local start, ending = startFirst, endingChangeCount
			return TestValue(start, ending, stacks, start, 0, comparator, limit)
		end
		return Compare(count, comparator, limit)
	end

	OvaleCondition:RegisterCondition("buffstacksonany", false, BuffStacksOnAny)
	OvaleCondition:RegisterCondition("debuffstacksonany", false, BuffStacksOnAny)
end

do
	--- Test if there is a stealable buff on the target.
	-- @name BuffStealable
	-- @paramsig boolean
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.BuffStealable()
	--     Spell(spellsteal)

	local function BuffStealable(condition, state)
		local target = ParseCondition(condition, state)
		return state:GetAuraWithProperty(target, "stealable", "HELPFUL")
	end

	OvaleCondition:RegisterCondition("buffstealable", false, BuffStealable)
end

do
	--- Check if the player can cast the given spell (not on cooldown).
	-- @name CanCast
	-- @paramsig boolean
	-- @param id The spell ID to check.
	-- @return True if the spell cast be cast; otherwise, false.

	local function CanCast(condition, state)
		local spellId = condition[1]
		local start, duration = state:GetSpellCooldown(spellId)
		return start + duration, INFINITY
	end

	OvaleCondition:RegisterCondition("cancast", true, CanCast)
end

do
	--- Get the cast time in seconds of the spell for the player, taking into account current haste effects.
	-- @name CastTime
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see ExecuteTime
	-- @usage
	-- if target.DebuffRemaining(flame_shock) < CastTime(lava_burst)
	--     Spell(lava_burst)

	local function CastTime(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local castTime = OvaleSpellBook:GetCastTime(spellId) or 0
		return Compare(castTime, comparator, limit)
	end

	--- Get the cast time in seconds of the spell for the player or the GCD for the player, whichever is greater.
	-- @name ExecuteTime
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see CastTime
	-- @usage
	-- if target.DebuffRemaining(flame_shock) < ExecuteTime(lava_burst)
	--     Spell(lava_burst)

	local function ExecuteTime(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local castTime = OvaleSpellBook:GetCastTime(spellId) or 0
		local gcd = state:GetGCD(nil, target)
		local t = (castTime > gcd) and castTime or gcd
		return Compare(t, comparator, limit)
	end

	OvaleCondition:RegisterCondition("casttime", true, CastTime)
	OvaleCondition:RegisterCondition("executetime", true, ExecuteTime)
end

do
	--- Test if the target is casting the given spell.
	-- The spell may be specified either by spell ID, spell list name (as defined in SpellList),
	-- "harmful" for any harmful spell, or "helpful" for any helpful spell.
	-- @name Casting
	-- @paramsig boolean
	-- @param spell The spell to check.
	--     Valid values: spell ID, spell list name, harmful, helpful
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- Define(maloriak_release_aberrations 77569)
	-- if target.Casting(maloriak_release_aberrations)
	--     Spell(pummel)

	local function Casting(condition, state)
		local spellId = condition[1]
		local target = ParseCondition(condition, state)

		-- Get the information about the current spellcast.
		local start, ending, castSpellId, castSpellName
		if target == "player" then
			start = state.startCast
			ending = state.endCast
			castSpellId = state.currentSpellId
			castSpellName = OvaleSpellBook:GetSpellName(castSpellId)
		else
			local spellName, _, _, _, startTime, endTime = API_UnitCastingInfo(target)
			if not spellName then
				spellName, _, _, _, startTime, endTime = API_UnitChannelInfo("unit")
			end
			if spellName then
				castSpellName = spellName
				start = startTime/1000
				ending = endTime/1000
			end
		end

		if castSpellId or castSpellName then
			if not spellId then
				-- No spell specified, so whatever spell is currently casting.
				return start, ending
			elseif OvaleData.buffSpellList[spellId] then
				for id in pairs(OvaleData.buffSpellList[spellId]) do
					if id == castSpellId or OvaleSpellBook:GetSpellName(id) == castSpellName then
						return start, ending
					end
				end
			elseif spellId == "harmful" and OvaleSpellBook:IsHarmfulSpell(spellId) then
				return start, ending
			elseif spellId == "helpful" and OvaleSpellBook:IsHelpfulSpell(spellId) then
				return start, ending
			elseif spellId == castSpellId then
				return start, ending
			elseif type(spellId) == "number" and OvaleSpellBook:GetSpellName(spellId) == castSpellName then
				return start, ending
			end
		end
		return nil
	end

	OvaleCondition:RegisterCondition("casting", false, Casting)
end

do
	--- Test if all of the listed checkboxes are off.
	-- @name CheckBoxOff
	-- @paramsig boolean
	-- @param id The name of a checkbox. It should match one defined by AddCheckBox(...).
	-- @param ... Optional. Additional checkbox names.
	-- @return A boolean value.
	-- @see CheckBoxOn
	-- @usage
	-- AddCheckBox(opt_black_arrow "Black Arrow" default)
	-- if CheckBoxOff(opt_black_arrow) Spell(explosive_trap)

	local function CheckBoxOff(condition, state)
		for i = 1, #condition do
			if Ovale:IsChecked(condition[i]) then
				return nil
			end
		end
		return 0, INFINITY
	end

	--- Test if all of the listed checkboxes are on.
	-- @name CheckBoxOn
	-- @paramsig boolean
	-- @param id The name of a checkbox. It should match one defined by AddCheckBox(...).
	-- @param ... Optional. Additional checkbox names.
	-- @return A boolean value.
	-- @see CheckBoxOff
	-- @usage
	-- AddCheckBox(opt_black_arrow "Black Arrow" default)
	-- if CheckBoxOn(opt_black_arrow) Spell(black_arrow)

	local function CheckBoxOn(condition, state)
		for i = 1, #condition do
			if not Ovale:IsChecked(condition[i]) then
				return nil
			end
		end
		return 0, INFINITY
	end

	OvaleCondition:RegisterCondition("checkboxoff", false, CheckBoxOff)
	OvaleCondition:RegisterCondition("checkboxon", false, CheckBoxOn)
end

do
	--- Test whether the target's class matches the given class.
	-- @name Class
	-- @paramsig boolean
	-- @param class The class to check.
	--     Valid values: DEATHKNIGHT, DRUID, HUNTER, MAGE, MONK, PALADIN, PRIEST, ROGUE, SHAMAN, WARLOCK, WARRIOR.
	-- @param yesno Optional. If yes, then return true if it matches. If no, then return true if it doesn't match.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.Class(PRIEST) Spell(cheap_shot)

	local function Class(condition, state)
		local class, yesno = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local _, classToken = API_UnitClass(target)
		local boolean = (classToken == class)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("class", false, Class)
end

do
	--- Test whether the target's classification matches the given classification.
	-- @name Classification
	-- @paramsig boolean
	-- @param classification The unit classification to check.
	--     Valid values: normal, elite, worldboss.
	-- @param yesno Optional. If yes, then return true if it matches. If no, then return true if it doesn't match.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.Classification(worldboss) Item(virmens_bite_potion)

	local function Classification(condition, state)
		local classification, yesno = condition[1], condition[2]
		local targetClassification
		local target = ParseCondition(condition, state)
		if API_UnitLevel(target) < 0 then
			targetClassification = "worldboss"
		else
			targetClassification = API_UnitClassification(target)
			if targetClassification == "rareelite" then
				targetClassification = "elite"
			elseif targetClassification == "rare" then
				targetClassification = "normal"
			end
		end
		local boolean = (targetClassification == classification)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("classification", false, Classification)
end

do
	--- Get the number of combo points on the currently selected target for a feral druid or a rogue.
	-- @name ComboPoints
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of combo points.
	-- @return A boolean value for the result of the comparison.
	-- @see LastComboPoints
	-- @usage
	-- if ComboPoints() >=1 Spell(savage_roar)
	-- if ComboPoints(more 0) Spell(savage_roar)

	local function ComboPoints(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.combo
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("combopoints", false, ComboPoints)
end

do
	--- Get the current value of a script counter.
	-- @name Counter
	-- @paramsig number or boolean
	-- @param id The name of the counter. It should match one that's defined by inccounter=xxx in SpellInfo(...).
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current value the counter.
	-- @return A boolean value for the result of the comparison.

	local function Counter(condition, state)
		local counter, comparator, limit = condition[1], condition[2], condition[3]
		local value = state:GetCounterValue(counter)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("counter", false, Counter)
end

do
	--- Test whether the target's creature family matches the given name.
	-- Applies only to beasts that can be taken as hunter pets (e.g., cats, worms, and ravagers but not zhevras, talbuks and pterrordax),
	-- demons that can be summoned by Warlocks (e.g., imps and felguards, but not demons that require enslaving such as infernals
	-- and doomguards or world demons such as pit lords and armored voidwalkers), and Death Knight's pets (ghouls)
	-- @name CreatureFamily
	-- @paramsig boolean
	-- @param name The English name of the creature family to check.
	--     Valid values: Bat, Beast, Felguard, Imp, Ravager, etc.
	-- @param yesno Optional. If yes, then return true if it matches. If no, then return true if it doesn't match.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if pet.CreatureFamily(Felguard)
	--     Spell(summon_felhunter)
	-- if target.CreatureFamily(Dragonkin)
	--     Spell(hibernate)

	local function CreatureFamily(condition, state)
		local name, yesno = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local family = API_UnitCreatureFamily(target)
		local lookupTable = LibBabbleCreatureType and LibBabbleCreatureType:GetLookupTable()
		local boolean = (lookupTable and family == lookupTable[name])
		return TestBoolean(boolean, yesno)	
	end

	OvaleCondition:RegisterCondition("creaturefamily", false, CreatureFamily)
end

do
	--- Test if the target is any of the listed creature types.
	-- @name CreatureType
	-- @paramsig boolean
	-- @param name The English name of a creature type.
	--     Valid values: Beast, Humanoid, Undead, etc.
	-- @param ... Optional. Additional creature types.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.CreatureType(Humanoid Critter)
	--     Spell(polymorph)

	local function CreatureType(condition, state)
		local target = ParseCondition(condition, state)
		local creatureType = API_UnitCreatureType(target)
		local lookupTable = LibBabbleCreatureType and LibBabbleCreatureType:GetLookupTable()
		if lookupTable then
			for _, name in ipairs(condition) do
				if creatureType == lookupTable[name] then
					return 0, INFINITY
				end
			end
		end
		return nil
	end

	OvaleCondition:RegisterCondition("creaturetype", false, CreatureType)
end

do
	-- Return the non-critical-strike damage of a spell, given the player's current stats.
	local function GetDamage(spellId, state)
		-- TODO: Use target's debuffs in this calculation.
		local ap = state.snapshot.attackPower or 0
		local sp = state.snapshot.spellBonusDamage or 0
		local mh = state.snapshot.mainHandWeaponDamage or 0
		local oh = state.snapshot.offHandWeaponDamage or 0
		local bdm = state.snapshot.baseDamageMultiplier or 1
		local dm = state:GetDamageMultiplier(spellId) or 1
		local combo = state.combo or 0
		return OvaleData:GetDamage(spellId, ap, sp, mh, oh, combo) * bdm * dm
	end

	--- Get the current estimated damage of a spell on the target if it is a critical strike.
	-- @name CritDamage
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The estimated critical strike damage of the given spell.
	-- @return A boolean value for the result of the comparison.
	-- @see Damage, LastDamage, LastEstimatedDamage

	local AMPLIFICATION = 146051
	local INCREASED_CRIT_EFFECT_3_PERCENT = 44797

	local function CritDamage(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local value = ComputeParameter(spellId, "damage", state)
		if not value then
			value = GetDamage(spellId, state)
		end
		-- Reduce by armor damage reduction for physical attacks.
		local physical = state:GetSpellInfoProperty(spellId, "physical", target)
		if physical == 1 then
			value = value * (1 - BossArmorDamageReduction(target))
		end

		-- Default crit damage is 2 times normal damage.
		local critMultiplier = 2
		-- Add additional critical strike damage from MoP amplification trinkets.
		do
			local aura = state:GetAura("player", AMPLIFICATION, "HELPFUL")
			if state:IsActiveAura(aura) then
				critMultiplier = critMultiplier + aura.value1
			end
		end
		-- Multiply by increased crit effect from the meta gem.
		do
			local aura = state:GetAura("player", INCREASED_CRIT_EFFECT_3_PERCENT, "HELPFUL")
			if state:IsActiveAura(aura) then
				critMultiplier = critMultiplier * aura.value1
			end
		end

		local value = critMultiplier * value
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("critdamage", false, CritDamage)

	--- Get the current estimated damage of a spell on the target.
	-- The calculated damage takes into account the current attack power, spellpower, weapon damage and combo points (if used).
	-- The damage is computed from information for the spell set via SpellInfo(...):
	--
	-- damage = base + bonusmainhand * MH + bonusoffhand * OH + bonusap * AP + bonuscp * CP + bonusapcp * AP * CP + bonussp * SP
	-- @name Damage
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The estimated damage of the given spell on the target.
	-- @return A boolean value for the result of the comparison.
	-- @see CritDamage, LastDamage, LastEstimatedDamage
	-- @usage
	-- if {target.Damage(rake) / target.LastEstimateDamage(rake)} >1.1
	--     Spell(rake)

	local function Damage(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local value = ComputeParameter(spellId, "damage", state)
		if not value then
			value = GetDamage(spellId, state)
		end
		-- Reduce by armor damage reduction for physical attacks.
		local physical = state:GetSpellInfoProperty(spellId, "physical", target)
		if physical == 1 then
			value = value * (1 - BossArmorDamageReduction(target))
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("damage", false, Damage)
end

do
	--- Get the current damage multiplier of a spell.
	-- This currently does not take into account increased damage due to mastery.
	-- @name DamageMultiplier
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current damage multiplier of the given spell.
	-- @return A boolean value for the result of the comparison.
	-- @see LastDamageMultiplier
	-- @usage
	-- if {DamageMultiplier(rupture) / LastDamageMultiplier(rupture)} >1.1
	--     Spell(rupture)

	local function DamageMultiplier(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local bdm = state.snapshot.baseDamageMultiplier
		local dm = state:GetDamageMultiplier(spellId)
		local value = bdm * dm
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("damagemultiplier", false, DamageMultiplier)
end

do
	--- Get the damage taken by the player in the previous time interval.
	-- @name DamageTaken
	-- @paramsig number or boolean
	-- @param interval The number of seconds before now.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The amount of damage taken in the previous interval.
	-- @return A boolean value for the result of the comparison.
	-- @see IncomingDamage
	-- @usage
	-- if DamageTaken(5) > 50000 Spell(death_strike)

	local function DamageTaken(condition, state)
		-- Damage taken shouldn't be smoothed since spike damage is important data.
		-- Just present damage taken as a constant value.
		local interval, comparator, limit = condition[1], condition[2], condition[3]
		local value = 0
		if interval > 0 then
			value = OvaleDamageTaken:GetRecentDamage(interval)
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("damagetaken", false, DamageTaken)
	OvaleCondition:RegisterCondition("incomingdamage", false, DamageTaken)
end

do
	local NECROTIC_PLAGUE_TALENT = 19
	local NECROTIC_PLAGUE_DEBUFF = 155159
	local BLOOD_PLAGUE_DEBUFF = 55078
	local FROST_FEVER_DEBUFF = 55095

	local function GetDiseases(target, state)
		local npAura, bpAura, ffAura
		local talented = (OvaleSpellBook:GetTalentPoints(NECROTIC_PLAGUE_TALENT) > 0)
		if talented then
			npAura = state:GetAura(target, NECROTIC_PLAGUE_DEBUFF, "HARMFUL", true)
		else
			bpAura = state:GetAura(target, BLOOD_PLAGUE_DEBUFF, "HARMFUL", true)
			ffAura = state:GetAura(target, FROST_FEVER_DEBUFF, "HARMFUL", true)
		end
		return talented, npAura, bpAura, ffAura
	end

	--- Get the remaining time in seconds before any diseases applied by the death knight will expire.
	-- @name DiseasesRemaining
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.

	local function DiseasesRemaining(condition, state)
		local comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local talented, npAura, bpAura, ffAura = GetDiseases(target, state)
		local aura
		if talented and state:IsActiveAura(npAura) then
			aura = npAura
		elseif not talented and state:IsActiveAura(bpAura) and state:IsActiveAura(ffAura) then
			aura = (bpAura.ending < ffAura.ending) and bpAura or ffAura
		end
		if aura then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			return TestValue(gain, INFINITY, 0, ending, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	--- Test if all diseases applied by the death knight are present on the target.
	-- @name DiseasesTicking
	-- @paramsig boolean
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.

	local function DiseasesTicking(condition, state)
		local target, filter, mine = ParseCondition(condition, state)
		local talented, npAura, bpAura, ffAura = GetDiseases(target, state)
		local gain, start, ending
		if talented and npAura then
			gain, start, ending = npAura.gain, npAura.start, npAura.ending
		elseif not talented and bpAura and ffAura then
			-- Compute the intersection of the time spans for the two disease auras.
			gain = (bpAura.gain > ffAura.gain) and bpAura.gain or ffAura.gain
			start = (bpAura.start > ffAura.start) and bpAura.start or ffAura.start
			ending = (bpAura.ending < ffAura.ending) and bpAura.ending or ffAura.ending
		end
		if gain and ending and ending > gain then
			return gain, ending
		end
		return nil
	end

	--- Test if any diseases applied by the death knight are present on the target.
	-- @name DiseasesAnyTicking
	-- @paramsig boolean
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.

	local function DiseasesAnyTicking(condition, state)
		local target, filter, mine = ParseCondition(condition, state)
		local talented, npAura, bpAura, ffAura = GetDiseases(target, state)
		local aura
		if talented and npAura then
			aura = npAura
		elseif not talented and (bpAura or ffAura) then
			aura = bpAura or ffAura
			if bpAura and ffAura then
				-- Find the disease that expires latest.
				aura = (bpAura.ending > ffAura.ending) and bpAura or ffAura
			end
		end
		if aura then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			if ending > gain then
				return gain, ending
			end
		end
		return nil
	end

	OvaleCondition:RegisterCondition("diseasesremaining", false, DiseasesRemaining)
	OvaleCondition:RegisterCondition("diseasesticking", false, DiseasesTicking)
	OvaleCondition:RegisterCondition("diseasesanyticking", false, DiseasesAnyTicking)
end

do
	--- Get the distance in yards to the target.
	-- The distances are from LibRangeCheck-2.0, which determines distance based on spell range checks, so results are approximate.
	-- You should not test for equality.
	-- @name Distance
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The distance to the target.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if target.Distance(less 25)
	--     Texture(ability_rogue_sprint)

	local function Distance(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local value = LibRangeCheck and LibRangeCheck:GetRange(target) or 0
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("distance", false, Distance)
end

do
	--- Get the current amount of Eclipse power for balance druids.
	-- A negative amount of power signifies being closer to Lunar Eclipse.
	-- A positive amount of power signifies being closer to Solar Eclipse.
	-- @name Eclipse
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The amount of Eclipse power.
	-- @return A boolean value for the result of the comparison.
	-- @see EclipseDir
	-- @usage
	-- if Eclipse() < 0-70 and EclipseDir() <0 Spell(wrath)
	-- if Eclipse(less -70) and EclipseDir(less 0) Spell(wrath)

	local function Eclipse(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.eclipse
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("eclipse", false, Eclipse)
end

do
	--- Get the current direction of the Eclipse status on the Eclipse bar for balance druids.
	-- A negative number means heading toward Lunar Eclipse.
	-- A positive number means heading toward Solar Eclipse.
	-- Zero means it can head in either direction.
	-- @name EclipseDir
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current direction.
	-- @return A boolean value for the result of the comparison.
	-- @see Eclipse
	-- @usage
	-- if Eclipse() < 0-70 and EclipseDir() <0 Spell(wrath)
	-- if Eclipse(less -70) and EclipseDir(less 0) Spell(wrath)

	local function EclipseDir(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.eclipseDirection
		return Compare(value, comparator, limit)		
	end

	OvaleCondition:RegisterCondition("eclipsedir", false, EclipseDir)
end

do
	--- Get the number of hostile enemies on the battlefield.
	-- The minimum value returned is 1.
	-- @name Enemies
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param tagged Optional. By default, all enemies are counted. To count only enemies directly tagged by the player, set tagged=1.
	--     Defaults to tagged=0.
	--     Valid values: 0, 1.
	-- @return The number of enemies.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Enemies() >4 Spell(fan_of_knives)
	-- if Enemies(more 4) Spell(fan_of_knives)

	local function Enemies(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.enemies
		if not value then
			if condition.tagged == 1 then
				value = state.taggedEnemies
			else
				value = state.activeEnemies
			end
		end
		-- This works around problems with testing on target dummies, which are never hostile.
		if value < 1 then
			value = 1
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("enemies", false, Enemies)
end

do
	--- Get the amount of regenerated energy per second for feral druids, non-mistweaver monks, and rogues.
	-- @name EnergyRegenRate
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current rate of energy regeneration.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if EnergyRegenRage() >11 Spell(stance_of_the_sturdy_ox)

	local function EnergyRegenRate(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.powerRate.energy
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("energyregen", false, EnergyRegenRate)
	OvaleCondition:RegisterCondition("energyregenrate", false, EnergyRegenRate)
end

do
	--- Test if the target exists. The target may be alive or dead.
	-- @name Exists
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target exists. If no, then return true if it doesn't exist.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @see Present
	-- @usage
	-- if pet.Exists(no) Spell(summon_imp)

	local function Exists(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitExists(target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("exists", false, Exists)
end

do
	--- A condition that always returns false.
	-- @name False
	-- @paramsig boolean
	-- @return A boolean value.

	local function False(condition, state)
		return nil
	end

	OvaleCondition:RegisterCondition("false", false, False)
end

do
	--- Get the amount of regenerated focus per second for hunters.
	-- @name FocusRegenRate
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current rate of focus regeneration.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if FocusRegenRate() >20 Spell(arcane_shot)
	-- if FocusRegenRate(more 20) Spell(arcane_shot)

	local function FocusRegenRate(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.powerRate.focus
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("focusregen", false, FocusRegenRate)
	OvaleCondition:RegisterCondition("focusregenrate", false, FocusRegenRate)
end

do
	--- Get the amount of focus that would be regenerated during the cast time of the given spell for hunters.
	-- @name FocusCastingRegen
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of focus.
	-- @return A boolean value for the result of the comparison.

	local STEADY_FOCUS = 177668

	local function FocusCastingRegen(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local regenRate = state.powerRate.focus
		local power = 0

		-- Get the "execute time" of the spell (smaller of GCD or the cast time).
		local castTime = OvaleSpellBook:GetCastTime(spellId) or 0
		local gcd = state:GetGCD(nil, target)
		local castSeconds = (castTime > gcd) and castTime or gcd
		power = power + regenRate * castSeconds

		-- Get the amount of time remaining on the Steady Focus buff.
		local aura = state:GetAura("player", STEADY_FOCUS, "HELPFUL", true)
		if aura then
			local seconds = aura.ending - state.currentTime
			if seconds <= 0 then
				seconds = 0
			elseif seconds > castSeconds then
				seconds = castSeconds
			end
			-- Steady Focus increases the focus regeneration rate by 50% for its duration.
			power = power + regenRate * 1.5 * seconds
		end
		return Compare(power, comparator, limit)
	end

	OvaleCondition:RegisterCondition("focuscastingregen", false, FocusCastingRegen)
end

do
	--- Get the player's global cooldown in seconds.
	-- @name GCD
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the previous spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if GCD() <1.1 Spell(frostfire_bolt)
	-- if GCD(less 1.1) Spell(frostfire_bolt)

	local function GCD(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state, "target")
		local value = state:GetGCD(nil, target)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("gcd", false, GCD)
end

do
	--- Get the value of the named state variable from the simulator.
	-- @name GetState
	-- @paramsig number or boolean
	-- @param name The name of the state variable.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The value of the state variable.
	-- @return A boolean value for the result of the comparison.

	local function GetState(condition, state)
		local name, comparator, limit = condition[1], condition[2], condition[3]
		local value = state:GetState(name)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("getstate", false, GetState)
end

do
	--- Test if the given glyph is active.
	-- @name Glyph
	-- @paramsig boolean
	-- @param id The glyph spell ID.
	-- @param yesno Optional. If yes, then return true if the glyph is active. If no, then return true if it isn't active.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if InCombat(no) and Glyph(glyph_of_savagery)
	--     Spell(savage_roar)

	local function Glyph(condition, state)
		local glyph, yesno = condition[1], condition[2]
		local boolean = OvaleSpellBook:IsActiveGlyph(glyph)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("glyph", false, Glyph)
end

do
	--- Test if the player has a particular item equipped.
	-- @name HasEquippedItem
	-- @paramsig boolean
	-- @param item Item to be checked whether it is equipped.
	-- @param yesno Optional. If yes, then return true if the item is equipped. If no, then return true if it isn't equipped.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param ilevel Optional.  Checks the item level of the equipped item.  If not specified, then any item level is valid.
	--     Defaults to not specified.
	--     Valid values: ilevel=N, where N is any number.
	-- @param slot Optional. Sets the inventory slot to check.  If not specified, then all slots are checked.
	--     Defaults to not specified.
	--     Valid values: slot=SLOTNAME, where SLOTNAME is a valid slot name, e.g., HandSlot.

	local function HasEquippedItem(condition, state)
		local itemId, yesno = condition[1], condition[2]
		local ilevel, slot = condition.ilevel, condition.slot
		local boolean = false
		local slotId
		if type(itemId) == "number" then
			slotId = OvaleEquipment:HasEquippedItem(itemId, slot)
			if slotId then
				if not ilevel or (ilevel and ilevel == OvaleEquipment:GetEquippedItemLevel(slotId)) then
					boolean = true
				end
			end
		elseif OvaleData.itemList[itemId] then
			for _, v in pairs(OvaleData.itemList[itemId]) do
				slotId = OvaleEquipment:HasEquippedItem(v, slot)
				if slotId then
					if not ilevel or (ilevel and ilevel == OvaleEquipment:GetEquippedItemLevel(slotId)) then
						boolean = true
						break
					end
				end
			end
		end
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("hasequippeditem", false, HasEquippedItem)
end

do
	--- Test if the player has full control, i.e., isn't feared, charmed, etc.
	-- @name HasFullControl
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target exists. If no, then return true if it doesn't exist.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if HasFullControl(no) Spell(barkskin)

	local function HasFullControl(condition, state)
		local yesno = condition[1]
		local boolean = API_HasFullControl()
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("hasfullcontrol", false, HasFullControl)
end

do
	--- Test if the player has a shield equipped.
	-- @name HasShield
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if a shield is equipped. If no, then return true if it isn't equipped.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if HasShield() Spell(shield_wall)

	local function HasShield(condition, state)
		local yesno = condition[1]
		local boolean = OvaleEquipment:HasShield()
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("hasshield", false, HasShield)
end

do
	--- Test if the player has a particular trinket equipped.
	-- @name HasTrinket
	-- @paramsig boolean
	-- @param id The item ID of the trinket or the name of an item list.
	-- @param yesno Optional. If yes, then return true if the trinket is equipped. If no, then return true if it isn't equipped.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- ItemList(rune_of_reorigination 94532 95802 96546)
	-- if HasTrinket(rune_of_reorigination) and BuffPresent(rune_of_reorigination_buff)
	--     Spell(rake)

	local function HasTrinket(condition, state)
		local trinketId, yesno = condition[1], condition[2]
		local boolean = false
		if type(trinketId) == "number" then
			boolean = OvaleEquipment:HasTrinket(trinketId)
		elseif OvaleData.itemList[trinketId] then
			for _, v in pairs(OvaleData.itemList[trinketId]) do
				boolean = OvaleEquipment:HasTrinket(v)
				if boolean then
					break
				end
			end
		end
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("hastrinket", false, HasTrinket)
end

do
	--- Test if the player has a weapon equipped.
	-- @name HasWeapon
	-- @paramsig boolean
	-- @param hand Sets which hand weapon.
	--     Valid values: main, off
	-- @param yesno Optional. If yes, then return true if the weapon is equipped. If no, then return true if it isn't equipped.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param type Optional. If set via type=value, then specify whether the weapon must be one-handed or two-handed.
	--     Default is unset.
	--     Valid values: one_handed, two_handed
	-- @return A boolean value.
	-- @usage
	-- if HasWeapon(offhand) and BuffStacks(killing_machine) Spell(frost_strike)

	local function HasWeapon(condition, state)
		local hand, yesno = condition[1], condition[2]
		local weaponType = condition.type
		local boolean = false
		if weaponType == "one_handed" then
			weaponType = 1
		elseif weaponType == "two_handed" then
			weaponType = 2
		end
		if hand == "offhand" or hand == "off" then
			boolean = OvaleEquipment:HasOffHandWeapon(weaponType)
		elseif hand == "mainhand" or hand == "main" then
			boolean = OvaleEquipment:HasMainHandWeapon(weaponType)
		end
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("hasweapon", false, HasWeapon)
end

do
	-- static properties for TimeToDie(), indexed by unit ID
	local lastTTDTime = {}
	local lastTTDHealth = {}
	local lastTTDguid = {}
	local lastTTDdps = {}

	--[[
		Returns:
			Estimated number of seconds before the specified unit reaches zero health
			The current time
			Unit's current health
			Unit's maximum health
	--]]
	local function EstimatedTimeToDie(state, unitId)
		-- Check for target switch.
		if lastTTDguid[unitId] ~= OvaleGUID:GetGUID(unitId) then
			lastTTDguid[unitId] = OvaleGUID:GetGUID(unitId)
			lastTTDTime[unitId] = nil
			if lastTTDHealth[unitId] then
				wipe(lastTTDHealth[unitId])
			else
				lastTTDHealth[unitId] = {}
			end
			lastTTDdps[unitId] = nil
		end

		local timeToDie
		local health = API_UnitHealth(unitId) or 0
		local maxHealth = API_UnitHealthMax(unitId) or 1
		local currentTime = API_GetTime()

		-- Clamp maxHealth to always be at least 1.
		if maxHealth < health then
			maxHealth = health
		end
		if maxHealth < 1 then
			maxHealth = 1
		end

		if health == 0 then
			timeToDie = 0
		elseif maxHealth <= 5 then
			timeToDie = INFINITY
		else
			local now = floor(currentTime)
			if (not lastTTDTime[unitId] or lastTTDTime[unitId] < now) and lastTTDguid[unitId] then
				lastTTDTime[unitId] = now
				local mod10, prevHealth
				for delta = 10, 1, -1 do
					mod10 = (now - delta) % 10
					prevHealth = lastTTDHealth[unitId][mod10]
					if delta == 10 then
						lastTTDHealth[unitId][mod10] = health
					end
					if prevHealth and prevHealth > health then
						lastTTDdps[unitId] = (prevHealth - health) / delta
						state:Log("prevHealth = %d, health = %d, delta = %d, dps = %d", prevHealth, health, delta, lastTTDdps[unitId])
						break
					end
				end
			end
			local dps = lastTTDdps[unitId]
			if dps and dps > 0 then
				timeToDie = health / dps
			else
				timeToDie = INFINITY
			end
		end
		-- Clamp time to die at a finite number.
		if timeToDie == INFINITY then
			-- Return time to die in the far-off future (one week).
			timeToDie = 3600 * 24 * 7
		end
		return timeToDie, currentTime, health, maxHealth
	end

	--- Get the current amount of health points of the target.
	-- @name Health
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current health.
	-- @return A boolean value for the result of the comparison.
	-- @see Life
	-- @usage
	-- if Health() <10000 Spell(last_stand)
	-- if Health(less 10000) Spell(last_stand)

	local function Health(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local timeToDie, now, health, maxHealth = EstimatedTimeToDie(state, target)
		if not timeToDie then
			return nil
		elseif timeToDie == 0 then
			return Compare(0, comparator, limit)
		end
		local value, origin, rate = health, now, -1 * health / timeToDie
		local start, ending = now, INFINITY
		return TestValue(start, ending, value, origin, rate, comparator, limit)
	end

	OvaleCondition:RegisterCondition("health", false, Health)
	OvaleCondition:RegisterCondition("life", false, Health)

	--- Get the number of health points away from full health of the target.
	-- @name HealthMissing
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current missing health.
	-- @return A boolean value for the result of the comparison.
	-- @see LifeMissing
	-- @usage
	-- if HealthMissing() <20000 Item(healthstone)
	-- if HealthMissing(less 20000) Item(healthstone)

	local function HealthMissing(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local timeToDie, now, health, maxHealth = EstimatedTimeToDie(state, target)
		if not timeToDie or timeToDie == 0 then
			return nil
		end
		local missing = maxHealth - health
		local value, origin, rate = missing, now, health / timeToDie
		local start, ending = now, INFINITY
		return TestValue(start, ending, value, origin, rate, comparator, limit)
	end

	OvaleCondition:RegisterCondition("healthmissing", false, Health)
	OvaleCondition:RegisterCondition("lifemissing", false, Health)

	--- Get the current percent level of health of the target.
	-- @name HealthPercent
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current health percent.
	-- @return A boolean value for the result of the comparison.
	-- @see LifePercent
	-- @usage
	-- if HealthPercent() <20 Spell(last_stand)
	-- if target.HealthPercent(less 25) Spell(kill_shot)

	local function HealthPercent(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local timeToDie, now, health, maxHealth = EstimatedTimeToDie(state, target)
		if not timeToDie then
			return nil
		elseif timeToDie == 0 then
			return Compare(0, comparator, limit)
		end
		local healthPercent = health / maxHealth * 100
		local value, origin, rate = healthPercent, now, -1 * healthPercent / timeToDie
		local start, ending = now, INFINITY
		return TestValue(start, ending, value, origin, rate, comparator, limit)
	end

	OvaleCondition:RegisterCondition("healthpercent", false, HealthPercent)
	OvaleCondition:RegisterCondition("lifepercent", false, HealthPercent)

	--- Get the amount of health points of the target when it is at full health.
	-- @name MaxHealth
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum health.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if target.MaxHealth() >10000000 Item(mogu_power_potion)
	-- if target.MaxHealth(more 10000000) Item(mogu_power_potion)

	local function MaxHealth(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local value = API_UnitHealthMax(target)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("maxhealth", false, MaxHealth)

	--- Get the estimated number of seconds remaining before the target is dead.
	-- @name TimeToDie
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see DeadIn
	-- @usage
	-- if target.TimeToDie() <2 and ComboPoints() >0 Spell(eviscerate)

	local function TimeToDie(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local timeToDie, now = EstimatedTimeToDie(state, target)
		local value, origin, rate = timeToDie, now, -1
		local start, ending = now, now + timeToDie
		return TestValue(start, ending, value, origin, rate, comparator, limit)
	end

	OvaleCondition:RegisterCondition("deadin", false, TimeToDie)
	OvaleCondition:RegisterCondition("timetodie", false, TimeToDie)

	--- Get the estimated number of seconds remaining before the target reaches the given percent of max health.
	-- @name TimeToHealthPercent
	-- @paramsig number or boolean
	-- @param percent The percent of maximum health of the target.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see TimeToDie
	-- @usage
	-- if target.TimeToHealthPercent(25) <15 Item(virmens_bite_potion)

	local function TimeToHealthPercent(condition, state)
		local percent, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state)
		local timeToDie, now, health, maxHealth = EstimatedTimeToDie(state, target)
		local healthPercent = health / maxHealth * 100
		if healthPercent >= percent then
			local t = timeToDie * (healthPercent - percent) / healthPercent
			local value, origin, rate = t, now, -1
			local start, ending = now, now + t
			return TestValue(start, ending, value, origin, rate, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("timetohealthpercent", false, TimeToHealthPercent)
	OvaleCondition:RegisterCondition("timetolifepercent", false, TimeToHealthPercent)
end

do
	--- Test if the player is in combat.
	-- @name InCombat
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the player is in combat. If no, then return true if the player isn't in combat.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if InCombat(no) and Stealthed(no) Spell(stealth)

	local function InCombat(condition, state)
		local yesno = condition[1]
		local boolean = state.inCombat
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("incombat", false, InCombat)
end

do
	--- Test if the given spell is in flight for spells that have a flight time after cast, e.g., Lava Burst.
	-- @name InFlightToTarget
	-- @paramsig boolean
	-- @param id The spell ID.
	-- @param yesno Optional. If yes, then return true if the spell is in flight. If no, then return true if it isn't in flight.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if target.DebuffRemaining(haunt) <3 and not InFlightToTarget(haunt)
	--     Spell(haunt)

	local function InFlightToTarget(condition, state)
		local spellId, yesno = condition[1], condition[2]
		local boolean = (state.currentSpellId == spellId) or OvaleFuture:InFlight(spellId)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("inflighttotarget", false, InFlightToTarget)
end

do
	--- Test if the distance from the player to the target is within the spell's range.
	-- @name InRange
	-- @paramsig boolean
	-- @param id The spell ID.
	-- @param yesno Optional. If yes, then return true if the target is in range. If no, then return true if it isn't in range.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if target.IsInterruptible() and target.InRange(kick)
	--     Spell(kick)

	local function InRange(condition, state)
		local spellId, yesno = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local boolean = (OvaleSpellBook:IsSpellInRange(spellId, target) == 1)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("inrange", false, InRange)
end

do
	--- Test if the target's primary aggro is on the player.
	-- Even if the target briefly targets and casts a spell on another raid member,
	-- this condition returns true as long as the player is highest on the threat table.
	-- @name IsAggroed
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target is aggroed. If no, then return true if it isn't aggroed.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.IsAggroed() Spell(feign_death)

	local function IsAggroed(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitDetailedThreatSituation("player", target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isaggroed", false, IsAggroed)
end

do
	--- Test if the target is dead.
	-- @name IsDead
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target is dead. If no, then return true if it isn't dead.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if pet.IsDead() Spell(revive_pet)

	local function IsDead(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitIsDead(target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isdead", false, IsDead)
end

do
	--- Test if the target is enraged.
	-- @name IsEnraged
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if enraged. If no, then return true if not enraged.
	--     Default is yes.
	--     Valid values: yes.  "no" currently doesn't work.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.IsEnraged() Spell(soothe)

	local function IsEnraged(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		return state:GetAuraWithProperty(target, "enraged", "HELPFUL")
	end

	OvaleCondition:RegisterCondition("isenraged", false, IsEnraged)
end

do
	--- Test if the player is feared.
	-- @name IsFeared
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if feared. If no, then return true if it not feared.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if IsFeared() Spell(every_man_for_himself)

	local function IsFeared(condition, state)
		local yesno = condition[1]
		local aura = state:GetAura("player", "fear_debuff", "HARMFUL")
		local boolean = not API_HasFullControl() and state:IsActiveAura(aura)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isfeared", false, IsFeared)
end

do
	--- Test if the target is friendly to the player.
	-- @name IsFriend
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target is friendly (able to help in combat). If no, then return true if it isn't friendly.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.IsFriend() Spell(healing_touch)

	local function IsFriend(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitIsFriend("player", target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isfriend", false, IsFriend)
end

do
	--- Test if the player is incapacitated.
	-- @name IsIncapacitated
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if incapacitated. If no, then return true if it not incapacitated.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if IsIncapacitated() Spell(every_man_for_himself)

	local function IsIncapacitated(condition, state)
		local yesno = condition[1]
		local aura = state:GetAura("player", "incapacitate_debuff", "HARMFUL")
		local boolean = not API_HasFullControl() and state:IsActiveAura(aura)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isincapacitated", false, IsIncapacitated)
end

do
	--- Test if the target is currently casting an interruptible spell.
	-- @name IsInterruptible
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target is interruptible. If no, then return true if it isn't interruptible.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.IsInterruptible() Spell(kick)

	local function IsInterruptible(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local name, _, _, _, _, _, _, _, notInterruptible = API_UnitCastingInfo(target)
		if not name then
			name, _, _, _, _, _, _, notInterruptible = API_UnitChannelInfo(target)
		end
		local boolean = notInterruptible ~= nil and not notInterruptible
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isinterruptible", false, IsInterruptible)
end

do
	--- Test if the target is flagged for PvP activity.
	-- @name IsPVP
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target is flagged for PvP activity. If no, then return true if it isn't PvP-flagged.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if not target.IsFriend() and target.IsPVP() Spell(sap)

	local function IsPVP(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitIsPVP(target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("ispvp", false, IsPVP)
end

do
	--- Test if the player is rooted.
	-- @name IsRooted
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if rooted. If no, then return true if it not rooted.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if IsRooted() Item(Trinket0Slot usable=1)

	local function IsRooted(condition, state)
		local yesno = condition[1]
		local aura = state:GetAura("player", "root_debuff", "HARMFUL")
		local boolean = state:IsActiveAura(aura)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isrooted", false, IsRooted)
end

do
	--- Test if the player is stunned.
	-- @name IsStunned
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if stunned. If no, then return true if it not stunned.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if IsStunned() Item(Trinket0Slot usable=1)

	local function IsStunned(condition, state)
		local yesno = condition[1]
		local aura = state:GetAura("player", "stun_debuff", "HARMFUL")
		local boolean = not API_HasFullControl() and state:IsActiveAura(aura)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isstunned", false, IsStunned)
end

do
	--- Get the current number of charges of the given item in the player's inventory.
	-- @name ItemCharges
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of charges.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ItemCount(mana_gem) ==0 or ItemCharges(mana_gem) <3
	--     Spell(conjure_mana_gem)
	-- if ItemCount(mana_gem equal 0) or ItemCharges(mana_gem less 3)
	--     Spell(conjure_mana_gem)

	local function ItemCharges(condition, state)
		local itemId, comparator, limit = condition[1], condition[2], condition[3]
		local value = API_GetItemCount(itemId, false, true)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("itemcharges", false, ItemCharges)
end

do
	--- Get the cooldown time in seconds of an item, e.g., trinket.
	-- @name ItemCooldown
	-- @paramsig number or boolean
	-- @param id The item ID or the equipped slot name.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if not ItemCooldown(ancient_petrified_seed) > 0
	--     Spell(berserk_cat)
	-- if not ItemCooldown(Trinket0Slot) > 0
	--     Spell(berserk_cat)

	local function ItemCooldown(condition, state)
		local itemId, comparator, limit = condition[1], condition[2], condition[3]
		if itemId and type(itemId) ~= "number" then
			itemId = OvaleEquipment:GetEquippedItem(itemId)
		end
		if itemId then
			local start, duration = API_GetItemCooldown(itemId)
			if start > 0 and duration > 0 then
				return TestValue(start, start + duration, duration, start, -1, comparator, limit)
			end
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("itemcooldown", false, ItemCooldown)
end

do
	--- Get the current number of the given item in the player's inventory.
	-- Items with more than one charge count as one item.
	-- @name ItemCount
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The count of the item.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ItemCount(mana_gem) ==0 Spell(conjure_mana_gem)
	-- if ItemCount(mana_gem equal 0) Spell(conjure_mana_gem)

	local function ItemCount(condition, state)
		local itemId, comparator, limit = condition[1], condition[2], condition[3]
		local value = API_GetItemCount(itemId)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("itemcount", false, ItemCount)
end

do
	--- Get the number of combo points consumed by the most recent cast of a spell on the target for a feral druid or a rogue.
	-- @name LastComboPoints
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of combo points.
	-- @return A boolean value for the result of the comparison.
	-- @see ComboPoints
	-- @usage
	-- if ComboPoints() >3 and target.LastComboPoints(rip) <3
	--     Spell(rip)

	local function LastComboPoints(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local guid = OvaleGUID:GetGUID(target)
		local value = OvaleFuture:GetLastSpellInfo(guid, spellId, "combo") or 0
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("lastcombopoints", false, LastComboPoints)
	OvaleCondition:RegisterCondition("lastspellcombopoints", false, LastComboPoints)
end

do
	--- Get the damage done by the most recent damage event for the given spell.
	-- If the spell is a periodic aura, then it gives the damage done by the most recent tick.
	-- @name LastDamage
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The damage done.
	-- @return A boolean value for the result of the comparison.
	-- @see Damage, LastEstimatedDamage
	-- @usage
	-- if LastDamage(ignite) >10000 Spell(combustion)
	-- if LastDamage(ignite more 10000) Spell(combustion)

	local function LastDamage(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local value = OvaleSpellDamage:Get(spellId)
		if value then
			return Compare(value, comparator, limit)
		end
		return nil
	end

	OvaleCondition:RegisterCondition("lastdamage", false, LastDamage)
	OvaleCondition:RegisterCondition("lastspelldamage", false, LastDamage)
end

do
	--- Get the damage multiplier of the most recent cast of a spell on the target.
	-- This currently does not take into account increased damage due to mastery.
	-- @name LastDamageMultiplier
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous damage multiplier.
	-- @return A boolean value for the result of the comparison.
	-- @see DamageMultiplier
	-- @usage
	-- if {DamageMultiplier(rupture) / target.LastDamageMultiplier(rupture)} >1.1
	--     Spell(rupture)

	local function LastDamageMultiplier(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local guid = OvaleGUID:GetGUID(target)
		local bdm = OvaleFuture:GetLastSpellInfo(guid, spellId, "baseDamageMultiplier") or 1
		local dm = OvaleFuture:GetLastSpellInfo(guid, spellId, "damageMultiplier") or 1
		local value = bdm * dm
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("lastdamagemultiplier", false, LastDamageMultiplier)
	OvaleCondition:RegisterCondition("lastspelldamagemultiplier", false, LastDamageMultiplier)
end

do
	--- Get the estimated damage of the most recent cast of the player's spell on the target.
	-- The calculated damage takes into account the values of attack power, spellpower, weapon damage and combo points (if used)
	-- at the time the spell was most recent cast.
	-- The damage is computed from information for the spell set via SpellInfo(...):
	--
	-- damage = base + bonusmainhand * MH + bonusoffhand * OH + bonusap * AP + bonuscp * CP + bonusapcp * AP * CP + bonussp * SP
	-- @name LastEstimatedDamage
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The estimated damage of the most recent cast of the given spell by the player.
	-- @return A boolean value for the result of the comparison.
	-- @see Damage, LastDamage
	-- @usage
	-- if {Damage(rake) / target.LastEstimateDamage(rake)} >1.1
	--     Spell(rake)

	local function LastEstimatedDamage(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local value = ComputeParameter(spellId, "lastEstimatedDamage", state)
		if not value then
			local guid = OvaleGUID:GetGUID(target)
			local ap = OvaleFuture:GetLastSpellInfo(guid, spellId, "attackPower") or 0
			local sp = OvaleFuture:GetLastSpellInfo(guid, spellId, "spellBonusDamage") or 0
			local mh = OvaleFuture:GetLastSpellInfo(guid, spellId, "mainHandWeaponDamage") or 0
			local oh = OvaleFuture:GetLastSpellInfo(guid, spellId, "offHandWeaponDamage") or 0
			local combo = OvaleFuture:GetLastSpellInfo(guid, spellId, "combo") or 0
			local bdm = OvaleFuture:GetLastSpellInfo(guid, spellId, "baseDamageMultiplier") or 1
			local dm = OvaleFuture:GetLastSpellInfo(guid, spellId, "damageMultiplier") or 1
			value = OvaleData:GetDamage(spellId, ap, sp, mh, oh, combo) * bdm * dm
		end
		-- Reduce by armor damage reduction for physical attacks.
		local physical = state:GetSpellInfoProperty(spellId, "physical", target)
		if physical == 1 then
			value = value * (1 - BossArmorDamageReduction(target))
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("lastestimateddamage", false, LastEstimatedDamage)
	OvaleCondition:RegisterCondition("lastspellestimateddamage", false, LastEstimatedDamage)
end

do
	-- Return the value of the stat from the snapshot at the time the spell was cast.
	local function LastSnapshot(statName, defaultValue, condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local guid = OvaleGUID:GetGUID(target)
		local value = OvaleFuture:GetLastSpellInfo(guid, spellId, statName)
		value = value or defaultValue
		return Compare(value, comparator, limit)
	end

	-- Return the value of the given critical strike chance from the aura snapshot at the time the aura was applied.
	local function LastSnapshotCritChance(statName, defaultValue, condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state)
		local guid = OvaleGUID:GetGUID(target)
		local value = OvaleFuture:GetLastSpellInfo(guid, spellId, statName)
		value = value or defaultValue
		if condition.unlimited ~= 1 and value > 100 then
			value = 100
		end
		return Compare(value, comparator, limit)
	end

	--- Get the attack power of the player during the most recent cast of a spell on the target.
	-- @name LastAttackPower
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous attack power.
	-- @return A boolean value for the result of the comparison.
	-- @see AttackPower
	-- @usage
	-- if {AttackPower() / target.LastAttackPower(hemorrhage)} >1.25
	--     Spell(hemorrhage)

	local function LastAttackPower(condition, state)
		return LastSnapshot("attackPower", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastattackpower", false, LastAttackPower)
	OvaleCondition:RegisterCondition("lastspellattackpower", false, LastAttackPower)

	--- Get the mastery effect of the player during the most recent cast of a spell on the target.
	-- Mastery effect is the effect of the player's mastery, typically a percent-increase to damage
	-- or a percent-increase to chance to trigger some effect.
	-- @name LastMastery
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous mastery effect.
	-- @return A boolean value for the result of the comparison.
	-- @see Mastery
	-- @usage
	-- if {Mastery(shadow_bolt) - LastMastery(shadow_bolt)} > 1000
	--     Spell(metamorphosis)

	local function LastMasteryEffect(condition, state)
		return LastSnapshot("masteryEffect", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastmastery", false, LastMasteryEffect)
	OvaleCondition:RegisterCondition("lastmasteryeffect", false, LastMasteryEffect)
	OvaleCondition:RegisterCondition("lastspellmastery", false, LastMasteryEffect)

	--- Get the melee critical strike chance of the player during the most recent cast of a spell on the target.
	-- @name LastMeleeCritChance
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous critical strike chance.
	-- @return A boolean value for the result of the comparison.
	-- @see MeleeCritChance
	-- @usage
	-- if MeleeCritChance() > target.LastMeleeCritChance(rip)
	--     Spell(rip)

	local function LastMeleeCritChance(condition, state)
		return LastSnapshotCritChance("meleeCrit", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastmeleecritchance", false, LastMeleeCritChance)
	OvaleCondition:RegisterCondition("lastspellmeleecritchance", false, LastMeleeCritChance)

	--- Get the multistrike chance of the player during the most recent cast of a spell on the target.
	-- @name LastMultistrikeEffect
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous multistrike chance (in percent).
	-- @return A boolean value for the result of the comparison.
	-- @see MultistrikeEffect
	-- @usage
	-- if MultistrikeChance(shadow_bolt) > LastMultistrikeChance(shadow_bolt)
	--     Spell(metamorphosis)

	local function LastMultistrikeChance(condition, state)
		return LastSnapshot("multistrike", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastmultistrikechance", false, LastMultistrikeChance)

	--- Get the ranged critical strike chance of the player during the most recent cast of a spell on the target.
	-- @name LastRangedCritChance
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous critical strike chance.
	-- @return A boolean value for the result of the comparison.
	-- @see RangedCritChance
	-- @usage
	-- if RangedCritChance() > target.LastRangedCritChance(serpent_sting_dot)
	--     Spell(serpent_sting)

	local function LastRangedCritChance(condition, state)
		return LastSnapshotCritChance("rangedCrit", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastrangedcritchance", false, LastRangedCritChance)
	OvaleCondition:RegisterCondition("lastspellrangedcritchance", false, LastRangedCritChance)

	--- Get the spell critical strike chance of the player during the most recent cast of a spell on the target.
	-- @name LastSpellCritChance
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous critical strike chance.
	-- @return A boolean value for the result of the comparison.
	-- @see SpellCritChance
	-- @usage
	-- if SpellCritChance() > target.LastSpellCritChance(shadow_bolt)
	--     Spell(metamorphosis)

	local function LastSpellCritChance(condition, state)
		return LastSnapshotCritChance("spellCrit", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastspellcritchance", false, LastSpellCritChance)
	OvaleCondition:RegisterCondition("lastspellspellcritchance", false, LastSpellCritChance)

	--- Get the spellpower of the player during the most recent cast of a spell on the target.
	-- @name LastSpellpower
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The previous spellpower.
	-- @return A boolean value for the result of the comparison.
	-- @see Spellpower
	-- @usage
	-- if {Spellpower() / target.LastSpellpower(living_bomb)} >1.25
	--     Spell(living_bomb)

	local function LastSpellpower(condition, state)
		return LastSnapshot("spellBonusDamage", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("lastspellpower", false, LastSpellpower)
	OvaleCondition:RegisterCondition("lastspellspellpower", false, LastSpellpower)
end

do
	--- Get the most recent estimate of roundtrip latency in milliseconds.
	-- @name Latency
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number of milliseconds to compare against.
	-- @return The most recent estimate of latency.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Latency() >1000 Spell(sinister_strike)
	-- if Latency(more 1000) Spell(sinister_strike)

	local function Latency(condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = OvaleLatency:GetLatency() * 1000
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("latency", false, Latency)
end

do
	--- Get the level of the target.
	-- @name Level
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The level of the target.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Level() >=34 Spell(tiger_palm)
	-- if Level(more 33) Spell(tiger_palm)

	local function Level(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local value
		if target == "player" then
			value = state.level
		else
			value = API_UnitLevel(target)
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("level", false, Level)
end

do
	--- Test if a list is currently set to the given value.
	-- @name List
	-- @paramsig boolean
	-- @param id The name of a list. It should match one defined by AddListItem(...).
	-- @param value The value to test.
	-- @return A boolean value.
	-- @usage
	-- AddListItem(opt_curse coe "Curse of the Elements" default)
	-- AddListItem(opt_curse cot "Curse of Tongues")
	-- if List(opt_curse coe) Spell(curse_of_the_elements)

	local function List(condition, state)
		local name, value = condition[1], condition[2]
		if name and Ovale:GetListValue(name) == value then
			return 0, INFINITY
		end
		return nil
	end

	OvaleCondition:RegisterCondition("list", false, List)
end

do
	--- Test whether the target's name matches the given name.
	-- @name Name
	-- @paramsig boolean
	-- @param name The localized target name.
	-- @param yesno Optional. If yes, then return true if it matches. If no, then return true if it doesn't match.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.

	local function Name(condition, state)
		local name, yesno = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local targetName = API_UnitName(target)
		local boolean = (name == targetName)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("name", false, Name)
end

do
	--- Test if the game is on a PTR server
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then returns true if it is a PTR realm. If no, return true if it is a live realm.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value

	local function PTR(condition, state)
		local yesno = condition[1]
		local _, _, _, uiVersion = API_GetBuildInfo()
		local boolean = (uiVersion > 50400)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("ptr", false, PTR)
end

do
	--- Get the persistent multiplier to the given aura if applied.
	-- The persistent multiplier is snapshotted to the aura for its duration.
	-- @name PersistentMultiplier
	-- @paramsig number or boolean
	-- @param id The aura ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The persistent multiplier.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if PersistentMultiplier(rake_debuff) > target.DebuffPersistentMultiplier(rake_debuff)
	--     Spell(rake)

	local function PersistentMultiplier(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local value = state:GetDamageMultiplier(spellId)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("persistentmultiplier", false, PersistentMultiplier)
end

do
	--- Test if the pet exists and is alive.
	-- PetPresent() is equivalent to pet.Present().
	-- @name PetPresent
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target exists. If no, then return true if it doesn't exist.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @see Present
	-- @usage
	-- if target.IsInterruptible() and PetPresent(yes)
	--     Spell(pet_pummel)

	local function PetPresent(condition, state)
		local yesno = condition[1]
		local target = "pet"
		local boolean = API_UnitExists(target) and not API_UnitIsDead(target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("petpresent", false, PetPresent)
end

do
	-- Return the maximum power of the given power type on the target.
	local function MaxPower(powerType, condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local value
		if target == "player" then
			value = OvalePower.maxPower[powerType]
		else
			local powerInfo = OvalePower.POWER_INFO[powerType]
			value = API_UnitPowerMax(target, powerInfo.id, powerInfo.segments)
		end
		return Compare(value, comparator, limit)
	end

	-- Return the amount of power of the given power type on the target.
	local function Power(powerType, condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		if target == "player" then
			local value, origin, rate = state[powerType], state.currentTime, state.powerRate[powerType]
			local start, ending = state.currentTime, INFINITY
			return TestValue(start, ending, value, origin, rate, comparator, limit)
		else
			local powerInfo = OvalePower.POWER_INFO[powerType]
			local value = API_UnitPower(target, powerInfo.id)
			return Compare(value, comparator, limit)
		end
	end

	--- Return the current deficit of power from max power on the target.
	local function PowerDeficit(powerType, condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		if target == "player" then
			local powerMax = OvalePower.maxPower[powerType] or 0
			if powerMax > 0 then
				local value, origin, rate = powerMax - state[powerType], state.currentTime, -1 * state.powerRate[powerType]
				local start, ending = state.currentTime, INFINITY
				return TestValue(start, ending, value, origin, rate, comparator, limit)
			end
		else
			local powerInfo = OvalePower.POWER_INFO[powerType]
			local powerMax = API_UnitPowerMax(target, powerInfo.id, powerInfo.segments) or 0
			if powerMax > 0 then
				local power = API_UnitPower(target, powerInfo.id)
				local value = powerMax - power
				return Compare(value, comparator, limit)
			end
		end
		return Compare(0, comparator, limit)
	end

	--- Return the current percent level of power (between 0 and 100) on the target.
	local function PowerPercent(powerType, condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		if target == "player" then
			local powerMax = OvalePower.maxPower[powerType] or 0
			if powerMax > 0 then
				local conversion = 100 / powerMax
				local value, origin, rate = state[powerType] * conversion, state.currentTime, state.powerRate[powerType] * conversion
				local start, ending = state.currentTime, INFINITY
				return TestValue(start, ending, value, origin, rate, comparator, limit)
			end
		else
			local powerInfo = OvalePower.POWER_INFO[powerType]
			local powerMax = API_UnitPowerMax(target, powerInfo.id, powerInfo.segments) or 0
			if powerMax > 0 then
				local conversion = 100 / powerMax
				local value = API_UnitPower(target, powerInfo.id) * conversion
				return Compare(value, comparator, limit)
			end
		end
		return Compare(0, comparator, limit)
	end

	--- Get the current amount of the player's primary resource for the given spell.
	-- @name PrimaryResource
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The amount of the primary resource.
	-- @return A boolean value for the result of the comparison.

	local function PrimaryResource(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local primaryPowerType
		local si = OvaleData:GetSpellInfo(spellId)
		if si then
			-- Check the spell information to see if a primary resource cost was given.
			for powerType in pairs(OvalePower.PRIMARY_POWER) do
				if si[powerType] then
					primaryPowerType = powerType
					break
				end
			end
		end
		-- If no primary resource cost was found, then query using Blizzard API.
		if not primaryPowerType then
			local _, powerType = OvalePower:GetSpellCost(spellId)
			if powerType then
				primaryPowerType = powerType
			end
		end
		if primaryPowerType then
			local value, origin, rate = state[primaryPowerType], state.currentTime, state.powerRate[primaryPowerType]
			local start, ending = state.currentTime, INFINITY
			return TestValue(start, ending, value, origin, rate, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("primaryresource", true, PrimaryResource)

	--- Get the current amount of alternate power displayed on the alternate power bar.
	-- @name AlternatePower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current alternate power.
	-- @return A boolean value for the result of the comparison.

	local function AlternatePower(condition, state)
		return Power("alternate", condition, state)
	end

	--- Get the current number of Burning Embers for destruction warlocks.
	-- @name BurningEmbers
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of Burning Embers.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if BurningEmbers() >10 Spell(chaos_bolt)
	-- if BurningEmbers(more 10) Spell(chaos_bolt)

	local function BurningEmbers(condition, state)
		return Power("burningembers", condition, state)
	end

	--- Get the current amount of stored Chi for monks.
	-- @name Chi
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The amount of stored Chi.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Chi() ==4 Spell(chi_burst)
	-- if Chi(more 3) Spell(chi_burst)

	local function Chi(condition, state)
		return Power("chi", condition, state)
	end

	--- Get the current amount of demonic fury for demonology warlocks.
	-- @name DemonicFury
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The amount of demonic fury.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if DemonicFury() >=1000 Spell(metamorphosis)
	-- if DemonicFury(more 999) Spell(metamorphosis)

	local function DemonicFury(condition, state)
		return Power("demonicfury", condition, state)
	end

	--- Get the current amount of energy for feral druids, non-mistweaver monks, and rogues.
	-- @name Energy
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current energy.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Energy() >70 Spell(vanish)
	-- if Energy(more 70) Spell(vanish)

	local function Energy(condition, state)
		return Power("energy", condition, state)
	end

	--- Get the current amount of focus for hunters.
	-- @name Focus
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current focus.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Focus() >70 Spell(arcane_shot)
	-- if Focus(more 70) Spell(arcane_shot)

	local function Focus(condition, state)
		return Power("focus", condition, state)
	end

	--- Get the current amount of holy power for a paladin.
	-- @name HolyPower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The amount of holy power.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if HolyPower() >=3 Spell(word_of_glory)
	-- if HolyPower(more 2) Spell(word_of_glory)

	local function HolyPower(condition, state)
		return Power("holy", condition, state)
	end

	--- Get the current level of mana of the target.
	-- @name Mana
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current mana.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if {MaxMana() - Mana()} > 12500 Item(mana_gem)

	local function Mana(condition, state)
		return Power("mana", condition, state)
	end

	--- Get the current amount of rage for guardian druids and warriors.
	-- @name Rage
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current rage.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Rage() >70 Spell(heroic_strike)
	-- if Rage(more 70) Spell(heroic_strike)

	local function Rage(condition, state)
		return Power("rage", condition, state)
	end

	--- Get the current amount of runic power for death knights.
	-- @name RunicPower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current runic power.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if RunicPower() >70 Spell(frost_strike)
	-- if RunicPower(more 70) Spell(frost_strike)

	local function RunicPower(condition, state)
		return Power("runicpower", condition, state)
	end

	--- Get the current number of Shadow Orbs for shadow priests.
	-- @name ShadowOrbs
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of Shadow Orbs.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ShadowOrbs() >2 Spell(mind_blast)
	-- if ShadowOrbs(more 2) Spell(mind_blast)

	local function ShadowOrbs(condition, state)
		return Power("shadoworbs", condition, state)
	end

	--- Get the current number of Soul Shards for warlocks.
	-- @name SoulShards
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of Soul Shards.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if SoulShards() >0 Spell(summon_felhunter)
	-- if SoulShards(more 0) Spell(summon_felhunter)

	local function SoulShards(condition, state)
		return Power("shards", condition, state)
	end

	OvaleCondition:RegisterCondition("alternatepower", false, AlternatePower)
	OvaleCondition:RegisterCondition("burningembers", false, BurningEmbers)
	OvaleCondition:RegisterCondition("chi", false, Chi)
	OvaleCondition:RegisterCondition("demonicfury", false, DemonicFury)
	OvaleCondition:RegisterCondition("energy", false, Energy)
	OvaleCondition:RegisterCondition("focus", false, Focus)
	OvaleCondition:RegisterCondition("holypower", false, HolyPower)
	OvaleCondition:RegisterCondition("mana", false, Mana)
	OvaleCondition:RegisterCondition("rage", false, Rage)
	OvaleCondition:RegisterCondition("runicpower", false, RunicPower)
	OvaleCondition:RegisterCondition("shadoworbs", false, ShadowOrbs)
	OvaleCondition:RegisterCondition("soulshards", false, SoulShards)

	--- Get the number of lacking resource points for a full alternate power bar, between 0 and maximum alternate power, of the target.
	-- @name AlternatePowerDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current alternate power deficit.
	-- @return A boolean value for the result of the comparison.

	local function AlternatePowerDeficit(condition, state)
		return PowerDeficit("alternatepower", condition, state)
	end

	--- Get the number of lacking resource points for a full burning embers bar, between 0 and maximum burning embers, of the target.
	-- @name BurningEmbersDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current burning embers deficit.
	-- @return A boolean value for the result of the comparison.

	local function BurningEmbersDeficit(condition, state)
		return PowerDeficit("burningembers", condition, state)
	end

	--- Get the number of lacking resource points for full chi, between 0 and maximum chi, of the target.
	-- @name ChiDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current chi deficit.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ChiDeficit() >=2 Spell(keg_smash)
	-- if ChiDeficit(more 1) Spell(keg_smash)

	local function ChiDeficit(condition, state)
		return PowerDeficit("chi", condition, state)
	end

	--- Get the number of lacking resource points for a full demonic fury bar, between 0 and maximum demonic fury, of the target.
	-- @name DemonicFuryDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current demonic fury deficit.
	-- @return A boolean value for the result of the comparison.

	local function DemonicFuryDeficit(condition, state)
		return PowerDeficit("demonicfury", condition, state)
	end

	--- Get the number of lacking resource points for a full energy bar, between 0 and maximum energy, of the target.
	-- @name EnergyDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current energy deficit.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if EnergyDeficit() >60 Spell(tigers_fury)
	-- if EnergyDeficit(more 60) Spell(tigers_fury)

	local function EnergyDeficit(condition, state)
		return PowerDeficit("energy", condition, state)
	end

	--- Get the number of lacking resource points for a full focus bar, between 0 and maximum focus, of the target.
	-- @name FocusDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current focus deficit.
	-- @return A boolean value for the result of the comparison.

	local function FocusDeficit(condition, state)
		return PowerDeficit("focus", condition, state)
	end

	--- Get the number of lacking resource points for full holy power, between 0 and maximum holy power, of the target.
	-- @name HolyPowerDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current holy power deficit.
	-- @return A boolean value for the result of the comparison.

	local function HolyPowerDeficit(condition, state)
		return PowerDeficit("holypower", condition, state)
	end

	--- Get the number of lacking resource points for a full mana bar, between 0 and maximum mana, of the target.
	-- @name ManaDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current mana deficit.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ManaDeficit() >30000 Item(mana_gem)
	-- if ManaDeficit(more 30000) Item(mana_gem)

	local function ManaDeficit(condition, state)
		return PowerDeficit("mana", condition, state)
	end

	--- Get the number of lacking resource points for a full rage bar, between 0 and maximum rage, of the target.
	-- @name RageDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current rage deficit.
	-- @return A boolean value for the result of the comparison.

	local function RageDeficit(condition, state)
		return PowerDeficit("rage", condition, state)
	end

	--- Get the number of lacking resource points for a full runic power bar, between 0 and maximum runic power, of the target.
	-- @name RunicPowerDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current runic power deficit.
	-- @return A boolean value for the result of the comparison.

	local function RunicPowerDeficit(condition, state)
		return PowerDeficit("runicpower", condition, state)
	end

	--- Get the number of lacking resource points for full shadow orbs, between 0 and maximum shadow orbs, of the target.
	-- @name ShadowOrbsDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current shadow orbs deficit.
	-- @return A boolean value for the result of the comparison.

	local function ShadowOrbsDeficit(condition, state)
		return PowerDeficit("shadoworbs", condition, state)
	end

	--- Get the number of lacking resource points for full soul shards, between 0 and maximum soul shards, of the target.
	-- @name SoulShardsDeficit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current soul shards deficit.
	-- @return A boolean value for the result of the comparison.

	local function SoulShardsDeficit(condition, state)
		return PowerDeficit("shards", condition, state)
	end

	OvaleCondition:RegisterCondition("alternatepowerdeficit", false, AlternatePowerDeficit)
	OvaleCondition:RegisterCondition("burningembersdeficit", false, BurningEmbersDeficit)
	OvaleCondition:RegisterCondition("chideficit", false, ChiDeficit)
	OvaleCondition:RegisterCondition("demonicfurydeficit", false, DemonicFuryDeficit)
	OvaleCondition:RegisterCondition("energydeficit", false, EnergyDeficit)
	OvaleCondition:RegisterCondition("focusdeficit", false, FocusDeficit)
	OvaleCondition:RegisterCondition("holypowerdeficit", false, HolyPowerDeficit)
	OvaleCondition:RegisterCondition("manadeficit", false, ManaDeficit)
	OvaleCondition:RegisterCondition("ragedeficit", false, RageDeficit)
	OvaleCondition:RegisterCondition("runicpowerdeficit", false, RunicPowerDeficit)
	OvaleCondition:RegisterCondition("shadoworbsdeficit", false, ShadowOrbsDeficit)
	OvaleCondition:RegisterCondition("soulshardsdeficit", false, SoulShardsDeficit)

	--- Get the current percent level of mana (between 0 and 100) of the target.
	-- @name ManaPercent
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The current mana percent.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if ManaPercent() >90 Spell(arcane_blast)
	-- if ManaPercent(more 90) Spell(arcane_blast)

	local function ManaPercent(condition, state)
		return PowerPercent("mana", condition, state)
	end

	OvaleCondition:RegisterCondition("manapercent", false, ManaPercent)

	--- Get the maximum amount of alternate power of the target.
	-- Alternate power is the resource tracked by the alternate power bar in certain boss fights.
	-- @name MaxAlternatePower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxAlternatePower(condition, state)
		return MaxPower("alternate", condition, state)
	end

	--- Get the maximum amount of burning embers of the target.
	-- @name MaxBurningEmbers
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxBurningEmbers(condition, state)
		return MaxPower("burningembers", condition, state)
	end

	--- Get the maximum amount of Chi of the target.
	-- @name MaxChi
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxChi(condition, state)
		return MaxPower("chi", condition, state)
	end

	--- Get the maximum amount of Demonic Fury of the target.
	-- @name MaxDemonicFury
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxDemonicFury(condition, state)
		return MaxPower("demonicfury", condition, state)
	end

	--- Get the maximum amount of energy of the target.
	-- @name MaxEnergy
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxEnergy(condition, state)
		return MaxPower("energy", condition, state)
	end

	--- Get the maximum amount of focus of the target.
	-- @name MaxFocus
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxFocus(condition, state)
		return MaxPower("focus", condition, state)
	end

	--- Get the maximum amount of Holy Power of the target.
	-- @name MaxHolyPower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxHolyPower(condition, state)
		return MaxPower("holy", condition, state)
	end

	--- Get the maximum amount of mana of the target.
	-- @name MaxMana
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if {MaxMana() - Mana()} > 12500 Item(mana_gem)

	local function MaxMana(condition, state)
		return MaxPower("mana", condition, state)
	end

	--- Get the maximum amount of rage of the target.
	-- @name MaxRage
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxRage(condition, state)
		return MaxPower("rage", condition, state)
	end

	--- Get the maximum amount of Runic Power of the target.
	-- @name MaxRunicPower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxRunicPower(condition, state)
		return MaxPower("runicpower", condition, state)
	end

	--- Get the maximum amount of Shadow Orbs of the target.
	-- @name MaxShadowOrbs
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxShadowOrbs(condition, state)
		return MaxPower("shadoworbs", condition, state)
	end

	--- Get the maximum amount of Soul Shards of the target.
	-- @name MaxSoulShards
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The maximum value.
	-- @return A boolean value for the result of the comparison.

	local function MaxSoulShards(condition, state)
		return MaxPower("shards", condition, state)
	end

	OvaleCondition:RegisterCondition("maxalternatepower", false, MaxAlternatePower)
	OvaleCondition:RegisterCondition("maxburningembers", false, MaxBurningEmbers)
	OvaleCondition:RegisterCondition("maxchi", false, MaxChi)
	OvaleCondition:RegisterCondition("maxdemonicfury", false, MaxDemonicFury)
	OvaleCondition:RegisterCondition("maxenergy", false, MaxEnergy)
	OvaleCondition:RegisterCondition("maxfocus", false, MaxFocus)
	OvaleCondition:RegisterCondition("maxholypower", false, MaxHolyPower)
	OvaleCondition:RegisterCondition("maxmana", false, MaxMana)
	OvaleCondition:RegisterCondition("maxrage", false, MaxRage)
	OvaleCondition:RegisterCondition("maxrunicpower", false, MaxRunicPower)
	OvaleCondition:RegisterCondition("maxshadoworbs", false, MaxShadowOrbs)
	OvaleCondition:RegisterCondition("maxsoulshards", false, MaxSoulShards)
end

do
	-- Return the amount of power of the given power type required to cast the given spell.
	local function PowerCost(powerType, condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local maxCost = (condition.max == 1)
		local value = state:PowerCost(spellId, powerType, target, maxCost) or 0
		return Compare(value, comparator, limit)
	end

	--- Get the amount of energy required to cast the given spell.
	-- This returns zero for spells that use either mana or another resource based on stance/specialization, e.g., Monk's Jab.
	-- @name EnergyCost
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param max Optional. Set max=1 to return the maximum energy cost for the spell.
	--     Defaults to max=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of energy.
	-- @return A boolean value for the result of the comparison.

	local function EnergyCost(condition, state)
		return PowerCost("energy", condition, state)
	end

	--- Get the amount of focus required to cast the given spell.
	-- @name FocusCost
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param max Optional. Set max=1 to return the maximum focus cost for the spell.
	--     Defaults to max=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of focus.
	-- @return A boolean value for the result of the comparison.

	local function FocusCost(condition, state)
		return PowerCost("focus", condition, state)
	end

	--- Get the amount of mana required to cast the given spell.
	-- This returns zero for spells that use either mana or another resource based on stance/specialization, e.g., Monk's Jab.
	-- @name ManaCost
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param max Optional. Set max=1 to return the maximum mana cost for the spell.
	--     Defaults to max=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of mana.
	-- @return A boolean value for the result of the comparison.

	local function ManaCost(condition, state)
		return PowerCost("mana", condition, state)
	end

	--- Get the amount of rage required to cast the given spell.
	-- @name RageCost
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param max Optional. Set max=1 to return the maximum rage cost for the spell.
	--     Defaults to max=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of rage.
	-- @return A boolean value for the result of the comparison.

	local function RageCost(condition, state)
		return PowerCost("rage", condition, state)
	end

	--- Get the amount of runic power required to cast the given spell.
	-- @name RunicPowerCost
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param max Optional. Set max=1 to return the maximum runic power cost for the spell.
	--     Defaults to max=0.
	--     Valid values: 0, 1
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of runic power.
	-- @return A boolean value for the result of the comparison.

	local function RunicPowerCost(condition, state)
		return PowerCost("runicpower", condition, state)
	end

	OvaleCondition:RegisterCondition("energycost", true, EnergyCost)
	OvaleCondition:RegisterCondition("focuscost", true, FocusCost)
	OvaleCondition:RegisterCondition("manacost", true, ManaCost)
	OvaleCondition:RegisterCondition("ragecost", true, RageCost)
	OvaleCondition:RegisterCondition("runicpowercost", true, RunicPowerCost)
end

do
	--- Test if the target exists and is alive.
	-- @name Present
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if the target exists. If no, then return true if it doesn't exist.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @see Exists
	-- @usage
	-- if target.IsInterruptible() and pet.Present(yes)
	--     Spell(pet_pummel)

	local function Present(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitExists(target) and not API_UnitIsDead(target)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("present", false, Present)
end

do
	--- Test if the previous spell cast matches the given spell.
	-- @name PreviousSpell
	-- @paramsig boolean
	-- @param id The spell ID.
	-- @param yesno Optional. If yes, then return true if there is a match. If no, then return true if it doesn't match.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.

	local function PreviousSpell(condition, state)
		local spellId, yesno = condition[1], condition[2]
		local boolean = (spellId == state.lastSpellId)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("previousspell", true, PreviousSpell)
end

do
	--- Get the result of the target's level minus the player's level. This number may be negative.
	-- @name RelativeLevel
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The difference in levels.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if target.RelativeLevel() >3
	--     Texture(ability_rogue_sprint)
	-- if target.RelativeLevel(more 3)
	--     Texture(ability_rogue_sprint)

	local function RelativeLevel(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local value, level
		if target == "player" then
			level = state.level
		else
			level = API_UnitLevel(target)
		end
		if level < 0 then
			-- World boss, so treat it as three levels higher.
			value = 3
		else
			value = level - state.level
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("relativelevel", false, RelativeLevel)
end

do
	--- Get the remaining cast time in seconds of the target's current spell cast.
	-- @name RemainingCastTime
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see CastTime
	-- @usage
	-- if target.Casting(hour_of_twilight) and target.RemainingCastTime() <2
	--     Spell(cloak_of_shadows)

	local function RemainingCastTime(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local _, _, _, _, startTime, endTime = API_UnitCastingInfo(target)
		if startTime and endTime then
			startTime = startTime / 1000
			endTime = endTime / 1000
			return TestValue(startTime, endTime, 0, endTime, -1, comparator, limit)
		end
		return nil
	end

	OvaleCondition:RegisterCondition("remainingcasttime", false, RemainingCastTime)
end

do
	--- Get the current number of active and regenerating (fractional) runes of the given type for death knights.
	-- @name Rune
	-- @paramsig number or boolean
	-- @param type The type of rune.
	--     Valid values: blood, frost, unholy, death
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of runes.
	-- @return A boolean value for the result of the comparison.
	-- @see DeathRune, RuneCount
	-- @usage
	-- if Rune(blood) > 1 Spell(blood_tap)

	local function Rune(condition, state)
		local name, comparator, limit = condition[1], condition[2], condition[3]
		local count, startCooldown, endCooldown = state:RuneCount(name)
		if startCooldown < INFINITY then
			local origin = startCooldown
			local rate = 1 / (endCooldown - startCooldown)
			local start, ending = startCooldown, INFINITY
			return TestValue(start, ending, count, origin, rate, comparator, limit)
		end
		return Compare(count, comparator, limit)
	end

	--- Get the current number of active and regenerating (fractional) death runes of the given type for death knights.
	-- @name DeathRune
	-- @paramsig number or boolean
	-- @param type The type of rune.
	--     Valid values: blood, frost, unholy
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of runes.
	-- @return A boolean value for the result of the comparison.
	-- @see Rune
	-- @usage
	-- if DeathRune(blood) > 1 Spell(blood_tap)

	local function DeathRune(condition, state)
		local name, comparator, limit = condition[1], condition[2], condition[3]
		local count, startCooldown, endCooldown = state:DeathRuneCount(name)
		if startCooldown < INFINITY then
			local origin = startCooldown
			local rate = 1 / (endCooldown - startCooldown)
			local start, ending = startCooldown, INFINITY
			return TestValue(start, ending, count, origin, rate, comparator, limit)
		end
		return Compare(count, comparator, limit)
	end

	--- Get the current number of active runes of the given type for death knights.
	-- @name RuneCount
	-- @paramsig number or boolean
	-- @param type The type of rune.
	--     Valid values: blood, frost, unholy, death
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of runes.
	-- @return A boolean value for the result of the comparison.
	-- @see Rune
	-- @usage
	-- if RuneCount(unholy) ==2 or RuneCount(frost) ==2 or RuneCount(death) ==2
	--     Spell(obliterate)

	local function RuneCount(condition, state)
		local name, comparator, limit = condition[1], condition[2], condition[3]
		local count, startCooldown, endCooldown = state:RuneCount(name)
		if startCooldown < INFINITY then
			local start, ending = startCooldown, endCooldown
			return TestValue(start, ending, count, start, 0, comparator, limit)
		end
		return Compare(count, comparator, limit)
	end

	OvaleCondition:RegisterCondition("rune", false, Rune)
	OvaleCondition:RegisterCondition("deathrune", false, DeathRune)
	OvaleCondition:RegisterCondition("runecount", false, RuneCount)
end

do
	local RUNE_OF_POWER_BUFF = 116014

	--- Get the remaining time in seconds before the latest Rune of Power expires.
	--- Returns non-zero only if the player is standing within an existing Rune of Power.
	-- @name RuneOfPowerRemaining
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if RuneOfPowerRemaining() < CastTime(rune_of_power) Spell(rune_of_power)

	local function RuneOfPowerRemaining(condition, state)
		local comparator, limit = condition[1], condition[2]
		local aura = state:GetAura("player", RUNE_OF_POWER_BUFF, "HELPFUL")
		if state:IsActiveAura(aura) then
			local start, ending
			for totemSlot = 1, 2 do
				local haveTotem, name, startTime, duration = API_GetTotemInfo(totemSlot)
				if haveTotem and startTime and (not start or startTime > start) then
					start = startTime
					ending = startTime + duration
				end
			end
			if start then
				return TestValue(0, INFINITY, ending - start, start, -1, comparator, limit)
			end
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("runeofpowerremaining", false, RuneOfPowerRemaining)
	OvaleCondition:RegisterCondition("runeofpowerremains", false, RuneOfPowerRemaining)
end

do
	local RUNE_TYPE = OvaleRunes.RUNE_TYPE

	local runes = {
		blood = 0,
		unholy = 0,
		frost = 0,
		death = 0,
	}

	local function ParseRuneCondition(condition, state)
		for name in pairs(RUNE_TYPE) do
			runes[name] = 0
		end
		local k = 1
		while true do
			local name, count = condition[2*k - 1], condition[2*k]
			if not RUNE_TYPE[name] then break end
			runes[name] = runes[name] + count
			k = k + 1
		end
		return runes.blood, runes.unholy, runes.frost, runes.death
	end

	--- Test if the current active rune counts meets the minimum rune requirements set out in the parameters.
	-- This condition takes pairs of "type number" to mean that there must be a minimum of number runes of the named type.
	-- E.g., Runes(blood 1 frost 1 unholy 1) means at least one blood, one frost, and one unholy rune is available,
	-- death runes included.
	-- @name Runes
	-- @paramsig boolean
	-- @param type The type of rune.
	--     Valid values: blood, frost, unholy, death
	-- @param number The number of runes
	-- @param ... Optional. Additional "type number" pairs for minimum rune requirements.
	-- @return A boolean value.
	-- @usage
	-- if Runes(frost 1) Spell(howling_blast)

	local function Runes(condition, state)
		local blood, unholy, frost, death = ParseRuneCondition(condition, state)
		local seconds = state:GetRunesCooldown(blood, unholy, frost, death)
		return state.currentTime + seconds, INFINITY
	end

	--- Get the number of seconds before the rune conditions are met.
	-- This condition takes pairs of "type number" to mean that there must be a minimum of number runes of the named type.
	-- E.g., RunesCooldown(blood 1 frost 1 unholy 1) returns the number of seconds before
	-- there are at least one blood, one frost, and one unholy rune, death runes included.
	-- @name RunesCooldown
	-- @paramsig number
	-- @param type The type of rune.
	--     Valid values: blood, frost, unholy, death
	-- @param number The number of runes
	-- @param ... Optional. Additional "type number" pairs for minimum rune requirements.
	-- @return The number of seconds.

	local function RunesCooldown(condition, state)
		local blood, unholy, frost, death = ParseRuneCondition(condition, state)
		local seconds = state:GetRunesCooldown(blood, unholy, frost, death)
		return 0, state.currentTime + seconds, seconds, state.currentTime, -1
	end

	OvaleCondition:RegisterCondition("runes", false, Runes)
	OvaleCondition:RegisterCondition("runescooldown", false, RunesCooldown)
end

do
	-- Returns the value of the given snapshot stat.
	local function Snapshot(statName, defaultValue, condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.snapshot[statName] or defaultValue
		return Compare(value, comparator, limit)
	end

	-- Returns the critical strike chance of the given snapshot stat.
	local function SnapshotCritChance(statName, defaultValue, condition, state)
		local comparator, limit = condition[1], condition[2]
		local value = state.snapshot[statName] or defaultValue
		if condition.unlimited ~= 1 and value > 100 then
			value = 100
		end
		return Compare(value, comparator, limit)
	end

	--- Get the current agility of the player.
	-- @name Agility
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current agility.
	-- @return A boolean value for the result of the comparison.

	local function Agility(condition, state)
		return Snapshot("agility", 0, condition, state)
	end

	--- Get the current attack power of the player.
	-- @name AttackPower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current attack power.
	-- @return A boolean value for the result of the comparison.
	-- @see LastAttackPower
	-- @usage
	-- if AttackPower() >10000 Spell(rake)
	-- if AttackPower(more 10000) Spell(rake)

	local function AttackPower(condition, state)
		return Snapshot("attackPower", 0, condition, state)
	end

	--- Get the current critical strike rating of the player.
	-- @name CritRating
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current critical strike rating.
	-- @return A boolean value for the result of the comparison.

	local function CritRating(condition, state)
		return Snapshot("critRating", 0, condition, state)
	end

	--- Get the current haste rating of the player.
	-- @name HasteRating
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current haste rating.
	-- @return A boolean value for the result of the comparison.

	local function HasteRating(condition, state)
		return Snapshot("hasteRating", 0, condition, state)
	end

	--- Get the current intellect of the player.
	-- @name Intellect
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current intellect.
	-- @return A boolean value for the result of the comparison.

	local function Intellect(condition, state)
		return Snapshot("intellect", 0, condition, state)
	end

	--- Get the current mastery effect of the player.
	-- Mastery effect is the effect of the player's mastery, typically a percent-increase to damage
	-- or a percent-increase to chance to trigger some effect.
	-- @name MasteryEffect
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current mastery effect.
	-- @return A boolean value for the result of the comparison.
	-- @see LastMasteryEffect
	-- @usage
	-- if {DamageMultiplier(rake) * {1 + MasteryEffect()/100}} >1.8
	--     Spell(rake)

	local function MasteryEffect(condition, state)
		return Snapshot("masteryEffect", 0, condition, state)
	end

	--- Get the current mastery rating of the player.
	-- @name MasteryRating
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current mastery rating.
	-- @return A boolean value for the result of the comparison.

	local function MasteryRating(condition, state)
		return Snapshot("masteryRating", 0, condition, state)
	end

	--- Get the current melee critical strike chance of the player.
	-- @name MeleeCritChance
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @return The current critical strike chance (in percent).
	-- @return A boolean value for the result of the comparison.
	-- @see LastMeleeCritChance
	-- @usage
	-- if MeleeCritChance() >90 Spell(rip)

	local function MeleeCritChance(condition, state)
		return SnapshotCritChance("meleeCrit", 0, condition, state)
	end

	--- Get the current multistrike chance of the player.
	-- @name MultistrikeChance
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current multistrike chance (in percent).
	-- @return A boolean value for the result of the comparison.
	-- @see LastMultistrikeChance

	local function MultistrikeChance(condition, state)
		return Snapshot("multistrike", 0, condition, state)
	end

	--- Get the current ranged critical strike chance of the player.
	-- @name RangedCritChance
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @return The current critical strike chance (in percent).
	-- @return A boolean value for the result of the comparison.
	-- @see LastRangedCritChance
	-- @usage
	-- if RangedCritChance() >90 Spell(serpent_sting)

	local function RangedCritChance(condition, state)
		return SnapshotCritChance("rangedCrit", 0, condition, state)
	end

	--- Get the current spell critical strike chance of the player.
	-- @name SpellCritChance
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param unlimited Optional. Set unlimited=1 to allow critical strike chance to exceed 100%.
	--     Defaults to unlimited=0.
	--     Valid values: 0, 1
	-- @return The current critical strike chance (in percent).
	-- @return A boolean value for the result of the comparison.
	-- @see CritChance, LastSpellCritChance
	-- @usage
	-- if SpellCritChance() >30 Spell(immolate)

	local function SpellCritChance(condition, state)
		return SnapshotCritChance("spellCrit", 0, condition, state)
	end

	--- Get the current percent increase to spell haste of the player.
	-- @name SpellHaste
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current percent increase to spell haste.
	-- @return A boolean value for the result of the comparison.
	-- @see BuffSpellHaste
	-- @usage
	-- if SpellHaste() >target.DebuffSpellHaste(moonfire) Spell(moonfire)

	local function SpellHaste(condition, state)
		return Snapshot("spellHaste", 0, condition, state)
	end

	--- Get the current spellpower of the player.
	-- @name Spellpower
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current spellpower.
	-- @return A boolean value for the result of the comparison.
	-- @see LastSpellpower
	-- @usage
	-- if {Spellpower() / LastSpellpower(living_bomb)} >1.25
	--     Spell(living_bomb)

	local function Spellpower(condition, state)
		return Snapshot("spellBonusDamage", 0, condition, state)
	end

	--- Get the current spirit of the player.
	-- @name Spirit
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current spirit.
	-- @return A boolean value for the result of the comparison.

	local function Spirit(condition, state)
		return Snapshot("spirit", 0, condition, state)
	end

	--- Get the current stamina of the player.
	-- @name Stamina
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current stamina.
	-- @return A boolean value for the result of the comparison.

	local function Stamina(condition, state)
		return Snapshot("stamina", 0, condition, state)
	end

	--- Get the current strength of the player.
	-- @name Strength
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The current strength.
	-- @return A boolean value for the result of the comparison.

	local function Strength(condition, state)
		return Snapshot("strength", 0, condition, state)
	end

	OvaleCondition:RegisterCondition("agility", false, Agility)
	OvaleCondition:RegisterCondition("attackpower", false, AttackPower)
	OvaleCondition:RegisterCondition("critrating", false, CritRating)
	OvaleCondition:RegisterCondition("hasterating", false, HasteRating)
	OvaleCondition:RegisterCondition("intellect", false, Intellect)
	OvaleCondition:RegisterCondition("mastery", false, MasteryEffect)
	OvaleCondition:RegisterCondition("masteryeffect", false, MasteryEffect)
	OvaleCondition:RegisterCondition("masteryrating", false, MasteryRating)
	OvaleCondition:RegisterCondition("meleecritchance", false, MeleeCritChance)
	OvaleCondition:RegisterCondition("multistrikechance", false, MultistrikeChance)
	OvaleCondition:RegisterCondition("rangedcritchance", false, RangedCritChance)
	OvaleCondition:RegisterCondition("spellcritchance", false, SpellCritChance)
	OvaleCondition:RegisterCondition("spellhaste", false, SpellHaste)
	OvaleCondition:RegisterCondition("spellpower", false, Spellpower)
	OvaleCondition:RegisterCondition("spirit", false, Spirit)
	OvaleCondition:RegisterCondition("stamina", false, Stamina)
	OvaleCondition:RegisterCondition("strength", false, Strength)
end

do
	--- Get the current speed of the target.
	-- If the target is not moving, then this condition returns 0 (zero).
	-- If the target is at running speed, then this condition returns 100.
	-- @name Speed
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The speed of the target.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Speed(more 0) and not BuffPresent(aspect_of_the_fox)
	--     Spell(aspect_of_the_fox)

	local function Speed(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local value = API_GetUnitSpeed(target) * 100 / 7
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("speed", false, Speed)
end

do
	--- Get the cooldown in seconds on a spell before it gains another charge.
	-- @name SpellChargeCooldown
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see SpellCharges
	-- @usage
	-- if SpellChargeCooldown(roll) <2
	--     Spell(roll usable=1)

	local function SpellChargeCooldown(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local charges, maxCharges, start, duration = state:GetSpellCharges(spellId)
		if charges and charges < maxCharges then
			return TestValue(start, start + duration, duration, start, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("spellchargecooldown", true, SpellChargeCooldown)
end

do
	--- Get the number of charges of the spell.
	-- @name SpellCharges
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param count Optional. Sets whether a count or a fractional value is returned.
	--     Defaults to count=1.
	--     Valid values: 0, 1.
	-- @return The number of charges.
	-- @return A boolean value for the result of the comparison.
	-- @see SpellChargeCooldown
	-- @usage
	-- if SpellCharges(savage_defense) >1
	--     Spell(savage_defense)

	local function SpellCharges(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local charges, maxCharges, start, duration = state:GetSpellCharges(spellId)
		charges = charges or 0
		maxCharges = maxCharges or 1
		if condition.count == 0 and charges < maxCharges then
			return TestValue(state.currentTime, INFINITY, charges + 1, start + duration, 1, comparator, limit)
		end
		return Compare(charges, comparator, limit)
	end

	OvaleCondition:RegisterCondition("charges", true, SpellCharges)
	OvaleCondition:RegisterCondition("spellcharges", true, SpellCharges)
end

do
	--- Get the number of seconds before any of the listed spells are ready for use.
	-- @name SpellCooldown
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param ... Optional. Additional spell IDs.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see TimeToSpell
	-- @usage
	-- if ShadowOrbs() ==3 and SpellCooldown(mind_blast) <2
	--     Spell(devouring_plague)

	local function SpellCooldown(condition, state)
		local comparator, limit
		local usable = (condition.usable == 1)
		local target = ParseCondition(condition, state, "target")
		local atTime = INFINITY
		for i = 1, #condition do
			local spellId = condition[1]
			if OvaleCondition.COMPARATOR[spellId] then
				comparator, limit = spellId, condition[i+1]
				break
			elseif not OvaleSpellBook:IsKnownSpell(spellId) then
				-- Skip unknown spells.
			elseif not usable or state:IsUsableSpell(spellId, target) then
				local start, duration = state:GetSpellCooldown(spellId)
				local t = 0
				if start > 0 and duration > 0 then
					t = start + duration
				end
				if t < atTime then
					atTime = t
				end
			end
		end
		--[[
			If there are no known spells in the list, then treat the spell as ready.
			This matches SimulationCraft's behavior regarding cooldowns of spells that
			are not known -- they are considered to have a cooldown of zero.
		--]]
		if atTime == INFINITY then
			return Compare(0, comparator, limit)
		elseif atTime > 0 then
			return TestValue(0, atTime, 0, atTime, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("spellcooldown", true, SpellCooldown)
end

do
	--- Get the cooldown duration in seconds for a given spell.
	-- @name SpellCooldownDuration
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.

	local function SpellCooldownDuration(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local duration = state:GetSpellCooldownDuration(spellId, state.currentTime, target)
		return Compare(duration, comparator, limit)
	end

	OvaleCondition:RegisterCondition("spellcooldownduration", true, SpellCooldownDuration)
end

do
	--- Get data for the given spell defined by SpellInfo(...)
	-- @name SpellData
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param key The name of the data set by SpellInfo(...).
	--     Valid values are any alphanumeric string.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number data associated with the given key.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if BuffRemaining(slice_and_dice) >= SpellData(shadow_blades duration)
	--     Spell(shadow_blades)

	local function SpellData(condition, state)
		local spellId, key, comparator, limit = condition[1], condition[2], condition[3], condition[4]
		local si = OvaleData.spellInfo[spellId]
		if si then
			local value = si[key]
			if value then
				return Compare(value, comparator, limit)
			end
		end
		return nil
	end

	OvaleCondition:RegisterCondition("spelldata", false, SpellData)
end

do
	--- Test if the given spell is in the spellbook.
	-- A spell is known if the player has learned the spell and it is in the spellbook.
	-- @name SpellKnown
	-- @paramsig boolean
	-- @param id The spell ID.
	-- @param yesno Optional. If yes, then return true if the spell has been learned.
	--     If no, then return true if the player hasn't learned the spell.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @see SpellUsable

	local function SpellKnown(condition, state)
		local spellId, yesno = condition[1], condition[2]
		local boolean = OvaleSpellBook:IsKnownSpell(spellId)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("spellknown", true, SpellKnown)
end

do
	--- Test if the given spell is usable.
	-- A spell is usable if the player has learned the spell and meets any requirements for casting the spell.
	-- Does not account for spell cooldowns or having enough of a primary (pooled) resource.
	-- @name SpellUsable
	-- @paramsig boolean
	-- @param id The spell ID.
	-- @param yesno Optional. If yes, then return true if the spell is usable. If no, then return true if it isn't usable.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @see SpellKnown

	local function SpellUsable(condition, state)
		local spellId, yesno = condition[1], condition[2]
		local target = ParseCondition(condition, state, "target")
		local isUsable, noMana = state:IsUsableSpell(spellId, target)
		local boolean = isUsable or noMana
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("spellusable", true, SpellUsable)
end

do
	local LIGHT_STAGGER = 124275
	local MODERATE_STAGGER = 124274
	local HEAVY_STAGGER = 124273

	--- Get the remaining amount of damage Stagger will cause to the target.
	-- @name StaggerRemaining
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of damage.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if StaggerRemaining() / MaxHealth() >0.4 Spell(purifying_brew)

	local function StaggerRemaining(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state)
		local aura = state:GetAura(target, HEAVY_STAGGER, "HARMFUL")
		if not state:IsActiveAura(aura) then
			aura = state:GetAura(target, MODERATE_STAGGER, "HARMFUL")
		end
		if not state:IsActiveAura(aura) then
			aura = state:GetAura(target, LIGHT_STAGGER, "HARMFUL")
		end
		if state:IsActiveAura(aura) then
			local gain, start, ending = aura.gain, aura.start, aura.ending
			local stagger = API_UnitStagger(target)
			local rate = -1 * stagger / (ending - start)
			return TestValue(gain, ending, 0, ending, rate, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("staggerremaining", false, StaggerRemaining)
	OvaleCondition:RegisterCondition("staggerremains", false, StaggerRemaining)
end

do
	--- Test if the player is in a given stance.
	-- @name Stance
	-- @paramsig boolean
	-- @param stance The stance name or a number representing the stance index.
	-- @param yesno Optional. If yes, then return true if the player is in the given stance. If no, then return true otherwise.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- unless Stance(druid_bear_form) Spell(bear_form)

	local function Stance(condition, state)
		local stance, yesno = condition[1], condition[2]
		local boolean = state:IsStance(stance)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("stance", false, Stance)
end

do
	--- Test if the player is currently stealthed.
	-- The player is stealthed if rogue Stealth, druid Prowl, or a similar ability is active.
	-- @name Stealthed
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if stealthed. If no, then return true if it not stealthed.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if Stealthed() or BuffPresent(shadow_dance)
	--     Spell(ambush)

	local function Stealthed(condition, state)
		local yesno = condition[1]
		local boolean = state:GetAura("player", "stealthed_buff") or API_IsStealthed()
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("isstealthed", false, Stealthed)
	OvaleCondition:RegisterCondition("stealthed", false, Stealthed)
end

do
	--- Get the time elapsed in seconds since the player's previous melee swing (white attack).
	-- @name LastSwing
	-- @paramsig number or boolean
	-- @param hand Optional. Sets which hand weapon's melee swing.
	--     If no hand is specified, then return the time elapsed since the previous swing of either hand's weapon.
	--     Valid values: main, off.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see NextSwing

	local function LastSwing(condition, state)
		local swing = condition[1]
		local comparator, limit
		local start
		if swing and swing == "main" or swing == "off" then
			comparator, limit = condition[2], condition[3]
			start = 0
		else
			comparator, limit = condition[1], condition[2]
			start = 0
		end
		Ovale:OneTimeMessage("Warning: 'LastSwing() is not implemented.")
		return TestValue(start, INFINITY, 0, start, 1, comparator, limit)
	end

	--- Get the time in seconds until the player's next melee swing (white attack).
	-- @name NextSwing
	-- @paramsig number or boolean
	-- @param hand Optional. Sets which hand weapon's melee swing.
	--     If no hand is specified, then return the time until the next swing of either hand's weapon.
	--     Valid values: main, off.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds
	-- @return A boolean value for the result of the comparison.
	-- @see LastSwing

	local function NextSwing(condition, state)
		local swing = condition[1]
		local comparator, limit
		local ending
		if swing and swing == "main" or swing == "off" then
			comparator, limit = condition[2], condition[3]
			ending = 0
		else
			comparator, limit = condition[1], condition[2]
			ending = 0
		end
		Ovale:OneTimeMessage("Warning: 'NextSwing() is not implemented.")
		return TestValue(0, ending, 0, ending, -1, comparator, limit)
	end

	OvaleCondition:RegisterCondition("lastswing", false, LastSwing)
	OvaleCondition:RegisterCondition("nextswing", false, NextSwing)
end

do
	--- Test if the given talent is active.
	-- @name Talent
	-- @paramsig boolean
	-- @param id The talent ID.
	-- @param yesno Optional. If yes, then return true if the glyph is active. If no, then return true if it isn't active.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @return A boolean value.
	-- @usage
	-- if Talent(blood_tap_talent) Spell(blood_tap)

	local function Talent(condition, state)
		local talentId, yesno = condition[1], condition[2]
		local boolean = (OvaleSpellBook:GetTalentPoints(talentId) > 0)
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("talent", false, Talent)
end

do
	--- Get the number of points spent in a talent (0 or 1)
	-- @name TalentPoints
	-- @paramsig number or boolean
	-- @param talent Talent to inspect.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of talent points.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TalentPoints(blood_tap_talent) Spell(blood_tap)

	local function TalentPoints(condition, state)
		local talent, comparator, limit = condition[1], condition[2], condition[3]
		local value = OvaleSpellBook:GetTalentPoints(talent)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("talentpoints", false, TalentPoints)
end

do
	--- Test if the player is the in-game target of the target.
	-- @name TargetIsPlayer
	-- @paramsig boolean
	-- @param yesno Optional. If yes, then return true if it matches. If no, then return true if it doesn't match.
	--     Default is yes.
	--     Valid values: yes, no.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return A boolean value.
	-- @usage
	-- if target.TargetIsPlayer() Spell(feign_death)

	local function TargetIsPlayer(condition, state)
		local yesno = condition[1]
		local target = ParseCondition(condition, state)
		local boolean = API_UnitIsUnit("player", target .. "target")
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("istargetingplayer", false, TargetIsPlayer)
	OvaleCondition:RegisterCondition("targetisplayer", false, TargetIsPlayer)
end

do
	--- Get the amount of threat on the current target relative to the its primary aggro target, scaled to between 0 (zero) and 100.
	-- This is a number between 0 (no threat) and 100 (will become the primary aggro target).
	-- @name Threat
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The amount of threat.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if Threat() >90 Spell(fade)
	-- if Threat(more 90) Spell(fade)

	local function Threat(condition, state)
		local comparator, limit = condition[1], condition[2]
		local target = ParseCondition(condition, state, "target")
		local _, _, value = API_UnitDetailedThreatSituation("player", target)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("threat", false, Threat)
end

do
	--- Get the number of seconds between ticks of a periodic aura on a target.
	-- @name TickTime
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param filter Optional. The type of aura to check.
	--     Default is any.
	--     Valid values: any, buff, debuff
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see TicksRemaining

	local function TickTime(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		local tickTime
		if state:IsActiveAura(aura) then
			tickTime = aura.tick
		else
			tickTime = OvaleData:GetTickLength(auraId, state.snapshot)
		end
		if tickTime and tickTime > 0 then
			return Compare(tickTime, comparator, limit)
		end
		return Compare(INFINITY, comparator, limit)
	end

	OvaleCondition:RegisterCondition("ticktime", false, TickTime)
end

do
	--- Get the remaining number of ticks of a periodic aura on a target.
	-- @name TicksRemaining
	-- @paramsig number or boolean
	-- @param id The spell ID of the aura or the name of a spell list.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param filter Optional. The type of aura to check.
	--     Default is any.
	--     Valid values: any, buff, debuff
	-- @param target Optional. Sets the target to check. The target may also be given as a prefix to the condition.
	--     Defaults to target=player.
	--     Valid values: player, target, focus, pet.
	-- @return The number of ticks.
	-- @return A boolean value for the result of the comparison.
	-- @see TickTime
	-- @usage
	-- if target.TicksRemaining(shadow_word_pain) <2
	--     Spell(shadow_word_pain)

	local function TicksRemaining(condition, state)
		local auraId, comparator, limit = condition[1], condition[2], condition[3]
		local target, filter, mine = ParseCondition(condition, state)
		local aura = state:GetAura(target, auraId, filter, mine)
		if aura then
			local gain, start, ending, tick = aura.gain, aura.start, aura.ending, aura.tick
			if tick and tick > 0 then
				return TestValue(gain, INFINITY, 1, ending, -1/tick, comparator, limit)
			end
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("ticksremaining", false, TicksRemaining)
	OvaleCondition:RegisterCondition("ticksremain", false, TicksRemaining)
end

do
	--- Get the number of seconds elapsed since the player entered combat.
	-- @name TimeInCombat
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TimeInCombat(more 5) Spell(bloodlust)

	local function TimeInCombat(condition, state)
		local comparator, limit = condition[1], condition[2]
		if state.inCombat then
			local start = state.combatStartTime
			return TestValue(start, INFINITY, 0, start, 1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("timeincombat", false, TimeInCombat)
end

do
	--- Get the number of seconds elapsed since the player cast the given spell.
	-- @name TimeSincePreviousSpell
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TimeSincePreviousSpell(pestilence) > 28 Spell(pestilence)

	local function TimeSincePreviousSpell(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local t = state:TimeOfLastCast(spellId)
		return TestValue(0, INFINITY, t, 0, 1, comparator, limit)
	end

	OvaleCondition:RegisterCondition("timesincepreviousspell", false, TimeSincePreviousSpell)
end

do
	--- Get the time in seconds until the next scheduled Bloodlust cast.
	-- Not implemented, always returns 3600 seconds.
	-- @name TimeToBloodlust
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.

	local function TimeToBloodlust(condition, state)
		local comparator, limit = condition[1], condition[2], condition[3]
		local value = 3600
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("timetobloodlust", false, TimeToBloodlust)
end

do
	--- Get the number of seconds before the player reaches the given power level.
	local function TimeToPower(powerType, level, comparator, limit, state)
		local level = level or 0
		local power = state[powerType] or 0
		local powerRegen = state.powerRate[powerType] or 1
		if powerRegen == 0 then
			if power == level then
				return Compare(0, comparator, limit)
			end
			return Compare(INFINITY, comparator, limit)
		else
			local t = (level - power) / powerRegen
			if t > 0 then
				local ending = state.currentTime + t
				return TestValue(0, ending, 0, ending, -1, comparator, limit)
			end
			return Compare(0, comparator, limit)
		end
	end

	--- Get the number of seconds before the player reaches the given energy level for feral druids, non-mistweaver monks and rogues.
	-- @name TimeToEnergy
	-- @paramsig number or boolean
	-- @param level. The level of energy to reach.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @see TimeToEnergyFor, TimeToMaxEnergy
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TimeToEnergy(100) < 1.2 Spell(sinister_strike)

	local function TimeToEnergy(condition, state)
		local level, comparator, limit = condition[1], condition[2], condition[3]
		return TimeToPower("energy", level, comparator, limit, state)
	end

	--- Get the number of seconds before the player reaches maximum energy for feral druids, non-mistweaver monks and rogues.
	-- @name TimeToMaxEnergy
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @see TimeToEnergy, TimeToEnergyFor
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TimeToMaxEnergy() < 1.2 Spell(sinister_strike)

	local function TimeToMaxEnergy(condition, state)
		local powerType = "energy"
		local comparator, limit = condition[1], condition[2]
		local level = OvalePower.maxPower[powerType] or 0
		return TimeToPower(powerType, level, comparator, limit, state)
	end

	--- Get the number of seconds before the player reaches the given focus level for hunters.
	-- @name TimeToFocus
	-- @paramsig number or boolean
	-- @param level. The level of focus to reach.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @see TimeToFocusFor, TimeToMaxFocus
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TimeToFocus(100) < 1.2 Spell(cobra_shot)

	local function TimeToFocus(condition, state)
		local level, comparator, limit = condition[1], condition[2], condition[3]
		return TimeToPower("focus", level, comparator, limit, state)
	end

	--- Get the number of seconds before the player reaches maximum focus for hunters.
	-- @name TimeToMaxFocus
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @see TimeToFocus, TimeToFocusFor
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if TimeToMaxFocus() < 1.2 Spell(cobra_shot)

	local function TimeToMaxFocus(condition, state)
		local powerType = "focus"
		local comparator, limit = condition[1], condition[2]
		local level = OvalePower.maxPower[powerType] or 0
		return TimeToPower(powerType, level, comparator, limit, state)
	end

	OvaleCondition:RegisterCondition("timetoenergy", false, TimeToEnergy)
	OvaleCondition:RegisterCondition("timetofocus", false, TimeToFocus)
	OvaleCondition:RegisterCondition("timetomaxenergy", false, TimeToMaxEnergy)
	OvaleCondition:RegisterCondition("timetomaxfocus", false, TimeToMaxFocus)
end

do
	local function TimeToPowerFor(powerType, condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		if not powerType then
			local _, pt = OvalePower:GetSpellCost(spellId)
			powerType = pt
		end
		local seconds = state:TimeToPower(spellId, target, powerType)

		if seconds == 0 then
			return Compare(0, comparator, limit)
		elseif seconds < INFINITY then
			return TestValue(0, state.currentTime + seconds, seconds, state.currentTime, -1, comparator, limit)
		else -- if seconds == INFINITY then
			return Compare(INFINITY, comparator, limit)
		end
	end

	--- Get the number of seconds before the player has enough energy to cast the given spell.
	-- @name TimeToEnergyFor
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see TimeToEnergyFor, TimeToMaxEnergy

	local function TimeToEnergyFor(condition, state)
		return TimeToPowerFor("energy", condition, state)
	end

	--- Get the number of seconds before the player has enough focus to cast the given spell.
	-- @name TimeToFocusFor
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see TimeToFocusFor

	local function TimeToFocusFor(condition, state)
		return TimeToPowerFor("focus", condition, state)
	end

	OvaleCondition:RegisterCondition("timetoenergyfor", true, TimeToEnergyFor)
	OvaleCondition:RegisterCondition("timetofocusfor", true, TimeToFocusFor)
end

do
	--- Get the number of seconds before the spell is ready to be cast, either due to cooldown or resources.
	-- @name TimeToSpell
	-- @paramsig number or boolean
	-- @param id The spell ID.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.

	local function TimeToSpell(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local seconds = 0
		-- Cooldown
		do
			local start, duration = state:GetSpellCooldown(spellId)
			local timeToCooldown = start + duration - state.currentTime
			if seconds < timeToCooldown then
				seconds = timeToCooldown
			end
		end
		-- Pooled resource.
		do
			local timeToPower = state:TimeToPower(spellId, target)
			if seconds < timeToPower then
				seconds = timeToPower
			end
		end
		-- Runes.
		local blood = state:GetSpellInfoProperty(spellId, "blood", target)
		local unholy = state:GetSpellInfoProperty(spellId, "unholy", target)
		local frost = state:GetSpellInfoProperty(spellId, "frost", target)
		local death = state:GetSpellInfoProperty(spellId, "death", target)
		if blood or unholy or frost or death then
			local timeToRunes = state:GetRunesCooldown(blood, unholy, frost, death)
			if seconds < timeToRunes then
				seconds = timeToRunes
			end
		end
		if seconds == 0 then
			return Compare(0, comparator, limit)
		elseif seconds < INFINITY then
			return TestValue(0, state.currentTime + seconds, seconds, state.currentTime, -1, comparator, limit)
		else -- if seconds == INFINITY then
			return Compare(INFINITY, comparator, limit)
		end
	end

	OvaleCondition:RegisterCondition("timetospell", true, TimeToSpell)
end

do
	--- Get the time scaled by the specified haste type, defaulting to spell haste.
	--- For example, if a DoT normally ticks every 3 seconds and is scaled by spell haste, then it ticks every TimeWithHaste(3 haste=spell) seconds.
	-- @name TimeWithHaste
	-- @paramsig number or boolean
	-- @param time The time in seconds.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param haste Optional. Sets whether "time" should be lengthened or shortened due to haste.
	--     Defaults to haste=spell.
	--     Valid values: melee, spell.
	-- @return The time in seconds scaled by haste.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if target.DebuffRemaining(flame_shock) < TimeWithHaste(3)
	--     Spell(flame_shock)

	local function TimeWithHaste(condition, state)
		local seconds, comparator, limit = condition[1], condition[2], condition[3]
		local haste = condition.haste or "spell"
		local value = GetHastedTime(seconds, haste)
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("timewithhaste", false, TimeWithHaste)
end

do
	local OVALE_TOTEMTYPE =
	{
		-- Death Knights
		ghoul = 1,
		-- Druid
		mushroom = 1,
		-- XXX Mage
		crystal = 4,
		-- Monks
		statue = 1,
		-- Shamans
		fire = 1,
		earth = 2,
		water = 3,
		air = 4
	}

	--- Test if the totem for shamans, the mushroom for druids, the ghoul for death knights, or the statue for monks has expired.
	-- @name TotemExpires
	-- @paramsig boolean
	-- @param id The totem ID of the totem, ghoul or statue, or the type of totem.
	--     Valid types: fire, water, air, earth, ghoul, mushroom, statue.
	-- @param seconds Optional. The maximum number of seconds before the totem should expire.
	--     Defaults to 0 (zero).
	-- @param totem Optional. Sets the specific totem to check of given totem ID type.
	--     Valid values: any totem spell ID
	-- @return A boolean value.
	-- @see TotemPresent, TotemRemaining
	-- @usage
	-- if TotemExpires(fire) Spell(searing_totem)
	-- if TotemPresent(water totem=healing_stream_totem) and TotemExpires(water 3) Spell(totemic_recall)

	local function TotemExpires(condition, state)
		local totemId, seconds = condition[1], condition[2]
		seconds = seconds or 0
		if type(totemId) ~= "number" then
			totemId = OVALE_TOTEMTYPE[totemId]
		end
		local haveTotem, name, startTime, duration = API_GetTotemInfo(totemId)
		if haveTotem and startTime and (not condition.totem or OvaleSpellBook:GetSpellName(condition.totem) == name) then
			return startTime + duration - seconds, INFINITY
		end
		return 0, INFINITY
	end

	--- Test if the totem for shamans, the ghoul for death knights, or the statue for monks is present.
	-- @name TotemPresent
	-- @paramsig boolean
	-- @param id The totem ID of the totem, ghoul or statue, or the type of totem.
	--     Valid types: fire, water, air, earth, ghoul, statue.
	-- @param totem Optional. Sets the specific totem to check of given totem ID type.
	--     Valid values: any totem spell ID
	-- @return A boolean value.
	-- @see TotemExpires, TotemRemaining
	-- @usage
	-- if not TotemPresent(fire) Spell(searing_totem)
	-- if TotemPresent(water totem=healing_stream_totem) and TotemExpires(water 3) Spell(totemic_recall)

	local function TotemPresent(condition, state)
		local totemId = condition[1]
		if type(totemId) ~= "number" then
			totemId = OVALE_TOTEMTYPE[totemId]
		end
		local haveTotem, name, startTime, duration = API_GetTotemInfo(totemId)
		if haveTotem and startTime and (not condition.totem or OvaleSpellBook:GetSpellName(condition.totem) == name) then
			return startTime, startTime + duration
		end
		return nil
	end

	OvaleCondition:RegisterCondition("totemexpires", false, TotemExpires)
	OvaleCondition:RegisterCondition("totempresent", false, TotemPresent)

	--- Get the remaining time in seconds before a totem expires.
	-- @name TotemRemaining
	-- @paramsig number or boolean
	-- @param id The totem ID of the totem, ghoul or statue, or the type of totem.
	--     Valid types: fire, water, air, earth, ghoul, statue.
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param totem Optional. Sets the specific totem to check of given totem ID type.
	--     Valid values: any totem spell ID
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @see TotemExpires, TotemPresent
	-- @usage
	-- if TotemRemaining(water totem=healing_stream_totem) <2 Spell(totemic_recall)

	local function TotemRemaining(condition, state)
		local totemId, comparator, limit = condition[1], condition[2], condition[3]
		if type(totemId) ~= "number" then
			totemId = OVALE_TOTEMTYPE[totemId]
		end
		local haveTotem, name, startTime, duration = API_GetTotemInfo(totemId)
		if haveTotem and startTime and (not condition.totem or OvaleSpellBook:GetSpellName(condition.totem) == name) then
			local start, ending = startTime, startTime + duration
			return TestValue(start, ending, duration, start, -1, comparator, limit)
		end
		return Compare(0, comparator, limit)
	end

	OvaleCondition:RegisterCondition("totemremaining", false, TotemRemaining)
	OvaleCondition:RegisterCondition("totemremains", false, TotemRemaining)
end

do
	-- Check if a tracking is enabled
	-- 1: the spell id
	-- return bool

	local function Tracking(condition, state)
		local spellId, yesno = condition[1], condition[2]
		local spellName = OvaleSpellBook:GetSpellName(spellId)
		local numTrackingTypes = API_GetNumTrackingTypes()
		local boolean = false
		for i = 1, numTrackingTypes do
			local name, _, active = API_GetTrackingInfo(i)
			if name and name == spellName then
				boolean = (active == 1)
				break
			end
		end
		return TestBoolean(boolean, yesno)
	end

	OvaleCondition:RegisterCondition("tracking", false, Tracking)
end

do
	--- The maximum travel time of a spell in seconds.
	-- This is a fixed guess at 1s or the maximum travel time of the spell in the spell information if given.
	-- @name MaxTravelTime
	-- @paramsig number or boolean
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @param target Optional. Sets the target of the spell. The target may also be given as a prefix to the condition.
	--     Defaults to target=target.
	--     Valid values: player, target, focus, pet.
	-- @return The number of seconds.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- if target.DebuffPresent(shadowflame_debuff) < MaxTravelTime(hand_of_guldan) + GCD()
	--     Spell(hand_of_guldan)

	local function MaxTravelTime(condition, state)
		local spellId, comparator, limit = condition[1], condition[2], condition[3]
		local target = ParseCondition(condition, state, "target")
		local si = spellId and OvaleData.spellInfo[spellId]
		-- TODO: Track average time in flight to target for the spell.
		local value = state:GetSpellInfoProperty(spellId, "max_travel_time", target) or 1
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("maxtraveltime", true, MaxTravelTime)
end

do
	--- A condition that always returns true.
	-- @name True
	-- @paramsig boolean
	-- @return A boolean value.

	local function True(condition, state)
		return 0, INFINITY
	end

	OvaleCondition:RegisterCondition("true", false, True)
end

do
	--- The normalized weapon damage of the weapon in the given hand.
	-- @name WeaponDamage
	-- @paramsig number or boolean
	-- @param hand Optional. Sets which hand weapon.
	--     Defaults to main.
	--     Valid values: main, off
	-- @param operator Optional. Comparison operator: less, atMost, equal, atLeast, more.
	-- @param number Optional. The number to compare against.
	-- @return The normalized weapon damage.
	-- @return A boolean value for the result of the comparison.
	-- @usage
	-- AddFunction MangleDamage {
	--     WeaponDamage() * 5 + 78
	-- }

	local function WeaponDamage(condition, state)
		local hand = condition[1]
		local comparator, limit
		local value = 0
		if hand == "offhand" or hand == "off" then
			comparator, limit = condition[2], condition[3]
			value = state.snapshot.offHandWeaponDamage
		elseif hand == "mainhand" or hand == "main" then
			comparator, limit = condition[2], condition[3]
			value = state.snapshot.mainHandWeaponDamage
		else
			comparator, limit = condition[1], condition[2]
			value = state.snapshot.mainHandWeaponDamage
		end
		return Compare(value, comparator, limit)
	end

	OvaleCondition:RegisterCondition("weapondamage", false, WeaponDamage)
end

do
	--- Test if the weapon imbue on the given weapon has expired or will expire after a given number of seconds.
	-- @name WeaponEnchantExpires
	-- @paramsig boolean
	-- @param hand Sets which hand weapon.
	--     Valid values: main, off.
	-- @param seconds Optional. The maximum number of seconds before the weapon imbue should expire.
	--     Defaults to 0 (zero).
	-- @return A boolean value.
	-- @usage
	-- if WeaponEnchantExpires(main) Spell(windfury_weapon)

	local function WeaponEnchantExpires(condition, state)
		local hand, seconds = condition[1], condition[2]
		seconds = seconds or 0
		local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = API_GetWeaponEnchantInfo()
		local now = API_GetTime()
		if hand == "mainhand" or hand == "main" then
			if hasMainHandEnchant then
				mainHandExpiration = mainHandExpiration / 1000
				return now + mainHandExpiration - seconds, INFINITY
			end
		elseif hand == "offhand" or hand == "off" then
			if hasOffHandEnchant then
				offHandExpiration = offHandExpiration / 1000
				return now + offHandExpiration - seconds, INFINITY
			end
		end
		return 0, INFINITY
	end

	OvaleCondition:RegisterCondition("weaponenchantexpires", false, WeaponEnchantExpires)
end
