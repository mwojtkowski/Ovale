local __addonName, __addon = ...
__addon.require(__addonName, __addon, "./src/scripts\ovale_warlock", { "./src/Scripts" }, function(__exports, __Scripts)
do
    local name = "ovale_warlock_demonology"
    local desc = "[7.0] Ovale Demonology Warlock"
    local code = [[
Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_warlock_spells)

AddCheckBox(opt_potion_intellect ItemName(draenic_intellect_potion) default specialization=demonology)
AddCheckBox(opt_legendary_ring_intellect ItemName(legendary_ring_intellect) default specialization=demonology)

AddFunction DemonologyUsePotionIntellect
{
	if CheckBoxOn(opt_potion_intellect) and target.Classification(worldboss) Item(draenic_intellect_potion usable=1)
}

### actions.default

AddFunction DemonologyDefaultMainActions
{
	if Talent(soul_harvest_talent) and not SpellCooldown(soul_harvest) > 0 and not target.DebuffRemaining(doom_debuff) Spell(doom)
	if Talent(impending_doom_talent) and target.DebuffRemaining(doom_debuff) <= CastTime(hand_of_guldan) Spell(doom)
	Spell(call_dreadstalkers)
	Spell(demonic_empowerment)
	if SoulShards() >= 4 Spell(hand_of_guldan)
	if Talent(impending_doom_talent) and target.DebuffRemaining(doom_debuff) <= BaseDuration(doom_debuff) * 0.3 Spell(doom)
	Spell(demonbolt)
	Spell(shadow_bolt)
	Spell(life_tap)
}

AddFunction DemonologyDefaultShortCdActions
{
	Spell(service_felguard)
}

AddFunction DemonologyDefaultCdActions
{
	if CheckBoxOn(opt_legendary_ring_intellect) Item(legendary_ring_intellect usable=1)
	Spell(berserking)
	Spell(blood_fury_sp)
	Spell(arcane_torrent_mana)
	if BuffPresent(nithramus_buff) DemonologyUsePotionIntellect()

	unless Spell(service_felguard)
	{
		if not Talent(grimoire_of_supremacy_talent) and Enemies() < 3 Spell(summon_doomguard)
		if not Talent(grimoire_of_supremacy_talent) and Enemies() >= 3 Spell(summon_infernal)
		if target.DebuffRemaining(doom_debuff) Spell(soul_harvest)
	}
}

### actions.precombat

AddFunction DemonologyPrecombatMainActions
{
}

AddFunction DemonologyPrecombatShortCdActions
{
	if not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() Spell(summon_felguard)
}

AddFunction DemonologyPrecombatShortCdPostConditions
{
	Spell(demonic_empowerment)
}

AddFunction DemonologyPrecombatCdActions
{
	unless not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_felguard)
	{
		if Talent(grimoire_of_supremacy_talent) and Enemies() < 3 Spell(summon_doomguard)
		if Talent(grimoire_of_supremacy_talent) and Enemies() >= 3 Spell(summon_infernal)
		DemonologyUsePotionIntellect()
	}
}

AddFunction DemonologyPrecombatCdPostConditions
{
	not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_felguard) or Spell(demonic_empowerment)
}

### Demonology icons.

AddCheckBox(opt_warlock_demonology_aoe L(AOE) default specialization=demonology)

AddIcon checkbox=!opt_warlock_demonology_aoe enemies=1 help=shortcd specialization=demonology
{
	if not InCombat() DemonologyPrecombatShortCdActions()
	unless not InCombat() and DemonologyPrecombatShortCdPostConditions()
	{
		DemonologyDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_warlock_demonology_aoe help=shortcd specialization=demonology
{
	if not InCombat() DemonologyPrecombatShortCdActions()
	unless not InCombat() and DemonologyPrecombatShortCdPostConditions()
	{
		DemonologyDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=demonology
{
	if not InCombat() DemonologyPrecombatMainActions()
	DemonologyDefaultMainActions()
}

AddIcon checkbox=opt_warlock_demonology_aoe help=aoe specialization=demonology
{
	if not InCombat() DemonologyPrecombatMainActions()
	DemonologyDefaultMainActions()
}

AddIcon checkbox=!opt_warlock_demonology_aoe enemies=1 help=cd specialization=demonology
{
	if not InCombat() DemonologyPrecombatCdActions()
	unless not InCombat() and DemonologyPrecombatCdPostConditions()
	{
		DemonologyDefaultCdActions()
	}
}

AddIcon checkbox=opt_warlock_demonology_aoe help=cd specialization=demonology
{
	if not InCombat() DemonologyPrecombatCdActions()
	unless not InCombat() and DemonologyPrecombatCdPostConditions()
	{
		DemonologyDefaultCdActions()
	}
}

	]]
    __Scripts.OvaleScripts:RegisterScript("WARLOCK", "demonology", name, desc, code, "script")
end
do
    local name = "simulationcraft_warlock_affliction_t19p"
    local desc = "[7.0] SimulationCraft: Warlock_Affliction_T19P"
    local code = [[
# Based on SimulationCraft profile "Warlock_Affliction_T19P".
#	class=warlock
#	spec=affliction
#	talents=3101011
#	pet=felhunter

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_warlock_spells)

AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=affliction)

### actions.default

AddFunction AfflictionDefaultMainActions
{
	#reap_souls,if=!buff.deadwind_harvester.remains&(buff.soul_harvest.remains>5+equipped.144364*1.5&!talent.malefic_grasp.enabled&buff.active_uas.stack>1|buff.tormented_souls.react>=8|target.time_to_die<=buff.tormented_souls.react*5+equipped.144364*1.5|!talent.malefic_grasp.enabled&(trinket.proc.any.react|trinket.stacking_proc.any.react))
	if not BuffPresent(deadwind_harvester_buff) and { BuffRemaining(soul_harvest_buff) > 5 + HasEquippedItem(144364) * 1.5 and not Talent(malefic_grasp_talent) and target.DebuffStacks(unstable_affliction_debuff) > 1 or BuffStacks(tormented_souls_buff) >= 8 or target.TimeToDie() <= BuffStacks(tormented_souls_buff) * 5 + HasEquippedItem(144364) * 1.5 or not Talent(malefic_grasp_talent) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stacking_proc_any_buff) } } Spell(reap_souls)
	#soul_effigy,if=!pet.soul_effigy.active
	if not pet.Present() Spell(soul_effigy)
	#agony,cycle_targets=1,if=remains<=tick_time+gcd
	if target.DebuffRemaining(agony_debuff) <= target.TickTime(agony_debuff) + GCD() Spell(agony)
	#corruption,if=remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)&(buff.active_uas.stack<2&soul_shard=0|!talent.malefic_grasp.enabled)
	if target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } Spell(corruption)
	#corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&active_enemies>1&remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
	if { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } Spell(corruption)
	#siphon_life,if=remains<=tick_time+gcd&(buff.active_uas.stack<2&soul_shard=0|!talent.malefic_grasp.enabled)
	if target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } Spell(siphon_life)
	#siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&active_enemies>1&remains<=tick_time+gcd
	if { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() Spell(siphon_life)
	#life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
	if Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() Spell(life_tap)
	#haunt
	Spell(haunt)
	#agony,cycle_targets=1,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
	if not Talent(malefic_grasp_talent) and target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(agony_debuff) Spell(agony)
	#agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&buff.active_uas.stack=0
	if target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(agony_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 Spell(agony)
	#life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
	if Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 or Talent(malefic_grasp_talent) and target.TimeToDie() > 15 and ManaPercent() < 10 Spell(life_tap)
	#seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=4|spell_targets.seed_of_corruption=3&dot.corruption.remains<=cast_time+travel_time
	if Talent(sow_the_seeds_talent) and Enemies() >= 3 or Enemies() >= 4 or Enemies() == 3 and target.DebuffRemaining(corruption_debuff) <= CastTime(seed_of_corruption) + TravelTime(seed_of_corruption) Spell(seed_of_corruption)
	#corruption,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
	if not Talent(malefic_grasp_talent) and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) Spell(corruption)
	#corruption,if=remains<=duration*0.3&target.time_to_die>=remains&buff.active_uas.stack=0
	if target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 Spell(corruption)
	#corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
	if { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) Spell(corruption)
	#siphon_life,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
	if not Talent(malefic_grasp_talent) and target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) Spell(siphon_life)
	#siphon_life,if=remains<=duration*0.3&target.time_to_die>=remains&buff.active_uas.stack=0
	if target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 Spell(siphon_life)
	#siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
	if { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) Spell(siphon_life)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&talent.haunt.enabled&(soul_shard>=4|debuff.haunt.remains>6.5|target.time_to_die<30)
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Talent(haunt_talent) and { SoulShards() >= 4 or target.DebuffRemaining(haunt_debuff) > 6.5 or target.TimeToDie() < 30 } Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.writhe_in_agony.enabled&talent.contagion.enabled&dot.unstable_affliction_1.remains<cast_time&dot.unstable_affliction_2.remains<cast_time&dot.unstable_affliction_3.remains<cast_time&dot.unstable_affliction_4.remains<cast_time&dot.unstable_affliction_5.remains<cast_time
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(writhe_in_agony_talent) and Talent(contagion_talent) and target.DebuffStacks(unstable_affliction_debuff) >= 1 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 2 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 3 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 4 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 5 < CastTime(unstable_affliction) Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.writhe_in_agony.enabled&(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(writhe_in_agony_talent) and { SoulShards() >= 4 or BuffPresent(trinket_proc_intellect_buff) or BuffPresent(trinket_stacking_proc_mastery_buff) or BuffPresent(trinket_proc_mastery_buff) or BuffPresent(trinket_proc_crit_buff) or BuffPresent(trinket_proc_versatility_buff) or BuffPresent(soul_harvest_buff) or BuffPresent(deadwind_harvester_buff) or BuffStacks(compounding_horror_buff) == 5 or target.TimeToDie() <= 20 } Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&(target.time_to_die<30|prev_gcd.1.unstable_affliction&soul_shard>=4)
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { target.TimeToDie() < 30 or PreviousGCDSpell(unstable_affliction) and SoulShards() >= 4 } Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&(soul_shard=5|talent.contagion.enabled&soul_shard>=4)
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { SoulShards() == 5 or Talent(contagion_talent) and SoulShards() >= 4 } Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&(talent.soul_effigy.enabled|equipped.132457)&!prev_gcd.3.unstable_affliction&prev_gcd.1.unstable_affliction
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { Talent(soul_effigy_talent) or HasEquippedItem(132457) } and not PreviousGCDSpell(unstable_affliction count=3) and PreviousGCDSpell(unstable_affliction) Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&equipped.132457&buff.active_uas.stack=0
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and HasEquippedItem(132457) and target.DebuffStacks(unstable_affliction_debuff) == 0 Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&talent.soul_effigy.enabled&!equipped.132457&buff.active_uas.stack=0&dot.agony.remains>cast_time*3+6.5&(!talent.soul_effigy.enabled|pet.soul_effigy.dot.agony.remains>cast_time*3+6.5)
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and Talent(soul_effigy_talent) and not HasEquippedItem(132457) and target.DebuffStacks(unstable_affliction_debuff) == 0 and target.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 and { not Talent(soul_effigy_talent) or pet.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 } Spell(unstable_affliction)
	#unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<4&talent.malefic_grasp.enabled&!talent.soul_effigy.enabled&!equipped.132457&!prev_gcd.3.unstable_affliction&dot.agony.remains>cast_time*3+6.5&(dot.corruption.remains>cast_time+6.5|talent.absolute_corruption.enabled)
	if { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and not Talent(soul_effigy_talent) and not HasEquippedItem(132457) and not PreviousGCDSpell(unstable_affliction count=3) and target.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 and { target.DebuffRemaining(corruption_debuff) > CastTime(unstable_affliction) + 6.5 or Talent(absolute_corruption_talent) } Spell(unstable_affliction)
	#reap_souls,if=!buff.deadwind_harvester.remains&buff.active_uas.stack>1&((!trinket.has_stacking_stat.any&!trinket.has_stat.any)|talent.malefic_grasp.enabled)
	if not BuffPresent(deadwind_harvester_buff) and target.DebuffStacks(unstable_affliction_debuff) > 1 and { not True(trinket_has_stacking_stat_any) and not True(trinket_has_stat_any) or Talent(malefic_grasp_talent) } Spell(reap_souls)
	#reap_souls,if=!buff.deadwind_harvester.remains&prev_gcd.1.unstable_affliction&((!trinket.has_stacking_stat.any&!trinket.has_stat.any)|talent.malefic_grasp.enabled)&buff.tormented_souls.react>1
	if not BuffPresent(deadwind_harvester_buff) and PreviousGCDSpell(unstable_affliction) and { not True(trinket_has_stacking_stat_any) and not True(trinket_has_stat_any) or Talent(malefic_grasp_talent) } and BuffStacks(tormented_souls_buff) > 1 Spell(reap_souls)
	#life_tap,if=mana.pct<=10
	if ManaPercent() <= 10 Spell(life_tap)
	#drain_soul,chain=1,interrupt=1
	Spell(drain_soul)
	#life_tap
	Spell(life_tap)
}

AddFunction AfflictionDefaultMainPostConditions
{
}

AddFunction AfflictionDefaultShortCdActions
{
	unless not BuffPresent(deadwind_harvester_buff) and { BuffRemaining(soul_harvest_buff) > 5 + HasEquippedItem(144364) * 1.5 and not Talent(malefic_grasp_talent) and target.DebuffStacks(unstable_affliction_debuff) > 1 or BuffStacks(tormented_souls_buff) >= 8 or target.TimeToDie() <= BuffStacks(tormented_souls_buff) * 5 + HasEquippedItem(144364) * 1.5 or not Talent(malefic_grasp_talent) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stacking_proc_any_buff) } } and Spell(reap_souls) or not pet.Present() and Spell(soul_effigy) or target.DebuffRemaining(agony_debuff) <= target.TickTime(agony_debuff) + GCD() and Spell(agony)
	{
		#service_pet,if=dot.corruption.remains&dot.agony.remains
		if target.DebuffRemaining(corruption_debuff) and target.DebuffRemaining(agony_debuff) Spell(service_felhunter)

		unless target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } and Spell(corruption) or { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and Spell(corruption) or target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } and Spell(siphon_life) or { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and Spell(siphon_life) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap)
		{
			#phantom_singularity
			Spell(phantom_singularity)
		}
	}
}

