require 'dirlist'
class SkinListNode
  attr_accessor :skinName,:skinPath
  
  def initialize(skinName,skinPath)
    @skinName = skinName
    @skinPath = skinPath
  end
end
class SkinList
  def initialize
    @skins = []
    Dir.new("gfx/skins").each do |x|
      #skip . and ..
      if x!= "." && x!= ".." && x!='.svn' #actually we should ignore all things start with . and Thumbs.db as well
        sShortSkinName = stripCreatorAndDotMap(x);
        @skins << SkinListNode.new(sShortSkinName,"gfx/skins" + "/" + x)
      end
    end
    
  end
  def getCount() 
    return @skins.size();
  end
  def getIndex(index)
    if(index < @skins.size())
      return @skins[index].skinPath;
    end
    return nil;
  end
  def getSkinName(index)
    if(index < @skins.size())
      return @skins[index].skinName
    end

    return nil;
  end
end
class MapListNode
  attr_accessor :fullname,:pfFilters,:fInCurrentFilterSet,:iFilteredIndex,:iIndex,:shortName
  def initialize(fullname)
    @fullname = fullname
    @pfFilters = []
    @fInCurrentFilterSet = true;
    
    @iIndex = 0;
    @iFilteredIndex = 0
    
    @fReadFromCache = false;
    @fValid = true;
  end
  def filename
    @fullname[@fullname.rindex('/')+1..-1]
  end
end
class MapList
  #todo:
  attr_accessor :current
  def initialize
    @current = 0
    @savedcurrent = 0
    @maps = {}
    @indexs = []
    
    entries = Dir.entries("maps").delete_if {|x|
      x=="." || x==".." || !File.file?("maps/#{x}")
    }
    entries.sort_by{|x| stripCreatorAndDotMap(x).downcase}.each_with_index do |x, i|
      if x!="." && x!=".." && File.file?("maps/#{x}")
        node = MapListNode.new("maps/#{x}")
        shortName = stripCreatorAndDotMap(x)
        @maps[shortName] = node
        @indexs << shortName
        
        node.shortName = shortName
        node.iIndex = i
        #todo
        node.iFilteredIndex = i
      end
    end
    
    @iFilteredMapCount = @maps.size
    
    if(@maps.empty?())
      puts ("ERROR: Empty map directory!\n");
      exit;
    end
    
    @mlnFilteredMaps = [];
    @mlnMaps = [];
    
  end
  def currentFilename()
    @maps[@indexs[@current]].fullname
  end
  
  def currentShortmapname
    @indexs[@current]
  end
  
  def findexact(name)
  end
  
  def Prev(fUseFilters)
    current_index = @current
    if(fUseFilters)
      Prev(false)
    else
      @current -=1
      if @current < 0
        @current = @maps.size - 1
      end
      
    end
    return current_index != @current
  end
  def Next(fUseFilters)
    current_index = @current
    if(fUseFilters)
      Next(false)
    else
      @current +=1
      if @current > @maps.size - 1
        @current = 0
      end
      
    end
    return current_index != @current
  end
  def fastPrev(fUseFilters,numadvance)
    current_index = @current
    numadvance.times do |i|
      Prev(fUseFilters)
    end
    return current_index != @current
  end
  
  def fastNext(fUseFilters,numadvance)
    current_index = @current
    numadvance.times do |i|
      Next(fUseFilters)
    end
    return current_index != @current
  end
  def random(fUseFilters)
  end
  
  def startswith(letter)
    #Captialize the letter becuase all maps have first letter in caps
    if(letter >= K_a && letter <= K_z)
      letter -= 32;
    end
    oldCurrent = @current
		
    begin
      Next(true);	#sets us to the beginning if we hit the end -> loop through the maps
	
      if(currentShortmapname()[0] == letter)
        return true;
      end
    end	while(current != oldCurrent);

    return false;
  end  
  
  def getCurrent
    @maps[@indexs[@current]]
  end
  
  def get(iIndex, fUseFilters)
    @maps[@indexs[iIndex]] #todo:fUseFilters later
  end
  
  def setCurrent(iIndex)
    @current = iIndex
  end
  
  def getFilteredCount
    #todo
    @maps.size()
  end
  
  #def GetCount() 
  #{return maps.size();}
  #end
  
  def applyFilters(pfFilters)
    game_values = $game_values
    @iFilteredMapCount = 0;
    iTotalCount = 0;
    @maps.values.each do |node|
    	fMatched = true;
    	(NUM_AUTO_FILTERS + $filterslist.getCount()).times do |iFilter|
    		if(pfFilters[iFilter])
    		  if !node.pfFilters[iFilter]
    		    fMatched = false
    		    break
    		  end
    	  end
    	end
    	node.fInCurrentFilterSet = fMatched
    	if(fMatched)
    	  node.iFilteredIndex = @iFilteredMapCount
    	  @mlnFilteredMaps[@iFilteredMapCount] = node;
    	  @iFilteredMapCount += 1
      end
      iTotalCount += 1
      @mlnMaps[iTotalCount] = node
    end
    
    game_values.fFiltersOn = false;   
    (NUM_AUTO_FILTERS + $filterslist.getCount()).times do |iFilter|
    	if(pfFilters[iFilter])
				game_values.fFiltersOn = true;
				break;
			end
    end
    
    findFilteredMap()
    
  end
  #Returns true if the map needs to be reloaded
  def findFilteredMap
    if(@maps[@indexs[@current]].fInCurrentFilterSet)
			return false;
		end
	
		Next(true);
		return true;
  end
  def mapInFilteredSet
    return @maps[@indexs[@current]]
  end
