class MovingPlatformPath
  attr_accessor :fStartX,:fStartY,:fEndX,:fEndY,:fVelocity,:fAngle
  
  def initialize(vel=nil, startX=nil, startY=nil, endX=nil, endY=nil)
    if !vel.nil?
      @fVelocity = vel;
      @fStartX = startX;
      @fStartY = startY;
      @fEndX = endX;
      @fEndY = endY;
    else
      @fVelocity = 1.0;
      @fStartX = 304.0;
      @fStartY = 48.0;
      @fEndX = 304.0;
      @fEndY = 432.0;
	
    end
    calculateAngle();
  end
  
  def calculateAngle
    if(@fEndX - @fStartX == 0)
      if(@fEndY - @fStartY > 0)
        @fAngle = HALF_PI;
      else
        @fAngle = THREE_HALF_PI;
      end
    elsif(@fEndY - @fStartY == 0)
      if(@fEndX - @fStartX > 0)
        @fAngle = 0.0;
      else
        @fAngle = PI;
      end
    else
      @fAngle = Math::atan2(@fEndY - @fStartY, @fEndX - @fStartX);
    end
  end
  
end


class MovingPlatform
  attr_accessor :fx,:fy,:fVelX,:fVelY,:fOldVelX,:fOldVelY
  def initialize(tiledata, w, h, path, forwardDirection, startPathNode, fPreview)
    iTileSize = TILESIZE;
    tilesurface = $g_map.tilesetsurface[0];
    if(fPreview)
      iTileSize = PREVIEWTILESIZE;
      tilesurface = $g_map.tilesetsurface[1];
	
      path.fEndX /= 2.0;
      path.fEndY /= 2.0;
      path.fStartX /= 2.0;
      path.fStartY /= 2.0;
      path.fVelocity /= 2.0;
    end
	  
    @iTileData = tiledata;
    @iTileWidth = w;
    @iTileHeight = h;
		
    @iWidth = w * iTileSize;
    @iHeight = h * iTileSize;
		
    @iHalfWidth = @iWidth >> 1;
    @iHalfHeight = @iHeight >> 1;
		
    xf(path.fStartX);
    yf(path.fStartY);
		
    @fOldX = @fx;
    @fOldY = @fy;
		
    @fStartDirection = forwardDirection;
    @fForwardDirection = @fStartDirection;
	  
    @iStartPathNode = startPathNode;
	  
    @pPath = path;
	  
    #@sSurface = SDL_CreateRGBSurface(0, w * iTileSize, h * iTileSize, 16, 0, 0, 0, 0);
    @sSurface = Surface.new([w * iTileSize, h * iTileSize]);
    @sSurface.fill([255, 0, 255,255])
	  
    #SDL_FillRect(@sSurface, NULL, SDL_MapRGB(sSurface.format, 255, 0, 255));
    @rSrcRect = []
    @rSrcRect.x = 0;
    @rSrcRect.y = 0;
    @rSrcRect.w = iTileSize;
    @rSrcRect.h = iTileSize;
		
    @rDstRect = []
    @rDstRect.x = 0;
    @rDstRect.y = 0;
    @rDstRect.w = iTileSize;
    @rDstRect.h = iTileSize;
		
    @iTileWidth.times do |iCol|
      @iTileHeight.times do |iRow|
        ts = @iTileData[iCol][iRow]
        if(ts == TILESETSIZE)
          @rDstRect.y += iTileSize;
          next
        end
			  
        @rSrcRect.x = (ts % TILESETWIDTH) * iTileSize;
        @rSrcRect.y = (ts / TILESETWIDTH) * iTileSize;
        #tilesurface.blit(@sSurface, @rDstRect,@rSrcRect)
        @sSurface.blit(tilesurface, @rDstRect,@rSrcRect)
        #@sSurface.blit(Surface.load_new('gfx/skins/0smw.bmp'), @rDstRect,@rSrcRect)
				
        @rDstRect.y += iTileSize;
      end
      @rDstRect.y = 0;
      @rDstRect.x += iTileSize;
    end
		
    @sSurface.set_colorkey([255,0,255,255],RLEACCEL)
		
    @rSrcRect.x = 0;
    @rSrcRect.y = 0;
    @rSrcRect.w = w * iTileSize;
    @rSrcRect.h = h * iTileSize;
	
    @rDstRect.x = @ix - @iHalfWidth;
    @rDstRect.y = @iy - @iHalfHeight;
    @rDstRect.w = w * iTileSize;
    @rDstRect.h = h * iTileSize;
		
    if(@forwardDirection)
      @fVelX = @pPath.fVelocity * Math::cos(@pPath.fAngle);
      @fVelY = @pPath.fVelocity * Math::sin(@pPath.fAngle);
    else
      @fVelX = -@pPath.fVelocity * Math::cos(@pPath.fAngle);
      @fVelY = -@pPath.fVelocity * Math::sin(@pPath.fAngle);
    end
		
    @fOldVelX = @fVelX;
    @fOldVelY = @fVelY;
		
    @fEndPointX = @forwardDirection ? path.fEndX : path.fStartX;
    @fEndPointY = @forwardDirection ? path.fEndY : path.fStartY;
  end
  
  def xf(xf)
    @fx = xf; @ix = @fx.to_i;
  end
  def xi(xi)
    @ix = xi; @fx = @ix.to_f;
  end
  def yf(yf)
    @fy = yf; @iy = @fy.to_i;
  end
  def yi(yi)
    @iy = yi; @fy = @iy;
  end
	
  def update
    @fOldX = @fx;
    @fOldY = @fy;
  	
    @fOldVelX = @fVelX;
    @fOldVelY = @fVelY;
		
    @fx += @fVelX;
    @fy += @fVelY;
		
    #See if were at the end of the path
    if(@fVelX < -0.01)
      if(@fVelY < -0.01)
        if(@fx <= @fEndPointX && @fy <= @fEndPointY)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      elsif(@fVelY > 0.01)
        if(@fx <= @fEndPointX && @fy >= @fEndPointY)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      else
        if(@fx <= @fEndPointX)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      end
    elsif(@fVelX > 0.01)
      if(@fVelY < -0.01)
        if(@fx >= @fEndPointX && @fy <= @fEndPointY)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      elsif(@fVelY > 0.01)
        if(@fx >= @fEndPointX && @fy >= @fEndPointY)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      else
        if(@fx >= @fEndPointX)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      end
    else
      if(@fVelY > 0.01)
        if(@fy >= @fEndPointY)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      elsif(@fVelY < -0.01)
        if(@fy <= @fEndPointY)
          xf(@fEndPointX);
          yf(@fEndPointY);
          flipDirection();
        end
      else
        #Platform is not moving!
        puts("Platform is not moving.  This is probably a problem!\n");
      end
    end
	  
    @ix = @fx;
    @iy = @fy;
  end
  
  def draw(iOffsetX=0, iOffsetY=0)
  
    @rDstRect.x = @ix - @iHalfWidth + $x_shake + iOffsetX;
    @rDstRect.y = @iy - @iHalfHeight + $y_shake + iOffsetY;
    #puts "@sSurface:#@sSurface"
    $blitdest.blit(@sSurface,@rDstRect,@rSrcRect)
    #$blitdest.blit(Surface.load_new('gfx/skins/0smw.bmp'),@rDstRect,@rSrcRect)
    
  end
  
  def resetPath
    xf(@pPath.fStartX);
    yf(@pPath.fStartY);
	
    @fOldX = @fx;
    @fOldY = @fy;
	
    @fForwardDirection = @fStartDirection;
  end
  def flipDirection
    @fForwardDirection = !@fForwardDirection;
    
    @fEndPointX = @fForwardDirection ? @pPath.fEndX : @pPath.fStartX;
    @fEndPointY = @fForwardDirection ? @pPath.fEndY : @pPath.fStartY;
		
    if(@fForwardDirection)
      @fVelX = @pPath.fVelocity * Math::cos(@pPath.fAngle);
      @fVelY = @pPath.fVelocity * Math::sin(@pPath.fAngle);
    else
      @fVelX = -@pPath.fVelocity * Math::cos(@pPath.fAngle);
      @fVelY = -@pPath.fVelocity * Math::sin(@pPath.fAngle);
    end
		
    #Fix rounding errors
    if(@fVelX < 0.01 && @fVelX > -0.01)
      @fVelX = 0.0;
    end
    if(@fVelY < 0.01 && @fVelY > -0.01)
      @fVelY = 0.0;
    end
	
    #printf("Platform Flipped Directions: velx: %.5f  vely: %.5f  angle: %.5f\n", @fVelX, @fVelY, @pPath.fAngle);
  end
  
  def collide(o)
    if(!coldec_player(o))
      if(o.platform == self)
        o.platform = nil;
      end
      return
    end
    
    fColVelX = o.velx - @fOldVelX;
 	  fColVelY = o.vely - @fOldVelY;
 	  
 	  if(o.platform)
 	    fColVelY += o.platform.fOldVelY - GRAVITATION;
 	    if(o.velx < -0.6 || o.velx > 0.6)
 	    	fColVelX += o.platform.fOldVelX;
 	    end
 	  elsif(!o.inair)
 		  fColVelY -= GRAVITATION;  #Ignore the gravity if the player is on the ground
 	  end
 	  
 	  # fRelativeY1;
 	  # fRelativeY2;
 	  g_map = $g_map
 	  if(o.platform != self)
 			fRelativeY1 = o.fy - @fOldY + @iHalfHeight;
 			fRelativeY2 = o.fy + PH - @fOldY + @iHalfHeight;
 		else
 			fRelativeY1 = o.fy - @fy + @iHalfHeight;
 			fRelativeY2 = o.fy + PH - @fy + @iHalfHeight;
 		end
 		
 		if(fColVelX > 0.01 || o.iHorizontalPlatformCollision == 3)
 			#fRelativeX;
 			if(o.fx + PW >= 640.0)
				fRelativeX = o.fx + PW - 640.0 - @fx + @iHalfWidth;
			else
				fRelativeX = o.fx + PW - @fx + @iHalfWidth;
			end
			
			if(fRelativeX >= 0.0 && fRelativeX < @iWidth)
			  tx = fRelativeX.to_i / TILESIZE;
			  
			  t1 = tile_nonsolid;
			  t2 = tile_nonsolid;
			  
			  if(fRelativeY1 >= 0.0 && fRelativeY1 < @iHeight)
					t1 = g_map.tileset[@iTileData[tx][fRelativeY1.to_i / TILESIZE]];
				end
	
				if(fRelativeY2 >= 0.0 && fRelativeY2 < @iHeight)
					t2 = g_map.tileset[@iTileData[tx][fRelativeY2.to_i / TILESIZE]];
				end
				
				if((t1 & 0x05) > 0 || (t2 & 0x05) > 0)
					if(o.iHorizontalPlatformCollision == 3)
					  o.killMapHazard();
						#printf("Platform Right Side Killed Player\n");
						return;
					else
					  o.xf((tx * TILESIZE - o.collisionWidth) - 0.2 + @fx - @iHalfWidth);
						o.flipsidesifneeded();
						
						#test to see if we put the object on top of a background tile
						iTestBackgroundY = o.fy.to_i / TILESIZE;
					  iTestBackgroundY2 = (o.fy.to_i + o.collisionHeight) / TILESIZE;
					  
					  #iTestBackgroundX
					  if(o.fx + o.collisionWidth >= 640.0)
							iTestBackgroundX = (o.fx.to_i + o.collisionWidth - 640) / TILESIZE;
						else
							iTestBackgroundX = (o.fx.to_i + o.collisionWidth) / TILESIZE;
						end
						
						topblock = g_map.block(iTestBackgroundX, iTestBackgroundY);
					  bottomblock = g_map.block(iTestBackgroundX, iTestBackgroundY2);
					  
					  if((topblock && !topblock.isTransparent()) || 
							(bottomblock && !bottomblock.isTransparent()) ||
							(g_map.map(iTestBackgroundX, iTestBackgroundY) & 0x05) > 0 || 
							(g_map.map(iTestBackgroundX, iTestBackgroundY2) & 0x05) > 0)
							
							  o.xf((iTestBackgroundX * TILESIZE - o.collisionWidth) - 0.2);
							  o.flipsidesifneeded();
					  end
					  
					  if(@fOldVelX < 0.0)
					    o.fOldX = @fx + 10.0;  #Need to push out the old enough to collide correctly with flip blocks
					  else
						  o.fOldX = @fx - 10.0;  #Need to push out the old enough to collide correctly with flip blocks
					  end
					  
					  o.iHorizontalPlatformCollision = 1;
					  
					  if(o.velx > 0.0)
						  o.sideBounce
					  end
				  end
				end
				
		  end
		elsif(fColVelX < -0.01 || o.iHorizontalPlatformCollision == 1)
			fRelativeX = o.fx - @fx + @iHalfWidth;
			
			if(fRelativeX >= 0.0 && fRelativeX < @iWidth)
			  tx = fRelativeX.to_i / TILESIZE;
			  t1 = tile_nonsolid;
			  t2 = tile_nonsolid;
			  
			  if(fRelativeY1 >= 0 && fRelativeY1 < @iHeight)
					t1 = g_map.tileset[@iTileData[tx][fRelativeY1.to_i / TILESIZE]];
				end
	
				if(fRelativeY2 >= 0 && fRelativeY2 < @iHeight)
					t2 = g_map.tileset[@iTileData[tx][fRelativeY2.to_i / TILESIZE]];
				end
				
				if(t1 & 0x05!=0 || t2 & 0x05!=0)
					if(o.iHorizontalPlatformCollision == 1)
					  o.killMapHazard();
					  return
					else
					  o.xf((tx * TILESIZE + TILESIZE) + 0.2 + @fx - @iHalfWidth);
					  o.flipsidesifneeded();
					  
					  #test to see if we put the object on top of a background tile
						iTestBackgroundY = o.fy.to_i / TILESIZE;
						iTestBackgroundY2 = (o.fy.to_i + o.collisionHeight) / TILESIZE;
						iTestBackgroundX = o.fx.to_i / TILESIZE;
						
						topblock = g_map.block(iTestBackgroundX, iTestBackgroundY);
					  bottomblock = g_map.block(iTestBackgroundX, iTestBackgroundY2);
					  
					  if((topblock && !topblock.isTransparent()) || 
							(bottomblock && !bottomblock.isTransparent()) ||
							(g_map.map(iTestBackgroundX, iTestBackgroundY) & 0x05) > 0 || 
							(g_map.map(iTestBackgroundX, iTestBackgroundY2) & 0x05) > 0)
						
							o.xf((iTestBackgroundX * TILESIZE + TILESIZE) + 0.2);
							o.flipsidesifneeded();
						end
						
						if(@fOldVelX < 0.0)
							o.fOldX = @fx + 10.0;  #Need to push out the old enough to collide correctly with flip blocks
						else
							o.fOldX = @fx - 10.0;  #Need to push out the old enough to collide correctly with flip blocks
						end
						
						o.iHorizontalPlatformCollision = 3;
						
						if(o.velx < 0.0)
						  o.sideBounce();
					  end

				  end
				  
				end
		  end
		end #end if(fColVelX > 0.01 || o.iHorizontalPlatformCollision == 3)
			
    fRelativeX1 = o.fx - @fx + @iHalfWidth;
    #fRelativeX2;
		if(o.fx + o.collisionWidth > 640.0)
			fRelativeX2 = o.fx + o.collisionWidth - 640.0 - @fx + @iHalfWidth;
		else
			fRelativeX2 = o.fx + o.collisionWidth - @fx + @iHalfWidth;
		end
		
		if(fColVelY < 0.0)
		  #fRelativeY
		  
		  if(o.inair || o.platform == self)
				fRelativeY = o.fPrecalculatedY - @fy + @iHalfHeight;
			else
				fRelativeY = o.fy - @fy + @iHalfHeight;
			end
			
			if(fRelativeY >= 0.0 && fRelativeY < @iHeight)
			  ty = fRelativeY.to_i / TILESIZE;
			  t1 = tile_nonsolid;
			  t2 = tile_nonsolid;
			  
			  if(fRelativeX1 >= 0.0 && fRelativeX1 < @iWidth)
					t1 = g_map.tileset[@iTileData[fRelativeX1.to_i / TILESIZE][ty]];
				end
	
				if(fRelativeX2 >= 0.0 && fRelativeX2 < @iWidth)
					t2 = g_map.tileset[@iTileData[fRelativeX2.to_i / TILESIZE][ty]];
				end
				
				if((t1 & 0x1 !=0) || (t2 & 0x1 !=0) ||
					((o.invincible || o.spawninvincible) && ((t1 & 0x4!=0) || (t2 & 0x4!=0))))
						if(o.iVerticalPlatformCollision == 2)
						  o.killMapHazard();
						  return
						else
						  o.fPrecalculatedY = ty * TILESIZE + TILESIZE + 0.2 + @fy - @iHalfHeight;
							o.fOldY = o.fPrecalculatedY - @fVelY - GRAVITATION;
							
							if(o.vely < 0.0 && @fVelY > 0.0)
						    o.fPrecalculatedY += @fVelY;
					    end
					    
					    if(o.vely < 0.0)
								o.vely = capFallingVelocity(-o.vely * BOUNCESTRENGTH + @fVelY);
							end
							
							o.iVerticalPlatformCollision = 0;
					  end
					  return
			  elsif((t1 & 0x4!=0) || (t2 & 0x4!=0))
			  	o.killMapHazard();
				  return;
				end

		  end
		else
		  fRelativeY = o.fPrecalculatedY + o.collisionHeight - @fy + @iHalfHeight;
		  
		  if(fRelativeY >= 0.0 && fRelativeY < @iHeight)
		    ty = fRelativeY.to_i / TILESIZE;
		    t1 = tile_nonsolid;
			  t2 = tile_nonsolid;
			  
			  if(fRelativeX1 >= 0.0 && fRelativeX1 < @iWidth)
					t1 = g_map.tileset[@iTileData[fRelativeX1.to_i / TILESIZE][ty]];
				end
	
				if(fRelativeX2 >= 0.0 && fRelativeX2 < @iWidth)
					t2 = g_map.tileset[@iTileData[fRelativeX2.to_i / TILESIZE][ty]];
				end
				
				fSolidTileUnderPlayer = (t1 & 0x5) == 1 || t1 == tile_death_on_bottom || (t2 & 0x5) == 1 || t2 == tile_death_on_bottom;
					
				if((t1 == tile_solid_on_top || t2 == tile_solid_on_top) && o.fOldY + o.collisionHeight <= ty * TILESIZE + @fOldY - @iHalfHeight)
					#Deal with player down jumping through solid on top tiles
					if(o.fallthrough && !fSolidTileUnderPlayer)
					  o.fPrecalculatedY = ty * TILESIZE - o.collisionHeight + (@fVelY > 0.0 ? @fVelY : 0.0) + 0.2 + @fy - @iHalfHeight;
					  o.inair = true;
					  o.platform = nil;
					else
					  if(o.iVerticalPlatformCollision == 0)
					    o.killPlayerMapHazard();
					    return
					  else
					    o.platform = self;
					    o.iVerticalPlatformCollision = 2;
					    
					    o.fPrecalculatedY = ty * TILESIZE - o.collisionHeight - 0.2 + @fy - @iHalfHeight;
					    o.vely = o.bottomBounce() #GRAVITATION;
					    o.inair = false;
					    o.killsinrowinair = false
					    o.featherjump = 0;
					  end
				  end
				  o.fOldY = o.fPrecalculatedY - @fVelY;
				  o.fallthrough = false;
				  o.onice = false;
				  return
				elsif(fSolidTileUnderPlayer ||
					((o.invincible || o.spawninvincible) && (t1 == tile_death_on_top || t2 == tile_death_on_top ||
					t1 == tile_death || t2 == tile_death)))
				  #on ground
				  if(o.iVerticalPlatformCollision == 0)
				    o.killMapHazard();
				    return
				  else
				    o.platform = self;
				    o.iVerticalPlatformCollision = 2;
				    
				    o.fPrecalculatedY = ty * TILESIZE - o.collisionHeight - 0.2 + @fy - @iHalfHeight;
						o.fOldY = o.fPrecalculatedY - @fVelY;
						
						o.vely = o.bottomBounce() #GRAVITATION;
						o.inair = false;
					  o.killsinrowinair = false
					  o.featherjump = 0;
					  
					  if((t1 == tile_ice && (t2 == tile_ice || t2 == tile_nonsolid)) ||
							t2 == tile_ice && (t1 == tile_ice || t1 == tile_nonsolid))
							o.onice = true;
						else 
							o.onice = false;
						end
						
						o.fallthrough = false;
						return
				  end
				elsif(t1 == tile_death_on_top || t2 == tile_death_on_top ||
					t1 == tile_death || t2 == tile_death)
						o.killPlayerMapHazard();
						return
			  else
			    if(o.platform == self)
					  o.platform = nil;
				  end
				end

		  end
	  end
	
  end
  def coldec_player(o)
    #Special cases to deal with players overlapping the right and left sides of the screen
    if(o.fx + o.collisionWidth < @fx - @iHalfWidth)
      if (o.fx + 640.0 >= @fx + @iHalfWidth || o.fx + o.collisionWidth + 640.0 < @fx - @iHalfWidth || o.fPrecalculatedY >= @fy + @iHalfHeight || o.fPrecalculatedY + o.collisionHeight < @fy - @iHalfHeight)
        return false;
      else 
        return true;
      end
    elsif(fx + @iHalfWidth < o.fx)
      if (o.fx >= @fx + @iHalfWidth + 640.0 || o.fx + o.collisionWidth < @fx - @iHalfWidth + 640.0 || o.fPrecalculatedY >= @fy + @iHalfHeight || o.fPrecalculatedY + o.collisionHeight < @fy - @iHalfHeight) 
        return false;
      else 
        return true;
      end
    else #Normal case where no overlap
      if (o.fx >= @fx + @iHalfWidth || @fx - @iHalfWidth > o.fx + o.collisionWidth || o.fPrecalculatedY >= @fy + @iHalfHeight || @fy - @iHalfHeight > o.fPrecalculatedY + o.collisionHeight) 
        #printf("No Platform Collision: %.5f >= %.5f || %.5f > %.5f || %.5f >= %.5f || %.5f > %.5f\n", o.fx, @fx + @iHalfWidth, @fx - @iHalfWidth, o.fx + o.collisionWidth, o.fPrecalculatedY, @fy + @iHalfHeight, @fy - @iHalfHeight, o.fPrecalculatedY + o.collisionHeight);
        return false;
      else 
        return true;
      end
    end
  end
  def gettiletypes(player)
    lefttile = tile_nonsolid;
    righttile = tile_nonsolid;
	  
    fRelativeY = player.fPrecalculatedY + PH - @fy + @iHalfHeight;
	  
    if(fRelativeY < 0.0 || fRelativeY >= @iHeight)
      return [lefttile,righttile]
    end
	  
    ty = fRelativeY.to_i / TILESIZE;
	  
    fRelativeX1 = player.fx - @fx + @iHalfWidth;
	  
    #fRelativeX2
    if(player.fx + PW > 640.0)
      fRelativeX2 = player.fx + PW - 640.0 - @fx + @iHalfWidth;
    else
      fRelativeX2 = player.fx + PW - @fx + @iHalfWidth;
    end
	  
	  
    if(fRelativeX1 >= 0.0 && fRelativeX1 < @iWidth)
      lefttile = $g_map.tileset[iTileData[fRelativeX1.to_i / TILESIZE][ty]];
    end
    if(fRelativeX2 >= 0.0 && fRelativeX2 < @iWidth)
      righttile = $g_map.tileset[iTileData[fRelativeX2.to_i / TILESIZE][ty]];
    end
	  
    return [lefttile,righttile]
  end
  
  def calculateNoSpawnZone(dPathTime)
    fXArea = @fVelX.abs * dPathTime + @iHalfWidth;
    fYArea = @fVelY.abs * dPathTime + @iHalfHeight;
	  
    @iNoSpawnZoneLeft = (@fx - fXArea);
    @iNoSpawnZoneRight = (@fx + fXArea);
	
    @iNoSpawnZoneTop = (@fy - fYArea);
    @iNoSpawnZoneBottom = (@fy + fYArea);
  end
  
  def isInNoSpawnZone(x,y,w,h)
    if(x + w < @iNoSpawnZoneLeft || x >= @iNoSpawnZoneRight ||
          y + h < @iNoSpawnZoneTop || y >= @iNoSpawnZoneBottom)
      return false;
    end
	
    return true;
  end
end
