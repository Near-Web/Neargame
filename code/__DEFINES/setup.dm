//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31
// TODO: Half of the defines in this file should be bitflags. Correct them eventually ~ Niobe
#define DEBUG
#define PI 3.1415

#define DELAY2GLIDESIZE(delay) (32 / max(Ceiling(delay / world.tick_lag), 1))

// delayNext() flags.
#define DELAY_MOVE    1
#define DELAY_ATTACK  2
#define DELAY_SPECIAL 4
#define DELAY_THROW 8
#define DELAY_ALL (DELAY_MOVE|DELAY_ATTACK|DELAY_SPECIAL|DELAY_THROW)

#define OR ||

#define ARBITRARILY_LARGE_NUMBER 10000 //Used in delays.dm and vehicle.dm. Upper limit on delays
#define ARBITRARILY_PLANCK_NUMBER 1.417*(10**32) //1.417×10^32. Because ARBITRARILY_LARGE_NUMBER is too small and INF is too large
#define MAX_VALUE 65535

#define MOLES_PHORON_VISIBLE 0.7 //Moles in a standard cell after which phoron is visible

/*
#define FIRE_MINIMUM_TEMPERATURE_TO_SPREAD	150+T0C
#define FIRE_MINIMUM_TEMPERATURE_TO_EXIST	100+T0C
#define FIRE_SPREAD_RADIOSITY_SCALE		0.85
#define FIRE_CARBON_ENERGY_RELEASED	  500000 //Amount of heat released per mole of burnt carbon into the tile
#define FIRE_PHORON_ENERGY_RELEASED	 3000000 //Amount of heat released per mole of burnt phoron into the tile
#define FIRE_GROWTH_RATE			40000 //For small fires

#define WATER_BOIL_TEMP 393 */

//Phoron fire properties
#define PHORON_MINIMUM_BURN_TEMPERATURE		100+T0C
#define PHORON_FLASHPOINT 					246+T0C
#define PHORON_UPPER_TEMPERATURE			1370+T0C
#define PHORON_MINIMUM_OXYGEN_NEEDED		2
#define PHORON_MINIMUM_OXYGEN_PHORON_RATIO	20
#define PHORON_OXYGEN_FULLBURN				10
				// -270.3degC


//This was a define, but I changed it to a variable so it can be changed in-game.(kept the all-caps definition because... code...) -Errorage
var/MAX_EXPLOSION_RANGE = 14
//#define MAX_EXPLOSION_RANGE		14					// Defaults to 12 (was 8) -- TLE		// How much shoes slow you down by default. Negative values speed you up


//ITEM INVENTORY SLOT BITMASKS
/*#define SLOT_OCLOTHING 1
#define SLOT_ICLOTHING 2
#define SLOT_GLOVES 4
#define SLOT_EYES 8
#define SLOT_EARS 16
#define SLOT_MASK 32
#define SLOT_HEAD 64
#define SLOT_FEET 128
#define SLOT_ID 256
#define SLOT_BELT 512
#define SLOT_BACK 1024
#define SLOT_POCKET 2048		//this is to allow items with a w_class of 3 or 4 to fit in pockets.
#define SLOT_DENYPOCKET 4096	//this is to deny items with a w_class of 2 or 1 to fit in pockets.
#define SLOT_TWOEARS 8192
#define SLOT_LEGS = 16384 */

//FLAGS BITMASK
#define STOPSPRESSUREDMAGE 1	//This flag is used on the flags variable for SUIT and HEAD items which stop pressure damage. Note that the flag 1 was previous used as ONBACK, so it is possible for some code to use (flags & 1) when checking if something can be put on your back. Replace this code with (inv_flags & SLOT_BACK) if you see it anywhere
                                //To successfully stop you taking all pressure damage you must have both a suit and head item with this flag.
#define TABLEPASS 2			// can pass by a table or rack

#define MASKINTERNALS	8	// mask allows internals
//#define SUITSPACE		8	// suit protects against space

#define PHORONGUARD 16384			//Does not get contaminated by phoron.


/*var/list/accessable_z_levels = list("1" = 5, "3" = 10, "4" = 15, "5" = 10, "6" = 60)*/
//This list contains the z-level numbers which can be accessed via space travel and the percentile chances to get there.
//(Exceptions: extended, sandbox and nuke) -Errorage
//Was list("3" = 30, "4" = 70).
//Spacing should be a reliable method of getting rid of a body -- Urist.
//Go away Urist, I'm restoring this to the longer list. ~Errorage

#define IS_MODE_COMPILED(MODE) (ispath(text2path("/datum/game_mode/"+(MODE))))


var/list/global_mutations = list() // list of hidden mutation things

var/static/list/scarySounds = list('sound/weapons/thudswoosh.ogg','sound/weapons/Taser.ogg','sound/weapons/armbomb.ogg','sound/voice/hiss1.ogg','sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg','sound/voice/hiss5.ogg','sound/voice/hiss6.ogg','sound/effects/Glassbr1.ogg','sound/effects/Glassbr2.ogg','sound/effects/Glassbr3.ogg','sound/items/Welder.ogg','sound/items/Welder2.ogg','sound/machines/airlock.ogg','sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg')

//Security levels
#define SEC_LEVEL_GREEN	0
#define SEC_LEVEL_BLUE	1
#define SEC_LEVEL_RED	2
#define SEC_LEVEL_DELTA	3

