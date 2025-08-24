// General
// what is a spell, how does it work? //
name = " " //the name of the spell 
overlay_state = " "  //the overlay that comes up to you or your target. 
releasedrain =  //No idea.
chargeddrain = //No idea.
chargetime = // How long it tales to cast the spell, if set at 0 its instant.
range =  //how many tiles away is it
warnie =  //No idea.
movment_interrupt = //If someone moves when the spell is cast does it negate the spell? apply [TRUE] and [FALSE] 
sound =  //what sounds a spell makes when it is cast. Use the 'sound/magic' area.
associated_skill = //if there are any skills in additon to this one, that are connected.
antimagic_allowed =  //[FALSE] and [TRUE] Apply here.
invocation = "The Firstborn smites thee!" // what someone said when the magic is cast
invocation_type = // How is the magic said? by a shout or a whisper
charge_max = SECONDS // the maximum amount of time needed to charge the spell, counted in seconds.
devotion_cost =  // How much devotion it costs, use negative numbers. 

//Blank Template//
name = " "
overlay_state = " "
releasedrain = 
chargeddrain =
chargetime =
range = 
warnie = 
movment_interrupt =  
sound = 
associated_skill = 
invocation = "The Firstborn smites thee!"
	invocation_type = "shout
charge_max =
devotion_cost =

/obj/effect/proc_holder/spell/invoked/lesser_heal/cast(list/targets, mob/living/user) //This line of code reads "the effect lesser can be cast on others, by the caster.

// What the spel actually does, up to you. Enjoy coding.



/////////////////////////////////
//   Undefined spells /?/      //  
////////////////////////////////
////////////////////////////////
//  1. SILORES - Sacred Flame //  
////////////////////////////////
/obj/effect/proc_holder/spell/targeted/sacred_flame_rogue
	name = "Sacred Flame"
	overlay_state = "sacredflame"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation = "The Sun cleanses!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 5 SECONDS
	miracle = TRUE
	devotion_cost = -45
	include_user = 0
	max_targets = 1

/obj/effect/proc_holder/spell/targeted/sacred_flame_rogue/cast(list/targets, mob/user = usr)
	for(var/mob/living/L in targets)
		user.visible_message("<font color='yellow'>[user] points at [L]/</font>")
		if(L.anti_magic_check(TRUE, TRUE))
			continue
		L.adjust_fire_stacks(5)
		L.IgniteMob()
		sleep(40)
		L.ExtinguishMob()

/////////////////////////
//  1. SILORES - Smite //  
/////////////////////////
/obj/effect/proc_holder/spell/targeted/smite	//Smite targets all excommunicated and apostates in view, providing a chance to stun based on holy level, and sets them on fire w/ a debuff effect applied.
	name = "Smite"				//Smite is twice as strong during the dae, and will even target undead/vampires during the day.
	range = 8
	overlay_state = "silores"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/ahh2.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Firstborn smites thee!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	var/smitelevel = 1
	var/prob2smite = 0

