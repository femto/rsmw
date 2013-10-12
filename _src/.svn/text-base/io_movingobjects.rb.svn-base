class IO_MovingObject < CObject
  attr_accessor :bounce,:inair,:onice,:fallthrough,:killsinrowinair,:featherjump,:velx,:vely
  attr_accessor :fOldX,:fOldY,:fx,:fy
  attr_accessor :platform
  attr_accessor :fPrecalculatedY
  attr_accessor :iHorizontalPlatformCollision,:iVerticalPlatformCollision
  attr_accessor :movingObjectType
  include MapAware
  def initialize(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth = -1, iCollisionHeight = -1, iCollisionOffsetX = -1, iCollisionOffsetY = -1, iAnimationOffsetX = -1, iAnimationOffsetY = -1, iAnimationHeight = -1, iAnimationWidth = -1)
    super(nspr,x,y)
    @iNumSprites = iNumSpr;

    if(iAnimationWidth > -1)
      @iw = iAnimationWidth;
    else
      @iw = @spr.getWidth() / @iNumSprites;
    end
	
    if(iAnimationHeight > -1)
      @ih = iAnimationHeight;
    end
	
    @animationtimer = 0;
    @animationWidth = @spr.getWidth();
	
    @fOldX = @fx;
    @fOldY = @fy - @ih;
	
    @animationspeed = aniSpeed;
		
    @objectType = object_moving;
    @movingObjectType = movingobject_none;
	
    if(iCollisionWidth > -1)
      @collisionWidth = iCollisionWidth;
      @collisionHeight = iCollisionHeight;
      @collisionOffsetX = iCollisionOffsetX;
      @collisionOffsetY = iCollisionOffsetY;
    else
      @collisionWidth = @iw;
      @collisionHeight = @ih;
      @collisionOffsetX = 0;
      @collisionOffsetY = 0;
    end
	
    if(iAnimationOffsetX > -1)
      @animationOffsetX = iAnimationOffsetX;
      @animationOffsetY = iAnimationOffsetY;
    else
      @animationOffsetX = 0;
      @animationOffsetY = 0;
    end
	
    @drawframe = @animationOffsetX;
	
    @inair = false;
    @onice = false;
	
    @platform = nil;
    @iHorizontalPlatformCollision = -1;
    @iVerticalPlatformCollision = -1;
  end
  def killMapHazard
    if(!@dead)
			@dead = true;
			$eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix + (@iw >> 1) - 16, @iy + (@ih >> 1) - 16, 3, 4));
	
			if(@movingObjectType == movingobject_fireball)
				iPlayerID = self.playerID;
	
				if($projectiles[iPlayerID] > 0)
					$projectiles[iPlayerID]-=1;
				end
	
				ifsoundonplay($sfx_hit);
			else
				#ifsoundonplay($sfx_transform);
	
				if(@movingObjectType == movingobject_egg)
					@dead = false;
					#self.placeEgg();
				elsif(@movingObjectType == movingobject_star)
					@dead = false;
					#self.placeStar();
				elsif(@movingObjectType == movingobject_flag)
					@dead = false;
					#self.placeFlag();
				end
			end
		end
  end
  def getMovingObjectType
    @movingObjectType
  end
  
  def invincible
    true
  end
  def spawninvincible
    true
  end
  def draw
    @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @animationOffsetY, @iw, @ih);
  end
  
  def update()
    @fOldX = @fx;
    @fOldY = @fy;
	
    collision_detection_map();
    @animationtimer += 1
    if(@animationtimer == @animationspeed)
      @animationtimer = 0;
			
      @drawframe += @iw;
      if(@drawframe >= @animationWidth)
        @drawframe = @animationOffsetX;
      end
    end
  end
  def hittop
    @vely = bottomBounce();
  end
  def sideBounce
    @velx = -@velx
  end
  def bottomBounce
    @bounce
  end
  def hitbottom
    @vely = -@vely;
  end
  def hitright
    if(@velx < 0.0)
      @velx = -@velx;
    end
  end
  def hitleft
    if(@velx > 0.0)
      @velx = -@velx;
    end
  end
  
  def short_circuit_to_process_map_collision
    false #we never short circuit map collision in IO_MovingObject
  end
  
  def flipsidesifneeded
    #Use ix here to avoid rounding issues (can crash if txr evals to over the right side of screen)
    if(@ix < 0 || @fx < 0.0)
      xf(@fx + 640.0);
      @fOldX += 640.0;
    elsif(@ix >= 640 || @fx >= 640.0)
      xf(@fx - 640.0);
      @fOldX -= 640.0;
    end
  end
  
end