AddFunction AfflictionDefaultShortCdPostConditions
{
	not BuffPresent(deadwind_harvester_buff) and { BuffRemaining(soul_harvest_buff) > 5 + HasEquippedItem(144364) * 1.5 and not Talent(malefic_grasp_talent) and target.DebuffStacks(unstable_affliction_debuff) > 1 or BuffStacks(tormented_souls_buff) >= 8 or target.TimeToDie() <= BuffStacks(tormented_souls_buff) * 5 + HasEquippedItem(144364) * 1.5 or not Talent(malefic_grasp_talent) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stacking_proc_any_buff) } } and Spell(reap_souls) or not pet.Present() and Spell(soul_effigy) or target.DebuffRemaining(agony_debuff) <= target.TickTime(agony_debuff) + GCD() and Spell(agony) or target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } and Spell(corruption) or { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and Spell(corruption) or target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } and Spell(siphon_life) or { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and Spell(siphon_life) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap) or Spell(haunt) or not Talent(malefic_grasp_talent) and target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(agony_debuff) and Spell(agony) or target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(agony_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(agony) or { Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 or Talent(malefic_grasp_talent) and target.TimeToDie() > 15 and ManaPercent() < 10 } and Spell(life_tap) or { Talent(sow_the_seeds_talent) and Enemies() >= 3 or Enemies() >= 4 or Enemies() == 3 and target.DebuffRemaining(corruption_debuff) <= CastTime(seed_of_corruption) + TravelTime(seed_of_corruption) } and Spell(seed_of_corruption) or not Talent(malefic_grasp_talent) and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and Spell(corruption) or target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(corruption) or { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and Spell(corruption) or not Talent(malefic_grasp_talent) and target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and Spell(siphon_life) or target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(siphon_life) or { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and Spell(siphon_life) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Talent(haunt_talent) and { SoulShards() >= 4 or target.DebuffRemaining(haunt_debuff) > 6.5 or target.TimeToDie() < 30 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(writhe_in_agony_talent) and Talent(contagion_talent) and target.DebuffStacks(unstable_affliction_debuff) >= 1 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 2 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 3 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 4 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 5 < CastTime(unstable_affliction) and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(writhe_in_agony_talent) and { SoulShards() >= 4 or BuffPresent(trinket_proc_intellect_buff) or BuffPresent(trinket_stacking_proc_mastery_buff) or BuffPresent(trinket_proc_mastery_buff) or BuffPresent(trinket_proc_crit_buff) or BuffPresent(trinket_proc_versatility_buff) or BuffPresent(soul_harvest_buff) or BuffPresent(deadwind_harvester_buff) or BuffStacks(compounding_horror_buff) == 5 or target.TimeToDie() <= 20 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { target.TimeToDie() < 30 or PreviousGCDSpell(unstable_affliction) and SoulShards() >= 4 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { SoulShards() == 5 or Talent(contagion_talent) and SoulShards() >= 4 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { Talent(soul_effigy_talent) or HasEquippedItem(132457) } and not PreviousGCDSpell(unstable_affliction count=3) and PreviousGCDSpell(unstable_affliction) and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and HasEquippedItem(132457) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and Talent(soul_effigy_talent) and not HasEquippedItem(132457) and target.DebuffStacks(unstable_affliction_debuff) == 0 and target.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 and { not Talent(soul_effigy_talent) or pet.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and not Talent(soul_effigy_talent) and not HasEquippedItem(132457) and not PreviousGCDSpell(unstable_affliction count=3) and target.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 and { target.DebuffRemaining(corruption_debuff) > CastTime(unstable_affliction) + 6.5 or Talent(absolute_corruption_talent) } and Spell(unstable_affliction) or not BuffPresent(deadwind_harvester_buff) and target.DebuffStacks(unstable_affliction_debuff) > 1 and { not True(trinket_has_stacking_stat_any) and not True(trinket_has_stat_any) or Talent(malefic_grasp_talent) } and Spell(reap_souls) or not BuffPresent(deadwind_harvester_buff) and PreviousGCDSpell(unstable_affliction) and { not True(trinket_has_stacking_stat_any) and not True(trinket_has_stat_any) or Talent(malefic_grasp_talent) } and BuffStacks(tormented_souls_buff) > 1 and Spell(reap_souls) or ManaPercent() <= 10 and Spell(life_tap) or Spell(drain_soul) or Spell(life_tap)
}

AddFunction AfflictionDefaultCdActions
{
	unless not BuffPresent(deadwind_harvester_buff) and { BuffRemaining(soul_harvest_buff) > 5 + HasEquippedItem(144364) * 1.5 and not Talent(malefic_grasp_talent) and target.DebuffStacks(unstable_affliction_debuff) > 1 or BuffStacks(tormented_souls_buff) >= 8 or target.TimeToDie() <= BuffStacks(tormented_souls_buff) * 5 + HasEquippedItem(144364) * 1.5 or not Talent(malefic_grasp_talent) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stacking_proc_any_buff) } } and Spell(reap_souls) or not pet.Present() and Spell(soul_effigy) or target.DebuffRemaining(agony_debuff) <= target.TickTime(agony_debuff) + GCD() and Spell(agony) or target.DebuffRemaining(corruption_debuff) and target.DebuffRemaining(agony_debuff) and Spell(service_felhunter)
	{
		#summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
		if not Talent(grimoire_of_supremacy_talent) and Enemies() <= 2 and { target.TimeToDie() > 180 or target.HealthPercent() <= 20 or target.TimeToDie() < 30 } Spell(summon_doomguard)
		#summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
		if not Talent(grimoire_of_supremacy_talent) and Enemies() > 2 Spell(summon_infernal)
		#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
		if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and HasEquippedItem(132379) and not SpellCooldown(sindorei_spite_icd) > 0 Spell(summon_doomguard)
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
		if Talent(grimoire_of_supremacy_talent) and Enemies() > 1 and HasEquippedItem(132379) and not SpellCooldown(sindorei_spite_icd) > 0 Spell(summon_infernal)
		#berserking,if=prev_gcd.1.unstable_affliction|buff.soul_harvest.remains>=10
		if PreviousGCDSpell(unstable_affliction) or BuffRemaining(soul_harvest_buff) >= 10 Spell(berserking)
		#blood_fury
		Spell(blood_fury_sp)
		#arcane_torrent
		Spell(arcane_torrent_mana)
		#soul_harvest,if=buff.active_uas.stack>=3|!equipped.132394&!equipped.132457&(debuff.haunt.remains|talent.writhe_in_agony.enabled)
		if target.DebuffStacks(unstable_affliction_debuff) >= 3 or not HasEquippedItem(132394) and not HasEquippedItem(132457) and { target.DebuffPresent(haunt_debuff) or Talent(writhe_in_agony_talent) } Spell(soul_harvest)
		#potion,name=prolonged_power,if=!talent.soul_harvest.enabled&(trinket.proc.any.react|trinket.stack_proc.any.react|target.time_to_die<=70|!cooldown.haunt.remains|buff.active_uas.stack>2)
		if not Talent(soul_harvest_talent) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stack_proc_any_buff) or target.TimeToDie() <= 70 or not SpellCooldown(haunt) > 0 or target.DebuffStacks(unstable_affliction_debuff) > 2 } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
		#potion,name=prolonged_power,if=talent.soul_harvest.enabled&buff.soul_harvest.remains&(trinket.proc.any.react|trinket.stack_proc.any.react|target.time_to_die<=70|!cooldown.haunt.remains|buff.active_uas.stack>2)
		if Talent(soul_harvest_talent) and BuffPresent(soul_harvest_buff) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stack_proc_any_buff) or target.TimeToDie() <= 70 or not SpellCooldown(haunt) > 0 or target.DebuffStacks(unstable_affliction_debuff) > 2 } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
	}
}

AddFunction AfflictionDefaultCdPostConditions
{
	not BuffPresent(deadwind_harvester_buff) and { BuffRemaining(soul_harvest_buff) > 5 + HasEquippedItem(144364) * 1.5 and not Talent(malefic_grasp_talent) and target.DebuffStacks(unstable_affliction_debuff) > 1 or BuffStacks(tormented_souls_buff) >= 8 or target.TimeToDie() <= BuffStacks(tormented_souls_buff) * 5 + HasEquippedItem(144364) * 1.5 or not Talent(malefic_grasp_talent) and { BuffPresent(trinket_proc_any_buff) or BuffPresent(trinket_stacking_proc_any_buff) } } and Spell(reap_souls) or not pet.Present() and Spell(soul_effigy) or target.DebuffRemaining(agony_debuff) <= target.TickTime(agony_debuff) + GCD() and Spell(agony) or target.DebuffRemaining(corruption_debuff) and target.DebuffRemaining(agony_debuff) and Spell(service_felhunter) or target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } and Spell(corruption) or { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(corruption_debuff) <= target.TickTime(corruption_debuff) + GCD() and { Enemies() < 3 and Talent(sow_the_seeds_talent) or Enemies() < 4 } and Spell(corruption) or target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and { target.DebuffStacks(unstable_affliction_debuff) < 2 and SoulShards() == 0 or not Talent(malefic_grasp_talent) } and Spell(siphon_life) or { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and Enemies() > 1 and target.DebuffRemaining(siphon_life_debuff) <= target.TickTime(siphon_life_debuff) + GCD() and Spell(siphon_life) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap) or Spell(phantom_singularity) or Spell(haunt) or not Talent(malefic_grasp_talent) and target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(agony_debuff) and Spell(agony) or target.DebuffRemaining(agony_debuff) <= BaseDuration(agony_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(agony_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(agony) or { Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 or Talent(malefic_grasp_talent) and target.TimeToDie() > 15 and ManaPercent() < 10 } and Spell(life_tap) or { Talent(sow_the_seeds_talent) and Enemies() >= 3 or Enemies() >= 4 or Enemies() == 3 and target.DebuffRemaining(corruption_debuff) <= CastTime(seed_of_corruption) + TravelTime(seed_of_corruption) } and Spell(seed_of_corruption) or not Talent(malefic_grasp_talent) and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and Spell(corruption) or target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(corruption) or { Talent(absolute_corruption_talent) or not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and target.DebuffRemaining(corruption_debuff) <= BaseDuration(corruption_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(corruption_debuff) and Spell(corruption) or not Talent(malefic_grasp_talent) and target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and Spell(siphon_life) or target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(siphon_life) or { not Talent(malefic_grasp_talent) or not Talent(soul_effigy_talent) } and target.DebuffRemaining(siphon_life_debuff) <= BaseDuration(siphon_life_debuff) * 0.3 and target.TimeToDie() >= target.DebuffRemaining(siphon_life_debuff) and Spell(siphon_life) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Talent(haunt_talent) and { SoulShards() >= 4 or target.DebuffRemaining(haunt_debuff) > 6.5 or target.TimeToDie() < 30 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(writhe_in_agony_talent) and Talent(contagion_talent) and target.DebuffStacks(unstable_affliction_debuff) >= 1 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 2 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 3 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 4 < CastTime(unstable_affliction) and target.DebuffStacks(unstable_affliction_debuff) >= 5 < CastTime(unstable_affliction) and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(writhe_in_agony_talent) and { SoulShards() >= 4 or BuffPresent(trinket_proc_intellect_buff) or BuffPresent(trinket_stacking_proc_mastery_buff) or BuffPresent(trinket_proc_mastery_buff) or BuffPresent(trinket_proc_crit_buff) or BuffPresent(trinket_proc_versatility_buff) or BuffPresent(soul_harvest_buff) or BuffPresent(deadwind_harvester_buff) or BuffStacks(compounding_horror_buff) == 5 or target.TimeToDie() <= 20 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { target.TimeToDie() < 30 or PreviousGCDSpell(unstable_affliction) and SoulShards() >= 4 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { SoulShards() == 5 or Talent(contagion_talent) and SoulShards() >= 4 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and { Talent(soul_effigy_talent) or HasEquippedItem(132457) } and not PreviousGCDSpell(unstable_affliction count=3) and PreviousGCDSpell(unstable_affliction) and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and HasEquippedItem(132457) and target.DebuffStacks(unstable_affliction_debuff) == 0 and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and Talent(soul_effigy_talent) and not HasEquippedItem(132457) and target.DebuffStacks(unstable_affliction_debuff) == 0 and target.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 and { not Talent(soul_effigy_talent) or pet.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 } and Spell(unstable_affliction) or { not Talent(sow_the_seeds_talent) or Enemies() < 3 } and Enemies() < 4 and Talent(malefic_grasp_talent) and not Talent(soul_effigy_talent) and not HasEquippedItem(132457) and not PreviousGCDSpell(unstable_affliction count=3) and target.DebuffRemaining(agony_debuff) > CastTime(unstable_affliction) * 3 + 6.5 and { target.DebuffRemaining(corruption_debuff) > CastTime(unstable_affliction) + 6.5 or Talent(absolute_corruption_talent) } and Spell(unstable_affliction) or not BuffPresent(deadwind_harvester_buff) and target.DebuffStacks(unstable_affliction_debuff) > 1 and { not True(trinket_has_stacking_stat_any) and not True(trinket_has_stat_any) or Talent(malefic_grasp_talent) } and Spell(reap_souls) or not BuffPresent(deadwind_harvester_buff) and PreviousGCDSpell(unstable_affliction) and { not True(trinket_has_stacking_stat_any) and not True(trinket_has_stat_any) or Talent(malefic_grasp_talent) } and BuffStacks(tormented_souls_buff) > 1 and Spell(reap_souls) or ManaPercent() <= 10 and Spell(life_tap) or Spell(drain_soul) or Spell(life_tap)
}

### actions.precombat

AddFunction AfflictionPrecombatMainActions
{
	#augmentation,type=defiled
	#snapshot_stats
	#grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
	if Talent(grimoire_of_sacrifice_talent) and pet.Present() Spell(grimoire_of_sacrifice)
	#life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remains
	if Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) Spell(life_tap)
}

AddFunction AfflictionPrecombatMainPostConditions
{
}

AddFunction AfflictionPrecombatShortCdActions
{
	#flask,type=whispered_pact
	#food,type=nightborne_delicacy_platter
	#summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
	if not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() Spell(summon_felhunter)
}

AddFunction AfflictionPrecombatShortCdPostConditions
{
	Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) and Spell(life_tap)
}

AddFunction AfflictionPrecombatCdActions
{
	unless not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_felhunter)
	{
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
		if Talent(grimoire_of_supremacy_talent) and ArtifactTraitRank(lord_of_flames) > 0 Spell(summon_infernal)
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>1
		if Talent(grimoire_of_supremacy_talent) and Enemies() > 1 Spell(summon_infernal)
		#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies=1&artifact.lord_of_flames.rank=0
		if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and ArtifactTraitRank(lord_of_flames) == 0 Spell(summon_doomguard)

		unless Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) and Spell(life_tap)
		{
			#potion,name=prolonged_power
			if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
		}
	}
}

AddFunction AfflictionPrecombatCdPostConditions
{
	not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_felhunter) or Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) and Spell(life_tap)
}

### Affliction icons.

AddCheckBox(opt_warlock_affliction_aoe L(AOE) default specialization=affliction)

AddIcon checkbox=!opt_warlock_affliction_aoe enemies=1 help=shortcd specialization=affliction
{
	if not InCombat() AfflictionPrecombatShortCdActions()
	unless not InCombat() and AfflictionPrecombatShortCdPostConditions()
	{
		AfflictionDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_warlock_affliction_aoe help=shortcd specialization=affliction
{
	if not InCombat() AfflictionPrecombatShortCdActions()
	unless not InCombat() and AfflictionPrecombatShortCdPostConditions()
	{
		AfflictionDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=affliction
{
	if not InCombat() AfflictionPrecombatMainActions()
	unless not InCombat() and AfflictionPrecombatMainPostConditions()
	{
		AfflictionDefaultMainActions()
	}
}

AddIcon checkbox=opt_warlock_affliction_aoe help=aoe specialization=affliction
{
	if not InCombat() AfflictionPrecombatMainActions()
	unless not InCombat() and AfflictionPrecombatMainPostConditions()
	{
		AfflictionDefaultMainActions()
	}
}

AddIcon checkbox=!opt_warlock_affliction_aoe enemies=1 help=cd specialization=affliction
{
	if not InCombat() AfflictionPrecombatCdActions()
	unless not InCombat() and AfflictionPrecombatCdPostConditions()
	{
		AfflictionDefaultCdActions()
	}
}

AddIcon checkbox=opt_warlock_affliction_aoe help=cd specialization=affliction
{
	if not InCombat() AfflictionPrecombatCdActions()
	unless not InCombat() and AfflictionPrecombatCdPostConditions()
	{
		AfflictionDefaultCdActions()
	}
}

### Required symbols
# 132379
# 132394
# 132457
# 144364
# absolute_corruption_talent
# agony
# agony_debuff
# arcane_torrent_mana
# berserking
# blood_fury_sp
# compounding_horror_buff
# contagion_talent
# corruption
# corruption_debuff
# deadwind_harvester_buff
# demonic_power_buff
# drain_soul
# empowered_life_tap_buff
# empowered_life_tap_talent
# grimoire_of_sacrifice
# grimoire_of_sacrifice_talent
# grimoire_of_supremacy_talent
# haunt
# haunt_debuff
# haunt_talent
# life_tap
# lord_of_flames
# malefic_grasp_talent
# phantom_singularity
# prolonged_power_potion
# reap_souls
# seed_of_corruption
# service_felhunter
# sindorei_spite_icd
# siphon_life
# siphon_life_debuff
# soul_effigy
# soul_effigy_talent
# soul_harvest
# soul_harvest_buff
# soul_harvest_talent
# sow_the_seeds_talent
# summon_doomguard
# summon_felhunter
# summon_infernal
# tormented_souls_buff
# unstable_affliction
# writhe_in_agony_talent
]]
    __Scripts.OvaleScripts:RegisterScript("WARLOCK", "affliction", name, desc, code, "script")
end
do
    local name = "simulationcraft_warlock_demonology_t19p"
    local desc = "[7.0] SimulationCraft: Warlock_Demonology_T19P"
    local code = [[
# Based on SimulationCraft profile "Warlock_Demonology_T19P".
#	class=warlock
#	spec=demonology
#	talents=3201022
#	pet=felguard

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_warlock_spells)

AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=demonology)

### actions.default

AddFunction DemonologyDefaultMainActions
{
	#implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&(buff.demonic_synergy.remains|talent.soul_conduit.enabled|(!talent.soul_conduit.enabled&spell_targets.implosion>1)|wild_imp_count<=4)
	if DemonDuration(wild_imp) <= ExecuteTime(shadow_bolt) and { BuffPresent(demonic_synergy_buff) or Talent(soul_conduit_talent) or not Talent(soul_conduit_talent) and Enemies() > 1 or Demons(wild_imp) <= 4 } Spell(implosion)
	#implosion,if=prev_gcd.1.hand_of_guldan&((wild_imp_remaining_duration<=3&buff.demonic_synergy.remains)|(wild_imp_remaining_duration<=4&spell_targets.implosion>2))
	if PreviousGCDSpell(hand_of_guldan) and { DemonDuration(wild_imp) <= 3 and BuffPresent(demonic_synergy_buff) or DemonDuration(wild_imp) <= 4 and Enemies() > 2 } Spell(implosion)
	#shadowflame,if=((debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time)|(charges=2&soul_shard<5))&spell_targets.demonwrath<5
	if { target.DebuffStacks(shadowflame_debuff) > 0 and target.DebuffRemaining(shadowflame_debuff) < CastTime(shadow_bolt) + TravelTime(shadowflame) or Charges(shadowflame) == 2 and SoulShards() < 5 } and Enemies() < 5 Spell(shadowflame)
	#call_dreadstalkers,if=(!talent.summon_darkglare.enabled|talent.power_trip.enabled)&(spell_targets.implosion<3|!talent.implosion.enabled)
	if { not Talent(summon_darkglare_talent) or Talent(power_trip_talent) } and { Enemies() < 3 or not Talent(implosion_talent) } Spell(call_dreadstalkers)
	#hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
	if SoulShards() >= 4 and not Talent(summon_darkglare_talent) Spell(hand_of_guldan)
	#summon_darkglare,if=prev_gcd.1.hand_of_guldan|prev_gcd.1.call_dreadstalkers|talent.power_trip.enabled
	if PreviousGCDSpell(hand_of_guldan) or PreviousGCDSpell(call_dreadstalkers) or Talent(power_trip_talent) Spell(summon_darkglare)
	#summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
	if SpellCooldown(call_dreadstalkers) > 5 and SoulShards() < 3 Spell(summon_darkglare)
	#summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&(soul_shard>=3|soul_shard>=1&buff.demonic_calling.react)
	if SpellCooldown(call_dreadstalkers) <= CastTime(summon_darkglare) and { SoulShards() >= 3 or SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } Spell(summon_darkglare)
	#call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&(cooldown.summon_darkglare.remains>2|prev_gcd.1.summon_darkglare|cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3|cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react)
	if Talent(summon_darkglare_talent) and { Enemies() < 3 or not Talent(implosion_talent) } and { SpellCooldown(summon_darkglare) > 2 or PreviousGCDSpell(summon_darkglare) or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 3 or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } Spell(call_dreadstalkers)
	#hand_of_guldan,if=(soul_shard>=3&prev_gcd.1.call_dreadstalkers)|soul_shard>=5|(soul_shard>=4&cooldown.summon_darkglare.remains>2)
	if SoulShards() >= 3 and PreviousGCDSpell(call_dreadstalkers) or SoulShards() >= 5 or SoulShards() >= 4 and SpellCooldown(summon_darkglare) > 2 Spell(hand_of_guldan)
	#demonic_empowerment,if=(((talent.power_trip.enabled&(!talent.implosion.enabled|spell_targets.demonwrath<=1))|!talent.implosion.enabled|(talent.implosion.enabled&!talent.soul_conduit.enabled&spell_targets.demonwrath<=3))&(wild_imp_no_de>3|prev_gcd.1.hand_of_guldan))|(prev_gcd.1.hand_of_guldan&wild_imp_no_de=0&wild_imp_remaining_duration<=0)|(prev_gcd.1.implosion&wild_imp_no_de>0)
	if { Talent(power_trip_talent) and { not Talent(implosion_talent) or Enemies() <= 1 } or not Talent(implosion_talent) or Talent(implosion_talent) and not Talent(soul_conduit_talent) and Enemies() <= 3 } and { NotDeDemons(wild_imp) > 3 or PreviousGCDSpell(hand_of_guldan) } or PreviousGCDSpell(hand_of_guldan) and NotDeDemons(wild_imp) == 0 and DemonDuration(wild_imp) <= 0 or PreviousGCDSpell(implosion) and NotDeDemons(wild_imp) > 0 Spell(demonic_empowerment)
	#demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
	if NotDeDemons(dreadstalker) > 0 or NotDeDemons(darkglare) > 0 or NotDeDemons(doomguard) > 0 or NotDeDemons(infernal) > 0 or 0 > 0 Spell(demonic_empowerment)
	#doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
	if not Talent(hand_of_doom_talent) and target.TimeToDie() > BaseDuration(doom_debuff) and { not target.DebuffPresent(doom_debuff) or target.DebuffRemaining(doom_debuff) < BaseDuration(doom_debuff) * 0.3 } Spell(doom)
	#shadowflame,if=charges=2&spell_targets.demonwrath<5
	if Charges(shadowflame) == 2 and Enemies() < 5 Spell(shadowflame)
	#life_tap,if=mana.pct<=30
	if ManaPercent() <= 30 Spell(life_tap)
	#demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
	if Enemies() >= 3 Spell(demonwrath)
	#demonwrath,moving=1,chain=1,interrupt=1
	if Speed() > 0 Spell(demonwrath)
	#demonbolt
	Spell(demonbolt)
	#shadow_bolt
	Spell(shadow_bolt)
	#life_tap
	Spell(life_tap)
}

AddFunction DemonologyDefaultMainPostConditions
{
}

AddFunction DemonologyDefaultShortCdActions
{
	unless DemonDuration(wild_imp) <= ExecuteTime(shadow_bolt) and { BuffPresent(demonic_synergy_buff) or Talent(soul_conduit_talent) or not Talent(soul_conduit_talent) and Enemies() > 1 or Demons(wild_imp) <= 4 } and Spell(implosion) or PreviousGCDSpell(hand_of_guldan) and { DemonDuration(wild_imp) <= 3 and BuffPresent(demonic_synergy_buff) or DemonDuration(wild_imp) <= 4 and Enemies() > 2 } and Spell(implosion) or { target.DebuffStacks(shadowflame_debuff) > 0 and target.DebuffRemaining(shadowflame_debuff) < CastTime(shadow_bolt) + TravelTime(shadowflame) or Charges(shadowflame) == 2 and SoulShards() < 5 } and Enemies() < 5 and Spell(shadowflame)
	{
		#service_pet
		Spell(service_felguard)

		unless { not Talent(summon_darkglare_talent) or Talent(power_trip_talent) } and { Enemies() < 3 or not Talent(implosion_talent) } and Spell(call_dreadstalkers) or SoulShards() >= 4 and not Talent(summon_darkglare_talent) and Spell(hand_of_guldan) or { PreviousGCDSpell(hand_of_guldan) or PreviousGCDSpell(call_dreadstalkers) or Talent(power_trip_talent) } and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) > 5 and SoulShards() < 3 and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) <= CastTime(summon_darkglare) and { SoulShards() >= 3 or SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(summon_darkglare) or Talent(summon_darkglare_talent) and { Enemies() < 3 or not Talent(implosion_talent) } and { SpellCooldown(summon_darkglare) > 2 or PreviousGCDSpell(summon_darkglare) or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 3 or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(call_dreadstalkers) or { SoulShards() >= 3 and PreviousGCDSpell(call_dreadstalkers) or SoulShards() >= 5 or SoulShards() >= 4 and SpellCooldown(summon_darkglare) > 2 } and Spell(hand_of_guldan) or { { Talent(power_trip_talent) and { not Talent(implosion_talent) or Enemies() <= 1 } or not Talent(implosion_talent) or Talent(implosion_talent) and not Talent(soul_conduit_talent) and Enemies() <= 3 } and { NotDeDemons(wild_imp) > 3 or PreviousGCDSpell(hand_of_guldan) } or PreviousGCDSpell(hand_of_guldan) and NotDeDemons(wild_imp) == 0 and DemonDuration(wild_imp) <= 0 or PreviousGCDSpell(implosion) and NotDeDemons(wild_imp) > 0 } and Spell(demonic_empowerment) or { NotDeDemons(dreadstalker) > 0 or NotDeDemons(darkglare) > 0 or NotDeDemons(doomguard) > 0 or NotDeDemons(infernal) > 0 or 0 > 0 } and Spell(demonic_empowerment) or not Talent(hand_of_doom_talent) and target.TimeToDie() > BaseDuration(doom_debuff) and { not target.DebuffPresent(doom_debuff) or target.DebuffRemaining(doom_debuff) < BaseDuration(doom_debuff) * 0.3 } and Spell(doom) or Charges(shadowflame) == 2 and Enemies() < 5 and Spell(shadowflame)
		{
			#thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
			if { DemonDuration(dreadstalker) > ExecuteTime(thalkiels_consumption) or Talent(implosion_talent) and Enemies() >= 3 } and Demons(wild_imp) > 3 and DemonDuration(wild_imp) > ExecuteTime(thalkiels_consumption) Spell(thalkiels_consumption)
		}
	}
}

AddFunction DemonologyDefaultShortCdPostConditions
{
	DemonDuration(wild_imp) <= ExecuteTime(shadow_bolt) and { BuffPresent(demonic_synergy_buff) or Talent(soul_conduit_talent) or not Talent(soul_conduit_talent) and Enemies() > 1 or Demons(wild_imp) <= 4 } and Spell(implosion) or PreviousGCDSpell(hand_of_guldan) and { DemonDuration(wild_imp) <= 3 and BuffPresent(demonic_synergy_buff) or DemonDuration(wild_imp) <= 4 and Enemies() > 2 } and Spell(implosion) or { target.DebuffStacks(shadowflame_debuff) > 0 and target.DebuffRemaining(shadowflame_debuff) < CastTime(shadow_bolt) + TravelTime(shadowflame) or Charges(shadowflame) == 2 and SoulShards() < 5 } and Enemies() < 5 and Spell(shadowflame) or { not Talent(summon_darkglare_talent) or Talent(power_trip_talent) } and { Enemies() < 3 or not Talent(implosion_talent) } and Spell(call_dreadstalkers) or SoulShards() >= 4 and not Talent(summon_darkglare_talent) and Spell(hand_of_guldan) or { PreviousGCDSpell(hand_of_guldan) or PreviousGCDSpell(call_dreadstalkers) or Talent(power_trip_talent) } and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) > 5 and SoulShards() < 3 and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) <= CastTime(summon_darkglare) and { SoulShards() >= 3 or SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(summon_darkglare) or Talent(summon_darkglare_talent) and { Enemies() < 3 or not Talent(implosion_talent) } and { SpellCooldown(summon_darkglare) > 2 or PreviousGCDSpell(summon_darkglare) or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 3 or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(call_dreadstalkers) or { SoulShards() >= 3 and PreviousGCDSpell(call_dreadstalkers) or SoulShards() >= 5 or SoulShards() >= 4 and SpellCooldown(summon_darkglare) > 2 } and Spell(hand_of_guldan) or { { Talent(power_trip_talent) and { not Talent(implosion_talent) or Enemies() <= 1 } or not Talent(implosion_talent) or Talent(implosion_talent) and not Talent(soul_conduit_talent) and Enemies() <= 3 } and { NotDeDemons(wild_imp) > 3 or PreviousGCDSpell(hand_of_guldan) } or PreviousGCDSpell(hand_of_guldan) and NotDeDemons(wild_imp) == 0 and DemonDuration(wild_imp) <= 0 or PreviousGCDSpell(implosion) and NotDeDemons(wild_imp) > 0 } and Spell(demonic_empowerment) or { NotDeDemons(dreadstalker) > 0 or NotDeDemons(darkglare) > 0 or NotDeDemons(doomguard) > 0 or NotDeDemons(infernal) > 0 or 0 > 0 } and Spell(demonic_empowerment) or not Talent(hand_of_doom_talent) and target.TimeToDie() > BaseDuration(doom_debuff) and { not target.DebuffPresent(doom_debuff) or target.DebuffRemaining(doom_debuff) < BaseDuration(doom_debuff) * 0.3 } and Spell(doom) or Charges(shadowflame) == 2 and Enemies() < 5 and Spell(shadowflame) or ManaPercent() <= 30 and Spell(life_tap) or Enemies() >= 3 and Spell(demonwrath) or Speed() > 0 and Spell(demonwrath) or Spell(demonbolt) or Spell(shadow_bolt) or Spell(life_tap)
}

AddFunction DemonologyDefaultCdActions
{
	unless DemonDuration(wild_imp) <= ExecuteTime(shadow_bolt) and { BuffPresent(demonic_synergy_buff) or Talent(soul_conduit_talent) or not Talent(soul_conduit_talent) and Enemies() > 1 or Demons(wild_imp) <= 4 } and Spell(implosion) or PreviousGCDSpell(hand_of_guldan) and { DemonDuration(wild_imp) <= 3 and BuffPresent(demonic_synergy_buff) or DemonDuration(wild_imp) <= 4 and Enemies() > 2 } and Spell(implosion) or { target.DebuffStacks(shadowflame_debuff) > 0 and target.DebuffRemaining(shadowflame_debuff) < CastTime(shadow_bolt) + TravelTime(shadowflame) or Charges(shadowflame) == 2 and SoulShards() < 5 } and Enemies() < 5 and Spell(shadowflame) or Spell(service_felguard)
	{
		#summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30|equipped.132369)
		if not Talent(grimoire_of_supremacy_talent) and Enemies() <= 2 and { target.TimeToDie() > 180 or target.HealthPercent() <= 20 or target.TimeToDie() < 30 or HasEquippedItem(132369) } Spell(summon_doomguard)
		#summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>2
		if not Talent(grimoire_of_supremacy_talent) and Enemies() > 2 Spell(summon_infernal)
		#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
		if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and HasEquippedItem(132379) and not SpellCooldown(sindorei_spite_icd) > 0 Spell(summon_doomguard)
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
		if Talent(grimoire_of_supremacy_talent) and Enemies() > 1 and HasEquippedItem(132379) and not SpellCooldown(sindorei_spite_icd) > 0 Spell(summon_infernal)

		unless { not Talent(summon_darkglare_talent) or Talent(power_trip_talent) } and { Enemies() < 3 or not Talent(implosion_talent) } and Spell(call_dreadstalkers) or SoulShards() >= 4 and not Talent(summon_darkglare_talent) and Spell(hand_of_guldan) or { PreviousGCDSpell(hand_of_guldan) or PreviousGCDSpell(call_dreadstalkers) or Talent(power_trip_talent) } and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) > 5 and SoulShards() < 3 and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) <= CastTime(summon_darkglare) and { SoulShards() >= 3 or SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(summon_darkglare) or Talent(summon_darkglare_talent) and { Enemies() < 3 or not Talent(implosion_talent) } and { SpellCooldown(summon_darkglare) > 2 or PreviousGCDSpell(summon_darkglare) or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 3 or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(call_dreadstalkers) or { SoulShards() >= 3 and PreviousGCDSpell(call_dreadstalkers) or SoulShards() >= 5 or SoulShards() >= 4 and SpellCooldown(summon_darkglare) > 2 } and Spell(hand_of_guldan) or { { Talent(power_trip_talent) and { not Talent(implosion_talent) or Enemies() <= 1 } or not Talent(implosion_talent) or Talent(implosion_talent) and not Talent(soul_conduit_talent) and Enemies() <= 3 } and { NotDeDemons(wild_imp) > 3 or PreviousGCDSpell(hand_of_guldan) } or PreviousGCDSpell(hand_of_guldan) and NotDeDemons(wild_imp) == 0 and DemonDuration(wild_imp) <= 0 or PreviousGCDSpell(implosion) and NotDeDemons(wild_imp) > 0 } and Spell(demonic_empowerment) or { NotDeDemons(dreadstalker) > 0 or NotDeDemons(darkglare) > 0 or NotDeDemons(doomguard) > 0 or NotDeDemons(infernal) > 0 or 0 > 0 } and Spell(demonic_empowerment) or not Talent(hand_of_doom_talent) and target.TimeToDie() > BaseDuration(doom_debuff) and { not target.DebuffPresent(doom_debuff) or target.DebuffRemaining(doom_debuff) < BaseDuration(doom_debuff) * 0.3 } and Spell(doom)
		{
			#arcane_torrent
			Spell(arcane_torrent_mana)
			#berserking
			Spell(berserking)
			#blood_fury
			Spell(blood_fury_sp)
			#soul_harvest
			Spell(soul_harvest)
			#potion,name=prolonged_power,if=buff.soul_harvest.remains|target.time_to_die<=70|trinket.proc.any.react
			if { BuffPresent(soul_harvest_buff) or target.TimeToDie() <= 70 or BuffPresent(trinket_proc_any_buff) } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
		}
	}
}

AddFunction DemonologyDefaultCdPostConditions
{
	DemonDuration(wild_imp) <= ExecuteTime(shadow_bolt) and { BuffPresent(demonic_synergy_buff) or Talent(soul_conduit_talent) or not Talent(soul_conduit_talent) and Enemies() > 1 or Demons(wild_imp) <= 4 } and Spell(implosion) or PreviousGCDSpell(hand_of_guldan) and { DemonDuration(wild_imp) <= 3 and BuffPresent(demonic_synergy_buff) or DemonDuration(wild_imp) <= 4 and Enemies() > 2 } and Spell(implosion) or { target.DebuffStacks(shadowflame_debuff) > 0 and target.DebuffRemaining(shadowflame_debuff) < CastTime(shadow_bolt) + TravelTime(shadowflame) or Charges(shadowflame) == 2 and SoulShards() < 5 } and Enemies() < 5 and Spell(shadowflame) or Spell(service_felguard) or { not Talent(summon_darkglare_talent) or Talent(power_trip_talent) } and { Enemies() < 3 or not Talent(implosion_talent) } and Spell(call_dreadstalkers) or SoulShards() >= 4 and not Talent(summon_darkglare_talent) and Spell(hand_of_guldan) or { PreviousGCDSpell(hand_of_guldan) or PreviousGCDSpell(call_dreadstalkers) or Talent(power_trip_talent) } and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) > 5 and SoulShards() < 3 and Spell(summon_darkglare) or SpellCooldown(call_dreadstalkers) <= CastTime(summon_darkglare) and { SoulShards() >= 3 or SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(summon_darkglare) or Talent(summon_darkglare_talent) and { Enemies() < 3 or not Talent(implosion_talent) } and { SpellCooldown(summon_darkglare) > 2 or PreviousGCDSpell(summon_darkglare) or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 3 or SpellCooldown(summon_darkglare) <= CastTime(call_dreadstalkers) and SoulShards() >= 1 and BuffPresent(demonic_calling_buff) } and Spell(call_dreadstalkers) or { SoulShards() >= 3 and PreviousGCDSpell(call_dreadstalkers) or SoulShards() >= 5 or SoulShards() >= 4 and SpellCooldown(summon_darkglare) > 2 } and Spell(hand_of_guldan) or { { Talent(power_trip_talent) and { not Talent(implosion_talent) or Enemies() <= 1 } or not Talent(implosion_talent) or Talent(implosion_talent) and not Talent(soul_conduit_talent) and Enemies() <= 3 } and { NotDeDemons(wild_imp) > 3 or PreviousGCDSpell(hand_of_guldan) } or PreviousGCDSpell(hand_of_guldan) and NotDeDemons(wild_imp) == 0 and DemonDuration(wild_imp) <= 0 or PreviousGCDSpell(implosion) and NotDeDemons(wild_imp) > 0 } and Spell(demonic_empowerment) or { NotDeDemons(dreadstalker) > 0 or NotDeDemons(darkglare) > 0 or NotDeDemons(doomguard) > 0 or NotDeDemons(infernal) > 0 or 0 > 0 } and Spell(demonic_empowerment) or not Talent(hand_of_doom_talent) and target.TimeToDie() > BaseDuration(doom_debuff) and { not target.DebuffPresent(doom_debuff) or target.DebuffRemaining(doom_debuff) < BaseDuration(doom_debuff) * 0.3 } and Spell(doom) or Charges(shadowflame) == 2 and Enemies() < 5 and Spell(shadowflame) or { DemonDuration(dreadstalker) > ExecuteTime(thalkiels_consumption) or Talent(implosion_talent) and Enemies() >= 3 } and Demons(wild_imp) > 3 and DemonDuration(wild_imp) > ExecuteTime(thalkiels_consumption) and Spell(thalkiels_consumption) or ManaPercent() <= 30 and Spell(life_tap) or Enemies() >= 3 and Spell(demonwrath) or Speed() > 0 and Spell(demonwrath) or Spell(demonbolt) or Spell(shadow_bolt) or Spell(life_tap)
}

### actions.precombat

AddFunction DemonologyPrecombatMainActions
{
	#demonic_empowerment
	Spell(demonic_empowerment)
	#demonbolt,if=talent.demonbolt.enabled
	if Talent(demonbolt_talent) Spell(demonbolt)
	#shadow_bolt,if=!talent.demonbolt.enabled
	if not Talent(demonbolt_talent) Spell(shadow_bolt)
}

AddFunction DemonologyPrecombatMainPostConditions
{
}

AddFunction DemonologyPrecombatShortCdActions
{
	#flask,type=whispered_pact
	#food,type=azshari_salad
	#summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
	if not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() Spell(summon_felguard)
}

AddFunction DemonologyPrecombatShortCdPostConditions
{
	Spell(demonic_empowerment) or Talent(demonbolt_talent) and Spell(demonbolt) or not Talent(demonbolt_talent) and Spell(shadow_bolt)
}

AddFunction DemonologyPrecombatCdActions
{
	unless not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_felguard)
	{
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
		if Talent(grimoire_of_supremacy_talent) and ArtifactTraitRank(lord_of_flames) > 0 Spell(summon_infernal)
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>1
		if Talent(grimoire_of_supremacy_talent) and Enemies() > 1 Spell(summon_infernal)
		#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies=1&artifact.lord_of_flames.rank=0
		if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and ArtifactTraitRank(lord_of_flames) == 0 Spell(summon_doomguard)
		#augmentation,type=defiled
		#snapshot_stats
		#potion,name=prolonged_power
		if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
	}
}

AddFunction DemonologyPrecombatCdPostConditions
{
	not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_felguard) or Spell(demonic_empowerment) or Talent(demonbolt_talent) and Spell(demonbolt) or not Talent(demonbolt_talent) and Spell(shadow_bolt)
}

### Demonology icons.

AddCheckBox(opt_warlock_demonology_aoe L(AOE) default specialization=demonology)

AddIcon checkbox=!opt_warlock_demonology_aoe enemies=1 help=shortcd specialization=demonology
{
	if not InCombat() DemonologyPrecombatShortCdActions()
	unless not InCombat() and DemonologyPrecombatShortCdPostConditions()
	{
		DemonologyDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_warlock_demonology_aoe help=shortcd specialization=demonology
{
	if not InCombat() DemonologyPrecombatShortCdActions()
	unless not InCombat() and DemonologyPrecombatShortCdPostConditions()
	{
		DemonologyDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=demonology
{
	if not InCombat() DemonologyPrecombatMainActions()
	unless not InCombat() and DemonologyPrecombatMainPostConditions()
	{
		DemonologyDefaultMainActions()
	}
}

AddIcon checkbox=opt_warlock_demonology_aoe help=aoe specialization=demonology
{
	if not InCombat() DemonologyPrecombatMainActions()
	unless not InCombat() and DemonologyPrecombatMainPostConditions()
	{
		DemonologyDefaultMainActions()
	}
}

AddIcon checkbox=!opt_warlock_demonology_aoe enemies=1 help=cd specialization=demonology
{
	if not InCombat() DemonologyPrecombatCdActions()
	unless not InCombat() and DemonologyPrecombatCdPostConditions()
	{
		DemonologyDefaultCdActions()
	}
}

AddIcon checkbox=opt_warlock_demonology_aoe help=cd specialization=demonology
{
	if not InCombat() DemonologyPrecombatCdActions()
	unless not InCombat() and DemonologyPrecombatCdPostConditions()
	{
		DemonologyDefaultCdActions()
	}
}

### Required symbols
# 132369
# 132379
# arcane_torrent_mana
# berserking
# blood_fury_sp
# call_dreadstalkers
# demonbolt
# demonbolt_talent
# demonic_calling_buff
# demonic_empowerment
# demonic_power_buff
# demonic_synergy_buff
# demonwrath
# doom
# doom_debuff
# grimoire_of_sacrifice_talent
# grimoire_of_supremacy_talent
# hand_of_doom_talent
# hand_of_guldan
# implosion
# implosion_talent
# life_tap
# lord_of_flames
# power_trip_talent
# prolonged_power_potion
# service_felguard
# shadow_bolt
# shadowflame
# shadowflame_debuff
# sindorei_spite_icd
# soul_conduit_talent
# soul_harvest
# soul_harvest_buff
# summon_darkglare
# summon_darkglare_talent
# summon_doomguard
# summon_felguard
# summon_infernal
# thalkiels_consumption
]]
    __Scripts.OvaleScripts:RegisterScript("WARLOCK", "demonology", name, desc, code, "script")
end
do
    local name = "simulationcraft_warlock_destruction_t19p"
    local desc = "[7.0] SimulationCraft: Warlock_Destruction_T19P"
    local code = [[
# Based on SimulationCraft profile "Warlock_Destruction_T19P".
#	class=warlock
#	spec=destruction
#	talents=2203022
#	pet=imp

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_warlock_spells)

AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=destruction)

### actions.default

AddFunction DestructionDefaultMainActions
{
	#immolate,if=remains<=tick_time
	if target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) Spell(immolate)
	#immolate,cycle_targets=1,if=active_enemies>1&remains<=tick_time&(!talent.roaring_blaze.enabled|(!debuff.roaring_blaze.remains&action.conflagrate.charges<2+set_bonus.tier19_4pc))
	if Enemies() > 1 and target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and { not Talent(roaring_blaze_talent) or not target.DebuffPresent(roaring_blaze_debuff) and Charges(conflagrate) < 2 + ArmorSetBonus(T19 4) } Spell(immolate)
	#immolate,if=talent.roaring_blaze.enabled&remains<=duration&!debuff.roaring_blaze.remains&target.time_to_die>10&(action.conflagrate.charges=2+set_bonus.tier19_4pc|(action.conflagrate.charges>=1+set_bonus.tier19_4pc&action.conflagrate.recharge_time<cast_time+gcd)|target.time_to_die<24)
	if Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) and not target.DebuffPresent(roaring_blaze_debuff) and target.TimeToDie() > 10 and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(immolate) + GCD() or target.TimeToDie() < 24 } Spell(immolate)
	#shadowburn,if=buff.conflagration_of_chaos.remains<=action.chaos_bolt.cast_time
	if BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) Spell(shadowburn)
	#shadowburn,if=(charges=1+set_bonus.tier19_4pc&recharge_time<action.chaos_bolt.cast_time|charges=2+set_bonus.tier19_4pc)&soul_shard<5
	if { Charges(shadowburn) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(shadowburn) < CastTime(chaos_bolt) or Charges(shadowburn) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 Spell(shadowburn)
	#conflagrate,if=talent.roaring_blaze.enabled&(charges=2+set_bonus.tier19_4pc|(charges>=1+set_bonus.tier19_4pc&recharge_time<gcd)|target.time_to_die<24)
	if Talent(roaring_blaze_talent) and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < GCD() or target.TimeToDie() < 24 } Spell(conflagrate)
	#conflagrate,if=talent.roaring_blaze.enabled&debuff.roaring_blaze.stack>0&dot.immolate.remains>dot.immolate.duration*0.3&(active_enemies=1|soul_shard<3)&soul_shard<5
	if Talent(roaring_blaze_talent) and target.DebuffStacks(roaring_blaze_debuff) > 0 and target.DebuffRemaining(immolate_debuff) > target.DebuffDuration(immolate_debuff) * 0.3 and { Enemies() == 1 or SoulShards() < 3 } and SoulShards() < 5 Spell(conflagrate)
	#conflagrate,if=!talent.roaring_blaze.enabled&buff.backdraft.stack<3&buff.conflagration_of_chaos.remains<=action.chaos_bolt.cast_time
	if not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) Spell(conflagrate)
	#conflagrate,if=!talent.roaring_blaze.enabled&buff.backdraft.stack<3&(charges=1+set_bonus.tier19_4pc&recharge_time<action.chaos_bolt.cast_time|charges=2+set_bonus.tier19_4pc)&soul_shard<5
	if not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and { Charges(conflagrate) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(chaos_bolt) or Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 Spell(conflagrate)
	#life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
	if Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() Spell(life_tap)
	#channel_demonfire,if=dot.immolate.remains>cast_time
	if target.DebuffRemaining(immolate_debuff) > CastTime(channel_demonfire) Spell(channel_demonfire)
	#rain_of_fire,if=active_enemies>=3&cooldown.havoc.remains<=12&!talent.wreak_havoc.enabled
	if Enemies() >= 3 and SpellCooldown(havoc) <= 12 and not Talent(wreak_havoc_talent) Spell(rain_of_fire)
	#rain_of_fire,if=active_enemies>=6&talent.wreak_havoc.enabled
	if Enemies() >= 6 and Talent(wreak_havoc_talent) Spell(rain_of_fire)
	#life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3
	if Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 Spell(life_tap)
	#chaos_bolt,if=(cooldown.havoc.remains>12&cooldown.havoc.remains|active_enemies<3|talent.wreak_havoc.enabled&active_enemies<6)&(set_bonus.tier19_4pc=0|!talent.eradication.enabled|buff.embrace_chaos.remains<=cast_time|soul_shard>=3)
	if { SpellCooldown(havoc) > 12 and SpellCooldown(havoc) > 0 or Enemies() < 3 or Talent(wreak_havoc_talent) and Enemies() < 6 } and { ArmorSetBonus(T19 4) == 0 or not Talent(eradication_talent) or BuffRemaining(embrace_chaos_buff) <= CastTime(chaos_bolt) or SoulShards() >= 3 } Spell(chaos_bolt)
	#shadowburn
	Spell(shadowburn)
	#conflagrate,if=!talent.roaring_blaze.enabled&buff.backdraft.stack<3
	if not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 Spell(conflagrate)
	#immolate,if=!talent.roaring_blaze.enabled&remains<=duration*0.3
	if not Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) * 0.3 Spell(immolate)
	#incinerate
	Spell(incinerate)
	#life_tap
	Spell(life_tap)
}

