class SfxSound
  def initialize
    @paused = false;
    @ready = false;
    @sound = nil;
  end
  
  def init(filename)
    if(@sound)
      reset();
    end
    @sound = Sound.new(filename)
    @sound.volume = $game_values.soundvolume/128.0
	  
    @channel = nil;
    @starttime = 0;
    @ready = true;
    @instances = 0;
  	
    #Mix_ChannelFinished(&soundfinished);
    #@sound.post_end_event = true
  	
    return true;
  
  end
  
  def sfx_pause
    @paused = !@paused;

    if(@paused)
      @channel.pause if @channel;
    else
      @channel.unpause if @channel;
    end
  end
  
  def play
    ticks = Timer.ticks;
    #Dont play sounds right over the top (doubles volume)
    if(@channel.nil? || ticks - @starttime > 40)
      @instances+=1;
      @channel = @sound.play(0)
  		
      return @channel if @channel.nil?
  
      @starttime = ticks;
  		
      if($g_PlayingSoundchannels[@channel])
        printf("Error: Sound was played on @channel that was not cleared!\n");
      end
      $g_PlayingSoundchannels[@channel] = self;
    end
    return @channel;
  end
  
  def playloop(iLoop)
    instances+=1;
    @channel = @sound.play(iLoop);
  
    return channel if @channel.nil?
  
    $g_PlayingSoundChannels[@channel] = self
  
    return @channel;
  end
  
  def stop
    if(@channel)
      @instances = 0;
      @channel.stop;
      @channel = nil
    end
  end
  
  def pause
    @paused = !@paused;

    if(@paused)
      @channel.pause
    else
      @channel.resume
    end
 		
  end
  
  def clearchannel
    @instances -= 1
    if(@instances <= 0)
      @instances = 0;
      @channel = nil
    end
  end
  
  
  
  def resetpause() 
    @paused = false
  end
  def reset
    @paused = false;
    @ready = false;
    @sound = nil;
  	
    if(@channel)
      $g_PlayingSoundChannels[@channel] = nil;
    end

    @channel = nil;
  end
  def isplaying
    return @channel != nil && @channel.busy?
  end
  
end
class SfxMusic
  def initialize
    @paused = false;
    @ready = false;
    @music = nil;
  end
  def load(filename)
    if(@music)
      reset();
    end
    puts "load #{filename}...";
    @music = Music.new(filename);
	  
    if(!@music)
      printf("Error Loading Music: %s\n", Mix_GetError());
      return false;
    end
	  
    @music.post_end_event = true
    @music.volume = $game_values.musicvolume/128.0 #we add here
	  
    #EndOfMusicEvent
    #Mix_HookMusicFinished(&musicfinished);

    @ready = true;
  
    return true;
  end

  def play(fPlayonce, fResume)
    @music.play(fPlayonce ? 0 : -1)
    $fResumeMusic = fResume;
  end
  def stop()
    @music.stop
  end
  def sfx_pause()
    @paused = !@paused;

    if(@paused)
      @music.pause
    else
      @music.unpause
    end
  end

  def resetpause() 
    @paused = false
  end

  def reset()
    @music = nil;
    @ready = false;
  end
  def isready() 
    return @ready
  end
  def isplaying()
    return @music && @music.busy?
  end

end
def sfx_close
  #close audio
  #Mixer.destory
end
def soundfinished(channel)
  
end

def musicfinished
  game_values = $game_values
  if(!game_values.music)
    return;
  end
  if(game_values.gamestate == :GS_GAME && !game_values.gamemode.gameover)
    if(game_values.playnextmusic)
      #musiclist.SetNextMusic(g_map.musicCategoryID, maplist.currentShortmapname(), g_map.szBackgroundFile);
      #backgroundmusic[0].load(musiclist.GetCurrentMusic());
    end
    backgroundmusic[0].play(game_values.playnextmusic, false);
  elsif $fResumeMusic
    backgroundmusic[3].play(false, false);
  end
end

def sfx_setmusicvolume(volume)

  #Mix_VolumeMusic(volume);
end

def sfx_setsoundvolume(volume)
  #Mix_Volume(-1, volume);
end