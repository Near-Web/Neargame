/obj/item/reagent_containers/food/snacks/lw

/obj/item/reagent_containers/food/snacks/lw/On_Consume()
	..()
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.add_event("goodfood", /datum/happiness_event/nutrition/goodfood)

/obj/item/reagent_containers/food/snacks/candy
	name = "candy"
	desc = "Nougat love it or hate it."
	icon_state = "candy"
	item_state = "candy"
	trash = /obj/item/trash/candy
	filling_color = "#7D5F46"
	var/candy_open = FALSE

/obj/item/reagent_containers/food/snacks/candy/New()
		..()
		reagents.add_reagent("nutriment", 2)
		reagents.add_reagent("sugar", 2)
		bitesize = 2


/obj/item/reagent_containers/food/snacks/candy/On_Consume(mob/user as mob)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.add_event("candy", /datum/happiness_event/nutrition/badtaste)
	..()

/obj/item/reagent_containers/food/snacks/candy/attack_self(mob/user as mob)
	if(ishuman(user) && !candy_open)
		if(do_after(user, 5))
			to_chat(user, "<span class='passive'>You open the candy bar.</span>")
			candy_open = TRUE
			playsound(user, "open_candy.ogg", 50, 0)
			update_icon()
	else
		to_chat(user, "<span class='combat'>[pick(fnord)] it is already open!</span>")
	return

/obj/item/reagent_containers/food/snacks/candy/attack(mob/M as mob, mob/user as mob, def_zone)
	if(!candy_open)
		to_chat(user, "<span class='combat'>[pick(fnord)] I need to open it before eating!</span>")
		return
	..()

/obj/item/reagent_containers/food/snacks/candy/On_Consume()
	..()
	icon_state = "candy-chew"

/obj/item/reagent_containers/food/snacks/candy/update_icon()
	if(candy_open)
		icon_state = "candy-open"
	else
		icon_state = "candy"

/obj/item/reagent_containers/food/snacks/organ

	name = "organ"
	desc = "It's good for you."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "appendix"
	filling_color = "#E00D34"

/obj/item/reagent_containers/food/snacks/organ/New()
		..()
		reagents.add_reagent("nutriment", rand(3,5))
		reagents.add_reagent("toxin", rand(1,3))
		src.bitesize = 3


/obj/item/reagent_containers/food/snacks/worms
	name = "Worms"
	icon_state = "worm7"
	filling_color = "#211F02"
	New()
		..()
		reagents.add_reagent("????", 30)
		bitesize = 7

/obj/item/reagent_containers/food/snacks/worms/On_Consume()
	..()
	var/totial = bitesize-bitecount
	icon_state = "worm[totial]"

/obj/item/reagent_containers/food/snacks/worms/update_icon()
	icon_state = "worm[bitesize]"

/obj/item/reagent_containers/food/snacks/worms/Crossed(AM as mob|obj)
	if(iscarbon(AM))
		var/mob/living/carbon/M = AM
		if(prob(30))
			M.stumble(1,src)
	else
		return

/obj/item/reagent_containers/food/snacks/deadrat
	name = "rat"
	icon_state = "rat"
	filling_color = "#211F02"

/obj/item/reagent_containers/food/snacks/deadrat/New()
		..()
		reagents.add_reagent("nutriment", 4)
		reagents.add_reagent("????", 1)
		bitesize = 2


/obj/item/reagent_containers/food/snacks/purryingmaggot
	name = "purrying maggot"
	icon = 'icons/mob/animal.dmi'
	icon_state = "worm_l"
	filling_color = "#211F02"

/obj/item/reagent_containers/food/snacks/purryingmaggot/New()
	..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("milk", 2)
	if(prob(40))
		reagents.add_reagent("????", 0.5)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/poo
	name = "poo"
	desc = "It's a poo. How disgusting!"
	icon = 'icons/obj/poop.dmi'
	icon_state = "poop2"
	item_state = "poop"
	maybecomeflesh = 1
/obj/item/reagent_containers/food/snacks/poo/New()
	..()
	icon_state = pick("poop1", "poop2", "poop3", "poop4", "poop5", "poop6", "poop7")
	reagents.add_reagent("poo", 10)
	bitesize = 3

/*	proc/poo_splat(atom/target)
		if(reagents.total_volume)
			if(ismob(target))
				src.reagents.reaction(target, TOUCH)
			if(isturf(target))
				src.reagents.reaction(get_turf(target))
			if(isobj(target))
				src.reagents.reaction(target, TOUCH)
		spawn(5) src.reagents.clear_reagents()
		playsound(src.loc, "squish.ogg", 40, 1)
		qdel(src)
*/
/obj/item/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom)
	..()
	if(istype(hit_atom, /turf/simulated/floor/open))//If it's an open space just fall through it.
		return
	if(reagents.total_volume)
		src.reagents.reaction(get_turf(hit_atom))
	spawn(5) src.reagents.clear_reagents()
	playsound(src.loc, "squish.ogg", 40, 1)
	qdel(src)

/obj/item/reagent_containers/food/snacks/lw/bakedpotato
	name = "baked potato"
	icon_state = "bakedpotato"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 3

/obj/item/reagent_containers/food/snacks/lw/steak
	name = "steak"
	icon_state = "steak"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 3


