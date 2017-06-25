Include(ovale_common)
Include(ovale_hunter_spells)

Define(mend_pet 136)
	SpellAddBuff(mend_pet pet_mend_pet_buff=1)
Define(pet_mend_pet_buff 136)
Define(titans_thunder 207068)
	SpellAddBuff(titans_thunder pet_titans_thunder_buff=1)
Define(pet_titans_thunder_buff 218638)

AddFunction Pet {
	if not pet.Present() Texture(ability_hunter_beastcall)
	if pet.IsDead() Spell(revive_pet)
}

AddFunction MendPet {
	if pet.BuffRemaining(pet_mend_pet_buff less 5) Spell(mend_pet)
}

AddFunction Interrupt {
	if not target.IsFriend() and target.IsInterruptible() Spell(counter_shot)
}

AddFunction KillCommand {
	if pet.Present() and pet.IsFeared(no) and pet.IsIncapacitated(no) and pet.IsStunned(no) Spell(kill_command)
}

AddFunction BeastMasteryOpener {
	Spell(a_murder_of_crows)
	if SpellCooldown(kill_command) < 3 Spell(bestial_wrath)
	if BuffPresent(bestial_wrath_buff) {
		if not pet.BuffPresent(pet_dire_frenzy_buff) Spell(dire_frenzy)
		Spell(kill_command)
		Spell(titans_thunder)
		Spell(dire_frenzy)
		Spell(aspect_of_the_wild)
		Spell(cobra_shot)
	}
}

AddFunction BeastMasterySingle {
	Spell(titans_thunder)
	if pet.BuffPresent(pet_titans_thunder_buff) Spell(dire_frenzy)
	if pet.BuffRemaining(pet_dire_frenzy_buff) < 5 Spell(dire_frenzy)
	Spell(kill_command)
	if Focus() > 90 Spell(cobra_shot)
}

AddFunction BeastMasteryAoE {
}

AddCheckBox(opt_normal L("Normal") default specialization=beast_mastery)
AddCheckBox(opt_aoe L("AoE") default specialization=beast_mastery)

AddIcon specialization=beast_mastery {
	Pet()
	BeastMasteryOpener()
	BeastMasterySingle()
}

AddIcon specialization=beast_mastery checkbox=opt_normal {
	Pet()
	BeastMasterySingle()
}

AddIcon specialization=beast_mastery checkbox=opt_aoe {
    Pet()
	BeastMasteryAoE()
}

AddIcon specialization=beast_mastery size=small {
	Interrupt()
	MendPet()
}