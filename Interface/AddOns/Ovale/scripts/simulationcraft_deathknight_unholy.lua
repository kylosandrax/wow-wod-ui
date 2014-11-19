local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "SimulationCraft: Death_Knight_Unholy_T17M"
	local desc = "[6.0] SimulationCraft: Death_Knight_Unholy_T17M"
	local code = [[
# Based on SimulationCraft profile "Death_Knight_Unholy_T17M".
#	class=deathknight
#	spec=unholy
#	talents=2003002

Include(ovale_common)
Include(ovale_deathknight_spells)

AddCheckBox(opt_potion_strength ItemName(draenic_strength_potion) default)

AddFunction UsePotionStrength
{
	if CheckBoxOn(opt_potion_strength) and target.Classification(worldboss) Item(draenic_strength_potion usable=1)
}

AddFunction InterruptActions
{
	if not target.IsFriend() and target.IsInterruptible()
	{
		if target.InRange(mind_freeze) Spell(mind_freeze)
		if not target.Classification(worldboss)
		{
			if target.InRange(asphyxiate) Spell(asphyxiate)
			if target.InRange(strangulate) Spell(strangulate)
			Spell(arcane_torrent_runicpower)
			if target.InRange(quaking_palm) Spell(quaking_palm)
			Spell(war_stomp)
		}
	}
}

AddFunction UnholyDefaultActions
{
	#auto_attack
	#deaths_advance,if=movement.remains>2
	if 0 > 2 Spell(deaths_advance)
	#antimagic_shell,damage=100000
	if IncomingDamage(1.5) > 0 Spell(antimagic_shell)
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#arcane_torrent
	Spell(arcane_torrent_runicpower)
	#potion,name=draenic_strength,if=buff.dark_transformation.up&target.time_to_die<=60
	if pet.BuffPresent(dark_transformation_buff any=1) and target.TimeToDie() <= 60 UsePotionStrength()
	#run_action_list,name=aoe,if=active_enemies>=2
	if Enemies() >= 2 UnholyAoeActions()
	#run_action_list,name=single_target,if=active_enemies<2
	if Enemies() < 2 UnholySingleTargetActions()
}

AddFunction UnholyAoeActions
{
	#unholy_blight
	Spell(unholy_blight)
	#run_action_list,name=spread,if=!dot.blood_plague.ticking|!dot.frost_fever.ticking
	if not target.DebuffPresent(blood_plague_debuff) or not target.DebuffPresent(frost_fever_debuff) UnholySpreadActions()
	#defile
	Spell(defile)
	#breath_of_sindragosa,if=runic_power>75
	if RunicPower() > 75 Spell(breath_of_sindragosa)
	#run_action_list,name=bos_aoe,if=dot.breath_of_sindragosa.ticking
	if BuffPresent(breath_of_sindragosa_buff) UnholyBosAoeActions()
	#blood_boil,if=blood=2|(frost=2&death=2)
	if Rune(blood) >= 2 or Rune(frost) >= 2 and Rune(death) >= 2 and Rune(death) < 3 Spell(blood_boil)
	#summon_gargoyle
	Spell(summon_gargoyle)
	#dark_transformation
	if BuffStacks(shadow_infusion_buff) >= 5 Spell(dark_transformation)
	#blood_tap,if=buff.shadow_infusion.stack=5
	if BuffStacks(shadow_infusion_buff) == 5 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#defile
	Spell(defile)
	#death_and_decay,if=unholy=1
	if Rune(unholy) >= 1 and Rune(unholy) < 2 Spell(death_and_decay)
	#soul_reaper,if=target.health.pct-3*(target.health.pct%target.time_to_die)<=45
	if target.HealthPercent() - 3 * target.HealthPercent() / target.TimeToDie() <= 45 Spell(soul_reaper_unholy)
	#scourge_strike,if=unholy=2
	if Rune(unholy) >= 2 Spell(scourge_strike)
	#blood_tap,if=buff.blood_charge.stack>10
	if BuffStacks(blood_charge_buff) > 10 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#death_coil,if=runic_power>90|buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1)
	if RunicPower() > 90 or BuffPresent(sudden_doom_buff) or pet.BuffExpires(dark_transformation_buff any=1) and Rune(unholy) < 2 Spell(death_coil)
	#blood_boil
	Spell(blood_boil)
	#icy_touch
	Spell(icy_touch)
	#scourge_strike,if=unholy=1
	if Rune(unholy) >= 1 and Rune(unholy) < 2 Spell(scourge_strike)
	#death_coil
	Spell(death_coil)
	#blood_tap
	if BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#plague_leech
	if target.DiseasesTicking() and { Rune(blood) < 1 or Rune(frost) < 1 or Rune(unholy) < 1 } Spell(plague_leech)
	#empower_rune_weapon
	Spell(empower_rune_weapon)
}

AddFunction UnholyBosAoeActions
{
	#death_and_decay,if=runic_power<88
	if RunicPower() < 88 Spell(death_and_decay)
	#blood_boil,if=runic_power<88
	if RunicPower() < 88 Spell(blood_boil)
	#scourge_strike,if=runic_power<88&unholy=1
	if RunicPower() < 88 and Rune(unholy) >= 1 and Rune(unholy) < 2 Spell(scourge_strike)
	#icy_touch,if=runic_power<88
	if RunicPower() < 88 Spell(icy_touch)
	#blood_tap,if=buff.blood_charge.stack>=5
	if BuffStacks(blood_charge_buff) >= 5 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#plague_leech
	if target.DiseasesTicking() and { Rune(blood) < 1 or Rune(frost) < 1 or Rune(unholy) < 1 } Spell(plague_leech)
	#empower_rune_weapon
	Spell(empower_rune_weapon)
	#death_coil,if=buff.sudden_doom.react
	if BuffPresent(sudden_doom_buff) Spell(death_coil)
}

AddFunction UnholyBosStActions
{
	#death_and_decay,if=runic_power<88
	if RunicPower() < 88 Spell(death_and_decay)
	#festering_strike,if=runic_power<77
	if RunicPower() < 77 Spell(festering_strike)
	#scourge_strike,if=runic_power<88
	if RunicPower() < 88 Spell(scourge_strike)
	#blood_tap,if=buff.blood_charge.stack>=5
	if BuffStacks(blood_charge_buff) >= 5 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#plague_leech
	if target.DiseasesTicking() and { Rune(blood) < 1 or Rune(frost) < 1 or Rune(unholy) < 1 } Spell(plague_leech)
	#empower_rune_weapon
	Spell(empower_rune_weapon)
	#death_coil,if=buff.sudden_doom.react
	if BuffPresent(sudden_doom_buff) Spell(death_coil)
}

AddFunction UnholyPrecombatActions
{
	#flask,type=greater_draenic_strength_flask
	#food,type=calamari_crepes
	#horn_of_winter
	if BuffExpires(attack_power_multiplier_buff any=1) Spell(horn_of_winter)
	#unholy_presence
	Spell(unholy_presence)
	#snapshot_stats
	#army_of_the_dead
	Spell(army_of_the_dead)
	#potion,name=draenic_strength
	UsePotionStrength()
	#raise_dead
	Spell(raise_dead)
}

AddFunction UnholySingleTargetActions
{
	#plague_leech,if=cooldown.outbreak.remains<1
	if SpellCooldown(outbreak) < 1 and target.DiseasesTicking() and { Rune(blood) < 1 or Rune(frost) < 1 or Rune(unholy) < 1 } Spell(plague_leech)
	#plague_leech,if=!talent.necrotic_plague.enabled&(dot.blood_plague.remains<1&dot.frost_fever.remains<1)
	if not Talent(necrotic_plague_talent) and target.DebuffRemaining(blood_plague_debuff) < 1 and target.DebuffRemaining(frost_fever_debuff) < 1 and target.DiseasesTicking() and { Rune(blood) < 1 or Rune(frost) < 1 or Rune(unholy) < 1 } Spell(plague_leech)
	#plague_leech,if=talent.necrotic_plague.enabled&(dot.necrotic_plague.remains<1)
	if Talent(necrotic_plague_talent) and target.DebuffRemaining(necrotic_plague_debuff) < 1 and target.DiseasesTicking() and { Rune(blood) < 1 or Rune(frost) < 1 or Rune(unholy) < 1 } Spell(plague_leech)
	#soul_reaper,if=target.health.pct-3*(target.health.pct%target.time_to_die)<=45
	if target.HealthPercent() - 3 * target.HealthPercent() / target.TimeToDie() <= 45 Spell(soul_reaper_unholy)
	#blood_tap,if=(target.health.pct-3*(target.health.pct%target.time_to_die)<=45&cooldown.soul_reaper.remains=0)
	if target.HealthPercent() - 3 * target.HealthPercent() / target.TimeToDie() <= 45 and not SpellCooldown(soul_reaper_unholy) > 0 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#summon_gargoyle
	Spell(summon_gargoyle)
	#death_coil,if=runic_power>90
	if RunicPower() > 90 Spell(death_coil)
	#defile
	Spell(defile)
	#dark_transformation
	if BuffStacks(shadow_infusion_buff) >= 5 Spell(dark_transformation)
	#unholy_blight,if=!talent.necrotic_plague.enabled&(dot.frost_fever.remains<3|dot.blood_plague.remains<3)
	if not Talent(necrotic_plague_talent) and { target.DebuffRemaining(frost_fever_debuff) < 3 or target.DebuffRemaining(blood_plague_debuff) < 3 } Spell(unholy_blight)
	#unholy_blight,if=talent.necrotic_plague.enabled&dot.necrotic_plague.remains<1
	if Talent(necrotic_plague_talent) and target.DebuffRemaining(necrotic_plague_debuff) < 1 Spell(unholy_blight)
	#outbreak,if=!talent.necrotic_plague.enabled&(!dot.frost_fever.ticking|!dot.blood_plague.ticking)
	if not Talent(necrotic_plague_talent) and { not target.DebuffPresent(frost_fever_debuff) or not target.DebuffPresent(blood_plague_debuff) } Spell(outbreak)
	#outbreak,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
	if Talent(necrotic_plague_talent) and not target.DebuffPresent(necrotic_plague_debuff) Spell(outbreak)
	#plague_strike,if=!talent.necrotic_plague.enabled&(!dot.blood_plague.ticking|!dot.frost_fever.ticking)
	if not Talent(necrotic_plague_talent) and { not target.DebuffPresent(blood_plague_debuff) or not target.DebuffPresent(frost_fever_debuff) } Spell(plague_strike)
	#plague_strike,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
	if Talent(necrotic_plague_talent) and not target.DebuffPresent(necrotic_plague_debuff) Spell(plague_strike)
	#breath_of_sindragosa,if=runic_power>75
	if RunicPower() > 75 Spell(breath_of_sindragosa)
	#run_action_list,name=bos_st,if=dot.breath_of_sindragosa.ticking
	if BuffPresent(breath_of_sindragosa_buff) UnholyBosStActions()
	#death_and_decay,if=cooldown.breath_of_sindragosa.remains<7&runic_power<88&talent.breath_of_sindragosa.enabled
	if SpellCooldown(breath_of_sindragosa) < 7 and RunicPower() < 88 and Talent(breath_of_sindragosa_talent) Spell(death_and_decay)
	#scourge_strike,if=cooldown.breath_of_sindragosa.remains<7&runic_power<88&talent.breath_of_sindragosa.enabled
	if SpellCooldown(breath_of_sindragosa) < 7 and RunicPower() < 88 and Talent(breath_of_sindragosa_talent) Spell(scourge_strike)
	#festering_strike,if=cooldown.breath_of_sindragosa.remains<7&runic_power<76&talent.breath_of_sindragosa.enabled
	if SpellCooldown(breath_of_sindragosa) < 7 and RunicPower() < 76 and Talent(breath_of_sindragosa_talent) Spell(festering_strike)
	#death_and_decay,if=unholy=2
	if Rune(unholy) >= 2 Spell(death_and_decay)
	#blood_tap,if=unholy=2&cooldown.death_and_decay.remains=0
	if Rune(unholy) >= 2 and not SpellCooldown(death_and_decay) > 0 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#scourge_strike,if=unholy=2
	if Rune(unholy) >= 2 Spell(scourge_strike)
	#death_coil,if=runic_power>80
	if RunicPower() > 80 Spell(death_coil)
	#festering_strike,if=blood=2&frost=2
	if Rune(blood) >= 2 and Rune(frost) >= 2 Spell(festering_strike)
	#death_and_decay
	Spell(death_and_decay)
	#blood_tap,if=cooldown.death_and_decay.remains=0
	if not SpellCooldown(death_and_decay) > 0 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#blood_tap,if=buff.blood_charge.stack>10&(buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1))
	if BuffStacks(blood_charge_buff) > 10 and { BuffPresent(sudden_doom_buff) or pet.BuffExpires(dark_transformation_buff any=1) and Rune(unholy) < 2 } and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#death_coil,if=buff.sudden_doom.react|(buff.dark_transformation.down&rune.unholy<=1)
	if BuffPresent(sudden_doom_buff) or pet.BuffExpires(dark_transformation_buff any=1) and Rune(unholy) < 2 Spell(death_coil)
	#scourge_strike,if=!(target.health.pct-3*(target.health.pct%target.time_to_die)<=45)|(unholy>=1&death>=1)|(death>=2)
	if not target.HealthPercent() - 3 * target.HealthPercent() / target.TimeToDie() <= 45 or Rune(unholy) >= 1 and Rune(death) >= 1 or Rune(death) >= 2 Spell(scourge_strike)
	#festering_strike
	Spell(festering_strike)
	#blood_tap,if=buff.blood_charge.stack>=10&runic_power>=30
	if BuffStacks(blood_charge_buff) >= 10 and RunicPower() >= 30 and BuffStacks(blood_charge_buff) >= 5 Spell(blood_tap)
	#death_coil
	Spell(death_coil)
	#empower_rune_weapon
	Spell(empower_rune_weapon)
}

AddFunction UnholySpreadActions
{
	#blood_boil,cycle_targets=1,if=dot.blood_plague.ticking|dot.frost_fever.ticking
	if target.DebuffPresent(blood_plague_debuff) or target.DebuffPresent(frost_fever_debuff) Spell(blood_boil)
	#outbreak,if=!talent.necrotic_plague.enabled&(!dot.blood_plague.ticking|!dot.frost_fever.ticking)
	if not Talent(necrotic_plague_talent) and { not target.DebuffPresent(blood_plague_debuff) or not target.DebuffPresent(frost_fever_debuff) } Spell(outbreak)
	#outbreak,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
	if Talent(necrotic_plague_talent) and not target.DebuffPresent(necrotic_plague_debuff) Spell(outbreak)
	#plague_strike,if=!talent.necrotic_plague.enabled&(!dot.blood_plague.ticking|!dot.frost_fever.ticking)
	if not Talent(necrotic_plague_talent) and { not target.DebuffPresent(blood_plague_debuff) or not target.DebuffPresent(frost_fever_debuff) } Spell(plague_strike)
	#plague_strike,if=talent.necrotic_plague.enabled&!dot.necrotic_plague.ticking
	if Talent(necrotic_plague_talent) and not target.DebuffPresent(necrotic_plague_debuff) Spell(plague_strike)
}

AddIcon specialization=unholy help=main enemies=1
{
	if not InCombat() UnholyPrecombatActions()
	UnholyDefaultActions()
}

AddIcon specialization=unholy help=aoe
{
	if not InCombat() UnholyPrecombatActions()
	UnholyDefaultActions()
}

### Required symbols
# antimagic_shell
# arcane_torrent_runicpower
# army_of_the_dead
# asphyxiate
# berserking
# blood_boil
# blood_charge_buff
# blood_fury_ap
# blood_plague_debuff
# blood_tap
# breath_of_sindragosa
# breath_of_sindragosa_buff
# breath_of_sindragosa_talent
# dark_transformation
# dark_transformation_buff
# death_and_decay
# death_coil
# deaths_advance
# defile
# draenic_strength_potion
# empower_rune_weapon
# festering_strike
# frost_fever_debuff
# horn_of_winter
# icy_touch
# mind_freeze
# necrotic_plague_debuff
# necrotic_plague_talent
# outbreak
# plague_leech
# plague_strike
# quaking_palm
# raise_dead
# scourge_strike
# shadow_infusion_buff
# soul_reaper_unholy
# strangulate
# sudden_doom_buff
# summon_gargoyle
# unholy_blight
# unholy_presence
# war_stomp
]]
	OvaleScripts:RegisterScript("DEATHKNIGHT", name, desc, code, "reference")
end
