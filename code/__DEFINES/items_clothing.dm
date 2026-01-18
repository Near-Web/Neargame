#define HUMAN_STRIP_DELAY        40   // Takes 40ds = 4s to strip someone.

#define SHOES_SLOWDOWN          -1.0  // How much shoes slow you down by default. Negative values speed you up.

//ITEM INVENTORY SLOT BITMASKS
#define SLOT_OCLOTHING 1
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
#define SLOT_LEGS = 16384

// Flags bitmasks.
#define STOPPRESSUREDAMAGE 1 // This flag is used on the flags variable for SUIT and HEAD items which stop pressure damage. Note that the flag 1 was previous used as ONBACK, so it is possible for some code to use (flags & 1) when checking if something can be put on your back. Replace this code with (inv_flags & SLOT_BACK) if you see it anywhere
                             // To successfully stop you taking all pressure damage you must have both a suit and head item with this flag.
#define AIRTIGHT           4    // Functions with internals.
#define USEDELAY 	16		// 1 second extra delay on use (Can be used once every 2s)
#define NODELAY 	32768	// 1 second attackby delay skipped (Can be used once every 0.2s). Most objects have a 1s attackby delay, which doesn't require a flag.
#define NOSHIELD	32		// weapon not affected by shield
#define CONDUCT		64		// conducts electricity (metal etc.)
#define FPRINT		256		// takes a fingerprint
#define ON_BORDER	512		// item has priority to check when entering or leaving
#define NOBLUDGEON  4  // when an item has this it produces no "X has been hit by Y with Z" message with the default handler
#define NOBLOODY	2048	// used to items if they don't want to get a blood overlay

//Use these flags to indicate if an item obscures the specified slots from view, whereas body_parts_covered seems to be used to indicate what body parts the item protects.
#define GLASSESCOVERSEYES	1024
#define MASKCOVERSEYES		1024		// get rid of some of the other retardation in these flags
#define HEADCOVERSEYES		1024		// feel free to realloc these numbers for other purposes
#define MASKCOVERSMOUTH		2048		// on other items, these are just for mask/head
#define HEADCOVERSMOUTH		2048

#define THICKMATERIAL 1024  // From /tg/station: prevents syringes, parapens and hyposprays if the external suit or helmet (if targeting head) has this flag. Example: space suits, biosuit, bombsuits, thick suits that cover your body. (NOTE: flag shared with NOSLIP for shoes)
#define NOSLIP		1024 		//prevents from slipping on wet floors, in space etc
#define OPENCONTAINER	4096 // Is an open container for chemistry purposes.
#define BLOCK_GAS_SMOKE_EFFECT 8192	// blocks the effect that chemical clouds would have on a mob --glasses, mask and helmets ONLY! (NOTE: flag shared with ONESIZEFITSALL)
#define ONESIZEFITSALL 8192
#define PLASMAGUARD 16384			//Does not get contaminated by plasma.
#define	NOREACT		16384 			//Reagents dont' react inside this container.
#define BLOCKHEADHAIR 4             // temporarily removes the user's hair overlay. Leaves facial hair.
#define BLOCKHAIR	32768			// temporarily removes the user's hair, facial and otherwise.

// Flags for pass_flags.
#define PASSTABLE  1
#define PASSGLASS  2
#define PASSGRILLE 4
#define PASSBLOB   8

// Bitmasks for the flags_inv variable. These determine when a piece of clothing hides another, i.e. a helmet hiding glasses.
// WARNING: The following flags apply only to the external suit!
#define HIDEGLOVES      1
#define HIDESUITSTORAGE 2
#define HIDEJUMPSUIT    4
#define HIDESHOES       8
#define HIDETAIL        16

// WARNING: The following flags apply only to the helmets and masks!
#define HIDEMASK 1
#define HIDEEARS 2 // Headsets and such.
#define HIDEEYES 4 // Glasses.
#define HIDEFACE 8 // Dictates whether we appear as "Unknown".

