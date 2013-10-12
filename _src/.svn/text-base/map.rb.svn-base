def read_type_full
  0
end
def read_type_preview
  1
end
def read_type_summary
  2
end

def tile_nonsolid
  0
end
def  tile_solid
  1
end
def  tile_solid_on_top
  2
end
def  tile_ice
  3
end
def  tile_death
  4
end
def  tile_death_on_top
  5
end
def  tile_death_on_bottom
  6
end

require 'movingplatform'
class Warp
  attr_accessor :direction,:connection,:id
end

class WarpExit
  attr_accessor :direction;
  attr_accessor :connection;
  attr_accessor :id;
	
  attr_accessor :x; #Player location where player warps out of
  attr_accessor :y; 

  attr_accessor :lockx;  #Location to display lock icon
  attr_accessor :locky;  

  attr_accessor :warpx;  #map grid location for first block in warp
  attr_accessor :warpy;
  attr_accessor :numblocks;  #number of warp blocks for this warp
end

class SpawnArea
  attr_accessor :left;
  attr_accessor :top;
  attr_accessor :width;
  attr_accessor :height;
  attr_accessor :size;
end

class CMap
  attr_accessor :platforms,:szBackgroundFile
  attr_accessor :tilesetsurface
  attr_accessor :eyecandyID
  attr_accessor :switchBlocks
  attr_accessor :objectdata
  attr_accessor :blockdata
  attr_accessor :tileset
  
  def isconnectionlocked(connection) 
    return @warplocked[connection];
  end
	def lockconnection(connection) 
    @warplocked[connection] = true;
  end
  
  def initialize
    @platforms = []
    

    @iThumbTileX = []
    @iThumbTileY = []

    @iPreviewTileX = []
    @iPreviewTileY = []

    @iGameTileX = []
    @iGameTileY = []

    TILESETSIZE.times do |iTile|
      @iThumbTileX[iTile] = (iTile % TILESETWIDTH) * THUMBTILESIZE;
      @iThumbTileY[iTile] = (iTile / TILESETWIDTH) * THUMBTILESIZE;

      @iPreviewTileX[iTile] = (iTile % TILESETWIDTH) * PREVIEWTILESIZE;
      @iPreviewTileY[iTile] = (iTile / TILESETWIDTH) * PREVIEWTILESIZE;

      @iGameTileX[iTile] = (iTile % TILESETWIDTH) * TILESIZE;
      @iGameTileY[iTile] = (iTile / TILESETWIDTH) * TILESIZE;
    end
    @fAutoFilter = []

    @mapdata = []
    MAPWIDTH.times do |i|
      @mapdata[i] = []
      MAPHEIGHT.times do |j|
        @mapdata[i][j] = []
      end
    end

    @objectdata = []
    @blockdata = []
    MAPWIDTH.times do |i|
      @objectdata[i] = []
      @blockdata[i] = []
      #       MAPHEIGHT.times do |j|
      #         @objectdata[i][j] = []
      #       end
    end
    @tilesetsurface = []
    @warpdata = []
    MAPWIDTH.times do |i|
      @warpdata[i] = []
      MAPHEIGHT.times do |j|
        @warpdata[i][j] = Warp.new
      end
    end
    @numwarpexits = 0
    @warpexits = []
    MAXWARPS.times do |i|
    	@warpexits[i] = WarpExit.new
    end
    @warplocktimer = [] #array of 10 short
    @warplocked = [] #array of 10 bool
    @maxConnection = 0 

    @nospawn = []
    NUMSPAWNAREATYPES.times do |i|
      @nospawn[i] = []
      MAPWIDTH.times do |j|
        @nospawn[i][j] = []
      end
    end

    @mapdatatop = []
    MAPWIDTH.times do |i|
      @mapdatatop[i] = []
    end
    
    @switchBlocks = []
    8.times do |i|
      @switchBlocks = []
    end
    @iSwitches = []

    @tileset = []
    @tilebltrect = []

    @animatedtilesback = CEyecandyContainer.new
    @animatedtilesfront = CEyecandyContainer.new

    @bltrect = []
    @tilebltrect = []
    
    @numspawnareas = []
    @spawnareas = []
    NUMSPAWNAREATYPES.times do |i|
      @spawnareas[i] = []
      MAXSPAWNAREAS.times do |j|
        @spawnareas[i][j] = SpawnArea.new
      end
    end
    @totalspawnsize = [0,0]
    
    @drawareas = []
    MAXDRAWAREAS.times do |i|
      @drawareas[i] = []
    end
  end
  
  def findspawnpoint(iType, width, height, tilealigned)
    if(@totalspawnsize[iType] <= 0)
      return [320,224]
    end
    
    #Calculate where the platforms are and create no spawn zones around them
    game_values = $game_values
    dPathTime = 0.0;
    if(game_values.spawnstyle == 1)
      dPathTime = 36.0;
    elsif(game_values.spawnstyle == 2)
      dPathTime = 51.0;
    end
		
    @iNumPlatforms.times do |iPlatform|
      @platforms[iPlatform].calculateNoSpawnZone(dPathTime);
    end
		
    x=0
    y=0
		
    fDone = false;
    #iTries = 0;
	  
    MAX_PLAYER_SPAWN_TRIES.times do |iTries|
      break if fDone
      spawnarea = rand(@totalspawnsize[iType]);
	  	
      currentsize = 0;
	  	
      @numspawnareas[iType].times do |m|
        currentsize += @spawnareas[iType][m].size;
	  		
        next if(spawnarea >= currentsize)
	  		
        areawidth = @spawnareas[iType][m].width * TILESIZE + TILESIZE;
        areaheight = @spawnareas[iType][m].height * TILESIZE + TILESIZE;
			  
        next if(width > areawidth || height > areaheight)
			  
        if(@tilealigned)
          xoffset = @spawnareas[iType][m].width;
          yoffset = @spawnareas[iType][m].height;
				  
          if(xoffset > 0)
            xoffset = rand(xoffset);
          end
          if(yoffset > 0)
            yoffset = rand(yoffset);
          end
					
          x = xoffset * TILESIZE + @spawnareas[iType][m].left * TILESIZE + (TILESIZE >> 1) - (width >> 1);
          y = yoffset * TILESIZE + @spawnareas[iType][m].top * TILESIZE + (TILESIZE >> 1) - (height >> 1);
				  
        else
          xoffset = areawidth - width - 2;
          yoffset = areaheight - height - 2;
				  
          if(xoffset > 0)
            xoffset = rand(xoffset) + 1;
          end
          if(yoffset > 0)
            yoffset = rand(yoffset) + 1;
          end
					
          x = xoffset + @spawnareas[iType][m].left * TILESIZE;
          y = yoffset + @spawnareas[iType][m].top * TILESIZE;
				  
        end
        break
      end
      @iNumPlatforms.times do |iPlatform|
        fDone = !@platforms[iPlatform].isInNoSpawnZone(x, y, width, height);
	  		
        if(!fDone)
          break;
        end
      end
    end #end MAX_PLAYER_SPAWN_TRIES.times
    return [x,y]
	  
  end

  def clearTileSet

    TILESETSIZE.times do |i|
      @tileset[i] = tile_nonsolid;
    end
    @tilebltrect.w = TILESIZE;
    @tilebltrect.h = TILESIZE;
  end

  def loadTileSet(tilesetfile, tilesetpng)
    clearTileSet

    #1. load tileset file
    #cout << "loading tileset from " << tilesetfile << " ... ";
    tsf = File.new(tilesetfile, "rb");

    TILESETSIZE.times do |i|
      @tileset[i] = readInt(tsf);
    end
    @tileset[TILESETSIZE] = tile_nonsolid;
    tsf.close;

    #2. load tileset graphics
    3.times do |iTileSet|
      surface = Surface.load_new(tilesetpng[iTileSet])
      surface.set_colorkey([255,0,255,255],RLEACCEL)
      @tilesetsurface[iTileSet] = surface.convert!
    end
  end

  def loadMap(file,iReadType)
    #FILE * mapfile;
    #short i, j, k;

    mapfile = File.open(file, "rb")
    version = mapfile.sysread(16).unpack("i4")
    if(version[0] == 1 && version[1] == 7)
      if((version[2] == 0 && version[3] > 1) || version[2] >= 1)

        data = mapfile.sysread((NUM_AUTO_FILTERS + 1)*4)
        iAutoFilterValues = data.unpack("i#{NUM_AUTO_FILTERS+1}")
        NUM_AUTO_FILTERS.times do |iFilter|
          @fAutoFilter[iFilter] = iAutoFilterValues[iFilter] > 0;
        end
      else
        NUM_AUTO_FILTERS.times do |iFilter|
          @fAutoFilter[iFilter] = false;
        end
      end

      if(iReadType == read_type_summary)
        return
      end
      clearPlatforms
      print "loading map #{file}"
      if(iReadType == read_type_preview)
        print " (preview)";
      end
      print " "
      print "[Version #{version[0]}.#{version[1]}.#{version[2]}.#{version[3]} Map Detected]\n";

      #2. load map data
      MAPHEIGHT.times do |j|
        MAPWIDTH.times do |i|
          MAPLAYERS.times do |k|
            @mapdata[i][j][k] = readInt(mapfile)
          end
          @objectdata[i][j] = readInt(mapfile)
        end
      end

      if((version[2] == 0 && version[3] > 1) || version[2] >= 1)
        @szBackgroundFile = readString(mapfile)
        puts "background:#{@szBackgroundFile}"
      elsif(version[2] == 0 && version[3] == 1)
        @szBackgroundFile = readString(mapfile)
        26.times do |iBackground|
          #todo:
        end
      else
        #Read old background IDs and convert that to a background filename
        backgroundID = readInt(mapfile);
        @szBackgroundFile = $g_szBackgroundConversion[backgroundID];
      end

      if((version[2] == 0 && version[3] > 0) || version[2] >= 1)
        4.times do |iSwitch|
          @iSwitches[iSwitch] = readInt(mapfile);
        end
      end
      if((version[2] == 0 && version[3] > 1) || version[2] >= 1)
        loadPlatforms(mapfile, iReadType == read_type_preview);
      end

      #Read in eyecandy to use
      @eyecandyID = readInt(mapfile);

      if((version[2] == 0 && version[3] > 0) || version[2] >= 1)
        @musicCategoryID = readInt(mapfile);
      else
        #@musicCategoryID = $g_iMusicCategoryConversion[backgroundID];
      end

      MAPHEIGHT.times do |j|
        MAPWIDTH.times do |i|
          @mapdatatop[i][j] = readInt(mapfile);
          @warpdata[i][j].direction = readInt(mapfile);
          @warpdata[i][j].connection = readInt(mapfile);
          @warpdata[i][j].id = readInt(mapfile);

          NUMSPAWNAREATYPES.times do|iType|
            @nospawn[iType][i][j] = readInt(mapfile) == 0 ? false : true;
          end
        end
      end

      if(iReadType == read_type_preview)
        mapfile.close;
        return;
      end
      
      @maxConnection = 0;
      
      @numwarpexits = readInt(mapfile);
      
      [@numwarpexits,MAXWARPS].min.times do |i|
      	
      	@warpexits[i].direction = readInt(mapfile);
        @warpexits[i].connection = readInt(mapfile);
        @warpexits[i].id = readInt(mapfile);
        @warpexits[i].x = readInt(mapfile);
        @warpexits[i].y = readInt(mapfile);
			
        @warpexits[i].lockx = readInt(mapfile);
        @warpexits[i].locky = readInt(mapfile);
			
        @warpexits[i].warpx = readInt(mapfile);
        @warpexits[i].warpy = readInt(mapfile);
        @warpexits[i].numblocks = readInt(mapfile);
	
        if(@warpexits[i].connection > @maxConnection)
          @maxConnection = @warpexits[i].connection;
        end
      end
      
      #Ignore any more warps than the max
      if @numwarpexits - MAXWARPS > 0
        (@numwarpexits - MAXWARPS).times do |i|
          10.times do |j|
            readInt(mapfile);
          end
        end
      end
      
      if(@numwarpexits > MAXWARPS)
        @numwarpexits = MAXWARPS;
      end
		  
      #Read spawn areas
		  
      NUMSPAWNAREATYPES.times do |i|
        @totalspawnsize[i] = 0;
        @numspawnareas[i] = readInt(mapfile);
        if(@numspawnareas[i] > MAXSPAWNAREAS)
          puts " ERROR: Number of spawn areas (#@numspawnareas[i]) was greater than max allowed (#{MAXSPAWNAREAS})"
          return;
        end
		    
        @numspawnareas[i].times do |m|
          @spawnareas[i][m].left = readInt(mapfile);
          @spawnareas[i][m].top = readInt(mapfile);
          @spawnareas[i][m].width = readInt(mapfile);
          @spawnareas[i][m].height = readInt(mapfile);
          @spawnareas[i][m].size = readInt(mapfile);
				
          @totalspawnsize[i] += @spawnareas[i][m].size;
        end
      end
		  
      #Read draw areas (foreground tiles drawing optimization)
      @numdrawareas = readInt(mapfile);
		  
      if(@numdrawareas > MAXDRAWAREAS)
        puts " ERROR: Number of draw areas (#@numdrawareas) was greater than max allowed (#{MAXDRAWAREAS})"
        return;
      end
			
      #Load rects to help optimize drawing the foreground
      @numdrawareas.times do |m|
        @drawareas[m].x = readInt(mapfile);
        @drawareas[m].y = readInt(mapfile);
        @drawareas[m].w = readInt(mapfile);
        @drawareas[m].h = readInt(mapfile);
      end
      
      if(version[2] == 0 && version[3] < 2)
        loadPlatforms(mapfile, iReadType == read_type_preview);
      end
      
      if(version[2] == 0 && version[3] == 0)
        4.times do |iSwitch|
          @iSwitches[iSwitch] = readInt(mapfile);
        end
      end
      
      

    end
    mapfile.close
    clearWarpLocks();
  end
  
  def clearWarpLocks
    10.times do |k|
      @warplocktimer[k] = 0;
      @warplocked[k] = false;
    end
  end

  def clearPlatforms
    @platforms = []
  end

  def loadPlatforms(mapfile, fPreview)
    clearPlatforms

    puts "loading platform"

    #Load moving platforms
    @iNumPlatforms = readInt(mapfile);
    puts "@iNumPlatforms:#@iNumPlatforms"
    @iNumPlatforms.times do |iPlatform|
      #@platforms[i] = nil
      iWidth = readInt(mapfile);
      iHeight = readInt(mapfile);
      tiles = Array.new(iWidth);
      iWidth.times do |iCol|
        tiles[iCol] = []
        iHeight.times do |iRow|
          tiles[iCol][iRow] = readInt(mapfile);
        end
      end

      fStartX = readFloat(mapfile);
      fStartY = readFloat(mapfile);
      fEndX = readFloat(mapfile);
      fEndY = readFloat(mapfile);
      fVelocity = readFloat(mapfile);

      path = MovingPlatformPath.new(fVelocity, fStartX, fStartY, fEndX, fEndY);

      @platforms[iPlatform] = MovingPlatform.new(tiles, iWidth, iHeight, path, true, 0, fPreview);
    end
  end

  def updatePlatforms
    @platforms.each do |platform|
      platform.update
    end
  end
  
  def update
    #puts "@maxConnection is #{@maxConnection}"
    10.times do|k|
      if(@warplocked[k])
        @warplocktimer[k]+=1
        #puts "@warplocktimer now is #@warplocktimer, $game_values.warplocks is #{$game_values.warplocks}"
        if(@warplocktimer[k] > $game_values.warplocks)
          @warplocked[k] = false;
          @warplocktimer[k] = 0;
        end
      end
    end

    @animatedtilesfront.update();
    @animatedtilesback.update();
  end

  def drawPlatforms(iOffsetX =0, iOffsetY = 0)
    @platforms.each do |platform|
      #puts "draw platform :#{platform.fx},#{platform.fy}"
      platform.draw(iOffsetX, iOffsetY)
    end
  end
  
  def movingPlatformCollision(o)
    #(@platforms + @tempPlatforms).each
    @platforms.each do |platform|
    	platform.collide(o);
    	
    	if(o.class == CPlayer && !o.isready())
			  return;
		  end
    end
    
  end

  def readInt(file)
    file.sysread(4).unpack("i")[0]
  end

  def readFloat(file)
    file.sysread(4).unpack("f")[0]
  end

  def readString(file)
    iLen = readInt(file)
    return file.sysread(iLen)[0,iLen-1]
  end
  
  def map(x,y)
    @mapdatatop[x][y];
  end
  
  def block(x, y)
    @blockdata[x][y];
  end
  
  def warp(x, y)
    @warpdata[x][y];
  end
	
  def blockat(x, y)
    @objectdata[x][y];
  end

  def spawn(iType, x, y)
    !@nospawn[iType][x][y];
  end
  

  def preDrawPreviewBackground(spr_background,fThumbnail)

    if(fThumbnail)
      surface = spr_background.surface.zoom(0.25,0.25,true)
    else
      surface = spr_background.surface.zoom(0.5,0.5,true)
    end
    drawPreview(surface, 0, fThumbnail);

    drawPreview(surface, 1, fThumbnail);
    surface
  end

  def preDrawPreviewForeground(targetSurface, fThumbnail)

    if(!fThumbnail)
      targetSurface.fill([255,0,255,255])
      targetSurface.set_colorkey([255,0,255,255])
    end

    drawPreview(targetSurface, 2, fThumbnail);

    drawPreview(targetSurface, 3, fThumbnail);
  end

  def drawPreview(targetSurface, layer, fThumbnail)
    iBlockSize = PREVIEWTILESIZE;
    if(fThumbnail)
      iBlockSize = THUMBTILESIZE;
    end

    rectSrc = []
    rectSrc.w = iBlockSize;
    rectSrc.h = iBlockSize;

    rectDst = []
    rectDst.w = iBlockSize;
    rectDst.h = iBlockSize;

    rectDst.x = 0;

    MAPWIDTH.times do |i|
      rectDst.y = -iBlockSize;
      MAPHEIGHT.times do |j|
        rectDst.y += iBlockSize;
        ts = @mapdata[i][j][layer];
        next if(ts == TILESETSIZE)


        if(fThumbnail)
          rectSrc.x = @iThumbTileX[ts];
          rectSrc.y = @iThumbTileY[ts];
        else
          rectSrc.x = @iPreviewTileX[ts];
          rectSrc.y = @iPreviewTileY[ts];
        end

        if(fThumbnail)
          targetSurface.blit(@tilesetsurface[2], rectDst, rectSrc);
        else
          targetSurface.blit(@tilesetsurface[1], rectDst, rectSrc);
        end
      end
      rectDst.x += iBlockSize;
    end
  end


  def predrawbackground(background, mapspr)
    r = [];
    r.x = 0;
    r.y = 0;
    r.w = 640;
    r.h = 480;

    mapspr.surface.blit(background.surface, r);

    draw(mapspr.surface, 0, false);
    draw(mapspr.surface, 1, false);

    if(!$game_values.toplayer)
      draw(mapspr.surface, 2, false);
      draw(mapspr.surface, 3, false);
    end

  end
  def predrawforeground(foregroundspr)
    foregroundspr.surface.fill([255, 0, 255]);
    foregroundspr.surface.set_colorkey([255,0,255]);

    draw(foregroundspr.surface, 2, true);
    draw(foregroundspr.surface, 3, true);

  end
  
  def drawfrontlayer
    #    @numdrawareas.times do |k|
    #      $spr_frontmap.draw(@drawareas[k].x, @drawareas[k].y, @drawareas[k].x, @drawareas[k].y, @drawareas[k].w, @drawareas[k].h);
    #    end
  end

  def draw(targetSurface, layer, fForeground)
    #int i, j, ts;
    animatedtilesdest = @animatedtilesback;
    if(fForeground)
      animatedtilesdest = @animatedtilesfront;
    end
    #draw left to right full vertical
    @bltrect.x = 0;
    MAPWIDTH.times do |i|
      @bltrect.y = -TILESIZE;	#this is okay, see
      MAPHEIGHT.times do |j|
        @bltrect.y += TILESIZE;	# here

        ts = @mapdata[i][j][layer];
        if(ts == TILESETSIZE)
          next;
        end
        @tilebltrect.x = @iGameTileX[ts];
        @tilebltrect.y = @iGameTileY[ts];

        if(ts >= 940 && ts <= 942)
          animatedtilesdest.add(EC_LoopingAnimation.new($spr_maplava, @bltrect.x, @bltrect.y, 3, 8, 0, 0, TILESIZE, ts - 940, TILESIZE, TILESIZE));
        elsif(ts >= 652 && ts <= 655)
          animatedtilesdest.add(EC_LoopingAnimation.new($spr_mapwater, @bltrect.x, @bltrect.y, 4, 8, 0, 0, 0, ts - 652, TILESIZE, TILESIZE));
        elsif(ts == 559 || ts == 495 || ts == 780)
          animatedtilesdest.add(EC_LoopingAnimation.new($spr_mapwaterfall, @bltrect.x, @bltrect.y, 4, 8, 0, 0, 0, 0, TILESIZE, TILESIZE));
        elsif(ts == 591 || ts == 527 || ts == 812)
          animatedtilesdest.add(EC_LoopingAnimation.new($spr_mapwaterfall, @bltrect.x, @bltrect.y, 4, 8, 0, 0, TILESIZE, 0, TILESIZE, TILESIZE));
        elsif(ts == 817)
          animatedtilesdest.add(EC_LoopingAnimation.new($spr_maplamp, @bltrect.x, @bltrect.y, 4, 8, 0, 0, 0, 0, TILESIZE, TILESIZE));
        else
          targetSurface.blit(@tilesetsurface[0], @bltrect, @tilebltrect);
        end

      end
      @bltrect.x += TILESIZE;
      
    end

    @bltrect.x = 0;
    @bltrect.y = 0;
    @bltrect.w = 640;
    @bltrect.h = 480;

  end

  def drawbackanimations()
    @animatedtilesback.draw();
  end

  def drawfrontanimations()
    @animatedtilesfront.draw();
  end
  
  def getRandomWarpExit(connection, currentID)
    #require 'debug'
		indices = [];
		numIndices = 0;
	
		currentWarp = nil;
	
		@numwarpexits.times do |k|
			if(@warpexits[k].connection == connection)
				if(@warpexits[k].id == currentID)
					currentWarp = @warpexits[k];
				else
					indices[numIndices] = k;
					numIndices+=1
				end
			end
		end
	
		if(numIndices == 0)
			return currentWarp;
		end
	
		return @warpexits[indices[rand(numIndices)]];
	end
	
	def drawWarpLocks
	  @numwarpexits.times do |k|
			if(@warplocked[@warpexits[k].connection])
				$spr_warplock.draw(@warpexits[k].lockx, @warpexits[k].locky);
			end
		end
	end
	
	def clearWarpLocks()
		10.times do|k|
			@warplocktimer[k] = 0;
			@warplocked[k] = false;
		end
	end


end