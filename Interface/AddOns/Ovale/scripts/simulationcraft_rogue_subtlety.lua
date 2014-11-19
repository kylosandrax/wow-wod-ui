local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "SimulationCraft: Rogue_Subtlety_T17M"
	local desc = "[6.0] SimulationCraft: Rogue_Subtlety_T17M"
	local code = [[
# Based on SimulationCraft profile "Rogue_Subtlety_T17M".
#	class=rogue
#	spec=subtlety
#	talents=3111132
#	glyphs=energy/hemorrhaging_veins

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

AddFunction SubtletyDefaultActions
{
	#potion,name=draenic_agility,if=buff.bloodlust.react|target.time_to_die<40
	if BuffPresent(burst_haste_buff any=1) or target.TimeToDie() < 40 UsePotionAgility()
	#kick
	InterruptActions()
	#use_item,slot=trinket2,if=buff.shadow_dance.up
	if BuffPresent(shadow_dance_buff) UseItemActions()
	#blood_fury,if=buff.shadow_dance.up
	if BuffPresent(shadow_dance_buff) Spell(blood_fury_ap)
	#berserking,if=buff.shadow_dance.up
	if BuffPresent(shadow_dance_buff) Spell(berserking)
	#arcane_torrent,if=energy<60
	if Energy() < 60 Spell(arcane_torrent_energy)
	#premeditation,if=combo_points<=4
	if ComboPoints() <= 4 Spell(premeditation)
	#pool_resource,for_next=1
	#ambush,if=combo_points<5|(talent.anticipation.enabled&anticipation_charges<3)|(buff.sleight_of_hand.up&buff.sleight_of_hand.remains<=gcd)
	if ComboPoints() < 5 or Talent(anticipation_talent) and BuffStacks(anticipation_buff) < 3 or BuffPresent(sleight_of_hand_buff) and BuffRemaining(sleight_of_hand_buff) <= GCD() Spell(ambush)
	unless { ComboPoints() < 5 or Talent(anticipation_talent) and BuffStacks(anticipation_buff) < 3 or BuffPresent(sleight_of_hand_buff) and BuffRemaining(sleight_of_hand_buff) <= GCD() } and SpellUsable(ambush) and SpellCooldown(ambush) < TimeToEnergyFor(ambush)
	{
		#pool_resource,for_next=1,extra_amount=75
		#shadow_dance,if=energy>=75&buff.stealth.down&buff.vanish.down&debuff.find_weakness.down
		if Energy() >= 75 and BuffExpires(stealthed_buff any=1) and BuffExpires(vanish_buff) and target.DebuffExpires(find_weakness_debuff) Spell(shadow_dance)
		#Remove any 'Energy() >= 75' condition from the following statement.
		unless Energy() >= 75 and BuffExpires(stealthed_buff any=1) and BuffExpires(vanish_buff) and target.DebuffExpires(find_weakness_debuff) and SpellUsable(shadow_dance) and SpellCooldown(shadow_dance) < TimeToEnergy(75)
		{
			#pool_resource,for_next=1,extra_amount=45
			#vanish,if=energy>=45&energy<=75&combo_points<=3&buff.shadow_dance.down&buff.master_of_subtlety.down&debuff.find_weakness.down
			if Energy() >= 45 and Energy() <= 75 and ComboPoints() <= 3 and BuffExpires(shadow_dance_buff) and BuffExpires(master_of_subtlety_buff) and target.DebuffExpires(find_weakness_debuff) Spell(vanish)
			#Remove any 'Energy() >= 45' condition from the following statement.
			unless Energy() >= 45 and Energy() <= 75 and ComboPoints() <= 3 and BuffExpires(shadow_dance_buff) and BuffExpires(master_of_subtlety_buff) and target.DebuffExpires(find_weakness_debuff) and SpellUsable(vanish) and SpellCooldown(vanish) < TimeToEnergy(45)
			{
				#marked_for_death,if=combo_points=0
				if ComboPoints() == 0 Spell(marked_for_death)
				#shadow_reflection,if=buff.shadow_dance.up
				if BuffPresent(shadow_dance_buff) Spell(shadow_reflection)
				#run_action_list,name=generator,if=talent.anticipation.enabled&anticipation_charges<4&buff.slice_and_dice.up&dot.rupture.remains>2&(buff.slice_and_dice.remains<6|dot.rupture.remains<4)
				if Talent(anticipation_talent) and BuffStacks(anticipation_buff) < 4 and BuffPresent(slice_and_dice_buff) and target.DebuffRemaining(rupture_debuff) > 2 and { BuffRemaining(slice_and_dice_buff) < 6 or target.DebuffRemaining(rupture_debuff) < 4 } SubtletyGeneratorActions()
				#run_action_list,name=finisher,if=combo_points=5
				if ComboPoints() == 5 SubtletyFinisherActions()
				#run_action_list,name=generator,if=combo_points<4|energy>80|talent.anticipation.enabled
				if ComboPoints() < 4 or Energy() > 80 or Talent(anticipation_talent) SubtletyGeneratorActions()
				#run_action_list,name=pool
				SubtletyPoolActions()
			}
		}
	}
}

AddFunction SubtletyFinisherActions
{
	#slice_and_dice,if=buff.slice_and_dice.remains<4
	if BuffRemaining(slice_and_dice_buff) < 4 and BuffRemaining(slice_and_dice_buff) < 0.3 * BaseDuration(slice_and_dice_buff) Spell(slice_and_dice)
	#death_from_above
	Spell(death_from_above)
	#rupture,cycle_targets=1,if=(!ticking|remains<duration*0.3)&active_enemies<=3&(cooldown.death_from_above.remains>0|!talent.death_from_above.enabled)
	if { not target.DebuffPresent(rupture_debuff) or target.DebuffRemaining(rupture_debuff) < BaseDuration(rupture_debuff) * 0.3 } and Enemies() <= 3 and { SpellCooldown(death_from_above) > 0 or not Talent(death_from_above_talent) } Spell(rupture)
	#crimson_tempest,if=(active_enemies>3&dot.crimson_tempest_dot.ticks_remain<=2&combo_points=5)|active_enemies>=5&(cooldown.death_from_above.remains>0|!talent.death_from_above.enabled)
	if Enemies() > 3 and target.TicksRemaining(crimson_tempest_dot_debuff) < 3 and ComboPoints() == 5 or Enemies() >= 5 and { SpellCooldown(death_from_above) > 0 or not Talent(death_from_above_talent) } Spell(crimson_tempest)
	#eviscerate,if=active_enemies<4|(active_enemies>3&dot.crimson_tempest_dot.ticks_remain>=2)&(cooldown.death_from_above.remains>0|!talent.death_from_above.enabled)
	if Enemies() < 4 or Enemies() > 3 and target.TicksRemaining(crimson_tempest_dot_debuff) >= 2 and { SpellCooldown(death_from_above) > 0 or not Talent(death_from_above_talent) } Spell(eviscerate)
	#run_action_list,name=pool
	SubtletyPoolActions()
}

AddFunction SubtletyGeneratorActions
{
	#run_action_list,name=pool,if=buff.master_of_subtlety.down&buff.shadow_dance.down&debuff.find_weakness.down&(energy+cooldown.shadow_dance.remains*energy.regen<80|energy+cooldown.vanish.remains*energy.regen<60)
	if BuffExpires(master_of_subtlety_buff) and BuffExpires(shadow_dance_buff) and target.DebuffExpires(find_weakness_debuff) and { Energy() + SpellCooldown(shadow_dance) * EnergyRegenRate() < 80 or Energy() + SpellCooldown(vanish) * EnergyRegenRate() < 60 } SubtletyPoolActions()
	#fan_of_knives,if=active_enemies>1
	if Enemies() > 1 Spell(fan_of_knives)
	#hemorrhage,if=(remains<8&target.time_to_die>10)|position_front
	if target.DebuffRemaining(hemorrhage_debuff) < 8 and target.TimeToDie() > 10 or False(position_front) Spell(hemorrhage)
	#shuriken_toss,if=energy<65&energy.regen<16
	if Energy() < 65 and EnergyRegenRate() < 16 Spell(shuriken_toss)
	#backstab
	Spell(backstab)
	#run_action_list,name=pool
	SubtletyPoolActions()
}

AddFunction SubtletyPoolActions
{
	#preparation,if=!buff.vanish.up&cooldown.vanish.remains>60
	if not BuffPresent(vanish_buff) and SpellCooldown(vanish) > 60 Spell(preparation)
}

AddFunction SubtletyPrecombatActions
{
	#flask,type=greater_draenic_agility_flask
	#food,type=calamari_crepes
	#apply_poison,lethal=deadly
	if BuffRemaining(lethal_poison_buff) < 1200 Spell(deadly_poison)
	#snapshot_stats
	#potion,name=draenic_agility
	UsePotionAgility()
	#stealth
	if BuffExpires(stealthed_buff any=1) Spell(stealth)
	#premeditation
	Spell(premeditation)
	#slice_and_dice
	if BuffRemaining(slice_and_dice_buff) < 0.3 * BaseDuration(slice_and_dice_buff) Spell(slice_and_dice)
	#honor_among_thieves,cooldown=2.2,cooldown_stddev=0.1
}

AddIcon specialization=subtlety help=main enemies=1
{
	if not InCombat() SubtletyPrecombatActions()
	SubtletyDefaultActions()
}

AddIcon specialization=subtlety help=aoe
{
	if not InCombat() SubtletyPrecombatActions()
	SubtletyDefaultActions()
}

### Required symbols
# ambush
# anticipation_buff
# anticipation_talent
# arcane_torrent_energy
# backstab
# berserking
# blood_fury_ap
# cheap_shot
# crimson_tempest
# crimson_tempest_dot_debuff
# deadly_poison
# deadly_throw
# death_from_above
# death_from_above_talent
# draenic_agility_potion
# eviscerate
# fan_of_knives
# find_weakness_debuff
# hemorrhage
# hemorrhage_debuff
# kick
# kidney_shot
# lethal_poison_buff
# marked_for_death
# master_of_subtlety_buff
# premeditation
# preparation
# quaking_palm
# rupture
# rupture_debuff
# shadow_dance
# shadow_dance_buff
# shadow_reflection
# shadowstep
# shuriken_toss
# sleight_of_hand_buff
# slice_and_dice
# slice_and_dice_buff
# stealth
# vanish
# vanish_buff
]]
	OvaleScripts:RegisterScript("ROGUE", name, desc, code, "reference")
end