//Slots
#define slot_back 1
#define slot_wear_mask 2
#define slot_handcuffed 3
#define slot_l_hand 4
#define slot_r_hand 5
#define slot_belt 6
#define slot_wear_id 7
#define slot_l_ear 8
#define slot_glasses 9
#define slot_gloves 10
#define slot_head 11
#define slot_shoes 12
#define slot_wear_suit 13
#define slot_w_uniform 14
#define slot_l_store 15
#define slot_r_store 16
#define slot_s_store 17
#define slot_in_backpack 18
#define slot_legcuffed 19
#define slot_r_ear 20
#define slot_legs 21
#define slot_wrist_r 22
#define slot_wrist_l 23
#define slot_amulet 24
#define slot_back2 25

// Inventory slot strings.
// since numbers cannot be used as associative list keys.
#define slot_back_str		"back"
#define slot_l_hand_str		"slot_l_hand"
#define slot_r_hand_str		"slot_r_hand"
#define slot_w_uniform_str	"w_uniform"

// Bitflags for clothing parts.
#define HEAD        (1<<0)
#define UPPER_TORSO        (1<<1)
#define GROIN        (1<<2)
#define LEG_LEFT    (1<<3)
#define LEG_RIGHT    (1<<4)
#define LEGS        (LEG_LEFT | LEG_RIGHT)
#define FOOT_LEFT    (1<<5)
#define FOOT_RIGHT    (1<<6)
#define FEET        (FOOT_LEFT | FOOT_RIGHT)
#define ARM_LEFT    (1<<7)
#define ARM_RIGHT    (1<<8)
#define ARMS        (ARM_LEFT | ARM_RIGHT)
#define HAND_LEFT    (1<<9)
#define HAND_RIGHT    (1<<10)
#define HANDS        (HAND_LEFT | HAND_RIGHT)
#define THROAT        (1<<11)
#define LEFT_EYE    (1<<12)
#define RIGHT_EYE    (1<<13)
#define LOWER_TORSO       (1<<14)
#define EYES        (LEFT_EYE | RIGHT_EYE)
#define FACE          (1<<15)
#define MOUTH         (1<<16)
#define R_EYE         (1<<17)
#define L_EYE         (1<<18)
#define LEGS_TOGETHER (1<<19) //if the legs are one piece, used for icon drawing
#define FULL_BODY    (~0)

#define CANDLE_LUM 3 // For how bright candles are.

// Bitflags for the percentual amount of protection a piece of clothing which covers the body part offers.
// Used with human/proc/get_heat_protection() and human/proc/get_cold_protection().
// The values here should add up to 1.
// Hands and feet have 2.5%, arms and legs 7.5%, each of the torso parts has 15% and the head has 30%
#define THERMAL_PROTECTION_HEAD			0.3
#define THERMAL_PROTECTION_UPPER_TORSO	0.15
#define THERMAL_PROTECTION_LOWER_TORSO	0.15
#define THERMAL_PROTECTION_LEG_LEFT		0.075
#define THERMAL_PROTECTION_LEG_RIGHT	0.075
#define THERMAL_PROTECTION_FOOT_LEFT	0.025
#define THERMAL_PROTECTION_FOOT_RIGHT	0.025
#define THERMAL_PROTECTION_ARM_LEFT		0.075
#define THERMAL_PROTECTION_ARM_RIGHT	0.075
#define THERMAL_PROTECTION_HAND_LEFT	0.025
#define THERMAL_PROTECTION_HAND_RIGHT	0.025

// Pressure limits.
#define HAZARD_HIGH_PRESSURE 550	//This determins at what pressure the ultra-high pressure red icon is displayed. (This one is set as a constant)
#define WARNING_HIGH_PRESSURE 325 	//This determins when the orange pressure icon is displayed (it is 0.7 * HAZARD_HIGH_PRESSURE)
#define WARNING_LOW_PRESSURE 50 	//This is when the gray low pressure icon is displayed. (it is 2.5 * HAZARD_LOW_PRESSURE)
#define HAZARD_LOW_PRESSURE 20		//This is when the black ultra-low pressure icon is displayed. (This one is set as a constant)

