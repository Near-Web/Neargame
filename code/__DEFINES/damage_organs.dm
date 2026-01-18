// Damage things. TODO: Merge these down to reduce on defines.
// Way to waste perfectly good damage-type names (BRUTE) on this... If you were really worried about case sensitivity, you could have just used lowertext(damagetype) in the proc.
#define CUT 		"cut"
#define BRUISE		"bruise"
#define BRUTE		"brute"
#define BURN		"fire"
#define TOX			"tox"
#define OXY			"oxy"
#define CLONE		"clone"
#define HALLOSS		"halloss"
#define STAMINA "stamina"

#define STUN		"stun"
#define WEAKEN		"weaken"
#define PARALYZE	"paralize"
#define IRRADIATE	"irradiate"
#define STUTTER		"stutter"
#define SLUR 		"slur"
#define EYE_BLUR	"eye_blur"
#define DROWSY		"drowsy"

#define AGONY		"agony" // Added in PAIN!

// I hate adding defines like this but I'd much rather deal with bitflags than lists and string searches.
#define BRUTELOSS 1
#define FIRELOSS  2
#define TOXLOSS   4
#define OXYLOSS   8

// Organ defines.
#define ORGAN_CUT_AWAY 1
#define ORGAN_GAUZED 2
#define ORGAN_ATTACHABLE 4
#define ORGAN_BLEEDING 8
#define ORGAN_BROKEN 32
#define ORGAN_DESTROYED 64
#define ORGAN_ROBOT 128
#define ORGAN_SPLINTED 256
#define SALVED 512
#define ORGAN_DEAD 1024
#define ORGAN_MUTATED 2048
#define ORGAN_ARTERY 4096
#define ORGAN_TENDON 8192

#define DROPLIMB_EDGE 0
#define DROPLIMB_BLUNT 1
#define DROPLIMB_BURN 2

// Damage above this value must be repaired with surgery.
#define ROBOLIMB_SELF_REPAIR_CAP 30

/*
	Germs and infections
*/

#define GERM_LEVEL_AMBIENT		110		//maximum germ level you can reach by standing still
#define GERM_LEVEL_MOVE_CAP		200		//maximum germ level you can reach by running around

#define INFECTION_LEVEL_ONE		50
#define INFECTION_LEVEL_TWO		250
#define INFECTION_LEVEL_THREE	500
