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
charge_max =
devotion_cost =

/obj/effect/proc_holder/spell/invoked/lesser_heal/cast(list/targets, mob/living/user) //This line of code reads "the effect lesser can be cast on others, by the caster.

// What the spel actually does, up to you. Enjoy coding.
