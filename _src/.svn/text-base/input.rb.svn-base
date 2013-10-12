NUM_KEYS=8
class CKeyState

  attr_accessor :fDown
  attr_accessor :fPressed
end

class CInputControl
  #     struct
  # 		{
  # 			short menu_up, menu_down, menu_left, menu_right, menu_select, menu_cancel, menu_random, menu_scrollfast;
  # 		};
  # 		struct
  # 		{
  # 			short game_left, game_right, game_jump, game_down, game_turbo, game_powerup, game_start, game_cancel;
  # 		};
  attr_accessor :keys
  def initialize
    @keys = Array.new(NUM_KEYS)
  end
end

class COutputControl
  attr_accessor :keys
  def initialize
    @keys = []
    NUM_KEYS.times do |i|
      @keys[i] = CKeyState.new
    end
    
  end
  def menu_up
    keys[0]
  end
  def menu_up=(key)
    keys[0] = key
  end
  
  def menu_down
    keys[1]
  end
  def menu_down=(key)
    keys[1] = key
  end
  
  def menu_left
    keys[2]
  end
  def menu_left=(key)
    keys[2] = key
  end
  
  def menu_right
    keys[3]
  end
  def menu_right=(key)
    keys[3] = key
  end
  
  def menu_select
    keys[4]
  end
  def menu_select=(key)
    keys[4] = key
  end
  
  def menu_cancel
    keys[5]
  end
  def menu_cancel=(key)
    keys[5] = key
  end
  
  def menu_random
    keys[6]
  end
  def menu_random=(key)
    keys[6] = key
  end
  
  def menu_scrollfast
    keys[7]
  end
  def menu_scrollfast=(key)
    keys[7] = key
  end
  
  def game_left
    keys[0]
  end
  def game_left=(key)
    keys[0] = key
  end
  def  game_right
    keys[1]
  end
  def  game_right=(key)
    keys[1] = key
  end
  def  game_jump
    keys[2]
  end
  def  game_jump=(key)
    keys[2] = key
  end
  def  game_down
    keys[3]
  end
  def  game_down=(key)
    keys[3] = key
  end
  def  game_turbo
    keys[4]
  end
  def  game_turbo=(key)
    keys[4] = key
  end
  def  game_powerup
    keys[5]
  end
  def  game_powerup=(key)
    keys[5] = key
  end
  def  game_start
    keys[6]
  end
  def  game_start=(key)
    keys[6] = key
  end
  def  game_cancel
    keys[7]
  end
  def  game_cancel=(key)
    keys[7] = key
  end
 
  
end

class CInputPlayerControl
  attr_accessor :iDevice, :inputGameControls
  def initialize
    @inputGameControls = [CInputControl.new, CInputControl.new]
  end
end

class CPlayerInput
  attr_accessor :inputControls,:outputControls,:iPressedKey
  def initialize
    @inputControls = [CInputControl.new,CInputControl.new,CInputControl.new,CInputControl.new]
    @outputControls = [COutputControl.new,COutputControl.new,COutputControl.new,COutputControl.new]
    @iPressedKey = 0
  end
  def checkIfMouseUsed
    2.times do |iGameState|
      4.times do |iPlayer|
        inputControl = @inputControls[iPlayer].inputGameControls[iGameState]
        NUM_KEYS.times do |iKey|
          iInputKey = inputControl.keys[iKey]
          if((iInputKey >= MOUSE_UP && iInputKey <= MOUSE_RIGHT) ||
                iInputKey == MOUSE_BUTTON_START + 4 || iInputKey == MOUSE_BUTTON_START + 5)
            @fUsingMouse = true
            return 
          end
    			
        end
      end
    end
    @fUsingMouse = false
  end
  
  #Pass in 0 for game and 1 for menu
  #Clear old button pushed states
  def clearPressedKeys(iGameState)
    4.times do |iPlayer|
      inputControl = @inputControls[iPlayer].inputGameControls[iGameState];
      outputControl = @outputControls[iPlayer];
      NUM_KEYS.times do |iKey|
        outputControl.keys[iKey].fPressed = false; 
        if(@fUsingMouse)
          iInputKey = inputControl.keys[iKey];
          #Need to reset analog mouse and joystick because there isnt a no longer moving event
          if((iInputKey >= MOUSE_UP && iInputKey <= MOUSE_RIGHT) )
            outputControl.keys[iKey].fDown = false;
          end

          #Clear mouse scroll inputs (scroll button down/up happen on same frame so it needs special case)
          if(iInputKey == MOUSE_BUTTON_START + 4 || iInputKey == MOUSE_BUTTON_START + 5)
            outputControl.keys[iKey].fDown = false;
          end
        end
      end
    end
    @iPressedKey = 0
  end
  def resetKeys
    #Clear all button pushed and down states
    #Call this when switching from menu to game
    #puts "resetKeys"
    4.times do |iPlayer|
      NUM_KEYS.times do |iKey|
        @outputControls[iPlayer].keys[iKey].fPressed = false;
        @outputControls[iPlayer].keys[iKey].fDown = false;
      end
    end
    @iPressedKey = 0;
  end
  
  #Called during game loop to read input events and see if 
  #configured keys were pressed.  If they were, then turn on 
  #key flags to be used by game logic
  #iGameState == 0 for in game and 1 for menu
  def update(event, iGameState)
    game_values = $game_values
    fFound = false;
    -1.upto(3) do |iPlayer|
  	
      #inputControl;
      #outputControl;
      iPlayerID = iPlayer;
      iDeviceID = DEVICE_KEYBOARD;
  
      #Allow keyboard input from player 1 at all times (even when he is configured to use joystick)
      if(iPlayer == -1)
        if(iGameState == 1 && inputControls[0].iDevice != DEVICE_KEYBOARD) 
          inputControl = game_values.inputConfiguration[0][0].inputGameControls[1];
          outputControl = @outputControls[0];
          iPlayerID = 0;
          iDeviceID = game_values.inputConfiguration[0][0].iDevice;
        else
          next;
        end
      else
        inputControl = @inputControls[iPlayer].inputGameControls[iGameState];
        outputControl = @outputControls[iPlayer];
        iDeviceID = inputControls[iPlayerID].iDevice;
      end
  		
      if iDeviceID == DEVICE_KEYBOARD
        if event.class == KeyDownEvent
  		    
          key = inputControl.keys.index(event.key)
          if key
            key = outputControl.keys[key]
            if(!key.fDown)
              key.fPressed = true 
            end
            key.fDown = true
          end
  		    
          @iPressedKey =  event.key
        end
        if event.class == KeyUpEvent
          key = inputControl.keys.index(event.key)
          if key
            key = outputControl.keys[key]
            key.fDown = false;
          end
        end
      else #use joy stick
  		
      end
  		
    end
  end
end