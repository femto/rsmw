class UI_Control
  def initialize(x,y)
    @fSelected = false;
    @fModifying = false;
    @fAutoModify = false;
    @ix = x;
    @iy = y;
	
    @fShow = true;
    @neighborControls = [] #4 
	
    @uiMenu = nil;
  end
  def sendInput(input)
    return MENU_CODE_NONE
  end
  def show(show)
    @fShow = show
  end
  def setPosition(x, y) 
    @ix = x; @iy = y;
  end
  def setMenuParent(menu)
    @uiMenu = menu
  end
	
  def setNeighbor(iNeighbor, uiControl) 
    @neighborControls[iNeighbor] = uiControl;
  end
  def getNeighbor(iNeighbor) 
    return @neighborControls[iNeighbor];
  end
  
  def isVisible
    @fShow
  end
  
  def select(select)
    @fSelected = select;

    if(@fSelected && @fAutoModify)
      modify(true);
    end
    puts "returning @fModifying #@fModifying"
    
    return @fModifying;
  end
  def modify(modify) 
    @fModifying = modify; return MENU_CODE_MODIFY_ACCEPTED;
  end
  def update
  end
	
  def draw
  end
	
  def setAutoModify(modify)
    puts "setting automodify to #{modify}"
    @fAutoModify = modify
  end
  def isAutoModify() 
    return @fAutoModify;
  end
end

class MI_Button < UI_Control
  def initialize(nspr, x, y, name, width, justified)
    super(x,y)
    @spr = nspr;
    @szName = name;
    @iWidth = width;
    @iTextJustified = justified;
    @fSelected = false;
    @menuCode = MENU_CODE_NONE;
  
    @sprImage = nil;
    @iImageSrcX = 0;
    @iImageSrcY = 0;
    @iImageW = 0;
    @iImageH = 0;
  
    #todo
    @iTextW = 52 #$menu_font_large.getWidth(name);
  
    @iAdjustmentY = width > 256 ? 0 : 128;
    @iHalfWidth = width >> 1;
  end
  def setCode(code)
    @menuCode = code
  end
  def setName(name)
    @szName = name; 
    @iTextW = $menu_font_large.getWidth(name);
  end
  def draw
    if(!@fShow)
      return;
    end
    @iAdjustmentY ||= 0
		
    @spr.draw(@ix, @iy, 0, (@fSelected ? 32 : 0) + @iAdjustmentY, @iHalfWidth, 32);
    @spr.draw(@ix + @iHalfWidth, @iy, 512 - @iWidth + @iHalfWidth, (@fSelected ? 32 : 0) + @iAdjustmentY, @iWidth - @iHalfWidth, 32);
  
    if(0 == @iTextJustified)
      $menu_font_large.drawChopRight(@ix + 16 + (@iImageW > 0 ? @iImageW + 2 : 0), @iy + 5, @iWidth - 32, @szName);
  		
      if(@sprImage)
        @sprImage.draw(@ix + 16, @iy + 16 - (iImageH >> 1), @iImageSrcX, @iImageSrcY, @iImageW, iImageH);
      end
    elsif(1 == @iTextJustified)
      $menu_font_large.drawCentered(@ix + ((@iWidth + (@iImageW > 0 ? @iImageW + 2 : 0)) >> 1), @iy + 5, @szName);
  
      if(@sprImage)
        @sprImage.draw(@ix + (@iWidth >> 1) - ((iTextW + @iImageW) >> 1) - 1, @iy + 16 - (iImageH >> 1), @iImageSrcX, @iImageSrcY, @iImageW, iImageH);
      end
    else
      $menu_font_large.drawRightJustified(@ix + @iWidth - 16, @iy + 5, @szName);
  
      if(@sprImage)
        @sprImage.draw(@ix + @iWidth - 18 - iTextW - @iImageW, @iy + 16 - (iImageH >> 1), @iImageSrcX, @iImageSrcY, @iImageW, iImageH);
      end
    end
  end
  
  def modify(modify)
    return @menuCode
  end
  
  def sendInput(playerInput)
    raise "x"
  end
  
end

class MI_Image < UI_Control
  def initialize(nspr, x, y, srcx, srcy, w, h, numxframes, numyframes, speed) 
    super(x,y)
    @spr = nspr;
    @isrcx = srcx;
    @isrcy = srcy;
    @iw = w;
    @ih = h;
	
    @iNumXFrames = numxframes;
    @iNumYFrames = numyframes;
    @iSpeed = speed;
		
    @iTimer = 0;
    @iXFrame = srcx;
    @iYFrame = srcy;
	
    @fPulse = false;
    @iPulseValue = 0;
    @fPulseOut = true; 
    @iPulseDelay = 0;
	
    @fSwirl = false;
    @dSwirlRadius = 0.0;
    @dSwirlAngle = 0.0;
    @dSwirlRadiusSpeed = 0.0;
    @dSwirlAngleSpeed = 0.0;
  end
  def draw
    if(!@fShow)
      return;
    end
    iXOffset = 0;
    iYOffset = 0;
  
    if(@fSwirl)
      iXOffset = (@dSwirlRadius * cos(@dSwirlAngle));
      iYOffset = (@dSwirlRadius * sin(@dSwirlAngle));
    end
  
    if(@fPulse)
      #@spr.drawStretch(@ix - @iPulseValue + iXOffset, @iy - @iPulseValue + iYOffset, @iw + (@iPulseValue << 1), ih + (@iPulseValue << 1), @iXFrame, @iYFrame, @iw, @ih);
    else
      @spr.draw(@ix + iXOffset, @iy + iYOffset, @iXFrame, @iYFrame, @iw, @ih);    
    end
  end
end

class MI_Text < UI_Control
  def initialize(text, x, y, w, size, justified)
    @szText = text;
	
    @iw = w;
    @iJustified = justified;
		
    if(size == 0)
      @font = $menu_font_small;
    else
      @font = $menu_font_large;
    end
  end
end

