local __addonName, __addon = ...
__addon.require(__addonName, __addon, "./src/scripts\ovale_deathknight", { "./src/Scripts" }, function(__exports, __Scripts)
do
    local name = "icyveins_deathknight_blood"
    local desc = "[7.0] Icy-Veins: DeathKnight Blood"
    local code = [[

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_deathknight_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=blood)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=blood)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=blood)

AddFunction BloodDefaultShortCDActions
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
	if not BuffPresent(rune_tap_buff) Spell(rune_tap)
	if Rune() <= 2 Spell(blood_tap)
}

AddFunction BloodDefaultMainActions
{
	BloodHealMe()
	if InCombat() and BuffExpires(bone_shield_buff 3) Spell(marrowrend)
	if target.DebuffRefreshable(blood_plague_debuff) Spell(blood_boil)
	if not BuffPresent(death_and_decay_buff) and BuffPresent(crimson_scourge_buff) and Talent(rapid_decomposition_talent) Spell(death_and_decay)
	if RunicPower() >= 100 and target.TimeToDie() >= 10 Spell(bonestorm)
	if RunicPowerDeficit() <= 20 Spell(death_strike)
	if BuffStacks(bone_shield_buff) <= 2+4*Talent(ossuary_talent) Spell(marrowrend)
	if not BuffPresent(death_and_decay_buff) and Rune() >= 3 and Talent(rapid_decomposition_talent) Spell(death_and_decay)
	if not target.DebuffPresent(mark_of_blood_debuff) Spell(mark_of_blood)
	if Rune() >= 3 or RunicPower() < 45 Spell(heart_strike)
	Spell(consumption)
	Spell(blood_boil)
}

AddFunction BloodDefaultAoEActions
{
	BloodHealMe()
	if RunicPower() >= 100 Spell(bonestorm)
	if InCombat() and BuffExpires(bone_shield_buff 3) Spell(marrowrend)
	if DebuffCountOnAny(blood_plague_debuff) < Enemies(tagged=1) Spell(blood_boil)
	if not BuffPresent(death_and_decay_buff) and BuffPresent(crimson_scourge_buff) Spell(death_and_decay)
	if RunicPowerDeficit() <= 20 Spell(death_strike)
	if BuffStacks(bone_shield_buff) <= 2+4*Talent(ossuary_talent) Spell(marrowrend)
	if not BuffPresent(death_and_decay_buff) and Enemies() >= 3 Spell(death_and_decay)
	if not target.DebuffPresent(mark_of_blood_debuff) Spell(mark_of_blood)
	if Rune() >= 3 or RunicPower() < 45 Spell(heart_strike)
	Spell(consumption)
	Spell(blood_boil)
}

AddFunction BloodHealMe
{
	if HealthPercent() <= 70 Spell(death_strike)
	if (DamageTaken(5) * 0.2) > (Health() / 100 * 25) Spell(death_strike)
	if (BuffStacks(bone_shield_buff) * 3) > (100 - HealthPercent()) Spell(tombstone)
	if HealthPercent() <= 70 Spell(consumption)
}

AddFunction BloodDefaultCdActions
{
	BloodInterruptActions()
	if IncomingDamage(1.5 magic=1) > 0 spell(antimagic_shell)
	if (HasEquippedItem(shifting_cosmic_sliver)) Spell(icebound_fortitude)
	Item(Trinket0Slot usable=1 text=13)
	Item(Trinket1Slot usable=1 text=14)
	Spell(vampiric_blood)
	Spell(icebound_fortitude)
	if target.InRange(blood_mirror) Spell(blood_mirror)
	Spell(dancing_rune_weapon)
	if BuffStacks(bone_shield_buff) >= 5 Spell(tombstone)
	if CheckBoxOn(opt_use_consumables) Item(unbending_potion usable=1)
	UseRacialSurvivalActions()
}

AddFunction BloodInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(mind_freeze) and target.IsInterruptible() Spell(mind_freeze)
		if target.InRange(asphyxiate) and not target.Classification(worldboss) Spell(asphyxiate)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_runicpower)
		if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
	}
}

AddCheckBox(opt_deathknight_blood_aoe L(AOE) default specialization=blood)

AddIcon help=shortcd specialization=blood
{
	BloodDefaultShortCDActions()
}

AddIcon enemies=1 help=main specialization=blood
{
	BloodDefaultMainActions()
}

AddIcon checkbox=opt_deathknight_blood_aoe help=aoe specialization=blood
{
	BloodDefaultAoEActions()
}

AddIcon help=cd specialization=blood
{
	#if not InCombat() ProtectionPrecombatCdActions()
	BloodDefaultCdActions()
}
]]
    __Scripts.OvaleScripts:RegisterScript("DEATHKNIGHT", "blood", name, desc, code, "script")
end
do
    local name = "simulationcraft_death_knight_frost_t19p"
    local desc = "[7.0] SimulationCraft: Death_Knight_Frost_T19P"
    local code = [[
# Based on SimulationCraft profile "Death_Knight_Frost_T19P".
#	class=deathknight
#	spec=frost
#	talents=3210031

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_deathknight_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=frost)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=frost)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=frost)

AddFunction FrostInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(mind_freeze) and target.IsInterruptible() Spell(mind_freeze)
		if target.Distance(less 12) and not target.Classification(worldboss) Spell(blinding_sleet)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_runicpower)
		if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
	}
}

AddFunction FrostUseItemActions
{
	Item(Trinket0Slot text=13 usable=1)
	Item(Trinket1Slot text=14 usable=1)
}

AddFunction FrostGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
}

### actions.default

AddFunction FrostDefaultMainActions
{
	#call_action_list,name=cds
	FrostCdsMainActions()

	unless FrostCdsMainPostConditions()
	{
		#run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<15
		if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 FrostBosPoolingMainActions()

		unless Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 and FrostBosPoolingMainPostConditions()
		{
			#run_action_list,name=bos_ticking,if=talent.breath_of_sindragosa.enabled&dot.breath_of_sindragosa.ticking
			if Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) FrostBosTickingMainActions()

			unless Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) and FrostBosTickingMainPostConditions()
			{
				#run_action_list,name=obliteration,if=buff.obliteration.up
				if BuffPresent(obliteration_buff) FrostObliterationMainActions()

				unless BuffPresent(obliteration_buff) and FrostObliterationMainPostConditions()
				{
					#call_action_list,name=standard
					FrostStandardMainActions()
				}
			}
		}
	}
}

AddFunction FrostDefaultMainPostConditions
{
	FrostCdsMainPostConditions() or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 and FrostBosPoolingMainPostConditions() or Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) and FrostBosTickingMainPostConditions() or BuffPresent(obliteration_buff) and FrostObliterationMainPostConditions() or FrostStandardMainPostConditions()
}

AddFunction FrostDefaultShortCdActions
{
	#auto_attack
	FrostGetInMeleeRange()
	#call_action_list,name=cds
	FrostCdsShortCdActions()

	unless FrostCdsShortCdPostConditions()
	{
		#run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<15
		if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 FrostBosPoolingShortCdActions()

		unless Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 and FrostBosPoolingShortCdPostConditions()
		{
			#run_action_list,name=bos_ticking,if=talent.breath_of_sindragosa.enabled&dot.breath_of_sindragosa.ticking
			if Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) FrostBosTickingShortCdActions()

			unless Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) and FrostBosTickingShortCdPostConditions()
			{
				#run_action_list,name=obliteration,if=buff.obliteration.up
				if BuffPresent(obliteration_buff) FrostObliterationShortCdActions()

				unless BuffPresent(obliteration_buff) and FrostObliterationShortCdPostConditions()
				{
					#call_action_list,name=standard
					FrostStandardShortCdActions()
				}
			}
		}
	}
}

AddFunction FrostDefaultShortCdPostConditions
{
	FrostCdsShortCdPostConditions() or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 and FrostBosPoolingShortCdPostConditions() or Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) and FrostBosTickingShortCdPostConditions() or BuffPresent(obliteration_buff) and FrostObliterationShortCdPostConditions() or FrostStandardShortCdPostConditions()
}

AddFunction FrostDefaultCdActions
{
	#mind_freeze
	FrostInterruptActions()
	#call_action_list,name=cds
	FrostCdsCdActions()

	unless FrostCdsCdPostConditions()
	{
		#run_action_list,name=bos_pooling,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains<15
		if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 FrostBosPoolingCdActions()

		unless Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 and FrostBosPoolingCdPostConditions()
		{
			#run_action_list,name=bos_ticking,if=talent.breath_of_sindragosa.enabled&dot.breath_of_sindragosa.ticking
			if Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) FrostBosTickingCdActions()

			unless Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) and FrostBosTickingCdPostConditions()
			{
				#run_action_list,name=obliteration,if=buff.obliteration.up
				if BuffPresent(obliteration_buff) FrostObliterationCdActions()

				unless BuffPresent(obliteration_buff) and FrostObliterationCdPostConditions()
				{
					#call_action_list,name=standard
					FrostStandardCdActions()
				}
			}
		}
	}
}

AddFunction FrostDefaultCdPostConditions
{
	FrostCdsCdPostConditions() or Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) < 15 and FrostBosPoolingCdPostConditions() or Talent(breath_of_sindragosa_talent) and BuffPresent(breath_of_sindragosa_buff) and FrostBosTickingCdPostConditions() or BuffPresent(obliteration_buff) and FrostObliterationCdPostConditions() or FrostStandardCdPostConditions()
}

### actions.bos_pooling

