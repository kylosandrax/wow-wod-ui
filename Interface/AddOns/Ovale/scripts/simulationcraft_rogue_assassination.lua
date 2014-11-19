local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "SimulationCraft: Rogue_Assassination_T17M"
	local desc = "[6.0] SimulationCraft: Rogue_Assassination_T17M"
	local code = [[
# Based on SimulationCraft profile "Rogue_Assassination_T17M".
#	class=rogue
#	spec=assassination
#	talents=3000032
#	glyphs=vendetta/energy/disappearance

Include(ovale_common)
Include(ovale_rogue_spells)

AddCheckBox(opt_potion_agility ItemName(draenic_agility_potion) default)

AddFunction UsePotionAgility
{
	if CheckBoxOn(opt_potion_agility) and target.Classification(worldboss) Item(draenic_agility_potion usable=1)
}

AddFunction UseItemActions
{
	Item(HandSlot usable=1)
	Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
}

AddFunction GetInMeleeRange
{
	if not target.InRange(kick)
	{
		Spell(shadowstep)
		Texture(misc_arrowlup help=L(not_in_melee_range))
	}
}

AddFunction InterruptActions
{
	if not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(kick) Spell(kick)
		if not target.Classification(worldboss)
		{
			if target.InRange(cheap_shot) Spell(cheap_shot)
			if target.InRange(deadly_throw) and ComboPoints() == 5 Spell(deadly_throw)
			if target.InRange(kidney_shot) Spell(kidney_shot)
			Spell(arcane_torrent_energy)
			if target.InRange(quaking_palm) Spell(quaking_palm)
		}
	}
}

AddFunction AssassinationDefaultActions
{
	#potion,name=draenic_agility,if=buff.bloodlust.react|target.time_to_die<40
	if BuffPresent(burst_haste_buff any=1) or target.TimeToDie() < 40 UsePotionAgility()
	#kick
	InterruptActions()
	#preparation,if=!buff.vanish.up&cooldown.vanish.remains>60
	if not BuffPresent(vanish_buff) and SpellCooldown(vanish) > 60 Spell(preparation)
	#use_item,slot=trinket2,if=active_enemies>1|(debuff.vendetta.up&active_enemies=1)
	if Enemies() > 1 or target.DebuffPresent(vendetta_debuff) and Enemies() == 1 UseItemActions()
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#arcane_torrent,if=energy<60
	if Energy() < 60 Spell(arcane_torrent_energy)
	#vanish,if=time>10&!buff.stealth.up
	if TimeInCombat() > 10 and not BuffPresent(stealthed_buff any=1) Spell(vanish)
	#rupture,if=combo_points=5&ticks_remain<3
	if ComboPoints() == 5 and target.TicksRemaining(rupture_debuff) < 3 Spell(rupture)
	#rupture,cycle_targets=1,if=active_enemies>1&!ticking&combo_points=5
	if Enemies() > 1 and not target.DebuffPresent(rupture_debuff) and ComboPoints() == 5 Spell(rupture)
	#mutilate,if=buff.stealth.up
	if BuffPresent(stealthed_buff any=1) Spell(mutilate)
	#slice_and_dice,if=buff.slice_and_dice.remains<5
	if BuffRemaining(slice_and_dice_buff) < 5 Spell(slice_and_dice)
	#marked_for_death,if=combo_points=0
	if ComboPoints() == 0 Spell(marked_for_death)
	#crimson_tempest,if=combo_points>4&active_enemies>=4&remains<8
	if ComboPoints() > 4 and Enemies() >= 4 and target.DebuffRemaining(crimson_tempest_debuff) < 8 Spell(crimson_tempest)
	#fan_of_knives,if=combo_points<5&active_enemies>=4
	if ComboPoints() < 5 and Enemies() >= 4 Spell(fan_of_knives)
	#rupture,if=(remains<2|(combo_points=5&remains<=(duration*0.3)))&active_enemies=1
	if { target.DebuffRemaining(rupture_debuff) < 2 or ComboPoints() == 5 and target.DebuffRemaining(rupture_debuff) <= BaseDuration(rupture_debuff) * 0.3 } and Enemies() == 1 Spell(rupture)
	#shadow_reflection,if=cooldown.vendetta.remains=0
	if not SpellCooldown(vendetta) > 0 Spell(shadow_reflection)
	#vendetta,if=buff.shadow_reflection.up|!talent.shadow_reflection.enabled
	if BuffPresent(shadow_reflection_buff) or not Talent(shadow_reflection_talent) Spell(vendetta)
	#envenom,cycle_targets=1,if=(combo_points>4&buff.envenom.remains<2&(cooldown.death_from_above.remains>2|!talent.death_from_above.enabled))&active_enemies<4&!dot.deadly_poison_dot.ticking
	if ComboPoints() > 4 and BuffRemaining(envenom_buff) < 2 and { SpellCooldown(death_from_above) > 2 or not Talent(death_from_above_talent) } and Enemies() < 4 and not target.DebuffPresent(deadly_poison_dot_debuff) Spell(envenom)
	#envenom,if=(combo_points>4&buff.envenom.remains<2&(cooldown.death_from_above.remains>2|!talent.death_from_above.enabled))&active_enemies<4
	if ComboPoints() > 4 and BuffRemaining(envenom_buff) < 2 and { SpellCooldown(death_from_above) > 2 or not Talent(death_from_above_talent) } and Enemies() < 4 Spell(envenom)
	#fan_of_knives,cycle_targets=1,if=active_enemies>2&!dot.deadly_poison_dot.ticking&debuff.vendetta.down
	if Enemies() > 2 and not target.DebuffPresent(deadly_poison_dot_debuff) and target.DebuffExpires(vendetta_debuff) Spell(fan_of_knives)
	#mutilate,cycle_targets=1,if=target.health.pct>35&combo_points<5&active_enemies=2&!dot.deadly_poison_dot.ticking&debuff.vendetta.down
	if target.HealthPercent() > 35 and ComboPoints() < 5 and Enemies() == 2 and not target.DebuffPresent(deadly_poison_dot_debuff) and target.DebuffExpires(vendetta_debuff) Spell(mutilate)
	#mutilate,if=target.health.pct>35&combo_points<5&active_enemies<5
	if target.HealthPercent() > 35 and ComboPoints() < 5 and Enemies() < 5 Spell(mutilate)
	#dispatch,cycle_targets=1,if=(combo_points<5|(talent.anticipation.enabled&anticipation_charges<4))&active_enemies=2&!dot.deadly_poison_dot.ticking&debuff.vendetta.down
	if { ComboPoints() < 5 or Talent(anticipation_talent) and BuffStacks(anticipation_buff) < 4 } and Enemies() == 2 and not target.DebuffPresent(deadly_poison_dot_debuff) and target.DebuffExpires(vendetta_debuff) Spell(dispatch)
	#dispatch,if=(combo_points<5|(talent.anticipation.enabled&anticipation_charges<4))&active_enemies<4
	if { ComboPoints() < 5 or Talent(anticipation_talent) and BuffStacks(anticipation_buff) < 4 } and Enemies() < 4 Spell(dispatch)
	#mutilate,cycle_targets=1,if=active_enemies=2&!dot.deadly_poison_dot.ticking&debuff.vendetta.down
	if Enemies() == 2 and not target.DebuffPresent(deadly_poison_dot_debuff) and target.DebuffExpires(vendetta_debuff) Spell(mutilate)
	#mutilate,if=active_enemies<5
	if Enemies() < 5 Spell(mutilate)
}

AddFunction AssassinationPrecombatActions
{
	#flask,type=greater_draenic_agility_flask
	#food,type=sleeper_surprise
	#apply_poison,lethal=deadly
	if BuffRemaining(lethal_poison_buff) < 1200 Spell(deadly_poison)
	#snapshot_stats
	#potion,name=draenic_agility
	UsePotionAgility()
	#stealth
	if BuffExpires(stealthed_buff any=1) Spell(stealth)
	#marked_for_death
	Spell(marked_for_death)
	#slice_and_dice,if=talent.marked_for_death.enabled
	if Talent(marked_for_death_talent) Spell(slice_and_dice)
}

AddIcon specialization=assassination help=main enemies=1
{
	if not InCombat() AssassinationPrecombatActions()
	AssassinationDefaultActions()
}

AddIcon specialization=assassination help=aoe
{
	if not InCombat() AssassinationPrecombatActions()
	AssassinationDefaultActions()
}

### Required symbols
# anticipation_buff
# anticipation_talent
# arcane_torrent_energy
# berserking
# blood_fury_ap
# cheap_shot
# crimson_tempest
# crimson_tempest_debuff
# deadly_poison
# deadly_poison_dot_debuff
# deadly_throw
# death_from_above
# death_from_above_talent
# dispatch
# draenic_agility_potion
# envenom
# envenom_buff
# fan_of_knives
# kick
# kidney_shot
# lethal_poison_buff
# marked_for_death
# marked_for_death_talent
# mutilate
# preparation
# quaking_palm
# rupture
# rupture_debuff
# shadow_reflection
# shadow_reflection_buff
# shadow_reflection_talent
# shadowstep
# slice_and_dice
# slice_and_dice_buff
# stealth
# vanish
# vanish_buff
# vendetta
# vendetta_debuff
]]
	OvaleScripts:RegisterScript("ROGUE", name, desc, code, "reference")
end