class MI_PlayerSelect < UI_Control
  def initialize(nspr, x, y, name, width, indent)
    super(x,y)
    @spr = nspr;
    @iSelectedPlayer = 0;
	
    @szName = name;
    @iWidth = width;
    @iIndent = indent;
	
    @miModifyImage = MI_Image.new(nspr, @ix, @iy - 6, 32, 128, 78, 78, 4, 1, 8);
    @miModifyImage.show(false);
	
    iSpacing = (width - indent - 136) / 5;
    @iPlayerPosition = []
    @iPlayerPosition[0] = iSpacing + indent;
    @iPlayerPosition[1] = @iPlayerPosition[0] + iSpacing + 34;
    @iPlayerPosition[2] = @iPlayerPosition[1] + iSpacing + 34;
    @iPlayerPosition[3] = @iPlayerPosition[2] + iSpacing + 34;
	
    setImagePosition();
  end
  def setImagePosition
    @miModifyImage.setPosition(@ix + @iPlayerPosition[@iSelectedPlayer] - 22, @iy - 7)
  end
  def modify(modify)
    @miModifyImage.show(modify);
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
  def sendInput(playerInput)
    game_values = $game_values
    4.times do |iPlayer|
      if(playerInput.outputControls[iPlayer].menu_right.fPressed)
        
        @iSelectedPlayer += 1
        if(@iSelectedPlayer > 3)
          @iSelectedPlayer = 0;
        end
        setImagePosition();
      end
      
      if(playerInput.outputControls[iPlayer].menu_left.fPressed)
        @iSelectedPlayer -=1
        if(@iSelectedPlayer < 0)
          @iSelectedPlayer = 3;
        end
        setImagePosition();
      end
		  
      if(playerInput.outputControls[iPlayer].menu_up.fPressed)
        game_values.playercontrol[@iSelectedPlayer] -= 1
        if game_values.playercontrol[@iSelectedPlayer] < 0
          game_values.playercontrol[@iSelectedPlayer] = 2;
        end
		    
        if(game_values.playercontrol[@iSelectedPlayer] == 0)
          iCountPlayers = (game_values.playercontrol.select {|x| x>0}.size)
          if(iCountPlayers < 2)
            game_values.playercontrol[@iSelectedPlayer] = 2;
          end
        end
		    
      end
		  
      if(playerInput.outputControls[iPlayer].menu_down.fPressed)
        game_values.playercontrol[@iSelectedPlayer] += 1
        if game_values.playercontrol[@iSelectedPlayer] > 2
          game_values.playercontrol[@iSelectedPlayer] = 0;
        end
		    
        if(game_values.playercontrol[@iSelectedPlayer] == 0)
          iCountPlayers = (game_values.playercontrol.select {|x| x>0}.size)
          if(iCountPlayers < 2)
            game_values.playercontrol[@iSelectedPlayer] = 1;
          end
        end
      end
		  
      if(playerInput.outputControls[iPlayer].menu_select.fPressed || playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        @miModifyImage.show(false);
        @fModifying = false;
        return MENU_CODE_UNSELECT_ITEM;
      end
		  
		  
    end
    return MENU_CODE_NONE;
  end
  def update
    @miModifyImage.update();
  end
  
  def draw
    if(!@fShow)
      return;
    end
    game_values = $game_values
    @spr.draw(@ix, @iy, 0, (@fSelected ? 64 : 0), @iIndent - 16, 64);
    @spr.draw(@ix + @iIndent - 16, @iy, 0, (@fSelected ? 192 : 128), 32, 64);
    @spr.draw(@ix + @iIndent + 16, @iy, 528 - @iWidth + @iIndent, (@fSelected ? 64 : 0), @iWidth - @iIndent - 16, 64);
  
    $menu_font_large.drawChopRight(@ix + 16, @iy + 20, @iIndent - 8, @szName);
  
    @miModifyImage.draw();
  	
    4.times do |iPlayer|
      @spr.draw(@ix + @iPlayerPosition[iPlayer], @iy + 16, game_values.playercontrol[iPlayer] * 34 + 32, 206, 34, 32);
    end
  end
end

class SF_ListItem
  attr_accessor :sName, :iValue, :sValue, :fValue, :fHidden
  def initialize(*args)
    args = ["", 0, "", false, false] unless args.size > 0
    @sName = args[0];
			
    @iValue = args[1];
    @sValue = args[2];
    @fValue = args[3];
    @fHidden = args[4];
  end
end

class MI_SelectField < UI_Control
  def initialize(nspr, x, y, name, width, indent)
    super(x,y)
    @spr = nspr;
    @szName= name; #need duplicate?
    @iWidth = width;
    @iIndent = indent;
	
    @mcItemChangedCode = MENU_CODE_NONE;
    @mcControlSelectedCode = MENU_CODE_NONE;
	
    @fAutoAdvance = false;
    @fNoWrap = false;
    @fDisable = false;
	
    @iValue = nil;
    @sValue = nil;
    @fValue = nil;
	
    @iIndex = 0;
	
    @miModifyImageLeft = MI_Image.new(nspr, @ix + indent - 26, @iy + 4, 32, 64, 26, 24, 4, 1, 8);
    @miModifyImageLeft.show(false);
	
    @miModifyImageRight = MI_Image.new(nspr, @ix + @iWidth - 16, @iy + 4, 32, 88, 26, 24, 4, 1, 8);
    @miModifyImageRight.show(false);
	
    @iAdjustmentY = width > 256 ? 0 : 128;
    @items = []
  end
  
  def setNoWrap(nowrap)
    @fNoWrap = nowrap;
  end
  
  def add(name, ivalue, svalue, fvalue, fhidden)
    item = SF_ListItem.new(name, ivalue, svalue, fvalue, fhidden);
    @items << item;

    if(@items.size() >= 1)
      @current = 0;
      @iIndex = 0;
    end
  end
  def modify(modify)
    return MENU_CODE_UNSELECT_ITEM if @fDisable
    #todo : handling autoadvance code
    puts "mcItemChangedCode: #@mcItemChangedCode,mcControlSelectedCode: #@mcControlSelectedCode"
    if(@fAutoAdvance && modify)
      if(!@items.empty?())
      end
		  
      return @mcItemChangedCode
    end
		
    if(MENU_CODE_NONE != @mcControlSelectedCode)
      return @mcControlSelectedCode;
    end
	  
    @miModifyImageLeft.show(modify);
    @miModifyImageRight.show(modify);
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
  def draw
    if(!@fShow)
      return;
    end
  	
    @spr.draw(@ix, @iy, 0, (@fSelected ? 32 : 0) + @iAdjustmentY, @iIndent - 16, 32);
    @spr.draw(@ix + @iIndent - 16, @iy, 0, (@fSelected ? 96 : 64), 32, 32);
    @spr.draw(@ix + @iIndent + 16, @iy, 528 - @iWidth + @iIndent, (@fSelected ? 32 : 0) + @iAdjustmentY, @iWidth - @iIndent - 16, 32);
  
    $menu_font_large.drawChopRight(@ix + 16, @iy + 5, @iIndent - 8, @szName);
  
    if(!@items.empty?())
      $menu_font_large.drawChopRight(@ix + @iIndent + 8, @iy + 5, @iWidth - @iIndent - 24, @items[@current].sName);
    end
  
    if(@current != 0 || !@fNoWrap)
      @miModifyImageLeft.draw();
    end
  
    if(@current != @items.size - 1 || !@fNoWrap)
      @miModifyImageRight.draw();
    end
  end
  def sendInput(playerInput)
    
    4.times do |iPlayer|
      if(playerInput.outputControls[iPlayer].menu_right.fPressed || playerInput.outputControls[iPlayer].menu_down.fPressed)
        if(moveNext())
          return @mcItemChangedCode;
        end
      end
  		
      if(playerInput.outputControls[iPlayer].menu_left.fPressed || playerInput.outputControls[iPlayer].menu_up.fPressed)
        if(movePrev())
          return @mcItemChangedCode;
        end
      end
  
      if(playerInput.outputControls[iPlayer].menu_random.fPressed)
        if(moveRandom())
          return @mcItemChangedCode;
        end
      end
  
      if(playerInput.outputControls[iPlayer].menu_select.fPressed || playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        @miModifyImageLeft.show(false);
        @miModifyImageRight.show(false);
  
        @fModifying = false;
  
        setValues();
  
        return MENU_CODE_UNSELECT_ITEM;
      end
    end
    return MENU_CODE_NONE
  end
  def moveNext
    
    return false if @items.empty?
    findNext = @current
    while true
      
      if findNext == @items.size - 1 
        if(@fNoWrap)
          return false
        end
        findNext = 0
      else
        findNext += 1  
      end
      return false if findNext == @current
      if !@items[findNext].fHidden
        @current = findNext
        setValues();
        return true
      end
    end
    raise "we should never reach here"
    return false
  end
  
  def movePrev
    return false if @items.empty?
    findNext = @current
    while true
      
      if findNext == 0
        if(@fNoWrap)
          return false
        end
        findNext = @items.size - 1
      else
        findNext -= 1  
      end
      return false if findNext == @current
      if !@items[findNext].fHidden
        @current = findNext
        setValues();
        return true
      end
    end
    raise "we should never reach here"
    return false
  end
  
  def moveRandom()
    return false if @items.size <= 1
    items = @items.select {|x| !x.fHidden}
    return false if items.size <= 1
    findNext = @current
    while true
      index = rand(items.size)
      findNext = (@current + index) % @items.size
      if findNext!=@current && !@items[findNext].fHidden
        @current = findNext
        setValues();
        return true
      end
    end
    
    #but we need to set @current ?
    
    raise "we should never reach here"
    return false
  end
  
  def getShortValue() ;return @items[@current].iValue;end
  def getStringValue(); return @items[@current].sValue;end
  def getBoolValue(); return @items[@current].fValue;end
  
  #wrong version
  def setData(ivalue, svalue, fvalue) 
    @iValue = ivalue; @sValue = svalue; @fValue = fvalue;
  end
  #todo:setValues
  def setValues()
    if(@iValue)
      puts @iValue +  "= @items[@current].iValue"
      #puts @items[@current].iValue
      #require 'debug'
      
      eval(@iValue +  "= @items[@current].iValue");
    end
	
    if(@sValue)
      eval(@sValue +  "= @items[@current].sValue");
    end
	
    if(@fValue)
      eval(@fValue +  "= @items[@current].fValue");
    end
                
  end
  
  def setKey(iID)
    return false if @items.empty?
    result = @items.select {|x|
      x.iValue == iID
    }
    if result.size > 0
      @current = @items.index(result[0])
      return true
    else
      return false 
    end
		
  end
  def update
    @miModifyImageRight.update();
    @miModifyImageLeft.update();
  end
	
  def setItemChangedCode(code) 
    @mcItemChangedCode = code;
  end
  def setControlSelectedCode(code) 
    @mcControlSelectedCode = code;
  end
	
  def setAutoAdvance(advance) 
    @fAutoAdvance = advance;
  end

end

class MI_InputControlField < UI_Control
  def initialize(nspr, x, y, name, width, indent)
    super(x,y)
    
    @spr = nspr;
    @szName = name;
    @iWidth = width;
    @iIndent = indent;
    @fSelected = false;
	
    @iDevice = DEVICE_KEYBOARD;
    @iKey = nil;
    @iType = 0;
    @iKeyIndex = 0;
    @iPlayerIndex = 0;
		
  end
	
  def modify(modify)
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
	
  def draw
    if(!@fShow)
      return;
    end
	
    @spr.draw(@ix, @iy, 0, (@fSelected ? 32 : 0), @iIndent - 16, 32);
    @spr.draw(@ix + @iIndent - 16, @iy, 0, (@fSelected ? 96 : 64), 32, 32);
    @spr.draw(@ix + @iIndent + 16, @iy, 528 - @iWidth + @iIndent, (@fSelected ? 32 : 0), @iWidth - @iIndent - 16, 32);
	
    $menu_font_large.drawChopRight(@ix + 16, @iy + 5, @iIndent - 8, @szName);
	
    iKey = @keys[@iKeyIndex]
    if(iKey == nil)
      $menu_font_large.drawChopRight(@ix + @iIndent + 8, @iy + 5, @iWidth - @iIndent - 16, "Unassigned");
    elsif(@fModifying)
      $menu_font_large.drawChopRight(@ix + @iIndent + 8, @iy + 5, @iWidth - @iIndent - 16, "(Press Button)");
    elsif(@iDevice == DEVICE_KEYBOARD)
      $menu_font_large.drawChopRight(@ix + @iIndent + 8, @iy + 5, @iWidth - @iIndent - 16, Keynames[iKey]);
    else
      $menu_font_large.drawChopRight(@ix + @iIndent + 8, @iy + 5, @iWidth - @iIndent - 16, Joynames[iKey]);
    end
  end
  def setDevice(device) 
    @iDevice = device;
  end
  def setKey(key, device)
    game_values = $game_values
    fNeedSwap = false;
    
    iSwapPlayer = nil
    iSwapKey = nil
  	
    4.times do |iPlayer|
      next if(game_values.playerInput.inputControls[iPlayer].iDevice != device)
      NUM_KEYS.times do |iKey|
        next if(iKey == @iKeyIndex && iPlayer == @iPlayerIndex)
        if(game_values.playerInput.inputControls[iPlayer].inputGameControls[@iType].keys[iKey] == key)
				
          fNeedSwap = true;
          iSwapPlayer = iPlayer;
          iSwapKey = iKey;
          break;
        end
				
				
      end
      break if(fNeedSwap);
			
    end
  	
    if(fNeedSwap)
      game_values.playerInput.inputControls[iSwapPlayer].inputGameControls[@iType].keys[iSwapKey] = @keys[@iKeyIndex];
    end
  	
    @keys[@iKeyIndex] = key

  end
  def setKeys(keys)
    @keys = keys
  end
  def setType(type) 
    @iType = type;
  end
  def setKeyIndex(keyindex) 
    @iKeyIndex = keyindex;
  end
  def setPlayerIndex(playerindex) 
    @iPlayerIndex = playerindex;
  end
  
  def sendInput(playerInput)
    game_values = $game_values
    #SDL_Event event;
    done = false;
    while (!done)
      #SDL_WaitEvent(&event);
      event = EventQueue.wait
			
      game_values.playerInput.update(event, 1);
			
      if(@iDevice == DEVICE_KEYBOARD)
        if (event.class == KeyDownEvent)
          key = event.key;
          setKey(key, @iDevice);
          done = true;
        end
      end
    end
		
		
    game_values.playerInput.checkIfMouseUsed();

    #Need to clear down keys when coming into this (well ignore key up events in here)
    game_values.playerInput.resetKeys();
	
    @fModifying = false;
    return MENU_CODE_UNSELECT_ITEM;
  end
end

class MI_InputControlContainer < UI_Control
  def initialize(spr_button, x, y, playerID)
    super(x,y)
    game_values = $game_values
    @iPlayerID = playerID;
    @iDevice = game_values.playerInput.inputControls[@iPlayerID].iDevice;
    @iSelectedInputType = 0;
    
    szTitle = "Player #{@iPlayerID+1} Controls"
    @miText = MI_Text.new(szTitle, 320, 5, 0, 2, 1);
    
    @miImage = []
    @miImage[0] = MI_Image.new(spr_button, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miImage[1] = MI_Image.new(spr_button, 320, 0, 192, 0, 320, 32, 1, 1, 0);
	  
	  
		
    @miDeviceSelectField = MI_SelectField.new(spr_button, x + 16, y + 38, "Device", 420, 150);
    @miDeviceSelectField.setItemChangedCode(MENU_CODE_INPUT_DEVICE_CHANGED);
    @miDeviceSelectField.add("Keyboard", -1, "", false, false);
		
    # 		for(short iJoystick = 0; iJoystick < joystickcount; iJoystick++)
    # 		{
    # 			miDeviceSelectField->Add(SDL_JoystickName(iJoystick), iJoystick, "", false, false);
    # 		}
    #If the device is not found, default to the keyboard
    if(!@miDeviceSelectField.setKey(@iDevice))
      @iDevice = DEVICE_KEYBOARD;
      @miDeviceSelectField.setKey(@iDevice);
    end
		
    @miInputTypeButton = MI_Button.new(spr_button, x + 336, y + 84, "Game", 100, 1);
    @miInputTypeButton.setCode(MENU_CODE_INPUT_TYPE_CHANGED);
	  
    @miGameInputControlFields = []
    @miMenuInputControlFields = []
    NUM_KEYS.times do |iKey|
      @miGameInputControlFields[iKey] = MI_InputControlField.new(spr_button, x + 16, y + 118 + iKey * 34, GameInputNames[iKey], 420, 150);
      @miGameInputControlFields[iKey].setDevice(@iDevice);
      @miGameInputControlFields[iKey].setType(0);
      @miGameInputControlFields[iKey].setKeyIndex(iKey);
      @miGameInputControlFields[iKey].setPlayerIndex(@iPlayerID);
      @miGameInputControlFields[iKey].setKeys(game_values.playerInput.inputControls[@iPlayerID].inputGameControls[0].keys);
    end
	  
    NUM_KEYS.times do |iKey|
      @miMenuInputControlFields[iKey] = MI_InputControlField.new(spr_button, x + 16, y + 118 + iKey * 34, MenuInputNames[iKey], 420, 150);
      @miMenuInputControlFields[iKey].setDevice(@iDevice);
      @miMenuInputControlFields[iKey].setType(1);
      @miMenuInputControlFields[iKey].setKeyIndex(iKey);
      @miMenuInputControlFields[iKey].setPlayerIndex(@iPlayerID);
      @miMenuInputControlFields[iKey].setKeys(game_values.playerInput.inputControls[@iPlayerID].inputGameControls[1].keys);
    end
	  
    @miBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miBackButton.setCode(MENU_CODE_BACK_TO_CONTROLS_MENU);
	  
    @mInputMenu = UI_Menu.new;
    @mInputMenu.setCancelCode(MENU_CODE_CANCEL_INPUT);
    @mInputMenu.addNonControl(@miImage[0]);
    @mInputMenu.addNonControl(@miImage[1]);
    @mInputMenu.addNonControl(@miText);
	
    @mInputMenu.addControl(@miDeviceSelectField, @miBackButton, @miInputTypeButton, nil, @miBackButton);
    @mInputMenu.addControl(@miInputTypeButton, @miDeviceSelectField, @miGameInputControlFields[0], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[0], @miInputTypeButton, @miGameInputControlFields[1], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[1], @miGameInputControlFields[0], @miGameInputControlFields[2], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[2], @miGameInputControlFields[1], @miGameInputControlFields[3], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[3], @miGameInputControlFields[2], @miGameInputControlFields[4], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[4], @miGameInputControlFields[3], @miGameInputControlFields[5], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[5], @miGameInputControlFields[4], @miGameInputControlFields[6], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[6], @miGameInputControlFields[5], @miGameInputControlFields[7], nil, @miBackButton);
    @mInputMenu.addControl(@miGameInputControlFields[7], @miGameInputControlFields[6], @miMenuInputControlFields[0], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[0], @miGameInputControlFields[7], @miMenuInputControlFields[1], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[1], @miMenuInputControlFields[0], @miMenuInputControlFields[2], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[2], @miMenuInputControlFields[1], @miMenuInputControlFields[3], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[3], @miMenuInputControlFields[2], @miMenuInputControlFields[4], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[4], @miMenuInputControlFields[3], @miMenuInputControlFields[5], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[5], @miMenuInputControlFields[4], @miMenuInputControlFields[6], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[6], @miMenuInputControlFields[5], @miMenuInputControlFields[7], nil, @miBackButton);
    @mInputMenu.addControl(@miMenuInputControlFields[7], @miMenuInputControlFields[6], @miBackButton, nil, @miBackButton);
	
    @mInputMenu.addControl(@miBackButton, @miMenuInputControlFields[7], @miDeviceSelectField, @miDeviceSelectField, nil);
			
    @mInputMenu.setHeadControl(@miDeviceSelectField);
	
    setVisibleInputFields();
  end
  
  def update()

    @mInputMenu.update();
  end
			
  def draw()
    if(!@fShow)
      return;
    end
	
    @mInputMenu.draw();		
  end
	
  def sendInput(playerInput)
    ret = @mInputMenu.sendInput(playerInput);
    
    if(MENU_CODE_CANCEL_INPUT == ret)
      @fModifying = false;
      return MENU_CODE_UNSELECT_ITEM;
    elsif(MENU_CODE_INPUT_TYPE_CHANGED == ret)
      if(0 == @iSelectedInputType)
        @iSelectedInputType = 1;
        @miInputTypeButton.setName("Menu");
      else
        @iSelectedInputType = 0;
        @miInputTypeButton.setName("Game");
      end
	
      setVisibleInputFields();
	
      return MENU_CODE_NONE;
    elsif(MENU_CODE_INPUT_DEVICE_CHANGED == ret)
      ##TODO: Need to handle writing out input configurations, modifying input configs here
      ##Need to handle case where reading in and using a device that is no longer
      ##an option will crash the system (joystick unplugged or something)
	
      updateDeviceKeys(@miDeviceSelectField.getShortValue());
      playerInput.resetKeys();
	
      return MENU_CODE_NONE;
    end
		
    return ret;
  end
  
  def updateDeviceKeys
    #todo
    game_values = $game_values
    game_values.playerInput.inputControls[@iPlayerID] = game_values.inputConfiguration[@iPlayerID][iDevice == DEVICE_KEYBOARD ? 0 : 1];
    game_values.playerInput.inputControls[@iPlayerID].iDevice = iDevice;
	
    NUM_KEYS.times do |iKey|
      @miGameInputControlFields[iKey].setDevice(iDevice);
      @miGameInputControlFields[iKey].setKeys(game_values.playerInput.inputControls[@iPlayerID].inputGameControls[0].keys);
    end
	
    NUM_KEYS.times do |iKey|
		
      @miMenuInputControlFields[iKey].setDevice(iDevice);
      @miMenuInputControlFields[iKey].SetKeys(game_values.playerInput.inputControls[@iPlayerID].inputGameControls[1].keys);
    end
		
    setVisibleInputFields();
  end
  
  def setVisibleInputFields
    iDevice = @miDeviceSelectField.getShortValue();

    NUM_KEYS.times do |iKey|
      @miGameInputControlFields[iKey].show(0 == @iSelectedInputType && (iKey < 6 || DEVICE_KEYBOARD != iDevice || @iPlayerID == 0));
    end
	
    NUM_KEYS.times do |iKey|
      @miMenuInputControlFields[iKey].show(1 == @iSelectedInputType && (iKey < 6 || DEVICE_KEYBOARD != iDevice || @iPlayerID == 0));
    end
  end
	
  def setPlayer(playerID)
    #todo
  end
end
class MI_AnnouncerField < UI_Control
  def initialize(*args)
    super(0,0)
  end
end
class MI_PacksField < MI_AnnouncerField
  def initialize(*args)
    super(0,0)
  end
end

class MI_SliderField < MI_SelectField
  def initialize(nspr, nsprSlider, x, y, name, width, indent1, indent2)
    super(nspr, x, y, name, width, indent1)
    
    @iIndent2 = indent2;
    @sprSlider = nsprSlider;
	
    @miModifyImageLeft.setPosition(@ix + indent1 - 26, @iy + 4);
    @miModifyImageRight.setPosition(@ix + @iWidth - 16, @iy + 4);
  end
  
  
  
  def sendInput(playerInput)
	
    4.times do|iPlayer|
      if(playerInput.outputControls[iPlayer].menu_scrollfast.fPressed)
        if(@current == 0)
          while(moveNext());end
        else
          while(movePrev());end
        end
	
        return @mcItemChangedCode;
      end
    end
	
    return super(playerInput);
  end

  
  def draw()
    if(!@fShow)
      return;
    end
	
    @spr.draw(@ix, @iy, 0, (@fSelected ? 32 : 0) + @iAdjustmentY, @iIndent - 16, 32);
    @spr.draw(@ix + @iIndent - 16, @iy, 0, (@fSelected ? 96 : 64), 32, 32);
    @spr.draw(@ix + @iIndent + 16, @iy, 528 - @iWidth + @iIndent, (@fSelected ? 32 : 0) + @iAdjustmentY, @iWidth - @iIndent - 16, 32);
	
    $menu_font_large.drawChopRight(@ix + 16, @iy + 5, @iIndent - 8, @szName);
	
    if(!@items.empty?())

      $menu_font_large.drawChopRight(@ix + @iIndent2 + 16, @iy + 5, @iWidth - @iIndent2 - 24, @items[@current].sName);
    end
	
    iSpacing = (@iIndent2 - @iIndent - 20) / (@items.size() - 1);
    iSpot = 0;
	
    @items.size().times do|index|
      if(index < @items.size() - 1)
        @sprSlider.draw(@ix + @iIndent + iSpot + 16, @iy + 10, 0, 0, iSpacing, 13);
      else
        @sprSlider.draw(@ix + @iIndent + iSpot + 16, @iy + 10, 164, 0, 4, 13);
      end
	
      iSpot += iSpacing;
    end
	
    @sprSlider.draw(@ix + @iIndent + (@current * iSpacing) + 14, @iy + 8, 168, 0, 8, 16);
	
    if(@current != 0 || !@fNoWrap)
      @miModifyImageLeft.draw();
    end
	
    if(@current != @items.size - 1 || !@fNoWrap)
      @miModifyImageRight.draw();
    end
  end
  
end
class MI_PlaylistField < UI_Control
  def initialize(*args)
    super(0,0)
  end
end

class MI_ImageSelectField < MI_SelectField
  def initialize(nspr, nspr_image, x, y, name, width, indent, imageHeight, imageWidth)
    super(nspr, x, y, name, width, indent)
    @spr_image = nspr_image;

    @iImageWidth = imageWidth;
    @iImageHeight = imageHeight;
  end
  def draw
    if(!@fShow)
      return;
    end
  	
    @spr.draw(@ix, @iy, 0, (@fSelected ? 32 : 0), @iIndent - 16, 32);
    @spr.draw(@ix + @iIndent - 16, @iy, 0, (@fSelected ? 96 : 64), 32, 32);
    @spr.draw(@ix + @iIndent + 16, @iy, 528 - @iWidth + @iIndent, (@fSelected ? 32 : 0), @iWidth - @iIndent - 16, 32);
  
    $menu_font_large.drawChopRight(@ix + 16, @iy + 5, @iIndent - 8, @szName);
  
    if(!@items.empty?())
      $menu_font_large.drawChopRight(@ix + @iIndent + @iImageWidth + 10, @iy + 5, @iWidth - @iIndent - 24, @items[@current].sName);
    end
  
    @spr_image.draw(@ix + @iIndent + 8, @iy + 16 - (@iImageHeight >> 1), @items[@current].iValue * @iImageWidth, 0, @iImageWidth, @iImageHeight);
  
    @miModifyImageRight.draw();
    @miModifyImageLeft.draw();
  end
  
end
class MI_MapField < UI_Control
  def initialize(nspr, x, y, name, width, indent, showtags)
    super(x,y)
    
    @fDisable = false;

    @spr = nspr;
    @szName = name;
    @iWidth = width;
    @iIndent = indent;
  
    @miModifyImageLeft = MI_Image.new(nspr, @ix + indent - 26, @iy + 4, 32, 64, 26, 24, 4, 1, 8);
    @miModifyImageLeft.show(false);
  
    @miModifyImageRight = MI_Image.new(nspr, @ix + @iWidth - 16, @iy + 4, 32, 88, 26, 24, 4, 1, 8);
    @miModifyImageRight.show(false);
  
    @surfaceMapBackground = Surface.new([320,240])
    @surfaceMapForeground = Surface.new([320,240])
    loadCurrentMap();
  	
    @rectDst = []
    @rectDst.x = x + 16;
    @rectDst.y = y + 44;
    @rectDst.w = 320;
    @rectDst.h = 240;
  
    if(showtags)
      @iSlideListOut = (@iWidth - 352) >> 1;
      @iSlideListOutGoal = @iSlideListOut;
    else
      @iSlideListOut = 0;
      @iSlideListOutGoal = @iSlideListOut;
    end
  end
  def modify(modify)
    if(@fDisable)
      return MENU_CODE_UNSELECT_ITEM;
    end
		
    @miModifyImageLeft.show(modify);
    @miModifyImageRight.show(modify);
  
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
  def update
    #if(@iSlideListOut != @iSlideListOutGoal)
    #puts "we are updating..."
    @miModifyImageRight.update();
    @miModifyImageLeft.update();
    $g_map.updatePlatforms();
  end
  def draw
    if(!@fShow)
      return;
    end
    game_values = $game_values
	  
    #Draw the select field background
    @spr.draw(@ix, @iy, 0, (@fSelected ? 32 : 0), @iIndent - 16, 32);
    @spr.draw(@ix + @iIndent - 16, @iy, 0, (@fSelected ? 96 : 64), 32, 32);
    @spr.draw(@ix + @iIndent + 16, @iy, 528 - @iWidth + @iIndent, (@fSelected ? 32 : 0), @iWidth - @iIndent - 16, 32);
  	
  	
    iMapBoxX = @ix + (@iWidth >> 1) - 176 - @iSlideListOut;
  	
    #Draw the background for the map preview
    $menu_dialog.draw(iMapBoxX, @iy + 30, 0, 0, 336, 254);
    $menu_dialog.draw(iMapBoxX + 336, @iy + 30, 496, 0, 16, 254);
    $menu_dialog.draw(iMapBoxX, @iy + 284, 0, 464, 336, 16);
    $menu_dialog.draw(iMapBoxX + 336, @iy + 284, 496, 464, 16, 16);
  
    @rectDst.x = iMapBoxX + 16;
  
    $menu_font_large.drawChopRight(@ix + 16, @iy + 5, @iIndent - 8, @szName);
    $menu_font_large.drawChopRight(@ix + @iIndent + 8, @iy + 5, @iWidth - @iIndent - 24, $maplist.currentShortmapname());
  
    $blitdest.blit(@surfaceMapBackground,@rectDst)
    
    $g_map.drawPlatforms(@rectDst.x, @rectDst.y);
  	
    #if(game_values.toplayer)
    #  $blitdest.blit(@surfaceMapForeground,@rectDst)
    #end
  	
    @miModifyImageLeft.draw();
    @miModifyImageRight.draw();
  	
  end
  def disable(disable)
    @fDisable = disable
  end
  def sendInput(playerInput)
    if(playerInput.iPressedKey > 0)
      if((playerInput.iPressedKey >= K_a && playerInput.iPressedKey <= K_z) ||
            (playerInput.iPressedKey >= K_0 && playerInput.iPressedKey <= K_9))
        iOldIndex = $maplist.current;
        $maplist.startswith(playerInput.iPressedKey);
        if(iOldIndex != $maplist.current)
          loadCurrentMap();
          return MENU_CODE_MAP_CHANGED;
        end
      
        return MENU_CODE_NONE;
      end
    end
    
    4.times do |iPlayer|
      if(playerInput.outputControls[iPlayer].menu_right.fPressed || playerInput.outputControls[iPlayer].menu_down.fPressed)
        numadvance = 1;
        if(playerInput.outputControls[iPlayer].menu_scrollfast.fDown)
          numadvance = 10;
        end
        if $maplist.fastNext(true, numadvance)
          loadCurrentMap()
          return MENU_CODE_MAP_CHANGED 
        end
        return MENU_CODE_NONE;
			  
      end
      if(playerInput.outputControls[iPlayer].menu_left.fPressed || playerInput.outputControls[iPlayer].menu_up.fPressed)
        numadvance = 1;
        if(playerInput.outputControls[iPlayer].menu_scrollfast.fDown)
          numadvance = 10;
        end
			  
        if $maplist.fastPrev(true, numadvance)
          loadCurrentMap()
          return MENU_CODE_MAP_CHANGED 
        end
        return MENU_CODE_NONE;
      end
      if(playerInput.outputControls[iPlayer].menu_random.fPressed)
        return MENU_CODE_MAP_CHANGED if maplist.random(true);
        return MENU_CODE_NONE;
      end
      if(playerInput.outputControls[iPlayer].menu_select.fPressed || playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        @miModifyImageLeft.show(false);
        @miModifyImageRight.show(false);
  			
        @fModifying = false;
        return MENU_CODE_UNSELECT_ITEM;
      end
    end
    return MENU_CODE_NONE;
  end
  def adjustIndicators
  end
  
  def loadCurrentMap
    @szMapName = $maplist.currentShortmapname();
    puts @szMapName
    
    $g_map.loadMap($maplist.currentFilename(), read_type_preview);
	  
    #Timer.delay(10);  #Sleeps to help the music from skipping
	  
    filename = "gfx/packs/backgrounds/#{$g_map.szBackgroundFile}"
    path = convertPath(filename, "Classic");
    puts "path:#{path}"
    if(!File.exist?(path))
      path = convertPath("gfx/packs/backgrounds/Land_Classic.png", "Classic");
    end
		
    __load_gfx($spr_background, path);
    #Timer.delay(10);  #Sleeps to help the music from skipping
		
		
    @surfaceMapBackground = $g_map.preDrawPreviewBackground($spr_background, false);
    #Timer.delay(10);  //Sleeps to help the music from skipping
    $g_map.preDrawPreviewForeground(@surfaceMapForeground, false);
    #$g_map.preDrawPreviewWarps(@surfaceMapForeground, false);
  end
  
  def setMap(szMapName)
    $maplist.findexact(@szMapName);
    loadCurrentMap();
  end
  def getMapName
    @szMapName
  end
end

class MFS_ListItem 
  attr_accessor :sName, :iIcon, :fSelected
  def initialize(sname = "", icon = -1, fselected = false)
    @sName = sname;
    @iIcon = icon;
    @fSelected = fselected;
  end
  
end

class MI_MapFilterScroll < UI_Control
  def initialize(nspr, x, y, width, numlines)
    super(x,y)
    @spr = nspr;
    @iWidth = width;
    @iNumLines = numlines;
	
    @iSelectedColumn = 0;
    @iSelectedLine = 0;
    @iIndex = 0;
    @iOffset = 0;
	
    @iTopStop = (@iNumLines - 1) >> 1;
    @iBottomStop = 0;
		
    @items = []
  end
  def add(name, icon)
    puts "adding #{name},#{icon} to MI_MapFilterScroll"
    item = MFS_ListItem.new(name, icon, false);
    @items << (item);
	
    if(@items.size() >= 1)
      @current = 0;
      @iIndex = 0;
    end
	
    @iBottomStop = @items.size() - @iNumLines + @iTopStop;
  end
  def modify(modify)
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
  
  def sendInput(playerInput)
    game_values = $game_values
    4.times do|iPlayer|
      if(playerInput.outputControls[iPlayer].menu_down.fPressed)
        moveNext();
        return MENU_CODE_NONE;
      end
			
      if(playerInput.outputControls[iPlayer].menu_up.fPressed)
        movePrev();
        return MENU_CODE_NONE;
      end
	
      if(playerInput.outputControls[iPlayer].menu_left.fPressed)
        @iSelectedColumn = 0;
        return MENU_CODE_NONE;
      end
	
      if(playerInput.outputControls[iPlayer].menu_right.fPressed)
        if(@iIndex >= NUM_AUTO_FILTERS)
          @iSelectedColumn = 1;
        end
	
        return MENU_CODE_NONE;
      end
	
      if(playerInput.outputControls[iPlayer].menu_select.fPressed)
        #If the left column is selected, then turn that filter on/off
        if(@iSelectedColumn == 0)
          @items[@iIndex].fSelected = !@items[@iIndex].fSelected;
          game_values.pfFilters[@iIndex] = !game_values.pfFilters[@iIndex];
        else #otherwise if the right is selected, go into the details of that filter
          game_values.selectedmapfilter = @iIndex;
          return MENU_CODE_TO_MAP_FILTER_EDIT;
        end
	
        return MENU_CODE_NONE;
      end
	
	
      if(playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        return MENU_CODE_MAP_FILTER_EXIT;
      end
    end
	
    return MENU_CODE_NONE;
  end
	 
  def update
  end
	 
  def draw
    if(!@fShow)
      return;
    end
		
    #Draw the background for the map preview
    $menu_dialog.draw(@ix, @iy, 0, 0, @iWidth - 16, @iNumLines * 32 + 32);
    $menu_dialog.draw(@ix + @iWidth - 16, @iy, 496, 0, 16, @iNumLines * 32 + 32);
    $menu_dialog.draw(@ix, @iy + @iNumLines * 32 + 32, 0, 464, @iWidth - 16, 16);
    $menu_dialog.draw(@ix + @iWidth - 16, @iy + @iNumLines * 32 + 32, 496, 464, 16, 16);
		
    $menu_font_large.drawCentered(@ix + (@iWidth >> 1), @iy + 5, "Map Filters");
		
    #Draw each filter field
    [@iNumLines,@items.size()].min.times do |iLine|
      if(@iOffset + iLine >= NUM_AUTO_FILTERS)
        iHalfLineWidth = (@iWidth - 64) >> 1;
        iLineWidth = @iWidth - 64;
	
        @spr.draw(@ix + 16, @iy + 32 + iLine * 32, 0, (@iSelectedLine == iLine  && @iSelectedColumn == 0 ? 32 : 0), iHalfLineWidth, 32);
        @spr.draw(@ix + 16 + iHalfLineWidth, @iy + 32 + iLine * 32, 512 - iLineWidth + iHalfLineWidth, (@iSelectedLine == iLine && @iSelectedColumn == 0 ? 32 : 0), iLineWidth - iHalfLineWidth, 32);
	
        $menu_map_filter.draw(@ix + @iWidth - 48, @iy + 32 + iLine * 32, 48, (@iSelectedLine == iLine && @iSelectedColumn == 1 ? 32 : 0), 32, 32);
      else
        iHalfLineWidth = (@iWidth - 32) >> 1;
        iLineWidth = @iWidth - 32;
        @spr.draw(@ix + 16, @iy + 32 + iLine * 32, 0, (@iSelectedLine == iLine && @iSelectedColumn == 0 ? 32 : 0), iHalfLineWidth, 32);
        @spr.draw(@ix + 16 + iHalfLineWidth, @iy + 32 + iLine * 32, 512 - iLineWidth + iHalfLineWidth, (@iSelectedLine == iLine && @iSelectedColumn == 0 ? 32 : 0), iLineWidth - iHalfLineWidth, 32);
      end
		  
      if(@items[@iOffset + iLine].fSelected)
        $menu_map_filter.draw(@ix + 24, @iy + 32 + iLine * 32 + 4, 24, 0, 24, 24);
      end

      $menu_font_large.drawChopRight(@ix + 52, @iy + 5 + iLine * 32 + 32, @iWidth - 104, @items[@iOffset + iLine].sName);
      $spr_map_filter_icons.draw(@ix + 28, @iy + 32 + iLine * 32 + 8, @items[@iOffset + iLine].iIcon % 10 * 16, @items[@iOffset + iLine].iIcon / 10 * 16, 16, 16);
    end
  end
  
  def moveNext
    if(@items.empty?())
      return false;
    end
	
    if(@iIndex == @items.size() - 1)
      return false;
    end
	
    @iIndex+=1;
    @current+=1;
	
    if(@iIndex > @iTopStop && @iIndex <= @iBottomStop)
      @iOffset+=1;
    else
      @iSelectedLine+=1;
    end
	
    return true;
  end
  
  def movePrev
    if(@items.empty?())
      return false;
    end
	
    if(@iIndex == 0)
      return false;
    end
	
    @iIndex-=1;
    @current-=1;
	
    if(@iIndex >= @iTopStop && @iIndex < @iBottomStop)
      @iOffset-=1;
    else
      @iSelectedLine-=1;
    end
	
    if(@iIndex < NUM_AUTO_FILTERS)
      @iSelectedColumn = 0;
    end
	
    return true;
  end

end

class MI_MapBrowser < UI_Control
  def initialize()
    super(0,0)
    @mapSurfaces = []
    @mapListNodes = []
    @mapNames = []
    @mapListItr = []
    9.times do |iSurface|
      @mapSurfaces[iSurface] = nil;
    end
    @srcRectBackground = []
    @dstRectBackground = []
    
    @srcRectBackground.x = 0;
    @srcRectBackground.y = 0;
    @srcRectBackground.w = 640;
    @srcRectBackground.h = 480;
	
    @dstRectBackground.x = 0;
    @dstRectBackground.y = 0;
    @dstRectBackground.w = 160;
    @dstRectBackground.h = 120;
	
    @iFilterTagAnimationTimer = 0;
    @iFilterTagAnimationFrame = 0;
  end
  
  def update
    @iFilterTagAnimationTimer += 1
    if(@iFilterTagAnimationTimer > 8)
      @iFilterTagAnimationTimer = 0;
			
      @iFilterTagAnimationFrame += 24;
      if(@iFilterTagAnimationFrame > 24)
        @iFilterTagAnimationFrame = 0;
      end
    end
  end
  
  def draw
    if(!@fShow)
      return;
    end
    game_values = $game_values
    rSrc = [0, 0, 160, 120];
    rDst = [0, 0, 160, 120];
		
    3.times do |iRow|
      rDst.y = iRow * 150 + 30;
			
      3.times do |iCol|
        if(@iSelectedCol != iCol || @iSelectedRow != iRow)
          if(iRow * 3 + iCol + @iPage * 9 >= @iMapCount)
            break;
          end
					
          rDst.x = iCol * 200 + 40;
					
          $blitdest.blit(@mapSurfaces[iRow * 3 + iCol],rDst,rSrc)
					
          if(@iType == 0)
            if(@mapListNodes[iRow * 3 + iCol].pfFilters[game_values.selectedmapfilter])
              $menu_map_filter.draw(rDst.x, rDst.y, @iFilterTagAnimationFrame, 24, 24, 24);
            end
          end
				  
          $menu_font_large.drawChopRight(rDst.x, rDst.y + 120, 165, @mapNames[iRow * 3 + iCol]);
        end
      end
    end
		
    #Draw the selected map
		
    rDst.y = @iSelectedRow * 150 + 30;
    rDst.x = @iSelectedCol * 200 + 40;
	
    $menu_dialog.draw(rDst.x - 16, rDst.y - 16, 0, 0, 176, 148);
    $menu_dialog.draw(rDst.x + 160, rDst.y - 16, 496, 0, 16, 148);
    $menu_dialog.draw(rDst.x - 16, rDst.y + 132, 0, 464, 176, 16);
    $menu_dialog.draw(rDst.x + 160, rDst.y + 132, 496, 464, 16, 16);
	
    $blitdest.blit(@mapSurfaces[@iSelectedRow * 3 + @iSelectedCol],rDst,rSrc);
	
    if(@iType == 0)
      if(@mapListNodes[iSelectedRow * 3 + iSelectedCol].pfFilters[game_values.selectedmapfilter])
        $menu_map_filter.draw(rDst.x, rDst.y, iFilterTagAnimationFrame, 24, 24, 24);
      end
    end
	
    $menu_font_large.drawChopRight(rDst.x, rDst.y + 120, 165, @mapNames[@iSelectedRow * 3 + @iSelectedCol]);
  end
  
  def modify(modify)
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
	
  def sendInput(playerInput)
    game_values = $game_values
    4.times do |iPlayer|
      if(playerInput.outputControls[iPlayer].menu_down.fPressed)
        iSkipRows = 1;
        if(playerInput.outputControls[iPlayer].menu_scrollfast.fDown)
          iSkipRows = 3;
        end
	
        @iSelectedIndex = (@iSelectedRow + iSkipRows) * 3 + @iSelectedCol + @iPage * 9;
				
        if(@iSelectedIndex >= @iMapCount)
          @iSelectedIndex = @iMapCount - 1;
        end
				
        @iSelectedRow = (@iSelectedIndex / 3) % 3;
        @iSelectedCol = @iSelectedIndex % 3;
	
        iOldPage = @iPage;
        @iPage = @iSelectedIndex / 9;
	
        if(iOldPage != @iPage)
          loadPage(@iPage, @iType == 1);
        end
	
        return MENU_CODE_NONE;
      end
      if(playerInput.outputControls[iPlayer].menu_up.fPressed)
        iSkipRows = 1;
        if(playerInput.outputControls[iPlayer].menu_scrollfast.fDown)
          iSkipRows = 3;
        end
	
        @iSelectedIndex = (@iSelectedRow - iSkipRows) * 3 + @iSelectedCol + @iPage * 9;
				
        if(@iSelectedIndex < 0)
          @iSelectedIndex = 0;
        end
	
        @iSelectedRow = (@iSelectedIndex / 3) % 3;
        @iSelectedCol = @iSelectedIndex % 3;
	
        iOldPage = @iPage;
        @iPage = @iSelectedIndex / 9;
	
        if(iOldPage != @iPage)
          loadPage(@iPage, @iType == 1);
        end
	
        return MENU_CODE_NONE;
      end
      
      if(playerInput.outputControls[iPlayer].menu_left.fPressed)
        iNextIndex = @iSelectedRow * 3 + @iSelectedCol - 1 + @iPage * 9;
			
        if(iNextIndex < 0)
          return MENU_CODE_NONE;
        end
	
        @iSelectedIndex = iNextIndex;
				
        @iSelectedCol -= 1
        if(@iSelectedCol < 0)
          @iSelectedCol = 2;
					
          @iSelectedRow -= 1
          if(@iSelectedRow < 0)
            @iSelectedRow = 2;
            loadPage((@iPage-=1), @iType == 1);
          end
        end
	
        return MENU_CODE_NONE;
      end
      if(playerInput.outputControls[iPlayer].menu_right.fPressed)
        iNextIndex = @iSelectedRow * 3 + @iSelectedCol + 1 + @iPage * 9;
			
        if(iNextIndex >= @iMapCount)
          return MENU_CODE_NONE;
        end
	
        @iSelectedIndex = iNextIndex;
				
        @iSelectedCol += 1
        if(@iSelectedCol > 2)
          @iSelectedCol = 0;
					
          @iSelectedRow+=1;
          if(@iSelectedRow > 2)
            @iSelectedRow = 0;
            loadPage((@iPage+=1), @iType == 1);
          end
        end
	
        return MENU_CODE_NONE;
      end
      
      if(playerInput.outputControls[iPlayer].menu_select.fPressed)
        if(@iType == 0)
          @mapListNodes[@iSelectedRow * 3 + @iSelectedCol].pfFilters[game_values.selectedmapfilter] = !@mapListNodes[@iSelectedRow * 3 + @iSelectedCol].pfFilters[game_values.selectedmapfilter];
          game_values.fNeedWriteFilters = true;
        else
          $maplist.setCurrent(@mapListItr[@iSelectedRow * 3 + @iSelectedCol]);
          return MENU_CODE_MAP_BROWSER_EXIT;
        end
	
        return MENU_CODE_NONE;
      end
      
      if(playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        return MENU_CODE_MAP_BROWSER_EXIT;
      end
    end
  end
  
  def reset(type)
    @iType = type;

    if(@iType == 0)
      @iSelectedIndex = $maplist.getCurrent().iIndex;
	
      @iFilterTagAnimationTimer = 0;
      @iFilterTagAnimationFrame = 72;
	
      @iMapCount = $maplist.GetCount();
    else
      @iSelectedIndex = $maplist.getCurrent().iFilteredIndex;
      @iMapCount = $maplist.getFilteredCount();
    end
	
    @iSelectedRow = (@iSelectedIndex / 3) % 3;
    @iSelectedCol = @iSelectedIndex % 3;
    @iPage = @iSelectedIndex / 9;
	
    loadPage(@iPage, @iType == 1);
  end
  
  def loadPage(page, fUseFilters)
    puts "loading page :#{page},#{fUseFilters}"
    9.times do |iMap|
      iIndex = iMap + page * 9;
    	
      if(iIndex >= @iMapCount)
        return;
      end
			
      node = $maplist.get(iIndex, fUseFilters);
			
      #See if we already have a thumbnail saved for this map
			
      szThumbnail = "maps/cache/#{node.filename}"
			
      szThumbnail.sub!(".map", ".png")
      #require 'debug'
			
      sConvertedPath = convertPath(szThumbnail);
			
      if(!File.exists?(sConvertedPath))
        $g_map.loadMap(node.fullname, read_type_preview);
        #SDL_Delay(10);  #Sleeps to help the music from skipping
        #$g_map.saveThumbnail(sConvertedPath, false);
        #SDL_Delay(10);
      end
			
      @mapSurfaces[iMap] = Surface.load_new(sConvertedPath);
			
      @mapListNodes[iMap] = node;
      @mapNames[iMap] = node.shortName;
      @mapListItr[iMap] = iIndex;
			
			
    end
  end
  
end

class MI_TourStop < UI_Control
  def initialize(*args)
    super(0,0)
  end
end

class MI_PowerupSlider < MI_SelectField
  def initialize(*args)
    super(0,0,0,0,0,0)
  end
  
  def add(*)
  end
  
  def setNoWrap(nowrap)
  end
  
end

class MI_TeamSelect < UI_Control
  attr_accessor :iTeamCounts,:iTeamIDs
  
  def initialize(spr_background,x,y)
    super(x,y)
    @spr = spr_background
    @miImage = MI_Image.new(spr_background, @ix, @iy, 0, 0, 416, 256, 1, 1, 0);
    game_values = $game_values
    @iTeamCounts = []
    @iTeamIDs = [[],[],[],[]]
    @fReady = []
    4.times do |iTeam|
      puts "game_values.teamcounts[] = #{game_values.teamcounts.inspect}"
      @iTeamCounts[iTeam] = game_values.teamcounts[iTeam];  

      puts "game_values.teamids = #{game_values.teamids.inspect}"
      3.times do |iSlot|
        #puts "iTeam is#{iTeam}"
        #puts @iTeamIDs[iTeam][iSlot]
        #puts game_values.teamids[iTeam]
        @iTeamIDs[iTeam][iSlot] = game_values.teamids[iTeam][iSlot];
        @iTeamIDs[iTeam][iSlot] = -2 if !@iTeamIDs[iTeam][iSlot]
        puts "after initialize, @iTeamIDs is #{@iTeamIDs.inspect}"
      end
      @fReady[iTeam] = false;
      
      @iAnimationTimer = 0;
      @iAnimationFrame = 0;
      @iRandomAnimationFrame = 0;
      
    end
  end
  def update
    @iAnimationTimer += 1
    if(@iAnimationTimer > 7)
      @iAnimationTimer = 0;
  
      @iAnimationFrame += 2;
      if(@iAnimationFrame > 2)
        @iAnimationFrame = 0;
      end
  
      @iRandomAnimationFrame += 32;
      if(@iRandomAnimationFrame >= 128)
        @iRandomAnimationFrame = 0;
      end
    end
  end
  def draw
    if(!@fShow)
      return;
    end
    game_values = $game_values
    #puts "in draw : #{game_values.teamids.inspect}"
	  
    iPlayerCount = 0;
    4.times do |iPlayer|
      if(game_values.playercontrol[iPlayer] > 0)
        iPlayerCount+=1
      end
    end
    #puts "in draw : iPlayerCount:#{iPlayerCount}"
    #puts "in draw : @iTeamCounts: #{@iTeamCounts.inspect}"
  	
    @miImage.draw();
    4.times do |iTeam|
      @iTeamCounts[iTeam].times do |iTeamItem|
        iPlayerID = @iTeamIDs[iTeam][iTeamItem]
        
        if game_values.randomskin[iPlayerID]
          @spr.draw(iTeam * 96 + 43 + @ix, iTeamItem * 36 + 52 + @iy, 416, @fReady[iPlayerID] ? 0 : @iRandomAnimationFrame, 42, 32);
        else
          #require 'debug'
          #loadMenuSkin(iPlayerID, $game_values.skinids[iPlayerID], 0)
          $spr_player[iPlayerID][@fReady[iPlayerID] ? 0 : @iAnimationFrame].draw(iTeam * 96 + 48 + @ix, iTeamItem * 36 + 52 + @iy, 0, 0, 32, 32);
          #$spr_player[iPlayerID][@fReady[iPlayerID] ? 0 : @iAnimationFrame].draw(iTeam * 96 + 48 + @ix, iTeamItem * 36 + 52 + @iy);
        end if iPlayerID
        if iPlayerID
          $spr_menu_boxed_numbers.draw(iTeam * 96 + 44 + @ix, iTeamItem * 36 + 72 + @iy, iPlayerID * 16, game_values.colorids[iPlayerID] * 16, 16, 16)
        end
           
  	#require 'debug'    
        if game_values.playercontrol[iTeam] > 0
          $spr_player_select_ready.draw(iTeam * 160 + 16, 368, 0, 0, 128, 96);
			
          $spr_menu_boxed_numbers.draw(iTeam * 160 + 32, 388, iTeam * 16, game_values.colorids[iTeam] * 16, 16, 16);
          $menu_font_small.drawChopRight(iTeam * 160 + 52, 404 - $menu_font_small.getHeight(), 80, 
            game_values.randomskin[iTeam] ? "Random" : $skinlist.getSkinName(game_values.skinids[iTeam]));
    
          
          $spr_player_select_ready.draw(iTeam * 160 + 64, 408, 128, (!@fReady[iTeam] ? 0 : (game_values.playercontrol[iTeam] == 1 ? 32 : 64)), 34, 32);
        end
      end
    end
    if(@fAllReady)
      $menu_plain_field.draw(@ix + 108, @iy + 224, 0, 160, 100, 32);
      $menu_plain_field.draw(@ix + 208, @iy + 224, 412, 160, 100, 32);
      $menu_font_large.drawCentered(320, @iy + 229, "Continue");
    end
  end
  def sendInput(playerInput)
    game_values = $game_values
    4.times do |iPlayer|
      playerKeys = game_values.playerInput.outputControls[iPlayer];
      if(game_values.playercontrol[iPlayer] > 0 && !@fReady[iPlayer]) #if this player is player or cpu
        if playerKeys.menu_left.fPressed
          if(playerKeys.menu_right.fDown)
            game_values.randomskin[iPlayer] = !game_values.randomskin[iPlayer];
          else
            findNewTeam(iPlayer, -1);
          end
        end
        if playerKeys.menu_right.fPressed
          if(playerKeys.menu_left.fDown)
            game_values.randomskin[iPlayer] = !game_values.randomskin[iPlayer];
          else
            findNewTeam(iPlayer, 1);
          end
        end
        
        if(playerKeys.menu_up.fPressed && !game_values.randomskin[iPlayer])
          if playerKeys.menu_down.fDown
            game_values.skinids[iPlayer] = rand($skinlist.getCount());
          else
            game_values.skinids[iPlayer] -= 1
            if(game_values.skinids[iPlayer] < 0)
              game_values.skinids[iPlayer] = $skinlist.getCount() - 1;
            end
          end
          loadMenuSkin(iPlayer, game_values.skinids[iPlayer], game_values.colorids[iPlayer])
        end
        
        if(playerKeys.menu_down.fPressed && !game_values.randomskin[iPlayer])
          if(playerKeys.menu_up.fDown)
            game_values.skinids[iPlayer] = rand($skinlist.getCount());
          else
            game_values.skinids[iPlayer] += 1
            if(game_values.skinids[iPlayer] >= $skinlist.getCount())
              game_values.skinids[iPlayer] = 0;
            end
          end
          #require 'debug'
          loadMenuSkin(iPlayer, game_values.skinids[iPlayer], game_values.colorids[iPlayer])
        end
        
        if(playerKeys.menu_random.fPressed)
          if(playerKeys.menu_scrollfast.fDown)
            game_values.randomskin[iPlayer] = !game_values.randomskin[iPlayer];
          elsif (!game_values.randomskin[iPlayer])
            #game_values.skinids[iPlayer] = rand() #% skinlist.GetCount();
          end
        end
      end
      if(playerInput.outputControls[iPlayer].menu_select.fPressed)
        @fReady[iPlayer] = true;
        if(@fAllReady && (DEVICE_KEYBOARD != playerInput.inputControls[iPlayer].iDevice || iPlayer == 0))
          @fModifying = false
          return MENU_CODE_TO_GAME_SETUP_MENU;
        end
        @fAllReady = (@fReady.select {|x| x == true}.size >0 )
        puts "MI_TeamSelect.sendInput: @fAllReady:#@fAllReady,@fReady[iPlayer]:#{@fReady[iPlayer]}, iPlayer:{iPlayer}"
      end
      if(playerInput.outputControls[iPlayer].menu_cancel.fPressed)
        if (game_values.playercontrol[iPlayer] > 0 && @fReady[iPlayer])
          @fReady[iPlayer] = false;
          @fAllReady = false;
        else
          if(DEVICE_KEYBOARD != playerInput.inputControls[iPlayer].iDevice || iPlayer == 0)
            @fModifying = false;
            return MENU_CODE_UNSELECT_ITEM;
          end
        end
        
      end
    end
    return MENU_CODE_NONE
  end
  def modify(modify)
    @fModifying = modify;
    return MENU_CODE_MODIFY_ACCEPTED;
  end
  
  def reset
    @iTeamIDs = [[0],[1],[],[]]
    @iTeamCounts = [1,1,0,0]
    
    4.times do |iPlayerID|
      loadMenuSkin(iPlayerID, $game_values.skinids[iPlayerID], $game_values.colorids[iPlayerID])
      @fReady[iPlayerID] = $game_values.playercontrol[iPlayerID] != 1
    end
    
  end
  
  #  def reset()
  #    game_values = $game_values
  #    puts "into reset return: #{@iTeamCounts.inspect} #{game_values.teamcounts.inspect}" 
  #    
  #    4.times do |iPlayer|
  #      iTeamID = 0;
  #      iSlotID = 0;
  #      puts "inspect @iTeamIDs, #{@iTeamIDs.inspect}"
  #      teamee = @iTeamIDs.select {|x| x.include?(iPlayer)}
  #      fFound = (teamee.size>0);
  #		
  #      puts "fFound is #{fFound} for player #{iPlayer}"
  # 	   
  #	  
  #	
  #      if(fFound)
  #        index = @iTeamIDs.index(teamee[0])
  #        iSlot = teamee[0].index(iPlayer)
  #        puts "fFound is #{fFound} for player #{iPlayer}, index is #{index}, iSlot is #{iSlot}"
  #        #Need to remove the player
  #        if(game_values.playercontrol[iPlayer] == 0)
  #          puts "@iTeamCounts[index]-=1; #{@iTeamCounts.inspect}"
  #          @iTeamCounts[index]-=1;
  #          if(@iTeamCounts[index] > iSlotID)
  #            @iTeamCounts[index].times do |iSlot|
  #              @indexs[index][iSlot] = indexs[index][iSlot + 1];
  #            end
  #          end
  #        else
  #          if(game_values.playercontrol[iPlayer] > 0)
  #            iLookForNewTeam = iPlayer;
  #            while(@iTeamCounts[iLookForNewTeam] >= 3)
  #              if((iLookForNewTeam =  iLookForNewTeam + 1)>= 4)
  #                iLookForNewTeam = 0;
  #              end
  #            end
  #  		      
  #            @iTeamIDs[iLookForNewTeam][@iTeamCounts[iLookForNewTeam]] = iPlayer;
  #            @iTeamCounts[iLookForNewTeam]+=1;
  #     				
  #            if(game_values.teamcolors)
  #              game_values.colorids[iPlayer] = iLookForNewTeam;
  #            end
  #          end
  #        end
  #      end
  #  		
  #    end
  #    
  #    puts "middle reset return: #{@iTeamCounts.inspect} #{game_values.teamcounts.inspect}" 
  #    
  #    #Check to see if there is only one team and if so, split them up
  #    iCountTeams = 0;
  #    iLastTeam = 0;
  #    4.times do |iTeamID|
  #      if(@iTeamCounts[iTeamID] > 0)
  #        iCountTeams+=1;
  #        iLastTeam = iTeamID;
  #      end
  #    end
  #    if(iCountTeams == 1)
  #      iLookForNewTeam = iLastTeam;
  #      iLookForNewTeam+=1
  #      if iLookForNewTeam == 4
  #        iLookForNewTeam = 0;
  #      end
  #      @iTeamCounts[iLastTeam]-=1;
  #      iPlayer = @iTeamIDs[iLastTeam][@iTeamCounts[iLastTeam]];
  #      @iTeamIDs[iLookForNewTeam][@iTeamCounts[iLookForNewTeam]] = iPlayer;
  #      @iTeamCounts[iLookForNewTeam]+=1;
  #		  
  #      if(game_values.teamcolors)
  #        game_values.colorids[iPlayer] = iLookForNewTeam;
  #      end
  #		  
  #    end
  #	  
  #    iAnimationTimer = 0;
  #    iAnimationFrame = 0;
  #	  
  #    @fAllReady = true;
  #	  
  #    4.times do |iPlayer|
  #      if(game_values.playercontrol[iPlayer] == 1)
  #        @fReady[iPlayer] = false;
  #        @fAllReady = false;
  #      else
  #        @fReady[iPlayer] = true;
  #      end
  #      #@fReady[iPlayer] = true if $debug
  #      #@fAllReady = true if $debug
  #      next if(game_values.playercontrol[iPlayer] == 0)
  #      if(game_values.teamcolors)
  #        #game_values.colorids[iPlayer] = getTeam(iPlayer);
  #        game_values.colorids[iPlayer] = iPlayer;
  #      else
  #        game_values.colorids[iPlayer] = iPlayer;
  #      end
  #		  
  #      #Skip skins that are invalid
  #      
  #      while(!loadMenuSkin(iPlayer, game_values.skinids[iPlayer], game_values.colorids[iPlayer]))
  #        
  #       	game_values.skinids[iPlayer]+=1	
  #        if(game_values.skinids[iPlayer] >= $skinlist.getCount())
  #          game_values.skinids[iPlayer] = 0;
  #        end
  #
  #      end
  #      puts "before reset return: #{@iTeamCounts.inspect} #{game_values.teamcounts.inspect}"
  #    end
  #	  
  #	  
  #  end
  def organizeTeams()
    @iNumTeams = 0;
    
    4.times do |iTeam|
      if(@iTeamCounts[iTeam] > 0)
        3.times do |iTeamSpot|
          $game_values.teamids[@iNumTeams][iTeamSpot] = @iTeamIDs[iTeam][iTeamSpot];
        end
        $game_values.teamcounts[@iNumTeams] = @iTeamCounts[iTeam];
        @iNumTeams+=1;
      end
    end
    return @iNumTeams
    
  end
  def getTeam(iPlayerID)
    
  end
  
  
  private
  def findNewTeam(iPlayerID, iDirection)
    puts "findNewTeam"
    teamee = @iTeamIDs.select {|x| x.include?(iPlayerID)}[0]
    index = @iTeamIDs.index(teamee)
    teamee.delete(iPlayerID)
    @iTeamCounts[index] -=1
    newIndex = index+iDirection
    if newIndex == 4
      newIndex = 0
    elsif newIndex == -1
      newIndex = 3
    end
    @iTeamIDs[newIndex] << iPlayerID
    @iTeamCounts[newIndex] +=1
    $game_values.colorids[iPlayerID] = newIndex
    loadMenuSkin(iPlayerID, $game_values.skinids[iPlayerID], $game_values.colorids[iPlayerID])
  end
end
class MI_TournamentScoreboard < UI_Control
  def initialize(*args)
    super(0,0)
  end
  
end

class MI_BonusWheel < UI_Control
  def initialize(*args)
    super(0,0)
  end
  
end

class MI_StoredPowerupResetButton < UI_Control
  def initialize(*args)
    super(0,0)
  end
  
  def setCode(code)
  end
  
end        