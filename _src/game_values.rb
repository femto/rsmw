
class GameValues
  attr_accessor :playercontrol
  attr_accessor :showfps,:frameadvance
  attr_accessor :autokill,:framelimiter
  attr_accessor :sound, :music,:gamestate
  attr_accessor :fullscreen
  
  attr_accessor		:screenResizeX
	attr_accessor		:screenResizeY
	attr_accessor		:screenResizeW
	attr_accessor		:screenResizeH
	
	attr_accessor		:flickerfilter
	attr_accessor		:hardwarefilter
	attr_accessor		:softfilter
	attr_accessor		:aspectratio10x11
	
	attr_accessor		:pausegame
	attr_accessor		:exitinggame
	attr_accessor		:exityes
	
	attr_accessor   :awardstyle,:spawnstyle
	attr_accessor   :tournamentgames,:tournamentwinner
	
	attr_accessor		:tour
	attr_accessor		:tourstopcurrent
	attr_accessor		:tourstoptotal
	attr_accessor   :tourstops;
	
	attr_accessor		:slowdownon
	attr_accessor		:slowdowncounter
	attr_accessor		:slowdownfreeze,:friendlyfire
	
	attr_accessor		:screencrunch;
	attr_accessor		:screenshaketimer;
	attr_accessor		:screenshakeplayerid;
	attr_accessor		:screenshaketeamid;
	attr_accessor		:screenshakekillinair;
	attr_accessor		:screenshakekillscount;
	
	attr_accessor   :toplayer
	
	attr_accessor		:loadedannouncer
	attr_accessor		:loadedmusic
	
	attr_accessor   :scoreboardstyle
	
	attr_accessor   :teamcolors
	
	attr_accessor   :spawninvincibility
	
	attr_accessor		:soundvolume
	attr_accessor		:musicvolume
	
	attr_accessor		:respawn
	attr_accessor		:itemrespawntime
	attr_accessor		:outofboundstime
	
	attr_accessor		:warplocks

	attr_accessor		:cputurn
	attr_accessor		:cpudifficulty
	
	attr_accessor		:fireballttl
	attr_accessor		:fireballlimit

	attr_accessor		:hammerdelay
	attr_accessor		:hammerttl
	attr_accessor		:hammerpower
	attr_accessor		:hammerlimit

	attr_accessor		:boomerangstyle
	attr_accessor		:boomeranglife
	attr_accessor		:boomeranglimit

	attr_accessor		:featherjumps
	attr_accessor		:featherlimit

	attr_accessor		:shellttl
	attr_accessor		:blueblockttl
	
	attr_accessor		:storedpowerupdelay
	attr_accessor		:bonuswheel
	attr_accessor		:keeppowerup

	attr_accessor		:showwinningcrown

	attr_accessor		:playnextmusic  #automatically advance to the next music track after one finishes

	attr_accessor		:soundcapable
	
	attr_accessor		:pointspeed
	
	attr_accessor		:swapstyle
	attr_accessor		:swapplayers
	attr_accessor		:swapplayersposition
	attr_accessor		:swapplayersblink
	attr_accessor		:swapplayersblinkcount
	
	attr_accessor		:secrets
	attr_accessor		:bosspeeking
	attr_accessor		:noexit
	attr_accessor		:enemyhammerkills
  
  attr_accessor   :pfFilters
  attr_accessor   :piFilterIcons
  attr_accessor   :fNeedWriteFilters
  
  attr_accessor   :powerupweights
  attr_accessor   :storedpowerups
  attr_accessor   :gamepowerups
  
  attr_accessor   :teamids
  attr_accessor   :teamcounts
  attr_accessor   :skinids
  attr_accessor   :colorids
  attr_accessor   :randomskin
  attr_accessor   :superboomerang
  
  attr_accessor   :inputConfiguration #[NumPlayers][Keyboard/Joystick]
  attr_accessor   :playerInput
  
  attr_accessor   :gamemode
  attr_accessor   :gamemodesettings
  
  
  attr_accessor :tournament
  
  attr_accessor :randomskin
  attr_accessor :screenfade
  attr_accessor :screenfadespeed
  
  attr_accessor :bulletbilltimer,:bulletbillhoming,:bulletbillspawntimer
  
  attr_accessor :teamdeadcounter
  attr_accessor :showscoreboard
  attr_accessor :scorepercentmove
  attr_accessor :playskidsound
  attr_accessor :playinvinciblesound
  attr_accessor :redkoopas
  attr_accessor :redthrowblocks
  attr_accessor :viewblocks
  
  attr_accessor :selectedmapfilter
  attr_accessor :fFiltersOn

  def initialize
    @playercontrol = Array.new(4,0)
    @randomskin = Array.new(4)
    #@powerupweights = Array.new(NUM_POWERUPS)
    #Poison, 1up, 2up, 3up, 5up, firepower, star, clock, bobomb, POW, Bullet Bill, hammer, Green Shell, Red Shell, Spiny Shell, Buzzy Shell, MOd, Feather
    @powerupweights = [5, 10, 4, 2, 1, 10, 8, 4, 4, 2, 2, 4, 8, 4, 2, 4, 2, 4, 5, 6]
    @storedpowerups = Array.new(4,-1)
    @gamepowerups = Array.new(4,-1)
    @teamids = []
    4.times do |i|
    	 @teamids[i] = []
    end
    
    
    @teamcounts = Array.new(4)
    @randomskin = Array.new(4, false)
    @superboomerang = Array.new(4,0)
    
    @skinids = Array.new(4)
    @colorids = Array.new(4)
    
    @inputConfiguration = Array.new(4, nil)
    4.times do |i|
    		@inputConfiguration[i] = [CInputPlayerControl.new,CInputPlayerControl.new]
    end
    @playerInput = CPlayerInput.new
    
    @gamemodesettings = GameModeSettings.new
    
    @screenfade = 0
    @screenfadespeed = 0
    
    @bulletbilltimer = []
    @bulletbillhoming = []
    @bulletbillspawntimer = []
    
    @cputurn = 0
    
    #@music = true #tmp
  end
  def music
    return true #tmp
  end
end