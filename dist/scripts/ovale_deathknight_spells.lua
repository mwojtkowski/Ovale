local __exports = LibStub:NewLibrary("ovale/scripts/ovale_deathknight_spells", 10000)
if not __exports then return end
local __Scripts = LibStub:GetLibrary("ovale/Scripts")
local OvaleScripts = __Scripts.OvaleScripts
__exports.register = function()
    local name = "ovale_deathknight_spells"
    local desc = "[7.0] Ovale: Death Knight spells"
    local code = [[

ItemRequire(shifting_cosmic_sliver unusable 1=oncooldown,!icebound_fortitude,buff,!icebound_fortitude_buff)
	
# Death Knight spells and functions.

# Learned spells.
Define(antimagic_shell 48707)
	SpellInfo(antimagic_shell cd=45 gcd=0 offgcd=1)
	SpellInfo(antimagic_shell buff_cdr=cooldown_reduction_strength_buff specialization=frost)
	SpellInfo(antimagic_shell buff_cdr=cooldown_reduction_strength_buff specialization=unholy)
	SpellInfo(antimagic_shell buff_cdr=cooldown_reduction_tank_buff specialization=blood)
Define(antimagic_shell_buff 48707)
	SpellInfo(antimagic_shell_buff duration=5)
Define(apocalypse 214839)
Define(army_of_the_dead 42650)
	SpellInfo(army_of_the_dead runicpower=-30 runes=3 cd=600)
	SpellInfo(army_of_the_dead buff_cdr=cooldown_reduction_strength_buff specialization=frost)
	SpellInfo(army_of_the_dead buff_cdr=cooldown_reduction_strength_buff specialization=unholy)
	SpellAddBuff(army_of_the_dead army_of_the_dead_buff=1)
Define(army_of_the_dead_buff 42650) # XXX
	SpellInfo(army_of_the_dead_buff duration=40)
Define(asphyxiate 221562)
	SpellInfo(asphyxiate cd=45 interrupt=1)
	SpellAddTargetDebuff(asphyxiate asphyxiate_debuff=1)
Define(asphyxiate_debuff 108194)
	SpellInfo(asphyxiate_debuff duration=5)
Define(blighted_rune_weapon 194918)
	SpellInfo(blighted_rune_weapon cd=60)
	SpellAddBuff(blighted_rune_weapon blighted_rune_weapon_buff=1)
Define(blighted_rune_weapon_buff 194918)
	SpellInfo(blighted_rune_weapon duration=60)
Define(blinding_sleet 207167)
	SpellInfo(blinding_sleet cd=60)
Define(blood_boil 50842)
	SpellAddTargetDebuff(blood_boil blood_plague_debuff=1)
	SpellAddBuff(blood_boil gravewarden_buff=1 itemset=T20 itemcount=2)
Define(blood_mirror 206977)
Define(blood_plague_debuff 55078)
	SpellInfo(blood_plague_debuff duration=24 tick=3)
Define(blood_shield 77513)
	SpellInfo(blood_shield learn=1 level=80 specialization=blood)
Define(blood_shield_buff 77535)
	SpellInfo(blood_shield_buff duration=10)
Define(blood_tap 221699)
	SpellInfo(blood_tap gcd=0 offgcd=1)
Define(bonestorm 194844)
	SpellAddBuff(bonestorm bonestorm_buff=1)
Define(bonestorm_buff 194844)
Define(bone_shield_buff 195181)
	SpellInfo(bone_shield_buff duration=30)
Define(breath_of_sindragosa 152279)
	SpellInfo(breath_of_sindragosa runicpower=15 cd=120 gcd=0)
	SpellAddBuff(breath_of_sindragosa breath_of_sindragosa_buff=1)
Define(breath_of_sindragosa_buff 152279)
Define(chains_of_ice 45524)
	SpellInfo(chains_of_ice runes=1 runicpower=-10)
Define(clawing_shadows 207311)
	SpellInfo(clawing_shadows runes=1 runicpower=-10)
	SpellAddTargetDebuff(clawing_shadows festering_wound_debuff=-1)
Define(consumption 205223)
Define(conversion 119975)
	SpellAddBuff(conversion conversion_buff=toggle)
Define(conversion_buff 119975)
Define(crimson_scourge 81136)
Define(crimson_scourge_buff 81141)
	SpellInfo(crimson_scourge_buff duration=15 specialization=blood)
Define(dancing_rune_weapon 49028)
	SpellInfo(dancing_rune_weapon cd=90 gcd=0)
	SpellInfo(dancing_rune_weapon buff_cdr=cooldown_reduction_tank_buff specialization=blood)
	SpellAddBuff(dancing_rune_weapon dancing_rune_weapon_buff=1)
Define(dancing_rune_weapon_buff 81256)
	SpellInfo(dancing_rune_weapon_buff duration=8)
Define(dark_arbiter 207349)
	SpellInfo(dark_arbiter cd=180)
Define(dark_simulacrum 77606)
	SpellInfo(dark_simulacrum cd=60)
	SpellAddTargetDebuff(dark_simulacrum dark_simulacrum_debuff=1)
Define(dark_simulacrum_debuff 77606)
	SpellInfo(dark_simulacrum_debuff duration=8)
Define(dark_succor 178819)
Define(dark_succor_buff 101568)
	SpellInfo(dark_succor_buff duration=15)
Define(dark_transformation 63560)
	SpellInfo(dark_transformation cd=60)
	SpellAddPetBuff(dark_transformation dark_transformation_buff=1)
Define(dark_transformation_buff 63560)
	SpellInfo(dark_transformation_buff duration=20)
Define(death_and_decay 43265)
	SpellInfo(death_and_decay runes=1 runicpower=-10 cd=30 specialization=unholy)
	SpellInfo(death_and_decay runes=1 runicpower=-10 cd=15 specialization=blood)
	SpellRequire(death_and_decay runes 0=buff,crimson_scourge_buff)
	SpellRequire(death_and_decay cd_percent 0=buff,crimson_scourge_buff)
	SpellAddTargetDebuff(death_and_decay death_and_decay_debuff=1)
Define(death_and_decay_buff 188290)
Define(death_and_decay_debuff 43265)
Define(death_coil 47541)
	SpellInfo(death_coil runicpower=45 travel_time=1)
	SpellRequire(death_coil runicpower_percent 0=buff,sudden_doom_buff if_spell=sudden_doom)
	SpellAddBuff(death_coil blood_charge_buff=2 if_spell=blood_tap)
	SpellAddTargetDebuff(death_coil blood_plague_debuff=extend,4 frost_fever_debuff=extend,4 if_spell=!necrotic_plague if_spell=plaguebearer)
	SpellAddTargetDebuff(death_coil necrotic_plague_debuff=1 if_spell=necrotic_plague if_spell=plaguebearer)
Define(death_grip 49576)
	SpellInfo(death_grip cd=25)
	SpellInfo(death_grip add_cd=-5 if_spell=enhanced_death_grip)
Define(death_strike 49998)
	SpellInfo(death_strike runicpower=45)
	SpellRequire(death_strike add_runicpower -5=buff,ossuary_buff)
	SpellRequire(death_strike add_runicpower -5=buff,gravewarden_buff)
Define(deaths_advance 96268)
	SpellInfo(deaths_advance cd=30 gcd=0 offgcd=1)
Define(deaths_caress 195292)
	SpellInfo(deaths_caress runes=1 runicpower=-10)
Define(defile 152280)
	SpellInfo(defile runes=1 runicpower=-10 cd=30)
Define(defile_debuff 156004)
Define(ebon_plaguebringer 51160)
	SpellInfo(ebon_plaguebringer learn=1 specialization=unholy)
Define(empower_rune_weapon 47568)
	SpellInfo(empower_rune_weapon cd=180 runicpower=-25 runes=-6 tag=cd)
	SpellInfo(empower_rune_weapon replace=hungering_rune_weapon talent=hungering_rune_weapon_talent specialization=frost)
Define(epidemic 207317)
	SpellInfo(epidemic runes=1 runicpower=-10 cd=10)
Define(festering_strike 85948)
	SpellInfo(festering_strike runes=2 runicpower=-20)
	SpellAddTargetDebuff(festering_strike blood_plague_debuff=extend,6 frost_fever_debuff=extend,6)
Define(festering_wound_debuff 194310)
Define(frost_fever_debuff 55095)
	SpellInfo(frost_fever_debuff duration=30 tick=3)
Define(frost_strike 49143)
	SpellInfo(frost_strike runicpower=25)
	SpellAddBuff(frost_strike icy_talons_buff=1 talent=icy_talons_talent)
	SpellAddBuff(frost_strike killing_machine_buff 1=buff,obliteration_buff)
Define(frostscythe 207230)
	SpellInfo(frostscythe runes=1 runicpower=-10)
Define(gathering_storm_buff 194912)
Define(glacial_advance 194913)
	SpellInfo(glacial_advance runes=1 runicpower=-10 cd=15 cd_haste=melee)
Define(gravewarden_buff 242010)
	SpellInfo(gravewarden_buff duration=10)
Define(heart_strike 206930)
	SpellInfo(heart_strike runes=1 runicpower=-10)
Define(horn_of_winter 57330)
	SpellInfo(horn_of_winter cd=45 runes=-2 runicpower=-20 tag=main)
Define(howling_blast 49184)
	SpellInfo(howling_blast runes=1 runicpower=-10)
	SpellRequire(howling_blast runes 0=buff,rime_buff)
	SpellRequire(howling_blast runicpower_percent 0=buff,rime_buff)
	SpellAddBuff(howling_blast rime_buff=0)
	SpellAddBuff(howling_blast killing_machine_buff 1=buff,obliteration_buff)
	SpellAddTargetDebuff(howling_blast frost_fever_debuff=1)
Define(hungering_rune_weapon 207127)
	SpellInfo(hungering_rune_weapon cd=180 runicpower=-25 runes=-6 tag=cd)
	SpellAddBuff(hungering_rune_weapon hungering_rune_weapon_buff=1)
Define(hungering_rune_weapon_buff 207127)
	SpellInfo(hungering_rune_weapon_buff duration=12)
Define(icebound_fortitude 48792)
	SpellInfo(icebound_fortitude cd=180 gcd=0 offgcd=1)
	SpellInfo(icebound_fortitude buff_cdr=cooldown_reduction_strength_buff specialization=frost)
	SpellInfo(icebound_fortitude buff_cdr=cooldown_reduction_strength_buff specialization=unholy)
	SpellInfo(icebound_fortitude buff_cdr=cooldown_reduction_tank_buff specialization=blood)
	SpellAddBuff(icebound_fortitude icebound_fortitude_buff=1)
Define(icebound_fortitude_buff 48792)
	SpellInfo(icebound_fortitude_buff duration=8)
Define(icy_talons_buff 194879)
Define(killing_machine 51128)
Define(killing_machine_buff 51124)
	SpellInfo(killing_machine_buff duration=10)
Define(lichborne 49039)
	SpellInfo(lichborne cd=120 gcd=0)
Define(mark_of_blood 206940)
	SpellInfo(mark_of_blood runicpower=30)
Define(mark_of_blood_debuff 206940)
Define(marrowrend 195182)
	SpellInfo(marrowrend runes=2 runicpower=-20)
	SpellAddBuff(marrowrend bone_shield_buff=1)
Define(mind_freeze 47528)
	SpellInfo(mind_freeze cd=15 gcd=0 interrupt=1 offgcd=1)
Define(necrosis_buff 207346)
Define(obliterate 49020)
	SpellInfo(obliterate runes=2 runicpower=-20)
	SpellAddBuff(obliterate killing_machine_buff=0)
	SpellRequire(obliterate runes 1=buff,obliteration_buff)
Define(obliteration 207256)
	SpellInfo(obliteration cd=90 tag=cd offgcd=1 gcd=0)
	SpellAddBuff(obliteration obliteration_buff=1)
Define(obliteration_buff 207256)
	SpellInfo(obliteration_buff duration=10)
Define(outbreak 77575)
	SpellInfo(outbreak runicpower=-10 runes=1)
	SpellAddTargetDebuff(outbreak virulent_plague_debuff=1)
Define(ossuary_buff 219788)
Define(pillar_of_frost 51271)
	SpellInfo(pillar_of_frost cd=60 gcd=0)
	SpellAddBuff(pillar_of_frost pillar_of_frost_buff=1)
Define(pillar_of_frost_buff 51271)
	SpellInfo(pillar_of_frost duration=20)
Define(plague_leech 123693)
	SpellInfo(plague_leech cd=25 runes=-2)
	SpellAddTargetDebuff(plague_leech blood_plague_debuff=0 frost_fever_debuff=0)
Define(plague_strike 52373)
	SpellInfo(plague_strike runes=2 runicpower=20)
	SpellAddTargetDebuff(plague_strike plague_strike_debuff=1)
Define(plague_strike_debuff 52373)
	SpellInfo(plague_strike_debuff duration=12)
Define(raise_dead 46584)
	SpellInfo(raise_dead cd=60)
Define(razorice_debuff 51714)
Define(remorseless_winter 196770)
	SpellInfo(remorseless_winter cd=20 runes=1 runicpower=-10)
Define(remorseless_winter_buff 196770)
	SpellInfo(remorseless_winter_buff duration=8)
Define(remorseless_winter_debuff 211973)
Define(rime_buff 59052)
	SpellInfo(rime_buff duration=15)
Define(rune_tap 194679)
Define(rune_tap_buff 194679)
Define(runic_corruption_buff 51460)
	SpellInfo(runic_corruption_buff duration=3) #TODO Increase rune generation rate
Define(scent_of_blood 49509)
	SpellInfo(scent_of_blood learn=1 specialization=blood)
Define(scourge_strike 55090)
	SpellInfo(scourge_strike runes=1 runicpower=-10)
Define(sindragosas_fury 190778)
	SpellInfo(sindragosas_fury cd=300)
	SpellInfo(sindragosas_fury cd=150 if_equipped=consorts_cold_core)
Define(soul_reaper_blood 114866)
	SpellInfo(soul_reaper_blood blood=1 cd=6)
	SpellAddBuff(soul_reaper_blood scent_of_blood_buff=1 if_spell=scent_of_blood)
	SpellAddTargetDebuff(soul_reaper_blood soul_reaper_blood_debuff=1)
Define(soul_reaper 130736)
	SpellInfo(soul_reaper runes=1 runicpower=-10 cd=45)
	SpellAddTargetDebuff(soul_reaper soul_reaper_debuff=1)
Define(soul_reaper_debuff 130736)
	SpellInfo(soul_reaper_debuff duration=5)
Define(soul_reaper_unholy 130736)
Define(soul_reaper_unholy_debuff 130736)
Define(strangulate 47476)
	SpellInfo(strangulate cd=60 interrupt=1)
Define(sudden_doom 49530)
Define(sudden_doom_buff 81340)
	SpellInfo(sudden_doom_buff duration=10)
Define(summon_gargoyle 49206)
	SpellInfo(summon_gargoyle cd=180)
Define(t18_class_trinket 124513)
Define(tombstone 219809)
Define(unholy_blight 115989)
	SpellInfo(unholy_blight cd=90)
Define(unholy_strength_buff 53365)
Define(valkyr_battlemaiden 100876) #TODO In fact it's a pet
Define(vampiric_blood 55233)
	SpellInfo(vampiric_blood cd=90 gcd=0 offgcd=1)
	SpellAddBuff(vampiric_blood vampiric_blood_buff=1)
Define(vampiric_blood_buff 55233)
	SpellInfo(vampiric_blood_buff duration=10)
Define(virulent_plague_debuff 191587)

# Talents
Define(all_will_serve_talent 2)
Define(anti-magic_barrier_talent 11)
Define(army_of_the_damned_talent 19)
Define(asphyxiate_talent 8)
Define(asphyxiate_talent_unholy 9)
Define(avalanche_talent 10)
Define(blinding_sleet_talent 9)
Define(blooddrinker_talent 2)
Define(bloodworms_talent 17)
Define(bonestorm_talent 21)
Define(breath_of_sindragosa_talent 21)
Define(bursting_sores_talent 4)
Define(clawing_shadows_talent 3)
Define(cold_heart_talent 3)
Define(consumption_talent 6)
Define(death_pact_talent 15)
Define(deaths_reach_talent 7)
Define(deaths_reach_talent_unholy 8)
Define(defile_talent 17)
Define(ebon_fever_talent 5)
Define(epidemic_talent 18)
Define(foul_bulwark_talent 7)
Define(frostscythe_talent 12)
Define(frostwyrms_fury_talent 18)
Define(frozen_pulse_talent 11)
Define(gathering_storm_talent 16)
Define(glacial_advance_talent 17)
Define(grip_of_the_dead_talent 13)
Define(grip_of_the_dead_talent_unholy 7)
Define(harbinger_of_doom_talent 11)
Define(heartbreaker_talent 1)
Define(hemostasis_talent 5)
Define(horn_of_winter_talent 6)
Define(icecap_talent 19)
Define(icy_talons_talent 2)
Define(inexorable_assault_talent 1)
Define(infected_claws_talent 1)
Define(mark_of_blood_talent 18)
Define(murderous_efficiency_talent 5)
Define(obliteration_talent 20)
Define(ossuary_talent 8)
Define(permafrost_talent 13)
Define(pestilence_talent 16)
Define(pestilent_pustules_talent 10)
Define(purgatory_talent 19)
Define(rapid_decomposition_talent 4)
Define(red_thirst_talent 20)
Define(rune_strike_talent 3)
Define(rune_tap_talent 12)
Define(runic_attenuation_talent 4)
Define(soul_reaper_talent 12)
Define(spell_eater_talent 13)
Define(summon_gargoyle_talent 21)
Define(tightening_grasp_talent 14)
Define(tombstone_talent 9)
Define(unholy_blight_talent 6)
Define(unholy_frenzy_talent 20)
Define(voracious_talent 16)
Define(will_of_the_necropolis_talent 10)
Define(wraith_walk_talent_blood 15)
Define(wraith_walk_talent 14)

# Artifact traits
Define(apocalypse 220143)
	SpellInfo(apocalypse cd=90)
Define(frozen_soul 189184)

# Legendary
Define(cold_heart 151796)
Define(cold_heart_buff 235599)
Define(consorts_cold_core 144293)
Define(koltiras_newfound_will 132366)
Define(perseverance_of_the_ebon_martyr 132459)
Define(perseverance_of_the_ebon_martyr_debuff 216059)

# Non-default tags for OvaleSimulationCraft.
	SpellInfo(blood_tap tag=main)
	SpellInfo(outbreak tag=main)
]]
    OvaleScripts:RegisterScript("DEATHKNIGHT", nil, name, desc, code, "include")
end
