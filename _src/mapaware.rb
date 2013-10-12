module MapAware
  def collision_detection_map
    #logfor(0)
    xf(@fx + @velx);
  
    flipsidesifneeded();
  
    @fPrecalculatedY = @fy + @vely;  #Fixes weird float rounding error.  Must be computed here before casting to int.  Otherwise, this will miss the bottom collision, but then hit the side collision and the player can slide out of 1x1 spaces.
  
    fPlatformVelX = 0.0;
    fPlatformVelY = 0.0;
	
    fTempY = @fy;
   
    if(@platform)
      fPlatformVelX = @platform.fVelX;
      xf(@fx + fPlatformVelX);
      flipsidesifneeded();
		
      fPlatformVelY = @platform.fVelY;
		
      if(@platform.fOldVelY < 0.0)
        @fy += @platform.fOldVelY;
      end
		
      @fPrecalculatedY += @platform.fOldVelY;
    end
  
    @iHorizontalPlatformCollision = -1;
    @iVerticalPlatformCollision = -1;
	
    $g_map.movingPlatformCollision(self);
	
    #quick return check
    if(self.class == CPlayer && @state != player_ready)
      return;
    end
	
    @fy = fTempY; #reset back fy
   
    
    if(@fPrecalculatedY + collisionHeight < 0.0)
      # on top outside of the screen
      yf(@fPrecalculatedY);
    
      @vely = capFallingVelocity(GRAVITATION + @vely);
		
      if(!@platform)
        @inair = true;
        @onice = false;
        @superjumptimer = 0;
        @fallthrough = false;
      end
      return
    elsif(@fPrecalculatedY + collisionHeight >= 480.0)
      #on ground outside of the screen?
      yi(-collisionHeight);
      @fOldY = @fy - 1;
      @fallthrough = false;
      @onice = false;

      return;
    end
  
    #Could be optimized with bit shift >> 5
  
    ty = (@fy.to_i / TILESIZE).to_i;
    ty2 = ((@fy.to_i + collisionHeight) / TILESIZE).to_i;
    tx = -1;
  
    ##-----------------------------------------------------------------
    ##  x axis (--)
    ##-----------------------------------------------------------------
    if(@fy + collisionHeight >= 0.0)
      collisionWithXAxis(fPlatformVelX, fPlatformVelY)
    end
    
    ##-----------------------------------------------------------------
    ##  then y axis (|)
    ##-----------------------------------------------------------------
    
    txl = -1; 
    txr = -1;
    txc = -1;
    
    txl = @ix / TILESIZE;
    
    if(txl < 0)
      txl += 20;
    elsif(txl > 19)
      txl -= 20;
    end
		
    if(@ix + collisionWidth/2 >= 640)
      txc = (@ix + collisionWidth/2 - 640) / TILESIZE;
    else
      txc = (@ix + collisionWidth/2) / TILESIZE;
    end
	
    if(@ix + collisionWidth >= 640)
      txr = (@ix + collisionWidth - 640) / TILESIZE;
    else
      txr = (@ix + collisionWidth) / TILESIZE;
    end
		
    #What block is the player aligned to (this will be the block that has the action on it)
    alignedBlockX = 0;
    unAlignedBlockX = 0;
    unAlignedBlockFX = 0;
		
    overlaptxl = txl * TILESIZE + TILESIZE + 1;
    if(overlaptxl > 639)
      overlaptxl -= 640;
    end
		
    if(@ix + halfCollisionWidth < overlaptxl)
      alignedBlockX = txl;
      unAlignedBlockX = txr;
      unAlignedBlockFX = (txr * TILESIZE - collisionWidth) - 0.2;
    else
      alignedBlockX = txr;
      unAlignedBlockX = txl;
      unAlignedBlockFX = (txl * TILESIZE + TILESIZE) + 0.2;
    end
		
    fMovingUp = @vely;
    if(@platform)
      fMovingUp = @vely + fPlatformVelY - bounce;
    end
		
		g_map = $g_map
		game_values = $game_values
		
    if(fMovingUp < -0.01)
      #moving up
      @fallthrough = false;

      ty = (@fPrecalculatedY).to_i / TILESIZE;
		  
      leftblock = $g_map.block(txl, ty);
      centerblock = $g_map.block(txc, ty);
      rightblock = $g_map.block(txr, ty);
			if(@can_enter_warp)
	      if(g_map.warp(alignedBlockX, ty).direction == 2 && g_map.warp(unAlignedBlockX, ty).direction == 2 && @playerKeys.game_jump.fDown && 
				g_map.warp(alignedBlockX, ty).connection == g_map.warp(unAlignedBlockX, ty).connection && 
				!g_map.isconnectionlocked(g_map.warp(alignedBlockX, ty).connection) && !g_map.isconnectionlocked(g_map.warp(unAlignedBlockX, ty).connection) &&
				(!game_values.slowdownfreeze || game_values.slowdownon == @teamID))
					yf((ty * TILESIZE + TILESIZE) + 0.2);
					enterwarp(g_map.warp(unAlignedBlockX, ty));
					@warpplane = @iy;
					if(@ix - PWOFFSET < txl * TILESIZE + 1)
						xi(txl * TILESIZE + PHOFFSET + 1);
					elsif(@ix + PW + PWOFFSET > txr * TILESIZE + TILESIZE)
						xi(txr * TILESIZE + TILESIZE - PW - PWOFFSET);
					end
					
					return
				end
			end
			if(centerblock && !centerblock.isTransparent())
			  if(!centerblock.collide(self, 0, true))
			    if(@iVerticalPlatformCollision == 2)
					  killMapHazard();
					end
					return
			  end
		  end
		  
		  ##Player hit a solid, ice or death on top
			##or if the player is invincible and hits death or death on bottom
			if(g_map.map(alignedBlockX, ty) & 0x1 != 0 ||
				((invincible || spawninvincible) && (g_map.map(alignedBlockX, ty) & 0x4 != 0)))
					
					yf((ty * TILESIZE + TILESIZE) + 0.2);
					@fOldY = @fy - 1.0;
					
					if(@vely < 0.0)
				    @vely = -@vely * BOUNCESTRENGTH;
			    end
			    
			    if(@iVerticalPlatformCollision == 2)
			      killMapHazard();
			    end
			    return
			end
			
			if(leftblock && !leftblock.isTransparent()) #then left
			  useBehavior = alignedBlockX == txl || rightblock == nil || rightblock.isTransparent();
			  if(!leftblock.collide(self, 0, useBehavior))
			    if(@iVerticalPlatformCollision == 2)
			      killMapHazard();
			    end
			    return
			  end
		  end
		  
		  ##Player squeezed around the block, ice or death on top
		  ##or if the player is invincible and hits death or death on bottom
			if(g_map.map(unAlignedBlockX, ty) & 0x1 != 0 ||
			  ((invincible || spawninvincible) && (g_map.map(unAlignedBlockX, ty) & 0x4 != 0)))
			  xf(unAlignedBlockFX);
			  @fOldX = @fx;
			  
			  yf(@fPrecalculatedY);
			  @vely += GRAVITATION;
			elsif(g_map.map(alignedBlockX, ty) & 0x4 !=0 || g_map.map(unAlignedBlockX, ty) & 0x4 !=0)
				killPlayerMapHazard();
				return
		  else
		    yf(@fPrecalculatedY);
			  @vely += GRAVITATION;
			end
			if(!@platform)
        #@superjumptimer = 0;
        @inair = true;
        @onice = false
      end
			
			
    else
      #moving down
      ty = (@fPrecalculatedY + collisionHeight).to_i / TILESIZE;
      if(@can_enter_warp)
	      if($g_map.warp(txl,ty).direction == 0 && $g_map.warp(txr,ty).direction == 0 && @playerKeys.game_down.fDown && 
				$g_map.warp(txl, ty).connection == $g_map.warp(txr, ty).connection && 
				!$g_map.isconnectionlocked($g_map.warp(txl,ty).connection) && !$g_map.isconnectionlocked($g_map.warp(txr,ty).connection) && 
				(!game_values.slowdownfreeze || game_values.slowdownon == teamID))
				  yf((ty * TILESIZE - PH) - 0.2);
				  enterwarp($g_map.warp(txr,ty));	
				  @warpplane = @iy + PH + 1;
				  
				  @fallthrough = false;
				  @platform = nil;
				  
				  if(@ix - PWOFFSET < txl * TILESIZE + 1)
						xi(txl * TILESIZE + PHOFFSET + 1);
					elsif(@ix + PW + PWOFFSET > txr * TILESIZE + TILESIZE)
						xi(txr * TILESIZE + TILESIZE - PW - PWOFFSET);
				  end
				  
				  return
			  end
			end
	    
      leftblock = $g_map.block(txl, ty);
      rightblock = $g_map.block(txr, ty);
		  
      if((leftblock && !leftblock.isTransparent()) || 
            (rightblock && !rightblock.isTransparent()))
        collisionresult = true;
        if(leftblock && !leftblock.isTransparent()) #collide with left block
          collisionresult &= leftblock.collide(self, 2, alignedBlockX == txl || rightblock == nil || rightblock.isTransparent());
			    	
          #If player was bumped and killed then return
          return if short_circuit_to_process_map_collision
			    
        end
			  
        if(rightblock && !rightblock.isTransparent()) #then right
				
          collisionresult &= rightblock.collide(self, 2, alignedBlockX == txr || leftblock == nil || leftblock.isTransparent());
	
          #If player was bumped and killed then return
          return if short_circuit_to_process_map_collision
        end
				
        if(!collisionresult)
          @platform = nil;
          @onice = false;
          @inair = false; #this?
	
          if(@iVerticalPlatformCollision == 0)
            killPlayerMapHazard();
          end
	
          return;
        end
      end #end left block right block
		  
      lefttile = $g_map.map(txl, ty);
      righttile = $g_map.map(txr, ty);
		  
      fSolidTileUnderPlayer = (lefttile & 0x5) == 1 || lefttile == tile_death_on_bottom || (righttile & 0x5) == 1 || righttile == tile_death_on_bottom;
		  	
      if((lefttile == tile_solid_on_top || righttile == tile_solid_on_top) && @fOldY + collisionHeight <= ty * TILESIZE)
        if(fallthrough && !fSolidTileUnderPlayer)
          yf((ty * TILESIZE - collisionHeight) + 0.2);
          #yf((ty * TILESIZE) + 0.2);
          if(!@platform)
            @inair = true;
          end
          return
        else
          #logfor(0, "on top of tile")
          #logforObject()
          @vely = bottomBounce();
          #logfor(0, "ty is #{ty}")
          yf((ty * TILESIZE - collisionHeight) - 0.2 );
         
          #logforObject("here")
				  
				  
          if(!@platform)
            @inair = false;
            @onice = false;
            @featherjump = 0;
            @killsinrowinair = 0;
          end
        end
		    
        @fOldY = @fy - GRAVITATION;
		    
        if(!@platform)
          @fallthrough = false;
          @onice = false;
        end
				
        @platform = nil;
				
        if(@iVerticalPlatformCollision == 0)
          killMapHazard();
        end

        return;
		  	
				
				
				
      end #end left tile right tile
		  
      if(fSolidTileUnderPlayer ||
            ((invincible || spawninvincible) && (lefttile == tile_death_on_top || righttile == tile_death_on_top ||
                lefttile == tile_death || righttile == tile_death)))
					
        yf((ty * TILESIZE - collisionHeight) - 0.2 );
        @vely = bottomBounce();	
        
        #logforObject("here1")
			  
        @fOldY = @fy;
			  
        if(!@platform)
          alignedtile = $g_map.map(alignedBlockX, ty);

          if(alignedtile == tile_ice || (alignedtile == tile_nonsolid && $g_map.map(unAlignedBlockX, ty) == tile_ice))
            @onice = true;
          else 
            @onice = false;
          end
					
          @inair = false;
          @featherjump = 0;
          @killsinrowinair = 0;
					
        end
        @platform = nil;

        if(@iVerticalPlatformCollision == 0)
          killMapHazard();
          return;
        end
      elsif(lefttile == tile_death_on_top || righttile == tile_death_on_top ||
            lefttile == tile_death || righttile == tile_death)
        killMapHazard();
        return
      else
        #falling (in air)
        yf(@fPrecalculatedY);
        @vely = capFallingVelocity(GRAVITATION + @vely);
	
        if(!@platform)
          @superjumptimer = 0;
          @inair = true;
        end
      end
		  
		  
    end
    
    #not moving
    if(!@platform)
      @fallthrough = false;
      if(@inair)
        @onice = false;
      end
    end
	
	
    #     if @iy > 360 - PH
    #       yf(360-PH) 
    #       @vely = 0
    #     end
  end
  def collisionWithXAxis(fPlatformVelX,fPlatformVelY)
    ty = @fy.to_i / TILESIZE;
    ty2 = (@fy + collisionHeight).to_i / TILESIZE;
    g_map = $g_map
    game_values = $game_values
    if(@velx + fPlatformVelX > 0.01 || @iHorizontalPlatformCollision == 3)
      #moving right
      if(@fx + collisionWidth >= 640.0)
        tx = (@fx + collisionWidth - 640.0).to_i / TILESIZE;
        @fOldX -= 640.0;
      else
        tx = (@fx + collisionWidth).to_i / TILESIZE;
      end
	    
      #Just in case tx out of bounds and flipsidesifneeded wasnt called
      if(tx < 0)
        tx += 20;
      elsif(tx > 19)
        tx -= 20;
      end
      
			
      topblock = $g_map.block(tx, ty);
      bottomblock = $g_map.block(tx, ty2);
				
      #first check to see if player hit a warp
			if(@can_enter_warp)
			  if(g_map.warp(tx,ty).direction == 3 && g_map.warp(tx,ty2).direction == 3 && @playerKeys.game_right.fDown &&
					g_map.warp(tx,ty).connection == g_map.warp(tx,ty2).connection && 
					!g_map.isconnectionlocked(g_map.warp(tx,ty).connection) && !g_map.isconnectionlocked(g_map.warp(tx,ty2).connection) &&
					(!game_values.slowdownfreeze || game_values.slowdownon == @teamID))
						xf((tx * TILESIZE - collisionWidth) - 0.2);
						enterwarp(g_map.warp(tx, ty2));
						@warpplane = @ix + collisionWidth + 1;
						
						if(@iy - PHOFFSET < ty * TILESIZE)
							yi(ty * TILESIZE + PHOFFSET);
						elsif(iy + PH > ty2 * TILESIZE + TILESIZE - 3)
							yi(ty2 * TILESIZE + TILESIZE - PH - 3);
						end
						
						return
				end
		  end
				
      if((topblock && !topblock.isTransparent()) || 
            (bottomblock && !bottomblock.isTransparent()))
        processOtherBlock = true;
        if(topblock && !topblock.isTransparent()) #collide with top block
          #puts "hit topblock"
          if(@iHorizontalPlatformCollision == 3)
            killMapHazard();
            return
          end
          topblock.collide(self, 1, true);
          flipsidesifneeded();
          if self.class != CPlayer
            processOtherBlock = false
            #removeifprojectile(this, true, true);
            sideBounce();
          end
        elsif(processOtherBlock && bottomblock && !bottomblock.isTransparent())
          #puts "hit bottom block"
	          
          if(@iHorizontalPlatformCollision == 3)
            killMapHazard();
            return;
          end
	
          bottomblock.collide(self, 1, true);
          flipsidesifneeded();
						
          if self.class != CPlayer
	            
            #removeifprojectile(this, true, true);
            sideBounce();
          end
        end
			elsif((g_map.map(tx, ty) == tile_death || g_map.map(tx, ty2) == tile_death) && !@invincible && !@spawninvincible && @afraid_hazard)	
				killPlayerMapHazard();
				return;
			elsif(g_map.map(tx, ty) & 0x05 !=0 || g_map.map(tx, ty2) & 0x05 !=0)
				#collision on the right side.
				if(@iHorizontalPlatformCollision == 3)
           killMapHazard();
           return;
        end
           
        xf((tx * TILESIZE - collisionWidth) - 0.2);	
        @fOldX = @fx;
        
        if(@velx > 0.0)
					#@velx = 0.0;
					sideBounce();
				end
				flipsidesifneeded();
				
      end
    elsif(@velx + fPlatformVelX < -0.01 || @iHorizontalPlatformCollision == 1)
      #moving left
      tx = @fx.to_i / TILESIZE;

      #Just in case tx out of bounds and flipsidesifneeded wasnt called
      if(tx < 0) #actually for IO_MovingObject, it puts it to 0 if tx<0
        tx += 20;
      elsif(tx > 19)
        tx -= 20;
      end
			
      topblock = $g_map.block(tx, ty);
      bottomblock = $g_map.block(tx, ty2);
      
			if(@can_enter_warp)
			  if(g_map.warp(tx,ty).direction == 1 && g_map.warp(tx,ty2).direction == 1 && @playerKeys.game_left.fDown && 
					g_map.warp(tx,ty).connection == g_map.warp(tx,ty2).connection && 
					!g_map.isconnectionlocked(g_map.warp(tx,ty).connection) && !g_map.isconnectionlocked(g_map.warp(tx,ty2).connection) &&
					(!game_values.slowdownfreeze || game_values.slowdownon == @teamID))
						xf((tx * TILESIZE + TILESIZE) + 0.2);
						enterwarp(g_map.warp(tx, ty2));
						@warpplane = @ix;
						
						if(@iy - PHOFFSET < ty * TILESIZE)
							yi(ty * TILESIZE + PHOFFSET);
						elsif(@iy + PH > ty2 * TILESIZE + TILESIZE - 3)
							yi(ty2 * TILESIZE + TILESIZE - PH - 3);
						end
						
						return
				end
		  end
		  
		  if((topblock && !topblock.isTransparent()) || 
            (bottomblock && !bottomblock.isTransparent()))
        processOtherBlock = true;
        if(topblock && !topblock.isTransparent()) #collide with top block
          #puts "hit topblock"
          if(@iHorizontalPlatformCollision == 1)
            killMapHazard();
            return
          end
          topblock.collide(self, 3, true);
          flipsidesifneeded();
          if self.class != CPlayer
            processOtherBlock = false
            #removeifprojectile(this, true, true);
            sideBounce();
          end
        elsif(processOtherBlock && bottomblock && !bottomblock.isTransparent())
          #puts "hit bottom block"
	          
          if(@iHorizontalPlatformCollision == 1)
            killMapHazard();
            return;
          end
	
          bottomblock.collide(self, 3, true);
          flipsidesifneeded();
						
          if self.class != CPlayer
	            
            #removeifprojectile(this, true, true);
            sideBounce();
          end
        end
			elsif((g_map.map(tx, ty) == tile_death || g_map.map(tx, ty2) == tile_death) && !@invincible && !@spawninvincible && @afraid_hazard)	
				killPlayerMapHazard();
				return;
			elsif(g_map.map(tx, ty) & 0x05 !=0 || g_map.map(tx, ty2) & 0x05 !=0)
				#collision on the right side.
				if(@iHorizontalPlatformCollision == 3)
           killMapHazard();
           return;
        end
           
        xf((tx * TILESIZE + TILESIZE) + 0.2);	
        @fOldX = @fx;
        
        if(@velx < 0.0)
					#@velx = 0.0;
					sideBounce();
				end
				flipsidesifneeded();
				
      end
		  
		  
		  
		
    end
  end
  
  def logfor(id, str=nil)
    if self.class == CPlayer && self.globalID == id
      print "#{str}," if str
      puts "@ix is #@ix, @fx is #@fx, @iy is #@iy, @fy is #@fy, @vely is #@vely" 
    end
  end
  
  def logforObject(str=nil)
    if self.is_a? CObject
      print "#{str}," if str
      puts "@ix is #@ix, @fx is #@fx, @iy is #@iy, @fy is #@fy, @vely is #@vely" 
    end
  end
  
  def collision_detection_checksides
    #todo
  end

end