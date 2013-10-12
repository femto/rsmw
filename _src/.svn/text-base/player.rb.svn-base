require 'mapaware'
def player_wait
  0
end
def  player_spawning
  1
end
def  player_dead
  2
end
def  player_ready
  3
end
def  player_entering_warp_up
  4
end
def  player_entering_warp_right
  5
end
def  player_entering_warp_down
  6
end
def  player_entering_warp_left
  7
end
def  player_exiting_warp_down
  8
end
def  player_exiting_warp_left
  9
end
def  player_exiting_warp_up
  10
end
def  player_exiting_warp_right
  11
end

def kill_style_stomp 
  0
end
def  kill_style_star 
  1
end
def  kill_style_fireball 
  2
end
def  kill_style_bobomb 
  3
end
def  kill_style_bounce 
  4
end
def  kill_style_pow 
  5
end
def  kill_style_goomba 
  6
end
def  kill_style_bulletbill 
  7
end
def  kill_style_hammer 
  8
end
def  kill_style_shell 
  9
end
def  kill_style_throwblock 
  10
end
def  kill_style_cheepcheep 
  11
end
def  kill_style_koopa 
  12
end
def  kill_style_boomerang 
  13
end
def  kill_style_feather 
  14
end

def award_style_none 
  0
end
def  award_style_fireworks 
  1
end
def  award_style_swirl 
  2
end
def  award_style_halo 
  3
end
def  award_style_souls 
  4
end
def  award_style_text 
  5
end




def death_style_jump
  0
end
def  death_style_squish
  1
end


