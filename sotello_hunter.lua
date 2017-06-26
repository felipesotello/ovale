Include(ovale_common)
Include(ovale_hunter_spells)

Define(pet_beast_cleave_buff 118455)

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

AddFunction BeastMasterySingle {
	Spell(a_murder_of_crows)
	Spell(dire_beast)
	Spell(kill_command)
	Spell(cobra_shot)
}

AddFunction BeastMasteryAoE {
    if pet.BuffRemaining(pet_beast_cleave_buff less 1) Spell(multishot)
}

AddFunction BeastMasteryCooldowns {
    Spell(titans_thunder)
    Spell(aspect_of_the_wild)
    Spell(bestial_wrath)
}

AddCheckBox(opt_cds L("CDs") default specialization=beast_mastery)
AddCheckBox(opt_aoe L("AoE") default specialization=beast_mastery)

AddIcon specialization=beast_mastery {
	Pet()
	BeastMasterySingle()
}

AddIcon specialization=beast_mastery checkbox=opt_cds {
	BeastMasteryCooldowns()
}

AddIcon specialization=beast_mastery checkbox=opt_aoe {
	BeastMasteryAoE()
}

AddIcon specialization=beast_mastery size=small {
	Interrupt()
	MendPet()
}