AddFunction FrostBosPoolingMainActions
{
	#remorseless_winter,if=talent.gathering_storm.enabled
	if Talent(gathering_storm_talent) Spell(remorseless_winter)
	#howling_blast,if=buff.rime.react&rune.time_to_4<(gcd*2)
	if BuffPresent(rime_buff) and TimeToRunes(4) < GCD() * 2 Spell(howling_blast)
	#obliterate,if=rune.time_to_6<gcd&!talent.gathering_storm.enabled
	if TimeToRunes(6) < GCD() and not Talent(gathering_storm_talent) Spell(obliterate)
	#obliterate,if=rune.time_to_4<gcd&(cooldown.breath_of_sindragosa.remains|runic_power<70)
	if TimeToRunes(4) < GCD() and { SpellCooldown(breath_of_sindragosa) > 0 or RunicPower() < 70 } Spell(obliterate)
	#frost_strike,if=runic_power>=95&set_bonus.tier19_4pc&cooldown.breath_of_sindragosa.remains&(!talent.shattering_strikes.enabled|debuff.razorice.stack<5|cooldown.breath_of_sindragosa.remains>6)
	if RunicPower() >= 95 and ArmorSetBonus(T19 4) and SpellCooldown(breath_of_sindragosa) > 0 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } Spell(frost_strike)
	#remorseless_winter,if=buff.rime.react&equipped.perseverance_of_the_ebon_martyr
	if BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) Spell(remorseless_winter)
	#howling_blast,if=buff.rime.react&(buff.remorseless_winter.up|cooldown.remorseless_winter.remains>gcd|(!equipped.perseverance_of_the_ebon_martyr&!talent.gathering_storm.enabled))
	if BuffPresent(rime_buff) and { BuffPresent(remorseless_winter_buff) or SpellCooldown(remorseless_winter) > GCD() or not HasEquippedItem(perseverance_of_the_ebon_martyr) and not Talent(gathering_storm_talent) } Spell(howling_blast)
	#obliterate,if=!buff.rime.react&!(talent.gathering_storm.enabled&!(cooldown.remorseless_winter.remains>(gcd*2)|rune>4))&rune>3
	if not BuffPresent(rime_buff) and not { Talent(gathering_storm_talent) and not { SpellCooldown(remorseless_winter) > GCD() * 2 or Rune() >= 5 } } and Rune() >= 4 Spell(obliterate)
	#frost_strike,if=runic_power>=70&(!talent.shattering_strikes.enabled|debuff.razorice.stack<5|cooldown.breath_of_sindragosa.remains>rune.time_to_4)
	if RunicPower() >= 70 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) } Spell(frost_strike)
	#frostscythe,if=buff.killing_machine.up&(!equipped.koltiras_newfound_will|spell_targets.frostscythe>=2)
	if BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } Spell(frostscythe)
	#glacial_advance,if=spell_targets.glacial_advance>=2
	if Enemies() >= 2 Spell(glacial_advance)
	#remorseless_winter,if=spell_targets.remorseless_winter>=2
	if Enemies() >= 2 Spell(remorseless_winter)
	#frostscythe,if=spell_targets.frostscythe>=3
	if Enemies() >= 3 Spell(frostscythe)
	#frost_strike,if=(cooldown.remorseless_winter.remains<(gcd*2)|buff.gathering_storm.stack=10)&cooldown.breath_of_sindragosa.remains>rune.time_to_4&talent.gathering_storm.enabled&(!talent.shattering_strikes.enabled|debuff.razorice.stack<5|cooldown.breath_of_sindragosa.remains>6)
	if { SpellCooldown(remorseless_winter) < GCD() * 2 or BuffStacks(gathering_storm_buff) == 10 } and SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) and Talent(gathering_storm_talent) and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } Spell(frost_strike)
	#obliterate,if=!buff.rime.react&(!talent.gathering_storm.enabled|cooldown.remorseless_winter.remains>gcd)
	if not BuffPresent(rime_buff) and { not Talent(gathering_storm_talent) or SpellCooldown(remorseless_winter) > GCD() } Spell(obliterate)
	#frost_strike,if=cooldown.breath_of_sindragosa.remains>rune.time_to_4&(!talent.shattering_strikes.enabled|debuff.razorice.stack<5|cooldown.breath_of_sindragosa.remains>6)
	if SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } Spell(frost_strike)
}

AddFunction FrostBosPoolingMainPostConditions
{
}

AddFunction FrostBosPoolingShortCdActions
{
}

AddFunction FrostBosPoolingShortCdPostConditions
{
	Talent(gathering_storm_talent) and Spell(remorseless_winter) or BuffPresent(rime_buff) and TimeToRunes(4) < GCD() * 2 and Spell(howling_blast) or TimeToRunes(6) < GCD() and not Talent(gathering_storm_talent) and Spell(obliterate) or TimeToRunes(4) < GCD() and { SpellCooldown(breath_of_sindragosa) > 0 or RunicPower() < 70 } and Spell(obliterate) or RunicPower() >= 95 and ArmorSetBonus(T19 4) and SpellCooldown(breath_of_sindragosa) > 0 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike) or BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) and Spell(remorseless_winter) or BuffPresent(rime_buff) and { BuffPresent(remorseless_winter_buff) or SpellCooldown(remorseless_winter) > GCD() or not HasEquippedItem(perseverance_of_the_ebon_martyr) and not Talent(gathering_storm_talent) } and Spell(howling_blast) or not BuffPresent(rime_buff) and not { Talent(gathering_storm_talent) and not { SpellCooldown(remorseless_winter) > GCD() * 2 or Rune() >= 5 } } and Rune() >= 4 and Spell(obliterate) or RunicPower() >= 70 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) } and Spell(frost_strike) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 2 and Spell(remorseless_winter) or Enemies() >= 3 and Spell(frostscythe) or { SpellCooldown(remorseless_winter) < GCD() * 2 or BuffStacks(gathering_storm_buff) == 10 } and SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) and Talent(gathering_storm_talent) and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike) or not BuffPresent(rime_buff) and { not Talent(gathering_storm_talent) or SpellCooldown(remorseless_winter) > GCD() } and Spell(obliterate) or SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike)
}

AddFunction FrostBosPoolingCdActions
{
	unless Talent(gathering_storm_talent) and Spell(remorseless_winter) or BuffPresent(rime_buff) and TimeToRunes(4) < GCD() * 2 and Spell(howling_blast) or TimeToRunes(6) < GCD() and not Talent(gathering_storm_talent) and Spell(obliterate) or TimeToRunes(4) < GCD() and { SpellCooldown(breath_of_sindragosa) > 0 or RunicPower() < 70 } and Spell(obliterate) or RunicPower() >= 95 and ArmorSetBonus(T19 4) and SpellCooldown(breath_of_sindragosa) > 0 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike) or BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) and Spell(remorseless_winter) or BuffPresent(rime_buff) and { BuffPresent(remorseless_winter_buff) or SpellCooldown(remorseless_winter) > GCD() or not HasEquippedItem(perseverance_of_the_ebon_martyr) and not Talent(gathering_storm_talent) } and Spell(howling_blast) or not BuffPresent(rime_buff) and not { Talent(gathering_storm_talent) and not { SpellCooldown(remorseless_winter) > GCD() * 2 or Rune() >= 5 } } and Rune() >= 4 and Spell(obliterate)
	{
		#sindragosas_fury,if=(equipped.consorts_cold_core|buff.pillar_of_frost.up)&buff.unholy_strength.up&debuff.razorice.stack=5
		if { HasEquippedItem(consorts_cold_core) or BuffPresent(pillar_of_frost_buff) } and BuffPresent(unholy_strength_buff) and target.DebuffStacks(razorice_debuff) == 5 Spell(sindragosas_fury)
	}
}

AddFunction FrostBosPoolingCdPostConditions
{
	Talent(gathering_storm_talent) and Spell(remorseless_winter) or BuffPresent(rime_buff) and TimeToRunes(4) < GCD() * 2 and Spell(howling_blast) or TimeToRunes(6) < GCD() and not Talent(gathering_storm_talent) and Spell(obliterate) or TimeToRunes(4) < GCD() and { SpellCooldown(breath_of_sindragosa) > 0 or RunicPower() < 70 } and Spell(obliterate) or RunicPower() >= 95 and ArmorSetBonus(T19 4) and SpellCooldown(breath_of_sindragosa) > 0 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike) or BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) and Spell(remorseless_winter) or BuffPresent(rime_buff) and { BuffPresent(remorseless_winter_buff) or SpellCooldown(remorseless_winter) > GCD() or not HasEquippedItem(perseverance_of_the_ebon_martyr) and not Talent(gathering_storm_talent) } and Spell(howling_blast) or not BuffPresent(rime_buff) and not { Talent(gathering_storm_talent) and not { SpellCooldown(remorseless_winter) > GCD() * 2 or Rune() >= 5 } } and Rune() >= 4 and Spell(obliterate) or RunicPower() >= 70 and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) } and Spell(frost_strike) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 2 and Spell(remorseless_winter) or Enemies() >= 3 and Spell(frostscythe) or { SpellCooldown(remorseless_winter) < GCD() * 2 or BuffStacks(gathering_storm_buff) == 10 } and SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) and Talent(gathering_storm_talent) and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike) or not BuffPresent(rime_buff) and { not Talent(gathering_storm_talent) or SpellCooldown(remorseless_winter) > GCD() } and Spell(obliterate) or SpellCooldown(breath_of_sindragosa) > TimeToRunes(4) and { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 or SpellCooldown(breath_of_sindragosa) > 6 } and Spell(frost_strike)
}

### actions.bos_ticking

AddFunction FrostBosTickingMainActions
{
	#frost_strike,if=talent.shattering_strikes.enabled&runic_power<40&rune.time_to_2>2&cooldown.empower_rune_weapon.remains&debuff.razorice.stack=5&(cooldown.horn_of_winter.remains|!talent.horn_of_winter.enabled)
	if Talent(shattering_strikes_talent) and RunicPower() < 40 and TimeToRunes(2) > 2 and SpellCooldown(empower_rune_weapon) > 0 and target.DebuffStacks(razorice_debuff) == 5 and { SpellCooldown(horn_of_winter) > 0 or not Talent(horn_of_winter_talent) } Spell(frost_strike)
	#remorseless_winter,if=runic_power>=30&((buff.rime.react&equipped.perseverance_of_the_ebon_martyr)|(talent.gathering_storm.enabled&(buff.remorseless_winter.remains<=gcd|!buff.remorseless_winter.remains)))
	if RunicPower() >= 30 and { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) and { BuffRemaining(remorseless_winter_buff) <= GCD() or not BuffPresent(remorseless_winter_buff) } } Spell(remorseless_winter)
	#howling_blast,if=((runic_power>=20&set_bonus.tier19_4pc)|runic_power>=30)&buff.rime.react
	if { RunicPower() >= 20 and ArmorSetBonus(T19 4) or RunicPower() >= 30 } and BuffPresent(rime_buff) Spell(howling_blast)
	#frost_strike,if=set_bonus.tier20_2pc&runic_power>85&rune<=3&buff.pillar_of_frost.up&!talent.shattering_strikes.enabled
	if ArmorSetBonus(T20 2) and RunicPower() > 85 and Rune() < 4 and BuffPresent(pillar_of_frost_buff) and not Talent(shattering_strikes_talent) Spell(frost_strike)
	#obliterate,if=runic_power<=45|rune.time_to_5<gcd
	if RunicPower() <= 45 or TimeToRunes(5) < GCD() Spell(obliterate)
	#horn_of_winter,if=runic_power<70&rune.time_to_3>gcd
	if RunicPower() < 70 and TimeToRunes(3) > GCD() Spell(horn_of_winter)
	#frostscythe,if=buff.killing_machine.up&(!equipped.koltiras_newfound_will|talent.gathering_storm.enabled|spell_targets.frostscythe>=2)
	if BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Talent(gathering_storm_talent) or Enemies() >= 2 } Spell(frostscythe)
	#glacial_advance,if=spell_targets.remorseless_winter>=2
	if Enemies() >= 2 Spell(glacial_advance)
	#remorseless_winter,if=spell_targets.remorseless_winter>=2
	if Enemies() >= 2 Spell(remorseless_winter)
	#obliterate,if=runic_power<=75|rune>3
	if RunicPower() <= 75 or Rune() >= 4 Spell(obliterate)
}

