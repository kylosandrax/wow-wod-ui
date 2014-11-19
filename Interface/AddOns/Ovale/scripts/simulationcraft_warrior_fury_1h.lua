local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "SimulationCraft: Warrior_Fury_1h_T17M"
	local desc = "[6.0] SimulationCraft: Warrior_Fury_1h_T17M"
	local code = [[
# Based on SimulationCraft profile "Warrior_Fury_1h_T17M".
#	class=warrior
#	spec=fury
#	talents=1321321
#	glyphs=unending_rage/raging_wind/heroic_leap

Include(ovale_common)
Include(ovale_warrior_spells)

AddCheckBox(opt_potion_strength ItemName(draenic_strength_potion) default)

AddFunction UsePotionStrength
{
	if CheckBoxOn(opt_potion_strength) and target.Classification(worldboss) Item(draenic_strength_potion usable=1)
}

AddFunction GetInMeleeRange
{
	if not target.InRange(pummel) Texture(misc_arrowlup help=L(not_in_melee_range))
}

AddFunction InterruptActions
{
	if not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(pummel) Spell(pummel)
		if Glyph(glyph_of_gag_order) and target.InRange(heroic_throw) Spell(heroic_throw)
		if not target.Classification(worldboss)
		{
			Spell(arcane_torrent_rage)
			if target.InRange(quaking_palm) Spell(quaking_palm)
			Spell(war_stomp)
		}
	}
}

AddFunction FurySingleMindedFuryDefaultActions
{
	#charge
	if target.InRange(charge) Spell(charge)
	#auto_attack
	#call_action_list,name=movement,if=movement.distance>5
	if 0 > 5 FurySingleMindedFuryMovementActions()
	#berserker_rage,if=buff.enrage.down|(talent.unquenchable_thirst.enabled&buff.raging_blow.down)
	if BuffExpires(enrage_buff any=1) or Talent(unquenchable_thirst_talent) and BuffExpires(raging_blow_buff) Spell(berserker_rage)
	#heroic_leap,if=(raid_event.movement.distance>25&raid_event.movement.in>45)|!raid_event.movement.exists
	if { 0 > 25 and 600 > 45 or not False(raid_event_movement_exists) } and target.InRange(charge) Spell(heroic_leap)
	#potion,name=draenic_strength,if=(target.health.pct<20&buff.recklessness.up)|target.time_to_die<=25
	if target.HealthPercent() < 20 and BuffPresent(recklessness_buff) or target.TimeToDie() <= 25 UsePotionStrength()
	#call_action_list,name=single_target,if=(raid_event.adds.cooldown<60&raid_event.adds.count>3&active_enemies=1)|raid_event.movement.cooldown<5
	if 600 < 60 and 0 > 3 and Enemies() == 1 or 600 < 5 FurySingleMindedFurySingleTargetActions()
	#recklessness,if=((target.time_to_die>190|target.health.pct<20)&(buff.bloodbath.up|!talent.bloodbath.enabled))|target.time_to_die<=12|talent.anger_management.enabled
	if { target.TimeToDie() > 190 or target.HealthPercent() < 20 } and { BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) } or target.TimeToDie() <= 12 or Talent(anger_management_talent) Spell(recklessness)
	#avatar,if=(buff.recklessness.up|target.time_to_die<=30)
	if BuffPresent(recklessness_buff) or target.TimeToDie() <= 30 Spell(avatar)
	#blood_fury,if=buff.bloodbath.up|!talent.bloodbath.enabled|buff.recklessness.up
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) or BuffPresent(recklessness_buff) Spell(blood_fury_ap)
	#berserking,if=buff.bloodbath.up|!talent.bloodbath.enabled|buff.recklessness.up
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) or BuffPresent(recklessness_buff) Spell(berserking)
	#arcane_torrent,if=buff.bloodbath.up|!talent.bloodbath.enabled|buff.recklessness.up
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) or BuffPresent(recklessness_buff) Spell(arcane_torrent_rage)
	#call_action_list,name=single_target,if=active_enemies=1
	if Enemies() == 1 FurySingleMindedFurySingleTargetActions()
	#call_action_list,name=two_targets,if=active_enemies=2
	if Enemies() == 2 FurySingleMindedFuryTwoTargetsActions()
	#call_action_list,name=three_targets,if=active_enemies=3
	if Enemies() == 3 FurySingleMindedFuryThreeTargetsActions()
	#call_action_list,name=aoe,if=active_enemies>3
	if Enemies() > 3 FurySingleMindedFuryAoeActions()
}

