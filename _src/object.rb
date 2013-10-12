require 'objecttype'
$g_tanookiFlag = 0 #weird to put in here?
class CObject
  attr_accessor :index,:dead,:state,:ix,:iy,:collisionWidth,:collisionHeight
  attr_accessor :iw,:ih
  def initialize(nspr, x, y)
    @dead = false;
	
    @spr = nspr;
    xi(x);
    yi(y);
	
    @iw = @spr.getWidth();
    @ih = @spr.getHeight();
	
    @velx = 0.0;
    @vely = 0.0;
		
    @state = 0;
	
    @collisionWidth = @iw;
    @collisionHeight = @ih;
    @collisionOffsetX = 0;
    @collisionOffsetY = 0;
	
    @iNetworkID = $g_iNextNetworkID;
    $g_iNextNetworkID+=1
  end
  
  def  draw()
    #puts("CObject::draw() - NO!");
  end
  def  update()
    #puts("CObject::update() - NO!");
  end
  def  collide(object)
    puts("CObject::collide() - NO!"); 
    return false;
  end
	
  def getObjectType()
    puts("CObject::getObjectType() - NO!"); 
    return object_none;
  end
  
  def xf(xf)
    @fx = xf; @ix = @fx.to_i;
  end
  def xi(xi)
    @ix = xi; @fx = @ix.to_f;
  end
  def yf(yf)
    @fy = yf; 
    if(@fy < 0.0) 
      @iy = (@fy - 1.0).to_i; 
    else 
      @iy = @fy.to_i
    end
  end
  def yi(yi)
    @iy = yi; @fy = @iy.to_i;
  end
  
  def getDead() 
    @dead
  end
  
  def getState
    @state
  end
  
  def halfCollisionWidth
    @collisionWidth >> 1
  end

end
class IO_Block < CObject
  def initialize(nspr, x, y)
    super(nspr, x, y)
    @bumpPlayer = nil

    @fposx = @fx;
    @fposy = @fy;
	
    @iposx = x;
    @iposy = y;
	
    @col = x / TILESIZE;
    @row = y / TILESIZE;
  end
  def getObjectType
    return object_block
  end
  def getBlockType()
    puts("CObject::getBlockType() - NO!"); 
    return block_none;
  end
  def isTransparent() 
    return false;
  end
  
  def collide(o, direction, useBehavior)
    if(direction == 2)
      return hittop(o, useBehavior);
    elsif(direction == 0)
      return hitbottom(o, useBehavior);
    elsif(direction == 1)
      return hitleft(o, useBehavior);
    else
      return hitright(o, useBehavior);
    end
  end
	
  def hittop(o, useBehavior)
    if(useBehavior)
      o.yf((@iposy - o.collisionHeight) - 0.2);
      #o.yf((@iposy - o.collisionHeight));
      o.inair = false;
      o.fallthrough = false;
      o.killsinrowinair = 0;
      o.featherjump = 0;
      o.vely = o.bottomBounce();
      o.fOldY = o.fy #does this necessary?
      #o.hittop
    end
	
    return false;
  end
  def fallthrough
    false
  end
  def hitbottom(o, useBehavior)
    if(useBehavior)
      #Player bounces off 
      o.hitbottom
			
      o.yf((@iposy + @ih) + 0.2);
      o.fOldY = o.fy #does this necessary?
    end
	
    return false;
  end
	
  def hitright(o, useBehavior)
    if(useBehavior)
      o.xf((@iposx + @iw) + 0.2);
      o.fOldX = o.fx;
			
      o.hitright
    end
	
    return false;
  end
	
  def hitleft(o, useBehavior)
    if(useBehavior)
      o.xf((@iposx - o.collisionWidth) - 0.2);
      o.fOldX = o.fx;
			
      o.hitleft
    end
	
    return false;
  end