class MO_Fireball < IO_MovingObject
  attr_accessor :playerID
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iGlobalID, iTeamID, iColorID)
    super(nspr, x, y, iNumSpr, aniSpeed, nspr.getWidth() >> 2, nspr.getHeight() >> 3, 0, 0)
    if(moveToRight)
      @velx = 5.0;
    else
      @velx = -5.0;
    end
		
    #fireball sprites have both right and left sprites in them
    @ih = @ih >> 3;
    @bounce = -FIREBALLBOUNCE;
		
    @playerID = iGlobalID;
    @teamID = iTeamID;
    @colorOffset = iColorID * 36;
    @movingObjectType = movingobject_fireball;
    @state = 1;
	
    @ttl = $game_values.fireballttl;
  end
  
  def update
    super
    @ttl -= 1
    if(@ttl <= 0)
      removeifprojectile(self, true, true);
    end
  end
  def draw
    @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, (@velx > 0 ? 0 : 18) + @colorOffset, @iw, @ih);
  end
  
  def collide(player)
    game_values = $game_values
    if(@playerID != player.globalID && (game_values.friendlyfire || @teamID != player.teamID))
      if(!player.spawninvincible)
        removeifprojectile(self, false, false);
        if(!player.invincible)
          #Find the player that shot this fireball so we can attribute a kill
          killer = getPlayerFromGlobalID(@playerID);
    	    
          if(killer)
            playerKilledPlayer(killer, player, death_style_jump, kill_style_fireball);
          else
            player.deathAwards();
	
            if(!game_values.gamemode.playerkilledself(player))
              player.die(0, false);
            end
	
            ifsoundonplay($sfx_deathsound);
          end
	
          return true;
        end
      end
    end
    return false
  end
end
class MO_SuperFireball < IO_MovingObject
end
class MO_Hammer < IO_MovingObject
  attr_accessor :playerID
  def initialize(nspr, x, y, iNumSpr, fVelyX, fVelyY, aniSpeed, iGlobalID, iTeamID, iColorID, superHammer)
    super(nspr, x, y, iNumSpr, aniSpeed, nspr.getWidth() / iNumSpr, nspr.getHeight() >> 2, 0, 0)
    @ih = @ih >> 2;

    game_values = $game_values
    @playerID = iGlobalID;
    @teamID = iTeamID;
    @colorOffset = iColorID * 28;
    @movingObjectType = movingobject_hammer;
    @state = 1;
    @velx = fVelyX;
    @vely = fVelyY;
    @ttl = game_values.hammerttl;
	
    @fSuper = superHammer;
	
    if(@velx > 0.0)
      @drawframe = 0;
    else
      @drawframe = @animationWidth - @iw;
    end
		
		
  end
  
  def update()
    @animationtimer += 1
    if(@animationtimer == @animationspeed)
		
      @animationtimer = 0;
			
      if(@velx > 0)
        @drawframe += iw;
        if(@drawframe >= @animationWidth)
          @drawframe = 0;
        end
      else
        @drawframe -= @iw;
        if(@drawframe < 0)
          @drawframe = @animationWidth - @iw;
        end
      end
    end
	
    xf(@fx + @velx);
    yf(@fy + @vely);
		
    if(!@fSuper)
      @vely += GRAVITATION;
    end
	
    if(@ix < 0)
      xi(@ix + 640);
    elsif(ix > 639)
      xi(@ix - 640);
    end
		
    if(@iy > 480 || (@ttl-=1) <= 0 || (@fSuper && @iy < -@ih))
      removeifprojectile(self, false, true);
    end
  end
	
  def draw()
    @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @colorOffset, @iw, @ih);
  end
	
  def collide(player)
    game_values = $game_values
    if(@playerID != player.globalID && (game_values.friendlyfire || @teamID != player.teamID))
		
      if(!player.spawninvincible)
			
        removeifprojectile(self, false, false);
	
        if(!player.invincible)
				
          #Find the player that shot this hammer so we can attribute a kill
          killer = getPlayerFromGlobalID(@playerID);
	
          if(killer)
            playerKilledPlayer(killer, player, death_style_jump, kill_style_hammer);
          else
            player.deathAwards();
	
            if(!game_values.gamemode.playerkilledself(player))
              player.die(0, false);
            end
	
            ifsoundonplay($sfx_deathsound);
          end
	
          return true;
        end
      end
    end
	
    return false;
  end