AddFunction FurySingleMindedFuryAoeActions
{
	#bloodbath
	Spell(bloodbath)
	#ravager,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(ravager)
	#raging_blow,if=buff.meat_cleaver.stack>=3&buff.enrage.up
	if BuffStacks(meat_cleaver_buff) >= 3 and BuffPresent(enrage_buff any=1) and BuffPresent(raging_blow_buff) Spell(raging_blow)
	#bloodthirst,if=buff.enrage.down|rage<50|buff.raging_blow.down
	if BuffExpires(enrage_buff any=1) or Rage() < 50 or BuffExpires(raging_blow_buff) Spell(bloodthirst)
	#raging_blow,if=buff.meat_cleaver.stack>=3
	if BuffStacks(meat_cleaver_buff) >= 3 and BuffPresent(raging_blow_buff) Spell(raging_blow)
	#recklessness,sync=bladestorm
	if not SpellCooldown(bladestorm) > 0 Spell(recklessness)
	#bladestorm,if=buff.enrage.remains>6
	if BuffRemaining(enrage_buff any=1) > 6 Spell(bladestorm)
	#whirlwind
	Spell(whirlwind)
	#execute,if=buff.sudden_death.react
	if BuffPresent(sudden_death_buff) Spell(execute)
	#dragon_roar,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(dragon_roar)
	#bloodthirst
	Spell(bloodthirst)
	#wild_strike,if=buff.bloodsurge.up
	if BuffPresent(bloodsurge_buff) Spell(wild_strike)
}

AddFunction FurySingleMindedFuryMovementActions
{
	#heroic_leap
	if target.InRange(charge) Spell(heroic_leap)
	#storm_bolt
	Spell(storm_bolt)
	#heroic_throw
	Spell(heroic_throw)
}

AddFunction FurySingleMindedFuryPrecombatActions
{
	#flask,type=greater_draenic_strength_flask
	#food,type=blackrock_barbecue
	#stance,choose=battle
	Spell(battle_stance)
	#snapshot_stats
	#potion,name=draenic_strength
	UsePotionStrength()
}

AddFunction FurySingleMindedFurySingleTargetActions
{
	#bloodbath
	Spell(bloodbath)
	#recklessness,if=target.health.pct<20&raid_event.adds.exists
	if target.HealthPercent() < 20 and False(raid_event_adds_exists) Spell(recklessness)
	#wild_strike,if=rage>110&target.health.pct>20
	if Rage() > 110 and target.HealthPercent() > 20 Spell(wild_strike)
	#bloodthirst,if=(!talent.unquenchable_thirst.enabled&rage<80)|buff.enrage.down
	if not Talent(unquenchable_thirst_talent) and Rage() < 80 or BuffExpires(enrage_buff any=1) Spell(bloodthirst)
	#ravager,if=buff.bloodbath.up|(!talent.bloodbath.enabled&(!raid_event.adds.exists|raid_event.adds.cooldown>60|target.time_to_die<40))
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) and { not False(raid_event_adds_exists) or 600 > 60 or target.TimeToDie() < 40 } Spell(ravager)
	#execute,if=buff.sudden_death.react
	if BuffPresent(sudden_death_buff) Spell(execute)
	#siegebreaker
	Spell(siegebreaker)
	#storm_bolt
	Spell(storm_bolt)
	#wild_strike,if=buff.bloodsurge.up
	if BuffPresent(bloodsurge_buff) Spell(wild_strike)
	#execute,if=buff.enrage.up|target.time_to_die<12
	if BuffPresent(enrage_buff any=1) or target.TimeToDie() < 12 Spell(execute)
	#dragon_roar,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(dragon_roar)
	#raging_blow
	if BuffPresent(raging_blow_buff) Spell(raging_blow)
	#wild_strike,if=buff.enrage.up&target.health.pct>20
	if BuffPresent(enrage_buff any=1) and target.HealthPercent() > 20 Spell(wild_strike)
	#shockwave,if=!talent.unquenchable_thirst.enabled
	if not Talent(unquenchable_thirst_talent) Spell(shockwave)
	#impending_victory,if=!talent.unquenchable_thirst.enabled&target.health.pct>20
	if not Talent(unquenchable_thirst_talent) and target.HealthPercent() > 20 Spell(impending_victory)
	#bloodthirst
	Spell(bloodthirst)
}

