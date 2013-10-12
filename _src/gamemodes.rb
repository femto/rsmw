GAMEMODE_NUM_OPTIONS = 21
require 'gamemodes_type'
class SModeOption
  attr_accessor :szName,:iValue
end

class JailGameModeSettings

  attr_accessor :tagfree;			#Free jailed player by tagging on same team
  attr_accessor :timetofree;		#Time it takes for a jailed player to be freed
end

class CoinGameModeSettings

  attr_accessor :penalty;			#Player loses coin if stomped on
  attr_accessor :quantity;			#Number of coins to have on screen at one time
end

class StompGameModeSettings

  attr_accessor :rate;				#How fast they spawn
  attr_accessor :enemyweight;	#What ratio the powerups are chosen
  def initialize
    @enemyweight = Array.new(3)
  end
end

class FlagGameModeSettings

  attr_accessor :speed;			#How fast to move bases
  attr_accessor :touchreturn;		#Return to base if player touches their own flag
  attr_accessor :pointmove;			#Move base after point
  attr_accessor :autoreturn;		#Time to automatically return flag to base
  attr_accessor :homescore;			#Need your flag at home base to score
end

class ChickenGameModeSettings

  attr_accessor :usetarget;			#Display target around chicken
end

class TagGameModeSettings

  attr_accessor :tagontouch;		#Transfer tag on touch
end

class StarGameModeSettings

  attr_accessor :time;				#Time to get rid or keep star
  attr_accessor :shine;				#If we are playing shine mode vs. ztar mode
end

class DominationGameModeSettings

  attr_accessor :loseondeath;		#Player loses his bases on death
  attr_accessor :stealondeath;		#Killing player steals bases on death
  attr_accessor :relocateondeath;	#Owned bases relocate on player's death
  attr_accessor :relocationfrequency; #How fast the bases switch spots
  attr_accessor :quantity;			#Number of bases
end

class KingOfTheHillModeSettings

  attr_accessor :areasize;			#size of the hill area, 2x2, 3x3 etc.
  attr_accessor :relocationfrequency;  #How often the hill switches spots
end

class RaceGameModeSettings

  attr_accessor :quantity;			#How many race goals
  attr_accessor :speed;			#How fast goals move
  attr_accessor :penalty;			#If dead players lose all tagged, one tagged or none
end

class FrenzyGameModeSettings

  attr_accessor :quantity;			#How many powerups spawn
  attr_accessor :rate;				#How fast they spawn
  attr_accessor :storedshells;		#Shells become stored instead of active
  attr_accessor :powerupweight;	#What ratio the powerups are chosen
  def initialize
    @powerupweight = Array.new(12)
  end
end

class SurvivalGameModeSettings

  attr_accessor :enemyweight;       #The weighting of thwomps vs. podobos
  attr_accessor :density;				#Number of thwomps on screen
  attr_accessor :speed;				#How fast thwomps go
  attr_accessor :shield;				#Players are shielded when spawning
  def initialize
    @enemyweight = Array.new(3)
  end
end

class GameModeSettings

  attr_accessor :jail;
  attr_accessor :coins;
  attr_accessor :stomp;
  attr_accessor :flag;
  attr_accessor :chicken;
  attr_accessor :tag;
  attr_accessor :star;
  attr_accessor :domination;
  attr_accessor :kingofthehill;
  attr_accessor :race;
  attr_accessor :frenzy;
  attr_accessor :survival;
  def initialize
	
    @jail=JailGameModeSettings.new;
    @coins=CoinGameModeSettings.new;
    @stomp=StompGameModeSettings.new;
    @flag=FlagGameModeSettings.new;
    @chicken=ChickenGameModeSettings.new;
    @tag=TagGameModeSettings.new;
    @star=StarGameModeSettings.new;
    @domination=DominationGameModeSettings.new;
    @kingofthehill=KingOfTheHillModeSettings.new;
    @race=RaceGameModeSettings.new;
    @frenzy=FrenzyGameModeSettings.new;
    @survival=SurvivalGameModeSettings.new;

  end