var/list/liftable_structures = list(\

	/obj/machinery/autolathe, \
	/obj/machinery/constructable_frame, \
	/obj/machinery/portable_atmospherics/hydroponics, \
	/obj/machinery/computer, \
	/obj/machinery/optable, \
	/obj/structure/dispenser, \
	/obj/machinery/gibber, \
	/obj/machinery/microwave, \
	/obj/machinery/vending, \
	/obj/machinery/seed_extractor, \
	/obj/machinery/space_heater, \
	/obj/machinery/recharge_station, \
	/obj/machinery/flasher, \
	/obj/structure/stool, \
	/obj/structure/closet, \
	/obj/machinery/photocopier, \
	/obj/structure/filingcabinet, \
	/obj/structure/reagent_dispensers, \
	/obj/machinery/portable_atmospherics/canister)

#define BE_TRAITOR    1
#define BE_OPERATIVE  2
#define BE_CHANGELING 4
#define BE_WIZARD     8
#define BE_MALF       16
#define BE_REV        32
#define BE_ALIEN      64
#define BE_PAI        128
#define BE_CULTIST    256
#define BE_MONKEY     512
#define BE_NINJA      1024
#define BE_RAIDER     2048
#define BE_PLANT      4096
#define BE_MUTINEER   8192

var/list/be_special_flags = list(
	"Traitor" = BE_TRAITOR,
	"Operative" = BE_OPERATIVE,
	"Changeling" = BE_CHANGELING,
	"Wizard" = BE_WIZARD,
	"Malf AI" = BE_MALF,
	"Revolutionary" = BE_REV,
	"Xenomorph" = BE_ALIEN,
	"pAI" = BE_PAI,
	"Cultist" = BE_CULTIST,
	"Monkey" = BE_MONKEY,
	"Ninja" = BE_NINJA,
	"Raider" = BE_RAIDER,
	"Diona" = BE_PLANT,
	"Mutineer" = BE_MUTINEER
	)
			//oldest a character can be

//Languages!
#define LANGUAGE_HUMAN		1
#define LANGUAGE_ALIEN		2
#define LANGUAGE_DOG		4
#define LANGUAGE_CAT		8
#define LANGUAGE_BINARY		16
#define LANGUAGE_OTHER		32768

#define LANGUAGE_UNIVERSAL	65535

var/list/RESTRICTED_CAMERA_NETWORKS = list( //Those networks can only be accessed by preexisting terminals. AIs and new terminals can't use them.
	"thunder",
	"ERT",
	"NUKE"
	)

//Species flags.
#define NO_BLOOD 1
#define NO_BREATHE 2
#define NO_SCAN 4
#define NO_PAIN 8
#define NO_SLIP 16
#define NO_POISON 32

#define HAS_SKIN_TONE 64
#define HAS_SKIN_COLOR 128
#define HAS_LIPS 256
#define HAS_UNDERWEAR 512
#define IS_PLANT 1024
#define IS_WHITELISTED 2048
#define IS_SYNTHETIC 4096

//Language flags.
#define WHITELISTED 1  		// Language is available if the speaker is whitelisted.
#define RESTRICTED 2   		// Language can only be accquired by spawning or an admin.
#define NONVERBAL 4    		// Language has a significant non-verbal component. Speech is garbled without line-of-sight
#define SIGNLANG 8     		// Language is completely non-verbal. Speech is displayed through emotes for those who can understand.
#define HIVEMIND 16         // Broadcast to all mobs with this language.

//Some on_mob_life() procs check for alien races.
#define IS_DIONA 1
#define IS_VOX 2
#define IS_SKRELL 3
#define IS_UNATHI 4
#define IS_XENOS 5

var/list/hit_appends = list("-OOF", "-ACK", "-UGH", "-HRNK", "-HURGH", "-GLORF")

// Reagent metabolism defines.
#define FOOD_METABOLISM 0.4
#define ALCOHOL_METABOLISM 0.1

///////////////////////
///////RESEARCH////////
///////////////////////
//used in rdmachines, to define certain behaviours
//bitflags are my waifu - Comic

//NB TRUELOCKS should ONLY be used for machines that produce stuff that's not good in an emergency i.e. a gun fabricator. Be very careful with it
#define CONSOLECONTROL		1	//does the console control it? can't be interacted if not linked
#define HASOUTPUT			2	//does it have an output? - mainly for fabricators
#define TAKESMATIN			4	//does it takes materials (sheets) - mainly for fabricators
#define NANOTOUCH			8	//does it have a nanoui when you smack it with your hand? - mainly for fabricators
#define HASMAT_OVER			16	//does it have overlays for when you load materials in? - mainly for fabricators
#define ACCESS_EMAG			32	//does it lose all its access when smacked by an emag? incompatible with CONSOLECONTROl, for obvious reasons
#define LOCKBOXES			64	//does it spawn a lockbox around a design which is said to be locked? - for fabricators
#define TRUELOCKS			128 //does it make a truly locked lockbox? If not set, the lockboxes made are unlockable by any crew with an ID

#define SLASH 1
#define STAB 2
#define BASH 3

// for /datum/var/datum_flags
#define DF_USE_TAG (1<<0)
#define DF_VAR_EDITED (1<<1)
#define DF_ISPROCESSING (1<<2)

// Reference list for disposal sort junctions. Set the sortType variable on disposal sort junctions to
// the index of the sort department that you want. For example, sortType set to 2 will reroute all packages
// tagged for the Cargo Bay.
var/list/TAGGERLOCATIONS = list("Disposals",
	"Cargo Bay", "QM Office", "Engineering", "CE Office",
	"Atmospherics", "Security", "HoS Office", "Medbay",
	"CMO Office", "Chemistry", "Research", "RD Office",
	"Robotics", "HoP Office", "Library", "Chapel", "Theatre",
	"Bar", "Kitchen", "Hydroponics", "Janitor Closet","Genetics")