end
class SimpleFileList
  def initialize(path, extension)
    d = Dir.new(path);
    @filelist = []
    d.each do |x|
      @filelist << (path + x) if x.rindex(extension)
    end
    
    @currentIndex = 0
    @currentIndex = -1 if @filelist.empty?
    
  end
  def getCurrentIndex
    @currentIndex
  end
  def setCurrent(index)
		
    if(@filelist.empty?())
      return;
    end

    if(index < @filelist.size())
      @currentIndex = index;
    else
      @currentIndex = 0;
    end
  end
  def current_name()
		
    if(@currentIndex > -1)
      return @filelist[@currentIndex];
    end
    return nil;
  end
  
  def getCount() 
    return @filelist.size
  end
  
  def getIndex(index)
    if(index < @filelist.size())
      return @filelist[index];
    end
    return nil;    
  end
  
end
class AnnouncerList < SimpleFileList
  def initialize
    super(convertPath("sfx/announcer/"), ".txt")
  end
end

class MusicEntry
  attr_accessor :fError,:fUsesMapOverrides,:fUsesBackgroundOverrides
  attr_accessor :numsongsforcategory,:songsforcategory
  def initialize(musicdirectory)
  
    @fError = false;
    @fUsesMapOverrides = false;
    @fUsesBackgroundOverrides = false;
    @iCurrentMusic = 0
		
    szDir = musicdirectory
		
    @numsongsforcategory = []
		
		
		
    MAXMUSICCATEGORY.times do |k|
      @numsongsforcategory[k] = 0
      musiclistname = musicdirectory[musicdirectory.rindex("/")+1..-1]
      name = musiclistname;
      musicfile = musicdirectory + "/" + "Music.txt"
      file = nil
      begin
        file = File.open(musicfile, "r");
      rescue
        puts "Error: Could not open: #{musicfile}"
        @fError = true
			
      end
		  
      iNumFile = 0;
      iAddToCategory = -1;
      #szBuffer[256];
      file.each do |line|
        next if line[0] == ?# or line[0] == ' '[0] or line[0] == ?\t or line[0] == ?\n or line[0] == ?\r
        line.delete!("\r\n") #delete both \r and \n
        #If we found a category header
        if(line[0] == '[')
          line = line.downcase
          if(line ==  "[land]")
            iAddToCategory = 0;
          elsif(line ==  "[underground]")
            iAddToCategory = 1;
          elsif(line ==  "[underwater]")
            iAddToCategory = 2;
          elsif(line ==  "[castle]")
            iAddToCategory = 3;
          elsif(line ==  "[platforms]")
            iAddToCategory = 4;
          elsif(line ==  "[ghost]")
            iAddToCategory = 5;
          elsif(line ==  "[bonus]")
            iAddToCategory = 6;
          elsif(line ==  "[battle]")
            iAddToCategory = 7;
          elsif(line ==  "[desert]")
            iAddToCategory = 8;
          elsif(line ==  "[clouds]")
            iAddToCategory = 9;
          elsif(line ==  "[snow]")
            iAddToCategory = 10;
          elsif(line ==  "[maps]")
            iAddToCategory = MAXMUSICCATEGORY;
          elsif(line == "[backgrounds]")
            iAddToCategory = MAXMUSICCATEGORY + 1;
          end
		
          next;
        end
      end
    end
		 
  end
  def getMusic(musicID)
    if (musicID >= @songFileNames.size())
      return @songFileNames[@songFileNames.size()-1];
    end
    return @songFileNames[musicID];
  end
end

class FiltersList < SimpleFileList
  def initialize
    super(convertPath("filters/"), ".txt")
  end
  
end

class MusicList  
  def initialize
    @entries = []
    dir = Dir.new(convertPath("music/"))
    dir.each do |x|
      if x!= "." && x!=".." && x!= ".svn" && File.directory?("music/" + x)
        m = MusicEntry.new("music/" + x);
        if (!m.fError)
          @entries << m;
        end
      end
    end
    if @entries.empty?
      puts ("ERROR: Empty Music directory!");
      exit
    end
    @currentIndex = 0;
    
    
  end
  
  def getCurrentIndex()
    return @currentIndex;
  end
  def setCurrent(index)
    if(index < @entries.size())
      @currentIndex = index;
    else
      @currentIndex = 0;
    end
  end
	
  def getMusic(musicID)
    @entries[@currentIndex].getMusic(musicID);
  end
  
  def setRandomMusic(iMusicCategory, szMapName, szBackground)
    #@currentMusic = @entries[@currentIndex].getRandomMusic(iMusicCategory, szMapName, szBackground);
    @currentMusic = "music/Standard/smb3level1.ogg"
  end
  
  def getCurrentMusic
    @currentMusic
  end
  
  def setNextMusic(iMusicCategory, szMapName, szBackground)
	  #@currentMusic = @entries[@currentIndex].getNextMusic(iMusicCategory, szMapName, szBackground);
  end

end