AddFunction FurySingleMindedFuryThreeTargetsActions
{
	#bloodbath
	Spell(bloodbath)
	#ravager,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(ravager)
	#bladestorm,if=buff.enrage.up
	if BuffPresent(enrage_buff any=1) Spell(bladestorm)
	#bloodthirst,if=buff.enrage.down|rage<50|buff.raging_blow.down
	if BuffExpires(enrage_buff any=1) or Rage() < 50 or BuffExpires(raging_blow_buff) Spell(bloodthirst)
	#execute,if=buff.sudden_death.react
	if BuffPresent(sudden_death_buff) Spell(execute)
	#raging_blow,if=buff.meat_cleaver.stack>=2
	if BuffStacks(meat_cleaver_buff) >= 2 and BuffPresent(raging_blow_buff) Spell(raging_blow)
	#dragon_roar,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(dragon_roar)
	#whirlwind
	Spell(whirlwind)
	#bloodthirst
	Spell(bloodthirst)
	#wild_strike,if=buff.bloodsurge.up
	if BuffPresent(bloodsurge_buff) Spell(wild_strike)
}

AddFunction FurySingleMindedFuryTwoTargetsActions
{
	#bloodbath
	Spell(bloodbath)
	#ravager,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(ravager)
	#dragon_roar,if=buff.bloodbath.up|!talent.bloodbath.enabled
	if BuffPresent(bloodbath_buff) or not Talent(bloodbath_talent) Spell(dragon_roar)
	#bladestorm,if=buff.enrage.up
	if BuffPresent(enrage_buff any=1) Spell(bladestorm)
	#bloodthirst,if=buff.enrage.down|rage<50|buff.raging_blow.down
	if BuffExpires(enrage_buff any=1) or Rage() < 50 or BuffExpires(raging_blow_buff) Spell(bloodthirst)
	#execute,if=target.health.pct<20|buff.sudden_death.react
	if target.HealthPercent() < 20 or BuffPresent(sudden_death_buff) Spell(execute)
	#raging_blow,if=buff.meat_cleaver.up
	if BuffPresent(meat_cleaver_buff) and BuffPresent(raging_blow_buff) Spell(raging_blow)
	#whirlwind,if=!buff.meat_cleaver.up
	if not BuffPresent(meat_cleaver_buff) Spell(whirlwind)
	#wild_strike,if=buff.bloodsurge.up&rage>75
	if BuffPresent(bloodsurge_buff) and Rage() > 75 Spell(wild_strike)
	#bloodthirst
	Spell(bloodthirst)
	#whirlwind,if=rage>rage.max-20
	if Rage() > MaxRage() - 20 Spell(whirlwind)
	#wild_strike,if=buff.bloodsurge.up
	if BuffPresent(bloodsurge_buff) Spell(wild_strike)
}

AddIcon specialization=fury help=main enemies=1
{
	if not InCombat() FurySingleMindedFuryPrecombatActions()
	FurySingleMindedFuryDefaultActions()
}

AddIcon specialization=fury help=aoe
{
	if not InCombat() FurySingleMindedFuryPrecombatActions()
	FurySingleMindedFuryDefaultActions()
}

### Required symbols
# anger_management_talent
# arcane_torrent_rage
# avatar
# battle_stance
# berserker_rage
# berserking
# bladestorm
# blood_fury_ap
# bloodbath
# bloodbath_buff
# bloodbath_talent
# bloodsurge_buff
# bloodthirst
# charge
# draenic_strength_potion
# dragon_roar
# execute
# glyph_of_gag_order
# heroic_leap
# heroic_throw
# impending_victory
# meat_cleaver_buff
# pummel
# quaking_palm
# raging_blow
# raging_blow_buff
# ravager
# recklessness
# recklessness_buff
# shockwave
# siegebreaker
# storm_bolt
# sudden_death_buff
# unquenchable_thirst_talent
# war_stomp
# whirlwind
# wild_strike
]]
	OvaleScripts:RegisterScript("WARRIOR", name, desc, code, "reference")
end
