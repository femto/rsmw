#GFX_FLAGS = SWSURFACE
GFX_FLAGS = 0
class GfxSprite
  attr_accessor :wrap
  def initialize
    @m_bltrect = []
    @m_srcrect = []
  end
  def surface
    @m_picture
  end
  def surface=(surface)
    @m_picture = surface
    @m_bltrect.w = @m_picture.w;
    @m_bltrect.h = @m_picture.h;
  end
  def init(filename, colorkey=nil, alpha=nil)
    if(@m_picture)
      #@m_picture.destory
      @m_picture = nil
    end
    @m_picture = Surface.load_new(filename)
    if(!@m_picture)
      puts "Couldn't load #{filename}"
      return false
    end
    if colorkey
      @m_picture.set_colorkey(colorkey, RLEACCEL)
    end
    
    if alpha
      @m_picture.set_alpha(alpha,RLEACCEL)
    end
    
    @m_picture.convert!
    #@m_picture.convert_alpha!
    
    if alpha
      @m_picture.set_alpha(alpha,RLEACCEL)
    end
    
    @m_bltrect.w = @m_picture.w;
    @m_bltrect.h = @m_picture.h;

    @m_srcrect.x = 0;
    @m_srcrect.y = 0;
    @m_srcrect.w = @m_picture.w;
    @m_srcrect.h = @m_picture.h;
    
    return true
  end
  def set_alpha(alpha)
    @m_picture.set_alpha(alpha, RLEACCEL)
  end
  
  def draw(x,y,srcx=nil,srcy=nil,w=0,h=0,iHiddenDirection = -1,iHiddenValue = -1)
    @m_bltrect.x = x + $x_shake;
    @m_bltrect.y = y + $y_shake;
    @m_bltrect.w = w;
    @m_bltrect.h = h;
    if srcx
      
    
      @m_srcrect.x = srcx;
      @m_srcrect.y = srcy;
      @m_srcrect.w = w;
      @m_srcrect.h = h;
      $window.blit(@m_picture,@m_bltrect,[srcx,srcy,w,h])
    else
      #todo:
      $window.blit(@m_picture,@m_bltrect)
    end
  end
  def width
    @m_picture.w
  end
  def getWidth
    @m_picture.w
  end
  def getHeight()
    @m_picture.h
  end
  
end
class GfxFont
  def init(filename)
    if(@m_font)
      sfont_FreeFont(@m_font)
    end
    puts "loading font #{filename} ... "
    fontsurf = Surface.load_new(filename);
    if(fontsurf == nil)
      puts  "\n" " ERROR: Couldn't load file #{filename}: #{SDLError}\n";
      return false;
    end
	  
    @m_font = sfont_InitFont(fontsurf);
    if(!@m_font)
		
      puts "\n ERROR: an error occurre while loading the font.\n";
      return false;
    end

    
    return true;
	  
  end
  
  def drawRightJustified(x,y,s,*args)
    sfont_WriteRight($blitdest, @m_font, x, y, s%args);
  end
  
  def drawf(x,y,s,*args)
    draw(x,y,s % args )
  end
  
  def draw(x,y,s)
    sfont_Write($blitdest, @m_font, x, y, s);
  end
  def drawChopRight(x,y,width,s)
    sfont_WriteChopRight($blitdest, @m_font, x, y, width, s);
  end
  
  def drawCentered(x,y,text)
    sfont_WriteCenter($blitdest, @m_font, x, y, text);
  end
  
  def getWidth(text)
    return sfont_TextWidth(@m_font, text);
  end
  
  def getHeight()
    return sfont_TextHeight(@m_font);
  end
end
def gfx_setresolution(w, h, fullscreen)
  flags = GFX_FLAGS;
  if(fullscreen)
    flags |= FULLSCREEN;
  end
end
$colorcodes = Array.new(3)
NUM_SCHEMES = 9 
$colorschemes = Array.new(4)
4.times do |i|
  $colorschemes[i] = Array.new(NUM_SCHEMES)
  NUM_SCHEMES.times do |j|
    $colorschemes[i][j] = Array.new(3)
  end	
end


def gfx_close
  #same as gfx_freepalette
end

def gfx_freepalette
  #we have nothing to do here
end