end

class CGameMode
  attr_accessor :winningteam,:gameover
  attr_accessor :chicken,:tagged,:star,:frenzyowner
  attr_accessor :goal
  def initialize
    @winningteam = 0
    @modeOptions = []
    GAMEMODE_NUM_OPTIONS.times do |index|
      @modeOptions[index] = SModeOption.new
    end
    
  end
  def getgamemode
    @gamemode
  end
  def getModeName
    @szModeName
  end
  def getGoalName
    @szGoalName
  end
  attr_accessor :goal,:gamemode
  
  def SetupModeStrings(szMode, szGoal, iGoalSpacing)
    @szModeName = szMode
    @szGoalName = szGoal
    GAMEMODE_NUM_OPTIONS.times do |iMode|
      if(iMode == GAMEMODE_NUM_OPTIONS - 1)
        @modeOptions[iMode].iValue = -1;
        @modeOptions[iMode].szName = "Unlimited";
      else
        @modeOptions[iMode].iValue = (iMode + 1) * iGoalSpacing;
        @modeOptions[iMode].szName = @modeOptions[iMode].iValue.to_s;
      end  
    end
  end
  
  def getOptions
    return @modeOptions
  end
  
  def init
    if(@goal == 1000)
      @goal = 999; #Cap goal for 3 digit scoreboard
    end
    @chicken = nil; 
    @tagged = nil;
    @star = nil;
    @frenzyowner = nil;
	
    @winningteam = -1; 
    @gameover = false; 
    @playedwarningsound = false;
	
    $score_cnt.times do |iScore|
      $score[iScore].setScore(0);
    end
		
  end
  
  def draw
  end
  
  def getReverseScoring
    @fReverseScoring
  end
  
  def playerkilledplayer(inflictor, other)
    #Penalize killing your team mates
    if(!@gameover)
      if(inflictor.teamID == other.teamID)
        inflictor.score.adjustScore(-1);
      else
        inflictor.score.adjustScore(1);
      end
    end
	
    return false;
  end
  
  def playerkilledself(player)
    if(player.bobomb)
      player.diedas = 2; #flag to use bobomb corpse sprite
    end
    return false;
  end
  
  def playerextraguy(player, iType)
    if(!@gameover)
      player.score.adjustScore(iType);
    end
  end
  
  def displayplayertext
    if(@winningteam > -1)
      $list_players_cnt.times do |k|
        if($list_players[k].teamID == @winningteam)
          $list_players[k].spawnText("Winner!");
        end
      end
    end
  end
  
  def playwarningsound
    @playedwarningsound = true;
    ifsoundonstop($sfx_invinciblemusic);
    ifsoundonstop($sfx_bowserlaugh);
	  
    if($game_values.music && $game_values.sound)
      $backgroundmusic[0].stop();
    end
	
    ifsoundonplay($sfx_timewarning);
  end
  
end

class CGM_Classic < CGameMode
  def initialize
    super
    @goal = 10;
    @gamemode = game_mode_classic;
    SetupModeStrings("Classic", "Lives", 5);
  end
  def init
    super
    @fReverseScoring = goal == -1;
    $score_cnt.times do |iScore|
      if(@fReverseScoring)
        $score[iScore].setScore(0);
      else
        $score[iScore].setScore(goal);
      end
    end
  end
  
  def think
    if(@gameover)
      displayplayertext();
    else
      if(@goal > -1)
        #puts "game over is true"
        #@gameover = true
      end  
    end
  end
  
  def playerkilledplayer(inflictor, other)
    puts "checking"
    if(!@gameover)
      if(@fReverseScoring)
        other.score.adjustScore(1);
      else
        other.score.adjustScore(-1);
        if(!@playedwarningsound)
          countscore = 0;
          $score_cnt.times do |k|
            next if(inflictor.score == $score[k])
            
            countscore += $score[k].score;
          end
          if(countscore <= 2)
            playwarningsound();
          end
        end
        if(other.score.score <= 0)
          removeTeam(other.teamID);
          @winningteam = inflictor.teamID;
          @gameover = true;
          return true;
        end
      end
      return checkWinner(inflictor,other);
    end
    return false
  end
  
  def checkWinner(inflictor, other)
    if(@goal == -1)
      return false;
    end
	
    if(other.score.score <= 0)
      @winningteam = inflictor.teamID;
      @gameover = true;
	
      #removePlayersButTeam(winningteam);
      #SetupScoreBoard(false);
      #ShowScoreBoard();
      puts "game over is true"
      return true;
    end
		
	
    return false;
  end

  