AddFunction FrostBosTickingMainPostConditions
{
}

AddFunction FrostBosTickingShortCdActions
{
}

AddFunction FrostBosTickingShortCdPostConditions
{
	Talent(shattering_strikes_talent) and RunicPower() < 40 and TimeToRunes(2) > 2 and SpellCooldown(empower_rune_weapon) > 0 and target.DebuffStacks(razorice_debuff) == 5 and { SpellCooldown(horn_of_winter) > 0 or not Talent(horn_of_winter_talent) } and Spell(frost_strike) or RunicPower() >= 30 and { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) and { BuffRemaining(remorseless_winter_buff) <= GCD() or not BuffPresent(remorseless_winter_buff) } } and Spell(remorseless_winter) or { RunicPower() >= 20 and ArmorSetBonus(T19 4) or RunicPower() >= 30 } and BuffPresent(rime_buff) and Spell(howling_blast) or ArmorSetBonus(T20 2) and RunicPower() > 85 and Rune() < 4 and BuffPresent(pillar_of_frost_buff) and not Talent(shattering_strikes_talent) and Spell(frost_strike) or { RunicPower() <= 45 or TimeToRunes(5) < GCD() } and Spell(obliterate) or RunicPower() < 70 and TimeToRunes(3) > GCD() and Spell(horn_of_winter) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Talent(gathering_storm_talent) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 2 and Spell(remorseless_winter) or { RunicPower() <= 75 or Rune() >= 4 } and Spell(obliterate)
}

AddFunction FrostBosTickingCdActions
{
	unless Talent(shattering_strikes_talent) and RunicPower() < 40 and TimeToRunes(2) > 2 and SpellCooldown(empower_rune_weapon) > 0 and target.DebuffStacks(razorice_debuff) == 5 and { SpellCooldown(horn_of_winter) > 0 or not Talent(horn_of_winter_talent) } and Spell(frost_strike) or RunicPower() >= 30 and { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) and { BuffRemaining(remorseless_winter_buff) <= GCD() or not BuffPresent(remorseless_winter_buff) } } and Spell(remorseless_winter) or { RunicPower() >= 20 and ArmorSetBonus(T19 4) or RunicPower() >= 30 } and BuffPresent(rime_buff) and Spell(howling_blast) or ArmorSetBonus(T20 2) and RunicPower() > 85 and Rune() < 4 and BuffPresent(pillar_of_frost_buff) and not Talent(shattering_strikes_talent) and Spell(frost_strike) or { RunicPower() <= 45 or TimeToRunes(5) < GCD() } and Spell(obliterate)
	{
		#sindragosas_fury,if=(equipped.consorts_cold_core|buff.pillar_of_frost.up)&buff.unholy_strength.up&debuff.razorice.stack=5
		if { HasEquippedItem(consorts_cold_core) or BuffPresent(pillar_of_frost_buff) } and BuffPresent(unholy_strength_buff) and target.DebuffStacks(razorice_debuff) == 5 Spell(sindragosas_fury)

		unless RunicPower() < 70 and TimeToRunes(3) > GCD() and Spell(horn_of_winter) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Talent(gathering_storm_talent) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 2 and Spell(remorseless_winter) or { RunicPower() <= 75 or Rune() >= 4 } and Spell(obliterate)
		{
			#empower_rune_weapon,if=runic_power<30&rune.time_to_2>gcd
			if RunicPower() < 30 and TimeToRunes(2) > GCD() Spell(empower_rune_weapon)
		}
	}
}

AddFunction FrostBosTickingCdPostConditions
{
	Talent(shattering_strikes_talent) and RunicPower() < 40 and TimeToRunes(2) > 2 and SpellCooldown(empower_rune_weapon) > 0 and target.DebuffStacks(razorice_debuff) == 5 and { SpellCooldown(horn_of_winter) > 0 or not Talent(horn_of_winter_talent) } and Spell(frost_strike) or RunicPower() >= 30 and { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) and { BuffRemaining(remorseless_winter_buff) <= GCD() or not BuffPresent(remorseless_winter_buff) } } and Spell(remorseless_winter) or { RunicPower() >= 20 and ArmorSetBonus(T19 4) or RunicPower() >= 30 } and BuffPresent(rime_buff) and Spell(howling_blast) or ArmorSetBonus(T20 2) and RunicPower() > 85 and Rune() < 4 and BuffPresent(pillar_of_frost_buff) and not Talent(shattering_strikes_talent) and Spell(frost_strike) or { RunicPower() <= 45 or TimeToRunes(5) < GCD() } and Spell(obliterate) or RunicPower() < 70 and TimeToRunes(3) > GCD() and Spell(horn_of_winter) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Talent(gathering_storm_talent) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 2 and Spell(remorseless_winter) or { RunicPower() <= 75 or Rune() >= 4 } and Spell(obliterate)
}

### actions.cds

AddFunction FrostCdsMainActions
{
	#call_action_list,name=cold_heart,if=equipped.cold_heart&((buff.cold_heart.stack>=10&!buff.obliteration.up)|target.time_to_die<=gcd)
	if HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } FrostColdHeartMainActions()
}

AddFunction FrostCdsMainPostConditions
{
	HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } and FrostColdHeartMainPostConditions()
}

AddFunction FrostCdsShortCdActions
{
	#pillar_of_frost,if=talent.obliteration.enabled&(cooldown.obliteration.remains>20|cooldown.obliteration.remains<10|!talent.icecap.enabled)
	if Talent(obliteration_talent) and { SpellCooldown(obliteration) > 20 or SpellCooldown(obliteration) < 10 or not Talent(icecap_talent) } Spell(pillar_of_frost)
	#pillar_of_frost,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.ready&runic_power>50
	if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) == 0 and RunicPower() > 50 Spell(pillar_of_frost)
	#pillar_of_frost,if=talent.breath_of_sindragosa.enabled&cooldown.breath_of_sindragosa.remains>40
	if Talent(breath_of_sindragosa_talent) and SpellCooldown(breath_of_sindragosa) > 40 Spell(pillar_of_frost)
	#pillar_of_frost,if=talent.hungering_rune_weapon.enabled
	if Talent(hungering_rune_weapon_talent) Spell(pillar_of_frost)
	#call_action_list,name=cold_heart,if=equipped.cold_heart&((buff.cold_heart.stack>=10&!buff.obliteration.up)|target.time_to_die<=gcd)
	if HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } FrostColdHeartShortCdActions()
}

AddFunction FrostCdsShortCdPostConditions
{
	HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } and FrostColdHeartShortCdPostConditions()
}

AddFunction FrostCdsCdActions
{
	#arcane_torrent,if=runic_power<80&!talent.breath_of_sindragosa.enabled
	if RunicPower() < 80 and not Talent(breath_of_sindragosa_talent) Spell(arcane_torrent_runicpower)
	#arcane_torrent,if=dot.breath_of_sindragosa.ticking&runic_power<50&rune<2
	if BuffPresent(breath_of_sindragosa_buff) and RunicPower() < 50 and Rune() < 2 Spell(arcane_torrent_runicpower)
	#blood_fury,if=buff.pillar_of_frost.up
	if BuffPresent(pillar_of_frost_buff) Spell(blood_fury_ap)
	#berserking,if=buff.pillar_of_frost.up
	if BuffPresent(pillar_of_frost_buff) Spell(berserking)
	#use_items
	FrostUseItemActions()
	#use_item,name=ring_of_collapsing_futures,if=(buff.temptation.stack=0&target.time_to_die>60)|target.time_to_die<60
	if BuffStacks(temptation_buff) == 0 and target.TimeToDie() > 60 or target.TimeToDie() < 60 FrostUseItemActions()
	#use_item,name=horn_of_valor,if=buff.pillar_of_frost.up&(!talent.breath_of_sindragosa.enabled|!cooldown.breath_of_sindragosa.remains)
	if BuffPresent(pillar_of_frost_buff) and { not Talent(breath_of_sindragosa_talent) or not SpellCooldown(breath_of_sindragosa) > 0 } FrostUseItemActions()
	#use_item,name=draught_of_souls,if=rune.time_to_5<3&(!dot.breath_of_sindragosa.ticking|runic_power>60)
	if TimeToRunes(5) < 3 and { not BuffPresent(breath_of_sindragosa_buff) or RunicPower() > 60 } FrostUseItemActions()
	#use_item,name=feloiled_infernal_machine,if=!talent.obliteration.enabled|buff.obliteration.up
	if not Talent(obliteration_talent) or BuffPresent(obliteration_buff) FrostUseItemActions()
	#potion,if=buff.pillar_of_frost.up&(dot.breath_of_sindragosa.ticking|buff.obliteration.up|talent.hungering_rune_weapon.enabled)
	if BuffPresent(pillar_of_frost_buff) and { BuffPresent(breath_of_sindragosa_buff) or BuffPresent(obliteration_buff) or Talent(hungering_rune_weapon_talent) } and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
	#breath_of_sindragosa,if=buff.pillar_of_frost.up
	if BuffPresent(pillar_of_frost_buff) Spell(breath_of_sindragosa)
	#call_action_list,name=cold_heart,if=equipped.cold_heart&((buff.cold_heart.stack>=10&!buff.obliteration.up)|target.time_to_die<=gcd)
	if HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } FrostColdHeartCdActions()

	unless HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } and FrostColdHeartCdPostConditions()
	{
		#obliteration,if=rune>=1&runic_power>=20&(!talent.frozen_pulse.enabled|rune<2|buff.pillar_of_frost.remains<=12)&(!talent.gathering_storm.enabled|!cooldown.remorseless_winter.ready)&(buff.pillar_of_frost.up|!talent.icecap.enabled)
		if Rune() >= 1 and RunicPower() >= 20 and { not Talent(frozen_pulse_talent) or Rune() < 2 or BuffRemaining(pillar_of_frost_buff) <= 12 } and { not Talent(gathering_storm_talent) or not SpellCooldown(remorseless_winter) == 0 } and { BuffPresent(pillar_of_frost_buff) or not Talent(icecap_talent) } Spell(obliteration)
		#hungering_rune_weapon,if=!buff.hungering_rune_weapon.up&rune.time_to_2>gcd&runic_power<40
		if not BuffPresent(hungering_rune_weapon_buff) and TimeToRunes(2) > GCD() and RunicPower() < 40 Spell(hungering_rune_weapon)
	}
}