def gfx_loadpalette
  gfx_freepalette
  palette = Surface.load_new("gfx/packs/Classic/palette.bmp")
  $numcolors = palette.w
  
  
  $colorcodes = [] #$numcolors array
  $colorschemes = []
    4.times do |i|
    	$colorschemes[i] = []
      NUM_SCHEMES.times do |j| 
        $colorschemes[i][j] = [] #$numcolors array
      end
      
    end
	colorcodes = $colorcodes
  colorschemes = $colorschemes
  
  if palette.must_lock
    palette.lock
  end

  counter = 0;

  $numcolors.times do |k|
    colorcodes[k] = [palette.pixels[counter+2],palette.pixels[counter+1],palette.pixels[counter]]
    counter+=3
		
    #counter += palette.pitch - palette.w * 3
  end
	
  4.times do |i|
    NUM_SCHEMES.times do |j|
      $numcolors.times do |m|
        #assume little endian
        colorschemes[i][j][m] = [palette.pixels[counter+2],palette.pixels[counter+1],palette.pixels[counter]]
        counter+=3
      end	
    end
  end

	
  if palette.must_lock
    palette.unlock
  end
  #palette.destory
end
def validSkinSurface(skin)
  if(skin.w == 192 && skin.h == 32 && skin.bitsize == 24) # && skin->format->BitsPerPixel == 24)
    return true;
  end
  return false;
end
def gfx_createfullskin(gSprites, filename, r, g, b, colorScheme)
  skin = Surface.load_new(filename);
  if(!validSkinSurface(skin))
    return false
  end
  puts "valid skin:#{filename}"
  
  4.times do |k|
    2.times do |j|
      skinSurface = gfx_createskinsurface(skin, k, r, g, b, colorScheme, true, j != 0);

      gSprites[(k * 2) + j].surface = skinSurface;
    end
  end
  
  #Dead Flying Sprite
  skinSurface = gfx_createskinsurface(skin, 4, r, g, b, colorScheme, true, false);
  gSprites[8].surface = skinSurface;
  
  #Dead Stomped Sprite
	skinSurface = gfx_createskinsurface(skin, 5, r, g, b, colorScheme, true, false);
	gSprites[9].surface = skinSurface;
  
end
def gfx_createskinsurface(skin,spriteindex,r,g,b,colorScheme,expand,reverse)
    #skin.set_colorkey([255,0,255,255]) #tmp
    #return skin #tmp
  
  loops = 1
  if(expand)
    loops = NUM_SCHEMES;
  end
  
  temp = Surface.new([32 * loops, 32],skin)
	
  if(temp.must_lock())
    puts "temp must lock"
    temp.lock()
  end

  if(skin.must_lock())
    pust "skin must lock"
    skin.lock()
  end
  #puts "spriteindex : #{spriteindex}"
  colorcodes = $colorcodes
  colorschemes = $colorschemes
  
  x=spriteindex*32
  
	
  reverseoffset = 0;
  32.times do |j|
    32.times do |i|
      if(reverse)
        #reverseoffset = 0
        reverseoffset = (31 - i);
        offset = 31-i
      else
        offset = i
      end
      fFoundColor = false
      #puts "examing skin [#{x+i},#{j}], #{skin[x+i,j].inspect}"
      $numcolors.times do |m|
        
        if( skin[x+i,j] == colorcodes[m] + [255])
				  #puts "found skin color #{skin[x+i,j].inspect}"
          loops.times do |k|
            temp[offset + k*32 ,j] = colorschemes[colorScheme][k][m];
          end
						
          fFoundColor = true;
          break;
        end
      end #end times of numcolors
      if !fFoundColor
        
        loops.times do |k|
          temp[offset + k*32,j] = skin[x+i,j];
        end
      end
      
      
    end #end i loop
	  
  end #end j loop
  if(skin.must_lock())
    skin.unlock
  end
  if(temp.must_lock())
    temp.unlock
  end
  temp.set_colorkey([r,g,b,255],RLEACCEL)
  final = temp.convert #copy from temp
  return final
end
def gfx_createmenuskin(gSprite, filename, r, g, b, colorScheme)
  # Load the BMP file into a surface
  puts "load menuskin #{filename}"
  skin = Surface.load_new(filename);
  if(!validSkinSurface(skin))
    return false;
  end
  2.times do |iSprite|
    skinSurface = gfx_createskinsurface(skin, iSprite, r, g, b, colorScheme, true, false);
    #require 'debug'
    gSprite[iSprite * 2].surface = skinSurface;
  end
end