end
def removeTeam(teamid)
  #If we have already removed this team then return
  if($score[teamid].order > -1)
    return;
  end
  #kill all players on the dead team
  $list_players_cnt.times do |iPlayer|
    if($list_players[iPlayer].teamID == teamid)
      $list_players[iPlayer].state = player_dead;
    end
  end
	
  $score[teamid].order = $game_values.teamdeadcounter;
  $game_values.teamdeadcounter += 1
end
class CGM_Frag < CGameMode
  def initialize
    super
    @goal = 20;
    @gamemode = game_mode_frag;
    SetupModeStrings("Frag Limit", "Kills", 5);
  end
end
class CGM_TimeLimit < CGameMode 
  def initialize
    super
    @goal = 60;
    @gamemode = game_mode_timelimit;
  
    SetupModeStrings("Time Limit", "Time", 30);
  
    @iFramesPerSecond = 1000 / WAITTIME;
  end
end
class CGM_Jail < CGM_Frag 
  def initialize
    super
    @gamemode = game_mode_jail;
    @goal = 20;
  
    @szModeName ="Jail";
  end
end
class CGM_Coins < CGameMode
  def initialize
    super
    @goal = 20;
    @gamemode = game_mode_coins;
  
    SetupModeStrings("Coin Collection", "Coins", 5);
  end 
end
class CGM_Stomp < CGameMode
  def initialize
    super
    @gamemode = game_mode_stomp;
    SetupModeStrings("Stomp", "Kills", 10);
  end
end
class CGM_Eggs < CGameMode
  def initialize
    super
    @goal = 20;
    @gamemode = game_mode_eggs;
  
    SetupModeStrings("Yoshis Eggs", "Eggs", 5);
  end 
end
class CGM_CaptureTheFlag < CGameMode
  def initialize
    super
    
    @goal = 20;
    @gamemode = game_mode_ctf;
  
    SetupModeStrings("Capture The Flag", "Flags", 5);
  end 
end
class CGM_Chicken < CGameMode 
  def initialize
    super
    
    @goal = 200;
    @gamemode = game_mode_chicken;
  
    SetupModeStrings("Chicken", "Points", 50);
  end
end
class CGM_Tag < CGameMode 
  def initialize
    super
    @goal = 200;
    @gamemode = game_mode_tag;
  
    SetupModeStrings("Tag", "Points", 50);
  end
end
class CGM_Star < CGameMode
  def initialize
    super
    @goal = 5;
    @gamemode = game_mode_star;
    SetupModeStrings("Star", "Lives", 1);
  end 
end
class CGM_Domination < CGameMode
  def initialize
    super
    @goal = 200;
    @gamemode = game_mode_domination;
  
    SetupModeStrings("Domination", "Points", 50);
  end 
end
class CGM_KingOfTheHill < CGameMode
  def initialize
    super
    
    @goal = 200;
    @gamemode = game_mode_koth;
  
    SetupModeStrings("King Of The Hill", "Points", 50);
    
  end 
end
class CGM_Race < CGameMode
  def initialize
    super
    @goal = 10;
    @gamemode = game_mode_race;
  
    SetupModeStrings("Race", "Laps", 5);
  end 