end
class B_PowerupBlock < IO_Block
  def initialize(nspr, x, y, iNumSpr, aniSpeed)
    super(nspr, x, y)
    @iw = nspr.getWidth() >> 2;
    @ih = @spr.getHeight() >> 1;  #This sprite has two images (unused and used blocks)
    @collisionWidth = @iw;
    @timer = 0;
    @side = true;
    @iNumSprites = iNumSpr;
    @animationSpeed = aniSpeed;
    @animationTimer = 0;
    @animationWidth = nspr.getWidth();
    @drawFrame = 0;
  end
  def getBlockType()
    return block_powerup;
  end
  def draw
    @spr.draw(@ix, @iy, @drawFrame, @state == 0 ? 0 : @ih, @iw, @ih);
  end
  
  def update
    game_values = $game_values
    if(@state > 0)
      yf(@fy + @vely);
      if(@state == 1 && (@fposy - @fy).abs > 10.0)
        @vely = -@vely;
        @state = 2;
        @bumpPlayer = nil;
      elsif(@state == 2 && (@fposy - @fy).abs < VELBLOCKBOUNCE)
        @vely = 0.0;
        @state = 3;
        yi(@iposy);
	
        iSelectedPowerup = selectPowerup();
		iSelectedPowerup = rand(15) +1
		iSelectedPowerup = 9 if iSelectedPowerup == 8
        if (-1 == iSelectedPowerup) 
          $objectcollisionitems.add(PU_Tanooki.new(@ix + 1, @iy + 1));
        elsif(0 == iSelectedPowerup)
          $objectcollisionitems.add(PU_PoisonPowerup.new($spr_poisonpowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(1 == iSelectedPowerup)
          $objectcollisionitems.add(PU_ExtraGuyPowerup.new($spr_1uppowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1, 1));
        elsif(2 == iSelectedPowerup)
          $objectcollisionitems.add(PU_ExtraGuyPowerup.new($spr_2uppowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1, 2));
        elsif(3 == iSelectedPowerup)
          $objectcollisionitems.add(PU_ExtraGuyPowerup.new($spr_3uppowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1, 3));
        elsif(4 == iSelectedPowerup)
          $objectcollisionitems.add(PU_ExtraGuyPowerup.new($spr_5uppowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1, 5));
        elsif(5 == iSelectedPowerup)
          $objectcollisionitems.add(PU_FirePowerup.new($spr_firepowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(6 == iSelectedPowerup)
          $objectcollisionitems.add(PU_StarPowerup.new($spr_starpowerup, @ix + 1, @iy - 1, 4, @side, 2, 30, 30, 1, 1));
        elsif(7 == iSelectedPowerup)
          $objectcollisionitems.add(PU_ClockPowerup.new($spr_clockpowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(8 == iSelectedPowerup)
          $objectcollisionitems.add(PU_BobombPowerup.new($spr_bobombpowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(9 == iSelectedPowerup)
          $objectcollisionitems.add(PU_PowPowerup.new($spr_powpowerup, @ix + 1, @iy - 1, 8, @side, 8, 30, 30, 1, 1));
        elsif(10 == iSelectedPowerup)
          $objectcollisionitems.add(PU_BulletBillPowerup.new($spr_bulletbillpowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(11 == iSelectedPowerup)
          $objectcollisionitems.add(PU_HammerPowerup.new($spr_hammerpowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(12 == iSelectedPowerup)
          $objectsplayer.add(CO_Shell.new(0, @ix + 1, @iy - 1, true, true, true, false));
        elsif(13 == iSelectedPowerup)
          $objectsplayer.add(CO_Shell.new(1, @ix + 1, @iy - 1, false, true, true, false));
        elsif(14 == iSelectedPowerup)
          $objectsplayer.add(CO_Shell.new(2, @ix + 1, @iy - 1, false, false, true, true));
        elsif(15 == iSelectedPowerup)
          $objectsplayer.add(CO_Shell.new(3, @ix + 1, @iy - 1, false, true, false, false));
        elsif(16 == iSelectedPowerup)
          $objectcollisionitems.add(PU_ModPowerup.new($spr_modpowerup, @ix + 1, @iy - 1, 8, @side, 8, 30, 30, 1, 1));
        elsif(17 == iSelectedPowerup)
          $objectcollisionitems.add(PU_FeatherPowerup.new($spr_featherpowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(18 == iSelectedPowerup)
          $objectcollisionitems.add(PU_MysteryMushroomPowerup.new($spr_mysterymushroompowerup, @ix + 1, @iy - 1, 1, @side, 32000, 30, 30, 1, 1));
        elsif(19 == iSelectedPowerup)
          $objectcollisionitems.add(PU_BoomerangPowerup.new($spr_boomerangpowerup, ix + 1, iy - 1, 1, @side, 32000, 30, 26, 1, 5));
        end
        ifsoundonplay($sfx_sprout);
      elsif(state == 3)
        @timer += 1
        #if(@timer >= game_values.itemrespawntime)
        if(@timer >= 3)
          @timer = 0;
          @state = 0;
        end
      end
    end
  
    @animationTimer += 1
    if(@animationTimer >= @animationSpeed)
      @animationTimer = 0;
		
      @drawFrame += @iw;
      if(@drawFrame >= @animationWidth)
        @drawFrame = 0;
      end
    end
  end
  
  def selectPowerup
    return rand(4) + 12
    game_values = $game_values
    if ($g_tanookiFlag > 0) 
      $g_tanookiFlag-=1; 
      return -1;
    end
	
    iCountWeight = 0;
    NUM_POWERUPS.times do|iPowerup|
      iCountWeight += game_values.powerupweights[iPowerup];
    end
	
    if(iCountWeight == 0)
      iCountWeight = 1;
    end
	
    iRandPowerup = rand(iCountWeight) + 1;
    iSelectedPowerup = 0;
    iPowerupWeightCount = game_values.powerupweights[iSelectedPowerup];
	
    while(iPowerupWeightCount < iRandPowerup)
      iPowerupWeightCount += game_values.powerupweights[(iSelectedPowerup+=1)];
    end
    iSelectedPowerup = 9 if iSelectedPowerup == 8 #we avoid bombob
    return iSelectedPowerup;
  end
  
  def hitbottom(o, useBehavior)
    if(useBehavior)
      #Player bounces off 
      o.vely = capFallingVelocity(-o.vely * BOUNCESTRENGTH);
      o.yf((@iposy + @ih) + 0.2);
	
      ifsoundonplay($sfx_bump);
	
      if(@state == 0)
        @bumpPlayer = o;
        @vely = -VELBLOCKBOUNCE;
        @state = 1;
        @side = o.ix + o.halfCollisionWidth < @ix + (@iw >> 1);
      end
    end
    return false
  end
end
class B_ViewBlock < B_PowerupBlock
end
class B_BreakableBlock < IO_Block
  def initialize(nspr, x, y, iNumSpr, aniSpeed)
    super(nspr, x, y)
    @iw = nspr.getWidth() >> 2;
    @iNumSprites = iNumSpr;
    @animationSpeed = aniSpeed;
    @animationTimer = 0;
    @animationWidth = nspr.getWidth();
    @drawFrame = 0;
  end
  def getBlockType()
    return block_breakable;
  end
  
  def draw()
    if(@state == 0)
      @spr.draw(@ix, @iy, @drawFrame, 0, @iw, @ih);
    end
  end
  def update
    if(@state > 0)
      if(@state == 1)
        @state = 2;
      elsif(state == 2)
        @bumpPlayer = nil;
        @dead = true;
        $g_map.blockdata[@col][@row] = nil;
      end
    end
    @animationTimer += 1
    if(@animationTimer >= @animationSpeed)
      @animationTimer = 0;
		
      @drawFrame += @iw;
      if(@drawFrame >= @animationWidth)
        @drawFrame = 0;
      end
    end
  end
  
  def hitbottom(o, useBehavior = true)
    if(useBehavior && @state == 0)
      triggerBehavior();
      
      o.vely = capFallingVelocity(-o.vely * BOUNCESTRENGTH);
      o.yf((@iposy + @ih) + 0.2);
      
      @bumpPlayer = o if o.class == CPlayer #actually we all invoke hitbottom from Player
    end
    return false
  end
  def triggerBehavior
    if(@state == 0)
      $eyecandyfront.add(EC_FallingObject.new($spr_brokenyellowblock, @ix, @iy, -2.2, -10.0, 4, 2, 0, 0, 0, 0));
      $eyecandyfront.add(EC_FallingObject.new($spr_brokenyellowblock, @ix + 16, @iy, 2.2, -10.0, 4, 2, 0, 0, 0, 0));
      $eyecandyfront.add(EC_FallingObject.new($spr_brokenyellowblock, @ix, @iy + 16, -2.2, -5.5, 4, 2, 0, 0, 0, 0));
      $eyecandyfront.add(EC_FallingObject.new($spr_brokenyellowblock, @ix + 16, @iy + 16, 2.2, -5.5, 4, 2, 0, 0, 0, 0));
	
      @state = 1;
      ifsoundonplay($sfx_breakblock);
    end
  end

end
class B_NoteBlock < IO_Block
  def initialize(nspr, x, y, iNumSpr, aniSpeed)
    super(nspr, x, y)
    @iw = nspr.getWidth() >> 2;
    @iNumSprites = iNumSpr;
    @animationSpeed = aniSpeed;
    @animationTimer = 0;
    @drawFrame = 0;
    @animationWidth = @spr.getWidth();
  end
  def getBlockType()
    return block_note;
  end
  
  def update
    if(@state > 0)
			xf(@fx + @velx);
			yf(@fy + @vely);
	
			if(@state == 1 && (@fposx - @fx).abs > 10.0)
				@velx = -@velx;
				@state = 2;
			elsif(@state == 2 && (@fposx - @fx).abs < VELNOTEBLOCKBOUNCE)
				@velx = 0.0;
				@state = 0;
				xf(@fposx);
				yf(@fposy);
			elsif(@state == 3 && (@fposy - @fy).abs > 10.0)
				@vely = -@vely;
				@state = 4;
			elsif(@state == 4 && (@fposy - @fy).abs < VELNOTEBLOCKBOUNCE)
				@vely = 0.0;
				@state = 0;
				xf(@fposx);
				yf(@fposy);
				@bumpPlayer = nil;
			end
		end
	
	  @animationTimer += 1
		if(@animationTimer >= @animationSpeed)
			@animationTimer = 0;
	
			@drawFrame += @iw;
			if(@drawFrame >= @animationWidth)
				@drawFrame = 0;
			end
		end
  end
  
  def hittop(player, useBehavior)
		super(player, useBehavior);
	
		if(useBehavior && player.class == CPlayer)
			player.superjumptimer = 4;
			player.vely = -VELNOTEBLOCKREPEL;
		
			if(@state == 0)
				@vely = VELNOTEBLOCKBOUNCE;
				@state = 3;
			end
	
			ifsoundonplay($sfx_bump);
		end
		
		return false;
	end
	
	def hitbottom(player, useBehavior)
		if(useBehavior)
			player.yf((@iposy + @ih) + 0.2);
			player.vely = VELNOTEBLOCKREPEL;
	
			if(@state == 0)
				@bumpPlayer = player;
				@vely = -VELNOTEBLOCKBOUNCE;
				@state = 3;
			end
	
			ifsoundonplay($sfx_bump);
		end
	
		return false;
	end
	
	def hitright(player, useBehavior)
		if(useBehavior)
			player.xf((@iposx + @iw) + 0.2);
			player.fOldX = player.fx;
			player.velx = VELNOTEBLOCKREPEL;
	
			if(@state == 0)
				@velx = -VELNOTEBLOCKBOUNCE;
				@state = 1;
			end
	
			ifsoundonplay($sfx_bump);
		end
	
		return false;
	end
	
	def hitleft(player, useBehavior)
		if(useBehavior)
			player.xf((@iposx - PW) - 0.2);
			player.fOldX = player.fx;
			player.velx = -VELNOTEBLOCKREPEL;
	
			if(@state == 0)
				@velx = VELNOTEBLOCKBOUNCE;
				@state = 1;
			end
	
			ifsoundonplay($sfx_bump);
		end
	
		return false;
	end
  
  def draw
    #puts "drawing B_NoteBlock"
    @spr.draw(@ix, @iy, @drawFrame, 0, @iw, @ih);
  end
  
end
class B_DonutBlock < IO_Block
end
class B_FlipBlock < IO_Block
  def isTransparent() 
    return @state != 0;
  end
end
class B_BounceBlock < IO_Block
end
class B_ThrowBlock < IO_Block
  def initialize(nspr, x, y, iNumSpr, aniSpeed)
    super(nspr, x, y)
    
    @iw = nspr.getWidth() >> 2;
		@ih = nspr.getHeight() >> 1;
		@iNumSprites = iNumSpr;
		@animationSpeed = aniSpeed;
		@animationTimer = 0;
		@drawFrame = 0;
		@animationWidth = nspr.getWidth();
		@fSuper = false;
  end
  def getBlockType()
    return block_throw;
  end
  
  def draw
  	@spr.draw(@ix, @iy, @drawFrame, @fSuper ? 32 : 0, @iw, @ih);
  end
  
  def update()
    @animationTimer += 1
		if(@animationTimer >= @animationSpeed)
			@animationTimer = 0;
	
			@drawFrame += @iw;
			if(@drawFrame >= @animationWidth)
				@drawFrame = 0;
			end
		end
	end
	
	def hittop(player, useBehavior)
		if(useBehavior && player.class == CPlayer)
			if(player.pressedAcceptItemKey() && player.isAcceptingItem())
				giveBlockToPlayer(player);
				return true;
			
			else
				player.yf((@iposy - PH) - 0.2);
				player.fOldY = player.fy;
				player.inair = false;
				player.fallthrough = false;
				player.killsinrowinair = 0;
				player.featherjump = 0;
				player.vely = GRAVITATION;
				return false;
			end
		end
	
		return false;
	end
	
	def hitright(player, useBehavior)
		if(useBehavior && player.class == CPlayer)
			if(player.isAcceptingItem())
				giveBlockToPlayer(player);
				return true;
			else
				player.xf((@iposx + @iw) + 0.2);
				player.fOldX = player.fx;
	
				if(player.velx < 0.0)
					player.velx = 0.0;
				end
	
				return false;
			end
		end
		
		return true;
	end
	
	def hitleft(player, useBehavior)
		if(useBehavior && player.class == CPlayer)
			if(player.isAcceptingItem())
				giveBlockToPlayer(player);
				return true;
			else
				player.xf((@iposx - PW) - 0.2);
				player.fOldX = player.fx;
	
				if(player.velx > 0.0)
					player.velx = 0.0;
				end
	
				return false;
			end
		end
		
		return true;
	end
	
	def giveBlockToPlayer(player)
		@dead = true;
		$g_map.blockdata[@col][@row] = nil;
	
		block = CO_ThrowBlock.new($spr_blueblock, @ix, @iy, @fSuper);
		if(player.acceptItem(block))
			block.owner = player;
			block.playerID = player.globalID;
			$objectsplayer.add(block);
		else
			#delete block;
		end
	end



	
	def setType(superblock)
	  @fSuper = superblock;
  end
end
class B_OnOffSwitchBlock < IO_Block
end
class B_SwitchBlock < IO_Block
  def isTransparent() 
    return @state != 0;
  end
end
require 'io_movingobjects' 
require 'powerup'

class CObjectContainer
  def initialize
    @list = []
  end
  def clean()
    @list = []
  end
  
  def add(ec)
    ec.index = @list.size
    @list << ec
    #need we ec.index?
    ec.dead = false
  end
  
  def each
    @list.each do |x|
      yield x
    end
  end
  
  def isBlockAt()
  end
  
  def update()
    @list.each do |x|
      x.update();
    end
  end
	
  def draw()
    @list.each do |x|
      x.draw();
    end
  end
  def cleandeadobjects
    @list.delete_if {|x| x.dead}
  end
  
  def countTypes(type)
    @list.select {|x| x.getObjectType() == type}.size
  end
end

class MysteryMushroomTempPlayer
end

def removeifprojectile(object, playsound, forcedead)
  game_values = $game_values
  if((object.movingObjectType == movingobject_fireball || object.movingObjectType == movingobject_superfireball || object.movingObjectType == movingobject_hammer || object.movingObjectType == movingobject_sledgehammer || object.movingObjectType == movingobject_boomerang) && !object.dead)
    iPlayerID = -1;
    fDie = true;
		
    if(object.movingObjectType == movingobject_fireball)
      iPlayerID = object.playerID;
    elsif(object.movingObjectType == movingobject_hammer)
      iPlayerID = object.playerID;
		  
      if(!game_values.hammerpower)
        fDie = false;
      end
    elsif(object.movingObjectType == movingobject_sledgehammer)
      iPlayerID = hammer.playerID;
      hammer.explode();
    elsif(object.movingObjectType == movingobject_boomerang)
      iPlayerID = object.playerID;
      game_values.superboomerang[iPlayerID] = 0;
    elsif(object.movingObjectType == movingobject_superfireball)
      iPlayerID = object.playerID;
    end
	  
    if(fDie || forcedead)
      if(iPlayerID > -1 && $projectiles[iPlayerID] > 0)
        $projectiles[iPlayerID]-=1;
      end
			
      object.dead = true;
      $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, object.ix + (object.iw >> 1) - 16, object.iy + (object.ih >> 1) - 16, 3, 4));
    end
	  
    if(playsound)
      ifsoundonplay($sfx_hit);
    end
  end
end