AddFunction DestructionDefaultMainPostConditions
{
}

AddFunction DestructionDefaultShortCdActions
{
	#havoc,target=2,if=active_enemies>1&(active_enemies<4|talent.wreak_havoc.enabled&active_enemies<6)&!debuff.havoc.remains
	if Enemies() > 1 and { Enemies() < 4 or Talent(wreak_havoc_talent) and Enemies() < 6 } and not target.DebuffPresent(havoc_debuff) and Enemies() > 1 Spell(havoc text=other)
	#dimensional_rift,if=charges=3
	if Charges(dimensional_rift) == 3 Spell(dimensional_rift)

	unless target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and Spell(immolate) or Enemies() > 1 and target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and { not Talent(roaring_blaze_talent) or not target.DebuffPresent(roaring_blaze_debuff) and Charges(conflagrate) < 2 + ArmorSetBonus(T19 4) } and Spell(immolate) or Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) and not target.DebuffPresent(roaring_blaze_debuff) and target.TimeToDie() > 10 and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(immolate) + GCD() or target.TimeToDie() < 24 } and Spell(immolate) or BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(shadowburn) or { Charges(shadowburn) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(shadowburn) < CastTime(chaos_bolt) or Charges(shadowburn) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(shadowburn) or Talent(roaring_blaze_talent) and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < GCD() or target.TimeToDie() < 24 } and Spell(conflagrate) or Talent(roaring_blaze_talent) and target.DebuffStacks(roaring_blaze_debuff) > 0 and target.DebuffRemaining(immolate_debuff) > target.DebuffDuration(immolate_debuff) * 0.3 and { Enemies() == 1 or SoulShards() < 3 } and SoulShards() < 5 and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and { Charges(conflagrate) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(chaos_bolt) or Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(conflagrate) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap)
	{
		#dimensional_rift,if=equipped.144369&!buff.lessons_of_spacetime.remains&((!talent.grimoire_of_supremacy.enabled&!cooldown.summon_doomguard.remains)|(talent.grimoire_of_service.enabled&!cooldown.service_pet.remains)|(talent.soul_harvest.enabled&!cooldown.soul_harvest.remains))
		if HasEquippedItem(144369) and not BuffPresent(lessons_of_spacetime_buff) and { not Talent(grimoire_of_supremacy_talent) and not SpellCooldown(summon_doomguard) > 0 or Talent(grimoire_of_service_talent) and not SpellCooldown(service_pet) > 0 or Talent(soul_harvest_talent) and not SpellCooldown(soul_harvest) > 0 } Spell(dimensional_rift)
		#service_pet
		Spell(service_imp)

		unless target.DebuffRemaining(immolate_debuff) > CastTime(channel_demonfire) and Spell(channel_demonfire)
		{
			#havoc,if=active_enemies=1&talent.wreak_havoc.enabled&equipped.132375&!debuff.havoc.remains
			if Enemies() == 1 and Talent(wreak_havoc_talent) and HasEquippedItem(132375) and not target.DebuffPresent(havoc_debuff) and Enemies() > 1 Spell(havoc)

			unless Enemies() >= 3 and SpellCooldown(havoc) <= 12 and not Talent(wreak_havoc_talent) and Spell(rain_of_fire) or Enemies() >= 6 and Talent(wreak_havoc_talent) and Spell(rain_of_fire)
			{
				#dimensional_rift,if=!equipped.144369|charges>1|((!talent.grimoire_of_service.enabled|recharge_time<cooldown.service_pet.remains)&(!talent.soul_harvest.enabled|recharge_time<cooldown.soul_harvest.remains)&(!talent.grimoire_of_supremacy.enabled|recharge_time<cooldown.summon_doomguard.remains))
				if not HasEquippedItem(144369) or Charges(dimensional_rift) > 1 or { not Talent(grimoire_of_service_talent) or SpellChargeCooldown(dimensional_rift) < SpellCooldown(service_pet) } and { not Talent(soul_harvest_talent) or SpellChargeCooldown(dimensional_rift) < SpellCooldown(soul_harvest) } and { not Talent(grimoire_of_supremacy_talent) or SpellChargeCooldown(dimensional_rift) < SpellCooldown(summon_doomguard) } Spell(dimensional_rift)

				unless Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 and Spell(life_tap)
				{
					#cataclysm
					Spell(cataclysm)
				}
			}
		}
	}
}

