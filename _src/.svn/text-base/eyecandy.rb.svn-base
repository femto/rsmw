class CEyecandy
  attr_accessor :dead
  def initialize
    @dead = false
  end
  def draw()
    #puts("CEyecandy::draw() - NO!");
  end
  def update()
    #puts("CEyecandy::update() - NO!");
  end
	
end
class EC_Cloud < CEyecandy
  def initialize(nspr, nx, ny, nvelx)
    @spr = nspr;
    @x = nx;
    @y = ny;
    @velx = nvelx;
    @w = @spr.getWidth();
  end
  def draw
    #puts "draw EC_Cloud at [#@x,#@y]"
    @spr.draw(@x, @y);
  end
  def update
    @x += @velx;
	
    if(@x > 639.0)
      @x -= 639.0;
    elsif( @x < 0.0)
      @x += 640.0;
    end
  end
end

class EC_Ghost < CEyecandy
  def initialize(nspr, nx, ny, nvelx, ianimationspeed, inumframes)
    
  end
  def draw
  end
  def update
  end
end

class EC_Corpse < CEyecandy
  def initialize(nspr, nx, ny, iSrcOffsetX)
    super()
    @spr = nspr;
    @x = nx;
    @y = ny;
    @vely = 1.0;
    @timeleft = CORPSESTAY;
    @offsetx = iSrcOffsetX;
	
    if(@x + PWOFFSET < 0.0)
      @tx =  ( (@x + 640.0 + PWOFFSET) / TILESIZE );
    else
      @tx =  ( (@x + PWOFFSET) / TILESIZE );
    end
	
    if(@x + PWOFFSET + PW >= 640.0)
      @tx2 =  ( (@x + PWOFFSET + PW - 640.0) / TILESIZE );
    else
      @tx2 = ( (@x + PWOFFSET + PW) / TILESIZE );
    end
  end
  def draw
    @spr.draw(@x, @y, @offsetx, 0, 32, 32);
  end
  def update
    g_map = $g_map
    if(@vely != 0.0)
      nexty = (@y + 32.0 + @vely);
      if(nexty >= 480)
        @dead = true;
        return;
      end
      if(nexty >= 0)
        ty = nexty / TILESIZE;
        if(g_map.map(@tx, ty) == tile_solid_on_top || g_map.map(@tx2, ty) == tile_solid_on_top)
          #on ground on tile solid_on_top
          if((@y + 32.0 - @vely) / TILESIZE < ty)
            #only if we were above the tile in the previous frame
            @y		=  (ty * TILESIZE - 32);
            @vely	= 0.0;
            return;
          end
        end
        tx=@tx
        tx2=@tx2
        leftblock = g_map.block(tx, ty);
        rightblock = g_map.block(tx2, ty);
			  
        if((g_map.map(tx, ty) & 0x05) > 0 || (g_map.map(tx2, ty) & 0x05) > 0 ||
              (leftblock && !leftblock.isTransparent()) || (rightblock && !rightblock.isTransparent()))
          #on ground
          @y		=  (ty * TILESIZE - 32);
          @vely	= 0.0;
          return;
        end
      end
      #falling (in air)
      @y		+= @vely;
      @vely	= capFallingVelocity(GRAVITATION + @vely);
    else
      if(@timeleft > 0)
        @timeleft-=1;
      else
        @dead = true;  
      end
    end
  end
end

class EC_FallingObject < CEyecandy
  def initialize(nspr, x, y, *args)
    
    @spr = nspr
    @fx = x
    @fy = y
    if args[1].is_a? Float
      @velx = args[0]
      @vely = args[1];
      
      @iSrcOffsetX = args[4];
      @iSrcOffsetY = args[5];
	    
      @iNumSprites = args[2];
	    
      @iw = args[6]
      if(@iw == 0)
        @iw = @spr.getWidth() / @iNumSprites;
      end
			
      @ih = args[7];
      if(@ih == 0)
        @ih = @spr.getHeight();
      end
			
			
      @iAnimationRate = args[3];
      @iDrawFrame = @iSrcOffsetX;
      @iAnimationTimer = 0;
      @iAnimationWidth = @iNumSprites * @iw;
    else	
      @velx = 0.0;
      @vely = args[0];
      
      @iSrcOffsetX = args[1];
      @iSrcOffsetY = args[2];
	    
      @iw = args[3]
      if(@iw == 0)
        @iw = @spr.getWidth();
      end
			
      @ih = args[4];
      if(@ih == 0)
        @ih = @spr.getHeight();
      end
			
      @iNumSprites = 1;
      @iAnimationRate = 0;
      @iDrawFrame = @iSrcOffsetX;
      @iAnimationTimer = 0;
      @iAnimationWidth = @iw;
	    
    end
  end
  
  def draw
    @spr.draw(@fx, @fy, @iDrawFrame, @iSrcOffsetY, @iw, @ih);	
  end
  def update
    @fy += @vely;
		@fx += @velx;
		
		if(@fy >= 480.0)
			@dead = true;
			return;
		end
	
		@vely += GRAVITATION;
	
		if(@iAnimationRate > 0)
		  @iAnimationTimer += 1
			if(@iAnimationTimer == @iAnimationRate)
				@iAnimationTimer = 0;
				@iDrawFrame += @iw;
	
				if(@iDrawFrame >= @iAnimationWidth)
					@iDrawFrame = @iSrcOffsetX;
				end
			end
		end
  end
