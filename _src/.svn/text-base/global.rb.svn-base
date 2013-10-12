TITLESTRING="Super Mario War"
VERSIONNUMBER="1.7"
WAITTIME=16
MAXAWARDS=10
MINAWARDSNEEDED=3
#debug=false #should decide on command line option
NUM_POWERUPS=20

NUM_AUTO_FILTERS=8

JOY_STICK_1_UP=0
JOY_STICK_1_DOWN=1
JOY_STICK_1_LEFT=2
JOY_STICK_1_RIGHT=3

JOY_STICK_2_UP=4
JOY_STICK_2_DOWN=5
JOY_STICK_2_LEFT=6
JOY_STICK_2_RIGHT=7

JOY_HAT_UP=8
JOY_HAT_DOWN=9
JOY_HAT_LEFT=10
JOY_HAT_RIGHT=11
JOY_BUTTON_START=12

MOUSE_UP=323
MOUSE_DOWN=324
MOUSE_LEFT=325
MOUSE_RIGHT=326
MOUSE_BUTTON_START=327

#WAITTIME=16

#see CPlayer::draw() on how this is used

PGFX_STANDING_R=0
PGFX_STANDING_L=1
PGFX_RUNNING_R=2
PGFX_RUNNING_L=3
PGFX_JUMPING_R=4
PGFX_JUMPING_L=5
PGFX_STOPPING_R=6
PGFX_STOPPING_L=7
PGFX_DEADFLYING=8
PGFX_DEAD=9
#--------------------------
PGFX_LAST=10

MENU_ITEM_NEIGHBOR_UP=0
MENU_ITEM_NEIGHBOR_DOWN=1
MENU_ITEM_NEIGHBOR_LEFT=2
MENU_ITEM_NEIGHBOR_RIGHT=3

DEVICE_KEYBOARD=-1

def ifsoundonplay(x)
  ($game_values.sound ? x.play() : -1)
end
def ifsoundonandreadyplay(x) 
  (x.isready() && $game_values.sound ? x.play() : -1)
end
def ifsoundonplayloop(x,y) 
  ($game_values.sound ? x.playloop(y) : -1)
end
def ifsoundonstop(x) 
  ($game_values.sound ? x.stop() : nil)
end

def ifsoundonpause(x)
  ($game_values.sound ? x.sfx_pause() : -1)
end

def ifmusiconplay(x) 
  ($game_values.music ? x.play() : -1)
end

def getScreenBackgroundFade

  #ifdef _XBOX
  #	return 96 #TV's seem to need extra shade
  #end 
  return 72;
end

def getNameFromFileName(szFileName)
  index = szFileName.rindex('/')
  index = -1 if index.nil?
  szName = szFileName[index+1..-1]
  
  index = szName.rindex('.')
  index = 0 if index.nil?
  return szName[0..index-1]
end

def stripCreatorAndDotMap(x)
  x = x.sub(/.*_/,"")
  x[0,x.rindex(".")]
end

MAPWIDTH=20
MAPHEIGHT=15
MAPLAYERS=4

TILESETSIZE = 960
#20 * 16 tile.
TILESETHEIGHT = 30
TILESETWIDTH = 32

TILESIZE=32
PREVIEWTILESIZE=16
THUMBTILESIZE=8
BLOCKSETSIZE=15
MAXWARPS=32

TWO_PI=6.2831853
PI=3.1415292
THREE_HALF_PI=4.7123890
THREE_QUARTER_PI=2.3561945
HALF_PI=1.5707963
QUARTER_PI=0.7853982

NUMSPAWNAREATYPES=2
MAXSPAWNAREAS=128
MAXDRAWAREAS=128

MAX_PLAYER_SPAWN_TRIES=16

MAXMUSICCATEGORY=11
MAXCATEGORYTRACKS=64