AddFunction DestructionDefaultShortCdPostConditions
{
	target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and Spell(immolate) or Enemies() > 1 and target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and { not Talent(roaring_blaze_talent) or not target.DebuffPresent(roaring_blaze_debuff) and Charges(conflagrate) < 2 + ArmorSetBonus(T19 4) } and Spell(immolate) or Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) and not target.DebuffPresent(roaring_blaze_debuff) and target.TimeToDie() > 10 and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(immolate) + GCD() or target.TimeToDie() < 24 } and Spell(immolate) or BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(shadowburn) or { Charges(shadowburn) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(shadowburn) < CastTime(chaos_bolt) or Charges(shadowburn) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(shadowburn) or Talent(roaring_blaze_talent) and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < GCD() or target.TimeToDie() < 24 } and Spell(conflagrate) or Talent(roaring_blaze_talent) and target.DebuffStacks(roaring_blaze_debuff) > 0 and target.DebuffRemaining(immolate_debuff) > target.DebuffDuration(immolate_debuff) * 0.3 and { Enemies() == 1 or SoulShards() < 3 } and SoulShards() < 5 and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and { Charges(conflagrate) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(chaos_bolt) or Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(conflagrate) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap) or target.DebuffRemaining(immolate_debuff) > CastTime(channel_demonfire) and Spell(channel_demonfire) or Enemies() >= 3 and SpellCooldown(havoc) <= 12 and not Talent(wreak_havoc_talent) and Spell(rain_of_fire) or Enemies() >= 6 and Talent(wreak_havoc_talent) and Spell(rain_of_fire) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 and Spell(life_tap) or { SpellCooldown(havoc) > 12 and SpellCooldown(havoc) > 0 or Enemies() < 3 or Talent(wreak_havoc_talent) and Enemies() < 6 } and { ArmorSetBonus(T19 4) == 0 or not Talent(eradication_talent) or BuffRemaining(embrace_chaos_buff) <= CastTime(chaos_bolt) or SoulShards() >= 3 } and Spell(chaos_bolt) or Spell(shadowburn) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and Spell(conflagrate) or not Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) * 0.3 and Spell(immolate) or Spell(incinerate) or Spell(life_tap)
}

