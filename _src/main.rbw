require 'global'
require 'score'
require 'game_values'
require 'splash'
require 'path'
require 'sfont'
require 'gfx'
require 'sfx'
require 'menu'
require 'input'
require 'maplist'
require 'gamemodes'
require 'game'
require 'map'
require 'ai'

require 'eyecandy'
require 'object'


gem_original_require "RUDL"
include RUDL
include Constant


def log(*args)
  puts *args
end

#for all globals
controlkeys = [ [ [ [K_LEFT, K_RIGHT, K_UP, K_DOWN, K_RCTRL, K_RSHIFT, K_RETURN, K_ESCAPE],
												  [K_a, K_d, K_w, K_s, K_e, K_q, K_UNKNOWN, K_UNKNOWN],
												  [K_g, K_j, K_y, K_h, K_u, K_t, K_UNKNOWN, K_UNKNOWN],
												  [K_l, K_QUOTE, K_p, K_SEMICOLON, K_LEFTBRACKET, K_o, K_UNKNOWN, K_UNKNOWN] ],
											
												  #up, down, left, right, select, cancel, random, fast scroll
												[ [K_UP, K_DOWN, K_LEFT, K_RIGHT, K_RETURN, K_ESCAPE, K_SPACE,  K_LSHIFT],
												  [K_w, K_s, K_a, K_d, K_e, K_q, K_UNKNOWN, K_UNKNOWN],
												  [K_y, K_h, K_g, K_j, K_u, K_t, K_UNKNOWN, K_UNKNOWN],
												  [K_p, K_SEMICOLON, K_l, K_QUOTE, K_LEFTBRACKET, K_o, K_UNKNOWN, K_UNKNOWN] ] ],

												  #left, right, jump, down, turbo, powerup, start, cancel;
											  [ [ [JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_STICK_1_DOWN, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3, JOY_BUTTON_START + 4],
												  [JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_STICK_1_DOWN, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3, JOY_BUTTON_START + 4],
												  [JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_STICK_1_DOWN, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3, JOY_BUTTON_START + 4],
												  [JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_STICK_1_DOWN, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3, JOY_BUTTON_START + 4] ],
											
												  #up, down, left, right, select, cancel, random, fast scroll
												[ [JOY_STICK_1_UP, JOY_STICK_1_DOWN, JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3],
												  [JOY_STICK_1_UP, JOY_STICK_1_DOWN, JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3],
												  [JOY_STICK_1_UP, JOY_STICK_1_DOWN, JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3],
												  [JOY_STICK_1_UP, JOY_STICK_1_DOWN, JOY_STICK_1_LEFT, JOY_STICK_1_RIGHT, JOY_BUTTON_START, JOY_BUTTON_START + 1, JOY_BUTTON_START + 2, JOY_BUTTON_START + 3] ] ] ];

g_iVersion = [1, 7, 1, 0];
$g_iVersion = g_iVersion;
$g_fLoadMessages = true

$spr_backmap = GfxSprite.new
$spr_frontmap = GfxSprite.new

gamemodes = []
$gamemodes = gamemodes
  game_mode_frag = 0
  game_mode_timelimit = 1
  game_mode_coins=2
  game_mode_classic=3
  game_mode_chicken=4
  game_mode_tag=5
  game_mode_frenzy=6
  game_mode_survival=7
  game_mode_eggs=8
  game_mode_domination=9
  game_mode_owned=10
  game_mode_jail=11
  game_mode_stomp=12
  game_mode_race=13
  game_mode_star=14
  game_mode_ctf=15
  game_mode_koth=16
  GAMEMODE_LAST=17
  game_mode_boss=18;
  

$x_shake = 0
$y_shake = 0
$debug = false
debug = $debug

# open a window
window = DisplaySurface.new([640,480])

# set window title
window.set_caption "#{TITLESTRING} #{VERSIONNUMBER}", "smw.ico"
class Mouse
  SDL_DISABLE = 0
  def self.show_cursor(style)
    #currently only supports hiding
    set_cursor(
	[0,0],

	[	[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000]		],

	[	[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000],
		[0b00000000,0b00000000]		])
  end
end
Mouse.show_cursor(Mouse::SDL_DISABLE)
puts "\n---------------- loading ----------------\n"
score = Array.new(4)
4.times do |i|
	score[i] = CScore.new(i)
end
$score = score
game_values = GameValues.new
game_values.playercontrol[0] = 1
game_values.playercontrol[1] = 2
game_values.showfps = false
game_values.frameadvance=false
game_values.autokill=false
game_values.sound=true
game_values.music=true
game_values.gamestate=:GS_MENU
if debug
game_values.fullscreen=false
else
game_values.fullscreen=true
end

