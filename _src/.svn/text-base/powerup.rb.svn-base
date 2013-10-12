class MO_Powerup < IO_MovingObject
  def initialize(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth = -1, iCollisionHeight = -1, iCollisionOffsetX = -1, iCollisionOffsetY = -1)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @desty = @fy - @collisionHeight;
    @movingObjectType = movingobject_powerup;
    @bounce = GRAVITATION;
  end
  
  def draw
    if(@state == 0)
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, 0, @iw, (@ih - @fy + @desty));
    else
      @spr.draw(@ix - @collisionOffsetX, @iy - @collisionOffsetY, @drawframe, 0, @iw, @ih);
    end
  end
  
  def update()
    #Have the powerup grow out of the powerup block
    if(@state == 0)
      yf(@fy - 2.0);
	
      if(@fy <= @desty)
        @state = 1;
        @vely = 1.0;
      end
    else #Then have it obey the physics
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
  
  def collide(player)
    @dead = true;
    return false;
  end
  
  def getMovingObjectType() 
    @movingObjectType
  end
end
class PU_Tanooki < MO_Powerup
  def initialize(x, y)
    super($spr_tanooki, x, y, 1, 32000, 30, 30, 1, 1)
  end
  def collide(player)
    game_values = $game_values
    @dead = true;

    if(player.tanooki)
      ifsoundonplay($sfx_storepowerup);
      game_values.gamepowerups[player.globalID] = 20;
    else
      ifsoundonplay($sfx_collectpowerup);
      player.tanooki = true;
    end
    return false;
  end
end
class PU_StarPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    if(moveToRight)
      @velx = 2.0;
    else
      @velx = -2.0;
    end
	
    @bounce = -VELPOWERUPBOUNCE;
  end
  
  def collide(player)
    game_values = $game_values
    @dead = true;
	
    if(!player.invincible)
      player.makeinvincible();
    else
      ifsoundonplay($sfx_storepowerup);
      game_values.gamepowerups[player.globalID] = 6;
    end
	
    return false;
  end
end
class PU_ExtraGuyPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY, type)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    if(moveToRight)
      @velx = 1.0 + type;
    else
      @velx = -1.0 - type;
    end

    @iType = type;
  end
  
  def collide(player)
    #$game_values.gamemode.playerextraguy(player, iType);
    ifsoundonplay($sfx_extraguysound);
	
    $eyecandyfront.add(EC_FloatingObject.new($spr_extralife, player.ix + HALFPW - 19, player.iy - 16, 0.0, -1.5, 62, player.colorID * 38, (@iType == 5 ? 3 : @iType - 1) * 16, 38, 16));
    puts "I'm dead"
    @dead = true;
    return false;
  end
end
class PU_PoisonPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    
    if(moveToRight)
      @velx = 2.0;
    else
      @velx = -2.0;
    end
	
    @movingObjectType = movingobject_poisonpowerup;
  end
  
  def collide(player)
    game_values = $game_values
    if(player.invincible)
      @dead = true;
      return false;
    end
	
    if(player.spawninvincible)
      return false;
    end
	
    player.deathAwards();
		
    if(!game_values.gamemode.playerkilledself(player))
      player.die(0, false);
    end
		
    ifsoundonplay($sfx_deathsound);
	
    @dead = true;
	
    return true;
  end

end
class PU_MysteryMushroomPowerup < MO_Powerup
end
class PU_FirePowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  def collide(player)
		player.setPowerup(1);
		@dead = true;
		return false;
	end
end
class PU_HammerPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  
  def collide(player)
		player.setPowerup(2);
		@dead = true;
		return false;
	end
end
class PU_SledgeHammerPowerup < MO_Powerup
end
class PU_PodoboPowerup < PU_SledgeHammerPowerup
end
class PU_ClockPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  
  def collide(player)
    game_values = $game_values
		@dead = true;
		ifsoundonplay($sfx_storepowerup);
		game_values.gamepowerups[player.globalID] = 7;
		return false;
  end
end
class PU_BobombPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  
  def collide(player)
    game_values = $game_values
		@dead = true;
	
		if(player.bobomb)
			ifsoundonplay($sfx_storepowerup);
			game_values.gamepowerups[player.globalID] = 8;
		else
			$eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, player.ix + (HALFPW) - 16, player.iy + (HALFPH) - 16, 3, 8));
			#ifsoundonplay($sfx_transform);
			player.bobomb = true;
		end
	
		return false;
	end
end
class PU_BombPowerup < PU_SledgeHammerPowerup
end
class PU_PowPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  
  def collide(player)
		@dead = true;
		ifsoundonplay($sfx_storepowerup);
		$game_values.gamepowerups[player.globalID] = 9;
	
		return false;
	end
end
class PU_ModPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  def collide(player)
		@dead = true;
		ifsoundonplay($sfx_storepowerup);
		$game_values.gamepowerups[player.globalID] = 16;
	
		return false;
	end
end
class PU_BulletBillPowerup < MO_Powerup
  def initialize(nspr, x, y, iNumSpr, moveToRight, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    super(nspr, x, y, iNumSpr, aniSpeed, iCollisionWidth, iCollisionHeight, iCollisionOffsetX, iCollisionOffsetY)
    @velx = 0.0;
  end
  
  def collide(player)
		@dead = true;
		ifsoundonplay($sfx_storepowerup);
		$game_values.gamepowerups[player.globalID] = 10;
	
		return false;
	end
end
class PU_FeatherPowerup < IO_MovingObject
end
class PU_BoomerangPowerup < MO_Powerup
end