AddFunction DestructionDefaultCdActions
{
	unless Enemies() > 1 and { Enemies() < 4 or Talent(wreak_havoc_talent) and Enemies() < 6 } and not target.DebuffPresent(havoc_debuff) and Enemies() > 1 and Spell(havoc text=other) or Charges(dimensional_rift) == 3 and Spell(dimensional_rift) or target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and Spell(immolate) or Enemies() > 1 and target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and { not Talent(roaring_blaze_talent) or not target.DebuffPresent(roaring_blaze_debuff) and Charges(conflagrate) < 2 + ArmorSetBonus(T19 4) } and Spell(immolate) or Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) and not target.DebuffPresent(roaring_blaze_debuff) and target.TimeToDie() > 10 and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(immolate) + GCD() or target.TimeToDie() < 24 } and Spell(immolate)
	{
		#berserking
		Spell(berserking)
		#blood_fury
		Spell(blood_fury_sp)
		#arcane_torrent
		Spell(arcane_torrent_mana)
		#potion,name=deadly_grace,if=(buff.soul_harvest.remains|trinket.proc.any.react|target.time_to_die<=45)
		if { BuffPresent(soul_harvest_buff) or BuffPresent(trinket_proc_any_buff) or target.TimeToDie() <= 45 } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(deadly_grace_potion usable=1)

		unless BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(shadowburn) or { Charges(shadowburn) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(shadowburn) < CastTime(chaos_bolt) or Charges(shadowburn) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(shadowburn) or Talent(roaring_blaze_talent) and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < GCD() or target.TimeToDie() < 24 } and Spell(conflagrate) or Talent(roaring_blaze_talent) and target.DebuffStacks(roaring_blaze_debuff) > 0 and target.DebuffRemaining(immolate_debuff) > target.DebuffDuration(immolate_debuff) * 0.3 and { Enemies() == 1 or SoulShards() < 3 } and SoulShards() < 5 and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and { Charges(conflagrate) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(chaos_bolt) or Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(conflagrate) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap) or HasEquippedItem(144369) and not BuffPresent(lessons_of_spacetime_buff) and { not Talent(grimoire_of_supremacy_talent) and not SpellCooldown(summon_doomguard) > 0 or Talent(grimoire_of_service_talent) and not SpellCooldown(service_pet) > 0 or Talent(soul_harvest_talent) and not SpellCooldown(soul_harvest) > 0 } and Spell(dimensional_rift) or Spell(service_imp)
		{
			#summon_infernal,if=artifact.lord_of_flames.rank>0&!buff.lord_of_flames.remains
			if ArtifactTraitRank(lord_of_flames) > 0 and not BuffPresent(lord_of_flames_buff) Spell(summon_infernal)
			#summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
			if not Talent(grimoire_of_supremacy_talent) and Enemies() <= 2 and { target.TimeToDie() > 180 or target.HealthPercent() <= 20 or target.TimeToDie() < 30 } Spell(summon_doomguard)
			#summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>2
			if not Talent(grimoire_of_supremacy_talent) and Enemies() > 2 Spell(summon_infernal)
			#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&artifact.lord_of_flames.rank>0&buff.lord_of_flames.remains&!pet.doomguard.active
			if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and ArtifactTraitRank(lord_of_flames) > 0 and BuffPresent(lord_of_flames_buff) and not pet.Present() Spell(summon_doomguard)
			#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
			if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and HasEquippedItem(132379) and not SpellCooldown(sindorei_spite_icd) > 0 Spell(summon_doomguard)
			#summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
			if Talent(grimoire_of_supremacy_talent) and Enemies() > 1 and HasEquippedItem(132379) and not SpellCooldown(sindorei_spite_icd) > 0 Spell(summon_infernal)
			#soul_harvest
			Spell(soul_harvest)
		}
	}
}