game_values.screenResizeX		= 20.0;
game_values.screenResizeY		= 20.0;
game_values.screenResizeW		= -40.0;
game_values.screenResizeH		= -40.0;

game_values.flickerfilter		= 5;  
game_values.hardwarefilter		= 2;  
game_values.softfilter			= 0;  
game_values.aspectratio10x11	= false;  

game_values.pausegame			= false;
game_values.exitinggame			= false;
game_values.exityes				= false;
game_values.awardstyle			= :award_style_fireworks;
game_values.spawnstyle			= 2;
game_values.tournamentgames		= 1;
game_values.tournamentwinner	= -1;
game_values.tour				= false;
game_values.tourstopcurrent		= 0;
game_values.tourstoptotal		= 0;
game_values.slowdownon			= -1;
game_values.slowdowncounter		= 0;
game_values.slowdownfreeze		= false;
game_values.friendlyfire		= false;
game_values.screencrunch		= true;
game_values.screenshaketimer	= 0;
game_values.screenshakeplayerid = -1;
game_values.screenshaketeamid	= -1;
game_values.toplayer			= true;
game_values.loadedannouncer		= -1;
game_values.loadedmusic			= -1;
game_values.scoreboardstyle     = 0;
game_values.teamcolors          = true;
game_values.cputurn				= -1;
game_values.spawninvincibility  = 62;
game_values.musicvolume			= 128;
game_values.soundvolume			= 128;
game_values.respawn				= 2;

game_values.itemrespawntime		= 1860;  #default item respawn is 30 seconds (30 * 62 fps)
game_values.outofboundstime		= 5;
game_values.warplocks			= 186;  # 3 seconds
game_values.cpudifficulty		= 2;
game_values.fireballttl			= 310;  # 5 seconds
game_values.shellttl			= 496;  # 8 seconds
game_values.blueblockttl		= 310;  # 5 seconds
game_values.hammerdelay			= 25;	# 0.4 second
game_values.hammerttl			= 49;	# 0.8 second
game_values.hammerpower			= true; #hammers die on first hit
game_values.fireballlimit		= 0;	#Unlimited
game_values.hammerlimit			= 0;	#Unlimited
game_values.boomerangstyle		= 1;	#SMB3 style
game_values.boomeranglife		= 248;	# 4 seconds of zelda boomerang
game_values.boomeranglimit		= 0;	#Unlimited
game_values.featherjumps		= 1;	#Allow one extra cape jump
game_values.featherlimit		= 0;	#Unlimited
game_values.storedpowerupdelay	= 4;
game_values.bonuswheel			= 1;
game_values.keeppowerup			= false;
game_values.showwinningcrown	= false;
game_values.playnextmusic		= false;
game_values.pointspeed			= 20;
game_values.swapstyle			= 1;	#Blink then swap
game_values.secrets				= true; #enable secrets by default

$filterslist = FiltersList.new
game_values.pfFilters			= Array.new()#new bool[NUM_AUTO_FILTERS + filterslist.GetCount()];
game_values.piFilterIcons		= [] #new short[NUM_AUTO_FILTERS + filterslist.GetCount()];
(NUM_AUTO_FILTERS + $filterslist.getCount()).times do |i|
	game_values.piFilterIcons[i] = 0
end
game_values.fNeedWriteFilters	= false;

#announcerlist.SetCurrent(0);
#musiclist.SetCurrent(0);
#menugraphicspacklist.SetCurrent(0);
#gamegraphicspacklist.SetCurrent(0);
#soundpacklist.SetCurrent(0);
$projectiles = [0,0,0,0]

4.times do |i| # 4 player
	#game_values.storedpowerups[i] = -1
	#game_values.gamepowerups[i] = -1
	game_values.teamids[i][0] = i
	game_values.teamcounts[i] = 1
	
	game_values.skinids[i] = 0;
	game_values.colorids[i] = i;
	
	#Setup the default key/button input configurations
  2.times do |j|  #for keyboard/joystick
		
			game_values.inputConfiguration[i][j].iDevice = j - 1;

			2.times do |k|  #for game/menu
			
				NUM_KEYS.times do |m|
				
				game_values.inputConfiguration[i][j].inputGameControls[k].keys[m] = controlkeys[j][k][i][m];
			  end
			end
	end		
	#ignore joystick here
	game_values.playerInput.inputControls[i] = game_values.inputConfiguration[i][0];