end
class MO_SledgeHammer < IO_MovingObject
end
class MO_Boomerang < IO_MovingObject
end
class MO_Coin < IO_MovingObject
end
class IO_OverMapObject < CObject
  def initialize(nspr, x, y, iNumSpr, aniSpeed)
    super(nspr, x, y)
    @iNumSprites = iNumSpr;

    @iw = @spr.getWidth() / @iNumSprites;
    @collisionWidth = @iw;
    @drawframe = 0;
	
    @animationspeed = aniSpeed;
    @animationtimer = 0;
    @animationWidth = @spr.getWidth();
	
    @objectType = object_overmap;
    @movingObjectType = movingobject_none;
  end
  def draw
    @spr.draw(@ix, @iy, @drawframe, 0, @iw, @ih);
  end
  
  def update
    xf(@fx + @velx);
    yf(@fy + @vely);
		
    @animationtimer += 1;
	
    if(@animationtimer == @animationspeed)
		
      @animationtimer = 0;
      @drawframe += @iw;
      if(@drawframe >= @animationWidth)
        @drawframe = 0;
      end
    end
  end
  
  def collide(o)
    return false;
  end
  
  def getObjectType()
    return @objectType;
  end
  def getMovingObjectType() 
    return @movingObjectType;
  end
  
end
class OMO_Thwomp < IO_OverMapObject
end
class OMO_Podobo < IO_MovingObject
end
class OMO_BowserFire < IO_OverMapObject
end
class MO_CarriedObject < IO_MovingObject
  attr_accessor :owner
  def initialize(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY, iAnimationOffsetX=-1, iAnimationOffsetY=-1, iAnimationHeight=-1, iAnimationWidth=-1)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY, iAnimationOffsetX, iAnimationOffsetY, iAnimationHeight, iAnimationWidth)
    @owner = nil;
    @fSmoking = false;
  end
  def update
  end
  def draw
  end
  def collide(player)
    return false;
  end
  
  #   def moveToOwner()
  #   end
  # 
  # 	def drop()
  #   end
  #   
  # 	def kick(superkick)
  # 	end
end
class CO_Egg < MO_CarriedObject
end
class CO_Star < MO_CarriedObject
end
class OMO_FlagBase < IO_OverMapObject
end
class CO_Flag < MO_CarriedObject
end
class OMO_Yoshi < IO_OverMapObject
end
class OMO_Area < IO_OverMapObject
end
class OMO_KingOfTheHillZone < IO_OverMapObject
end
class OMO_RaceGoal < IO_OverMapObject
end
class MO_FrenzyCard < IO_MovingObject
end
class OMO_Explosion < IO_OverMapObject
  def initialize(nspr, x, y, iNumSpr, aniSpeed, playerid, iTeamID)
    super(nspr, x, y, iNumSpr, aniSpeed)
    @state = 1;
    @playerID = playerid;
    @teamID = iTeamID;
    @timer = 0;
    @objectType = object_explosion;
  end
  
  def collide(o)
    game_values = $game_values
    if o.class == CPlayer
      if(o.globalID != @playerID && (game_values.friendlyfire || @teamID != o.teamID) && !o.invincible && !o.spawninvincible)
      	#Find the player that made this explosion so we can attribute a kill
      	killer = getPlayerFromGlobalID(@playerID);
      	if(killer)
          playerKilledPlayer(killer, o, death_style_jump, kill_style_bobomb);
        else
          o.deathAwards();
		
          if(!game_values.gamemode.playerkilledself(o))
            o.die(0, false);
          end
        end
		
        return true;
      end
      return false
    else #IO_MovingObject
    end
  end
  
  def update
    @animationtimer += 1
    if(@animationtimer == @animationspeed)
      @animationtimer = 0;
      @drawframe += @iw;
      if(@drawframe >= @animationWidth)
        @drawframe = 0;
      end
    end
    @timer += 1
    if(@timer >= 48)
      @dead = true;
    end
  end