AddFunction DestructionDefaultCdPostConditions
{
	Enemies() > 1 and { Enemies() < 4 or Talent(wreak_havoc_talent) and Enemies() < 6 } and not target.DebuffPresent(havoc_debuff) and Enemies() > 1 and Spell(havoc text=other) or Charges(dimensional_rift) == 3 and Spell(dimensional_rift) or target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and Spell(immolate) or Enemies() > 1 and target.DebuffRemaining(immolate_debuff) <= target.TickTime(immolate_debuff) and { not Talent(roaring_blaze_talent) or not target.DebuffPresent(roaring_blaze_debuff) and Charges(conflagrate) < 2 + ArmorSetBonus(T19 4) } and Spell(immolate) or Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) and not target.DebuffPresent(roaring_blaze_debuff) and target.TimeToDie() > 10 and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(immolate) + GCD() or target.TimeToDie() < 24 } and Spell(immolate) or BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(shadowburn) or { Charges(shadowburn) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(shadowburn) < CastTime(chaos_bolt) or Charges(shadowburn) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(shadowburn) or Talent(roaring_blaze_talent) and { Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) or Charges(conflagrate) >= 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < GCD() or target.TimeToDie() < 24 } and Spell(conflagrate) or Talent(roaring_blaze_talent) and target.DebuffStacks(roaring_blaze_debuff) > 0 and target.DebuffRemaining(immolate_debuff) > target.DebuffDuration(immolate_debuff) * 0.3 and { Enemies() == 1 or SoulShards() < 3 } and SoulShards() < 5 and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and BuffRemaining(conflagration_of_chaos_buff) <= CastTime(chaos_bolt) and Spell(conflagrate) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and { Charges(conflagrate) == 1 + ArmorSetBonus(T19 4) and SpellChargeCooldown(conflagrate) < CastTime(chaos_bolt) or Charges(conflagrate) == 2 + ArmorSetBonus(T19 4) } and SoulShards() < 5 and Spell(conflagrate) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) <= GCD() and Spell(life_tap) or HasEquippedItem(144369) and not BuffPresent(lessons_of_spacetime_buff) and { not Talent(grimoire_of_supremacy_talent) and not SpellCooldown(summon_doomguard) > 0 or Talent(grimoire_of_service_talent) and not SpellCooldown(service_pet) > 0 or Talent(soul_harvest_talent) and not SpellCooldown(soul_harvest) > 0 } and Spell(dimensional_rift) or Spell(service_imp) or target.DebuffRemaining(immolate_debuff) > CastTime(channel_demonfire) and Spell(channel_demonfire) or Enemies() == 1 and Talent(wreak_havoc_talent) and HasEquippedItem(132375) and not target.DebuffPresent(havoc_debuff) and Enemies() > 1 and Spell(havoc) or Enemies() >= 3 and SpellCooldown(havoc) <= 12 and not Talent(wreak_havoc_talent) and Spell(rain_of_fire) or Enemies() >= 6 and Talent(wreak_havoc_talent) and Spell(rain_of_fire) or { not HasEquippedItem(144369) or Charges(dimensional_rift) > 1 or { not Talent(grimoire_of_service_talent) or SpellChargeCooldown(dimensional_rift) < SpellCooldown(service_pet) } and { not Talent(soul_harvest_talent) or SpellChargeCooldown(dimensional_rift) < SpellCooldown(soul_harvest) } and { not Talent(grimoire_of_supremacy_talent) or SpellChargeCooldown(dimensional_rift) < SpellCooldown(summon_doomguard) } } and Spell(dimensional_rift) or Talent(empowered_life_tap_talent) and BuffRemaining(empowered_life_tap_buff) < BaseDuration(empowered_life_tap_buff) * 0.3 and Spell(life_tap) or { SpellCooldown(havoc) > 12 and SpellCooldown(havoc) > 0 or Enemies() < 3 or Talent(wreak_havoc_talent) and Enemies() < 6 } and { ArmorSetBonus(T19 4) == 0 or not Talent(eradication_talent) or BuffRemaining(embrace_chaos_buff) <= CastTime(chaos_bolt) or SoulShards() >= 3 } and Spell(chaos_bolt) or Spell(shadowburn) or not Talent(roaring_blaze_talent) and BuffStacks(backdraft_buff) < 3 and Spell(conflagrate) or not Talent(roaring_blaze_talent) and target.DebuffRemaining(immolate_debuff) <= BaseDuration(immolate_debuff) * 0.3 and Spell(immolate) or Spell(incinerate) or Spell(life_tap)
}