/obj/effect/proc_holder/spell/targeted/smite/cast(list/targets, mob/living/user = usr)
	prob2smite = 0

	if (GLOB.tod == "dawn"|| GLOB.tod == "day"|)
		smitelevel = 2
	else
		smitelevel = 1
	if(user && user.mind)
		for(var/i in 1 to user.mind.get_skill_level(/datum/skill/magic/holy))
			prob2smite += 20
	for(var/mob/living/L in targets)
		if(L.stat == DEAD)
			continue
		if(HAS_TRAIT(L, TRAIT_EXCOMMUNICATED) || L.has_status_effect(/datum/status_effect/debuff/apostasy))
			user.visible_message(span_warning("[usr] brings forth HER power and smites [L]!"))
			smite_effect(L)
			..()
			return TRUE
		if(L.mind)
			var/datum/antagonist/vampirelord/lesser/V = L.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			if(V)
				if(V.disguised || smitelevel != 2) // Being disguised makes you immune to being smited. If you can hide from astrata's rays in dae, you can hide from the smite.
					continue
				user.visible_message(span_warning("[user] brings forth the HER power and smites [L]!"))
				smite_effect(V)
				return

			if(L.mind.special_role == "Vampire Lord" && smitelevel == 2)
				var/datum/antagonist/vampirelord/V_lord = L.mind.has_antag_datum(/datum/antagonist/vampirelord/)
				if(V_lord.vamplevel < 4)
					user.visible_message(span_warning("[usr] brings forth the HER power and smites [L]!"))
					smite_effect(L)
					return
				else
					user.visible_message(span_warning("[L] rebukes [usr]'s smite!"))
					user.throw_at(get_ranged_target_turf(user, get_dir(user,L), 7), 7, 1, L, spin = FALSE)
			var/datum/antagonist/zombie/Z =L.mind.has_antag_datum(/datum/antagonist/zombie)
			if(Z)
				user.visible_message(span_warning("[usr] brings forth the HER power and smites [L]!"))
				smite_effect(L)
				return
		if(L.mob_biotypes & MOB_UNDEAD && smitelevel == 2)
			user.visible_message(span_warning("[usr] brings forth the HER power and smites [L]!"))
			smite_effect(L)
			return
		..()
	return TRUE

/obj/effect/proc_holder/spell/targeted/smite/proc/smite_effect(var/mob/living/carbon/L)
	var/stuntime = 25 * smitelevel
	var/fireamount = 5 * smitelevel
	if(prob(prob2smite))
		L.Stun(stuntime)
	L.adjust_fire_stacks(fireamount)
	L.IgniteMob()
	L.apply_status_effect (/datum/status_effect/debuff/smited)
	to_chat(L, span_warning("Astrata's divine light smites me!"))

////////////////////////////
//  3. SILORES - FIREBALL //  
////////////////////////////
/obj/effect/proc_holder/spell/invoked/projectile/fireball
	name = "Fireball"
	desc = ""
	clothes_req = FALSE
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue
	overlay_state = "fireball"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	charge_max = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/invoked/projectile/fireball/fire_projectile(list/targets, mob/living/user)
	projectile_var_overrides = list("range" = 8)
	return ..()

/obj/projectile/magic/aoe/fireball/rogue
	name = "fireball"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 0
	exp_fire = 1
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////
//  BALGROMEL AND QOTIA   //  
////////////////////////////

////////////////////////////
//  1.B+Q - Blindness     //  
////////////////////////////
/obj/effect/proc_holder/spell/invoked/blindness
    name = "Blindness"
    overlay_state = "blindness"
    req_items = list(/obj/item/clothing/neck/roguetown/psicross)
    releasedrain = 30
    chargedrain = 0
    chargetime = 0
    range = 7
    warnie = "sydwarning"
    movement_interrupt = FALSE
    sound = 'sound/magic/churn.ogg'
    invocation = "Noc blinds thee of thy sins!"
    invocation_type = "shout" //can be none, whisper, emote and shout
    associated_skill = /datum/skill/magic/holy
    antimagic_allowed = TRUE
    charge_max = 15 SECONDS
    devotion_cost = 15

/obj/effect/proc_holder/spell/invoked/blindness/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(span_warning("[user] points at [target]'s eyes!"),span_warning("My eyes are covered in darkness!"))		
		target.blind_eyes(2)
		return TRUE
	revert_cast()
	return FALSE


////////////////////////////////
//  2.B+Q - Lesser Heal      //  
///////////////////////////////
/obj/effect/proc_holder/spell/invoked/lesser_heal
	name = "Lesser Miracle"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	devotion_cost = -25

