#define DEBUG
// Turf-only flags.
#define TURF_FLAG_NOJAUNT               BITFLAG(0) // This is used in literally one place, turf.dm, to block ethereal jaunt.
#define TURF_FLAG_NO_POINTS_OF_INTEREST BITFLAG(1) // Used by the level subtemplate generator to skip placing loaded templates on this turf.
#define TURF_FLAG_BACKGROUND            BITFLAG(2) // Used by shuttle movement to determine if it should be ignored by turf translation.
#define TURF_FLAG_HOLY                  BITFLAG(3)
#define TURF_FLAG_ABSORB_LIQUID         BITFLAG(4)
#define TURF_IS_HOLOMAP_OBSTACLE        BITFLAG(5)
#define TURF_IS_HOLOMAP_PATH            BITFLAG(6)
#define TURF_IS_HOLOMAP_ROCK            BITFLAG(7)

//Error handler defines
#define ERROR_USEFUL_LEN 2

#define TYPE_IS_ABSTRACT(D) (initial(D.abstract_type) == D)
#define TYPE_IS_SPAWNABLE(D) (!TYPE_IS_ABSTRACT(D) && initial(D.is_spawnable_type))
#define INSTANCE_IS_ABSTRACT(D) (D.abstract_type == D.type)

#define EXCEPTION_TEXT(E) "'[E.name]' ('[E.type]'): '[E.file]':[E.line]:\n'[E.desc]'"

//Area flags, possibly more to come
#define AREA_FLAG_RAD_SHIELDED         BITFLAG(1)  // Shielded from radiation, clearly.
#define AREA_FLAG_EXTERNAL             BITFLAG(2)  // External as in exposed to space, not outside in a nice, green, forest.
#define AREA_FLAG_ION_SHIELDED         BITFLAG(3)  // Shielded from ionospheric anomalies.
#define AREA_FLAG_IS_NOT_PERSISTENT    BITFLAG(4)  // SSpersistence will not track values from this area.
#define AREA_FLAG_IS_BACKGROUND        BITFLAG(5)  // Blueprints can create areas on top of these areas. Cannot edit the name of or delete these areas.
#define AREA_FLAG_MAINTENANCE          BITFLAG(6)  // Area is a maintenance area.
#define AREA_FLAG_SHUTTLE              BITFLAG(7)  // Area is a shuttle area.
#define AREA_FLAG_HALLWAY              BITFLAG(8)  // Area is a public hallway suitable for event selection
#define AREA_FLAG_PRISON               BITFLAG(9)  // Area is a prison for the purposes of brigging objectives.
#define AREA_FLAG_HOLY                 BITFLAG(10) // Area is holy for the purposes of marking turfs as cult-resistant.
#define AREA_FLAG_SECURITY             BITFLAG(11) // Area is security for the purposes of newscaster init.
#define AREA_FLAG_HIDE_FROM_HOLOMAP    BITFLAG(12) // if we shouldn't be drawn on station holomaps

// Literacy check constants.
#define WRITTEN_SKIP     0
#define WRITTEN_PHYSICAL 1
#define WRITTEN_DIGITAL  2

// Turf-only flags.
#define NOJAUNT 1 // This is used in literally one place, turf.dm, to block ethereal jaunt.

#define TRANSITIONEDGE 2 // Distance from edge to move to another z-level.

// Invisibility constants.
#define INVISIBILITY_LIGHTING             20
#define INVISIBILITY_LEVEL_ONE            35
#define INVISIBILITY_LEVEL_TWO            45
#define INVISIBILITY_TELLER		          55
#define INVISIBILITY_OBSERVER             60
#define INVISIBILITY_EYE		          61

#define SEE_INVISIBLE_LIVING              25
#define SEE_INVISIBLE_OBSERVER_NOLIGHTING 15
#define SEE_INVISIBLE_LEVEL_ONE           35
#define SEE_INVISIBLE_LEVEL_TWO           45
#define SEE_INVISIBLE_TELLER		      55
#define SEE_INVISIBLE_CULT		          60
#define SEE_INVISIBLE_OBSERVER            61

#define SEE_INVISIBLE_MINIMUM 5
#define INVISIBILITY_MAXIMUM 100

// Some arbitrary defines to be used by self-pruning global lists. (see master_controller)
#define PROCESS_KILL 26 // Used to trigger removal from a processing list.

// Age limits on a character.
#define AGE_MIN 18
#define AGE_MAX 85

#define MAX_GEAR_COST 5 // Used in chargen for accessory loadout limit.