g_szBackgroundConversion = ["Land_Classic.png",
  "Castle_Dungeon.png",
  "Desert_Pyramids.png",
  "Ghost_GhostHouse.png",
  "Underground_Cave.png",
  "Clouds_AboveTheClouds.png",
  "Castle_GoombaHall.png",
  "Platforms_GreenSpottedHills.png",
  "Snow_SnowTrees.png",
  "Desert_Desert.png",
  "Underground_BrownRockWall.png",
  "Land_CastleWall.png",
  "Clouds_Clouds.png",
  "Land_GreenMountains.png",
  "Land_InTheTrees.png",
  "Battle_Manor.png",
  "Platforms_JaggedGreenStones.png",
  "Underground_RockWallAndPlants.png",
  "Underground_DarkPipes.png",
  "Bonus_StarryNight.png",
  "Platforms_CloudsAndWaterfalls.png",
  "Battle_GoombaPillars.png",
  "Bonus_HillsAtNight.png",
  "Castle_CastlePillars.png",
  "Land_GreenHillsAndClouds.png",
  "Platforms_BlueSpottedHills.png"]
  
$g_szAutoFilterNames = ["Hazards", "Warps", "Ice", "Item Boxes", "Breakable Blocks", "Throwable Blocks", "On/Off Blocks", "Platforms"];
$g_iAutoFilterIcons = [37, 29, 33, 1, 0, 6, 40, 73];

$g_iPowerupToIcon = [80, 176, 272, 304, 336, 368];
                                                                         
PH=25		#Player height
PW=22		#Player width
HALFPH=12
HALFPW=11
PHOFFSET=4
PWOFFSET=5

CRUNCHVELOCITY=2
CRUNCHAMOUNT=16
CRUNCHMAX=32

VELMOVING	=	4.0		#velocity (speed) for moving left, right
VELSLOWMOVING	= 2.2		#velocity when slow down powerup is in effect
VELDASHMOVING =   10.0		#velocity of invincible dashing
VELMOVING_CHICKEN = 2.9		#speed of the chicken in the gamemode capturethechicken
VELMOVINGADD = 0.5
VELMOVINGADDICE = VELMOVINGADD / 4
VELDASHADD =      1.0
VELTURBOMOVING = 5.5
VELJUMP	=	9.0		#velocity for jumping
VELSLOWJUMP	=	7.0		#velocity for jumping when slow down powerup is in effect
VELTURBOJUMP =	10.2		#velocity for turbo jumping
VELSUPERJUMP =	14.0;		#super jump (hold down for 2 seconds, then jump on note blocks)
VELPUSHBACK =	5.0
VELMAXBREAKBLOCK = 3.0
VELNOTEBLOCKBOUNCE = 3.0
VELNOTEBLOCKREPEL = 5.0
VELBLOCKBOUNCE = 3.0
VELBLOCKREPEL =  3.0
VELPOWERUPBOUNCE = 8.1
FIREBALLBOUNCE = 5.0
HAMMERTHROW =    8.5
VELMOVINGFRICTION = 0.2
VELICEFRICTION =  0.06
VELAIRFRICTION = 0.06
VELSTOPJUMP  =   5.0
BOUNCESTRENGTH = 0.5
TAGGEDBOOST  =  1.0

GRAVITATION	=	0.40

MAXVELY	=	20.0
CORPSESTAY=200

GameInputNames = ["Left", "Right", "Jump", "Down", "Turbo", "Use Item", "Pause", "Exit"];
MenuInputNames = ["Up", "Down", "Left", "Right", "Select", "Cancel", "Random", "Fast Map"];