/obj/effect/proc_holder/spell/invoked/heal/lesser/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		if(get_dist(user, target) > 7)
			return FALSE
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.visible_message("<span class='danger'>[target] is burned by holy light!</span>", "<span class='userdanger'>I'm burned by holy light!</span>")
			target.adjustFireLoss(50)
			target.Paralyze(30)
			target.fire_act(1,5)
			return TRUE
		target.visible_message("<span class='info'>A wreath of gentle light passes over [target]!</span>", "<span class='notice'>I'm bathed in holy light!</span>")
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(20, 20, 0, null, FALSE))
					C.update_damage_overlays()
				if(affecting.heal_wounds(50))
					C.update_damage_overlays()
		else
			target.adjustBruteLoss(-5)
			target.adjustFireLoss(-5)
		target.adjustToxLoss(-5)
		target.adjustOxyLoss(-5)
		target.blood_volume += 25
		return TRUE
	else
		return FALSE


/////////////////////////////
//  3.B+Q - Wound Heal     //  
////////////////////////////
/obj/effect/proc_holder/spell/invoked/wound_heal
	name = "Wound Miracle"
	desc = "Heals all wounds on a targeted limb."
	overlay_icon = 'icons/mob/actions/genericmiracles.dmi'
	overlay_state = "woundheal"
	action_icon_state = "woundheal"
	action_icon = 'icons/mob/actions/genericmiracles.dmi'
	releasedrain = 15
	chargedrain = 0
	chargetime = 3
	range = 1
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/magic/woundheal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 2 MINUTES
	miracle = TRUE
	is_cdr_exempt = TRUE
	var/delay = 4.5 SECONDS	//Reduced to 1.5 seconds with Legendary
	devotion_cost = 100

