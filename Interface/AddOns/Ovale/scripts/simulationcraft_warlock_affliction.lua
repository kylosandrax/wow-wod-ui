local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "SimulationCraft: Warlock_Affliction_T17M"
	local desc = "[6.0] SimulationCraft: Warlock_Affliction_T17M"
	local code = [[
# Based on SimulationCraft profile "Warlock_Affliction_T17M".
#	class=warlock
#	spec=affliction
#	talents=0000113
#	pet=felhunter

Include(ovale_common)
Include(ovale_warlock_spells)

AddCheckBox(opt_potion_intellect ItemName(draenic_intellect_potion) default)

AddFunction UsePotionIntellect
{
	if CheckBoxOn(opt_potion_intellect) and target.Classification(worldboss) Item(draenic_intellect_potion usable=1)
}

AddFunction AfflictionDefaultActions
{
	#potion,name=draenic_intellect,if=buff.bloodlust.react|target.health.pct<=20
	if BuffPresent(burst_haste_buff any=1) or target.HealthPercent() <= 20 UsePotionIntellect()
	#berserking
	Spell(berserking)
	#blood_fury
	Spell(blood_fury_sp)
	#arcane_torrent
	Spell(arcane_torrent_mana)
	#mannoroths_fury
	Spell(mannoroths_fury)
	#dark_soul,if=!talent.archimondes_darkness.enabled|(talent.archimondes_darkness.enabled&(charges=2|trinket.proc.intellect.react|trinket.stacking_proc.intellect.react>6|target.health.pct<=10))
	if not Talent(archimondes_darkness_talent) or Talent(archimondes_darkness_talent) and { Charges(dark_soul_misery) == 2 or BuffPresent(trinket_proc_intellect_buff) or BuffStacks(trinket_stacking_proc_intellect_buff) > 6 or target.HealthPercent() <= 10 } Spell(dark_soul_misery)
	#service_pet,if=talent.grimoire_of_service.enabled
	if Talent(grimoire_of_service_talent) Spell(grimoire_felhunter)
	#summon_doomguard,if=!talent.demonic_servitude.enabled&active_enemies<5
	if not Talent(demonic_servitude_talent) and Enemies() < 5 Spell(summon_doomguard)
	#summon_infernal,if=!talent.demonic_servitude.enabled&active_enemies>=5
	if not Talent(demonic_servitude_talent) and Enemies() >= 5 Spell(summon_infernal)
	#cataclysm
	Spell(cataclysm)
	#haunt,if=shard_react&!talent.soulburn_haunt.enabled&!in_flight_to_target&(dot.haunt.remains<cast_time+travel_time|soul_shard=4)&(trinket.proc.any.react|trinket.stacking_proc.any.react>6|buff.dark_soul.up|soul_shard>2|soul_shard*14<=target.time_to_die)
	if SoulShards() >= 1 and not Talent(soulburn_haunt_talent) and not InFlightToTarget(haunt) and { target.DebuffRemaining(haunt_debuff) < CastTime(haunt) + MaxTravelTime(haunt) or SoulShards() == 4 } and { BuffPresent(trinket_proc_any_buff) or BuffStacks(trinket_stacking_proc_any_buff) > 6 or BuffPresent(dark_soul_misery_buff) or SoulShards() > 2 or SoulShards() * 14 <= target.TimeToDie() } Spell(haunt)
	#soulburn,if=shard_react&talent.soulburn_haunt.enabled&buff.soulburn.down&(buff.haunting_spirits.down|soul_shard=4&buff.haunting_spirits.remains<5)
	if SoulShards() >= 1 and Talent(soulburn_haunt_talent) and BuffExpires(soulburn_buff) and { BuffExpires(haunting_spirits_buff) or SoulShards() == 4 and BuffRemaining(haunting_spirits_buff) < 5 } Spell(soulburn)
	#haunt,if=shard_react&talent.soulburn_haunt.enabled&!in_flight_to_target&((buff.soulburn.up&buff.haunting_spirits.remains<5)|soul_shard=4)
	if SoulShards() >= 1 and Talent(soulburn_haunt_talent) and not InFlightToTarget(haunt) and { BuffPresent(soulburn_buff) and BuffRemaining(haunting_spirits_buff) < 5 or SoulShards() == 4 } Spell(haunt)
	#agony,cycle_targets=1,if=target.time_to_die>16&remains<=(duration*0.3)&((talent.cataclysm.enabled&remains<=(cooldown.cataclysm.remains+action.cataclysm.cast_time))|!talent.cataclysm.enabled)
	if target.TimeToDie() > 16 and target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and { Talent(cataclysm_talent) and target.DebuffRemaining(agony_debuff) <= SpellCooldown(cataclysm) + CastTime(cataclysm) or not Talent(cataclysm_talent) } Spell(agony)
	#unstable_affliction,cycle_targets=1,if=target.time_to_die>10&remains<=(duration*0.3)
	if target.TimeToDie() > 10 and target.DebuffRemaining(unstable_affliction_debuff) <= BaseDuration(unstable_affliction_debuff) * 0.3 Spell(unstable_affliction)
	#corruption,cycle_targets=1,if=target.time_to_die>12&remains<=(duration*0.3)
	if target.TimeToDie() > 12 and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 Spell(corruption)
	#life_tap,if=mana.pct<40
	if ManaPercent() < 40 Spell(life_tap)
	#drain_soul,interrupt=1,chain=1
	Spell(drain_soul)
	#agony,cycle_targets=1,moving=1,if=mana.pct>50
	if Speed() > 0 and ManaPercent() > 50 Spell(agony)
	#life_tap
	Spell(life_tap)
}

AddFunction AfflictionPrecombatActions
{
	#flask,type=greater_draenic_intellect_flask
	#food,type=sleeper_surprise
	#dark_intent,if=!aura.spell_power_multiplier.up
	if not BuffPresent(spell_power_multiplier_buff any=1) Spell(dark_intent)
	#summon_pet,if=!talent.demonic_servitude.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.grimoire_of_sacrifice.down)
	if not Talent(demonic_servitude_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(grimoire_of_sacrifice_buff) } and not pet.Present() Spell(summon_felhunter)
	#summon_doomguard,if=talent.demonic_servitude.enabled&active_enemies<5
	if Talent(demonic_servitude_talent) and Enemies() < 5 Spell(summon_doomguard)
	#summon_infernal,if=talent.demonic_servitude.enabled&active_enemies>=5
	if Talent(demonic_servitude_talent) and Enemies() >= 5 Spell(summon_infernal)
	#snapshot_stats
	#grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled&!talent.demonic_servitude.enabled
	if Talent(grimoire_of_sacrifice_talent) and not Talent(demonic_servitude_talent) and pet.Present() Spell(grimoire_of_sacrifice)
	#service_pet,if=talent.grimoire_of_service.enabled
	if Talent(grimoire_of_service_talent) Spell(grimoire_felhunter)
	#potion,name=draenic_intellect
	UsePotionIntellect()
}

AddIcon specialization=affliction help=main enemies=1
{
	if not InCombat() AfflictionPrecombatActions()
	AfflictionDefaultActions()
}

AddIcon specialization=affliction help=aoe
{
	if not InCombat() AfflictionPrecombatActions()
	AfflictionDefaultActions()
}

### Required symbols
# agony
# agony_debuff
# arcane_torrent_mana
# archimondes_darkness_talent
# berserking
# blood_fury_sp
# cataclysm
# cataclysm_talent
# corruption
# corruption_debuff
# dark_intent
# dark_soul_misery
# dark_soul_misery_buff
# demonic_servitude_talent
# draenic_intellect_potion
# drain_soul
# grimoire_felhunter
# grimoire_of_sacrifice
# grimoire_of_sacrifice_buff
# grimoire_of_sacrifice_talent
# grimoire_of_service_talent
# haunt
# haunt_debuff
# haunting_spirits_buff
# life_tap
# mannoroths_fury
# soulburn
# soulburn_buff
# soulburn_haunt_talent
# summon_doomguard
# summon_felhunter
# summon_infernal
# unstable_affliction
# unstable_affliction_debuff
]]
	OvaleScripts:RegisterScript("WARLOCK", name, desc, code, "reference")
end