AddFunction FrostCdsCdPostConditions
{
	HasEquippedItem(cold_heart) and { BuffStacks(cold_heart_buff) >= 10 and not BuffPresent(obliteration_buff) or target.TimeToDie() <= GCD() } and FrostColdHeartCdPostConditions()
}

### actions.cold_heart

AddFunction FrostColdHeartMainActions
{
	#chains_of_ice,if=buff.cold_heart.stack=20&buff.unholy_strength.up&cooldown.pillar_of_frost.remains>6
	if BuffStacks(cold_heart_buff) == 20 and BuffPresent(unholy_strength_buff) and SpellCooldown(pillar_of_frost) > 6 Spell(chains_of_ice)
	#chains_of_ice,if=buff.pillar_of_frost.up&buff.pillar_of_frost.remains<gcd&(buff.cold_heart.stack>=11|(buff.cold_heart.stack>=10&set_bonus.tier20_4pc))
	if BuffPresent(pillar_of_frost_buff) and BuffRemaining(pillar_of_frost_buff) < GCD() and { BuffStacks(cold_heart_buff) >= 11 or BuffStacks(cold_heart_buff) >= 10 and ArmorSetBonus(T20 4) } Spell(chains_of_ice)
	#chains_of_ice,if=buff.unholy_strength.up&buff.unholy_strength.remains<gcd&buff.cold_heart.stack>16&cooldown.pillar_of_frost.remains>6
	if BuffPresent(unholy_strength_buff) and BuffRemaining(unholy_strength_buff) < GCD() and BuffStacks(cold_heart_buff) > 16 and SpellCooldown(pillar_of_frost) > 6 Spell(chains_of_ice)
	#chains_of_ice,if=buff.cold_heart.stack>=4&target.time_to_die<=gcd
	if BuffStacks(cold_heart_buff) >= 4 and target.TimeToDie() <= GCD() Spell(chains_of_ice)
}

AddFunction FrostColdHeartMainPostConditions
{
}

AddFunction FrostColdHeartShortCdActions
{
}

AddFunction FrostColdHeartShortCdPostConditions
{
	BuffStacks(cold_heart_buff) == 20 and BuffPresent(unholy_strength_buff) and SpellCooldown(pillar_of_frost) > 6 and Spell(chains_of_ice) or BuffPresent(pillar_of_frost_buff) and BuffRemaining(pillar_of_frost_buff) < GCD() and { BuffStacks(cold_heart_buff) >= 11 or BuffStacks(cold_heart_buff) >= 10 and ArmorSetBonus(T20 4) } and Spell(chains_of_ice) or BuffPresent(unholy_strength_buff) and BuffRemaining(unholy_strength_buff) < GCD() and BuffStacks(cold_heart_buff) > 16 and SpellCooldown(pillar_of_frost) > 6 and Spell(chains_of_ice) or BuffStacks(cold_heart_buff) >= 4 and target.TimeToDie() <= GCD() and Spell(chains_of_ice)
}

AddFunction FrostColdHeartCdActions
{
}

AddFunction FrostColdHeartCdPostConditions
{
	BuffStacks(cold_heart_buff) == 20 and BuffPresent(unholy_strength_buff) and SpellCooldown(pillar_of_frost) > 6 and Spell(chains_of_ice) or BuffPresent(pillar_of_frost_buff) and BuffRemaining(pillar_of_frost_buff) < GCD() and { BuffStacks(cold_heart_buff) >= 11 or BuffStacks(cold_heart_buff) >= 10 and ArmorSetBonus(T20 4) } and Spell(chains_of_ice) or BuffPresent(unholy_strength_buff) and BuffRemaining(unholy_strength_buff) < GCD() and BuffStacks(cold_heart_buff) > 16 and SpellCooldown(pillar_of_frost) > 6 and Spell(chains_of_ice) or BuffStacks(cold_heart_buff) >= 4 and target.TimeToDie() <= GCD() and Spell(chains_of_ice)
}

### actions.obliteration

AddFunction FrostObliterationMainActions
{
	#remorseless_winter,if=talent.gathering_storm.enabled
	if Talent(gathering_storm_talent) Spell(remorseless_winter)
	#howling_blast,if=buff.rime.up&!buff.killing_machine.up&spell_targets.howling_blast>1
	if BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Enemies() > 1 Spell(howling_blast)
	#howling_blast,if=!buff.rime.up&!buff.killing_machine.up&spell_targets.howling_blast>2&rune>3&talent.freezing_fog.enabled&talent.gathering_storm.enabled
	if not BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Enemies() > 2 and Rune() >= 4 and Talent(freezing_fog_talent) and Talent(gathering_storm_talent) Spell(howling_blast)
	#frost_strike,if=!buff.killing_machine.up&(!buff.rime.up|rune.time_to_1>=gcd|runic_power>=80)
	if not BuffPresent(killing_machine_buff) and { not BuffPresent(rime_buff) or TimeToRunes(1) >= GCD() or RunicPower() >= 80 } Spell(frost_strike)
	#frostscythe,if=buff.killing_machine.up&spell_targets.frostscythe>1
	if BuffPresent(killing_machine_buff) and Enemies() > 1 Spell(frostscythe)
	#howling_blast,if=buff.rime.up&!buff.killing_machine.up
	if BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) Spell(howling_blast)
	#obliterate,if=buff.killing_machine.up
	if BuffPresent(killing_machine_buff) Spell(obliterate)
	#frost_strike,if=!buff.killing_machine.up&rune.time_to_1>=gcd
	if not BuffPresent(killing_machine_buff) and TimeToRunes(1) >= GCD() Spell(frost_strike)
	#obliterate
	Spell(obliterate)
}

AddFunction FrostObliterationMainPostConditions
{
}

AddFunction FrostObliterationShortCdActions
{
}

AddFunction FrostObliterationShortCdPostConditions
{
	Talent(gathering_storm_talent) and Spell(remorseless_winter) or BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Enemies() > 1 and Spell(howling_blast) or not BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Enemies() > 2 and Rune() >= 4 and Talent(freezing_fog_talent) and Talent(gathering_storm_talent) and Spell(howling_blast) or not BuffPresent(killing_machine_buff) and { not BuffPresent(rime_buff) or TimeToRunes(1) >= GCD() or RunicPower() >= 80 } and Spell(frost_strike) or BuffPresent(killing_machine_buff) and Enemies() > 1 and Spell(frostscythe) or BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Spell(howling_blast) or BuffPresent(killing_machine_buff) and Spell(obliterate) or not BuffPresent(killing_machine_buff) and TimeToRunes(1) >= GCD() and Spell(frost_strike) or Spell(obliterate)
}

AddFunction FrostObliterationCdActions
{
}

AddFunction FrostObliterationCdPostConditions
{
	Talent(gathering_storm_talent) and Spell(remorseless_winter) or BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Enemies() > 1 and Spell(howling_blast) or not BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Enemies() > 2 and Rune() >= 4 and Talent(freezing_fog_talent) and Talent(gathering_storm_talent) and Spell(howling_blast) or not BuffPresent(killing_machine_buff) and { not BuffPresent(rime_buff) or TimeToRunes(1) >= GCD() or RunicPower() >= 80 } and Spell(frost_strike) or BuffPresent(killing_machine_buff) and Enemies() > 1 and Spell(frostscythe) or BuffPresent(rime_buff) and not BuffPresent(killing_machine_buff) and Spell(howling_blast) or BuffPresent(killing_machine_buff) and Spell(obliterate) or not BuffPresent(killing_machine_buff) and TimeToRunes(1) >= GCD() and Spell(frost_strike) or Spell(obliterate)
}

### actions.precombat

AddFunction FrostPrecombatMainActions
{
}

AddFunction FrostPrecombatMainPostConditions
{
}

AddFunction FrostPrecombatShortCdActions
{
}

AddFunction FrostPrecombatShortCdPostConditions
{
}

AddFunction FrostPrecombatCdActions
{
	#flask
	#food
	#augmentation
	#snapshot_stats
	#potion
	if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)
}

AddFunction FrostPrecombatCdPostConditions
{
}

### actions.standard

AddFunction FrostStandardMainActions
{
	#frost_strike,if=talent.icy_talons.enabled&buff.icy_talons.remains<=gcd
	if Talent(icy_talons_talent) and BuffRemaining(icy_talons_buff) <= GCD() Spell(frost_strike)
	#frost_strike,if=talent.shattering_strikes.enabled&debuff.razorice.stack=5&buff.gathering_storm.stack<2&!buff.rime.up
	if Talent(shattering_strikes_talent) and target.DebuffStacks(razorice_debuff) == 5 and BuffStacks(gathering_storm_buff) < 2 and not BuffPresent(rime_buff) Spell(frost_strike)
	#remorseless_winter,if=(buff.rime.react&equipped.perseverance_of_the_ebon_martyr)|talent.gathering_storm.enabled
	if BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) Spell(remorseless_winter)
	#obliterate,if=(equipped.koltiras_newfound_will&talent.frozen_pulse.enabled&set_bonus.tier19_2pc=1)|rune.time_to_4<gcd&buff.hungering_rune_weapon.up
	if HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(4) < GCD() and BuffPresent(hungering_rune_weapon_buff) Spell(obliterate)
	#frost_strike,if=(!talent.shattering_strikes.enabled|debuff.razorice.stack<5)&runic_power>=90
	if { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 } and RunicPower() >= 90 Spell(frost_strike)
	#howling_blast,if=buff.rime.react
	if BuffPresent(rime_buff) Spell(howling_blast)
	#obliterate,if=(equipped.koltiras_newfound_will&talent.frozen_pulse.enabled&set_bonus.tier19_2pc=1)|rune.time_to_5<gcd
	if HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(5) < GCD() Spell(obliterate)
	#frost_strike,if=runic_power>=90&!buff.hungering_rune_weapon.up
	if RunicPower() >= 90 and not BuffPresent(hungering_rune_weapon_buff) Spell(frost_strike)
	#frostscythe,if=buff.killing_machine.up&(!equipped.koltiras_newfound_will|spell_targets.frostscythe>=2)
	if BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } Spell(frostscythe)
	#remorseless_winter,if=spell_targets.remorseless_winter>=2
	if Enemies() >= 2 Spell(remorseless_winter)
	#glacial_advance,if=spell_targets.glacial_advance>=2
	if Enemies() >= 2 Spell(glacial_advance)
	#frostscythe,if=spell_targets.frostscythe>=3
	if Enemies() >= 3 Spell(frostscythe)
	#obliterate,if=buff.killing_machine.react
	if BuffPresent(killing_machine_buff) Spell(obliterate)
	#frost_strike,if=runic_power>=80
	if RunicPower() >= 80 Spell(frost_strike)
	#obliterate
	Spell(obliterate)
	#horn_of_winter,if=!buff.hungering_rune_weapon.up&(rune.time_to_2>gcd|!talent.frozen_pulse.enabled)
	if not BuffPresent(hungering_rune_weapon_buff) and { TimeToRunes(2) > GCD() or not Talent(frozen_pulse_talent) } Spell(horn_of_winter)
	#frost_strike,if=!(runic_power<50&talent.obliteration.enabled&cooldown.obliteration.remains<=gcd)
	if not { RunicPower() < 50 and Talent(obliteration_talent) and SpellCooldown(obliteration) <= GCD() } Spell(frost_strike)
}