### actions.precombat

AddFunction DestructionPrecombatMainActions
{
	#augmentation,type=defiled
	#snapshot_stats
	#grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
	if Talent(grimoire_of_sacrifice_talent) and pet.Present() Spell(grimoire_of_sacrifice)
	#life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remains
	if Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) Spell(life_tap)
	#chaos_bolt
	Spell(chaos_bolt)
}

AddFunction DestructionPrecombatMainPostConditions
{
}

AddFunction DestructionPrecombatShortCdActions
{
	#flask,type=whispered_pact
	#food,type=azshari_salad
	#summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
	if not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() Spell(summon_imp)
}

AddFunction DestructionPrecombatShortCdPostConditions
{
	Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) and Spell(life_tap) or Spell(chaos_bolt)
}

AddFunction DestructionPrecombatCdActions
{
	unless not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_imp)
	{
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0
		if Talent(grimoire_of_supremacy_talent) and ArtifactTraitRank(lord_of_flames) > 0 Spell(summon_infernal)
		#summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>1
		if Talent(grimoire_of_supremacy_talent) and Enemies() > 1 Spell(summon_infernal)
		#summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies=1&artifact.lord_of_flames.rank=0
		if Talent(grimoire_of_supremacy_talent) and Enemies() == 1 and ArtifactTraitRank(lord_of_flames) == 0 Spell(summon_doomguard)

		unless Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) and Spell(life_tap)
		{
			#potion,name=prolonged_power
			if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
		}
	}
}