Keynames = ["Unknown", "", "", "", "", "", "", "", "Backspace", "Tab", 
						"",	"", "Clear", "Return", "", "", "", "", "", "Pause",
						"", "", "", "", "", "", "", "Escape", "", "",
						"", "", "Space Bar", "!", "\"", "#", "$", "", "&", "'",
						"(", ")", "*", "+", ",", "-", ".", "/", "0", "1",
						"2", "3", "4", "5", "6", "7", "8", "9", ":", ";",
						"<", "=", ">", "?", "@", "", "", "", "", "", 
						"", "", "", "", "", "", "", "", "", "", 
						"", "", "", "", "", "", "", "", "", "", 
						"", "[", "\\", "]", "^", "_", "`", "A", "B", "C", 
				##100
				  	"D", "E", "F", "G", "H", "I", "J", "K", "L", "M", 
						"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", 
						"X", "Y", "Z", "", "", "", "", "Delete", "", "", 
						"", "", "", "", "", "", "", "", "", "", 
						"", "", "", "", "", "", "", "", "", "", 
						"", "", "", "", "", "", "", "", "", "", 
						"World 0", "World 1", "World 2", "World 3", "World 4", "World 5", "World 6", "World 7", "World 8", "World 9", 
						"World 10", "World 11", "World 12", "World 13", "World 14", "World 15", "World 16", "World 17", "World 18", "World 19", 
						"World 20", "World 21", "World 22", "World 23", "World 24", "World 25", "World 26", "World 27", "World 28", "World 29", 
						"World 30", "World 31", "World 32", "World 33", "World 34", "World 35", "World 36", "World 37", "World 38", "World 39", 
				##200
				    "World 40", "World 41", "World 42", "World 43", "World 44", "World 45", "World 46", "World 47", "World 48", "World 49", 
						"World 50", "World 51", "World 52", "World 53", "World 54", "World 55", "World 56", "World 57", "World 58", "World 59", 
						"World 60", "World 61", "World 62", "World 63", "World 64", "World 65", "World 66", "World 67", "World 68", "World 69", 
						"World 70", "World 71", "World 72", "World 73", "World 74", "World 75", "World 76", "World 67", "World 78", "World 79", 
						"World 80", "World 81", "World 82", "World 83", "World 84", "World 85", "World 86", "World 77", "World 88", "World 89", 
						"World 90", "World 91", "World 92", "World 93", "World 94", "World 95", "Keypad 0", "Keypad 1", "Keypad 2", "Keypad 3", 
						"Keypad 4", "Keypad 5", "Keypad 6", "Keypad 7", "Keypad 8", "Keypad 9", "Keypad .", "Keypad /", "Keypad *", "Keypad -", 
						"Keypad +", "Keypad Enter", "Keypad =", "Up", "Down", "Right", "Left", "Insert", "Home", "End", 
						"Page Up", "Page Down", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", 
						"F9", "F10", "F11", "F12", "F13", "F14", "F15", "", "", "", 
				##300
					"Num Lock", "Caps Lock", "Scroll Lock", "Right Shift", "Left Shift", "Right Control", "Left Control", "Right Alt", "Left Alt", "Right Meta", 
						"Left Meta", "Left Super", "Right Super", "Mode", "Compose", "Help", "Print", "Sys Req", "Break", "Menu", 
						"Power", "Euro", "Undo", "Mouse Up", "Mouse Down", "Mouse Left", "Mouse Right", "Mouse Button 1", "Left Mouse Button", "Center Mouse Button",
						"Right Mouse Button", "Mouse Scroll Up", "Mouse Scroll Down", "Mouse Button 4", "Mouse Button 5", "Mouse Button 6", "Mouse Button 7", "Mouse Button 8", "Mouse Button 9", "Mouse Button 10"]
						
Joynames = ["Joystick Up", "Joystick Down", "Joystick Left", "Joystick Right", "Stick 2 Up", "Stick 2 Down", "Stick 2 Left", "Stick 2 Right", "Pad Up", "Pad Down", 
                       "Pad Left", "Pad Right", "Button 1", "Button 2", "Button 3", "Button 4", "Button 5", "Button 6", "Button 7", "Button 8", 
					   "Button 9", "Button 10", "Button 11", "Button 12", "Button 13", "Button 14", "Button 15", "Button 16", "Button 17", "Button 18"]

KEY_NONE = -1