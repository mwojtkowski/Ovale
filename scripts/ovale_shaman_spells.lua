local OVALE, Ovale = ...
local OvaleScripts = Ovale.OvaleScripts

do
	local name = "ovale_shaman_spells"
	local desc = "[6.0.2] Ovale: Shaman spells"
	local code = [[
# Shaman spells and functions.

# Learned spells.
Define(flurry 16282)
	SpellInfo(flurry learn=1 level=20 specialization=enhancement)
Define(maelstrom_weapon 51530)
	SpellInfo(maelstrom_weapon learn=1 level=50 specialization=enhancement)
Define(shamanism 62099)
	SpellInfo(shamanism learn=1 level=10 specialization=elemental)
Define(spiritual_insight 123099)
	SpellInfo(spiritual_insight learn=1 level=10 specialization=elemental)
Define(tidal_waves 51564)
	SpellInfo(tidal_waves learn=1 level=50 specialization=restoration)

Define(ancestral_swiftness 16188)
	SpellInfo(ancestral_swiftness cd=90 gcd=0)
	SpellAddBuff(ancestral_swiftness ancestral_swiftness_buff=1)
Define(ancestral_swiftness_buff 16188)
Define(ascendance_caster 165339)
	SpellInfo(ascendance_caster cd=180 gcd=0)
	SpellAddBuff(ascendance_caster ascendance_caster_buff=1)
Define(ascendance_caster_buff 114050)
	SpellInfo(ascendance_caster_buff duration=15)
Define(ascendance_heal 165344)
	SpellInfo(ascendance_heal cd=180 gcd=0)
	SpellAddBuff(ascendance_heal ascendance_heal_buff=1)
Define(ascendance_heal_buff 114052)
	SpellInfo(ascendance_heal_buff duration=15)
Define(ascendance_melee 165341)
	SpellInfo(ascendance_melee cd=180 gcd=0)
	SpellInfo(ascendance_melee buff_cdr=cooldown_reduction_agility_buff)
	SpellAddBuff(ascendance_melee ascendance_melee_buff=1)
Define(ascendance_melee_buff 114051)
	SpellInfo(ascendance_melee_buff duration=15)
Define(bloodlust 2825)
	SpellInfo(bloodlust cd=300 gcd=0)
	SpellAddBuff(bloodlust bloodlust_buff=1)
Define(bloodlust_buff 2825)
	SpellInfo(bloodlust_buff duration=40)
Define(chain_heal 1064)
	SpellInfo(chain_heal cd=3 glyph=glyph_of_chaining)
	SpellAddBuff(chain_heal ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(chain_heal maelstrom_weapon_buff=0 if_spell=maelstrom_weapon)
	SpellAddBuff(chain_heal tidal_waves_buff=2 if_spell=tidal_waves)
Define(chain_lightning 421)
	SpellInfo(chain_lightning cd=3)
	SpellInfo(chain_lightning cd=0 if_spell=shamanism)
	SpellAddBuff(chain_lightning ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(chain_lightning maelstrom_weapon_buff=0 if_spell=maelstrom_weapon)
	SpellAddBuff(chain_lightning enhanced_chain_lightning_buff=1 if_spell=enhanced_chain_lightning)
Define(earth_shield 974)
	SpellAddTargetBuff(earth_shield earth_shield_buff=1)
Define(earth_shield_buff 974)
	SpellInfo(earth_shield_buff duration=600 max_stacks=9)
Define(earth_shock 8042)
	SpellInfo(earth_shock cd=6 sharedcd=shock)
	SpellInfo(earth_shock addcd=-1 if_spell=spiritual_insight)
	SpellAddBuff(earth_shock elemental_fusion_buff=0 if_spell=elemental_fusion)
Define(earthquake 61882)
	SpellInfo(earthquake cd=10)
	SpellInfo(earthquake buff_no_cd=echo_of_the_elements_buff if_spell=echo_of_the_elements)
	SpellAddBuff(earthquake ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(earthquake echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
	SpellAddTargetDebuff(earthquake earthquake_debuff=1)
Define(earthquake_debuff 77478)
	SpellInfo(earthquake_debuff duration=10 haste=spell tick=1)
Define(echo_of_the_elements 108283)
Define(echo_of_the_elements_buff 159101)
	SpellInfo(echo_of_the_elements_buff duration=15)
Define(elemental_blast 117014)
	SpellInfo(elemental_blast cd=12)
	SpellAddBuff(elemental_blast ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(elemental_blast maelstrom_weapon_buff=0 if_spell=maelstrom_weapon)
	SpellAddBuff(elemental_blast unleash_flame_buff=0 if_spell=unleash_flame)
Define(elemental_blast_talent 18)
Define(elemental_fusion 152257)
Define(elemental_fusion_buff 157174)
	SpellInfo(elemental_fusion_buff duration=15 max_stacks=2)
Define(elemental_fusion_talent 19)
Define(elemental_mastery 16166)
	SpellInfo(elemental_mastery cd=120 gcd=0)
	SpellAddBuff(elemental_mastery elemental_mastery_buff=1)
Define(elemental_mastery_buff 16166)
	SpellInfo(elemental_mastery_buff duration=20)
Define(enhanced_chain_lightning 157765)
Define(enhanced_chain_lightning_buff 157766)
	SpellInfo(enhanced_chain_lightning_buff duration=15) # max_stacks=?
Define(feral_spirit 51533)
	SpellInfo(feral_spirit cd=120)
	SpellInfo(feral_spirit addcd=60 glyph=glyph_of_ephemeral_spirits)
	SpellInfo(feral_spirit buff_cdr=cooldown_reduction_agility_buff)
Define(fire_elemental_totem 2894)
	SpellInfo(fire_elemental_totem cd=300)
	SpellInfo(fire_elemental_totem cd=150 glyph=glyph_of_fire_elemental_totem)
	SpellInfo(fire_elemental_totem buff_cdr=cooldown_reduction_agility_buff specialization=enhancement)
Define(fire_nova 1535)
	SpellInfo(fire_nova cd=4)
	SpellInfo(fire_nova cd_haste=melee if_spell=flurry)
	SpellInfo(fire_nova buff_no_cd=echo_of_the_elements_buff if_spell=echo_of_the_elements)
	SpellAddBuff(fire_nova echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
Define(flame_shock 8050)
	SpellInfo(flame_shock cd=6 sharedcd=shock)
	SpellInfo(flame_shock addcd=-1 if_spell=spiritual_insight)
	SpellInfo(flame_shock cd_haste=melee if_spell=flurry)
	SpellAddBuff(flame_shock elemental_fusion_buff=0 if_spell=elemental_fusion)
	SpellAddBuff(flame_shock unleash_flame_buff=0 if_spell=unleash_flame)
	SpellAddTargetDebuff(flame_shock flame_shock_debuff=1)
Define(flame_shock_debuff 8050)
	SpellInfo(flame_shock_debuff duration=30 haste=spell tick=3)
Define(frost_shock 8050)
	SpellInfo(frost_shock cd=6 sharedcd=shock)
	SpellInfo(frost_shock addcd=-2 glyph=glyph_of_frost_shock)
	SpellInfo(frost_shock cd_haste=melee if_spell=flurry)
	SpellInfo(frost_shock buff_no_cd=echo_of_the_elements_buff if_spell=echo_of_the_elements)
	SpellAddBuff(frost_shock echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
	SpellAddBuff(frost_shock elemental_fusion_buff=0 if_spell=elemental_fusion)
Define(glyph_of_chain_lightning 55449)
Define(glyph_of_chaining 55452)
Define(glyph_of_ephemeral_spirits 159640)
Define(glyph_of_fire_elemental_totem 55455)
Define(glyph_of_frost_shock 55443)
Define(glyph_of_riptide 63273)
Define(glyph_of_spirit_walk 55454)
Define(glyph_of_spiritual_focus 159650)
Define(glyph_of_thunder 63270)
Define(glyph_of_wind_shear 55451)
Define(healing_rain 73920)
	SpellInfo(healing_rain cd=10)
	SpellAddBuff(healing_rain ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(healing_rain maelstrom_weapon_buff=0 if_spell=maelstrom_weapon)
Define(healing_stream_totem 5394)
	SpellInfo(healing_stream_totem cd=30)
Define(healing_surge 8004)
	SpellAddBuff(healing_surge ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(healing_surge tidal_waves_buff=-1 if_spell=tidal_waves)
Define(healing_tide_totem 108280)
	SpellInfo(healing_tide_totem cd=180)
Define(healing_wave 77472)
	SpellAddBuff(healing_wave ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(healing_wave tidal_waves_buff=-1 if_spell=tidal_waves)
Define(heroism 32182)
	SpellInfo(heroism cd=300 gcd=0)
	SpellAddBuff(heroism heroism_buff=1)
Define(heroism_buff 32182)
	SpellInfo(heroism_buff duration=40)
Define(improved_flame_shock 157804)
Define(improved_lightning_shield 157774)
Define(improved_riptide 157812)
Define(lava_beam 114074)
	SpellAddBuff(lava_beam unleash_flame_buff=0 if_spell=unleash_flame)
Define(lava_burst 51505)
	SpellInfo(lava_burst cd=8)
	SpellInfo(lava_burst buff_no_cd=lava_burst_no_cd_buff)
	SpellAddBuff(lava_burst lava_surge_buff=0)
	SpellAddBuff(lava_burst echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
	SpellAddBuff(lava_burst unleash_flame_buff=0 if_spell=unleash_flame)
SpellList(lava_burst_no_cd_buff ascendance_caster_buff echo_of_the_elements_buff)
Define(lava_lash 60103)
	SpellInfo(lava_lash cd=10.5)
	SpellInfo(lava_lash cd_haste=melee if_spell=flurry)
	SpellInfo(lava_lash buff_no_cd=echo_of_the_elements_buff if_spell=echo_of_the_elements)
	SpellAddBuff(lava_lash echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
Define(lava_surge_buff 77762)
	SpellInfo(lava_surge_buff duration=6)
Define(lightning_bolt 403)
	SpellAddBuff(lightning_bolt ancestral_swiftness_buff=0 if_spell=ancestral_swiftness)
	SpellAddBuff(lightning_bolt maelstrom_weapon_buff=0 if_spell=maelstrom_weapon)
Define(lightning_shield 324)
	SpellAddBuff(lightning_shield lightning_shield_buff=1)
Define(lightning_shield_buff 324)
	SpellInfo(lightning_shield_buff duration=3600 max_stacks=15)
	SpellInfo(lightning_shield_buff max_stacks=20 if_spell=improved_lightning_shield)
Define(liquid_magma 152255)
	SpellInfo(liquid_magma cd=45)
	SpellAddBuff(liquid_magma liquid_magma_buff=1)
Define(liquid_magma_buff 152255)
Define(liquid_magma_talent 21)
Define(maelstrom_weapon_buff 53817)
	SpellInfo(maelstrom_weapon_buff duration=30 max_stacks=5)
Define(magma_totem 8190)
Define(primal_strike 73899)
	SpellInfo(primal_strike cd=8)
Define(riptide 61295)
	SpellInfo(riptide cd=6)
	SpellInfo(riptide addcd=-1 if_spell=improved_riptide)
	SpellInfo(riptide cd=0 glyph=glyph_of_riptide)
	SpellAddBuff(riptide tidal_waves_buff=2 if_spell=tidal_waves)
	SpellAddTargetBuff(riptide riptide_buff=1)
Define(riptide_buff 61295)
	SpellInfo(riptide_buff duration=18 haste=spell tick=3)
Define(searing_totem 3599)
Define(spirit_link_totem 98008)
	SpellInfo(spirit_link_totem cd=180)
Define(spirit_walk 58875)
	SpellInfo(spirit_walk cd=60)
	SpellInfo(spirit_walk addcd=-15 glyph=glyph_of_spirit_walk)
Define(spiritwalkers_grace 79206)
	SpellInfo(spiritwalkers_grace cd=120 gcd=0)
	SpellInfo(spiritwalkers_grace addcd=-60 glyph=glyph_of_spiritual_focus)
	SpellInfo(spiritwalkers_grace buff_cdr=cooldown_reduction_agility_buff specialization=enhancement)
Define(storm_elemental_totem 152256)
	SpellInfo(storm_elemental_totem cd=300)
Define(storm_elemental_totem_talent 20)
Define(stormstrike 17364)
	SpellInfo(stormstrike cd=7.5)
	SpellInfo(stormstrike cd_haste=melee if_spell=flurry)
	SpellInfo(stormstrike buff_no_cd=echo_of_the_elements_buff if_spell=echo_of_the_elements)
	SpellAddBuff(stormstrike echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
Define(thunderstorm 51490)
	SpellInfo(thunderstorm cd=45)
	SpellInfo(thunderstorm addcd=-10 glyph=glyph_of_thunder)
Define(tidal_waves_buff 53390)
	SpellInfo(tidal_waves_buff duration=15 max_stacks=2)
Define(totemic_recall 36936)
Define(tremor_totem 8143)
	SpellInfo(tremor_totem cd=60)
Define(unleash_elements 73680)
	SpellInfo(unleash_elements cd=15)
	SpellInfo(unleash_elements cd_haste=melee if_spell=flurry)
	SpellAddBuff(unleash_elements unleash_flame_buff=1)
Define(unleash_flame 165462)
	SpellInfo(unleash_flame cd=15)
	SpellAddBuff(unleash_flame unleash_flame_buff=1)
Define(unleash_flame_buff 165462)
	SpellInfo(unleash_flame_buff duration=20)
Define(unleashed_fury_talent 16)
Define(water_shield 52127)
	SpellAddBuff(water_shield water_shield_buff=1)
Define(water_shield_buff 52127)
	SpellInfo(water_shield duration=3600)
Define(wind_shear 57994)
	SpellInfo(wind_shear cd=12 gcd=0 interrupt=1)
	SpellInfo(wind_shear addcd=3 glyph=glyph_of_wind_shear)
Define(windstrike 115356)
	SpellInfo(windstrike cd=7.5)
	SpellInfo(windstrike cd_haste=melee if_spell=flurry)
	SpellInfo(windstrike buff_no_cd=echo_of_the_elements_buff if_spell=echo_of_the_elements)
	SpellAddBuff(windstrike echo_of_the_elements_buff=0 if_spell=echo_of_the_elements)
Define(windwalk_totem 108273)
	SpellInfo(windwalk_totem cd=60)

# Pet spells (Primal Elementalist Talent)
Define(pet_empower 118350)
	SpellInfo(pet_empower gcd=0)
	SpellAddBuff(pet_empower pet_empower_buff=1)
Define(pet_empower_buff 118350)
	SpellInfo(pet_empower_buff duration=60)
Define(pet_reinforce 118347)
	SpellInfo(pet_reinforce gcd=0)
	SpellAddBuff(pet_reinforce pet_reinforce_buff=1)
Define(pet_reinforce_buff 118347)
	SpellInfo(pet_reinforce_buff duration=60)
]]

	OvaleScripts:RegisterScript("SHAMAN", name, desc, code, "include")
end
