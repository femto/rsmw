MENU_CODE_NONE=0 
MENU_CODE_UNSELECT_ITEM=1 
MENU_CODE_INPUT_TYPE_CHANGED=2 
MENU_CODE_INPUT_DEVICE_CHANGED=3 
MENU_CODE_CANCEL_INPUT=4 
MENU_CODE_START_GAME=5 
MENU_CODE_MODIFY_ACCEPTED=6
MENU_CODE_BONUS_DONE=7 
MENU_CODE_EXIT_APPLICATION=8 
MENU_CODE_TO_OPTIONS_MENU=9 
MENU_CODE_TO_CONTROLS_MENU=10 
MENU_CODE_BACK_TO_CONTROLS_MENU=11 
MENU_CODE_TO_PLAYER_1_CONTROLS=12 
MENU_CODE_TO_PLAYER_2_CONTROLS=13 
MENU_CODE_TO_PLAYER_3_CONTROLS=14 
MENU_CODE_TO_PLAYER_4_CONTROLS=15 
MENU_CODE_TO_MAIN_MENU=16 
MENU_CODE_TOGGLE_FULLSCREEN=17 
MENU_CODE_TO_SCREEN_SETTINGS=18 
MENU_CODE_TO_SCREEN_RESIZE=19 
MENU_CODE_MODE_CHANGED=20 
MENU_CODE_TO_GAME_SETUP_MENU=21 
MENU_CODE_TO_TEAM_SELECT_MENU=22 
MENU_CODE_BACK_TEAM_SELECT_MENU=23 
MENU_CODE_SOUND_VOLUME_CHANGED=24 
MENU_CODE_MUSIC_VOLUME_CHANGED=25 
MENU_CODE_TOURNAMENT_CHANGED=26 
MENU_CODE_TO_MODE_SETTINGS_MENU=27 
MENU_CODE_BACK_TO_GAME_SETUP_MENU=28 
MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS=29 
MENU_CODE_EXIT_TOURNAMENT_YES=30 
MENU_CODE_EXIT_TOURNAMENT_NO=31 
MENU_CODE_TO_POWERUP_SELECTION_MENU=32 
MENU_CODE_BACK_TO_OPTIONS_MENU=33 
MENU_CODE_RESTORE_DEFAULT_POWERUP_WEIGHTS=34 
MENU_CODE_TO_GRAPHICS_OPTIONS_MENU=35 
MENU_CODE_TO_SOUND_OPTIONS_MENU=36 
MENU_CODE_TO_GAMEPLAY_OPTIONS_MENU=37 
MENU_CODE_TO_TEAM_OPTIONS_MENU=38 
MENU_CODE_BACK_TO_GRAPHIC_OPTIONS_MENU=39 
MENU_CODE_MENU_GRAPHICS_PACK_CHANGED=40 
MENU_CODE_GAME_GRAPHICS_PACK_CHANGED=41 
MENU_CODE_SOUND_PACK_CHANGED=42 
MENU_CODE_TO_PROJECTILES_OPTIONS_MENU=43 
MENU_CODE_TO_POWERUP_SETTINGS_MENU=44
MENU_CODE_POWERUP_RESET_YES=45 
MENU_CODE_POWERUP_RESET_NO=46 
MENU_CODE_TOUR_STOP_CONTINUE=47 
MENU_CODE_EXIT_TOUR_YES=48 
MENU_CODE_EXIT_TOUR_NO=49 
MENU_CODE_RESET_STORED_POWERUPS=50
MENU_CODE_MAP_CHANGED=51
MENU_CODE_MAP_FILTER_EXIT=52
MENU_CODE_TO_MAP_FILTERS=53
MENU_CODE_TO_MAP_FILTER_EDIT=54
MENU_CODE_MAP_BROWSER_EXIT=55
MENU_CODE_TO_MAP_BROWSER_THUMBNAILS=56
MENU_CODE_SAVE_ALL_MAP_THUMBNAILS=57
MENU_CODE_BACK_TO_SCREEN_SETTINGS_MENU=58
MENU_CODE_SCREEN_FILTER_CHANGED=59
MENU_CODE_SCREEN_SETTINGS_CHANGED=60
MENU_CODE_GENERATE_THUMBS_RESET_YES=61
MENU_CODE_GENERATE_THUMBS_RESET_NO=62
class UI_Menu
  def initialize
    @cancelCode = MENU_CODE_NONE;
    @fModifyingItem = false;
    @headControl = nil;
    @current = nil;
    @controls = []
    @eyeCandy = CEyecandyContainer.new
  end
  def addControl(control, up, down, left, right)
    control.setMenuParent(self);
    @controls << control;
    control.setNeighbor(MENU_ITEM_NEIGHBOR_UP, up);
    control.setNeighbor(MENU_ITEM_NEIGHBOR_DOWN, down);
    control.setNeighbor(MENU_ITEM_NEIGHBOR_LEFT, left);
    control.setNeighbor(MENU_ITEM_NEIGHBOR_RIGHT, right);
  end
  def addNonControl(control)
    control.setMenuParent(self);
    @controls << control;
  end
  def setHeadControl(control)
    @headControl = control;
    resetMenu();
  end
  def resetMenu
    if(@current)
      @current.modify(false);
      @current.select(false);
    end

    @current = @headControl;
	
    if(@current)
      @fModifyingItem = @current.select(true);
    end
    @eyeCandy.clean();
  end
  def setCancelCode(code)
    @cancelCode = code
  end
  def update
    @controls.each do |control|
      control.update
    end
    @eyeCandy.cleandeadobjects();
    @eyeCandy.update();
  end
  def draw
    @controls.each do |control|
      if control.respond_to? "draw"
        control.draw
      end
    end
    @eyeCandy.draw();
  end
  
  def sendInput(playerInput)
    if(@fModifyingItem)
      
      ret = @current.sendInput(playerInput);
  		
      if(MENU_CODE_UNSELECT_ITEM == ret)
        puts "MENU_CODE_UNSELECT_ITEM"
        @fModifyingItem = false;
  			
        if(@current.isAutoModify())
          puts "returning cancelCode:#{@cancelCode}"
          return @cancelCode;
        end
  
        return MENU_CODE_NONE;
      end
      return ret;
    end
    game_values = $game_values
    4.times do |iPlayer|
      #next if(iPlayer != 0 && game_values.playerInput.inputControls[iPlayer].iDevice == DEVICE_KEYBOARD)
      if(playerInput.outputControls[iPlayer].menu_up.fPressed)
        moveNextControl(MENU_ITEM_NEIGHBOR_UP);
      end
      if(playerInput.outputControls[iPlayer].menu_down.fPressed)
        moveNextControl(MENU_ITEM_NEIGHBOR_DOWN);
      end
      if(playerInput.outputControls[iPlayer].menu_left.fPressed)
        moveNextControl(MENU_ITEM_NEIGHBOR_LEFT);
      end
      if(playerInput.outputControls[iPlayer].menu_right.fPressed)
        moveNextControl(MENU_ITEM_NEIGHBOR_RIGHT);
      end
      
      if(playerInput.outputControls[iPlayer].menu_select.fPressed)
        puts "menu_select pressed at sendInput@UI_Menu dispatch"
        
        ret = @current.modify(true);
			
        if(MENU_CODE_MODIFY_ACCEPTED == ret)
          @fModifyingItem = true;
          return MENU_CODE_NONE;
        end
  			
        if(MENU_CODE_UNSELECT_ITEM == ret)
          @fModifyingItem = false;
          return MENU_CODE_NONE;
        end
			
        return ret;
      end
      
      if(playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        return @cancelCode
      end
    end
    return MENU_CODE_NONE
  end
  
  def moveNextControl(iDirection)
    neighbor = @current.getNeighbor(iDirection); 
    while(neighbor && !neighbor.isVisible())
      neighbor = neighbor.getNeighbor(iDirection);
    end
    if(neighbor)
      @current.select(false);
      @current = neighbor;
      @fModifyingItem = @current.select(true);
    end
    puts "current:#{@current}"
  end
  
  def rememberCurrent
    @savedCurrent = @current;
  end
  
  def restoreCurrent
    if(@current)
      @current.modify(false);
      @current.select(false);
    end
	
    @current = @savedCurrent;
	
    if(@current)
      @fModifyingItem = @current.select(true);
    end
	
    @eyeCandy.clean();
  end
  

end