end
class MO_Goomba < IO_MovingObject
end
class MO_Koopa < MO_Goomba
end
class OMO_CheepCheep < IO_MovingObject
end
class OMO_BulletBill < IO_MovingObject
  def initialize(nspr, y, nspeed, playerID, homing)
    super(nspr, 0, y, 3, 8, 30, 28, 1, 2)
    @fMaxVel = nspeed.abs;
    @velx = nspeed;
    @vely = 0.0;
    
    @fGoalVelX = velx;
    @fGoalVelY = vely;
	  
    @ih = nspr.getHeight() >> 3;
	  
    if(@velx < 0)
      xi(640 + @iw);
    else
      xi(-@iw);
    end
		
    @movingObjectType = movingobject_bulletbill;
    @state = 1;
	  
    game_values = $game_values
    @iPlayerID = playerID;
    @iColorID = game_values.colorids[playerID];
    @iTeamID = lookupTeamID(@iPlayerID);
	
    @iColorOffsetY = 64 * @iColorID;
    setDirectionOffset();
	
    @pHomingPlayer = nil;
    @fHoming = homing;
	
    homeToNearestPlayer();
  end
  
  def setDirectionOffset
    @iDirectionOffsetY = @velx < 0 ? 0 : 32;
  end
  
  def homeToNearestPlayer
    if(!@fHoming)
      return;
    end

    iDistance = 640000;
    list_players_cnt = $list_players_cnt
    list_players = $list_players
    list_players_cnt.times do |k|
      next if(list_players[k].globalID == @iPlayerID)
	
      if(list_players[k].isready())
        iXValue = list_players[k].ix - @ix;
        iYValue = list_players[k].iy - @iy;
	
        playerDistance = iXValue * iXValue + iYValue * iYValue;
	
        if(playerDistance < iDistance)
				
          iDistance = playerDistance;
          @pHomingPlayer = list_players[k];
        end
      end
    end
	
    if(@pHomingPlayer)
      fSlope = (@pHomingPlayer.ix - @ix) / (@pHomingPlayer.iy - @iy);
			
      if(@pHomingPlayer.ix > @ix)
        @fGoalVelX = @fMaxVel;
      else
        @fGoalVelX = -@fMaxVel;
      end
	
      if(@pHomingPlayer.iy > iy)
        @fGoalVelY = @fMaxVel / fSlope.abs;
      else
        @fGoalVelY = -@fMaxVel / fSlope.abs;
      end
	
      setDirectionOffset();
    end
  end
  
  def update
    if(@pHomingPlayer)
      if(@fGoalVelX < 0.0 && @velx > @fGoalVelX)
        @velx -= 0.2;
      end
	
      if(@fGoalVelX > 0.0 && @velx < @fGoalVelX)
        @velx += 0.2;
      end
	
      if(@fGoalVelY < 0.0 && @vely > @fGoalVelY)
        @vely -= 0.2;
      end
	
      if(@fGoalVelY > 0.0 && @vely < @fGoalVelY)
        @vely += 0.2;
      end
    end
	
    xf(@fx + @velx);
    yf(@fy + @vely);
	
    @animationtimer += 1
    if(@animationtimer == @animationspeed)
      @animationtimer = 0;
			
      @drawframe += @iw;
      if(@drawframe >= @animationWidth)
        @drawframe = 0;
      end
    end
	
    if((@velx < 0 && @ix < -@iw) || (@velx > 0 && @ix > 640))
      @dead = true;
    end
  end
  
  def draw
    @spr.draw(@ix, @iy, @drawframe, @iColorOffsetY + @iDirectionOffsetY, @iw, @ih);
  end
  
  def collide(o)
    if o.class == CPlayer
      if(o.invincible)
        addAwardKill(o, nil, kill_style_bulletbill);
        ifsoundonplay($sfx_kicksound);
				
        die();
      else
        if(o.fOldY + o.collisionHeight <= @iy && o.iy + o.collisionHeight >= @iy)
          return hittop(o);
        else
          return hitother(o);
        end
      end
		
      return false;
    else
    end
  end
  
  def hittop(player)
    player.yi(@iy - player.collisionHeight - 1);
    player.bouncejump();
    player.collision_detection_checktop();
    player.platform = nil;
		
    addAwardKill(player, nil, kill_style_bulletbill);
	
    ifsoundonplay($sfx_mip);
		
    die();
	
    return false;
  end
  
  def hitother(player)
    game_values = $game_values
    if(player.spawninvincible || player.globalID == @iPlayerID)
      return false;
    end
	
    if(!game_values.friendlyfire && @iTeamID == player.teamID)
      return false;
    end
	
    #Find the player that owns this bullet bill so we can attribute a kill
    killer = getPlayerFromGlobalID(@iPlayerID);
	
    if(killer)
      playerKilledPlayer(killer, player, death_style_jump, kill_style_bulletbill);
    else
      player.deathAwards();
	
      if(!game_values.gamemode.playerkilledself(player))
        player.die(0, false);
      end
	
      ifsoundonplay($sfx_deathsound);
    end
		
    return true;
  end
  
  def die
    @dead = true;
    $eyecandyfront.add(EC_FallingObject.new($spr_bulletbilldead, @ix, @iy, -VELJUMP / 2.0, @velx > 0 ? 0 : 32, @iColorID * 32, 32, 32));
  end
  
