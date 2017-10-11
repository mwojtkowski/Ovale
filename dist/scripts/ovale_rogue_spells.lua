local __addonName, __addon = ...
            __addon.require("./scripts/ovale_rogue_spells", { "./Scripts" }, function(__exports, __Scripts)
do
    local name = "ovale_rogue_spells"
    local desc = "[7.0] Ovale: Rogue spells"
    local code = [[
# Rogue spells and functions.

# Items
Define(bleeding_hollow_toxin_vessel 124520)
Define(denial_of_the_halfgiants 137100)
Define(duskwalkers_footpads 137030)
Define(greenskins_waterlogged_wristcuffs 137099)
Define(greenskins_waterlogged_wristcuffs_buff 209423)
Define(insignia_of_ravenholdt 137049)
Define(mantle_of_the_master_assassin 144236)
	Define(master_assassins_initiative 235022)
		SpellInfo(master_assassins_initiative duration=6)
Define(the_dreadlords_deceit 137021)
Define(the_dreadlords_deceit_buff 208692)
Define(thraxis_tricksy_treads 137031)
Define(shadow_satyrs_walk 137032)
Define(shivarran_symmetry 141321)

# Learned spells.
Define(blindside 121152)
	SpellInfo(blindside learn=1 level=40 specialization=assassination)
Define(find_weakness 91023)
	SpellInfo(find_weakness learn=1 level=10 specialization=subtlety)

Define(adrenaline_rush 13750)
	SpellInfo(adrenaline_rush cd=180 gcd=0)
	SpellInfo(adrenaline_rush buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(adrenaline_rush adrenaline_rush_aura=1)
Define(adrenaline_rush_aura 13750)
	SpellInfo(adrenaline_rush_aura duration=15)
Define(adrenaline_rush_t18_aura 186286)
	SpellInfo(adrenaline_rush_t18_aura duration=4)
SpellList(adrenaline_rush_buff adrenaline_rush_aura adrenaline_rush_t18_aura)
Define(alacrity_buff 193539)
Define(alacrity_talent 17)
Define(ambush 8676)
	SpellInfo(ambush combo=2 energy=60)
	SpellRequire(ambush unusable 1=!stealthed)
	SpellAddTargetDebuff(ambush find_weakness_debuff=1 if_spell=find_weakness)
Define(anticipation 114015)
Define(anticipation_buff 115189)
	SpellInfo(anticipation_buff duration=15)
Define(anticipation_talent 8)
Define(backstab 53)
	SpellInfo(backstab combo=1 energy=35)
	SpellAddBuff(backstab silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(bag_of_tricks 192657)
Define(bandits_guile 84654)
Define(bandits_guile_buff 84654)
	SpellInfo(bandits_guile_buff duration=15 max_stacks=12)
Define(between_the_eyes 199804)
	SpellInfo(between_the_eyes combo=finisher energy=35 cd=20)
Define(blade_flurry 13877)
	SpellInfo(blade_flurry cd=10 gcd=0 offgcd=1)
	SpellAddBuff(blade_flurry blade_flurry_buff=toggle)
Define(blade_flurry_buff 13877)
Define(blindside_buff 121153)
	SpellInfo(blindside_buff duration=10)
Define(blunderbuss_buff 202895)
Define(broadsides_buff 193356)
Define(burst_of_speed 108212)
	SpellInfo(burst_of_speed cd=3 energy=30)
	SpellAddBuff(burst_of_speed burst_of_speed_buff=1)
Define(burst_of_speed_buff 137573)
	SpellInfo(burst_of_speed_buff duration=4)
Define(cannonball_barrage 185767)
	SpellInfo(cannonball_barrage cd=60)
Define(cheap_shot 1833)
	SpellInfo(cheap_shot combo=2 energy=40 interrupt=1)
	SpellRequire(cheap_shot unusable 1=!stealthed)
	SpellInfo(cheap_shot buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellInfo(cheap_shot buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2 specialization=combat)
	SpellInfo(cheap_shot buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2 specialization=subtlety)
	SpellAddBuff(cheap_shot silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddTargetDebuff(cheap_shot find_weakness_debuff=1 if_spell=find_weakness)
Define(crimson_tempest 121411)
	SpellInfo(crimson_tempest combo=finisher energy=35)
	SpellAddTargetDebuff(crimson_tempest crimson_tempest_debuff=1)
Define(crimson_tempest_debuff 122233)
	SpellInfo(crimson_tempest_debuff duration=12 tick=2)
Define(crippling_poison 3408)
	SpellAddBuff(crippling_poison crippling_poison_buff=1)
Define(crippling_poison_buff 3408)
	SpellInfo(crippling_poison_buff duration=3600)
Define(curse_of_the_dreadblades 202665)
	SpellInfo(curse_of_the_dreadblades cd=90 tag=cd)
Define(curse_of_the_dreadblades_buff 202665)
Define(deadly_poison 2823)
	SpellInfo(deadly_poison replace=instant_poison unusable=1 if_spell=swift_poison)
	SpellAddBuff(deadly_poison deadly_poison_buff=1)
Define(deadly_poison_buff 2823)
	SpellInfo(deadly_poison_buff duration=3600)
Define(deadly_poison_dot_debuff 2818)
	SpellInfo(deadly_poison_dot_debuff duration=12 tick=3)
Define(deadly_throw 26679)
	SpellInfo(deadly_throw combo=finisher energy=35 interrupt=1)
Define(death_buff 227151)
	SpellInfo(death_buff duration=10)
Define(death_from_above 152150)
	SpellInfo(death_from_above combo=finisher energy=50)
	SpellAddBuff(death_from_above envenom_buff=1 specialization=assassination)
	SpellAddBuff(death_from_above enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
	SpellAddBuff(death_from_above surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(death_from_above_buff 152150)
Define(death_from_above_talent 21)
Define(deathly_shadows_buff 188700)
	SpellInfo(deathly_shadows_buff duration=10)
Define(deceit_buff 166878)
	SpellInfo(deceit_buff duration=10)
Define(deep_insight_buff 84747)
	SpellInfo(deep_insight_buff duration=15)
Define(deeper_stratagem_talent 7)
Define(dispatch 111240)
	SpellInfo(dispatch combo=1 energy=30 target_health_pct=35)
	SpellInfo(dispatch combo=3 itemset=T18 itemcount=4 specialization=assassination)
	SpellInfo(dispatch buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2)
	SpellRequire(dispatch energy 0=buff,blindside_buff if_spell=blindside)
	SpellRequire(dispatch target_health_pct 100=buff,blindside_buff if_spell=blindside)
	SpellAddBuff(dispatch silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddBuff(dispatch enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
Define(elaborate_planning_buff 193640)
	SpellInfo(elaborate_planning_buff duration=5)
Define(enhanced_shadow_dance 157669)
Define(enhanced_vanish 157666)
Define(enhanced_vendetta 158108)
Define(enhanced_vendetta_buff 158108)
	SpellInfo(enhanced_vendetta_buff duration=15)
Define(enveloping_shadows 206237)
	SpellInfo(enveloping_shadows combo=finisher energy=30)
	SpellAddBuff(enveloping_shadows enveloping_shadows_buff=1)
Define(enveloping_shadows_buff 206237)
	SpellInfo(enveloping_shadows_buff duration=6 tick=3 adddurationcp=6)
Define(envenom 32645)
	SpellInfo(envenom combo=finisher energy=35)
	SpellAddBuff(envenom envenom_buff=1)
	SpellAddBuff(envenom slice_and_dice=refresh if_spell=!improved_slice_and_dice)
	SpellAddBuff(envenom enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
	SpellAddBuff(envenom surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(envenom_buff 32645)
	SpellInfo(envenom_buff duration=1 adddurationcp=1 tick=1)
Define(eviscerate 196819)
	SpellInfo(eviscerate combo=finisher energy=35)
Define(exsanguinate 200806)
	SpellInfo(exsanguinate cd=45 tag=main)
	SpellAddTargetDebuff(exsanguinate rupture_debuff_exsanguinated=1 if_target_debuff=rupture_debuff) #TODO if_target_debuff is not implemented here
	SpellAddTargetDebuff(exsanguinate garrote_debuff_exsanguinated=1 if_target_debuff=garrote_debuff)
Define(exsanguinate_talent 18)
SpellList(exsanguinated rupture_debuff_exsanguinated garrote_debuff_exsanguinated)
Define(fan_of_knives 51723)
	SpellInfo(fan_of_knives combo=1 energy=35)
	SpellInfo(fan_of_knives buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellInfo(fan_of_knives buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2 specialization=subtlety)
	SpellAddBuff(fan_of_knives silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(faster_than_light_trigger_buff 197270)
Define(feeding_frenzy_buff 242705)
Define(finality 197406)
Define(finality_nightblade 197395)
	SpellInfo(finality_nightblade combo=finisher energy=25)
	SpellAddTargetDebuff(finality_nightblade finality_nightblade_debuff=1)
Define(finality_nightblade_debuff 197395)
	SpellInfo(finality_nightblade_debuff duration=6)
Define(find_weakness 91023)
Define(find_weakness_debuff 91021)
	SpellInfo(find_weakness_debuff duration=10)
Define(garrote 703)
	SpellInfo(garrote cd=15 combo=1 energy=45)
	SpellInfo(garrote addcd=-12 addenergy=-20 itemset=T20 itemcount=4)
	SpellAddTargetDebuff(garrote find_weakness_debuff=1 if_spell=find_weakness)
	SpellAddTargetDebuff(garrote garrote_debuff=1)
Define(garrote_debuff 703)
	SpellInfo(garrote_debuff duration=18 tick=2)
Define(garrote_debuff_exsanguinated -703) #TODO negative number for hidden auras?
	SpellInfo(garrote_debuff_exsanguinated duration=garrote_debuff) #TODO use an aura as a duration to mirror the duration
Define(ghostly_strike 196937)
	SpellInfo(ghostly_strike combo=1 energy=30)
	SpellAddTargetDebuff(ghostly_strike ghostly_strike_debuff=1)
Define(ghostly_strike_debuff 196937)
	SpellInfo(ghostly_strike_debuff duration=15)
Define(ghostly_strike_talent 1)
Define(gloomblade 200758)
	SpellInfo(gloomblade combo=1 energy=35)
Define(goremaws_bite 209782)
	SpellInfo(goremaws_bite cd=60 combo=3)
Define(gouge 1776)
	SpellInfo(gouge combo=1 cd=10 energy=25 tag=main)
	SpellInfo(gouge combo=1 cd=10 energy=0 talent=dirty_tricks_talent)
Define(hemorrhage 16511)
	SpellInfo(hemorrhage combo=1 energy=30)
	SpellInfo(hemorrhage buff_energy=silent_blades_buff buff_energy_amount=-2 itemset=T16_melee itemcount=2)
	SpellAddBuff(hemorrhage silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddTargetDebuff(hemorrhage hemorrhage_debuff=1)
Define(hemorrhage_debuff 16511)
	SpellInfo(hemorrhage_debuff duration=24 tick=3)
Define(hemorrhage_talent 3)
Define(hidden_blade_buff 202754)
Define(honor_among_thieves_cooldown_buff 51699)
Define(improved_slice_and_dice 157513)
Define(instant_poison 157584)
	SpellAddBuff(instant_poison instant_poison_buff=1)
Define(instant_poison_buff 157584)
	SpellInfo(instant_poison_buff duration=3600)
Define(internal_bleeding 154904)
Define(internal_bleeding_talent 15)
Define(internal_bleeding_debuff 154953)
	SpellInfo(internal_bleeding_debuff duration=12 tick=2)
Define(kick 1766)
	SpellInfo(kick cd=15 gcd=0 interrupt=1 offgcd=1)
Define(kidney_shot 408)
	SpellInfo(kidney_shot cd=20 combo=finisher energy=25 interrupt=1)
	SpellAddTargetDebuff(kidney_shot internal_bleeding_debuff=1 if_spell=internal_bleeding)
	SpellAddBuff(kidney_shot surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(killing_spree 51690)
	SpellInfo(killing_spree cd=120)
	SpellInfo(killing_spree buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(killing_spree killing_spree_buff=1)
Define(killing_spree_buff 51690)
	SpellInfo(killing_spree_buff duration=3)
Define(kingsbane 192759)
	SpellAddTargetDebuff(kingsbane kingsbane_debuff=1)
Define(kingsbane_debuff 192759)
	SpellInfo(kingsbane_debuff duration=14)
Define(leeching_poison 108211)
	SpellAddBuff(leeching_poison leeching_poison_buff=1)
Define(leeching_poison_buff 108211)
	SpellInfo(leeching_poison_buff duration=3600)
SpellList(lethal_poison_buff deadly_poison_buff instant_poison_buff wound_poison_buff)
Define(marked_for_death 137619)
	SpellInfo(marked_for_death cd=60 combo=5 gcd=0 offgcd=1 temp_combo=1)
Define(marked_for_death_talent 20)
Define(master_assassin 192349)
Define(master_of_shadows_talent 19)
Define(master_of_subtlety_buff 31665)
Define(mutilate 1329)
	SpellInfo(mutilate combo=2 energy=55)
	SpellInfo(mutilate buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2)
	SpellAddBuff(mutilate silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddBuff(mutilate enhanced_vendetta_buff=0 if_spell=enhanced_vendetta)
Define(mutilated_flesh_debuff 211672)
Define(nightblade 195452)
	SpellInfo(nightblade energy=25 combo=finisher)
	SpellAddTargetDebuff(nightblade nightblade_debuff=1)
Define(nightblade_debuff 195452)
	SpellInfo(nightblade_debuff duration=6)
Define(nightstalker_talent 4)
SpellList(non_lethal_poison_buff crippling_poison_buff leeching_poison_buff)
Define(opportunity_buff 195627)
	SpellInfo(opportunity_buff duration=10)
Define(pistol_shot 185763)
	SpellInfo(pistol_shot combo=1 energy=40)
	SpellAddBuff(pistol_shot opportunity_buff=-1)
	SpellAddBuff(pistol_shot pistol_shot_buff=1)
Define(pistol_shot_buff 185763)
	SpellInfo(pistol_shot_buff duration=6)
Define(premeditation 14183)
	SpellInfo(premeditation cd=20 combo=2 gcd=0 offgcd=1 temp_combo=1)
	SpellRequire(premeditation unusable 1=!stealthed)
Define(premeditation_talent 16)
Define(quick_draw_talent 3)
Define(revealing_strike 84617)
	SpellInfo(revealing_strike combo=1 energy=40)
	SpellInfo(revealing_strike buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2)
	SpellAddBuff(revealing_strike silent_blades_buff=0 itemset=T16_melee itemcount=2)
	SpellAddTargetDebuff(revealing_strike revealing_strike_debuff=1)
Define(revealing_strike_debuff 84617)
	SpellInfo(revealing_strike_debuff duration=24 tick=3)
Define(roll_the_bones 193316)
	SpellInfo(roll_the_bones energy=25 combo=finisher)

	Define(grand_melee_buff 193358)
		SpellInfo(grand_melee_buff duration=12 adddurationcp=6)
	Define(jolly_roger_buff 199603)
		SpellInfo(grand_melee_buff duration=12 adddurationcp=6)
	Define(true_bearing_buff 193359)
		SpellInfo(true_bearing_buff duration=12 adddurationcp=6)
	Define(buried_treasure_buff 199600)
		SpellInfo(buried_treasure_buff duration=12 adddurationcp=6)
	Define(broadside_buff 193356)
		SpellInfo(broadside_buff duration=12 adddurationcp=6)
	SpellList(roll_the_bones_buff grand_melee_buff broadside_buff jolly_roger_buff shark_infested_waters_buff true_bearing_buff buried_treasure_buff)

Define(run_through 2098)
	SpellInfo(run_through energy=35 combo=finisher)
Define(rupture 1943)
	SpellInfo(rupture combo=finisher energy=25)
	SpellAddTargetDebuff(rupture rupture_debuff=1)
	SpellAddBuff(rupture surge_of_toxins_debuff=1 trait=surge_of_toxins)
Define(rupture_debuff 1943)
	SpellInfo(rupture_debuff adddurationcp=4 duration=4 tick=2)
Define(rupture_debuff_exsanguinated -1943)
	SpellInfo(rupture_debuff_exsanguinated duration=rupture_debuff)
Define(saber_slash 193315)
	SpellInfo(saber_slash combo=1 energy=50)
Define(shadow_blades 121471)
	SpellInfo(shadow_blades cd=180)
	SpellAddBuff(shadow_blades shadow_blades_buff=1)
Define(shadow_blades_buff 121471)
	SpellInfo(shadow_blades_buff duration=15)
Define(shadow_dance 185313)
	SpellInfo(shadow_dance cd=60 gcd=0)
	SpellInfo(shadow_dance energy=-60 itemset=T17 itemcount=2 specialization=subtlety)
	SpellInfo(shadow_dance buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(shadow_dance shadow_dance_buff=1)
Define(shadow_dance_buff 185422)
Define(shadow_focus 108209)
Define(shadow_focus_talent 6)
	SpellRequire(ambush energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(backstab energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(cheap_shot energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(crimson_tempest energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(deadly_throw energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(death_from_above energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(dispatch energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(eviscerate energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(fan_of_knives energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(hemorrhage energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(kidney_shot energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(mutilate energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(revealing_strike energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(rupture energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(shiv energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(shuriken_toss energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(sinister_strike energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
	SpellRequire(slice_and_dice energy_percent 50=buff,stealthed_buff talent=shadow_focus_talent)
Define(shadow_reflection 152151)
	SpellInfo(shadow_reflection cd=120 gcd=0)
	SpellAddBuff(shadow_reflection shadow_reflection_buff=1)
	SpellAddTargetDebuff(shadow_reflection shadow_reflection_debuff=1)
Define(shadow_reflection_buff 152151)
	SpellInfo(shadow_reflection_buff duration=16)
Define(shadow_reflection_debuff 156745)
	SpellInfo(shadow_reflection_debuff duration=16)
Define(shadowstep 36554)
	SpellInfo(shadowstep cd=20 gcd=0 offgcd=1)
Define(shadowstrike 185438)
	SpellInfo(shadowstrike combo=1 energy=40 stealthed=1)
	SpellAddBuff(shadowstrike death_buff=-1)
Define(shark_infested_waters_buff 193357)
Define(shiv 5938)
	SpellInfo(shiv cd=10 energy=20)
Define(shuriken_storm 197835)
	SpellInfo(shuriken_storm energy=35 combo=1)
Define(shuriken_toss 114014)
	SpellInfo(shuriken_toss combo=1 energy=40 travel_time=1)
	SpellInfo(shuriken_toss buff_energy=silent_blades_buff buff_energy_amount=-6 itemset=T16_melee itemcount=2 specialization=assassination)
	SpellAddBuff(shuriken_toss silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(silent_blades_buff 145193)
	SpellInfo(silent_blades_buff duration=30 stacking=1)
Define(sinister_circulation 238138)
Define(sinister_strike 1752)
	SpellInfo(sinister_strike combo=1 energy=50)
	SpellInfo(sinister_strike buff_energy=silent_blades_buff buff_energy_amount=-15 itemset=T16_melee itemcount=2 specialization=combat)
	SpellAddBuff(sinister_strike bandits_guile_buff=1 if_spell=bandits_guile)
	SpellAddBuff(sinister_strike silent_blades_buff=0 itemset=T16_melee itemcount=2)
Define(sleight_of_hand_buff 145211)
	SpellInfo(sleight_of_hand_buff duration=10)
Define(slice_and_dice 5171)
	SpellInfo(slice_and_dice combo=finisher energy=25)
	SpellInfo(slice_and_dice unusable=1 if_spell=improved_slice_and_dice)
	SpellAddBuff(slice_and_dice slice_and_dice_buff=1)
Define(slice_and_dice_buff 5171)
	SpellInfo(slice_and_dice adddurationcp=6 duration=6 tick=3)
	SpellInfo(roll_the_bones unusable=1 talent=slice_and_dice_talent)
Define(slice_and_dice_talent 19)
Define(sprint 2983)
	SpellInfo(sprint cd=60)
	SpellAddBuff(sprint sprint_buff=1)
Define(sprint_buff 2983)
	SpellInfo(sprint_buff duration=8)
Define(stealth 1784)
	SpellInfo(stealth cd=6 to_stance=rogue_stealth)
	SpellRequire(stealth unusable 1=stealthed,1)
	SpellAddBuff(stealth stealth=1)
Define(subterfuge 108208)
Define(subterfuge_buff 115192)
	SpellInfo(subterfuge_buff duration=3)
Define(subterfuge_talent 5)
Define(surge_of_toxins 192424)
Define(surge_of_toxins_debuff 192425)
	SpellInfo(surge_of_toxins_debuff duration=5)
Define(symbols_of_death 212283)
	SpellInfo(symbols_of_death cd=10 energy=35 stealthed=1 tag=shortcd)
	SpellAddBuff(symbols_of_death symbols_of_death_buff=1)
	SpellAddBuff(symbols_of_death death_buff=1)
Define(symbols_of_death_buff 212283)
	SpellInfo(symbols_of_death_buff duration=35)
Define(swift_poison 157605)
Define(the_first_of_the_dead_buff 248210)
Define(t18_class_trinket 124520)
Define(toxic_blade 245388)
	SpellInfo(toxic_blade combo=1 tag=main)
	SpellAddTargetDebuff(toxic_blade toxic_blade_debuff=1)
Define(toxic_blade_debuff 245389)
	SpellInfo(toxic_blade_debuff duration=9)
Define(urge_to_kill 192384)
Define(vanish 1856)
	SpellInfo(vanish cd=120 gcd=0)
	SpellInfo(vanish addcd=-30 if_spell=enhanced_vanish)
	SpellInfo(vanish buff_cdr=cooldown_reduction_agility_buff specialization=assassination)
	SpellInfo(vanish buff_cdr=cooldown_reduction_agility_buff specialization=subtlety)
	SpellInfo(vanish combo=5 itemset=T18 itemcount=2 specialization=subtlety)
	SpellAddBuff(vanish vanish_aura=1 if_spell=!subterfuge)
	SpellAddBuff(vanish vanish_subterfuge_buff=1 if_spell=subterfuge)
	SpellAddBuff(vanish deathly_shadows_buff=1 itemset=T18 itemcount=2 specialization=subtlety)
	SpellRequire(vanish unusable 1=stealthed,1)
Define(vanish_aura 11327)
	SpellInfo(vanish_aura duration=3)
Define(vanish_buff 1856)
Define(vanish_subterfuge_buff 115193)
	SpellInfo(vanish_subterfuge_buff duration=3)
SpellList(vanish_buff vanish_aura vanish_subterfuge_buff)
Define(vendetta 79140)
	SpellInfo(vendetta cd=120)
	SpellInfo(vendetta buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(vendetta enhanced_vendetta_buff=1 if_spell=enhanced_vendetta)
	SpellAddTargetDebuff(vendetta vendetta_debuff=1)
Define(vendetta_debuff 79140)
	SpellInfo(vendetta_debuff duration=20)
Define(wound_poison 8679)
	SpellAddBuff(wound_poison wound_poison_buff=1)
Define(wound_poison_buff 8679)
	SpellInfo(wound_poison_buff duration=3600)

# Talents
Define(dark_shadow_talent 16)
Define(deeper_strategem_talent 7)
Define(dirty_tricks_talent 15)
Define(elaborate_planning_talent 2)
Define(enveloping_shadows_talent 18)
Define(master_poisoner_talent 1)
Define(venom_rush_talent 19)
Define(vigor_talent 9)

# Non-default tags for OvaleSimulationCraft.
	SpellInfo(premeditation tag=main)
	SpellInfo(vanish tag=shortcd)
]]
    __Scripts.OvaleScripts:RegisterScript("ROGUE", nil, name, desc, code, "include")
end
end)
