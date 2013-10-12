# Delcare one variable of this type for each font you are using.
# To load the fonts, load the font image into YourFont->Surface
# and call InitFont( YourFont );
class SFont_Font
  attr_accessor :surface
  attr_accessor :charPos #an Array of 512
  attr_accessor :maxPos
  def initialize
    @charPos = Array.new(512)
  end
end

def sfont_InitFont(surface)
    x = 0
    i = 0;
    #pixel;
    #font;
    #pink;

    if (surface == nil)
	     return nil
	  end

    font = SFont_Font.new
    font.surface = surface;

    surface.lock

    pink = [255, 0, 255, 255];
    while (x < surface.w) do 
			if (surface[x, 0] == pink)  
		    	    font.charPos[i]=x;
		    	    i+=1
		    	    while x < surface.w && surface[x, 0]== pink do
				         x+=1
				      end
			        font.charPos[i]=x;
			        i+=1
			end
			x+=1;
    end
    font.maxPos = x-1
    
    pixel = surface[0,surface.h-1];
    surface.unlock
    surface.set_colorkey(pixel, RLEACCEL)
    
    #SDL_SetColorKey(Surface, SDL_SRCCOLORKEY, pixel);

    return font;
end
def sfont_Write(surface,font,x,y,text)
  
  #  int charoffset;
  srcrect = []
  dstrect = [];
  return if text.nil?
  
  # these values won't change in the loop
  srcrect.y = 1;
  srcrect.h = dstrect.h = font.surface.h - 1;
  
  $x_shake = 0
  $y_shake = 0
  i=0
  
  text.each_byte do |c|
  	break if x > surface.w
   
		charoffset = (c - 33) * 2 + 1;
		# skip spaces and nonprintable characters
		if (c == ' '[0] || charoffset < 0 || charoffset > font.maxPos) 
		
			x += font.charPos[2]-font.charPos[1];
			next
		end

		srcrect.w = dstrect.w = 
			(((font.charPos[charoffset+2] + font.charPos[charoffset+1]) >> 1) -
			((font.charPos[charoffset] + font.charPos[charoffset-1]) >> 1));

		srcrect.x = (font.charPos[charoffset] + font.charPos[charoffset-1]) >> 1;
		#debug
		delta = ((font.charPos[charoffset]- font.charPos[charoffset-1]) >> 1).to_f
		
		dstrect.x =  (x - delta) + $x_shake;
		
					#dstrect.x =  x + $x_shake;
					
		#dstrect.x =  x + $x_shake;

		dstrect.y = (y + $y_shake);
    surface.blit(font.surface,[dstrect.x.to_i,dstrect.y],srcrect)
		#surface.flip

		x += font.charPos[charoffset+1] - font.charPos[charoffset];
		i+=20
  end
end
def sfont_WriteCenter(surface,font,x,y,text)
  sfont_Write(surface, font, x - (sfont_TextWidth(font, text) >> 1), y, text);
end

def sfont_TextWidth(font,text)
  #const char* c;
  #charoffset=0;
  width = 0;

  return 0 if text.nil?
	text.each_byte do |c|
	  charoffset = (c - 33) * 2 + 1;
	  
	  if (c == ' '[0] || charoffset < 0 || charoffset > font.maxPos) 
      width += font.charPos[2] - font.charPos[1];
			next;
		end
	
		width += font.charPos[charoffset+1] - font.charPos[charoffset];
	end
	return width
end

def sfont_TextHeight(font)
  return font.surface.h - 1
end

def sfont_WriteRight(surface, font, x, y, text)
    sfont_Write(surface, font, x - sfont_TextWidth(font, text), y, text);
end

def sfont_WriteChopRight(surface,font,x,y,w,text)
  #const char* c;
  #  int charoffset;
  #  SDL_Rect srcrect, dstrect;
	startx = x;

    if(text == nil)
		  return;
		end
    srcrect = []
    dstrect = []
    # these values won't change in the loop
    srcrect.y = 1;
    srcrect.h = dstrect.h = font.surface.h - 1;
    text.each_byte do |c|
      break if x > surface.w
	
  		charoffset = (c - 33) * 2 + 1;
  		# skip spaces and nonprintable characters
  		if (c == ' '[0] || charoffset < 0 || charoffset > font.maxPos) 
  		
  			x += font.charPos[2]-font.charPos[1];
  			next
  		end
  		
  		srcrect.w = dstrect.w = 
			(((font.charPos[charoffset+2] + font.charPos[charoffset+1]) >> 1) -
			((font.charPos[charoffset] + font.charPos[charoffset-1]) >> 1));
  		
  		if(x - startx + srcrect.w > w)
  			break;
  		end
  
  		srcrect.x = (font.charPos[charoffset] + font.charPos[charoffset-1]) >> 1;
  		delta = ((font.charPos[charoffset]- font.charPos[charoffset-1]) >> 1).to_f
  		dstrect.x =  (x - delta) + $x_shake;
  
  		dstrect.y = (y + $y_shake);
  
  		surface.blit(font.surface,[dstrect.x.to_i,dstrect.y],srcrect)
		  #surface.flip

		  x += font.charPos[charoffset+1] - font.charPos[charoffset];
    end
end

def sfont_FreeFont(font)
 #font.surface.destroy
 #font = nil #no need
end