end
class MO_SledgeBrother < IO_MovingObject
end
##state 1: Shell is moving
##state 2: Shell is waiting to be picked up
##state 3: Shell is being held
class CO_Shell < MO_CarriedObject
  def initialize(type, x, y, dieOnMovingPlayerCollision, dieOnHoldingPlayerCollision, dieOnFire, killBouncePlayer)
    super($spr_shell, x, y, 4, 4, 30, 20, 1, 11, 0, type * 32, 32, 32)  
    
    @iShellType = type;

    @state = 0;
    @bounce = GRAVITATION;
    @objectType = object_moving;
    @movingObjectType = movingobject_shell;
    @playerID = -1;
    @iIgnoreBounceTimer = 0;
    @iBounceCounter = 0;
	
    @fDieOnMovingPlayerCollision = dieOnMovingPlayerCollision;
    @fDieOnHoldingPlayerCollision = dieOnHoldingPlayerCollision;
    @fDieOnFire = dieOnFire;
    @fKillBouncePlayer = killBouncePlayer;
	
    @iDeathTime = 0;
	
    @iDestY = @iy - collisionHeight;
    @fy = @iDestY + 32.0;
    @iColorOffsetY = type * 32;
	
    @iKillCounter = 0;
  end
  def isThreat() 
    return @state == 1 || @state == 3;
  end
  
  def drop()
		if(@owner)
			@owner.carriedItem = nil;
			xi(@owner.ix + (@owner.isPlayerFacingRight() ? PW + 1: -33));
		end
	
		#if(collision_detection_checksides())
			#Move back to where it was before checking sides, then kill it
		#	xi(@owner.ix + (@owner.isPlayerFacingRight() ? PW + 1: -33));
		#	yi(@owner.iy + PH - 32 + @collisionOffsetY);
		#	die();
		#else
			@owner = nil;
			@state = 2;
		#end
	end
  
  def collide(player)
    puts "colliding...."
    if(player.invincible)
      if(@state == 0 || @state == 2)
        die();
        return false;
      elsif(@state == 3)
        if(@owner != player)
          die();
          return false;
        end
      elsif(@state == 1)
        flipx = 0;
        	
        if(player.ix + player.collisionWidth < 320 && @ix > 320)
          flipx = 640;
        elsif(@ix + @iw < 320 && player.ix > 320)
          flipx = -640;
        end
        	
        if((player.ix + player.halfCollisionWidth + flipx >= @ix + (@iw >> 1) && @velx > 0.0) || (player.ix + player.halfCollisionWidth + flipx < @ix + (@iw >> 1) && @velx < 0.0))
        				
          die();
          return false;	
        end
      end
    
    end
	
    if(player.statue_timer == 0)
      if(player.fOldY + player.collisionHeight <= iy && player.iy + player.collisionHeight >= iy)
        return hitTop(player);
      else
        return hitOther(player);
      end
    end
	
    return false;
  end
	
  def hitTop(player)
    puts "hitTop"
    if(player.invincible)
      die();
      @fSmoking = false;
      return false;
    end
	
    if(@fKillBouncePlayer)
      killPlayer(player);
    elsif(@state == 2) #Sitting
      @owner = player;
      kick(false);
      @fSmoking = false;
      if(player.ix + player.halfCollisionWidth < @ix + (@iw >> 1))
        velx = 5.0;
      else
        velx = -5.0;
      end
	
      @iIgnoreBounceTimer = 10;
    elsif(@state == 1 && @iIgnoreBounceTimer == 0)  #Moving
      @owner = nil;
      @velx = 0.0;
      @state = 2;
      @fSmoking = false;
      ifsoundonplay($sfx_kicksound);
	
      player.yi(@iy - player.collisionHeight - 1);
			
      player.bouncejump();
      player.collision_detection_checktop();
      player.platform = nil;
      @iKillCounter = 0;
    elsif(@state == 3) #Holding
      game_values = $game_values
      if(player != @owner && (game_values.friendlyfire || player.teamID != @owner.teamID))
        if(@owner)
          @owner.carriedItem = nil;
        end
	
        kick(false);
        @fSmoking = false;
	
        player.yi(@iy - player.collisionHeight - 1);
        player.bouncejump();
        player.collision_detection_checktop();
        player.platform = nil;
      end
    end
	
    return false;
  end
	
  def hitOther(player)
    puts "hitOther"
    if(@state == 2) #Sitting
      if(@owner == nil)
        if(player.acceptItem(self))
          @owner = player;
          @playerID = @owner.globalID;
          @state = 3;
        else
          flipx = 0;
	
          if(player.ix + player.collisionWidth < 320 && @ix > 320)
            flipx = 640;
          elsif(@ix + @iw < 320 && player.ix > 320)
            flipx = -640;
          end
	
          @owner = player;
          kick(false);
          if(player.ix + player.halfCollisionWidth + flipx < @ix + (@iw >> 1))
            velx = 5.0;
          else
            velx = -5.0;
          end
        end
      end
    elsif(@state == 1)  #Moving
      flipx = 0;
	
      if(player.ix + player.collisionWidth < 320 && @ix > 320)
        flipx = 640;
      elsif(@ix + @iw < 320 && player.ix > 320)
        flipx = -640;
      end
	
      if((player.ix + player.halfCollisionWidth + flipx >= @ix + (@iw >> 1) && @velx > 0.0) || (player.ix + player.halfCollisionWidth + flipx < @ix + (@iw >> 1) && @velx < 0.0))
			
        return killPlayer(player);
      end
	
    elsif(@state == 3)  #Holding
      game_values = $game_values
      if(player != @owner && (game_values.friendlyfire || player.teamID != @owner.teamID))
        @playerID = @owner.globalID;
        return killPlayer(player);
      end
    end
	
    return false;
  end
	
  def usedAsStoredPowerup(player)
    @owner = player;
    moveToOwner();
	
    if(player.acceptItem(self))
      @state = 3;
    else
      kick(false);
    end
  end
  
  def kick(superkick)
    vel = 5.0;
    if(superkick)
      vel = 10.0;
      @fSmoking = true;
      ifsoundonplay($sfx_cannon);
    end
	
    @velx = @owner.isPlayerFacingRight() ? vel : -vel;
    @vely = 0.0;
	
    @playerID = @owner.globalID;
	
    @owner = nil;
	
    @state = 1;
		
    #if(collision_detection_checksides())
    #	die();
    #else
    ifsoundonplay($sfx_kicksound);
    #end
  end
	
  def moveToOwner()
    if(@owner)
		
      xi(@owner.ix + (@owner.isPlayerFacingRight() ? HALFPW: HALFPW - 32));
      yi(@owner.iy + PH - 32 + @collisionOffsetY);
    end
  end
	
  def killPlayer(player)
    if(player.spawninvincible || player.invincible)
      return false;
    end
	
    checkAndDie();
    game_values = $game_values
	
    #Find the player that shot this shell so we can attribute a kill
    killer = getPlayerFromGlobalID(@playerID);
	
    if(killer && killer.globalID != player.globalID)
      playerKilledPlayer(killer, player, death_style_jump, kill_style_shell);
      addMovingKill(killer);
    else
      player.deathAwards();
	
      if(!game_values.gamemode.playerkilledself(player))
        player.die(0, false);
      end
	
      ifsoundonplay($sfx_deathsound);
    end
	
    return true;
  end
	
  def addMovingKill(killer)
    if(@state == 1 && $game_values.awardstyle != award_style_none) #If the shell is moving, the keep track of how many people we kill in a row with it
      @iKillCounter += 1
      if(@iKillCounter > 1)
        #killer.addKillsInRowInAirAward();
      end
    end
  end
  
  def update()
    game_values = $game_values
    if(@state == 1)
      if(game_values.shellttl > 0 && (@iDeathTime+=1) >= game_values.shellttl)
        $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix, @iy, 3, 8));
        @dead = true;
        ifsoundonplay($sfx_kicksound);
	
        if(@owner)
          owner.carriedItem = nil;
          @owner = nil;
        end
	
        return;
      end
    else
      @iDeathTime = 0;
    end
				
    #Have the powerup grow out of the powerup block
    if(@state == 0)
      yf(@fy - 2.0);
	
      if(@fy <= @iDestY)
        @state = 2;
        @vely = GRAVITATION;
        yf(@iDestY);
      end
	
      return;
    end
	
    if(@iIgnoreBounceTimer > 0)
      @iIgnoreBounceTimer-=1;
    end
		
    if(@iBounceCounter > 0)
      @iBounceCounter-=1;
    end
	
    if(@owner)
      moveToOwner();
      @inair = true;
    else
      @fOldX = @fx;
      @fOldY = @fy;
	
      collision_detection_map();
			
      @animationtimer += 1
      if(@animationtimer == @animationspeed)
        @animationtimer = 0;
        @drawframe += @iw;
        if(@drawframe >= @animationWidth)
          @drawframe = 0;
        end
      end
    end
  end
	
  def draw()
    #require 'debug'
    #puts "state= #{@state}"
    
    if(@state == 0)
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, 0, @iColorOffsetY, @iw, (@ih - @fy + @iDestY));
    elsif(@owner)
      if(@owner.iswarping())
        @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, 0, @iColorOffsetY, @iw, @ih, @owner.state % 4, @owner.getWarpPlane());
      else
        @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, 0, @iColorOffsetY, @iw, @ih);
      end
    else
      if(@state == 2)
        @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, 0, @iColorOffsetY, @iw, @ih);
      elsif(@state == 1)
        @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @iColorOffsetY, @iw, @ih);
      end
    end
	
    if(@fSmoking)
      $eyecandyback.add(EC_SingleAnimation.new($spr_burnup, @ix - @collisionOffsetX + (@iw >> 1) - 16, @iy - @collisionOffsetY + (@ih >> 1) - 16, 5, 3));
    end
  end
	
  def checkAndDie()
    if((@fDieOnMovingPlayerCollision && @state == 1) || (@fDieOnHoldingPlayerCollision && @state == 3))
      die();
    elsif(!@fDieOnHoldingPlayerCollision && @state == 3 && (rand(5) == 0))
      die();
    end
  end
  
  def die()
    $eyecandyfront.add(EC_FallingObject.new($spr_shelldead, @ix, @iy, -@velx / 4.0, -VELJUMP / 2.0, 1, 0, @iShellType * 32, 0, 32, 32));
    @dead = true;
    ifsoundonplay($sfx_kicksound);
    @iKillCounter = 0;
	
    if(@owner)
      @owner.carriedItem = nil;
      @owner = nil;
    end
  end

	
	