AddFunction FrostStandardMainPostConditions
{
}

AddFunction FrostStandardShortCdActions
{
}

AddFunction FrostStandardShortCdPostConditions
{
	Talent(icy_talons_talent) and BuffRemaining(icy_talons_buff) <= GCD() and Spell(frost_strike) or Talent(shattering_strikes_talent) and target.DebuffStacks(razorice_debuff) == 5 and BuffStacks(gathering_storm_buff) < 2 and not BuffPresent(rime_buff) and Spell(frost_strike) or { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) } and Spell(remorseless_winter) or { HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(4) < GCD() and BuffPresent(hungering_rune_weapon_buff) } and Spell(obliterate) or { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 } and RunicPower() >= 90 and Spell(frost_strike) or BuffPresent(rime_buff) and Spell(howling_blast) or { HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(5) < GCD() } and Spell(obliterate) or RunicPower() >= 90 and not BuffPresent(hungering_rune_weapon_buff) and Spell(frost_strike) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(remorseless_winter) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 3 and Spell(frostscythe) or BuffPresent(killing_machine_buff) and Spell(obliterate) or RunicPower() >= 80 and Spell(frost_strike) or Spell(obliterate) or not BuffPresent(hungering_rune_weapon_buff) and { TimeToRunes(2) > GCD() or not Talent(frozen_pulse_talent) } and Spell(horn_of_winter) or not { RunicPower() < 50 and Talent(obliteration_talent) and SpellCooldown(obliteration) <= GCD() } and Spell(frost_strike)
}

AddFunction FrostStandardCdActions
{
	unless Talent(icy_talons_talent) and BuffRemaining(icy_talons_buff) <= GCD() and Spell(frost_strike) or Talent(shattering_strikes_talent) and target.DebuffStacks(razorice_debuff) == 5 and BuffStacks(gathering_storm_buff) < 2 and not BuffPresent(rime_buff) and Spell(frost_strike) or { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) } and Spell(remorseless_winter) or { HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(4) < GCD() and BuffPresent(hungering_rune_weapon_buff) } and Spell(obliterate) or { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 } and RunicPower() >= 90 and Spell(frost_strike) or BuffPresent(rime_buff) and Spell(howling_blast) or { HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(5) < GCD() } and Spell(obliterate)
	{
		#sindragosas_fury,if=(equipped.consorts_cold_core|buff.pillar_of_frost.up)&buff.unholy_strength.up&debuff.razorice.stack=5
		if { HasEquippedItem(consorts_cold_core) or BuffPresent(pillar_of_frost_buff) } and BuffPresent(unholy_strength_buff) and target.DebuffStacks(razorice_debuff) == 5 Spell(sindragosas_fury)

		unless RunicPower() >= 90 and not BuffPresent(hungering_rune_weapon_buff) and Spell(frost_strike) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(remorseless_winter) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 3 and Spell(frostscythe) or BuffPresent(killing_machine_buff) and Spell(obliterate) or RunicPower() >= 80 and Spell(frost_strike) or Spell(obliterate) or not BuffPresent(hungering_rune_weapon_buff) and { TimeToRunes(2) > GCD() or not Talent(frozen_pulse_talent) } and Spell(horn_of_winter) or not { RunicPower() < 50 and Talent(obliteration_talent) and SpellCooldown(obliteration) <= GCD() } and Spell(frost_strike)
		{
			#empower_rune_weapon,if=!talent.breath_of_sindragosa.enabled|target.time_to_die<cooldown.breath_of_sindragosa.remains
			if not Talent(breath_of_sindragosa_talent) or target.TimeToDie() < SpellCooldown(breath_of_sindragosa) Spell(empower_rune_weapon)
		}
	}
}

AddFunction FrostStandardCdPostConditions
{
	Talent(icy_talons_talent) and BuffRemaining(icy_talons_buff) <= GCD() and Spell(frost_strike) or Talent(shattering_strikes_talent) and target.DebuffStacks(razorice_debuff) == 5 and BuffStacks(gathering_storm_buff) < 2 and not BuffPresent(rime_buff) and Spell(frost_strike) or { BuffPresent(rime_buff) and HasEquippedItem(perseverance_of_the_ebon_martyr) or Talent(gathering_storm_talent) } and Spell(remorseless_winter) or { HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(4) < GCD() and BuffPresent(hungering_rune_weapon_buff) } and Spell(obliterate) or { not Talent(shattering_strikes_talent) or target.DebuffStacks(razorice_debuff) < 5 } and RunicPower() >= 90 and Spell(frost_strike) or BuffPresent(rime_buff) and Spell(howling_blast) or { HasEquippedItem(koltiras_newfound_will) and Talent(frozen_pulse_talent) and ArmorSetBonus(T19 2) == 1 or TimeToRunes(5) < GCD() } and Spell(obliterate) or RunicPower() >= 90 and not BuffPresent(hungering_rune_weapon_buff) and Spell(frost_strike) or BuffPresent(killing_machine_buff) and { not HasEquippedItem(koltiras_newfound_will) or Enemies() >= 2 } and Spell(frostscythe) or Enemies() >= 2 and Spell(remorseless_winter) or Enemies() >= 2 and Spell(glacial_advance) or Enemies() >= 3 and Spell(frostscythe) or BuffPresent(killing_machine_buff) and Spell(obliterate) or RunicPower() >= 80 and Spell(frost_strike) or Spell(obliterate) or not BuffPresent(hungering_rune_weapon_buff) and { TimeToRunes(2) > GCD() or not Talent(frozen_pulse_talent) } and Spell(horn_of_winter) or not { RunicPower() < 50 and Talent(obliteration_talent) and SpellCooldown(obliteration) <= GCD() } and Spell(frost_strike)
}

### Frost icons.

AddCheckBox(opt_deathknight_frost_aoe L(AOE) default specialization=frost)

