/datum/patron/divine
	name = null
	associated_faith = /datum/faith/divine
	t0 = list(/obj/effect/proc_holder/spell/targeted/touch/orison, /obj/effect/proc_holder/spell/invoked/lesser_heal)


/datum/patron/divine/silores
	name = "Silores"
	domain = "Goddess of the Sun, the Day, and Fire"
	desc = "The lady of Flame and Light, gifted man zealotry and matyrdom"
	worshippers = "The Noble Hearted, Zealots and Knights"
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/targeted/smite
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"SILORES IS MY LIGHT!",
		"MAY SILORES CLEANSE YOUR WITH FIRE!",
		"I SERVE THE GLORY OF THE FLAME!",
	)

/datum/patron/divine/bal
	name = "Balgromel"
	domain = "Father of All. God of Nature. Of Endurance and Iron-will."
	desc = "Father of the Gods. He taught Maeyr how to wield a blade and scorch the earth. To reforge life by your own hands and will."
	worshippers = "Madmen, Fathers, Scholar-Wizards, Warrior-kings and Druids"
	mob_traits = list(TRAIT_NOCTURNAL, TRAIT_VINE_WALKER) //lighting alpha 245. DV spell is 220, DV spell w/noc or DV special is 200
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
    t1 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility
    t2 = /obj/effect/proc_holder/spell/invoked/wound_heal
	confess_lines = list( )

/datum/patron/divine/qot
	name = "Qotia"
	domain = "Mother of all. Goddess of the Earth. Of Motherhood and Young Love."
	desc = "Mother of the Gods. She taught Maeyr to farm and harvest. To enjoy life to its fullest."
	worshippers = "Lovers, Mothers, Butchers, Farmers and Gardeners"
	mob_traits = list(TRAIT_NOCTURNAL, TRAIT_VINE_WALKER)
	t1 = /obj/effect/proc_holder/spell/invoked/blindness
    t1 = /obj/effect/proc_holder/spell/invoked/lesser_heal
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/targeted/conjure_vines
	confess_lines = list()

/datum/patron/divine/vatnas
	name = "Vatnas"
	domain = "Guider of Humanity, Twin-prince of A[]. Lord-to-be-enlightened."
	desc = "Guided humanity after defeating the Dark Elder. He watches man from afar now, seeking enlightenment."
	worshippers = "Warriors, Justice-seekers and Smiths"
	t1 = /obj/effect/proc_holder/spell/invoked/burden
    t1 = /obj/effect/proc_holder/spell/invoked/blood_heal
    t2 = /obj/effect/proc_holder/spell/invoked/vatnas_endure
	confess_lines = list()


////////////////////////////////////////////////////////
// Saving these for The Heathen ones, unsure of A[] ? //
////////////////////////////////////////////////////////
/datum/patron/divine/necra
	name = "Necra"
	domain = "Goddess of Death and the Afterlife"
	desc = "The Veiled Lady, a feared but respected God who leads the dead."
	worshippers = "The Dead, Mourners, Gravekeepers"
	mob_traits = list(TRAIT_SOUL_EXAMINE)
	t1 = /obj/effect/proc_holder/spell/targeted/burialrite
	t2 = /obj/effect/proc_holder/spell/targeted/churn
	t3 = /obj/effect/proc_holder/spell/targeted/soulspeak
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"THE UNDERMAIDEN IS OUR FINAL REPOSE!",
		"I FEAR NOT DEATH, MY LADY AWAITS ME!",
	)

/datum/patron/divine/pestra
	name = "Pestra"
	domain = "Goddess of Decay, Disease and Medicine"
	desc = "The Loving Daughter of Psydon, gifted man medicine."
	worshippers = "The Sick, Phyicians, Apothecaries"
	mob_traits = list(TRAIT_EMPATH, TRAIT_ROT_EATER)
	t0 = list(/obj/effect/proc_holder/spell/targeted/touch/orison, /obj/effect/proc_holder/spell/invoked/diagnose, /obj/effect/proc_holder/spell/invoked/lesser_heal) // Combine all spells on t0
	t1 = /obj/effect/proc_holder/spell/invoked/mercy
	t2 = /obj/effect/proc_holder/spell/invoked/attach_bodypart
	t3 = /obj/effect/proc_holder/spell/invoked/cure_rot
	confess_lines = list(
		"PESTRA SOOTHES ALL ILLS!",
		"DECAY IS A CONTINUATION OF LIFE!",
		"MY AFFLICTION IS MY TESTAMENT!",
	)

/datum/patron/divine/malum
	name = "Malum"
	domain = "God of Fire, Destruction and Rebirth"
	desc = "The Opinionless God, his children hold no malice in their actions."
	worshippers = "Smiths, Miners, Artists"
	mob_traits = list(TRAIT_FORGEBLESSED)
	t1 = /obj/effect/proc_holder/spell/invoked/vigorousexchange
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t4 = /obj/effect/proc_holder/spell/invoked/craftercovenant
	confess_lines = list(
		"MALUM IS MY MUSE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)

/datum/patron/divine/eora
	name = "Eora"
	domain = "Goddess of Love, Life, and Beauty"
	desc = "Eora's divine gift was family, and She taught man to make art and wine that he might live life to its fullest. She teaches love for family and beauty, and hates all that threaten them."
	worshippers = "Lovers, Doting Grandparents, Harlots"
	t1 = /obj/effect/proc_holder/spell/invoked/eoracurse
	t2 = /obj/effect/proc_holder/spell/invoked/bud
	t3 = /obj/effect/proc_holder/spell/invoked/eoracharm
	confess_lines = list(
		"EORA BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)