end
##State 1: Moving
##State 2: Holding
class CO_ThrowBlock < MO_CarriedObject
  attr_accessor :playerID
  def initialize(nspr, x, y, superblock)
    super(nspr, x, y, 4, 2, 30, 30, 1, 1)
    
    @state = 2;
    @ih = nspr.getHeight() >> 1;
    @bounce = GRAVITATION;
    @objectType = object_moving;
    @movingObjectType = movingobject_throwblock;
    @playerID = -1;
    @fSuper = superblock;
	
    @iDeathTime = 0;
    @iBounceCounter = 0;
  end
  
  def moveToOwner()
    if(@owner)
      xi(@owner.ix + (@owner.isPlayerFacingRight() ? 14 : -22));
      yi(@owner.iy + PH - 32 + @collisionOffsetY);
    end
  end
	
  def update()
    game_values = $game_values
    if(game_values.blueblockttl > 0 && (@iDeathTime+=1) >= game_values.blueblockttl)
      $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @ix, @iy, 3, 8));
      @dead = true;
	
      if(@owner)
        @owner.carriedItem = nil;
        @owner = nil;
      end
	
      return;
    end
		
    if(@owner)
      moveToOwner();
      @inair = true;
    else
      if(@iBounceCounter > 0)
        @iBounceCounter-=1;
      end
	
      @fOldX = @fx;
      @fOldY = @fy;
	
      collision_detection_map();
    end
	
    @animationtimer += 1
    if(@animationtimer == @animationspeed)
      @animationtimer = 0;
      @drawframe += @iw;
      if(@drawframe >= @animationWidth)
        @drawframe = 0;
      end
    end
  end
	
  def draw()
    if(@owner && @owner.iswarping())
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @fSuper ? 32 : 0, @iw, @ih, @owner.state % 4, @owner.getWarpPlane());
    else
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @fSuper ? 32 : 0, @iw, @ih);
    end
	
    if(@fSmoking)
      $eyecandyback.add(EC_SingleAnimation.new($spr_burnup, @ix - @collisionOffsetX + (iw >> 1) - 16, @iy - @collisionOffsetY + (@ih >> 1) - 16, 5, 3));
    end
  end
	
  def collide(player)
    if(player.fOldY + PH <= @iy && player.iy + PH >= @iy)
      return hitTop(player);
    else
      return hitOther(player);
    end
  end
	
  def hitTop(player)
    if(player.invincible)
      die();
    else
      if(@state == 1) #moving
        return killPlayer(player);
      elsif(@state == 2) #Holding
        if(player != owner)
          if(@owner)
            @owner.carriedItem = nil;
          end
	
          kick(false);
	
          player.yi(@iy - PH - 1);
          player.bouncejump();
          player.collision_detection_checktop();
          player.platform = nil;
        end
      end
    end
	
    return false;
  end
	
  def hitOther(player)
    if(@state == 1)  #Moving
      flipx = 0;
	
      if(player.ix + PW < 320 && @ix > 320)
        flipx = 640;
      elsif(@ix + @iw < 320 && player.ix > 320)
        flipx = -640;
      end
	
      if((player.ix + flipx > @ix && @velx > 0.0) || (player.ix + flipx <= @ix && @velx < 0.0))
        return killPlayer(player);
      end
    elsif(@state == 2)  #Holding
      if(player != @owner)
        @playerID = @owner.globalID;
        return killPlayer(player);
      end
    end
	
    return false;
  end
	
  def killPlayer(player)
    if(player.invincible)
      die();
      return false;
    end
	
    if(player.spawninvincible)
      return false;
    end
	
    if(!@fSuper)
      die();
    end
    game_values = $game_values
    #Find the player that shot this shell so we can attribute a kill
    killer = getPlayerFromGlobalID(@playerID);
	
    if(killer && killer.globalID != player.globalID)
      playerKilledPlayer(killer, player, death_style_jump, kill_style_throwblock);
    else
      player.deathAwards();
	    
      if(!game_values.gamemode.playerkilledself(player))
        player.die(0, false);
      end
	
      ifsoundonplay($sfx_deathsound);
    end
	
    return true;
  end
	
  def die()
    $eyecandyfront.add(EC_FallingObject.new($spr_brokenblueblock, @ix, @iy, -1.5, -7.0, 6, 2, 0, @fSuper ? 16 : 0, 16, 16));
    $eyecandyfront.add(EC_FallingObject.new($spr_brokenblueblock, @ix + 16, @iy, 1.5, -7.0, 6, 2, 0, @fSuper ? 16 : 0, 16, 16));
    $eyecandyfront.add(EC_FallingObject.new($spr_brokenblueblock, @ix, @iy + 16, -1.5, -4.0, 6, 2, 0, @fSuper ? 16 : 0, 16, 16));
    $eyecandyfront.add(EC_FallingObject.new($spr_brokenblueblock, @ix + 16, @iy + 16, 1.5, -4.0, 6, 2, 0, @fSuper ? 16 : 0, 16, 16));
		
    @dead = true;
    ifsoundonplay($sfx_breakblock);
	
    if(@owner)
      @owner.carriedItem = nil
      @owner = nil;
    end
  end

	
  def drop()
    kick(false);
  end
	
  def kick(superkick)
    vel = 6.5;
    if(superkick)
      vel = 12.0;
      @fSmoking = true;
      ifsoundonplay($sfx_cannon);
    end
	
    @iDeathTime = 0;
	
    @velx = @owner.isPlayerFacingRight() ? vel : -vel;
    @vely = 0.0;
	
    @playerID = @owner.globalID;
	
    @owner = nil;
	
    @state = 1;
    ifsoundonplay($sfx_kicksound);
	
    #collision_detection_checksides();
  end