AddIcon checkbox=!opt_deathknight_frost_aoe enemies=1 help=shortcd specialization=frost
{
	if not InCombat() FrostPrecombatShortCdActions()
	unless not InCombat() and FrostPrecombatShortCdPostConditions()
	{
		FrostDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_deathknight_frost_aoe help=shortcd specialization=frost
{
	if not InCombat() FrostPrecombatShortCdActions()
	unless not InCombat() and FrostPrecombatShortCdPostConditions()
	{
		FrostDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=frost
{
	if not InCombat() FrostPrecombatMainActions()
	unless not InCombat() and FrostPrecombatMainPostConditions()
	{
		FrostDefaultMainActions()
	}
}

AddIcon checkbox=opt_deathknight_frost_aoe help=aoe specialization=frost
{
	if not InCombat() FrostPrecombatMainActions()
	unless not InCombat() and FrostPrecombatMainPostConditions()
	{
		FrostDefaultMainActions()
	}
}

AddIcon checkbox=!opt_deathknight_frost_aoe enemies=1 help=cd specialization=frost
{
	if not InCombat() FrostPrecombatCdActions()
	unless not InCombat() and FrostPrecombatCdPostConditions()
	{
		FrostDefaultCdActions()
	}
}

AddIcon checkbox=opt_deathknight_frost_aoe help=cd specialization=frost
{
	if not InCombat() FrostPrecombatCdActions()
	unless not InCombat() and FrostPrecombatCdPostConditions()
	{
		FrostDefaultCdActions()
	}
}

### Required symbols
# arcane_torrent_runicpower
# berserking
# blinding_sleet
# blood_fury_ap
# breath_of_sindragosa
# breath_of_sindragosa_buff
# breath_of_sindragosa_talent
# chains_of_ice
# cold_heart
# cold_heart_buff
# consorts_cold_core
# death_strike
# empower_rune_weapon
# freezing_fog_talent
# frost_strike
# frostscythe
# frozen_pulse_talent
# gathering_storm_buff
# gathering_storm_talent
# glacial_advance
# horn_of_winter
# horn_of_winter_talent
# howling_blast
# hungering_rune_weapon
# hungering_rune_weapon_buff
# hungering_rune_weapon_talent
# icecap_talent
# icy_talons_buff
# icy_talons_talent
# killing_machine_buff
# koltiras_newfound_will
# mind_freeze
# obliterate
# obliteration
# obliteration_buff
# obliteration_talent
# perseverance_of_the_ebon_martyr
# pillar_of_frost
# pillar_of_frost_buff
# prolonged_power_potion
# razorice_debuff
# remorseless_winter
# remorseless_winter_buff
# rime_buff
# shattering_strikes_talent
# sindragosas_fury
# temptation_buff
# unholy_strength_buff
# war_stomp
]]
    __Scripts.OvaleScripts:RegisterScript("DEATHKNIGHT", "frost", name, desc, code, "script")
end
do
    local name = "simulationcraft_death_knight_unholy_t19p"
    local desc = "[7.0] SimulationCraft: Death_Knight_Unholy_T19P"
    local code = [[
# Based on SimulationCraft profile "Death_Knight_Unholy_T19P".
#	class=deathknight
#	spec=unholy
#	talents=1210023

Include(ovale_common)
Include(ovale_trinkets_mop)
Include(ovale_trinkets_wod)
Include(ovale_deathknight_spells)

AddCheckBox(opt_interrupt L(interrupt) default specialization=unholy)
AddCheckBox(opt_melee_range L(not_in_melee_range) specialization=unholy)
AddCheckBox(opt_use_consumables L(opt_use_consumables) default specialization=unholy)

AddFunction UnholyInterruptActions
{
	if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
	{
		if target.InRange(mind_freeze) and target.IsInterruptible() Spell(mind_freeze)
		if target.InRange(asphyxiate) and not target.Classification(worldboss) Spell(asphyxiate)
		if target.Distance(less 8) and target.IsInterruptible() Spell(arcane_torrent_runicpower)
		if target.Distance(less 5) and not target.Classification(worldboss) Spell(war_stomp)
	}
}

AddFunction UnholyUseItemActions
{
	Item(Trinket0Slot text=13 usable=1)
	Item(Trinket1Slot text=14 usable=1)
}

AddFunction UnholyGetInMeleeRange
{
	if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
}

### actions.default

AddFunction UnholyDefaultMainActions
{
	#outbreak,target_if=!dot.virulent_plague.ticking
	if not target.DebuffPresent(virulent_plague_debuff) Spell(outbreak)
	#run_action_list,name=valkyr,if=talent.dark_arbiter.enabled&pet.valkyr_battlemaiden.active
	if Talent(dark_arbiter_talent) and pet.Present() UnholyValkyrMainActions()

	unless Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrMainPostConditions()
	{
		#call_action_list,name=generic
		UnholyGenericMainActions()
	}
}

AddFunction UnholyDefaultMainPostConditions
{
	Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrMainPostConditions() or UnholyGenericMainPostConditions()
}

AddFunction UnholyDefaultShortCdActions
{
	#auto_attack
	UnholyGetInMeleeRange()

	unless not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak)
	{
		#dark_transformation,if=equipped.137075&cooldown.dark_arbiter.remains>165
		if HasEquippedItem(137075) and SpellCooldown(dark_arbiter) > 165 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&!talent.shadow_infusion.enabled&cooldown.dark_arbiter.remains>55
		if HasEquippedItem(137075) and not Talent(shadow_infusion_talent) and SpellCooldown(dark_arbiter) > 55 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&talent.shadow_infusion.enabled&cooldown.dark_arbiter.remains>35
		if HasEquippedItem(137075) and Talent(shadow_infusion_talent) and SpellCooldown(dark_arbiter) > 35 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&target.time_to_die<cooldown.dark_arbiter.remains-8
		if HasEquippedItem(137075) and target.TimeToDie() < SpellCooldown(dark_arbiter) - 8 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&cooldown.summon_gargoyle.remains>160
		if HasEquippedItem(137075) and SpellCooldown(summon_gargoyle) > 160 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&!talent.shadow_infusion.enabled&cooldown.summon_gargoyle.remains>55
		if HasEquippedItem(137075) and not Talent(shadow_infusion_talent) and SpellCooldown(summon_gargoyle) > 55 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&talent.shadow_infusion.enabled&cooldown.summon_gargoyle.remains>35
		if HasEquippedItem(137075) and Talent(shadow_infusion_talent) and SpellCooldown(summon_gargoyle) > 35 Spell(dark_transformation)
		#dark_transformation,if=equipped.137075&target.time_to_die<cooldown.summon_gargoyle.remains-8
		if HasEquippedItem(137075) and target.TimeToDie() < SpellCooldown(summon_gargoyle) - 8 Spell(dark_transformation)
		#dark_transformation,if=!equipped.137075&rune<=3
		if not HasEquippedItem(137075) and Rune() < 4 Spell(dark_transformation)
		#blighted_rune_weapon,if=rune<=3
		if Rune() < 4 Spell(blighted_rune_weapon)
		#run_action_list,name=valkyr,if=talent.dark_arbiter.enabled&pet.valkyr_battlemaiden.active
		if Talent(dark_arbiter_talent) and pet.Present() UnholyValkyrShortCdActions()

		unless Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrShortCdPostConditions()
		{
			#call_action_list,name=generic
			UnholyGenericShortCdActions()
		}
	}
}

AddFunction UnholyDefaultShortCdPostConditions
{
	not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak) or Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrShortCdPostConditions() or UnholyGenericShortCdPostConditions()
}

AddFunction UnholyDefaultCdActions
{
	#mind_freeze
	UnholyInterruptActions()
	#arcane_torrent,if=runic_power.deficit>20
	if RunicPowerDeficit() > 20 Spell(arcane_torrent_runicpower)
	#blood_fury
	Spell(blood_fury_ap)
	#berserking
	Spell(berserking)
	#use_item,slot=trinket1
	UnholyUseItemActions()
	#potion,name=prolonged_power,if=buff.unholy_strength.react
	if BuffPresent(unholy_strength_buff) and CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)

	unless not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak) or HasEquippedItem(137075) and SpellCooldown(dark_arbiter) > 165 and Spell(dark_transformation) or HasEquippedItem(137075) and not Talent(shadow_infusion_talent) and SpellCooldown(dark_arbiter) > 55 and Spell(dark_transformation) or HasEquippedItem(137075) and Talent(shadow_infusion_talent) and SpellCooldown(dark_arbiter) > 35 and Spell(dark_transformation) or HasEquippedItem(137075) and target.TimeToDie() < SpellCooldown(dark_arbiter) - 8 and Spell(dark_transformation) or HasEquippedItem(137075) and SpellCooldown(summon_gargoyle) > 160 and Spell(dark_transformation) or HasEquippedItem(137075) and not Talent(shadow_infusion_talent) and SpellCooldown(summon_gargoyle) > 55 and Spell(dark_transformation) or HasEquippedItem(137075) and Talent(shadow_infusion_talent) and SpellCooldown(summon_gargoyle) > 35 and Spell(dark_transformation) or HasEquippedItem(137075) and target.TimeToDie() < SpellCooldown(summon_gargoyle) - 8 and Spell(dark_transformation) or not HasEquippedItem(137075) and Rune() < 4 and Spell(dark_transformation) or Rune() < 4 and Spell(blighted_rune_weapon)
	{
		#run_action_list,name=valkyr,if=talent.dark_arbiter.enabled&pet.valkyr_battlemaiden.active
		if Talent(dark_arbiter_talent) and pet.Present() UnholyValkyrCdActions()

		unless Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrCdPostConditions()
		{
			#call_action_list,name=generic
			UnholyGenericCdActions()
		}
	}
}

AddFunction UnholyDefaultCdPostConditions
{
	not target.DebuffPresent(virulent_plague_debuff) and Spell(outbreak) or HasEquippedItem(137075) and SpellCooldown(dark_arbiter) > 165 and Spell(dark_transformation) or HasEquippedItem(137075) and not Talent(shadow_infusion_talent) and SpellCooldown(dark_arbiter) > 55 and Spell(dark_transformation) or HasEquippedItem(137075) and Talent(shadow_infusion_talent) and SpellCooldown(dark_arbiter) > 35 and Spell(dark_transformation) or HasEquippedItem(137075) and target.TimeToDie() < SpellCooldown(dark_arbiter) - 8 and Spell(dark_transformation) or HasEquippedItem(137075) and SpellCooldown(summon_gargoyle) > 160 and Spell(dark_transformation) or HasEquippedItem(137075) and not Talent(shadow_infusion_talent) and SpellCooldown(summon_gargoyle) > 55 and Spell(dark_transformation) or HasEquippedItem(137075) and Talent(shadow_infusion_talent) and SpellCooldown(summon_gargoyle) > 35 and Spell(dark_transformation) or HasEquippedItem(137075) and target.TimeToDie() < SpellCooldown(summon_gargoyle) - 8 and Spell(dark_transformation) or not HasEquippedItem(137075) and Rune() < 4 and Spell(dark_transformation) or Rune() < 4 and Spell(blighted_rune_weapon) or Talent(dark_arbiter_talent) and pet.Present() and UnholyValkyrCdPostConditions() or UnholyGenericCdPostConditions()
}

### actions.aoe

AddFunction UnholyAoeMainActions
{
	#death_and_decay,if=spell_targets.death_and_decay>=2
	if Enemies() >= 2 Spell(death_and_decay)
	#epidemic,if=spell_targets.epidemic>4
	if Enemies() > 4 Spell(epidemic)
	#scourge_strike,if=spell_targets.scourge_strike>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	if Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } Spell(scourge_strike)
	#clawing_shadows,if=spell_targets.clawing_shadows>=2&(dot.death_and_decay.ticking|dot.defile.ticking)
	if Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } Spell(clawing_shadows)
	#epidemic,if=spell_targets.epidemic>2
	if Enemies() > 2 Spell(epidemic)
}

AddFunction UnholyAoeMainPostConditions
{
}

AddFunction UnholyAoeShortCdActions
{
}

AddFunction UnholyAoeShortCdPostConditions
{
	Enemies() >= 2 and Spell(death_and_decay) or Enemies() > 4 and Spell(epidemic) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(scourge_strike) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(clawing_shadows) or Enemies() > 2 and Spell(epidemic)
}

AddFunction UnholyAoeCdActions
{
}

AddFunction UnholyAoeCdPostConditions
{
	Enemies() >= 2 and Spell(death_and_decay) or Enemies() > 4 and Spell(epidemic) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(scourge_strike) or Enemies() >= 2 and { target.DebuffPresent(death_and_decay_debuff) or target.DebuffPresent(defile_debuff) } and Spell(clawing_shadows) or Enemies() > 2 and Spell(epidemic)
}

### actions.castigator

AddFunction UnholyCastigatorMainActions
{
	#festering_strike,if=debuff.festering_wound.stack<=4&runic_power.deficit>23
	if target.DebuffStacks(festering_wound_debuff) <= 4 and RunicPowerDeficit() > 23 Spell(festering_strike)
	#death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune<=3
	if not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 Spell(death_coil)
	#scourge_strike,if=buff.necrosis.react&debuff.festering_wound.stack>=3&runic_power.deficit>23
	if BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 Spell(scourge_strike)
	#scourge_strike,if=buff.unholy_strength.react&debuff.festering_wound.stack>=3&runic_power.deficit>23
	if BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 Spell(scourge_strike)
	#scourge_strike,if=rune>=2&debuff.festering_wound.stack>=3&runic_power.deficit>23
	if Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 Spell(scourge_strike)
	#death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
	if Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
	#death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	if Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) Spell(death_coil)
	#death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
	if Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
	#death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	if not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) Spell(death_coil)
}