end
class CGM_Owned < CGameMode
  def initialize
    super
    @goal = 200;
    @gamemode = game_mode_owned;
  
    SetupModeStrings("Owned", "Points", 50);
  end 
end
class CGM_Frenzy < CGM_Frag
  def initialize
    super
    @gamemode = game_mode_frenzy;
    @szModeName = "Frenzy";
  end 
end
class CGM_Survival < CGM_Classic
  def initialize
    super
    @goal = 20;
    @gamemode = game_mode_survival;
  
    @szModeName = "Survival";
  end 
end

class CGM_Boss < CGameMode
  def initialize
    super
    @gamemode = game_mode_boss;
    SetupModeStrings("Boss", "Lives", 5);
    @iBossType = 0;
  end 
  def init
    super
    @enemytimer = rand(120) + 120;
    @poweruptimer = 120;
    
    $score_cnt.times do |iScore|
      $score[iScore].setScore(5);
    end
    
    $objectcollisionitems.add(MO_SledgeBrother.new($spr_sledgebrothers, (@iBossType == 0 ? 256 : (@iBossType == 1 ? 256 : 320)), @iBossType));
  end
  
  def think
    game_values = $game_values
    if(!@gameover && $list_players_cnt == 0)
      @gameover = true;
      if(game_values.music)
        ifsoundonstop($sfx_invinciblemusic);
        ifsoundonstop($sfx_timewarning);
        ifsoundonstop($sfx_slowdownmusic);
        ifsoundonplay($sfx_gameover);
				
        #$backgroundmusic[1].stop();
      end
    end
    
    if(@gameover)
      displayplayertext();
    else
      if(@iBossType == 0)
        #Randomly spawn koopas
        @enemytimer -= 1
        if(@enemytimer <= 0)
          $objectcollisionitems.add(MO_Koopa.new(game_values.redkoopas ? $spr_redkoopa : $spr_koopa, 2, 8, rand(2) == 0, 30, 28, 1, 25, game_values.redkoopas));
          @enemytimer = rand(120) + 120;
        end
      elsif(@iBossType == 1)
      elsif(@iBossType == 2)
        @enemytimer -= 1
        if(@enemytimer <= 0)
          $objectsfront.add(OMO_Podobo.new($spr_podobo, rand(608), -(rand(9) / 2.0) - 9.0, -1, -1, -1));
          @enemytimer = rand(80) + 60;
        end
         
        @poweruptimer -= 1
        if(@poweruptimer <= 0)
          @poweruptimer = rand(80) + 60;
          if($objectsplayer.countTypes(object_frenzycard) < $list_players_cnt)
            $objectsplayer.add(MO_FrenzyCard.new($spr_frenzycards, 12, 8, 0));
          end
        end
      end #end if iBosstype
    end
  end
  
  def draw
    if(@gameover)
      if(@winningteam > -1)
        $game_font_large.drawCentered(320, 96, "Congratulations!");
        
        if(@iBossType == 0)
          $game_font_large.drawCentered(320, 118, "The Powerful Sledge Hammer Is Yours");
        elsif(@iBossType == 1)
          game_font_large.drawCentered(320, 118, "The Super Bomb Is Yours");
        elsif(@iBossType == 2)
          game_font_large.drawCentered(320, 118, "The Golden Podobo Is Yours");
        end
      else
        $game_font_large.drawCentered(320, 96, "You Failed To Defeat");
        
        if(@iBossType == 0)
          $game_font_large.drawCentered(320, 118, "The Mighty Sledge Brother");
        elsif(@iBossType == 1)
          $game_font_large.drawCentered(320, 118, "The Mighty Bomb Brother");
        elsif(@iBossType == 2)
          $game_font_large.drawCentered(320, 118, "The Mighty Flame Brother");
        end
      end
    end
  end
  
  
  
  
end