//Preference toggles
#define SOUND_ADMINHELP	1
#define SOUND_MIDI		2
#define SOUND_AMBIENCE	4
#define SOUND_LOBBY		8
#define CHAT_OOC		16
#define CHAT_DEAD		32
#define CHAT_GHOSTEARS	64
#define CHAT_GHOSTSIGHT	128
#define CHAT_PRAYER		256
#define CHAT_RADIO		512
#define CHAT_ATTACKLOGS	1024
#define CHAT_DEBUGLOGS	2048
#define CHAT_LOOC		4096
#define CHAT_GHOSTRADIO 8192
#define SHOW_TYPING 	16384

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|CHAT_OOC|CHAT_DEAD|CHAT_PRAYER|CHAT_RADIO|CHAT_ATTACKLOGS|CHAT_LOOC)

// For secHUDs and medHUDs and variants. The number is the location of the image on the list hud_list of humans.
#define      HEALTH_HUD 1 // A simple line rounding the mob's number health.
#define      STATUS_HUD 2 // Alive, dead, diseased, etc.
#define          ID_HUD 3 // The job asigned to your ID.
#define      WANTED_HUD 4 // Wanted, released, paroled, security status.
#define    IMPLOYAL_HUD 5 // Loyality implant.
#define     IMPCHEM_HUD 6 // Chemical implant.
#define    IMPTRACK_HUD 7 // Tracking implant.
#define SPECIALROLE_HUD 8 // AntagHUD image.
#define  STATUS_HUD_OOC 9 // STATUS_HUD without virus DB check for someone being ill.
#define 	  LIFE_HUD 10 // STATUS_HUD that only reports dead or alive

/*
 *	Shuttles.
*/

// These define the time taken for the shuttle to get to the space station, and the time before it leaves again.
#define SHUTTLE_PREPTIME                300 // 5 minutes = 300 seconds - after this time, the shuttle departs centcom and cannot be recalled.
#define SHUTTLE_LEAVETIME               180 // 3 minutes = 180 seconds - the duration for which the shuttle will wait at the station after arriving.
#define SHUTTLE_TRANSIT_DURATION        300 // 5 minutes = 300 seconds - how long it takes for the shuttle to get to the station.
#define SHUTTLE_TRANSIT_DURATION_RETURN 120 // 2 minutes = 120 seconds - for some reason it takes less time to come back, go figure.

// Shuttle moving status.
#define SHUTTLE_IDLE      0
#define SHUTTLE_WARMUP    1
#define SHUTTLE_INTRANSIT 2

// Ferry shuttle processing status.
#define IDLE_STATE   0
#define WAIT_LAUNCH  1
#define FORCE_LAUNCH 2
#define WAIT_ARRIVE  3
#define WAIT_FINISH  4


#define BACKGROUND_ENABLED   0      // The default value for all uses of set background. Set background can
                                    // cause gradual lag and is recommended you only turn this on if necessary.
                                    // 1 will enable set background. 0 will disable set background.

// Event defines.
#define EVENT_LEVEL_MUNDANE  1
#define EVENT_LEVEL_MODERATE 2
#define EVENT_LEVEL_MAJOR    3

//General-purpose life speed define for plants.
#define HYDRO_SPEED_MULTIPLIER 1

//#define DEFAULT_JOB_TYPE /datum/job/assistant

// Custom layer definitions, supplementing the default TURF_LAYER, MOB_LAYER, etc.
#define DOOR_OPEN_LAYER 2.7		//Under all objects if opened. 2.7 due to tables being at 2.6
#define DOOR_CLOSED_LAYER 3.1	//Above most items if closed
#define LIGHTING_LAYER 11
#define OBFUSCATION_LAYER 14	//Where images covering the view for eyes are put
#define SCREEN_LAYER 17			//Mob HUD/effects layer

// Metal sheets, glass sheets, and rod stacks.
#define MAX_STACK_AMOUNT_METAL 50
#define MAX_STACK_AMOUNT_GLASS 50
#define MAX_STACK_AMOUNT_RODS  60

#define WALL_CAN_OPEN 1
#define WALL_OPENING 2

#define DEFAULT_WALL_MATERIAL "steel"

#define SHARD_SHARD "shard"
#define SHARD_SHRAPNEL "shrapnel"
#define SHARD_STONE_PIECE "piece"
#define SHARD_SPLINTER "splinters"
#define SHARD_NONE ""

#define MATERIAL_UNMELTABLE 1
#define MATERIAL_BRITTLE 2
#define MATERIAL_PADDING 4

#define TABLE_BRITTLE_MATERIAL_MULTIPLIER 4 // Amount table damage is multiplied by if it is made of a brittle material (e.g. glass)

#define MIDNIGHT_ROLLOVER		864000	//number of deciseconds in a day

#define WORLD_ICON_SIZE 32 //Needed for the R-UST port
#define PIXEL_MULTIPLIER WORLD_ICON_SIZE/32 //Needed for the R-UST port

// Maploader bounds indices
#define MAP_MINX 1
#define MAP_MINY 2
#define MAP_MINZ 3
#define MAP_MAXX 4
#define MAP_MAXY 5
#define MAP_MAXZ 6