end
puts "after:#{game_values.teamids.inspect}"

#set game modes
gamemodes[0] = CGM_Classic.new;
	gamemodes[1] = CGM_Frag.new;
	gamemodes[2] = CGM_TimeLimit.new;
	gamemodes[3] = CGM_Jail.new;
	gamemodes[4] = CGM_Coins.new;
	gamemodes[5] = CGM_Stomp.new;
	gamemodes[6] = CGM_Eggs.new;
	gamemodes[7] = CGM_CaptureTheFlag.new;
	gamemodes[8] = CGM_Chicken.new;
	gamemodes[9] = CGM_Tag.new;
	gamemodes[10] = CGM_Star.new;
	gamemodes[11] = CGM_Domination.new;
	gamemodes[12] = CGM_KingOfTheHill.new;
	gamemodes[13] = CGM_Race.new;
	gamemodes[14] = CGM_Owned.new;
	gamemodes[15] = CGM_Frenzy.new;
	gamemodes[16] = CGM_Survival.new;

	bossgamemode = CGM_Boss.new;

	currentgamemode = 0;
	game_values.gamemode = gamemodes[currentgamemode];
	
#Setup the default game mode settings

#Jail
game_values.gamemodesettings.jail.tagfree = true;		#players on same team can free player by touching
game_values.gamemodesettings.jail.timetofree = 1240;   #20 seconds of jail

#Coins
game_values.gamemodesettings.coins.penalty = false;		#no penalty for getting stomped
game_values.gamemodesettings.coins.quantity = 1;		#only 1 coin on screen

	#Stomp
game_values.gamemodesettings.stomp.rate = 90; #Moderate
game_values.gamemodesettings.stomp.enemyweight[0] = 1; # turn on goombas, koopa and cheep cheeps by default
game_values.gamemodesettings.stomp.enemyweight[1] = 1;  
game_values.gamemodesettings.stomp.enemyweight[2] = 2;

	#Capture The Flag
game_values.gamemodesettings.flag.speed = 0;  #Bases don't move by default
game_values.gamemodesettings.flag.touchreturn = false;  #Don't return by touching
game_values.gamemodesettings.flag.pointmove = true;  #Move base after point
game_values.gamemodesettings.flag.autoreturn = 1240;  #Return flag automatically after 20 seconds
game_values.gamemodesettings.flag.homescore = false;  #Don't require flag to be home to score

	#Chicken
game_values.gamemodesettings.chicken.usetarget = true;  #default to displaying a target around the chicken

	#Tag
game_values.gamemodesettings.tag.tagontouch = true;  #default to transfer tag on touching other players

	#Star
game_values.gamemodesettings.star.time = 30;			#default to 30 seconds
game_values.gamemodesettings.star.shine = false;		#default to hot potato (ztar)

	#Domination
game_values.gamemodesettings.domination.loseondeath = true;
game_values.gamemodesettings.domination.stealondeath = false;
game_values.gamemodesettings.domination.relocateondeath = false;
game_values.gamemodesettings.domination.quantity = 13; ## Players + 1 = 13
game_values.gamemodesettings.domination.relocationfrequency = 1240;  #Relocate after 20 seconds = 1240
	
	#King Of The Hill
game_values.gamemodesettings.kingofthehill.areasize = 3;
game_values.gamemodesettings.kingofthehill.relocationfrequency = 1240;

	#Race
game_values.gamemodesettings.race.quantity = 4;
game_values.gamemodesettings.race.speed = 4;
game_values.gamemodesettings.race.penalty = 2;  #0 == none, 1 = 1 base, 2 = all bases lost on death
		
	#Frenzy
game_values.gamemodesettings.frenzy.quantity = 6; ##players - 1
game_values.gamemodesettings.frenzy.rate = 186; #3 seconds
game_values.gamemodesettings.frenzy.storedshells = true; #Shells are stored by default
game_values.gamemodesettings.frenzy.powerupweight[0] = 0;
game_values.gamemodesettings.frenzy.powerupweight[1] = 1;  # turn on flowers and hammers by default
game_values.gamemodesettings.frenzy.powerupweight[2] = 1;
game_values.gamemodesettings.frenzy.powerupweight[3] = 0;
game_values.gamemodesettings.frenzy.powerupweight[4] = 0;
game_values.gamemodesettings.frenzy.powerupweight[5] = 0;
game_values.gamemodesettings.frenzy.powerupweight[6] = 0;
game_values.gamemodesettings.frenzy.powerupweight[7] = 0;
game_values.gamemodesettings.frenzy.powerupweight[8] = 0;
game_values.gamemodesettings.frenzy.powerupweight[9] = 0;
game_values.gamemodesettings.frenzy.powerupweight[10] = 0;
game_values.gamemodesettings.frenzy.powerupweight[11] = 0;

	#Survival