end

class EC_GravText < CEyecandy
  def initialize(nfont, nx, ny, ntext, nvely)
    super()
    @font = nfont;
		@x = (nx - (@font.getWidth(ntext) / 2));
		@y = ny;
		@w = @font.getWidth(ntext);
		
		
		@text = ntext;
		
	
		@vely = nvely;
  end
  
  def update()
	
		@y += @vely;
		@vely += GRAVITATION;
	
		if(@y > 480)
			@dead = true;
		end
	end
	
	def draw
		@font.draw(@x, @y, @text);
	
		if(@x < 0)
			@font.draw(@x + 640, @y, @text);
		elsif(@x + @w > 639)
			@font.draw(@x - 640, @y, @text);
		end
	
  end
end

class EC_SingleAnimation < CEyecandy
  def initialize(nspr, nx, ny, iframes, irate)
    @spr = nspr;
    @x = nx;
    @y = ny;
    @frames = iframes;
    @frame = 0;
    @counter = 0;
    @rate = irate - 1;
	
    @iw = @spr.getWidth() / iframes;
    @ih = @spr.getHeight();
	
    @iAnimationWidth = @spr.getWidth();
  end
  def update
    @counter += 1
    if(@counter > @rate)
      @counter = 0;
      @frame += @iw;
	
      if(@frame >= @iAnimationWidth)
        @dead = true;
      end
    end
  end
  
  def draw
    @spr.draw(@x, @y, @frame, 0, @iw, @ih);
  end
end


class EC_LoopingAnimation < CEyecandy
  def initialize(nspr, x, y, iframes, irate, iloops, ioffsetx, ioffsety, istartoffsetx, iwidth, iheight)
    @spr = nspr;
    @ix = x;
    @iy = y;
    @frame = ioffsetx + istartoffsetx * iwidth;
    @counter = 0;
    @rate = irate - 1;
	
    @iw = iwidth;
    @ih = iheight;
	
    @iOffsetX = ioffsetx;
    @iOffsetY = ioffsety;
	
    @iAnimationWidth = ioffsetx + iframes * iwidth;
	
    @countloops = 0;
    @loops = iloops;
  end
 
  def update
    @counter += 1
    if(@counter > @rate)
      @counter = 0;
			
      @frame += @iw;
      if(@frame >= @iAnimationWidth)
			  
        if(@loops > 0)
          @countloops += 1
          if @countloops >= @loops
            @dead = true;
          end
        end
	
        @frame = @iOffsetX;
      end
    end
  end
  def draw
    @spr.draw(@ix, @iy, @frame, @iOffsetY, @iw, @ih);
  end
end

class EC_FloatingObject < CEyecandy
  def initialize(nspr, nx, ny, nvelx, nvely, timetolive, nsrcx, nsrcy, nwidth, nheight)
    @spr = nspr;
		@x = nx;
		@y = ny;
		@velx = nvelx;
		@vely = nvely;
		@srcx = nsrcx;
		@srcy = nsrcy;
		@w = nwidth;
		@h = nheight;
	
		@timer = 0;
		@ttl = timetolive;
  end
  def update
    @y += @vely;
		@x += @velx;
	
	  @timer += 1
		if(@timer > @ttl)
			$eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, @x + (@w >> 1) - 16, @y + (@h >> 1) - 16, 3, 8));
			@dead = true;
		end
  end
  
  def draw
  	@spr.draw(@x, @y, @srcx, @srcy, @w, @h);
  end
end

class CEyecandyContainer

  def initialize
    @list = []
    @list_end = 0
  end
  
  def CEyecandyContainer.finalize(id)
    puts "Object #{id} dying at #{Time.new} in CEyecandyContainer destructor"
    clean()
  end

  def add(ec)
    @list << ec
    ec.dead = false
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
	
  #do we need each method for eyecandy?
  # 	def each
  # 	  @list.each do |x|
  #     	yield x
  #     end
  #   end
	
  def clean
    @list = []
    @list_end = 0
  end
  
  def cleandeadobjects
    #     @list.each do |x|
    #     	if x.dead
    #     	  @list.delete(x)
    #       end
    #     end
    @list.delete_if {|x| x.dead}
  end
  
  def remove(i)
    @list.delete_at(i)
  end
	
end