#define TEMPERATURE_DAMAGE_COEFFICIENT 1.5	//This is used in handle_temperature_damage() for humans, and in reagents that affect body temperature. Temperature damage is multiplied by this amount.
#define BODYTEMP_AUTORECOVERY_DIVISOR 12 //This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery. This is applied each tick, so long as the mob is alive.
#define BODYTEMP_AUTORECOVERY_MINIMUM 10 //Minimum amount of kelvin moved toward 310.15K per tick. So long as abs(310.15 - bodytemp) is more than 50.
#define BODYTEMP_COLD_DIVISOR 6 //Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to lose bodytemp faster.
#define BODYTEMP_HEAT_DIVISOR 6 //Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to gain bodytemp faster.
#define BODYTEMP_COOLING_MAX -30 //The maximum number of degrees that your body can cool in 1 tick, when in a cold area.
#define BODYTEMP_HEATING_MAX 30 //The maximum number of degrees that your body can heat up in 1 tick, when in a hot area.

#define BODYTEMP_HEAT_DAMAGE_LIMIT 360.15 // The limit the human body can take before it starts taking damage from heat.
#define BODYTEMP_COLD_DAMAGE_LIMIT 260.15 // The limit the human body can take before it starts taking damage from coldness.

#define SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // What min_cold_protection_temperature is set to for space-helmet quality headwear. MUST NOT BE 0.
#define   SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // What min_cold_protection_temperature is set to for space-suit quality jumpsuits or suits. MUST NOT BE 0.
#define       HELMET_MIN_COLD_PROTECTION_TEMPERATURE 160 // For normal helmets.
#define        ARMOR_MIN_COLD_PROTECTION_TEMPERATURE 160 // For armor.
#define       GLOVES_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // For some gloves.
#define         SHOE_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // For shoes.

#define  SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE 5000  // These need better heat protect, but not as good heat protect as firesuits.
#define    FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE 30000 // What max_heat_protection_temperature is set to for firesuit quality headwear. MUST NOT BE 0.
#define FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE 30000 // For fire-helmet quality items. (Red and white hardhats)
#define      HELMET_MAX_HEAT_PROTECTION_TEMPERATURE 600   // For normal helmets.
#define       ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE 600   // For armor.
#define      GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE 1500  // For some gloves.
#define        SHOE_MAX_HEAT_PROTECTION_TEMPERATURE 1500  // For shoes.

#define PRESSURE_SUIT_REDUCTION_COEFFICIENT 0.8 //This is how much (percentual) a suit with the flag STOPSPRESSUREDMAGE reduces pressure.
#define PRESSURE_HEAD_REDUCTION_COEFFICIENT 0.4 //This is how much (percentual) a helmet/hat with the flag STOPSPRESSUREDMAGE reduces pressure.

// Fire.
#define FIRE_MIN_STACKS          -20
#define FIRE_MAX_STACKS           25
#define FIRE_MAX_FIRESUIT_STACKS  20 // If the number of stacks goes above this firesuits won't protect you anymore. If not, you can walk around while on fire like a badass.

#define THROWFORCE_SPEED_DIVISOR    5  // The throwing speed value at which the throwforce multiplier is exactly 1.
#define THROWNOBJ_KNOCKBACK_SPEED   15 // The minumum speed of a w_class 2 thrown object that will cause living mobs it hits to be knocked back. Heavier objects can cause knockback at lower speeds.
#define THROWNOBJ_KNOCKBACK_DIVISOR 2  // Affects how much speed the mob is knocked back with.

// Suit sensor levels
#define SUIT_SENSOR_OFF      0
#define SUIT_SENSOR_BINARY   1
#define SUIT_SENSOR_VITAL    2