end
class CO_Spring < MO_CarriedObject
end
class CO_Spike < CO_Spring
end
class CO_Bomb < MO_CarriedObject
  def initialize(nspr, x, y, fVelX, fVelY, aniSpeed, iGlobalID, iTeamID, iColorID, timetolive)
    super(nspr, x, y, 5, aniSpeed, 24, 24, 4, 14)
    @iw = 28;
    @ih = 38;
	
    @bounce = GRAVITATION;
	
    @playerID = iGlobalID;
    @teamID = iTeamID;
    @iColorOffsetY = (iColorID + 1) * 38;
		
    @movingObjectType = movingobject_bomb;
    @state = 1;
	
    @ttl = timetolive;
	
    @velx = fVelX;
    @vely = fVelY;
  end
  
  def collide(player)
    if(@state == 1 && @owner == nil)
      if(player.acceptItem(self))
        @owner = player;

        @velx = 0.0;
        @vely = 0.0;
	
        if(@playerID == -1)
          @playerID = owner.globalID;
          @teamID = owner.teamID;
          iColorOffsetY = (owner.colorID + 1) * 38;
        end
      end
    end
    return false
  end
  
  def update()
    @ttl -= 1
    if(@ttl <= 0)
      die();
    end
	
    if(@dead)
      return;
    end
	
    if(@owner)
      moveToOwner();
    else
      #Add air/ground friction
      if(@velx > 0.0)
        if(@inair)
          @velx -= VELAIRFRICTION;
        elsif(@onice)
          @velx -= VELICEFRICTION;
        else
          @velx -= VELMOVINGFRICTION;
        end
	
        if(@velx < 0.0)
          velx = 0.0;
        end
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
	
      #Collision detect map
      @fOldX = @fx;
      @fOldY = @fy;
	
      collision_detection_map();
    end
		
    @animationtimer += 1
	
    if(@animationtimer == @animationspeed)
      @animationtimer = 0;
			
      @drawframe += @iw;
      if(@drawframe >= @animationWidth)
        @drawframe = 0;
      end
    end
  end
  def moveToOwner()
    if(@owner)
      xi(@owner.ix + (@owner.isPlayerFacingRight() ? 14 : -16));
      yi(@owner.iy + PH - 40 + @collisionOffsetY);
    end
  end

  def die
    if(@owner)
      @owner.carriedItem = nil;
      @owner = nil;
    end
	  
    if(@playerID > -1 && $projectiles[@playerID] > 0)
      $projectiles[@playerID]-=1;
    end
	  
    @dead = true;
    $objectsfront.add(OMO_Explosion.new($spr_explosion, @ix + (@iw >> 2) - 96, @iy + (@ih >> 2) - 64, 2, 4, @playerID, @teamID));
    ifsoundonplay($sfx_bobombsound);
  end
  def draw
    if(owner && owner.iswarping())
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @iColorOffsetY, @iw, @ih, owner.state % 4, owner.getWarpPlane());
    else
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, @iColorOffsetY, @iw, @ih);
    end
  end
  
  def drop
    if(@owner)
      @owner.carriedItem = nil;
    end
	
    @owner = nil;
	
    collision_detection_checksides();
  end
  
  def kick(superkick)
    @velx = owner.velx + (owner.isPlayerFacingRight() ? 2.0 : -2.0);
    @vely = -4.0;
    ifsoundonplay($sfx_kicksound);
	
    drop();
  end
end