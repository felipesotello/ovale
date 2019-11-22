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

AddFunction BeastMasteryMain {
    if pet.BuffRemaining(pet_frenzy_buff) < 2 Spell(barbed_shot)
    Spell(bestial_wrath)
    Spell(aspect_of_the_wild)
    Spell(kill_command)
    if Charges(barbed_shot count=0) > 1.5 Spell(barbed_shot)
    Spell(cobra_shot)
    Spell(barbed_shot)
    Spell(mend_pet)
}

AddFunction BeastMasterySingle {
    if pet.BuffRemaining(pet_frenzy_buff) < 2 Spell(barbed_shot)
    Spell(kill_command)
    if Charges(barbed_shot count=0) > 1.5 Spell(barbed_shot)
    Spell(cobra_shot)
    Spell(barbed_shot)
    Spell(mend_pet)
}

AddFunction BeastMasteryCooldowns {
    Spell(bestial_wrath)
    Spell(aspect_of_the_wild)
}

AddFunction BeastMasteryMultiple {
    if pet.BuffRemaining(pet_beast_cleave_buff less 1) Texture(ability_upgrademoonglaive)
}

AddCheckBox(opt_main L("Main") default specialization=beast_mastery)
AddCheckBox(opt_single L("Single") default specialization=beast_mastery)
AddCheckBox(opt_cooldowns L("Cooldowns") default specialization=beast_mastery)
AddCheckBox(opt_multiple L("Multiple") default specialization=beast_mastery)

AddIcon specialization=beast_mastery checkbox=opt_main {
    Pet()
    BeastMasteryMain()
}

AddIcon specialization=beast_mastery checkbox=opt_single {
    Pet()
    BeastMasterySingle()
}

AddIcon specialization=beast_mastery checkbox=opt_cooldowns {
    BeastMasteryCooldowns()
}

AddIcon specialization=beast_mastery checkbox=opt_multiple {
    BeastMasteryMultiple()
}

AddIcon specialization=beast_mastery size=small {
    Interrupt()
    MendPet()
}