game_values.gamemodesettings.survival.enemyweight[0] = 1;
game_values.gamemodesettings.survival.enemyweight[1] = 0;
game_values.gamemodesettings.survival.enemyweight[2] = 0;
game_values.gamemodesettings.survival.density = 20;
game_values.gamemodesettings.survival.speed = 4;
game_values.gamemodesettings.survival.shield = true;

$g_PlayingSoundchannels = {}
if File.exist?("options.bin")
  fp = File.open("options.bin", "rb")
  if fp.sysread(8).unpack("s4") == g_iVersion
    #match
    abyte = fp.sysread(27)
    game_values.spawnstyle = abyte[0];
    game_values.awardstyle =  abyte[1];
		game_values.friendlyfire = (abyte[3] > 0 ? true : false);
		game_values.screencrunch = (abyte[4] > 0 ? true : false);
		game_values.toplayer = (abyte[5] > 0 ? true : false);
		game_values.scoreboardstyle = abyte[6];
		game_values.teamcolors = (abyte[7] > 0 ? true : false);
		game_values.sound = (abyte[8] > 0 ? true : false);
		game_values.music = (abyte[9] > 0 ? true : false);
		game_values.musicvolume = abyte[10];
		game_values.soundvolume = abyte[11];
		
		#game_values.sound = true;
		#game_values.music = true;
		#game_values.musicvolume = 64;
		#game_values.soundvolume = 64;
		
		game_values.respawn = abyte[12];
		game_values.outofboundstime = abyte[14];
		game_values.cpudifficulty = abyte[15];
		game_values.framelimiter = abyte[18];
		game_values.framelimiter = 16 #if game_values.framelimiter.nil? #well, we add here
		game_values.bonuswheel = abyte[19];
		game_values.keeppowerup = (abyte[20] > 0 ? true : false);
		game_values.showwinningcrown = (abyte[21] > 0 ? true : false);
		game_values.playnextmusic = (abyte[22] > 0 ? true : false);
		game_values.pointspeed = abyte[23];
		game_values.swapstyle = abyte[24];
		game_values.secrets = (abyte[26] > 0 ? true : false);
		
		game_values.spawninvincibility =fp.sysread(2).unpack("s")[0];
		game_values.itemrespawntime = fp.sysread(2).unpack("s")[0]
		game_values.fireballttl = fp.sysread(2).unpack("s")[0]
		game_values.fireballlimit = fp.sysread(2).unpack("s")[0]
		game_values.hammerdelay = fp.sysread(2).unpack("s")[0]
		game_values.hammerttl = fp.sysread(2).unpack("s")[0]
		game_values.hammerpower = fp.sysread(1)[0]
		game_values.hammerlimit = fp.sysread(2).unpack("s")[0]
		game_values.boomerangstyle = fp.sysread(2).unpack("s")[0]
		game_values.boomeranglife = fp.sysread(2).unpack("s")[0]
		game_values.boomeranglimit = fp.sysread(2).unpack("s")[0]
		game_values.featherjumps = fp.sysread(2).unpack("s")[0]
		game_values.featherlimit = fp.sysread(2).unpack("s")[0]
		game_values.shellttl = fp.sysread(2).unpack("s")[0]
		game_values.blueblockttl = fp.sysread(2).unpack("s")[0]
		game_values.storedpowerupdelay = fp.sysread(2).unpack("s")[0]
		game_values.warplocks = fp.sysread(2).unpack("s")[0]
		
		4.times do |i|
		  2.times do |j|
		
				game_values.inputConfiguration[i][j].iDevice = fp.sysread(2).unpack("s")[0]
				game_values.inputConfiguration[i][j].inputGameControls[0].keys = fp.sysread(2*8).unpack("s*")
				game_values.inputConfiguration[i][j].inputGameControls[1].keys = fp.sysread(2*8).unpack("s*")
		 end
		end
		
		4.times do |iPlayer|
		  iDevice = fp.sysread(2).unpack("s")[0]
		  
		  #if(iDevice >= joystickcount)
			#		iDevice = DEVICE_KEYBOARD;
			#end
			
			game_values.playerInput.inputControls[iPlayer] = game_values.inputConfiguration[iPlayer][iDevice == DEVICE_KEYBOARD ? 0 : 1];
		end
		
		game_values.fullscreen = fp.sysread(1).unpack("c")[0] == 1
		
		GAMEMODE_LAST.times do |iGameMode|
		  gamemodes[iGameMode].goal = fp.sysread(2).unpack("s")[0]
		end
		NUM_POWERUPS.times do |iPowerup|
		  game_values.powerupweights[iPowerup] = fp.sysread(2).unpack("s")[0]
		end
		
		#game_values.gamemodesettings = 
		 #= fp.sysread(, sizeof(CInputPlayerControl)* 8).unpack(;
		 
		 game_values.teamcounts = fp.sysread(8).unpack("s*");
    4.times do |iTeam|
    	
      game_values.teamids[iTeam] = fp.sysread(6).unpack("s*")
    end
    game_values.skinids = fp.sysread(8).unpack("s*")
    game_values.randomskin = fp.sysread(4).unpack("c*").collect {|x|
      if x > 0
         true
      else
         false
      end
    }
    temp = fp.sysread(8)
    game_values.playercontrol = temp.unpack("s*");
    #require 'debug'
    
    #Load skin/team settings