/obj/item/reagent_containers/food/snacks/lw/omelette
	name = "omelette"
	icon_state = "omelette"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2

/obj/item/reagent_containers/food/snacks/lw/fries
	name = "fries"
	icon_state = "fries"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 3

/obj/item/reagent_containers/food/snacks/lw/flatbread
	name = "flatbread"
	icon_state = "flatbread"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 3

/obj/item/reagent_containers/food/snacks/lw/loaf
	name = "loaf"
	icon_state = "loaf4"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 4
	On_Consume()
		..()
		var/totial = bitesize-bitecount
		icon_state = "loaf[totial]"


/obj/item/reagent_containers/food/snacks/lw/pancake
	name = "pancake"
	icon_state = "pancake"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 3


/obj/item/reagent_containers/food/snacks/lw/cutlet
	name = "cutlet"
	icon_state = "cutlet4"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 4
	On_Consume()
		..()

/obj/item/reagent_containers/food/snacks/lw/crackers
	name = "crackers"
	icon_state = "cracker5"
	icon = 'icons/obj/food.dmi'

	New()
		..()
		reagents.add_reagent("nutriment", 8)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 5
	On_Consume()
		..()
		var/totial = bitesize-bitecount
		icon_state = "cracker[totial]"


// ALCOHOLISMS GREAT FOOD REWORK/REDO/THINGY

// EXOTIC SPICES - Nobles love 'em, everyone loves 'em, only way to taste luxury!

/obj/item/reagent_containers/food/snacks/lw/exotic
	name = "spices"
	desc = "Incredibly armoatic."
	icon_state = "exotic"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 1) // Why the fuck would you eat this raw. Seriously.
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 1

/obj/item/reagent_containers/food/snacks/lw/salt
	name = "salt"
	desc = "Incredibly salty"
	icon_state = "exotic"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 1) // Why the fuck would you eat this raw. Seriously.
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 1

// PASTRY

/obj/item/reagent_containers/food/snacks/lw/bun
	name = "bun"
	icon_state = "lwbun"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2

// PERSONAL PIE - Fuck it! Throw it in a PIE!

/obj/item/reagent_containers/food/snacks/lw/plpie
	name = "plump-helmet pie"
	icon_state = "pieshroom"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 4

/obj/item/reagent_containers/food/snacks/lw/popie
	name = "potato pie"
	icon_state = "piepotato"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 4

/obj/item/reagent_containers/food/snacks/lw/mpie
	name = "meat pie"
	icon_state = "piemeat"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 12)
		bitesize = 4

// OVEN-ROASTED - Delicious, probably. Generic food goes here

/obj/item/reagent_containers/food/snacks/lw/shroomsteak
	name = "shroomsteak"
	icon_state = "shroomsteak"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		bitesize = 4 // Lots of bites, since it's got alot of pieces!

/obj/item/reagent_containers/food/snacks/lw/eggytoast
	name = "arelite-in-the-nest"
	icon_state = "egghole"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		bitesize = 2

/obj/item/reagent_containers/food/snacks/lw/eeye
	name = "eelo eye"
	icon_state = "eelo_eye"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2

/obj/item/reagent_containers/food/snacks/lw/stuffplump
	name = "stuffed plumphelmet"
	icon_state = "stuffedhelmet"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2

/obj/item/reagent_containers/food/snacks/lw/bastardcake
	name = "alms cake"
	icon_state = "srygnik"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 2) // TERRIBLE! But CHEAP!
		bitesize = 1

// BURGERS & HANDHELDS - BORGAR

/obj/item/reagent_containers/food/snacks/lw/ratburger
	name = "rat burger"
	icon_state = "ratburger"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6) // No longer a luxury! It's a RAT!
		bitesize = 3

/obj/item/reagent_containers/food/snacks/lw/ratburger/cheese
	name = "cheese rat burger"
	icon_state = "cheeseratburger"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8) // No. Not even cheese makes it a luxury.
		bitesize = 3

/obj/item/reagent_containers/food/snacks/lw/donair
	name = "donair"
	icon_state = "shaurma" // Get fucked
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 4


// Spiced Variants

/obj/item/reagent_containers/food/snacks/lw/plpie/spiced
	name = "plump-helmet pie"
	desc = "It smells delicious!"
	icon_state = "pieshroom"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 4

/obj/item/reagent_containers/food/snacks/lw/popie/spiced
	name = "potato pie"
	desc = "It smells delicious!"
	icon_state = "piepotato"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 4

/obj/item/reagent_containers/food/snacks/lw/mpie/spiced
	name = "meat pie"
	desc = "It smells delicious!"
	icon_state = "piemeat"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 12)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 4

/obj/item/reagent_containers/food/snacks/lw/stuffplump/spiced
	name = "stuffed plumphelmet"
	desc = "It smells delicious!"
	icon_state = "stuffedhelmet"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 2

/obj/item/reagent_containers/food/snacks/lw/shroomsteak/spiced
	name = "shroomsteak"
	desc = "It smells delicious!"
	icon_state = "shroomsteak"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 4

/obj/item/reagent_containers/food/snacks/lw/steak/spiced
	name = "steak"
	desc = "It smells delicious!"
	icon_state = "steak"
	icon = 'icons/obj/cooking.dmi'
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 3