class CPlayer
  attr_accessor :globalID,:teamID
  attr_accessor :invincible,:spawninvincible
  attr_accessor :inair,:onice
  attr_accessor :killsinrowinair
  attr_accessor :bobomb,:diedas,:ix,:iy
  attr_accessor :state
  attr_accessor :fOldX,:fOldY,:fx,:fy
  attr_accessor :score
  attr_accessor :velx,:vely
  attr_accessor :colorID,:tanooki,:fallthrough,:featherjump
  attr_accessor :ownerPlayerID,:ownerColorOffsetX
  attr_accessor :iSrcOffsetX
  attr_accessor :jailed
  attr_accessor :powerup
  attr_accessor :platform
  attr_accessor :fPrecalculatedY
  attr_accessor :iHorizontalPlatformCollision,:iVerticalPlatformCollision
  attr_accessor :carriedItem
  attr_accessor :statue_timer
  attr_accessor :superjumptimer
  include MapAware
  
  def pressedAcceptItemKey
    return @fPressedAcceptItem
  end
  def isAcceptingItem
    @fAcceptingItem
  end
  
  def enterwarp(warp)
	  game_values = $game_values
	  g_map = $g_map
		if(warp.direction == 0)
			@state = player_entering_warp_down;
			@vely = 0.0;
			@velx = 0.0;
		elsif(warp.direction == 1)
			@state = player_entering_warp_left;
			@vely = 0.0;
			@velx = -1.0;
		elsif(warp.direction == 2)
			@state = player_entering_warp_up;
			@vely = 0.0;
			@velx = 0.0;
		elsif(warp.direction == 3)
			@state = player_entering_warp_right;
			@vely = 0.0;
			@velx = 1.0;
		end
	
		@warpconnection = warp.connection;
		@warpid = warp.id;
	
		if(game_values.warplocks > 0)
			g_map.lockconnection(@warpconnection);
		end
	
		ifsoundonplay($sfx_pipe);
	end
  def initialize(iGlobalID, iLocalID, iTeamID, iSubTeamID, iColorID, nsprites, nscore, irespawn, ai)
    #tmp solution
    @globalID = iGlobalID;
    @localID = iLocalID;
    @teamID = iTeamID;
    @subTeamID = iSubTeamID;
    @colorID = iColorID;
    
    
	  
    #AI stuff
    @pPlayerAI = ai;
    if(@pPlayerAI)
      @pPlayerAI.setPlayer(self);
    end
    game_values = $game_values
    @playerKeys = game_values.playerInput.outputControls[iGlobalID];
    @playerDevice = game_values.playerInput.inputControls[@globalID].iDevice;
		
    @score = nscore;
		
    @spr = PGFX_JUMPING_R;
    @sprites = []
    PGFX_LAST.times do |i|
      @sprites[i] = nsprites[i]
    end
    #p @sprites
    @sprswitch = 0;
		
    @spawninvincible = false;
    @spawninvincibletimer = 0;
	  
    @carriedItem = nil
    @ownerPlayerID = -1
    @ownerColorOffsetX = 0
    @jailed = 0
	  
    @spawntext = 20;  #set it to 20 so there is an immediate text spawned upon winning
    @powerupused = -1;
	  
	  
    @respawn_index = irespawn #todo, here should be a pointer/updater
	  
    @boss_index = []
    setupNewPlayer();
    #@respawn[@globalID] = 0;
	  
    @fAcceptingItem = false; 
    @fPressedAcceptItem = false
	  
    @pSuicideCreditPlayer = nil
    @iSuicideCreditTimer = 0
	  
    @konamiIndex = 0
    @secret_spring_index = 0
    @secret_spike_index = 0
	  
    @state = player_ready
    
    @ix = 0
    @iy = 0
    @killsinrow = 0
    @killsinrowinair = 0
    
    @boss_index = [] #Array 3
    @konamiIndex = 0
    @superKickIndex = 0
    @homingBillsIndex = 0
    @homingBills = nil
    
    
    @super_hammer_throw_left_index = 0
    @super_hammer_throw_right_index = 0
    @shoot_right_super_hammer = false
    @shoot_left_super_hammer = false
    
    @super_sledge_hammer_throw_index = 0;
    @shoot_super_sledge_hammer = false;
	  
    @holddown = 0;
    @holddowntolerance = 0;
    @holdleft = 0;
    @holdlefttolerance = 0;
    @holdright = 0;
    @holdrighttolerance = 0;
		
    @super_boomerang_throw_index_left = 0;
    @super_boomerang_throw_index_right = 0;
    @shoot_super_boomerang = false;
		
    @ryu_fireball_index_left = 0;
    @ryu_fireball_index_right = 0;
    @shoot_left_fireball = false;
    @shoot_right_fireball = false;
		
    @dashLeftIndex = 0;
    @dashRightIndex = 0;
    @dashLeft = false;
    @dashRight = false;
    @dashSparkleAnimationTimer = 0;
		
    @super_pow_index = 0;
    @super_pow = false;
    @super_pow_timer = 0;
		
    @super_mod_index = 0;
    @super_mod = false;
    @super_mod_timer = 0;
		
    @redKoopaIndex = 0;
    @redThrowBlockIndex = 0;
    @viewBlockIndex = 0;
		
    @secret_spring_index = 0;
    @secret_spike_index = 0;
		
    @tanooki = false;
    @statue_lock = false;
    @statue_timer = 0
    
    @lockjump = false;		#is the player allowed to jump
    @lockfall = false;		#on PC verion, the down key makes player fall through solid_on_top tiles
    @lockfire = false;		#the player is allowed to shoot a fireball


    @superjumptimer = 0;		#this is true when a player is able to do a super jump off a note block
    @hammertimer = 0;		#Only allow the player to throw powerful hammers so fast
		
    @throw_star = 0;
		
    @pSuicideCreditPlayer = nil;
    @iSuicideCreditTimer = 0;
    
    @konamiIndex = 0
		
    @fNewSwapX = 0.0 
    @fNewSwapY = 0.0 #For moving players around during player swap effect
    @fOldSwapX = 0.0
    @fOldSwapY = 0.0
    @iSrcOffsetX = 0;
    #gfxSprite ** pScoreboardSprite;
		
    @animationstate = 0;
    @animationtimer = 0;
		
    @spawntimer = 0
    @spawnradius = 0.0;
    @spawnangle = 0.0;
    
    @powerupused = 0
    @powerupradius = 0.0
    @powerupangle = 0.0
		
    @afraid_hazard = true
    @can_enter_warp = true
    
  end
  
  def xf(xf)
    @fx = xf; @ix = @fx.to_i;
  end;
  def xi(xi)
    @ix = xi; @fx = @ix.to_f;
  end;
  def yf(yf)
    @fy = yf; @iy = @fy.to_i;
  end;
  def yi(yi)
    @iy = yi; @fy = @iy.to_f;
  end
  
  def killPlayerMapHazard
    if(@pSuicideCreditPlayer)
      playerKilledPlayer(@pSuicideCreditPlayer, self, death_style_jump, kill_style_bounce);
    else
      deathAwards();
			
      if(!$game_values.gamemode.playerkilledself(self))
        die(death_style_jump, false);
      end
    
      ifsoundonplay($sfx_deathsound);
    end
  end

  def killMapHazard()
    killPlayerMapHazard()
  end
  
  def collisionWidth
    PW
  end
  
  def collisionHeight
    PH
  end
  
  def halfCollisionWidth
    collisionWidth/2
  end
  
  def short_circuit_to_process_map_collision
    @state != player_ready
  end
  
  def bottomBounce
    GRAVITATION
  end
  
  def sideBounce
    @velx = 0 #clear velx when player hit right or hit left
  end
  
  def bounce
    GRAVITATION
  end
  
  def hittop
    #@vely = 0 #bottomBounce();
  end
  
  def hitbottom
    @vely = capFallingVelocity(-@vely * BOUNCESTRENGTH);
  end
  
  def hitright
    if(@velx < 0.0)
      @velx = 0.0;
    end
  end
  
  def hitleft
    if(@velx > 0.0)
      @velx = 0;
    end
  end
  
  def setupNewPlayer
    #@fx = @fy = @fOldX = @fOldY = 0
    @pScoreboardSprite = @sprites;
    findSpawnPoint();
    game_values = $game_values
    #collision_detection_checksides();
	
    @velx = 0.0;
    
    if(game_values.spawnstyle == 1)
      @vely = 0.0;
    else
      
      @vely = -(VELJUMP / 2);	#make the player jump up on respawn
      #@vely = 0.0
    end
    
    @fOldX = @fx;
    @fOldY = @fy;
	  
    @inair = true;
    @onice = false;
    @lockjump = true;
    @superjumptimer = 0;
    @powerup	= 0;
    @projectilelimit = 0;
    @bobomb = false;
    @hammertimer = 0;
		
    @tanooki = false;
    @statue_lock = false;
    @statue_timer = 0;
    
    #Only reset the tanooki index if it hasnt been triggered yet
    if(@konamiIndex != 11)
      @konamiIndex = 0;
    end
		
    #Only reset the secret spring index if it hasnt been triggered yet
    if(@secret_spring_index != 9)
      @secret_spring_index = 0;
    end
		
    if(@secret_spike_index != 6)
      @secret_spike_index = 0;
    end
		
    @superKickIndex = 0;

    @invincible = false;
    @invincibletimer = 0;
	  
    @animationstate = 0;
    @animationtimer = 0;
	  
    @killsinrow = 0;
    @killsinrowinair = 0;
    @awardangle = 0.0;
    @featherjump = 0;
    @holddown = 0;
    @holddowntolerance = 0;
    @holdleft = 0;
    @holdlefttolerance = 0;
    @holdright = 0;
    @holdrighttolerance = 0;
    @flying = false;
    @flyingtimer = 0;
		
    @ryu_fireball_index_left = 0;
    @ryu_fireball_index_right = 0;
    @shoot_left_fireball = false;
    @shoot_right_fireball = false;
		
    @super_hammer_throw_left_index = 0;
    @super_hammer_throw_right_index = 0;
    @shoot_left_super_hammer = false;
    @shoot_right_super_hammer = false;
		
    @super_bobomb_index = 0;
    @shoot_super_bobomb = false;
	  
    @super_sledge_hammer_throw_index = 0;
    @shoot_super_sledge_hammer = false;
	
    @super_boomerang_throw_index_left = 0;
    @super_boomerang_throw_index_right = 0;
    @shoot_super_boomerang = false;
		
    @super_pow_index = 0;
    @super_pow = false;
    @super_pow_timer = 0;
	
    @super_mod_index = 0;
    @super_mod = false;
    @super_mod_timer = 0;
		
    @dashLeftIndex = 0;
    @dashRightIndex = 0;
    @dashLeft = false;
    @dashRight = false;
    @dashSparkleAnimationTimer = 0;
	
    @homingBillsIndex = 0;
    @homingBills = false;
		
    @redKoopaIndex = 0;
    @redThrowBlockIndex = 0;
    @viewBlockIndex = 0;
	  
    3.times do |bossType|
      @boss_index[bossType] = 0;
    end
	  
    @iCapeTimer = 0;
    @iCapeFrameX = 0;
    @iCapeFrameY = 0;
    @fCapeUp = false;
    @iCapeYOffset = 0;
		
    @frictionslidetimer = 0;
    @bobombsmoketimer = 0;
	  
    @spawnangle = (rand(1000) * 0.00628);  #random new spawn angle
    @spawnradius = 100.0;
    @spawntimer = 0;
    @waittimer = 0;
		
    $respawncounter[@respawn_index] = game_values.respawn;
    @state = player_wait;
		
    @fallthrough = false;
    @diedas = 0;
    @iSrcOffsetX = 0;
	  
    @burnuptimer = 0;
    @burnupstarttimer = 0;
	  
    @outofarenatimer = 0;
    @outofarenadisplaytimer = game_values.outofboundstime - 1;
	  
    @warpcounter = 0;

    @powerupused = -1;
	  
    @platform = nil;
    @iHorizontalPlatformCollision = -1;
    @iVerticalPlatformCollision = -1;
	  
    if(game_values.gamemode.getgamemode() == game_mode_survival)
      if(game_values.gamemodesettings.survival.shield)
        if(game_values.spawninvincibility > 0)
          @spawninvincibletimer = game_values.spawninvincibility;
        else
          @spawninvincibletimer = 62;
        end
				
        @spawninvincible = true;
      end
    elsif (game_values.spawninvincibility > 0)
      @spawninvincibletimer = game_values.spawninvincibility;
      @spawninvincible = true;
    end
	  
    @throw_star = 0;
    
  end
  
  def findSpawnPoint
    @ix,@iy = $g_map.findspawnpoint(0, PW, PH, false);
    @fx = @ix;
    @fy = @iy;
  end
  
  def spawnText(szText)
    @spawntext += 1
    if(@spawntext >= 20)
      $eyecandyfront.add(EC_GravText.new($game_font_large, @ix + HALFPW, @iy, szText, -VELJUMP));
      @spawntext = 0;	#spawn text every 20 frames
    end
  end
  
  def deathAwards
    game_values = $game_values
    if(game_values.awardstyle == award_style_halo)
      explodeawards();
    elsif(game_values.awardstyle == award_style_souls && @killsinrow >= MINAWARDSNEEDED)
      $eyecandyfront.add(EC_SoulsAward.new($spr_awardsouls, $spr_awardsoulspawn, @ix + HALFPW, @iy + HALFPH, 60, 9.0, @killsinrow, @awards));
    end
  end

  def explodeawards
    if(@killsinrow < MINAWARDSNEEDED)
      return;
    end
    ifsoundonplay($sfx_cannon);
	
    numawards = (@killsinrow > MAXAWARDS ? MAXAWARDS : killsinrow);
    addangle = TWO_PI / numawards;
	
    numawards.times do |k|
      angle = k * addangle + @awardangle;
      cosangle = Math::cos(angle);
      sinangle = Math::sin(angle);
		
      awardx = @ix + HALFPW - 8 + (30.0 * cosangle);
      awardy = @iy + HALFPH - 8 + (30.0 * sinangle);
		
      awardvelx = 7.0 * cosangle;
      awardvely = 7.0 * sinangle;
		
      $eyecandyfront.add(EC_ExplodingAward.new($spr_awardsolid, awardx, awardy, awardvelx, awardvely, 30, @awards[k]));
		
    end
  end
  
  def die(deathStyle, fTeamRemoved)
    game_values = $game_values
    iDeathSprite = deathStyle == 0 ? PGFX_DEADFLYING : PGFX_DEAD;
    corpseSprite = @sprites[iDeathSprite];
    
    if(@diedas == 1 || game_values.gamemode.chicken == self)
      corpseSprite = $spr_chocobo[@colorID][iDeathSprite];
    elsif(diedas == 2 || @bobomb)
      corpseSprite = $spr_bobomb[@colorID][iDeathSprite];
    end
    
    if(deathStyle == 0)
      $eyecandyfront.add(EC_FallingObject.new(corpseSprite, @ix + HALFPW - 16, @iy + PH - 32, -VELTURBOJUMP, @iSrcOffsetX, 0, 32, 32));
    else
      $eyecandyback.add(EC_Corpse.new(corpseSprite, (@ix - PWOFFSET), (@iy+PH-32), @iSrcOffsetX));
    end
		
    if(@carriedItem)
      @carriedItem.drop();
      @carriedItem = nil;
    end
	  
    if(!fTeamRemoved)
      #       if(game_values.screencrunch)
      #         $y_shake += CRUNCHAMOUNT;
      #       end
      #       if($y_shake > CRUNCHMAX)
      #         $y_shake = CRUNCHMAX;
      #       end
      
      setupNewPlayer();
      
    end
  end
  
  def isready() 
    return @state == player_ready;
  end
  def isspawning() 
    return @state == player_spawning;
  end
  def iswarping() 
    return @state > player_ready; #all the warping state
  end
  def isdead() 
    return @state == player_dead;
  end
  def draw
    
    #Dont draw a player that is waiting to respawn
    if(@state == player_wait || @state == player_spawning || @state == player_dead)
      return;
    end
    game_values = $game_values
    #Draw player
    @pScoreboardSprite = @sprites;
    
    if (@statue_timer > 0)
      if (isready() && (@statue_timer < 50) && (@statue_timer / 3 % 2!=0))
                
        return;      
      end
      if(iswarping())
        $spr_statue.draw(@ix - PWOFFSET, @iy - 31, 0, 0, 32, 58, @state % 4, @warpplane);
      else
        $spr_statue.draw(@ix - PWOFFSET, @iy - 31);
      end
      return
    elsif(@bobomb) #draw him as bob-omb
      @pScoreboardSprite = $spr_bobomb[@colorID];
      #Add smoke to the top of the bomb
      @bobombsmoketimer += 1
      if(@bobombsmoketimer > 2 && (@velx != 0.0 || @vely != GRAVITATION) && @state == player_ready)
      	@bobombsmoketimer = 0;
        $eyecandyfront.add(EC_SingleAnimation.new($spr_bobombsmoke, @ix + HALFPH - 8, @iy - PHOFFSET - 8, 4, 4));
      end
    elsif($game_values.gamemode.chicken == self) #draw him as chicken
      @pScoreboardSprite = $spr_chocobo[@colorID];
    end
    
    if(@ownerPlayerID > -1)
      if(iswarping())
        $spr_ownedtags.draw(@ix - PWOFFSET - 8, @iy - PHOFFSET - 8, @ownerColorOffsetX, 0, 48, 48, @state % 4, @warpplane);
      else
        $spr_ownedtags.draw(@ix - PWOFFSET - 8, @iy - PHOFFSET - 8, @ownerColorOffsetX, 0, 48, 48);
      end
    end
    
    if(@powerup == 3)
      drawCape();
    end
	  
    if(@state > player_ready) #warping
      @pScoreboardSprite[@spr].draw(@ix - PWOFFSET, @iy - PHOFFSET, @iSrcOffsetX, 0, 32, 32, @state % 4, @warpplane);
    else
      @pScoreboardSprite[@spr].draw(@ix - PWOFFSET, @iy - PHOFFSET, @iSrcOffsetX, 0, 32, 32);
    end
		
    #Draw the crown on the player
    if(game_values.showwinningcrown && $g_iWinningPlayer == @teamID)
      $spr_crown.draw(@ix + HALFPW - (isPlayerFacingRight() ? 4 : 10), @iy - 10);
    end
    if(@state < player_ready)
      return;
    end
	  
    if(@jailed > 0)
      if(@state > player_ready) #warping
        $spr_jail.draw(@ix - PWOFFSET - 6, @iy - PHOFFSET - 6, 0, 0, 44, 44, @state % 4, @warpplane);
      else
        $spr_jail.draw(@ix - PWOFFSET - 6, @iy - PHOFFSET - 6);
      end
    end
	  
    #Draw the Ring awards
    if(game_values.awardstyle == award_style_halo && @killsinrow >= MINAWARDSNEEDED)
      @awardangle += 0.02;
      if(@awardangle > TWO_PI)
        @awardangle -= TWO_PI;
      end
			
      numawards = (killsinrow > MAXAWARDS ? MAXAWARDS : @killsinrow);
      addangle = TWO_PI / numawards;
		  
      xoffset = @ix + HALFPW - 8;
      yoffset = @iy + HALFPH - 8;
		  
      numawards.times do |k|
        angle = k * addangle + @awardangle;
        awardx = xoffset + (30.0 * Math::cos(angle));
        awardy = yoffset + (30.0 * Math::sin(angle));
			  
        if(@state > player_ready) #warping
          $spr_award.draw(awardx, awardy, @awards[k] * 16, 0, 16, 16, @state % 4, @warpplane);
        else
          $spr_award.draw(awardx, awardy, @awards[k] * 16, 0, 16, 16);
        end
      end
    end
	  
    #Draw the powerup ring when a powerup is being used
    if(@powerupused > -1)
      numeyecandy = 8;
      addangle = TWO_PI / numeyecandy;
      displayangle = @powerupangle;
		  
      numeyecandy.times do |k|
        powerupX = @ix + HALFPW - 8 + (@powerupradius * Math::cos(displayangle));
        powerupY = @iy + HALFPH - 8 + (@powerupradius * Math::sin(displayangle));
	
        displayangle += addangle;
				
        if(@state > player_ready) #warping
          $spr_storedpowerupsmall.draw(powerupX, powerupY, @powerupused * 16, 0, 16, 16, @state %4, @warpplane);
        else
          $spr_storedpowerupsmall.draw(powerupX, powerupY, @powerupused * 16, 0, 16, 16);
        end
      end
    end
	  
    if((@dashLeft && @velx < -VELDASHMOVING + 1) || (@dashRight && @velx > VELDASHMOVING - 1))
      @dashSparkleAnimationTimer += 1
      if(@dashSparkleAnimationTimer > 2)
        @dashSparkleAnimationTimer = 0;
        $eyecandyfront.add(EC_SingleAnimation.new($spr_coinsparkle, @ix + HALFPW - 16, @iy + HALFPH - 16, 7, 4));
      end
    end
  end
  
  def drawCape
    
    @iCapeTimer += 1
    if(@iCapeTimer > 3)
      if((!@inair && @velx != 0.0) || (@inair && @vely < 1.0))
      	@iCapeFrameX += 32;
        if(@iCapeFrameX > 96)
          @iCapeFrameX = 0;
        end
	
        @iCapeFrameY = 0;
        @fCapeUp = true;
        @iCapeYOffset = 0;
      elsif(!@inair)
        if(@fCapeUp)
          @fCapeUp = false;
          @iCapeFrameX = 0;
        else
          @iCapeFrameX = 32;
        end
	
        @iCapeFrameY = 96;
        @iCapeYOffset = 0;
      elsif(@inair)
        @iCapeFrameX += 32;
        if(@iCapeFrameX > 64)
          @iCapeFrameX = 0;
        end
	
        @iCapeFrameY = 64;
        @fCapeUp = true;
        @iCapeYOffset = -18;
      end
      @iCapeTimer = 0;
    end
    fPlayerFacingRight = isPlayerFacingRight();
    if(iswarping())
      $spr_cape.draw(@ix - PWOFFSET + (fPlayerFacingRight ? - 18 : 18), @iy - PHOFFSET + 4 + @iCapeYOffset, 0 + (fPlayerFacingRight ? 128 : 0) + @iCapeFrameX, @iCapeFrameY, 32, 32, @state %4, @warpplane);
    else
      $spr_cape.draw(@ix - PWOFFSET + (fPlayerFacingRight ? - 18 : 18), @iy - PHOFFSET + 4 + @iCapeYOffset, 0 + (fPlayerFacingRight ? 128 : 0) + @iCapeFrameX, @iCapeFrameY, 32, 32);
    end
  end
  
  def drawarrows
    if(@iy < 0)
      if(@iy + PH < -1 || (@iy + PH <= 0 && @vely <= 1))
        $spr_abovearrows.draw(@ix - PWOFFSET, 0, @colorID * 32, 0, 32, 26);
	
        #This displays the out of arena timer before the player is killed
        if($game_values.outofboundstime > 0)
          $spr_awardkillsinrow[@colorID].draw(@ix - PWOFFSET + 8, 18, @outofarenadisplaytimer * 16, 0, 16, 16);
        end
      end
    end
  end
  def updateswap
    if(@state != player_ready)
      return;
    end
    if($game_values.swapstyle == 1)
      xf(game_values.swapplayersblink ? fOldSwapX : fNewSwapX);
      yf(game_values.swapplayersblink ? fOldSwapY : fNewSwapY);
    else
      xf(((fNewSwapX - fOldSwapX) * game_values.swapplayersposition) + fOldSwapX);
      yf(((fNewSwapY - fOldSwapY) * game_values.swapplayersposition) + fOldSwapY);
    end
    #if(@carriedItem)
    #  @carriedItem.moveToOwner();
    #end
  end
  
  def move
    game_values = $game_values
    if(@invincible)
      game_values.playinvinciblesound = true;
    end
		
    keymask =
      (@playerKeys.game_jump.fDown ? 1:0) |
    (@playerKeys.game_down.fDown ? 2:0) |
    (@playerKeys.game_left.fDown ? 4:0) |
    (@playerKeys.game_right.fDown ? 8:0) |
    (@playerKeys.game_turbo.fDown ? 16:0) |
    (@playerKeys.game_powerup.fDown ? 32:0);
		
    if(game_values.secrets && keymask!=0)
      3.times do |bossType|
        if(game_values.bosspeeking == bossType)
          boss_code = [ [2,1,4,8,16,16,32],
            [1,1,4,8,2,2,32],
            [4,8,4,8,16,16,0] ];
          boss_code_length = [7, 7, 6];
				  
          if (keymask & boss_code[bossType][boss_index[bossType]]) 
            @boss_index[bossType]+=1;
          elsif (keymask & ~boss_code[bossType][boss_index[bossType]]) 
            @boss_index[bossType] = 0;
          end
					
          if (@boss_index[bossType] == boss_code_length[bossType])
            @boss_index[bossType] = 0;
            #enterBossMode(bossType);
          end
        else
          @boss_index[bossType] = 0;  
        end
      end
      if(@konamiIndex < 11)
        konami_code = [1,1,2,2,4,8,4,8,48,48,48]
        
        if (keymask & konami_code[@konamiIndex]) 
          @konamiIndex+=1;
        elsif (keymask & ~konami_code[@konamiIndex]) 
          @konamiIndex = 0;
        end
        if (@konamiIndex == 11)
          #ifsoundonplay($sfx_transform); 
          $g_tanookiFlag+=1; 
        end
      end
      #Super kick shells and BTBs
      if(keymask & 2)
        @superKickIndex+=1;
      elsif(keymask & ~2)
        @superKickIndex = 0;
      end
			
      #Homing bullet bills
      if (game_values.gamepowerups[@globalID] == 10 && @homingBillsIndex < 4)
        homingBillsCode = [16, 16, 16, 32]
        if (keymask & homingBillsCode[@homingBillsIndex]) 
          @homingBillsIndex+=1;
        elsif (keymask & ~homingBillsCode[@homingBillsIndex]) 
          @homingBillsIndex = 0;
        end
				
        if (@homingBillsIndex == 4)
          @homingBillsIndex = 0;
          #ifsoundonplay($sfx_transform); 
          @homingBills = true;
        end
			  
      end
      if(game_values.gamepowerups[@globalID] != 10 && @powerupused != 10)
        @homingBills = false;
      end
			
      if (@powerup == 2)
        super_hammer_throw_code_left = [8, 8, 4, 16];
        if (keymask & super_hammer_throw_code_left[@super_hammer_throw_left_index]) 
          @super_hammer_throw_left_index+=1;
        elsif (keymask & ~super_hammer_throw_code_left[@super_hammer_throw_left_index])
          @super_hammer_throw_left_index = 0;
        end
				
        if (@super_hammer_throw_left_index >= 4)
          @super_hammer_throw_left_index = 0;
          @shoot_left_super_hammer = true;
        end
				
        super_hammer_throw_code_right = [4, 4, 8, 16];
        if (keymask & super_hammer_throw_code_right[@super_hammer_throw_right_index]) 
          @super_hammer_throw_right_index+=1;
        elsif (keymask & ~super_hammer_throw_code_right[@super_hammer_throw_right_index])
          @super_hammer_throw_right_index = 0;
        end
				
        if (@super_hammer_throw_right_index >= 4)
          @super_hammer_throw_right_index = 0;
          @shoot_right_super_hammer = true;
        end
      else
        @super_hammer_throw_left_index = 0;
        @super_hammer_throw_right_index = 0;
	
        @shoot_left_super_hammer = false;
        @shoot_right_super_hammer = false;	
      end
		  
      if (@powerup == 5)
        super_sledge_hammer_throw_code = [2, 2, 16];
        if (keymask & super_sledge_hammer_throw_code[super_sledge_hammer_throw_index]) 
          @super_sledge_hammer_throw_index+=1;
        elsif (keymask & ~super_sledge_hammer_throw_code[super_sledge_hammer_throw_index])
          @super_sledge_hammer_throw_index = 0;
        end
        if (@super_sledge_hammer_throw_index >= 3)
          @super_sledge_hammer_throw_index = 0;
          @shoot_super_sledge_hammer = true;
        end
      else
        @super_sledge_hammer_throw_index = 0;
        @shoot_super_sledge_hammer = false;
      end
		  
      if (@powerup == 4)
        if(@playerKeys.game_left.fDown)
          @holdleft+=1;
          @holdlefttolerance = 0;
        elsif(@holdleft >= 60 && @holdlefttolerance < 15)
          @holdlefttolerance+=1;
        else
          @holdleft = 0;
          @holdlefttolerance = 0;
          @super_boomerang_throw_index_right = 0;
        end
		    
        if(@playerKeys.game_right.fDown)
          @holdright+=1;
          @holdrighttolerance = 0;
        elsif(holdright >= 60 && holdrighttolerance < 15)
          @holdrighttolerance+=1;
        else
          @holdright = 0;
          @holdrighttolerance = 0;
          @super_boomerang_throw_index_left = 0;
        end
				
        if(@holdleft >= 60)
          super_boomerang_throw_code_right = [8, 16];
			    
          if (keymask & super_boomerang_throw_code_right[@super_boomerang_throw_index_right]) 
            @super_boomerang_throw_index_right+=1;
          elsif (keymask & ~super_boomerang_throw_code_right[@super_boomerang_throw_index_right])
            @super_boomerang_throw_index_right = 0;
          end
					
          if (@super_boomerang_throw_index_right >= 2)
            @super_boomerang_throw_index_right = 0;
            @shoot_super_boomerang = true;
          end
        end
				
        if(holdright >= 60)
          super_boomerang_throw_code_left = [4, 16];
			    
          if (keymask & super_boomerang_throw_code_left[@super_boomerang_throw_index_left]) 
            @super_boomerang_throw_index_left+=1;
          elsif (keymask & ~super_boomerang_throw_code_left[@super_boomerang_throw_index_left])
            @super_boomerang_throw_index_left = 0;
          end
					
          if (@super_boomerang_throw_index_left >= 2)
            @super_boomerang_throw_index_left = 0;
            @shoot_super_boomerang = true;
          end
        end
      else
        @holdleft = 0;
        @holdlefttolerance = 0;
				
        @holdright = 0;
        @holdrighttolerance = 0;
	
        @super_boomerang_throw_index_left = 0;
        @super_boomerang_throw_index_right = 0;
	
        @shoot_super_boomerang = false;
      end
		  
      if (@bobomb)
        super_bobomb_code = [4, 8, 4, 8, 2, 2, 16];
        if (keymask & super_bobomb_code[@super_bobomb_index]) 
          @super_bobomb_index+=1;
        elsif (keymask & ~super_bobomb_code[@super_bobomb_index])
          @super_bobomb_index = 0;
        end
				
        if (@super_bobomb_index >= 7)
          @super_bobomb_index = 0;
          @shoot_super_bobomb = true;
        end
      else
        @super_bobomb_index = 0;
        @shoot_super_bobomb = false;
      end
		  
      if(game_values.superboomerang[@globalID] == 1)
        if(keymask & 16)
          game_values.superboomerang[@globalID] = 2;
        end
      end
		  
      #Fly using feather
      if(@playerKeys.game_down.fDown)
        @holddown+=1;
        @holddowntolerance = 0;
      elsif(@holddown >= 120 && @holddowntolerance < 15)
        @holddowntolerance+=1;
      else
        @holddown = 0;
        @holddowntolerance = 0;
      end
		  
      #repeat again?
      keymaskdown =
        (@playerKeys.game_jump.fDown ? 1 : 0) |
      (@playerKeys.game_down.fDown ? 2 : 0) |
      (@playerKeys.game_left.fDown ? 4:0) |
      (@playerKeys.game_right.fDown ? 8:0) |
      (@playerKeys.game_turbo.fDown ? 16:0) |
      (@playerKeys.game_powerup.fDown ? 32:0);
      if(@powerup == 1)
        ryu_fireball_code_left = [2,6,4,20];
        if (keymaskdown == ryu_fireball_code_left[@ryu_fireball_index_left])
          @ryu_fireball_index_left+=1;
        elsif(@ryu_fireball_index_left > 0 && keymaskdown == ryu_fireball_code_left[@ryu_fireball_index_left - 1])
				  
        else
          @ryu_fireball_index_left = 0;
        end
	      
        if (@ryu_fireball_index_left >= 4)
          @ryu_fireball_index_left = 0;
          @shoot_left_fireball = true;
        end
	      
        ryu_fireball_code_right= [2,10,8,24];
        if (keymaskdown == ryu_fireball_code_right[@ryu_fireball_index_right])
          @ryu_fireball_index_right+=1;
        elsif(@ryu_fireball_index_right > 0 && keymaskdown == ryu_fireball_code_right[@ryu_fireball_index_right - 1])
				  
        else
          @ryu_fireball_index_right = 0;
        end
				
        if (@ryu_fireball_index_right >= 4)
          @ryu_fireball_index_right = 0;
          @shoot_right_fireball = true;
        end
      else
        @shoot_left_fireball = false;
        @shoot_right_fireball = false;
	
        @ryu_fireball_index_left = 0;
        @ryu_fireball_index_right = 0;
      end
      
      #@shoot_left_fireball = true;
		  #@shoot_right_fireball = true;	
		  
      if(@invincible)
        if(keymask & 4)
          @dashLeftIndex+=1;
        elsif(keymask & ~4)
          @dashLeftIndex = 0;
        end
				
        if(@dashLeftIndex >= 3 && keymaskdown == 20)
          @dashLeftIndex = 0;
          @dashLeft = true;
        end
				
        if(keymaskdown != 20)
          @dashLeft = false;
        end
			  
        if(keymask & 8)
          @dashRightIndex+=1;
        elsif(keymask & ~8)
          @dashRightIndex = 0;
        end

        if(@dashRightIndex >= 3 && keymaskdown == 24)
          @dashRightIndex = 0;
          @dashRight = true;
        end
				
        if(keymaskdown != 24)
          @dashRight = false;
        end
      else
        @dashLeft = false;
        @dashRight = false;
      end	
			
      if(@super_pow && (game_values.screenshaketimer > 0 || @powerupused == 9))
        if(game_values.screenshaketimer > 0)
          @super_pow_timer += 1
          if(@super_pow_timer >= 60)
            game_values.screenshaketimer = 0;
            @super_pow_timer = 0;
            @super_pow = false;
          end
          if(keymask & 16)
            game_values.screenshaketimer += 10;
					
            #IO_Block * block = $objectblocks.getRandomObject();
	
            #if(block)
            #	block->triggerBehavior();
            #end
          end
        end
      else
        @super_pow = false;
        @super_pow_timer = 0;
      end
			
      if(@super_mod && (game_values.screenshaketimer > 0 || @powerupused == 16))
        if(game_values.screenshaketimer > 0)
          @super_mod_timer += 1
          if(@super_mod_timer >= 60)
            game_values.screenshaketimer = 0;
            @super_mod_timer = 0;
            @super_mod = false;
          end
					
          if(keymask & 16)
            game_values.screenshaketimer += 10;
						
            #IO_Block * block = (IO_Block*)objectblocks.getRandomObject();
	
            #if(block)
            #	block->triggerBehavior();
            #end
          end
        end
      else
        @super_mod = false;
        @super_mod_timer = 0;
      end
		  
      #Super Pow
      if (game_values.gamepowerups[@globalID] == 9)
        super_pow_code = [2, 2, 32];
        if (keymask & super_pow_code[@super_pow_index]) 
          @super_pow_index+=1;
        elsif (keymask & ~super_pow_code[@super_pow_index]) 
          @super_pow_index = 0;
        end
				
        if (@super_pow_index >= 3)
          @super_pow_index = 0;
          #ifsoundonplay($sfx_transform); 
          @super_pow = true;
        end
      end
		  
      #Super Mod
      if (game_values.gamepowerups[@globalID] == 16)
        super_mod_code = [1, 1, 32];
		        
        if (keymask & super_mod_code[@super_mod_index]) 
          @super_mod_index+=1;
        elsif (keymask & ~super_mod_code[@super_mod_index]) 
          @super_mod_index = 0;
        end
		        
        if (@super_mod_index >= 3)
          @super_mod_index = 0;
          #ifsoundonplay($sfx_transform); 
          @super_mod = true;
        end
      end
  		
      if(game_values.gamemode.gamemode == game_mode_stomp && !game_values.redkoopas)
        if (redKoopaIndex < 7)
          red_koopa_code = [2,2,4,2,8,2,1];
          if (keymask & red_koopa_code[@redKoopaIndex]) 
            @redKoopaIndex+=1;
          elsif (keymask & ~red_koopa_code[@redKoopaIndex]) 
            @redKoopaIndex = 0;
          end
					
          if (@redKoopaIndex == 7)
            #ifsoundonplay($sfx_transform); 
            game_values.redkoopas = true; 
          end
        end
      end
  	  
      if(!game_values.redthrowblocks)
        if (@redThrowBlockIndex < 8)
          red_throw_block_code = [1,2,1,2,8,4,1,2];
          if (keymask & red_throw_block_code[@redThrowBlockIndex] != 0) 
            @redThrowBlockIndex+=1;
          elsif (keymask & ~red_throw_block_code[@redThrowBlockIndex] !=0) 
            @redThrowBlockIndex = 0;
          end	
					
          if (@redThrowBlockIndex == 8)
            #ifsoundonplay($sfx_transform); 
            game_values.redthrowblocks = true;
	
            #$objectblocks.each do |x|
            #	if(x.getBlockType() == block_throw)
            #	{
            #		((B_ThrowBlock*)objectblocks.list[iBlock])->SetType(true);
            #	}
            #end
          end
					
					
        end
      end
  	  
      if(!game_values.viewblocks)
        if (@viewBlockIndex < 7)
          view_block_code = [8,2,4,2,1,1,1];
          if (keymask & view_block_code[@viewBlockIndex]) 
            @viewBlockIndex+=1;
          elsif (keymask & ~view_block_code[@viewBlockIndex]) 
            @viewBlockIndex = 0;
          end
  	      
        end
        if (@viewBlockIndex == 7)
          #ifsoundonplay($sfx_transform); 
          game_values.viewblocks = true;

          $objectblocks.each do |block|
						
            # 						if(block->getBlockType() == block_powerup)
            # 						{
            # 							block->dead = true;
            # 							B_ViewBlock * viewBlock = new B_ViewBlock(&spr_viewblock, block->col * TILESIZE, block->row * TILESIZE);
            # 							
            # 							if(block->state != 0)
            # 							{
            # 								viewBlock->state = 3;
            # 								viewBlock->timer = ((B_PowerupBlock*)block)->timer;
            # 							}
            # 
            # 							g_map.blockdata[block->col][block->row] = viewBlock;
            # 							objectblocks.add(viewBlock);
            # 						}
          end
        end
  	    
        if (@secret_spring_index < 9)
          secret_spring_code = [2,1,2,1,2,1,2,2,16];
	        
          if (keymask & secret_spring_code[@secret_spring_index]) 
            @secret_spring_index+=1;
          elsif (keymask & ~secret_spring_code[@secret_spring_index]) 
            @secret_spring_index = 0;
          end
			          
          if (@secret_spring_index == 9)
            #ifsoundonplay($sfx_transform); 
            #$objectsplayer.add(CO_Spring.new(&spr_spring));
          end
        end
  	    
        if (@secret_spike_index < 6)
          secret_spike_code = [16,2,4,8,1,16];
	        
          if (keymask & secret_spike_code[@secret_spike_index]) 
            @secret_spike_index+=1;
          elsif (keymask & ~secret_spike_code[@secret_spike_index]) 
            @secret_spike_index = 0;
			        
            if (@secret_spike_index == 6)
              #ifsoundonplay($sfx_transform); 
              #$objectsplayer.add(CO_Spike.new($spr_spike));
            end
          end
        end
  	  
  	  
      end
    end
    if (@tanooki && @state == player_ready)
      # If the down key is ever released, manually untransform by releasing the down key
      if (!@playerKeys.game_down.fDown && @statue_timer != 0)
        # Untransform from statue
        @statue_timer = 1;
            
      elsif (@playerKeys.game_turbo.fPressed && playerKeys.game_down.fDown && !@statue_lock && !@lockfire && @powerupused == -1)
        # Become the tanooki
        # set the amount of time you get to remain in statue form
        @statue_timer = 123;
        # perform tansformation effects
        #$eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + (HALFPW) - 16, @iy + (HALFPH) - 16, 3, 8));
        #ifsoundonplay($sfx_transform);
            
        # Neutralize lateral velocity
        tv = 1.6;
        if (@velx > tv) 
          @velx = tv;
        elsif (@velx < -tv) 
          @velx = -tv;
        end
            
        # Prevent you from shooting
        @lockfire = true;
			
        # Prevent you from falling through solid-on-top blocks
        @lockfall = true;
			
        # Prevent you from becoming the statue twice before touching the ground
        @statue_lock = true;
        
      end
        
      # Count down the statue timer, which leads to a forced detransformation
      if (@statue_timer == 1)
        # Untransform from statue
        @statue_timer = 0;
          
        # Release invincibility
        @spawninvincible = false;
          
        # Slight upward velocity to escape spikes  lava
        if(!@inair)
          @vely = -8.0;
        end
				  
        # perform transformation effects
        #$eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + (HALFPW) - 16, @iy + (HALFPH) - 16, 3, 8));
        #ifsoundonplay($sfx_transform);

        @statue_lock = false;
			    
      elsif (@statue_timer > 0)
        # Prevent player from shooting while a statue
        @lockfire = true;
          
        # Prevent player from jumping
        @lockjump = true;
          
        # Don't fall through passable platforms
        @fallthrough = false;
          
        # Decrement statue timer
        @statue_timer-=1;
          
        # Become invincible
        @spawninvincible = true;

        @statue_lock = true;
      end
        
    end
		
    if(@hammertimer > 0)
      @hammertimer-=1;
    end
	  
    if(@throw_star > 0)
      @throw_star-=1;
    end
	  
    if(@pSuicideCreditPlayer)
      @iSuicideCreditTimer -= 1
      if(@iSuicideCreditTimer <= 0)
        @iSuicideCreditTimer = 0;
        @pSuicideCreditPlayer = nil;
      end
    end
		
    @iSrcOffsetX = 0;
		
    if(@invincible)
      @iSrcOffsetX = @animationstate;
    elsif(game_values.gamemode.tagged == self)
      @iSrcOffsetX = 160;
    elsif(game_values.gamemode.star == self)
      @iSrcOffsetX = game_values.gamemodesettings.star.shine ? 224 : 192;
    elsif(game_values.slowdownfreeze && game_values.slowdownon != @teamID)
      @iSrcOffsetX = 256;
    elsif(spawninvincible)
      @iSrcOffsetX = 128;
    end
		
    if(@state != player_ready)
      if(@state == player_wait)
        #use 31 frames to do 0.5 second increments
        @waittimer += 1
        if($respawncounter[@respawn_index] > 0 && @waittimer >= 31)
          @waittimer = 0;
          $respawncounter[@respawn_index]-=1;
        end
			  
        if($respawncounter[@respawn_index] <= 0)
          $respawncounter[@respawn_index] = 0
          @state = player_spawning;
          if(game_values.spawnstyle == 0)
            $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
          elsif(game_values.spawnstyle == 1)
            $eyecandyback.add(EC_Door.new($spr_spawndoor[@colorID], @sprites[@spr], @ix + HALFPW - 16, @iy + HALFPH - 16, 1, @iSrcOffsetX));
          end
        end
        return  
      end #end if player_wait
		  
      if(@state == player_spawning)
        if(game_values.spawnstyle == 0)
          @state = player_ready;
        elsif(game_values.spawnstyle == 1)
          #Wait for door eyecandy to open to let mario out (20 frames for door to appear and 16 frames to open)
          @spawntimer += 1
          if(@spawntimer > 36)
            @spawntimer = 0;
            @state = player_ready;
          end
        elsif(game_values.spawnstyle == 2)
          @spawnradius -= 2.0;
          @spawnangle += 0.05;
				  
          if(@spawnradius < 0.0)
            @state = player_ready;
          end
          @spawntimer += 1
          if(@spawntimer > 1)
            @spawntimer = 0;
				    
            ix1 = @ix - PWOFFSET + (@spawnradius * Math::cos(@spawnangle));
            iy1 = @iy - PHOFFSET + (@spawnradius * Math::sin(@spawnangle));
							
            ix2 = @ix - PWOFFSET + (@spawnradius * Math::cos(@spawnangle + HALF_PI));
            iy2 = @iy - PHOFFSET + (@spawnradius * Math::sin(@spawnangle + HALF_PI));
	
            ix3 = @ix - PWOFFSET + (@spawnradius * Math::cos(@spawnangle + PI));
            iy3 = @iy - PHOFFSET + (@spawnradius * Math::sin(@spawnangle + PI));
	
            ix4 = @ix - PWOFFSET + (@spawnradius * Math::cos(@spawnangle + THREE_HALF_PI));
            iy4 = @iy - PHOFFSET + (@spawnradius * Math::sin(@spawnangle + THREE_HALF_PI));
						 
            $eyecandyfront.add(EC_SingleAnimation.new($spr_spawnsmoke[@colorID], ix1, iy1, 4, 4));
            $eyecandyfront.add(EC_SingleAnimation.new($spr_spawnsmoke[@colorID], ix2, iy2, 4, 4));
            $eyecandyfront.add(EC_SingleAnimation.new($spr_spawnsmoke[@colorID], ix3, iy3, 4, 4));
            $eyecandyfront.add(EC_SingleAnimation.new($spr_spawnsmoke[@colorID], ix4, iy4, 4, 4));
          end
        end
      elsif(iswarping())
        @fOldY = @fy;
        @fOldX = @fx;
				
        if(state == player_entering_warp_left)
          xi(@ix - 1);
          increasewarpcounter(PW + PWOFFSET);
        elsif(state == player_entering_warp_right)
          xi(@ix + 1);
          increasewarpcounter(PW + PWOFFSET);
        elsif(state == player_entering_warp_up)
          yi(@iy - 1);
          increasewarpcounter(TILESIZE - PHOFFSET);
        elsif(state == player_entering_warp_down)
          yi(@iy + 1);
          increasewarpcounter(PH + PHOFFSET);
        elsif(state == player_exiting_warp_left)
          xi(@ix - 1);
          decreasewarpcounter();
        elsif(state == player_exiting_warp_right)
          xi(@ix + 1);
          decreasewarpcounter();
        elsif(state == player_exiting_warp_up)
          yi(@iy - 1);
          decreasewarpcounter();
        elsif(state == player_exiting_warp_down)
          yi(@iy + 1);
          decreasewarpcounter();
        end
			  
      end #end iswarping()
    elsif(@powerupused > -1)  
      @powerupradius -= game_values.storedpowerupdelay / 2.0;
      @powerupangle += 0.05;
      if(@powerupradius < 0.0)
        case(@powerupused)
        when 1,2,3
          game_values.gamemode.playerextraguy(self, @powerupused);
          ifsoundonplay($sfx_extraguysound);
        when 4
          game_values.gamemode.playerextraguy(self, 5);
          ifsoundonplay($sfx_extraguysound);
        when 5
          @powerup = 0;
          setPowerup(1);
        when 6
          makeinvincible();	
        when 7
          turnslowdownon(@holddown > 310);  
        when 8
          $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
          #ifsoundonplay($sfx_transform);
          @bobomb = true;
        when 9
          ifsoundonplay($sfx_thunder);
          game_values.screenshaketimer = 20;
          game_values.screenshakeplayerid = @globalID;
          game_values.screenshaketeamid = @teamID;
          game_values.screenshakekillinair = false;
          game_values.screenshakekillscount = 0;
        when 10
          game_values.bulletbilltimer[@globalID] = 400;
          game_values.bulletbillspawntimer[@globalID] = 0;
          game_values.bulletbillhoming[@globalID] = @homingBills;
          @homingBills = false;
        when 11
          @powerup = 0;
          setPowerup(2);
        when 12,13,14,15
        when 16
          ifsoundonplay($sfx_thunder);
          game_values.screenshaketimer = 20;
          game_values.screenshakeplayerid = @globalID;
          game_values.screenshaketeamid = @teamID;
          game_values.screenshakekillinair = true;
        when 17
          $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
          ifsoundonplay($sfx_collectfeather);
          @powerup = 3;
          @iCapeTimer = 4;
        when 18
          swapPlayers(@localID);
        when 19
          @powerup = 0;
          setPowerup(4);
        when 21 #sledge hammer
          @powerup = 0;
          setPowerup(5);
        when 22  #golden podobo
          numPodobos = rand(6) + 10;
          numPodobos.times do|iPodobo|
            $objectsfront.add(OMO_Podobo.new($spr_podobo, rand(608), -rand(9) / 2.0 - 9.0, @globalID, @teamID, @colorID));
          end
          ifsoundonplay($sfx_thunder);
        when 23 #bombs
          @powerup = 0;
          setPowerup(6);
        end #end case
        @powerupused = -1;
      end
    end
    
    #Animate invincibility
    if(@invincible)
      @animationtimer+=1;
      if((@animationtimer > 3 && @invincibletimer < 480) || @animationtimer > 6)
        @animationtimer = 0;
        @animationstate += 32;
      	
        if(@animationstate > 96)
          @animationstate = 0;
        end
      end
      
      @invincibletimer += 1
      if(@invincibletimer > 580)
        @animationstate = 0;
        @animationtimer = 0;
        @invincibletimer = 0;
        @invincible = false;
      end
    end
    
    #if player is warping or spawning dont pay attention to controls
    if(@state == player_ready)
      #If player is shielded, count down that timer
      if(@spawninvincibletimer > 0)
        @spawninvincibletimer -=1
        @spawninvincible = @spawninvincibletimer > 0;
      end
			
      lrn = 0;	#move left-right-no: -1.. left 0 no 1 ... right
			
      if(@pPlayerAI)
        #Calculate movement every 4th frame (speed up optimization)
        if(game_values.cputurn == @globalID)
          cpu_think();
        end
      end
		  
      if (@statue_timer == 0 && (!game_values.slowdownfreeze || game_values.slowdownon == @teamID))
        if(@playerKeys.game_right.fDown)
          lrn+=1;
        end
        if(@playerKeys.game_left.fDown)
          lrn-=1;
        end
      end
		  
      #Used for bouncing off of note blocks
      if(@superjumptimer > 0)
        @superjumptimer-=1;
      end
			
      #jump pressed?
      if(!game_values.slowdownfreeze || game_values.slowdownon == @teamID)
        if(@playerKeys.game_jump.fDown)
          if(!@lockjump)
            if(@powerup == 3 && @holddown >= 120 && !@flying)
              @holddown = 0;
              ifsoundonplay($sfx_collectfeather);
              @flying = true;
              @lockjump = true;
	
              if(game_values.featherlimit > 0)
                #decreaseProjectileLimit();
              end
            elsif(!@inair && @superjumptimer == 0)
              #only if on the ground and the jump key was released somewhen after it was pressed the last time
						  
              fFellThrough = false;
              if(@playerKeys.game_down.fDown)
                #Check to see what the player is standing on
                txl = @ix / TILESIZE;
                #txr;
                @fPrecalculatedY = @fy + @vely;
							  
                ty = (@fPrecalculatedY + PH) / TILESIZE;
							  
                if(txl < 0)
                  txl += 20;
                elsif(txl > 19)
                  txl -= 20;
                end
								
                if(@ix + PW >= 640)
                  txr = (@ix + PW - 640) / TILESIZE;
                else
                  txr = (@ix + PW) / TILESIZE;
                end
								
                lefttile = $g_map.map(txl, ty);
                righttile = $g_map.map(txr, ty);
							  
                if((lefttile == tile_solid_on_top && (righttile == tile_solid_on_top || righttile == tile_nonsolid)) ||
                      (righttile == tile_solid_on_top && (lefttile == tile_solid_on_top || lefttile == tile_nonsolid)))
                  fFellThrough = true;
                end
								
                if(!fFellThrough && @platform)
                  fPrecalculatedY += @platform.fOldVelY;
                  lefttile,righttile = @platform.gettiletypes(self);
								  
                  if((lefttile == tile_solid_on_top && (righttile == tile_solid_on_top || righttile == tile_nonsolid)) ||
                        (righttile == tile_solid_on_top && (lefttile == tile_solid_on_top || lefttile == tile_nonsolid)))
									
                    fFellThrough = true;
                  end
                end
							  
							  
              end
						  
              if(fFellThrough)
                puts "fFellThrough is #{fFellThrough}, #@playerKeys" 
                @lockfall = true;
                @fallthrough = true;
              else
                jump(lrn, 1.0);
                ifsoundonplay($sfx_jump);
              end
              @lockjump = true;
            elsif(@superjumptimer > 0)
              if(@holddown > 60)
                @holddown = 0;
                @vely = -VELSUPERJUMP;
                ifsoundonplay($sfx_superspring);
              else
                @vely = -VELTURBOJUMP;
                ifsoundonplay($sfx_springjump);
              end
					    
              @superjumptimer = 0;
              @lockjump = true;
            elsif (@powerup == 3)
              if(@featherjump < game_values.featherjumps)
                if(game_values.featherlimit == 0 || projectilelimit > 0)
                  if(@featherjump < game_values.featherjumps)
                    jump(lrn, 0.8);
                    ifsoundonplay($sfx_capejump);
                    @lockjump = true;
                  end
                  @featherjump+=1;	
						      
                end
                if(game_values.featherlimit > 0)
                  decreaseProjectileLimit();
                end
              end
            end
				    
				    
          end
        else
          @lockjump = false;		#the jump key is not pressed: the player may jump again if he is on the ground

          if(@vely < -VELSTOPJUMP)
            @vely = -VELSTOPJUMP;
          end
	
          @flying = false;
          @flyingtimer = 0;
        end
      end 
		  
      if(@flying)
        @flyingtimer += 1
        if(@flyingtimer > 300)
          @flyingtimer = 0;
          @flying = false;
        end
				
        if(@playerKeys.game_down.fDown && @vely < 1.0)
          @vely += 1.0;
        elsif(!playerKeys.game_down.fDown && @vely > -1.0)
          @vely -= 1.0;
          @inair = true;
        end
      end
		  
      if(!game_values.slowdownfreeze || game_values.slowdownon == @teamID)
        if(@playerKeys.game_down.fDown)
          if(!@lockfall && !@inair && @playerDevice == DEVICE_KEYBOARD)
            @lockfall = true;
            @fallthrough = true;
            puts "fallthrough is true in place 2, playerKeys is #{@playerKeys.inspect}"
          end
        else
          @lockfall = false;
        end
      end
		  
      #POWERUP RELEASE
      if(@playerKeys.game_powerup.fDown && (!game_values.slowdownfreeze || game_values.slowdownon == @teamID) && @statue_timer == 0)
        if(game_values.gamepowerups[@globalID] > -1)
          @powerupused = game_values.gamepowerups[@globalID];
          game_values.gamepowerups[@globalID] = -1;
		  	  
          @powerupradius = 100.0;
          @powerupangle = (rand(1000) * 0.00628);
                
          puts "powerup release"
					
          ifsoundonplay($sfx_storedpowerupsound);
        end
      end
		  
      @fPressedAcceptItem = @playerKeys.game_turbo.fPressed;
		  
      #Projectiles
		  
      if(!game_values.slowdownfreeze || game_values.slowdownon == @teamID)
        if(@playerKeys.game_turbo.fDown)
          @fAcceptingItem = @carriedItem == nil;
          if(!@lockfire)
            if(@bobomb) #If we are a bob-omb, explode
              @bobomb = false;

              if(@shoot_super_bobomb)
                @shoot_super_bobomb = false;
						    
                bomb = CO_Bomb.new($spr_bomb, @ix + HALFPW - 14, @iy + 2, 0.0, 0.0, 4, @globalID, @teamID, @colorID, rand(120) + 240);
						    
                if(acceptItem(bomb))
                  bomb.owner = self;
                  bomb.moveToOwner();
                end
						    
                $objectsfront.add(bomb);
                $projectiles[@globalID]+=1;
							  
                $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
                #ifsoundonplay($sfx_transform);
              else
                $objectsfront.add(OMO_Explosion.new($spr_explosion, @ix + HALFPW - 96, @iy + HALFPH - 64, 2, 4, @globalID, @teamID));
                ifsoundonplay($sfx_bobombsound);
              end
            else #fire power up
              if(@powerup == 1 && $projectiles[@globalID] < 2)
                if(game_values.fireballlimit == 0 || @projectilelimit > 0)
                  if(@shoot_left_fireball)
                    $objectsfront.add(MO_SuperFireball.new($spr_superfireball, @ix + HALFPW - 30, @iy + HALFPH - 16, 4, -6.0, 0.0, 4, @globalID, @teamID, @colorID));
                    ifsoundonplay($sfx_spit); 
                  elsif(@shoot_right_fireball)
                    $objectsfront.add(MO_SuperFireball.new($spr_superfireball, @ix + HALFPW - 2, @iy + HALFPH - 16, 4, 6.0, 0.0, 4, @globalID, @teamID, @colorID));
                    ifsoundonplay($sfx_spit); 
                  else
                    $objectcollisionitems.add(MO_Fireball.new($spr_fireball, @ix + 6, @iy, 4, isPlayerFacingRight(), 5, @globalID, @teamID, @colorID));
                    ifsoundonplay($sfx_fireball);
                  end
				
                  $projectiles[@globalID]+=1;
                end
						          
                if(game_values.fireballlimit > 0)
                  decreaseProjectileLimit();
                end
              elsif(@powerup == 2 && $projectiles[@globalID] < 2 && @hammertimer == 0)
                if(game_values.hammerlimit == 0 || @projectilelimit > 0)
                  if(@shoot_left_super_hammer || @shoot_right_super_hammer)
                    @shoot_left_super_hammer = false;
                    @shoot_right_super_hammer = false;
                    $objectsfront.add(MO_Hammer.new($spr_hammer, @ix + 6, @iy, 6, (isPlayerFacingRight() ? 5.0 : -5.0), -1.0, 5, @globalID, @teamID, @colorID, true));
                    $objectsfront.add(MO_Hammer.new($spr_hammer, @ix + 6, @iy, 6, (isPlayerFacingRight() ? 5.0 : -5.0), 0.0, 5, @globalID, @teamID, @colorID, true));
                    $objectsfront.add(MO_Hammer.new($spr_hammer, @ix + 6, @iy, 6, (isPlayerFacingRight() ? 5.0 : -5.0), 1.0, 5, @globalID, @teamID, @colorID, true));
                    $projectiles[@globalID] += 3;
                  else
                    if(isPlayerFacingRight())
                      $objectsfront.add(MO_Hammer.new($spr_hammer, @ix + 8, @iy, 6, @velx + 2.0, -HAMMERTHROW, 5, @globalID, @teamID, @colorID, false));
                    else
                      $objectsfront.add(MO_Hammer.new($spr_hammer, @ix - 14, @iy, 6, @velx - 2.0, -HAMMERTHROW, 5, @globalID, @teamID, @colorID, false));
                    end
				
                    $projectiles[@globalID]+=1;
                  end
                  @hammertimer = game_values.hammerdelay;
                  ifsoundonplay($sfx_fireball);
                end
              end
            end #end if @bobomb
            @lockfire = true
          end
        else
          @lockfire = false;
          @fAcceptingItem = false;
				  
          if(@carriedItem)
            if(@playerKeys.game_down.fDown)
              @carriedItem.drop();
            else
              #Make sure the shell/block is out in front of player before kicking it
              if(@carriedItem.getMovingObjectType() == movingobject_shell || @carriedItem.getMovingObjectType() == movingobject_throwblock)
                @carriedItem.moveToOwner();
              end
              @carriedItem.kick(@superKickIndex > 1 && !(@carriedItem.is_a? CO_ThrowBlock));
            end
            @carriedItem = nil;
          end
        end #end game.turbo.fDown not fDown
      end
		  
      @shoot_left_fireball = false;
      @shoot_right_fireball = false;
		  
      if(lrn == 1)
        if(@onice)
          @velx += VELMOVINGADDICE;
        elsif(@dashRight)
          @velx += VELDASHADD;
        else
          @velx += VELMOVINGADD;		#move right
        end
				
        maxVel = 0;
        if((game_values.slowdownon != -1 && game_values.slowdownon != @teamID) || @jailed > 0)
          maxVel = game_values.slowdownfreeze ? 0.0 : VELSLOWMOVING;
        elsif(@dashRight)
          maxVel = VELDASHMOVING;
        elsif(@playerKeys.game_turbo.fDown)
          maxVel = VELTURBOMOVING + (game_values.gamemode.tagged == self ? TAGGEDBOOST : 0.0);
        else
          maxVel = VELMOVING + (game_values.gamemode.tagged == self ? TAGGEDBOOST : 0.0);
        end
			  
        if(@velx > maxVel)
          @velx = maxVel;
        end
			  
        if(@velx < 0.0 && !@inair)
          game_values.playskidsound = true;
        end
      elsif(lrn == -1)
        if(@onice)
          @velx -= VELMOVINGADDICE;
        elsif(@dashLeft)
          @velx -= VELDASHADD;
        else
          @velx -= VELMOVINGADD;		#move left
        end
				
        maxVel = 0;
        if((game_values.slowdownon != -1 && game_values.slowdownon != @teamID) || @jailed > 0)
          maxVel = game_values.slowdownfreeze ? 0.0 : -VELSLOWMOVING;
        elsif(@dashLeft)
          maxVel = -VELDASHMOVING;
        elsif(@playerKeys.game_turbo.fDown)
          maxVel = -VELTURBOMOVING - (game_values.gamemode.tagged == self ? TAGGEDBOOST : 0.0);
        else
          maxVel = -VELMOVING - (game_values.gamemode.tagged == self ? TAGGEDBOOST : 0.0);
        end
				
        if(@velx < maxVel)
          @velx = maxVel;
        end
	
        if(@velx > 0.0 && !@inair)
          game_values.playskidsound = true;
        end
      else #no move
        #Add air/ground friction
        if(@velx > 0.0)
          if(@inair)
            @velx -= VELAIRFRICTION;
          elsif(@onice)
            @velx -= VELICEFRICTION;
          else
            @velx -= VELMOVINGFRICTION;
          end
					
          @velx = 0.0 if(@velx < 0.0)
					
        elsif(@velx < 0.0)
          if(@inair)
            @velx += VELAIRFRICTION;
          elsif(@onice)
            @velx += VELICEFRICTION;
          else
            @velx += VELMOVINGFRICTION;
          end
					
          if(@velx > 0.0)
            @velx = 0.0;
          end
        end
      end
		  
      @fOldX = @fx;
      @fOldY = @fy;
		  
      collision_detection_map();
		  
    end #end if player_state == player_ready
    
    #and another if player_state == player_ready
    #Player can be killed by map so only do this code if he is still living
    if(@state == player_ready)
      #Deal with terminal burnup velocity
      if(@vely >= MAXVELY && !@invincible)
        @burnupstarttimer += 1
        if(@burnupstarttimer >= 20)
          if(@burnupstarttimer == 20)
            ifsoundonplay($sfx_burnup);
          end
				  
          @burnuptimer += 1
          if(@burnuptimer > 80)
            killPlayerMapHazard();
            return
          else
            $eyecandyback.add(EC_SingleAnimation.new($spr_burnup, @ix + HALFPW - 16, @iy + HALFPH - 16, 5, 4));
          end
				  
				  
        end
      else
        @burnuptimer = 0;
        @burnupstarttimer = 0;
      end
      
      #Deal with out of arena timer
      if(@iy < 0)
        if((@iy + PH < -1 || (@iy + PH <= 1 && @vely <= 0.8)) && game_values.outofboundstime > 0 && !@invincible)
          @outofarenatimer += 1
          if(@outofarenatimer > 62)
            @outofarenatimer = 0;
            @outofarenadisplaytimer -= 1
            if(@outofarenadisplaytimer < 0)
              killPlayerMapHazard();
              return;
            end
          end
        end
      end
      
      #Deal with release from jail timer
      if(@jailed > 0 && game_values.gamemodesettings.jail.timetofree > 1)
        @jailed -= 1
        if(@jailed <= 0)
          @jailed = 0;
          $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
          #ifsoundonplay($sfx_transform);
        end
      end
    end
    setSprite();
		  
		
		
		
		
	 
    #     if @playerKeys.game_right.fDown
    #       puts "moving right"
    #       @ix += 1
    #     elsif  @playerKeys.game_left.fDown
    #       @ix -= 1
    #     elsif @playerKeys.game_down.fDown
    #       @iy += 1
    #     elsif @playerKeys.game_jump.fDown
    #       @iy -= 1
    #     end
	 
  end
  
  def setSprite
    #Use correct sprite (and animate)
    game_values = $game_values
    if(!game_values.pausegame && !game_values.exitinggame && !game_values.swapplayers)
      #if player is warping from below, set them in the air
      if(@state > player_ready)
        if(@state == player_exiting_warp_down || @state == player_entering_warp_up)
          @inair = true;
        else
          @inair = false;
        end
      end
			
      #lockjump is true when we are in the air (even if we fell of an edge)
      if(@state == player_spawning)
        if((@spr & 0x1) == 0)
          @spr = PGFX_JUMPING_R;
        else
          @spr = PGFX_DEAD
        end
      elsif(@inair)
        @frictionslidetimer = 0;
        if(isPlayerFacingRight())
          @spr = PGFX_JUMPING_R;
        else
          @spr = PGFX_JUMPING_L;
        end
      else
        if(@velx > 0.0)
          if(@playerKeys.game_left.fDown && !@playerKeys.game_right.fDown && @state == player_ready)
            @spr = PGFX_STOPPING_R;
            @frictionslidetimer += 1
            if(@frictionslidetimer > 3)
              @frictionslidetimer = 0;
              $eyecandyfront.add(EC_SingleAnimation.new($spr_frictionsmoke, @ix, @iy + PH - 12, 4, 4));
            end
          else
            if(@onice && !@playerKeys.game_right.fDown && !@playerKeys.game_left.fDown) 
              @spr = PGFX_STANDING_R;
            else
              @sprswitch -= 1
              if(@sprswitch < 1)
                if(@spr == PGFX_STANDING_R)
                  @spr = PGFX_RUNNING_R;
                else
                  @spr = PGFX_STANDING_R;
                end
                @sprswitch = 4;
              else
                #If animation timer hasn't fired, make sure we're facing the correct direction
                if((@spr & 0x1) == 1)
                  spr = PGFX_STANDING_R;
                end
              end
            end
          end
        elsif(@velx < 0.0)
          if(@playerKeys.game_right.fDown && !@playerKeys.game_left.fDown && @state == player_ready)
            @spr = PGFX_STOPPING_L;
			      
            @frictionslidetimer += 1
            if(@frictionslidetimer > 3)
              @frictionslidetimer = 0;
              $eyecandyfront.add(EC_SingleAnimation.new($spr_frictionsmoke, @ix + PW - 16, @iy + PH - 12, 4, 4));
            end
			      
          else
            if(@onice && !@playerKeys.game_right.fDown && !@playerKeys.game_left.fDown)
              @spr = PGFX_STANDING_L;
            else
              @sprswitch -= 1
              if(@sprswitch < 1)
                if(@spr == PGFX_STANDING_L)
                  @spr = PGFX_RUNNING_L;
                else
                  @spr = PGFX_STANDING_L;
                end
              else
                #If animation timer hasn't fired, make sure we're facing the correct direction
                if((@spr & 0x1) == 0)
                  @spr = PGFX_STANDING_L;
                end
              end
			        
			        
            end  
			      
          end
        else
          #standing
			    
          if(@playerKeys.game_left.fDown)
            @spr = PGFX_STANDING_L;
          elsif(@playerKeys.game_right.fDown)
            @spr = PGFX_STANDING_R;
          else
            if((@spr & 0x1) == 0)
              @spr = PGFX_STANDING_R;
            else
              @spr = PGFX_STANDING_L;
            end
          end
        end
      end
    end #end if(!game_values.pausegame && !game_values.exitinggame && !game_values.swapplayers)
  end
  
  def jump(iMove, jumpModifier)
    game_values = $game_values
    if((game_values.slowdownon != -1 && game_values.slowdownon != @teamID) || @jailed > 0)
      @vely = -VELSLOWJUMP * jumpModifier;
    elsif(@velx.abs > VELMOVING && iMove != 0 && @playerKeys.game_turbo.fDown)
      @vely = -VELTURBOJUMP * jumpModifier;
    else
      @vely = -VELJUMP * jumpModifier;
    end
    
    @inair = true;
    #Need to help the player off the platform otherwise it will collide with them again
    if(@platform)
      #if(platform->fVelY < 0.0f)
      #	yf(fy + platform->fVelY);
	
      @platform = nil;
    end

    puts("Player Jumped!");
  end
        
  def setPowerup(iPowerup)
    #Play sounds for collecting a powerup
    if(@powerup == iPowerup || (@bobomb && iPowerup == 0) || iPowerup > 6)
      ifsoundonplay($sfx_storepowerup);
    elsif(iPowerup == 0)
      #ifsoundonplay($sfx_transform);
      $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
    elsif(iPowerup == 3)
      ifsoundonplay($sfx_collectfeather);
      $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + HALFPW - 16, @iy + HALFPH - 16, 3, 8));
    else
      ifsoundonplay($sfx_collectpowerup);
    end
    game_values = $game_values
    if(iPowerup == 0)
      if(@bobomb)
        game_values.gamepowerups[@globalID] = 8;
      end

      @bobomb = true;
    elsif(iPowerup > 6)
      if(iPowerup == 7)
        game_values.gamepowerups[@globalID] = 9;
      elsif(iPowerup == 8)
        game_values.gamepowerups[@globalID] = 16;
      elsif(iPowerup == 9)
        game_values.gamepowerups[@globalID] = 10;
      elsif(iPowerup > 9)
        game_values.gamepowerups[@globalID] = iPowerup + 2; #Storing shells
      end
    else
      if(powerup == 1)
        game_values.gamepowerups[@globalID] = 5;
      elsif(powerup == 2)
        game_values.gamepowerups[@globalID] = 11;
      elsif(powerup == 3)
        game_values.gamepowerups[@globalID] = 17;
      elsif(powerup == 4)
        game_values.gamepowerups[@globalID] = 19;
      elsif(powerup == 5)
        game_values.gamepowerups[@globalID] = 21;
      elsif(powerup == 6)
        game_values.gamepowerups[@globalID] = 23;
      end
      @powerup = iPowerup;
      @projectilelimit = 0;
		        
      if(@powerup == 1)
        if(game_values.fireballlimit > 0)
          @projectilelimit = game_values.fireballlimit;
        end
      elsif(powerup == 2)
        if(game_values.hammerlimit > 0)
          projectilelimit = game_values.hammerlimit;
        end
      elsif(powerup == 3)
        if(game_values.featherlimit > 0)
          projectilelimit = game_values.featherlimit;
        end
      elsif(powerup == 4)
        if(game_values.boomeranglimit > 0)
          projectilelimit = game_values.boomeranglimit;
        end
      elsif(powerup == 5)
        if(game_values.hammerlimit > 0)
          projectilelimit = game_values.hammerlimit;
        end
      end
    end
          
    #Minor fix for becoming caped to draw animation correctly
    if(iPowerup == 3)
      @iCapeTimer = 4;
    end
  end
        
  def makeinvincible
    @invincible = true;
    @invincibletimer = 0;
    @animationstate = 0;
    @animationtimer = 0;
    @spawninvincible = false;
    @spawninvincibletimer = 0;
    game_values = $game_values
				
    #Stop the invincible music if a player is already invincible 
    #(we dont want two invincible music sounds playing at the same time)
    ifsoundonstop($sfx_invinciblemusic);
					
    if(!game_values.gamemode.gameover)
      game_values.playinvinciblesound = true;
				
      if(game_values.music && game_values.sound)
        $backgroundmusic[0].stop();
      end
    end
  end
        
  def turnslowdownon(fSuperFreeze)
    game_values = $game_values
    game_values.slowdownon = @teamID;
    game_values.slowdowncounter = 0;
    game_values.slowdownfreeze = fSuperFreeze;
  end
        
  def getWarpPlane
    return @warpplane
  end
        
  def acceptItem(item)
    if(@fAcceptingItem && @statue_timer == 0)
      @carriedItem = item;
      @fAcceptingItem = false;
      return true;
    end
    return false;
  end
  
  #Returns true if player facing right, false if left
  def isPlayerFacingRight
    game_values = $game_values
    if(game_values.swapplayers && game_values.swapstyle == 0)
      if(@fNewSwapX < @fOldSwapX)
        return false;
      else 
        return true;
      end
    end
    
    if(@state == player_ready)
      if(@playerKeys.game_left.fDown && @playerKeys.game_right.fDown && @velx != 0.0)
        if(@velx > 0.0)
          return true;
        else
          return false;
        end
      else
        if(@playerKeys.game_left.fDown)
          return false;
        elsif(@playerKeys.game_right.fDown)
          return true;
        end
      end
    end
    
    if(@spr == PGFX_STOPPING_R)
      return false;
    elsif(@spr == PGFX_STOPPING_L)
      return true;
    elsif((@spr & 0x1) == 0)
      return true;
    end
		
    return false;
    
  end
  
  def bouncejump
    if(@playerKeys.game_jump.fDown)
      @lockjump = true;
      @vely = -VELJUMP;
      return true;
    else
      @vely = -VELJUMP / 2;	#jump a little off of collision object
      return false;
    end
  end
        
  def collision_detection_checktop
    if(@iy < 0.0)
      return false;
    end
				
    ty = @iy / TILESIZE;
				
    if(ty < 0 || ty >= MAPHEIGHT)
      return false;
    end
				
    txl = @ix / TILESIZE;
				
    if(txl < 0 || txl >= MAPWIDTH)
      return false;
    end
				
    txr = -1;
    if(@ix + PW >= 640)
      txr = (@ix + PW - 640) / TILESIZE;
    else
      txr = (@ix + PW) / TILESIZE;
    end
				
    if(txr < 0 || txr >= MAPWIDTH)
      return false;
    end
					
    g_map = $g_map
					
    if((g_map.map(txl, ty) != tile_nonsolid && g_map.map(txl, ty) != tile_solid_on_top) || 
          (g_map.map(txr, ty) != tile_nonsolid && g_map.map(txr, ty) != tile_solid_on_top) ||
          (g_map.block(txl, ty) && !g_map.block(txl, ty).isTransparent()) || 
          (g_map.block(txr, ty) && !g_map.block(txr, ty).isTransparent()))
      yf((ty * TILESIZE + TILESIZE) + 0.2);
      return true;
    end
				
    return false;
  end
        
  def collision_detection_checkleft()
    if(@fy < 0.0)
      return false;
    end
					
    ty = fy.to_i / TILESIZE;
					
    if(ty < 0 || ty >= MAPHEIGHT)
      return false;
    end
					
    ty2 = (@fy + collisionHeight) / TILESIZE;
					
    if(ty2 < 0 || ty2 >= MAPHEIGHT)
      return false;
    end
					
    tx = @ix / TILESIZE;
					
    if(tx < 0 || tx >= MAPWIDTH)
      return false;
    end
					
    g_map = $g_map
    if((g_map.map(tx, ty) != tile_nonsolid && g_map.map(tx, ty) != tile_solid_on_top) ||
          (g_map.map(tx, ty2) != tile_nonsolid && g_map.map(tx, ty2) != tile_solid_on_top) ||
          (g_map.block(tx, ty) && !g_map.block(tx, ty).isTransparent()) || 
          (g_map.block(tx, ty2) && !g_map.block(tx, ty2).isTransparent()))
						
      xf((tx * TILESIZE + TILESIZE) + 0.2);
      flipsidesifneeded();
      return true;
    end
					
    return false;
  end
        
  def getScoreboardSprite
    @pScoreboardSprite
  end
  
  def isstomping(o)
    game_values = $game_values
    
    if(@fOldY + PH <= o.fOldY && @iy + PH >= o.iy)
      #dont reposition if player is warping when he kills the other player
      if(state == player_ready)
        yi(o.iy - PH);		#set new position to top of other player
        #collision_detection_checktop();
        @platform = nil;
      end
      fKillPotential = false;
      if(@vely > 1.0)
        fKillPotential = true;
      end
      bouncejump();
      if(fKillPotential)
        playerKilledPlayer(self, o, death_style_squish, (@featherjump > 0 ? kill_style_feather : kill_style_stomp));
      else
        if(game_values.gamemode.tagged == o && isready() && o.isready())
          game_values.gamemode.tagged = self;
          o.spawninvincible = true;
          o.spawninvincibletimer = 60;
          #$eyecandyfront.add(EC_GravText.new($game_font_large, game_values.gamemode.tagged.ix + HALFPW, game_values.gamemode.tagged.iy + PH, "Tagged!", -VELJUMP*1.5));
          $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, game_values.gamemode.tagged.ix + HALFPW - 16, game_values.gamemode.tagged.iy + HALFPH - 16, 3, 8));
          #ifsoundonplay($sfx_transform);
        elsif(game_values.gamemode.tagged == self && isready() && o.isready())
          game_values.gamemode.tagged = o;
          spawninvincibletimer = 60;
          spawninvincible = true;
          #$eyecandyfront.add(EC_GravText.new($game_font_large, game_values.gamemode.tagged.ix + HALFPW, game_values.gamemode.tagged.iy + PH, "Tagged!", -VELJUMP*1.5));
          $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, game_values.gamemode.tagged.ix + HALFPW - 16, game_values.gamemode.tagged.iy + HALFPH - 16, 3, 8));
          #ifsoundonplay($sfx_transform);
        end
      end
      return true
    end
    return false
  end
        
  def flipsidesifneeded
    #Use ix here to avoid rounding issues (can crash if txr evals to over the right side of screen)
    if(@ix < 0 || @fx < 0.0)
      #This avoids rounding errors
      xf(@fx + 640.0);
      @fOldX += 640.0;
    elsif(@ix >= 640 || @fx >= 640.0)
      xf(@fx - 640.0);
      @fOldX -= 640.0;
    end
  end