# 		4.times do|iPlayer|
# 			if(game_values.skinids[iPlayer] >= $skinlist.getCount() || game_values.skinids[iPlayer] < 0)
# 				game_values.skinids[iPlayer] = 0;
# 			end
# 		end

#       announcerlist.SetCurrent((short) abyte[2]);
# 			musiclist.SetCurrent((short) abyte[13]);
# 			menugraphicspacklist.SetCurrent((short) abyte[16]);
# 			gamegraphicspacklist.SetCurrent((short) abyte[25]);
# 			soundpacklist.SetCurrent((short) abyte[17]);
		 
		 
		 sfx_setmusicvolume(game_values.musicvolume);
		 sfx_setsoundvolume(game_values.soundvolume);
  else
    puts "old options bin found, skip reading it"
  end
end


$window = window
$screen = window
$game_values = game_values
$blitdest = $screen

$announcerlist = AnnouncerList.new
$sfx_announcer = []
$musiclist = MusicList.new

$eyecandyfront = CEyecandyContainer.new
$eyecandyback = CEyecandyContainer.new

$objectblocks = CObjectContainer.new;
$objectcollisionitems = CObjectContainer.new;
$objectsfront = CObjectContainer.new;
$objectsplayer = CObjectContainer.new;


#colorcodes=$colorcodes
#colorschemes=$colorschemes
#Load the gfx color palette
gfx_loadpalette

mixer=Mixer.new(44100, AUDIO_S16SYS, 2, 16384)
$backgroundmusic = [SfxMusic.new,SfxMusic.new,SfxMusic.new,SfxMusic.new,SfxMusic.new]
$g_PlayingSoundChannels = {}
$g_map = CMap.new
$score_cnt = 0
$scoreoffsets = [2, 36, 70];

$scorepowerupoffsets = [[37, 0, 0],
											[71, 89, 0],
											[105, 123, 141]];
											
$respawn = [0, 0, 0, 0]

#Network stuff
$g_iNextNetworkID = 0;
$g_iNextMessageID = 0;
$szIPString = "";

#Call to setup input optimization
game_values.playerInput.checkIfMouseUsed();
fLoadOK=true
fLoadOK = loadAndSplashScreen
if !fLoadOK
  puts "\n---------------- EXIT DURING LOADING ----------------\n\n"
  sfx_close();
	gfx_close();
	#net_close();
	exit
end

$skinlist = SkinList.new
$maplist = MapList.new

$spr_background = GfxSprite.new




puts "\n---------------- ready, steady, go! ----------------\n"
menu = Menu.new
menu.createMenu()
menu.runMenu()

 while(game_values.gamestate != :GS_QUIT)
 
 		case (game_values.gamestate)
 			when :GS_START_GAME, :GS_GAME
 			  begin
 			    runGame();
 			  rescue
 			    puts $!.inspect
 			    print $!.backtrace.join("\n")
 			    exit
 			  end
 			
 			when :GS_MENU
 			  puts "run menu"
 				menu.runMenu();
       when :GS_QUIT # added because of warning on not handling all of enum
         break;
 		end
 end
 
 

# loop do
#     # wait for an input event
#     ev = EventQueue.wait
#     puts ev.gain if ev.is_a? ActiveEvent
#     # exit if the window was closed
#     break if ev.is_a? QuitEvent
# end



def getPlayerFromGlobalID(iGlobalID)
  $list_players.select {|x| x.globalID == iGlobalID}[0] #because select always return an array, even not found, return an empty array
end