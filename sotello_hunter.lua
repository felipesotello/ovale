Include(ovale_common)
Include(ovale_hunter_spells)

Define(dire_beast_buff 120694)
Define(mend_pet 136)
Define(titans_thunder 207068)

Define(pet_beast_cleave_buff 118455)
Define(pet_mend_pet_buff 136)
Define(pet_titans_thunder_buff 218638)

SpellAddBuff(mend_pet pet_mend_pet_buff=1)
SpellAddBuff(titans_thunder pet_titans_thunder_buff=1)



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
    if BuffPresent(dire_beast_buff) Spell(titans_thunder)
    Spell(a_murder_of_crows)
    if BuffPresent(bestial_wrath_buff) Spell(dire_beast)
    Spell(kill_command)
    Spell(dire_beast)
    if BuffPresent(bestial_wrath_buff) Spell(cobra_shot)
    if Focus() > 90 Spell(cobra_shot)
    Spell(mend_pet)
}

AddFunction BeastMasteryAoE {
    if pet.BuffRemaining(pet_beast_cleave_buff less 1) Spell(multishot)
}

AddFunction BeastMasteryCooldowns {
    Spell(bestial_wrath)
    Spell(aspect_of_the_wild)
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