AddFunction UnholyCastigatorMainPostConditions
{
}

AddFunction UnholyCastigatorShortCdActions
{
}

AddFunction UnholyCastigatorShortCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) <= 4 and RunicPowerDeficit() > 23 and Spell(festering_strike) or not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 and Spell(death_coil) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 and Spell(scourge_strike) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 and Spell(scourge_strike) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

AddFunction UnholyCastigatorCdActions
{
}

AddFunction UnholyCastigatorCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) <= 4 and RunicPowerDeficit() > 23 and Spell(festering_strike) or not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 and Spell(death_coil) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 and Spell(scourge_strike) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 23 and Spell(scourge_strike) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

### actions.generic

AddFunction UnholyGenericMainActions
{
	#death_coil,if=runic_power.deficit<10
	if RunicPowerDeficit() < 10 Spell(death_coil)
	#death_coil,if=!talent.dark_arbiter.enabled&buff.sudden_doom.up&!buff.necrosis.up&rune<=3
	if not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and not BuffPresent(necrosis_buff) and Rune() < 4 Spell(death_coil)
	#death_coil,if=talent.dark_arbiter.enabled&buff.sudden_doom.up&cooldown.dark_arbiter.remains>5&rune<=3
	if Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Rune() < 4 Spell(death_coil)
	#festering_strike,if=debuff.festering_wound.stack<6&cooldown.apocalypse.remains<=6
	if target.DebuffStacks(festering_wound_debuff) < 6 and SpellCooldown(apocalypse) <= 6 Spell(festering_strike)
	#festering_strike,if=debuff.soul_reaper.up&!debuff.festering_wound.up
	if target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) Spell(festering_strike)
	#scourge_strike,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	if target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 Spell(scourge_strike)
	#clawing_shadows,if=debuff.soul_reaper.up&debuff.festering_wound.stack>=1
	if target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 Spell(clawing_shadows)
	#call_action_list,name=aoe,if=active_enemies>=2
	if Enemies() >= 2 UnholyAoeMainActions()

	unless Enemies() >= 2 and UnholyAoeMainPostConditions()
	{
		#call_action_list,name=instructors,if=equipped.132448
		if HasEquippedItem(132448) UnholyInstructorsMainActions()

		unless HasEquippedItem(132448) and UnholyInstructorsMainPostConditions()
		{
			#call_action_list,name=standard,if=!talent.castigator.enabled&!equipped.132448
			if not Talent(castigator_talent) and not HasEquippedItem(132448) UnholyStandardMainActions()

			unless not Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyStandardMainPostConditions()
			{
				#call_action_list,name=castigator,if=talent.castigator.enabled&!equipped.132448
				if Talent(castigator_talent) and not HasEquippedItem(132448) UnholyCastigatorMainActions()
			}
		}
	}
}

AddFunction UnholyGenericMainPostConditions
{
	Enemies() >= 2 and UnholyAoeMainPostConditions() or HasEquippedItem(132448) and UnholyInstructorsMainPostConditions() or not Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyStandardMainPostConditions() or Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyCastigatorMainPostConditions()
}

AddFunction UnholyGenericShortCdActions
{
	#soul_reaper,if=debuff.festering_wound.stack>=6&cooldown.apocalypse.remains<4
	if target.DebuffStacks(festering_wound_debuff) >= 6 and SpellCooldown(apocalypse) < 4 Spell(soul_reaper_unholy)
	#apocalypse,if=debuff.festering_wound.stack>=6
	if target.DebuffStacks(festering_wound_debuff) >= 6 Spell(apocalypse)

	unless RunicPowerDeficit() < 10 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and not BuffPresent(necrosis_buff) and Rune() < 4 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Rune() < 4 and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 6 and SpellCooldown(apocalypse) <= 6 and Spell(festering_strike)
	{
		#soul_reaper,if=debuff.festering_wound.stack>=3
		if target.DebuffStacks(festering_wound_debuff) >= 3 Spell(soul_reaper_unholy)

		unless target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows)
		{
			#defile
			Spell(defile)
			#call_action_list,name=aoe,if=active_enemies>=2
			if Enemies() >= 2 UnholyAoeShortCdActions()

			unless Enemies() >= 2 and UnholyAoeShortCdPostConditions()
			{
				#call_action_list,name=instructors,if=equipped.132448
				if HasEquippedItem(132448) UnholyInstructorsShortCdActions()

				unless HasEquippedItem(132448) and UnholyInstructorsShortCdPostConditions()
				{
					#call_action_list,name=standard,if=!talent.castigator.enabled&!equipped.132448
					if not Talent(castigator_talent) and not HasEquippedItem(132448) UnholyStandardShortCdActions()

					unless not Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyStandardShortCdPostConditions()
					{
						#call_action_list,name=castigator,if=talent.castigator.enabled&!equipped.132448
						if Talent(castigator_talent) and not HasEquippedItem(132448) UnholyCastigatorShortCdActions()
					}
				}
			}
		}
	}
}

AddFunction UnholyGenericShortCdPostConditions
{
	RunicPowerDeficit() < 10 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and not BuffPresent(necrosis_buff) and Rune() < 4 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Rune() < 4 and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 6 and SpellCooldown(apocalypse) <= 6 and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows) or Enemies() >= 2 and UnholyAoeShortCdPostConditions() or HasEquippedItem(132448) and UnholyInstructorsShortCdPostConditions() or not Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyStandardShortCdPostConditions() or Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyCastigatorShortCdPostConditions()
}

AddFunction UnholyGenericCdActions
{
	#dark_arbiter,if=!equipped.137075&runic_power.deficit<30
	if not HasEquippedItem(137075) and RunicPowerDeficit() < 30 Spell(dark_arbiter)
	#dark_arbiter,if=equipped.137075&runic_power.deficit<30&cooldown.dark_transformation.remains<2
	if HasEquippedItem(137075) and RunicPowerDeficit() < 30 and SpellCooldown(dark_transformation) < 2 Spell(dark_arbiter)
	#summon_gargoyle,if=!equipped.137075,if=rune<=3
	if Rune() < 4 Spell(summon_gargoyle)
	#summon_gargoyle,if=equipped.137075&cooldown.dark_transformation.remains<10&rune<=3
	if HasEquippedItem(137075) and SpellCooldown(dark_transformation) < 10 and Rune() < 4 Spell(summon_gargoyle)

	unless target.DebuffStacks(festering_wound_debuff) >= 6 and SpellCooldown(apocalypse) < 4 and Spell(soul_reaper_unholy) or target.DebuffStacks(festering_wound_debuff) >= 6 and Spell(apocalypse) or RunicPowerDeficit() < 10 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and not BuffPresent(necrosis_buff) and Rune() < 4 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Rune() < 4 and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 6 and SpellCooldown(apocalypse) <= 6 and Spell(festering_strike) or target.DebuffStacks(festering_wound_debuff) >= 3 and Spell(soul_reaper_unholy) or target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows) or Spell(defile)
	{
		#call_action_list,name=aoe,if=active_enemies>=2
		if Enemies() >= 2 UnholyAoeCdActions()

		unless Enemies() >= 2 and UnholyAoeCdPostConditions()
		{
			#call_action_list,name=instructors,if=equipped.132448
			if HasEquippedItem(132448) UnholyInstructorsCdActions()

			unless HasEquippedItem(132448) and UnholyInstructorsCdPostConditions()
			{
				#call_action_list,name=standard,if=!talent.castigator.enabled&!equipped.132448
				if not Talent(castigator_talent) and not HasEquippedItem(132448) UnholyStandardCdActions()

				unless not Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyStandardCdPostConditions()
				{
					#call_action_list,name=castigator,if=talent.castigator.enabled&!equipped.132448
					if Talent(castigator_talent) and not HasEquippedItem(132448) UnholyCastigatorCdActions()
				}
			}
		}
	}
}

AddFunction UnholyGenericCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) >= 6 and SpellCooldown(apocalypse) < 4 and Spell(soul_reaper_unholy) or target.DebuffStacks(festering_wound_debuff) >= 6 and Spell(apocalypse) or RunicPowerDeficit() < 10 and Spell(death_coil) or not Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and not BuffPresent(necrosis_buff) and Rune() < 4 and Spell(death_coil) or Talent(dark_arbiter_talent) and BuffPresent(sudden_doom_buff) and SpellCooldown(dark_arbiter) > 5 and Rune() < 4 and Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 6 and SpellCooldown(apocalypse) <= 6 and Spell(festering_strike) or target.DebuffStacks(festering_wound_debuff) >= 3 and Spell(soul_reaper_unholy) or target.DebuffPresent(soul_reaper_unholy_debuff) and not target.DebuffPresent(festering_wound_debuff) and Spell(festering_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(scourge_strike) or target.DebuffPresent(soul_reaper_unholy_debuff) and target.DebuffStacks(festering_wound_debuff) >= 1 and Spell(clawing_shadows) or Spell(defile) or Enemies() >= 2 and UnholyAoeCdPostConditions() or HasEquippedItem(132448) and UnholyInstructorsCdPostConditions() or not Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyStandardCdPostConditions() or Talent(castigator_talent) and not HasEquippedItem(132448) and UnholyCastigatorCdPostConditions()
}

### actions.instructors

AddFunction UnholyInstructorsMainActions
{
	#festering_strike,if=debuff.festering_wound.stack<=3&runic_power.deficit>13
	if target.DebuffStacks(festering_wound_debuff) <= 3 and RunicPowerDeficit() > 13 Spell(festering_strike)
	#death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune<=3
	if not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 Spell(death_coil)
	#scourge_strike,if=buff.necrosis.react&debuff.festering_wound.stack>=4&runic_power.deficit>29
	if BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 Spell(scourge_strike)
	#clawing_shadows,if=buff.necrosis.react&debuff.festering_wound.stack>=3&runic_power.deficit>11
	if BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 Spell(clawing_shadows)
	#scourge_strike,if=buff.unholy_strength.react&debuff.festering_wound.stack>=4&runic_power.deficit>29
	if BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 Spell(scourge_strike)
	#clawing_shadows,if=buff.unholy_strength.react&debuff.festering_wound.stack>=3&runic_power.deficit>11
	if BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 Spell(clawing_shadows)
	#scourge_strike,if=rune>=2&debuff.festering_wound.stack>=4&runic_power.deficit>29
	if Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 Spell(scourge_strike)
	#clawing_shadows,if=rune>=2&debuff.festering_wound.stack>=3&runic_power.deficit>11
	if Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 Spell(clawing_shadows)
	#death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
	if Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
	#death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	if Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) Spell(death_coil)
	#death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
	if Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
	#death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	if not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) Spell(death_coil)
}