/obj/effect/proc_holder/spell/invoked/wound_heal/cast(list/targets, mob/user = usr)
	if(ishuman(targets[1]))
	
		var/mob/living/carbon/human/target = targets[1]
		var/mob/living/carbon/human/HU = user
		var/def_zone = check_zone(user.zone_selected)
		var/obj/item/bodypart/affecting = target.get_bodypart(def_zone)

		if(HAS_TRAIT(target, TRAIT_PSYDONITE))
			target.visible_message(span_info("[target] stirs for a moment, the miracle dissipates."), span_notice("A dull warmth swells in your heart, only to fade as quickly as it arrived."))
			user.playsound_local(user, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			playsound(target, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			return FALSE

		if(!affecting)
			revert_cast()
			return FALSE
		if(length(affecting.embedded_objects))
			var/no_embeds = TRUE
			for(var/object in affecting.embedded_objects)
				if(!istype(object, /obj/item/natural/worms/leech))	//Leeches and surgical cheeles are made an exception.
					no_embeds = FALSE
			if(!no_embeds)
				to_chat(user, span_warning("We cannot seal wounds with objects inside this limb!"))
				revert_cast()
				return FALSE
		if(!do_after(user, (delay - (0.5 SECONDS * HU.get_skill_level(associated_skill)))))
			revert_cast()
			to_chat(user, span_warning("We were interrupted!"))
			return FALSE
		var/foundwound = FALSE
		if(length(affecting.wounds))
			for(var/datum/wound/wound in affecting.wounds)
				if(!isnull(wound) && wound.healable_by_miracles)
					wound.heal_wound(wound.whp)
					foundwound = TRUE
					user.visible_message(("<font color = '#488f33'>[capitalize(wound.name)] oozes a clear fluid and closes shut, forming into a sore bruise!</font>"))
					affecting.add_wound(/datum/wound/bruise/woundheal)
			if(foundwound)
				playsound(target, 'sound/magic/woundheal_crunch.ogg', 100, TRUE)
			affecting.change_bodypart_status(BODYPART_ORGANIC, heal_limb = TRUE)
			affecting.update_disabled()
			return TRUE
		else
			to_chat(user, span_warning("The limb is free of wounds."))
			revert_cast()
			return FALSE



/////////////////////////////////
//  4.B+Q - Conjure Vines     //  
////////////////////////////////
/obj/effect/proc_holder/spell/targeted/conjure_vines
	name = "Vine Sprout"
	range = 1
	overlay_state = "blesscrop"
	releasedrain = 80
	charge_max = 25 SECONDS
	chargetime = 20
	no_early_release = TRUE
	movement_interrupt = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/items/dig_shovel.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Treefather, bring forth vines."
	invocation_type = "shout" //can be none, whisper, emote and shout
	devotion_cost = 40

/obj/effect/proc_holder/spell/targeted/conjure_vines/cast(list/targets, mob/user = usr)
	. = ..()
	var/turf/target_turf = get_step(user, user.dir)
	var/turf/target_turf_two = get_step(target_turf, turn(user.dir, 90))
	var/turf/target_turf_three = get_step(target_turf, turn(user.dir, -90))
	if(!locate(/obj/structure/spacevine) in target_turf)
		new /obj/structure/spacevine/dendor(target_turf)
	if(!locate(/obj/structure/spacevine) in target_turf_two)
		new /obj/structure/spacevine/dendor(target_turf_two)
	if(!locate(/obj/structure/spacevine) in target_turf_three)
		new /obj/structure/spacevine/dendor(target_turf_three)
	
return TRUE

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

/////////////////////////////////////
//  1.BARGOMEL - Invisibility     //  
////////////////////////////////////
/obj/effect/proc_holder/spell/invoked/invisibility
	name = "Invisibility"
	overlay_state = "invisibility"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	charge_max = 30 SECONDS
	range = 3
	warnie = "sydwarning"
	movement_interrupt = FALSE
	invocation_type = "whisper"
	sound = 'sound/misc/area.ogg' //This sound doesnt play for some reason. Fix me.
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	devotion_cost = 25

/obj/effect/proc_holder/spell/invoked/invisibility/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(span_warning("[target] starts to fade into thin air!"), span_notice("You start to become invisible!"))
		animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
		target.mob_timers[MT_INVISIBILITY] = world.time + 15 SECONDS
		addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 15 SECONDS)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[target] fades back into view."), span_notice("You become visible again.")), 15 SECONDS)
		return TRUE
	revert_cast()
	return FALSE

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

////////////////////////////////
//  1.QOTIA - Bless Crops     //  
////////////////////////////////
/obj/effect/proc_holder/spell/targeted/blesscrop
	name = "Bless Crops"
	range = 5
	overlay_state = "blesscrop"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Treefather commands thee, be fruitful!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/targeted/blesscrop/cast(list/targets,mob/user = usr)
	. = ..()
	var/growed = FALSE
	var/amount_blessed = 0
	for(var/obj/structure/soil/soil in view(4))
		soil.bless_soil()
		growed = TRUE
		amount_blessed++
		// Blessed only up to 5 crops
		if(amount_blessed >= 5)
			break
	if(growed)
		visible_message(span_green("[usr] blesses the nearby crops with Dendor's Favour!"))
	return growed


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////
//  VATNAS     //  
/////////////////

////////////////////////
// 1.VATNAS - Burden //
///////////////////////
/obj/effect/proc_holder/spell/invoked/burden
	name = "Burden"
	overlay_state = "hierophant"
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/timestop.ogg'
	invocation = "In Ravox's name, stand and fight, coward!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	charge_max = 30 SECONDS
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/burden/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	spelltarget.apply_status_effect(/datum/status_effect/debuff/ravox_burden)

	if(spelltarget != user)
		user.visible_message("[user] shouts an incantation, causing [spelltarget] to go stiff!")
	else
		user.visible_message("[user] shouts an incantation as they slow to a crawl.")

	return TRUE
/////////////////////////////
// 2. Vatnas - Blood Heal  //
/////////////////////////////
/obj/effect/proc_holder/spell/invoked/blood_heal
	name = "Blood transfer Miracle"
	desc = "Transfers the blood from myself to the target with divine magycks. Ratio of transfer scales with holy skill."
	overlay_icon = 'icons/mob/actions/genericmiracles.dmi'
	overlay_state = "bloodheal"
	action_icon_state = "bloodheal"
	action_icon = 'icons/mob/actions/genericmiracles.dmi'
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	ignore_los = FALSE
	warnie = "sydwarning"
	movement_interrupt = TRUE
	sound = 'sound/magic/bloodheal.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 45 SECONDS
	miracle = TRUE
	devotion_cost = 50
	var/blood_price = 5
	var/blood_vol_restore = 7.5 //30 every 2 seconds.
	var/vol_per_skill = 1	//54 with legendary
	var/delay = 0.5 SECONDS

/obj/effect/proc_holder/spell/invoked/blood_heal/cast(list/targets, mob/user = usr)
	if(ishuman(targets[1]))
		var/mob/living/carbon/human/target = targets[1]
		var/mob/living/carbon/human/UH = user
		if(target.blood_volume >= BLOOD_VOLUME_NORMAL)
			to_chat(UH, span_warning("Their lyfeblood is at capacity. There is no need."))
			revert_cast()
			return FALSE
			
		if(HAS_TRAIT(target, TRAIT_PSYDONITE))
			target.visible_message(span_info("[target] stirs for a moment, the miracle dissipates."), span_notice("A dull warmth swells in your heart, only to fade as quickly as it arrived."))
			user.playsound_local(user, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			playsound(target, 'sound/magic/PSY.ogg', 100, FALSE, -1)
			return FALSE

		UH.visible_message(span_warning("Tiny strands of red link between [UH] and [target], blood being transferred!"))
		playsound(UH, 'sound/magic/bloodheal_start.ogg', 100, TRUE)
		var/user_skill = UH.get_skill_level(associated_skill)
		var/user_informed = FALSE
		switch(user_skill)	//Bleeding happens every life(), which is every 2 seconds. Multiply these numbers by 4 to get the "bleedrate" equivalent values.
			if(SKILL_LEVEL_APPRENTICE)
				blood_price = 3.75
			if(SKILL_LEVEL_JOURNEYMAN)
				blood_price = 2.5
			if(SKILL_LEVEL_EXPERT)
				blood_price = 2
			if(SKILL_LEVEL_MASTER)
				blood_price = 1.625
			if(SKILL_LEVEL_LEGENDARY)
				blood_price = 1.25
		if(user_skill > SKILL_LEVEL_NOVICE)
			blood_vol_restore += vol_per_skill * user_skill
		var/max_loops = round(UH.blood_volume / blood_price, 1) * 2	// x2 just in case the user is trying to fill themselves up while using it.
		var/datum/beam/bloodbeam = user.Beam(target,icon_state="blood",time=(max_loops * 5))
		for(var/i in 1 to max_loops)
			if(UH.blood_volume > (BLOOD_VOLUME_SURVIVE / 2))
				if(do_after(UH, delay))
					target.blood_volume = min((target.blood_volume + blood_vol_restore), BLOOD_VOLUME_NORMAL)
					UH.blood_volume = max((UH.blood_volume - blood_price), 0)
					if(target.blood_volume >= BLOOD_VOLUME_NORMAL && !user_informed)
						to_chat(UH, span_info("They're at a healthy blood level, but I can keep going."))
						user_informed = TRUE
				else
					UH.visible_message(span_warning("Severs the bloodlink from [target]!"))
					bloodbeam.End()
					return TRUE
			else
				UH.visible_message(span_warning("Severs the bloodlink from [target]!"))
				bloodbeam.End()
				return TRUE
		bloodbeam.End()
		return TRUE

/////////////////////////
// 3. Vatnas - Endure //
////////////////////////
/obj/effect/proc_holder/spell/invoked/vatnasendure
	name = "ENDURE"
	desc = "Mends the wounds of the target."
	overlay_state = "ENDURE"
	releasedrain = 20
	chargedrain = 0
	chargetime = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/ENDVRE.ogg'
	invocations = list("LYVE, ENDURE!") // holy larp yelling for healing is silly
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 30 SECONDS
	miracle = TRUE
	devotion_cost = 40

/obj/effect/proc_holder/spell/invoked/psydonendure/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		var/brute = target.getBruteLoss()
		var/burn = target.getFireLoss()
		var/list/wAmount = target.get_wounds()
		var/conditional_buff = FALSE
		var/situational_bonus = 0
		var/psicross_bonus = 0
		var/pp = 0
		var/damtotal = brute + burn
		var/zcross_trigger = FALSE
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) // YOU ARE NO LONGER MORTAL. NO LONGER OF HIM. PSYDON WEEPS.
			target.visible_message(span_danger("[target] shudders with a strange stirring feeling!"), span_userdanger("It hurts. You feel like weeping."))
			target.adjustBruteLoss(40)			
			return TRUE

		// Bonuses! Flavour! SOVL!
		for(var/obj/item/clothing/neck/current_item in target.get_equipped_items(TRUE))
			if(current_item.type in list(/obj/item/clothing/neck/roguetown/zcross/aalloy, /obj/item/clothing/neck/roguetown/psicross, /obj/item/clothing/neck/roguetown/psicross/wood, /obj/item/clothing/neck/roguetown/psicross/aalloy, /obj/item/clothing/neck/roguetown/psicross/silver,	/obj/item/clothing/neck/roguetown/psicross/g))
				pp += 1
				if(pp >= 12 & target == user) // A harmless easter-egg. Only applies on self-cast. You'd have to be pretty deliberate to wear 12 of them.
					target.visible_message(span_danger("[target]'s many psycrosses reverberate with a strange, ephemeral sound..."), span_userdanger("HE must be waking up! I can hear it! I'm ENDURING so much!"))
					playsound(user, 'sound/magic/PSYDONE.ogg', 100, FALSE)
					sleep(60)
					user.psydo_nyte()
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					sleep(20)
					user.psydo_nyte()
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					sleep(15)
					user.psydo_nyte()
					user.playsound_local(user, 'sound/misc/psydong.ogg', 100, FALSE)
					sleep(10)
					user.gib()
					return FALSE
				
				switch(current_item.type) // Target-based worn Psicross Piety bonus. For fun.
					if(/obj/item/clothing/neck/roguetown/psicross/wood)
						psicross_bonus = 0.1				
					if(/obj/item/clothing/neck/roguetown/psicross/aalloy)
						psicross_bonus = 0.2	
					if(/obj/item/clothing/neck/roguetown/psicross)
						psicross_bonus = 0.3
					if(/obj/item/clothing/neck/roguetown/psicross/silver)
						psicross_bonus = 0.4	
					if(/obj/item/clothing/neck/roguetown/psicross/g) // PURITY AFLOAT.
						psicross_bonus = 0.4
					if(/obj/item/clothing/neck/roguetown/zcross/aalloy)
						zcross_trigger = TRUE	

		if(damtotal >= 300) // ARE THEY ENDURING MUCH, IN ONE WAY OR ANOTHER?
			situational_bonus += 0.3

		if(wAmount.len > 5)	
			situational_bonus += 0.3		
	
		if (situational_bonus > 0)
			conditional_buff = TRUE

		target.visible_message(span_info("A strange stirring feeling pours from [target]!"), span_info("Sentimental thoughts drive away my pain..."))
		var/psyhealing = 3
		psyhealing += psicross_bonus
		if (conditional_buff & !zcross_trigger)
			to_chat(user, "In <b>ENDURING</b> so much, become <b>EMBOLDENED</b>!")
			psyhealing += situational_bonus
	
		if (zcross_trigger)
			user.visible_message(span_warning("[user] shuddered. Something's very wrong."), span_userdanger("Cold shoots through my spine. Something laughs at me for trying."))
			user.playsound_local(user, 'sound/misc/zizo.ogg', 25, FALSE)
			user.adjustBruteLoss(25)		
			return FALSE

		target.apply_status_effect(/datum/status_effect/buff/psyhealing, psyhealing)
		return TRUE

	revert_cast()
	return FALSE