AddFunction DestructionPrecombatCdPostConditions
{
	not Talent(grimoire_of_supremacy_talent) and { not Talent(grimoire_of_sacrifice_talent) or BuffExpires(demonic_power_buff) } and not pet.Present() and Spell(summon_imp) or Talent(empowered_life_tap_talent) and not BuffPresent(empowered_life_tap_buff) and Spell(life_tap) or Spell(chaos_bolt)
}

### Destruction icons.

AddCheckBox(opt_warlock_destruction_aoe L(AOE) default specialization=destruction)

AddIcon checkbox=!opt_warlock_destruction_aoe enemies=1 help=shortcd specialization=destruction
{
	if not InCombat() DestructionPrecombatShortCdActions()
	unless not InCombat() and DestructionPrecombatShortCdPostConditions()
	{
		DestructionDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_warlock_destruction_aoe help=shortcd specialization=destruction
{
	if not InCombat() DestructionPrecombatShortCdActions()
	unless not InCombat() and DestructionPrecombatShortCdPostConditions()
	{
		DestructionDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=destruction
{
	if not InCombat() DestructionPrecombatMainActions()
	unless not InCombat() and DestructionPrecombatMainPostConditions()
	{
		DestructionDefaultMainActions()
	}
}

AddIcon checkbox=opt_warlock_destruction_aoe help=aoe specialization=destruction
{
	if not InCombat() DestructionPrecombatMainActions()
	unless not InCombat() and DestructionPrecombatMainPostConditions()
	{
		DestructionDefaultMainActions()
	}
}

AddIcon checkbox=!opt_warlock_destruction_aoe enemies=1 help=cd specialization=destruction
{
	if not InCombat() DestructionPrecombatCdActions()
	unless not InCombat() and DestructionPrecombatCdPostConditions()
	{
		DestructionDefaultCdActions()
	}
}

AddIcon checkbox=opt_warlock_destruction_aoe help=cd specialization=destruction
{
	if not InCombat() DestructionPrecombatCdActions()
	unless not InCombat() and DestructionPrecombatCdPostConditions()
	{
		DestructionDefaultCdActions()
	}
}

### Required symbols
# 132375
# 132379
# 144369
# arcane_torrent_mana
# backdraft_buff
# berserking
# blood_fury_sp
# cataclysm
# channel_demonfire
# chaos_bolt
# conflagrate
# conflagration_of_chaos_buff
# deadly_grace_potion
# demonic_power_buff
# dimensional_rift
# doomguard
# embrace_chaos_buff
# empowered_life_tap_buff
# empowered_life_tap_talent
# eradication_talent
# grimoire_of_sacrifice
# grimoire_of_sacrifice_talent
# grimoire_of_service_talent
# grimoire_of_supremacy_talent
# havoc
# havoc_debuff
# immolate
# immolate_debuff
# incinerate
# lessons_of_spacetime_buff
# life_tap
# lord_of_flames
# lord_of_flames_buff
# prolonged_power_potion
# rain_of_fire
# roaring_blaze_debuff
# roaring_blaze_talent
# service_imp
# service_pet
# shadowburn
# sindorei_spite_icd
# soul_harvest
# soul_harvest_buff
# soul_harvest_talent
# summon_doomguard
# summon_imp
# summon_infernal
# wreak_havoc_talent
]]
    __Scripts.OvaleScripts:RegisterScript("WARLOCK", "destruction", name, desc, code, "script")
end
end)