AddFunction UnholyInstructorsMainPostConditions
{
}

AddFunction UnholyInstructorsShortCdActions
{
}

AddFunction UnholyInstructorsShortCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) <= 3 and RunicPowerDeficit() > 13 and Spell(festering_strike) or not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 and Spell(death_coil) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 and Spell(scourge_strike) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 and Spell(scourge_strike) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

AddFunction UnholyInstructorsCdActions
{
}

AddFunction UnholyInstructorsCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) <= 3 and RunicPowerDeficit() > 13 and Spell(festering_strike) or not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 and Spell(death_coil) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 and Spell(scourge_strike) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 4 and RunicPowerDeficit() > 29 and Spell(scourge_strike) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 3 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

### actions.precombat

AddFunction UnholyPrecombatMainActions
{
}

AddFunction UnholyPrecombatMainPostConditions
{
}

AddFunction UnholyPrecombatShortCdActions
{
	#raise_dead
	Spell(raise_dead)
}

AddFunction UnholyPrecombatShortCdPostConditions
{
}

AddFunction UnholyPrecombatCdActions
{
	#flask,name=countless_armies
	#food,name=nightborne_delicacy_platter
	#augmentation,name=defiled
	#snapshot_stats
	#potion,name=prolonged_power
	if CheckBoxOn(opt_use_consumables) and target.Classification(worldboss) Item(prolonged_power_potion usable=1)

	unless Spell(raise_dead)
	{
		#army_of_the_dead
		Spell(army_of_the_dead)
	}
}

AddFunction UnholyPrecombatCdPostConditions
{
	Spell(raise_dead)
}

### actions.standard

AddFunction UnholyStandardMainActions
{
	#festering_strike,if=debuff.festering_wound.stack<=3&runic_power.deficit>13
	if target.DebuffStacks(festering_wound_debuff) <= 3 and RunicPowerDeficit() > 13 Spell(festering_strike)
	#death_coil,if=!buff.necrosis.up&talent.necrosis.enabled&rune<=3
	if not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 Spell(death_coil)
	#scourge_strike,if=buff.necrosis.react&debuff.festering_wound.stack>=1&runic_power.deficit>15
	if BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 Spell(scourge_strike)
	#clawing_shadows,if=buff.necrosis.react&debuff.festering_wound.stack>=1&runic_power.deficit>11
	if BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 Spell(clawing_shadows)
	#scourge_strike,if=buff.unholy_strength.react&debuff.festering_wound.stack>=1&runic_power.deficit>15
	if BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 Spell(scourge_strike)
	#clawing_shadows,if=buff.unholy_strength.react&debuff.festering_wound.stack>=1&runic_power.deficit>11
	if BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 Spell(clawing_shadows)
	#scourge_strike,if=rune>=2&debuff.festering_wound.stack>=1&runic_power.deficit>15
	if Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 Spell(scourge_strike)
	#clawing_shadows,if=rune>=2&debuff.festering_wound.stack>=1&runic_power.deficit>11
	if Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 Spell(clawing_shadows)
	#death_coil,if=talent.shadow_infusion.enabled&talent.dark_arbiter.enabled&!buff.dark_transformation.up&cooldown.dark_arbiter.remains>15
	if Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
	#death_coil,if=talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled&!buff.dark_transformation.up
	if Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) Spell(death_coil)
	#death_coil,if=talent.dark_arbiter.enabled&cooldown.dark_arbiter.remains>15
	if Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 Spell(death_coil)
	#death_coil,if=!talent.shadow_infusion.enabled&!talent.dark_arbiter.enabled
	if not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) Spell(death_coil)
}

AddFunction UnholyStandardMainPostConditions
{
}

AddFunction UnholyStandardShortCdActions
{
}

AddFunction UnholyStandardShortCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) <= 3 and RunicPowerDeficit() > 13 and Spell(festering_strike) or not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 and Spell(death_coil) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 and Spell(scourge_strike) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 and Spell(scourge_strike) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

AddFunction UnholyStandardCdActions
{
}

AddFunction UnholyStandardCdPostConditions
{
	target.DebuffStacks(festering_wound_debuff) <= 3 and RunicPowerDeficit() > 13 and Spell(festering_strike) or not BuffPresent(necrosis_buff) and Talent(necrosis_talent) and Rune() < 4 and Spell(death_coil) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 and Spell(scourge_strike) or BuffPresent(necrosis_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 and Spell(scourge_strike) or BuffPresent(unholy_strength_buff) and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 15 and Spell(scourge_strike) or Rune() >= 2 and target.DebuffStacks(festering_wound_debuff) >= 1 and RunicPowerDeficit() > 11 and Spell(clawing_shadows) or Talent(shadow_infusion_talent) and Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and not pet.BuffPresent(dark_transformation_buff) and Spell(death_coil) or Talent(dark_arbiter_talent) and SpellCooldown(dark_arbiter) > 15 and Spell(death_coil) or not Talent(shadow_infusion_talent) and not Talent(dark_arbiter_talent) and Spell(death_coil)
}

### actions.valkyr

AddFunction UnholyValkyrMainActions
{
	#death_coil
	Spell(death_coil)
	#festering_strike,if=debuff.festering_wound.stack<8&cooldown.apocalypse.remains<5
	if target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 Spell(festering_strike)
	#call_action_list,name=aoe,if=active_enemies>=2
	if Enemies() >= 2 UnholyAoeMainActions()

	unless Enemies() >= 2 and UnholyAoeMainPostConditions()
	{
		#festering_strike,if=debuff.festering_wound.stack<=3
		if target.DebuffStacks(festering_wound_debuff) <= 3 Spell(festering_strike)
		#scourge_strike,if=debuff.festering_wound.up
		if target.DebuffPresent(festering_wound_debuff) Spell(scourge_strike)
		#clawing_shadows,if=debuff.festering_wound.up
		if target.DebuffPresent(festering_wound_debuff) Spell(clawing_shadows)
	}
}

AddFunction UnholyValkyrMainPostConditions
{
	Enemies() >= 2 and UnholyAoeMainPostConditions()
}

AddFunction UnholyValkyrShortCdActions
{
	unless Spell(death_coil)
	{
		#apocalypse,if=debuff.festering_wound.stack=8
		if target.DebuffStacks(festering_wound_debuff) == 8 Spell(apocalypse)

		unless target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike)
		{
			#call_action_list,name=aoe,if=active_enemies>=2
			if Enemies() >= 2 UnholyAoeShortCdActions()
		}
	}
}

AddFunction UnholyValkyrShortCdPostConditions
{
	Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or Enemies() >= 2 and UnholyAoeShortCdPostConditions() or target.DebuffStacks(festering_wound_debuff) <= 3 and Spell(festering_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(scourge_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(clawing_shadows)
}

AddFunction UnholyValkyrCdActions
{
	unless Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) == 8 and Spell(apocalypse) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike)
	{
		#call_action_list,name=aoe,if=active_enemies>=2
		if Enemies() >= 2 UnholyAoeCdActions()
	}
}

AddFunction UnholyValkyrCdPostConditions
{
	Spell(death_coil) or target.DebuffStacks(festering_wound_debuff) == 8 and Spell(apocalypse) or target.DebuffStacks(festering_wound_debuff) < 8 and SpellCooldown(apocalypse) < 5 and Spell(festering_strike) or Enemies() >= 2 and UnholyAoeCdPostConditions() or target.DebuffStacks(festering_wound_debuff) <= 3 and Spell(festering_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(scourge_strike) or target.DebuffPresent(festering_wound_debuff) and Spell(clawing_shadows)
}

### Unholy icons.

AddCheckBox(opt_deathknight_unholy_aoe L(AOE) default specialization=unholy)

AddIcon checkbox=!opt_deathknight_unholy_aoe enemies=1 help=shortcd specialization=unholy
{
	if not InCombat() UnholyPrecombatShortCdActions()
	unless not InCombat() and UnholyPrecombatShortCdPostConditions()
	{
		UnholyDefaultShortCdActions()
	}
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=shortcd specialization=unholy
{
	if not InCombat() UnholyPrecombatShortCdActions()
	unless not InCombat() and UnholyPrecombatShortCdPostConditions()
	{
		UnholyDefaultShortCdActions()
	}
}

AddIcon enemies=1 help=main specialization=unholy
{
	if not InCombat() UnholyPrecombatMainActions()
	unless not InCombat() and UnholyPrecombatMainPostConditions()
	{
		UnholyDefaultMainActions()
	}
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=aoe specialization=unholy
{
	if not InCombat() UnholyPrecombatMainActions()
	unless not InCombat() and UnholyPrecombatMainPostConditions()
	{
		UnholyDefaultMainActions()
	}
}

AddIcon checkbox=!opt_deathknight_unholy_aoe enemies=1 help=cd specialization=unholy
{
	if not InCombat() UnholyPrecombatCdActions()
	unless not InCombat() and UnholyPrecombatCdPostConditions()
	{
		UnholyDefaultCdActions()
	}
}

AddIcon checkbox=opt_deathknight_unholy_aoe help=cd specialization=unholy
{
	if not InCombat() UnholyPrecombatCdActions()
	unless not InCombat() and UnholyPrecombatCdPostConditions()
	{
		UnholyDefaultCdActions()
	}
}

### Required symbols
# 132448
# 137075
# apocalypse
# arcane_torrent_runicpower
# army_of_the_dead
# asphyxiate
# berserking
# blighted_rune_weapon
# blood_fury_ap
# castigator_talent
# clawing_shadows
# dark_arbiter
# dark_arbiter_talent
# dark_transformation
# dark_transformation_buff
# death_and_decay
# death_and_decay_debuff
# death_coil
# death_strike
# defile
# defile_debuff
# epidemic
# festering_strike
# festering_wound_debuff
# mind_freeze
# necrosis_buff
# necrosis_talent
# outbreak
# prolonged_power_potion
# raise_dead
# scourge_strike
# shadow_infusion_talent
# soul_reaper_unholy
# soul_reaper_unholy_debuff
# sudden_doom_buff
# summon_gargoyle
# unholy_strength_buff
# valkyr_battlemaiden
# virulent_plague_debuff
# war_stomp
]]
    __Scripts.OvaleScripts:RegisterScript("DEATHKNIGHT", "unholy", name, desc, code, "script")
end
end)