end

      





def capFallingVelocity(vel)
  if(vel > MAXVELY)
    return MAXVELY;
  end
	
  return vel;
end

      

def decreaseProjectileLimit()
  @projectilelimit -= 1
  if(@projectilelimit <= 0)
    @projectilelimit = 0;
    @powerup = 0;
    ifsoundonplay($sfx_powerdown);
  end
end

def cpu_think
  @pPlayerAI.think(@playerKeys);
end

def increasewarpcounter(iGoal)
  @warpcounter += 1
  if(@warpcounter > iGoal)
    @warpcounter = iGoal;
    chooseWarpExit();
  end
end

def decreasewarpcounter()
  @warpcounter -= 1
  if(@warpcounter < 0)
    @warpcounter = 0;
    @state = player_ready;
  end
end

def chooseWarpExit
  exit = $g_map.getRandomWarpExit(@warpconnection, @warpid);
  xi(exit.x);
  yi(exit.y);
	
  @fOldX = @fx;
  @fOldY = @fy;
	
  @lockjump = false;
	
  if(exit.direction == 0)
    @state = player_exiting_warp_up;
    @warpcounter = PH + PHOFFSET;
    @velx = 0.0;
    @vely = -4.0;
    @warpplane = exit.warpy * TILESIZE;
  elsif(exit.direction == 1)
    @state = player_exiting_warp_right;
    @warpcounter = PW + PWOFFSET;
    @velx = 1.0;
    @vely = 1.0;
    @warpplane = exit.warpx * TILESIZE + TILESIZE;
  elsif(exit.direction == 2)
    @state = player_exiting_warp_down;
    @warpcounter = TILESIZE - PHOFFSET;
    @velx = 0.0;
    @vely = 1.1;
    @inair = true;
    @warpplane = exit.warpy * TILESIZE + TILESIZE;
  elsif(exit.direction == 3)
    @state = player_exiting_warp_left;
    @warpcounter = PW + PWOFFSET;
    @velx = -1.0;
    @vely = 1.0;
    @warpplane = exit.warpx * TILESIZE;  
  end
  game_values = $game_values
  if(game_values.spawninvincibility > 0)
    if(!@spawninvincible || @spawninvincibletimer < game_values.spawninvincibility)
      @spawninvincibletimer = game_values.spawninvincibility;
      @spawninvincible = true;
    end
  end
  
end



def playerKilledPlayer(killer, killed, deathstyle, style)
  #If this player is already dead, then dont kill him again
  return if(killed.state != player_ready)
  if(killed.bobomb)
    killed.diedas = 2;
    killer.bobomb = true;
    $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, killer.ix + HALFPW - 16, killer.iy + HALFPH - 16, 3, 8));
    #ifsoundonplay($sfx_transform);
  end	
  game_values = $game_values
  if(game_values.gamemode.chicken == killer && style != kill_style_pow)
    ifsoundonplay($sfx_chicken);
  else
    if(deathstyle == 0)
      ifsoundonplay($sfx_deathsound);
    else
      ifsoundonplay($sfx_mip);
    end
  end
  
  #if(killer.teamID != killed.teamID)
  #  addAwardKill(killer, killed, style);
  #end
  
  if(game_values.awardstyle != award_style_none)
    #puts killed
    killed.deathAwards();
  end
	
  if(!game_values.gamemode.playerkilledplayer(killer, killed))
    killed.die(deathstyle, false);
  end
end

def addAwardKill(killer, killed, style)
  #todo
end