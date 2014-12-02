local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "SimulationCraft: Warlock_Demonology_T17M"
	local desc = "[6.0] SimulationCraft: Warlock_Demonology_T17M"
	local code = [[
# Based on SimulationCraft profile "Warlock_Demonology_T17M".
#	class=warlock
#	spec=demonology
#	talents=0000111
#	glyphs=dark_soul
#	pet=felguard

Include(ovale_common)
Include(ovale_warlock_spells)

AddCheckBox(opt_potion_intellect ItemName(draenic_intellect_potion) default)

AddFunction UsePotionIntellect
{
	if CheckBoxOn(opt_potion_intellect) and target.Classification(worldboss) Item(draenic_intellect_potion usable=1)
}

AddFunction DemonologyDefaultActions
{
	#potion,name=draenic_intellect,if=buff.bloodlust.react|(buff.dark_soul.up&(trinket.proc.any.react|trinket.stacking_proc.any.react>6)&!buff.demonbolt.remains)|target.health.pct<20
	if BuffPresent(burst_haste_buff any=1) or BuffPresent(dark_soul_knowledge_buff) and { BuffPresent(trinket_proc_any_buff) or BuffStacks(trinket_stacking_proc_any_buff) > 6 } and not BuffPresent(demonbolt_buff) or target.HealthPercent() < 20 UsePotionIntellect()
	#berserking
	Spell(berserking)
	#blood_fury
	Spell(blood_fury_sp)
	#arcane_torrent
	Spell(arcane_torrent_mana)
	#mannoroths_fury
	Spell(mannoroths_fury)
	#dark_soul,if=talent.demonbolt.enabled&(charges=2|target.time_to_die<buff.demonbolt.remains|(!buff.demonbolt.remains&demonic_fury>=790))
	if Talent(demonbolt_talent) and { Charges(dark_soul_knowledge) == 2 or target.TimeToDie() < BuffRemaining(demonbolt_buff) or not BuffPresent(demonbolt_buff) and DemonicFury() >= 790 } Spell(dark_soul_knowledge)
	#dark_soul,if=!talent.demonbolt.enabled&(charges=2|!talent.archimondes_darkness.enabled|(target.time_to_die<=20&!glyph.dark_soul.enabled|target.time_to_die<=10)|(target.time_to_die<=60&demonic_fury>400)|((trinket.stacking_proc.multistrike.remains>7.5|trinket.proc.any.remains>7.5)&demonic_fury>=400))
	if not Talent(demonbolt_talent) and { Charges(dark_soul_knowledge) == 2 or not Talent(archimondes_darkness_talent) or target.TimeToDie() <= 20 and not Glyph(glyph_of_dark_soul) or target.TimeToDie() <= 10 or target.TimeToDie() <= 60 and DemonicFury() > 400 or { BuffRemaining(trinket_stacking_proc_multistrike_buff) > 7.5 or BuffRemaining(trinket_proc_any_buff) > 7.5 } and DemonicFury() >= 400 } Spell(dark_soul_knowledge)
	#imp_swarm,if=(buff.dark_soul.up|(cooldown.dark_soul.remains>(120%(1%spell_haste)))|time_to_die<32)&time>3
	if { BuffPresent(dark_soul_knowledge_buff) or SpellCooldown(dark_soul_knowledge) > 120 / { 1 / { SpellHaste() / 100 } } or TimeToDie() < 32 } and TimeInCombat() > 3 Spell(imp_swarm)
	#felguard:felstorm
	if pet.Present() and pet.CreatureFamily(Felguard) Spell(felguard_felstorm)
	#wrathguard:wrathstorm
	if pet.Present() and pet.CreatureFamily(Wrathguard) Spell(wrathguard_wrathstorm)
	#hand_of_guldan,if=!in_flight&dot.shadowflame.remains<travel_time+action.shadow_bolt.cast_time&(((set_bonus.tier17_4pc=0&((charges=1&recharge_time<4)|charges=2))|(charges=3|(charges=2&recharge_time<13.8-travel_time*2))&(cooldown.cataclysm.remains>dot.shadowflame.duration|!talent.cataclysm.enabled)&cooldown.dark_soul.remains>dot.shadowflame.duration)|dot.shadowflame.remains>travel_time)
	if not InFlightToTarget(hand_of_guldan) and target.DebuffRemaining(shadowflame_debuff) < MaxTravelTime(hand_of_guldan) + CastTime(shadow_bolt) and { ArmorSetBonus(T17 4) == 0 and { Charges(hand_of_guldan) == 1 and SpellChargeCooldown(hand_of_guldan) < 4 or Charges(hand_of_guldan) == 2 } or { Charges(hand_of_guldan) == 3 or Charges(hand_of_guldan) == 2 and SpellChargeCooldown(hand_of_guldan) < 13.8 - MaxTravelTime(hand_of_guldan) * 2 } and { SpellCooldown(cataclysm) > target.DebuffDuration(shadowflame_debuff) or not Talent(cataclysm_talent) } and SpellCooldown(dark_soul_knowledge) > target.DebuffDuration(shadowflame_debuff) or target.DebuffRemaining(shadowflame_debuff) > MaxTravelTime(hand_of_guldan) } Spell(hand_of_guldan)
	#hand_of_guldan,if=!in_flight&dot.shadowflame.remains<travel_time+action.shadow_bolt.cast_time&talent.demonbolt.enabled&((set_bonus.tier17_4pc=0&((charges=1&recharge_time<4)|charges=2))|(charges=3|(charges=2&recharge_time<13.8-travel_time*2))|dot.shadowflame.remains>travel_time)
	if not InFlightToTarget(hand_of_guldan) and target.DebuffRemaining(shadowflame_debuff) < MaxTravelTime(hand_of_guldan) + CastTime(shadow_bolt) and Talent(demonbolt_talent) and { ArmorSetBonus(T17 4) == 0 and { Charges(hand_of_guldan) == 1 and SpellChargeCooldown(hand_of_guldan) < 4 or Charges(hand_of_guldan) == 2 } or Charges(hand_of_guldan) == 3 or Charges(hand_of_guldan) == 2 and SpellChargeCooldown(hand_of_guldan) < 13.8 - MaxTravelTime(hand_of_guldan) * 2 or target.DebuffRemaining(shadowflame_debuff) > MaxTravelTime(hand_of_guldan) } Spell(hand_of_guldan)
	#hand_of_guldan,if=!in_flight&dot.shadowflame.remains<travel_time+3&buff.demonbolt.remains<gcd*2&charges>=2&action.dark_soul.charges>=1
	if not InFlightToTarget(hand_of_guldan) and target.DebuffRemaining(shadowflame_debuff) < MaxTravelTime(hand_of_guldan) + 3 and BuffRemaining(demonbolt_buff) < GCD() * 2 and Charges(hand_of_guldan) >= 2 and Charges(dark_soul_knowledge) >= 1 Spell(hand_of_guldan)
	#service_pet,if=talent.grimoire_of_service.enabled
	if Talent(grimoire_of_service_talent) Spell(grimoire_felguard)
	#summon_doomguard,if=!talent.demonic_servitude.enabled&active_enemies<5
	if not Talent(demonic_servitude_talent) and Enemies() < 5 Spell(summon_doomguard)
	#summon_infernal,if=!talent.demonic_servitude.enabled&active_enemies>=5
	if not Talent(demonic_servitude_talent) and Enemies() >= 5 Spell(summon_infernal)
	#call_action_list,name=db,if=talent.demonbolt.enabled
	if Talent(demonbolt_talent) DemonologyDbActions()
	#immolation_aura,if=demonic_fury>450&active_enemies>=5&buff.immolation_aura.down
	if DemonicFury() > 450 and Enemies() >= 5 and BuffExpires(immolation_aura_buff) Spell(immolation_aura)
	#cataclysm,if=buff.metamorphosis.up
	if BuffPresent(metamorphosis_buff) Spell(cataclysm)
	#doom,if=buff.metamorphosis.up&target.time_to_die>=30*spell_haste&remains<=(duration*0.3)&(remains<cooldown.cataclysm.remains|!talent.cataclysm.enabled)&(buff.dark_soul.down|!glyph.dark_soul.enabled)&trinket.stacking_proc.multistrike.react<10
	if BuffPresent(metamorphosis_buff) and target.TimeToDie() >= 30 * SpellHaste() / 100 and target.DebuffRemaining(doom_debuff) <= BaseDuration(doom_debuff) * 0.3 and { target.DebuffRemaining(doom_debuff) < SpellCooldown(cataclysm) or not Talent(cataclysm_talent) } and { BuffExpires(dark_soul_knowledge_buff) or not Glyph(glyph_of_dark_soul) } and BuffStacks(trinket_stacking_proc_multistrike_buff) < 10 Spell(doom)
	#corruption,cycle_targets=1,if=target.time_to_die>=6&remains<=(0.3*duration)&buff.metamorphosis.down
	if target.TimeToDie() >= 6 and target.DebuffRemaining(corruption_debuff) <= 0.3 * BaseDuration(corruption_debuff) and BuffExpires(metamorphosis_buff) Spell(corruption)
	#cancel_metamorphosis,if=buff.metamorphosis.up&((demonic_fury<650&!glyph.dark_soul.enabled)|demonic_fury<450)&buff.dark_soul.down&(trinket.stacking_proc.multistrike.down&trinket.proc.any.down|demonic_fury<(800-cooldown.dark_soul.remains*(10%spell_haste)))&target.time_to_die>20
	if BuffPresent(metamorphosis_buff) and { DemonicFury() < 650 and not Glyph(glyph_of_dark_soul) or DemonicFury() < 450 } and BuffExpires(dark_soul_knowledge_buff) and { BuffExpires(trinket_stacking_proc_multistrike_buff) and BuffExpires(trinket_proc_any_buff) or DemonicFury() < 800 - SpellCooldown(dark_soul_knowledge) * 10 / { SpellHaste() / 100 } } and target.TimeToDie() > 20 and BuffPresent(metamorphosis_buff) Spell(metamorphosis text=cancel)
	#cancel_metamorphosis,if=buff.metamorphosis.up&action.hand_of_guldan.charges>0&dot.shadowflame.remains<action.hand_of_guldan.travel_time+action.shadow_bolt.cast_time&demonic_fury<100&buff.dark_soul.remains>10
	if BuffPresent(metamorphosis_buff) and Charges(hand_of_guldan) > 0 and target.DebuffRemaining(shadowflame_debuff) < MaxTravelTime(hand_of_guldan) + CastTime(shadow_bolt) and DemonicFury() < 100 and BuffRemaining(dark_soul_knowledge_buff) > 10 and BuffPresent(metamorphosis_buff) Spell(metamorphosis text=cancel)
	#cancel_metamorphosis,if=buff.metamorphosis.up&action.hand_of_guldan.charges=3&(!buff.dark_soul.remains>gcd|action.metamorphosis.cooldown<gcd)
	if BuffPresent(metamorphosis_buff) and Charges(hand_of_guldan) == 3 and { not BuffRemaining(dark_soul_knowledge_buff) > GCD() or SpellCooldown(metamorphosis) < GCD() } and BuffPresent(metamorphosis_buff) Spell(metamorphosis text=cancel)
	#chaos_wave,if=buff.metamorphosis.up&(set_bonus.tier17_4pc=0&charges=2)|charges=3
	if BuffPresent(metamorphosis_buff) and ArmorSetBonus(T17 4) == 0 and Charges(chaos_wave) == 2 or Charges(chaos_wave) == 3 Spell(chaos_wave)
	#soul_fire,if=buff.metamorphosis.up&buff.molten_core.react&(buff.dark_soul.remains>execute_time|target.health.pct<=25)&(((buff.molten_core.stack*execute_time>=trinket.stacking_proc.multistrike.remains-1|demonic_fury<=ceil((trinket.stacking_proc.multistrike.remains-buff.molten_core.stack*execute_time)*40)+80*buff.molten_core.stack)|target.health.pct<=25)&trinket.stacking_proc.multistrike.remains>=execute_time|trinket.stacking_proc.multistrike.down|!trinket.has_stacking_proc.multistrike)
	if BuffPresent(metamorphosis_buff) and BuffPresent(molten_core_buff) and { BuffRemaining(dark_soul_knowledge_buff) > ExecuteTime(soul_fire) or target.HealthPercent() <= 25 } and { { BuffStacks(molten_core_buff) * ExecuteTime(soul_fire) >= BuffRemaining(trinket_stacking_proc_multistrike_buff) - 1 or DemonicFury() <= { BuffRemaining(trinket_stacking_proc_multistrike_buff) - BuffStacks(molten_core_buff) * ExecuteTime(soul_fire) } * 40 + 80 * BuffStacks(molten_core_buff) or target.HealthPercent() <= 25 } and BuffRemaining(trinket_stacking_proc_multistrike_buff) >= ExecuteTime(soul_fire) or BuffExpires(trinket_stacking_proc_multistrike_buff) or not True(trinket_has_stacking_proc_multistrike) } Spell(soul_fire)
	#touch_of_chaos,if=buff.metamorphosis.up
	if BuffPresent(metamorphosis_buff) Spell(touch_of_chaos)
	#metamorphosis,if=buff.dark_soul.remains>gcd&(demonic_fury>300|!glyph.dark_soul.enabled)&(demonic_fury>=80&buff.molten_core.stack>=1|demonic_fury>=40)
	if BuffRemaining(dark_soul_knowledge_buff) > GCD() and { DemonicFury() > 300 or not Glyph(glyph_of_dark_soul) } and { DemonicFury() >= 80 and BuffStacks(molten_core_buff) >= 1 or DemonicFury() >= 40 } Spell(metamorphosis)
	#metamorphosis,if=(trinket.stacking_proc.multistrike.react|trinket.proc.any.react)&((demonic_fury>450&action.dark_soul.recharge_time>=10&glyph.dark_soul.enabled)|(demonic_fury>650&cooldown.dark_soul.remains>=10))
	if { BuffPresent(trinket_stacking_proc_multistrike_buff) or BuffPresent(trinket_proc_any_buff) } and { DemonicFury() > 450 and SpellChargeCooldown(dark_soul_knowledge) >= 10 and Glyph(glyph_of_dark_soul) or DemonicFury() > 650 and SpellCooldown(dark_soul_knowledge) >= 10 } Spell(metamorphosis)
	#metamorphosis,if=!cooldown.cataclysm.remains&talent.cataclysm.enabled
	if not SpellCooldown(cataclysm) > 0 and Talent(cataclysm_talent) Spell(metamorphosis)
	#metamorphosis,if=!dot.doom.ticking&target.time_to_die>=30%(1%spell_haste)&demonic_fury>300
	if not target.DebuffPresent(doom_debuff) and target.TimeToDie() >= 30 / { 1 / { SpellHaste() / 100 } } and DemonicFury() > 300 Spell(metamorphosis)
	#metamorphosis,if=(demonic_fury>750&(action.hand_of_guldan.charges=0|(!dot.shadowflame.ticking&!action.hand_of_guldan.in_flight_to_target)))|floor(demonic_fury%80)*action.soul_fire.execute_time>=target.time_to_die
	if DemonicFury() > 750 and { Charges(hand_of_guldan) == 0 or not target.DebuffPresent(shadowflame_debuff) and not InFlightToTarget(hand_of_guldan) } or DemonicFury() / 80 * ExecuteTime(soul_fire) >= target.TimeToDie() Spell(metamorphosis)
	#metamorphosis,if=demonic_fury>=950
	if DemonicFury() >= 950 Spell(metamorphosis)
	#cancel_metamorphosis
	if BuffPresent(metamorphosis_buff) Spell(metamorphosis text=cancel)
	#soul_fire,if=buff.molten_core.react&(buff.molten_core.stack>=7|target.health.pct<=25|(buff.dark_soul.remains&cooldown.metamorphosis.remains>buff.dark_soul.remains)|trinket.proc.any.remains>execute_time|trinket.stacking_proc.multistrike.remains>execute_time)&(buff.dark_soul.remains<action.shadow_bolt.cast_time|buff.dark_soul.remains>execute_time)
	if BuffPresent(molten_core_buff) and { BuffStacks(molten_core_buff) >= 7 or target.HealthPercent() <= 25 or BuffPresent(dark_soul_knowledge_buff) and SpellCooldown(metamorphosis) > BuffRemaining(dark_soul_knowledge_buff) or BuffRemaining(trinket_proc_any_buff) > ExecuteTime(soul_fire) or BuffRemaining(trinket_stacking_proc_multistrike_buff) > ExecuteTime(soul_fire) } and { BuffRemaining(dark_soul_knowledge_buff) < CastTime(shadow_bolt) or BuffRemaining(dark_soul_knowledge_buff) > ExecuteTime(soul_fire) } Spell(soul_fire)
	#soul_fire,if=buff.molten_core.react&target.time_to_die<(time+target.time_to_die)*0.25+cooldown.dark_soul.remains
	if BuffPresent(molten_core_buff) and target.TimeToDie() < { TimeInCombat() + target.TimeToDie() } * 0.25 + SpellCooldown(dark_soul_knowledge) Spell(soul_fire)
	#life_tap,if=mana.pct<40
	if ManaPercent() < 40 Spell(life_tap)
	#shadow_bolt
	Spell(shadow_bolt)
	#hellfire,moving=1,interrupt=1
	if Speed() > 0 Spell(hellfire)
	#life_tap
	Spell(life_tap)
}

AddFunction DemonologyDbActions
{
	#doom,if=buff.metamorphosis.up&target.time_to_die>=30*spell_haste&remains<=(duration*0.3)&(remains<cooldown.cataclysm.remains|!talent.cataclysm.enabled)&(buff.dark_soul.down|!glyph.dark_soul.enabled)&buff.demonbolt.remains&(buff.demonbolt.remains<(40*spell_haste-action.demonbolt.execute_time)|demonic_fury<80+80*buff.demonbolt.stack)
	if BuffPresent(metamorphosis_buff) and target.TimeToDie() >= 30 * SpellHaste() / 100 and target.DebuffRemaining(doom_debuff) <= BaseDuration(doom_debuff) * 0.3 and { target.DebuffRemaining(doom_debuff) < SpellCooldown(cataclysm) or not Talent(cataclysm_talent) } and { BuffExpires(dark_soul_knowledge_buff) or not Glyph(glyph_of_dark_soul) } and BuffPresent(demonbolt_buff) and { BuffRemaining(demonbolt_buff) < 40 * SpellHaste() / 100 - ExecuteTime(demonbolt) or DemonicFury() < 80 + 80 * BuffStacks(demonbolt_buff) } Spell(doom)
	#corruption,cycle_targets=1,if=target.time_to_die>=6&remains<=(0.3*duration)&buff.metamorphosis.down
	if target.TimeToDie() >= 6 and target.DebuffRemaining(corruption_debuff) <= 0.3 * BaseDuration(corruption_debuff) and BuffExpires(metamorphosis_buff) Spell(corruption)
	#cancel_metamorphosis,if=buff.metamorphosis.up&buff.demonbolt.stack>3&demonic_fury<=600&target.time_to_die>buff.demonbolt.remains&buff.dark_soul.down
	if BuffPresent(metamorphosis_buff) and BuffStacks(demonbolt_buff) > 3 and DemonicFury() <= 600 and target.TimeToDie() > BuffRemaining(demonbolt_buff) and BuffExpires(dark_soul_knowledge_buff) and BuffPresent(metamorphosis_buff) Spell(metamorphosis text=cancel)
	#demonbolt,if=buff.demonbolt.stack=0|(buff.demonbolt.stack<4&buff.demonbolt.remains>=(40*spell_haste-execute_time))
	if BuffStacks(demonbolt_buff) == 0 or BuffStacks(demonbolt_buff) < 4 and BuffRemaining(demonbolt_buff) >= 40 * SpellHaste() / 100 - ExecuteTime(demonbolt) Spell(demonbolt)
	#soul_fire,if=buff.metamorphosis.up&buff.molten_core.react&((buff.dark_soul.remains>execute_time&demonic_fury>=175)|(target.time_to_die<buff.demonbolt.remains))
	if BuffPresent(metamorphosis_buff) and BuffPresent(molten_core_buff) and { BuffRemaining(dark_soul_knowledge_buff) > ExecuteTime(soul_fire) and DemonicFury() >= 175 or target.TimeToDie() < BuffRemaining(demonbolt_buff) } Spell(soul_fire)
	#soul_fire,if=buff.metamorphosis.up&buff.molten_core.react&target.health.pct<=25&(((demonic_fury-80)%800)>(buff.demonbolt.remains%(40*spell_haste)))&demonic_fury>=750
	if BuffPresent(metamorphosis_buff) and BuffPresent(molten_core_buff) and target.HealthPercent() <= 25 and { DemonicFury() - 80 } / 800 > BuffRemaining(demonbolt_buff) / { 40 * SpellHaste() / 100 } and DemonicFury() >= 750 Spell(soul_fire)
	#touch_of_chaos,if=buff.metamorphosis.up&(target.time_to_die<buff.demonbolt.remains|demonic_fury>=750&buff.demonbolt.remains)
	if BuffPresent(metamorphosis_buff) and { target.TimeToDie() < BuffRemaining(demonbolt_buff) or DemonicFury() >= 750 and BuffPresent(demonbolt_buff) } Spell(touch_of_chaos)
	#touch_of_chaos,if=buff.metamorphosis.up&(((demonic_fury-40)%800)>(buff.demonbolt.remains%(40*spell_haste)))&demonic_fury>=750
	if BuffPresent(metamorphosis_buff) and { DemonicFury() - 40 } / 800 > BuffRemaining(demonbolt_buff) / { 40 * SpellHaste() / 100 } and DemonicFury() >= 750 Spell(touch_of_chaos)
	#metamorphosis,if=buff.dark_soul.remains>gcd&demonic_fury>=240&(buff.demonbolt.down|target.time_to_die<buff.demonbolt.remains|(buff.dark_soul.remains>execute_time&demonic_fury>=175))
	if BuffRemaining(dark_soul_knowledge_buff) > GCD() and DemonicFury() >= 240 and { BuffExpires(demonbolt_buff) or target.TimeToDie() < BuffRemaining(demonbolt_buff) or BuffRemaining(dark_soul_knowledge_buff) > ExecuteTime(metamorphosis) and DemonicFury() >= 175 } Spell(metamorphosis)
	#metamorphosis,if=buff.demonbolt.down&demonic_fury>=480&(action.dark_soul.charges=0|!talent.archimondes_darkness.enabled&cooldown.dark_soul.remains)
	if BuffExpires(demonbolt_buff) and DemonicFury() >= 480 and { Charges(dark_soul_knowledge) == 0 or not Talent(archimondes_darkness_talent) and SpellCooldown(dark_soul_knowledge) > 0 } Spell(metamorphosis)
	#metamorphosis,if=(demonic_fury%80)*2*spell_haste>=target.time_to_die&target.time_to_die<buff.demonbolt.remains
	if DemonicFury() / 80 * 2 * SpellHaste() / 100 >= target.TimeToDie() and target.TimeToDie() < BuffRemaining(demonbolt_buff) Spell(metamorphosis)
	#metamorphosis,if=target.time_to_die>=30*spell_haste&!dot.doom.ticking&buff.dark_soul.down
	if target.TimeToDie() >= 30 * SpellHaste() / 100 and not target.DebuffPresent(doom_debuff) and BuffExpires(dark_soul_knowledge_buff) Spell(metamorphosis)
	#metamorphosis,if=demonic_fury>750&buff.demonbolt.remains>=action.metamorphosis.cooldown
	if DemonicFury() > 750 and BuffRemaining(demonbolt_buff) >= SpellCooldown(metamorphosis) Spell(metamorphosis)
	#metamorphosis,if=(((demonic_fury-120)%800)>(buff.demonbolt.remains%(40*spell_haste)))&buff.demonbolt.remains>=10&dot.doom.remains<=dot.doom.duration*0.3
	if { DemonicFury() - 120 } / 800 > BuffRemaining(demonbolt_buff) / { 40 * SpellHaste() / 100 } and BuffRemaining(demonbolt_buff) >= 10 and target.DebuffRemaining(doom_debuff) <= target.DebuffDuration(doom_debuff) * 0.3 Spell(metamorphosis)
	#cancel_metamorphosis
	if BuffPresent(metamorphosis_buff) Spell(metamorphosis text=cancel)
	#soul_fire,if=buff.molten_core.react&(buff.dark_soul.remains<action.shadow_bolt.cast_time|buff.dark_soul.remains>cast_time)
	if BuffPresent(molten_core_buff) and { BuffRemaining(dark_soul_knowledge_buff) < CastTime(shadow_bolt) or BuffRemaining(dark_soul_knowledge_buff) > CastTime(soul_fire) } Spell(soul_fire)
	#life_tap,if=mana.pct<40
	if ManaPercent() < 40 Spell(life_tap)
	#shadow_bolt
	Spell(shadow_bolt)
	#life_tap
	Spell(life_tap)
}

AddFunction DemonologyPrecombatActions
{
	#flask,type=greater_draenic_intellect_flask
	#food,type=sleeper_surprise
	#dark_intent,if=!aura.spell_power_multiplier.up
	if not BuffPresent(spell_power_multiplier_buff any=1) Spell(dark_intent)
	#summon_pet,if=!talent.demonic_servitude.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.grimoire_of_sacrifice.down)
	if not Talent(demonic_servitude_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(grimoire_of_sacrifice_buff) } and not pet.Present() Spell(summon_felguard)
	#summon_doomguard,if=talent.demonic_servitude.enabled&active_enemies<5
	if Talent(demonic_servitude_talent) and Enemies() < 5 Spell(summon_doomguard)
	#summon_infernal,if=talent.demonic_servitude.enabled&active_enemies>=5
	if Talent(demonic_servitude_talent) and Enemies() >= 5 Spell(summon_infernal)
	#snapshot_stats
	#service_pet,if=talent.grimoire_of_service.enabled
	if Talent(grimoire_of_service_talent) Spell(grimoire_felguard)
	#potion,name=draenic_intellect
	UsePotionIntellect()
	#soul_fire
	Spell(soul_fire)
}

AddIcon specialization=demonology help=main enemies=1
{
	if not InCombat() DemonologyPrecombatActions()
	DemonologyDefaultActions()
}

AddIcon specialization=demonology help=aoe
{
	if not InCombat() DemonologyPrecombatActions()
	DemonologyDefaultActions()
}

### Required symbols
# arcane_torrent_mana
# archimondes_darkness_talent
# berserking
# blood_fury_sp
# cancel_metamorphosis
# cataclysm
# cataclysm_talent
# chaos_wave
# corruption
# corruption_debuff
# dark_intent
# dark_soul_knowledge
# dark_soul_knowledge_buff
# demonbolt
# demonbolt_buff
# demonbolt_talent
# demonic_servitude_talent
# doom
# doom_debuff
# draenic_intellect_potion
# felguard_felstorm
# glyph_of_dark_soul
# grimoire_felguard
# grimoire_of_sacrifice_buff
# grimoire_of_sacrifice_talent
# grimoire_of_service_talent
# hand_of_guldan
# hellfire
# immolation_aura
# immolation_aura_buff
# imp_swarm
# life_tap
# mannoroths_fury
# metamorphosis
# metamorphosis_buff
# molten_core_buff
# shadow_bolt
# shadowflame_debuff
# soul_fire
# summon_doomguard
# summon_felguard
# summon_infernal
# touch_of_chaos
# wrathguard_wrathstorm
]]
	OvaleScripts:RegisterScript("WARLOCK", name, desc, code, "reference")
end
