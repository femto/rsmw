require 'uimenu'
require 'uicontrol'
DISPLAY_ERROR_NONE=0
DISPLAY_ERROR_READ_TOUR_FILE=1
DISPLAY_ERROR_MAP_FILTER=2

class Menu
  def initialize
    @iDisplayError = 0
    @iDisplayErrorTimer = 0
  end
  def createMenu
    #szTemp #char [256]
    #***********************
    # Main Menu
    #***********************
		
		
		
    @miSMWTitle = MI_Image.new($menu_smw, 320 - ($menu_smw.width >> 1), 30, 0, 0, 372, 140, 1, 1, 0);
    @miSMWVersion = MI_Image.new($menu_version, 570, 10, 0, 0, 58, 32, 1, 1, 0);
	  
    @miMainStartButton = MI_Button.new($spr_selectfield, 120, 180, "Start", 400, 0);
    @miMainStartButton.setCode(MENU_CODE_TO_TEAM_SELECT_MENU);
	  
    @miPlayerSelect = MI_PlayerSelect.new($menu_player_select, 120, 220, "Players", 400, 140);
	
    @miTournamentField = MI_SelectField.new($spr_selectfield, 120, 292, "Match", 400, 140);
    @miTournamentField.add("Single Game", 1, "", false, false);
    @miTournamentField.add("Tournament 2", 2, "", true, false);
    @miTournamentField.add("Tournament 3", 3, "", true, false);
    @miTournamentField.add("Tournament 4", 4, "", true, false);
    @miTournamentField.add("Tournament 5", 5, "", true, false);
    @miTournamentField.add("Tournament 6", 6, "", true, false);
    @miTournamentField.add("Tournament 7", 7, "", true, false);
    @miTournamentField.add("Tournament 8", 8, "", true, false);
    @miTournamentField.add("Tournament 9", 9, "", true, false);
    @miTournamentField.add("Tournament 10", 10, "", true, false);
    @miTournamentField.setData($game_values.tournamentgames, nil, $game_values.tournament);
    @miTournamentField.setKey($game_values.tournamentgames);
    @miTournamentField.setItemChangedCode(MENU_CODE_TOURNAMENT_CHANGED);
		
    #for(short iTour = 0; iTour < tourlist.GetCount(); iTour++)
    #		GetNameFromFileName(szTemp, tourlist.GetIndex(iTour));
    #		strcat(szTemp, " Tour");
    #		miTournamentField->Add(szTemp, iTour + 11, "", true, false);
    #end
		
    @miOptionsButton = MI_Button.new($spr_selectfield, 120, 332, "Options", 400, 0);
    @miOptionsButton.setCode(MENU_CODE_TO_OPTIONS_MENU);
	
    @miControlsButton = MI_Button.new($spr_selectfield, 120, 372, "Controls", 400, 0);
    @miControlsButton.setCode(MENU_CODE_TO_CONTROLS_MENU);
	
    @miExitButton = MI_Button.new($spr_selectfield, 120, 412, "Exit", 400, 0);
    @miExitButton.setCode(MENU_CODE_EXIT_APPLICATION);
    @mMainMenu = UI_Menu.new
                
    @mMainMenu.addControl(@miMainStartButton, @miExitButton, @miPlayerSelect, nil, nil);
    @mMainMenu.addControl(@miPlayerSelect, @miMainStartButton, @miTournamentField, nil, nil);
    @mMainMenu.addControl(@miTournamentField, @miPlayerSelect, @miOptionsButton, nil, nil);
    @mMainMenu.addControl(@miOptionsButton, @miTournamentField, @miControlsButton, nil, nil);
    @mMainMenu.addControl(@miControlsButton, @miOptionsButton, @miExitButton, nil, nil);
    @mMainMenu.addControl(@miExitButton, @miControlsButton, @miMainStartButton, nil, nil);
		
    @mMainMenu.setHeadControl(@miMainStartButton);
    #ifndef _XBOX
    @mMainMenu.setCancelCode(MENU_CODE_EXIT_APPLICATION);
    #endif
	
    @mMainMenu.addNonControl(@miSMWTitle);
    @mMainMenu.addNonControl(@miSMWVersion);
    #@mMainMenu.addNonControl(@miSMWVersionText);
		
    #***********************
    # Player Control Select Menu
    #***********************
		
    @miPlayer1ControlsButton = MI_Button.new($spr_selectfield, 120, 140, "Player 1", 400, 1);
    @miPlayer1ControlsButton.setCode(MENU_CODE_TO_PLAYER_1_CONTROLS);
	
    @miPlayer2ControlsButton = MI_Button.new($spr_selectfield, 120, 180, "Player 2", 400, 1);
    @miPlayer2ControlsButton.setCode(MENU_CODE_TO_PLAYER_2_CONTROLS);
	
    @miPlayer3ControlsButton = MI_Button.new($spr_selectfield, 120, 220, "Player 3", 400, 1);
    @miPlayer3ControlsButton.setCode(MENU_CODE_TO_PLAYER_3_CONTROLS);
	
    @miPlayer4ControlsButton = MI_Button.new($spr_selectfield, 120, 260, "Player 4", 400, 1);
    @miPlayer4ControlsButton.setCode(MENU_CODE_TO_PLAYER_4_CONTROLS);
	
    @miPlayerControlsBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miPlayerControlsBackButton.setCode(MENU_CODE_TO_MAIN_MENU);
		
    @miPlayerControlsLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miPlayerControlsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miPlayerControlsMenuHeaderText = MI_Text.new("Player Controls Menu", 320, 5, 0, 2, 1);
	
    @mPlayerControlsSelectMenu = UI_Menu.new
    @mPlayerControlsSelectMenu.addControl(@miPlayer1ControlsButton, @miPlayerControlsBackButton, @miPlayer2ControlsButton, nil, @miPlayerControlsBackButton);
    @mPlayerControlsSelectMenu.addControl(@miPlayer2ControlsButton, @miPlayer1ControlsButton, @miPlayer3ControlsButton, nil, @miPlayerControlsBackButton);
    @mPlayerControlsSelectMenu.addControl(@miPlayer3ControlsButton, @miPlayer2ControlsButton, @miPlayer4ControlsButton, nil, @miPlayerControlsBackButton);
    @mPlayerControlsSelectMenu.addControl(@miPlayer4ControlsButton, @miPlayer3ControlsButton, @miPlayerControlsBackButton, nil, @miPlayerControlsBackButton);
    @mPlayerControlsSelectMenu.addControl(@miPlayerControlsBackButton, @miPlayer4ControlsButton, @miPlayer1ControlsButton, @miPlayer1ControlsButton, nil);
	
    @mPlayerControlsSelectMenu.addNonControl(@miPlayerControlsLeftHeaderBar);
    @mPlayerControlsSelectMenu.addNonControl(@miPlayerControlsMenuRightHeaderBar);
    @mPlayerControlsSelectMenu.addNonControl(@miPlayerControlsMenuHeaderText);
		
    @mPlayerControlsSelectMenu.setHeadControl(@miPlayer1ControlsButton);
    @mPlayerControlsSelectMenu.setCancelCode(MENU_CODE_TO_MAIN_MENU);
	
    #***********************
    # Player Controls Menu
    #***********************
	
    @miInputContainer = MI_InputControlContainer.new($menu_plain_field, 94, 10, 0);
    
    @miInputContainer.setAutoModify(true);
    
    @mPlayerControlsMenu = UI_Menu.new
    @mPlayerControlsMenu.addControl(@miInputContainer, nil, nil, nil, nil);
    @mPlayerControlsMenu.setHeadControl(@miInputContainer);
    @mPlayerControlsMenu.setCancelCode(MENU_CODE_BACK_TO_CONTROLS_MENU);
	
	
    #***********************
    # Options Menu
    #***********************
	
    @miGameplayOptionsMenuButton = MI_Button.new($spr_selectfield, 120, 80, "Gameplay", 400, 1);
    @miGameplayOptionsMenuButton.setCode(MENU_CODE_TO_GAMEPLAY_OPTIONS_MENU);
		
    @miTeamOptionsMenuButton = MI_Button.new($spr_selectfield, 120, 120, "Team", 400, 1);
    @miTeamOptionsMenuButton.setCode(MENU_CODE_TO_TEAM_OPTIONS_MENU);
	
    @miPowerupOptionsMenuButton = MI_Button.new($spr_selectfield, 120, 160, "Item Selection", 400, 1);
    @miPowerupOptionsMenuButton.setCode(MENU_CODE_TO_POWERUP_SELECTION_MENU);
	
    @miPowerupSettingsMenuButton = MI_Button.new($spr_selectfield, 120, 200, "Item Settings", 400, 1);
    @miPowerupSettingsMenuButton.setCode(MENU_CODE_TO_POWERUP_SETTINGS_MENU);
	
    @miProjectilesOptionsMenuButton = MI_Button.new($spr_selectfield, 120, 240, "Weapons & Projectiles", 400, 1);
    @miProjectilesOptionsMenuButton.setCode(MENU_CODE_TO_PROJECTILES_OPTIONS_MENU);
	
    @miGraphicsOptionsMenuButton = MI_Button.new($spr_selectfield, 120, 280, "Graphics", 400, 1);
    @miGraphicsOptionsMenuButton.setCode(MENU_CODE_TO_GRAPHICS_OPTIONS_MENU);
    game_values = $game_values
    @miSoundOptionsMenuButton = MI_Button.new((game_values.soundcapable ? $spr_selectfield : $spr_selectfielddisabled), 120, 320, "Sound", 400, 1);
		
    if(game_values.soundcapable)
      @miSoundOptionsMenuButton.setCode(MENU_CODE_TO_SOUND_OPTIONS_MENU);
    end
	
    @miGenerateMapThumbsButton = MI_Button.new($spr_selectfield, 120, 360, "Refresh Maps", 400, 1);
    @miGenerateMapThumbsButton.setCode(MENU_CODE_SAVE_ALL_MAP_THUMBNAILS);
	
    @miOptionsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miOptionsMenuBackButton.setCode(MENU_CODE_TO_MAIN_MENU);
	
    @miOptionsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miOptionsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miOptionsMenuHeaderText = MI_Text.new("Options Menu", 320, 5, 0, 2, 1);
	
    @miGenerateThumbsDialogImage = MI_Image.new($spr_dialog, 224, 176, 0, 0, 192, 128, 1, 1, 0);
    @miGenerateThumbsDialogAreYouText = MI_Text.new("Are You", 320, 195, 0, 2, 1);
    @miGenerateThumbsDialogSureText = MI_Text.new("Sure?", 320, 220, 0, 2, 1);
    @miGenerateThumbsDialogYesButton = MI_Button.new($spr_selectfield, 235, 250, "Yes", 80, 1);
    @miGenerateThumbsDialogNoButton = MI_Button.new($spr_selectfield, 325, 250, "No", 80, 1);
		
    @miGenerateThumbsDialogYesButton.setCode(MENU_CODE_GENERATE_THUMBS_RESET_YES);
    @miGenerateThumbsDialogNoButton.setCode(MENU_CODE_GENERATE_THUMBS_RESET_NO);
	
    @miGenerateThumbsDialogImage.show(false);
    @miGenerateThumbsDialogAreYouText.show(false);
    @miGenerateThumbsDialogSureText.show(false);
    @miGenerateThumbsDialogYesButton.show(false);
    @miGenerateThumbsDialogNoButton.show(false);
	
    @mOptionsMenu = UI_Menu.new
    @mOptionsMenu.addControl(@miGameplayOptionsMenuButton, @miOptionsMenuBackButton, @miTeamOptionsMenuButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miTeamOptionsMenuButton, @miGameplayOptionsMenuButton, @miPowerupOptionsMenuButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miPowerupOptionsMenuButton, @miTeamOptionsMenuButton, @miPowerupSettingsMenuButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miPowerupSettingsMenuButton, @miPowerupOptionsMenuButton, @miProjectilesOptionsMenuButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miProjectilesOptionsMenuButton, @miPowerupSettingsMenuButton, @miGraphicsOptionsMenuButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miGraphicsOptionsMenuButton, @miProjectilesOptionsMenuButton, @miSoundOptionsMenuButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miSoundOptionsMenuButton, @miGraphicsOptionsMenuButton, @miGenerateMapThumbsButton, nil, @miOptionsMenuBackButton);
    @mOptionsMenu.addControl(@miGenerateMapThumbsButton, @miSoundOptionsMenuButton, @miOptionsMenuBackButton, nil, @miOptionsMenuBackButton);
	
    @mOptionsMenu.addControl(@miOptionsMenuBackButton, @miGenerateMapThumbsButton, @miGameplayOptionsMenuButton, @miGenerateMapThumbsButton, nil);
		
    @mOptionsMenu.addNonControl(@miOptionsMenuLeftHeaderBar);
    @mOptionsMenu.addNonControl(@miOptionsMenuRightHeaderBar);
    @mOptionsMenu.addNonControl(@miOptionsMenuHeaderText);
	
    @mOptionsMenu.addNonControl(@miGenerateThumbsDialogImage);
    @mOptionsMenu.addNonControl(@miGenerateThumbsDialogAreYouText);
    @mOptionsMenu.addNonControl(@miGenerateThumbsDialogSureText);
	
    @mOptionsMenu.addControl(@miGenerateThumbsDialogYesButton, nil, nil, nil, @miGenerateThumbsDialogNoButton);
    @mOptionsMenu.addControl(@miGenerateThumbsDialogNoButton, nil, nil, @miGenerateThumbsDialogYesButton, nil);
	
    @mOptionsMenu.setHeadControl(@miGameplayOptionsMenuButton);
    @mOptionsMenu.setCancelCode(MENU_CODE_TO_MAIN_MENU);
	
	
    #***********************
    # Graphics Options
    #***********************
	
    @miSpawnStyleField = MI_SelectField.new($spr_selectfield, 120, 60, "Spawn", 400, 150);
    @miSpawnStyleField.add("Instant", 0, "", false, false);
    @miSpawnStyleField.add("Door", 1, "", false, false);
    @miSpawnStyleField.add("Swirl", 2, "", false, false);
    @miSpawnStyleField.setData($game_values.spawnstyle, nil, nil);
    @miSpawnStyleField.setKey(game_values.spawnstyle);
	
    @miAwardStyleField = MI_SelectField.new($spr_selectfield, 120, 100, "Awards", 400, 150);
    @miAwardStyleField.add("None", 0, "", false, false);
    @miAwardStyleField.add("Fireworks", 1, "", false, false);
    @miAwardStyleField.add("Spiral", 2, "", false, false);
    @miAwardStyleField.add("Ring", 3, "", false, false);
    @miAwardStyleField.add("Souls", 4, "", false, false);
    @miAwardStyleField.add("Text", 5, "", false, false);
    @miAwardStyleField.setData($game_values.awardstyle, nil, nil);
    @miAwardStyleField.setKey(game_values.awardstyle);
	
    @miScoreStyleField = MI_SelectField.new($spr_selectfield, 120, 140, "Scores", 400, 150);
    @miScoreStyleField.add("Top", 0, "", false, false);
    @miScoreStyleField.add("Bottom", 1, "", false, false);
    @miScoreStyleField.add("Corners", 2, "", false, false);
    @miScoreStyleField.setData($game_values.scoreboardstyle, nil, nil);
    @miScoreStyleField.setKey(game_values.scoreboardstyle);
	
    @miCrunchField = MI_SelectField.new($spr_selectfield, 120, 180, "Crunch", 400, 150);
    @miCrunchField.add("Off", 0, "", false, false);
    @miCrunchField.add("On", 1, "", true, false);
    @miCrunchField.setData(nil, nil, $game_values.screencrunch);
    @miCrunchField.setKey(game_values.screencrunch ? 1 : 0);
    @miCrunchField.setAutoAdvance(true);
	
    @miTopLayerField = MI_SelectField.new($spr_selectfield, 120, 220, "Top Layer", 400, 150);
    @miTopLayerField.add("Background", 0, "", false, false);
    @miTopLayerField.add("Foreground", 1, "", true, false);
    @miTopLayerField.setData(nil, nil, $game_values.toplayer);
    @miTopLayerField.setKey(game_values.toplayer ? 1 : 0);
    @miTopLayerField.setAutoAdvance(true);
	
    @miWinningCrownField = MI_SelectField.new($spr_selectfield, 120, 260, "Crown", 400, 150);
    @miWinningCrownField.add("Off", 0, "", false, false);
    @miWinningCrownField.add("On", 1, "", true, false);
    @miWinningCrownField.setData(nil, nil, $game_values.showwinningcrown);
    @miWinningCrownField.setKey(game_values.showwinningcrown ? 1 : 0);
    @miWinningCrownField.setAutoAdvance(true);
	
    #ifdef _XBOX
    #@miScreenSettingsButton = MI_Button.new($spr_selectfield, 120, 300, "Screen Settings", 400, 0);
    #@miScreenSettingsButton.setCode(MENU_CODE_TO_SCREEN_SETTINGS);
    #else
    @miFullscreenField = MI_SelectField.new($spr_selectfield, 120, 300, "Screen", 400, 150);
    @miFullscreenField.add("Windowed", 0, "", false, false);
    @miFullscreenField.add("Fullscreen", 1, "", true, false);
    @miFullscreenField.setData(nil, nil, $game_values.fullscreen);
    @miFullscreenField.setKey(game_values.fullscreen ? 1 : 0);
    @miFullscreenField.setAutoAdvance(true);
    @miFullscreenField.setItemChangedCode(MENU_CODE_TOGGLE_FULLSCREEN);
    #endif #_XBOX
	
    @miMenuGraphicsPackField = MI_PacksField.new($spr_selectfield, 120, 340, "Menu Gfx", 400, 150, $menugraphicspacklist, MENU_CODE_MENU_GRAPHICS_PACK_CHANGED);
    @miGameGraphicsPackField = MI_PacksField.new($spr_selectfield, 120, 380, "Game Gfx", 400, 150, $gamegraphicspacklist, MENU_CODE_GAME_GRAPHICS_PACK_CHANGED);
	
    @miGraphicsOptionsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miGraphicsOptionsMenuBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
	
    @miGraphicsOptionsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miGraphicsOptionsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miGraphicsOptionsMenuHeaderText = MI_Text.new("Graphics Options Menu", 320, 5, 0, 2, 1);
	
    @mGraphicsOptionsMenu = UI_Menu.new
    @mGraphicsOptionsMenu.addControl(@miSpawnStyleField, @miGraphicsOptionsMenuBackButton, @miAwardStyleField, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miAwardStyleField, @miSpawnStyleField, @miScoreStyleField, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miScoreStyleField, @miAwardStyleField, @miCrunchField, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miCrunchField, @miScoreStyleField, @miTopLayerField, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miTopLayerField, @miCrunchField, @miWinningCrownField, nil, @miGraphicsOptionsMenuBackButton);
    #ifdef _XBOX
    #@mGraphicsOptionsMenu.addControl(@miWinningCrownField, @miTopLayerField, @miScreenSettingsButton, nil, @miGraphicsOptionsMenuBackButton);
    #@mGraphicsOptionsMenu.addControl(@miScreenSettingsButton, @miWinningCrownField, @miMenuGraphicsPackField, nil, @miGraphicsOptionsMenuBackButton);
    #@mGraphicsOptionsMenu.addControl(@miMenuGraphicsPackField, @miScreenSettingsButton, @miGameGraphicsPackField, nil, @miGraphicsOptionsMenuBackButton);
    #else
    @mGraphicsOptionsMenu.addControl(@miWinningCrownField, @miTopLayerField, @miFullscreenField, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miFullscreenField, @miWinningCrownField, @miMenuGraphicsPackField, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miMenuGraphicsPackField, @miFullscreenField, @miGameGraphicsPackField, nil, @miGraphicsOptionsMenuBackButton);
    #endif
	
    @mGraphicsOptionsMenu.addControl(@miGameGraphicsPackField, @miMenuGraphicsPackField, @miGraphicsOptionsMenuBackButton, nil, @miGraphicsOptionsMenuBackButton);
    @mGraphicsOptionsMenu.addControl(@miGraphicsOptionsMenuBackButton, @miGameGraphicsPackField, @miSpawnStyleField, @miGameGraphicsPackField, nil);
	
    @mGraphicsOptionsMenu.addNonControl(@miGraphicsOptionsMenuLeftHeaderBar);
    @mGraphicsOptionsMenu.addNonControl(@miGraphicsOptionsMenuRightHeaderBar);
    @mGraphicsOptionsMenu.addNonControl(@miGraphicsOptionsMenuHeaderText);
	
    @mGraphicsOptionsMenu.setHeadControl(@miSpawnStyleField);
    @mGraphicsOptionsMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
	
    #***********************
    # Team Options
    #***********************
	
	
    @miTeamKillsField = MI_SelectField.new($spr_selectfield, 120, 200, "Kills", 400, 150);
    @miTeamKillsField.add("Off", 0, "", false, false);
    @miTeamKillsField.add("On", 1, "", true, false);
    @miTeamKillsField.setData(nil, nil, $game_values.friendlyfire);
    @miTeamKillsField.setKey(game_values.friendlyfire ? 1 : 0);
    @miTeamKillsField.setAutoAdvance(true);
	
    @miTeamColorsField = MI_SelectField.new($spr_selectfield, 120, 240, "Colors", 400, 150);
    @miTeamColorsField.add("Off", 0, "", false, false);
    @miTeamColorsField.add("On", 1, "", true, false);
    @miTeamColorsField.setData(nil, nil, $game_values.teamcolors);
    @miTeamColorsField.setKey(game_values.teamcolors ? 1 : 0);
    @miTeamColorsField.setAutoAdvance(true);
	
    @miTeamOptionsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miTeamOptionsMenuBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
	
    @miTeamOptionsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miTeamOptionsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miTeamOptionsMenuHeaderText = MI_Text.new("Team Options Menu", 320, 5, 0, 2, 1);
	
    @mTeamOptionsMenu = UI_Menu.new
    @mTeamOptionsMenu.addControl(@miTeamKillsField, @miTeamOptionsMenuBackButton, @miTeamColorsField, nil, @miTeamOptionsMenuBackButton);
    @mTeamOptionsMenu.addControl(@miTeamColorsField, @miTeamKillsField, @miTeamOptionsMenuBackButton, nil, @miTeamOptionsMenuBackButton);
    @mTeamOptionsMenu.addControl(@miTeamOptionsMenuBackButton, @miTeamColorsField, @miTeamKillsField, @miTeamColorsField, nil);
	
    @mTeamOptionsMenu.addNonControl(@miTeamOptionsMenuLeftHeaderBar);
    @mTeamOptionsMenu.addNonControl(@miTeamOptionsMenuRightHeaderBar);
    @mTeamOptionsMenu.addNonControl(@miTeamOptionsMenuHeaderText);
	
    @mTeamOptionsMenu.setHeadControl(@miTeamKillsField);
    @mTeamOptionsMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
	
    #***********************
    # Gameplay Options
    #***********************
	
    @miRespawnField = MI_SelectField.new($spr_selectfield, 120, 80, "Respawn", 400, 180);
    @miRespawnField.add("Instant", 0, "", false, false);
    @miRespawnField.add("0.5 Seconds", 1, "", false, false);
    @miRespawnField.add("1.0 Seconds", 2, "", false, false);
    @miRespawnField.add("1.5 Seconds", 3, "", false, false);
    @miRespawnField.add("2.0 Seconds", 4, "", false, false);
    @miRespawnField.add("2.5 Seconds", 5, "", false, false);
    @miRespawnField.add("3.0 Seconds", 6, "", false, false);
    @miRespawnField.add("3.5 Seconds", 7, "", false, false);
    @miRespawnField.add("4.0 Seconds", 8, "", false, false);
    @miRespawnField.add("4.5 Seconds", 9, "", false, false);
    @miRespawnField.add("5.0 Seconds", 10, "", false, false);
    @miRespawnField.add("5.5 Seconds", 11, "", false, false);
    @miRespawnField.add("6.0 Seconds", 12, "", false, false);
    @miRespawnField.add("6.5 Seconds", 13, "", false, false);
    @miRespawnField.add("7.0 Seconds", 14, "", false, false);
    @miRespawnField.add("7.5 Seconds", 15, "", false, false);
    @miRespawnField.add("8.0 Seconds", 16, "", false, false);
    @miRespawnField.add("8.5 Seconds", 17, "", false, false);
    @miRespawnField.add("9.0 Seconds", 18, "", false, false);
    @miRespawnField.add("9.5 Seconds", 19, "", false, false);
    @miRespawnField.add("10.0 Seconds", 20, "", false, false);
    @miRespawnField.setData($game_values.respawn, nil, nil);
    @miRespawnField.setKey(game_values.respawn);
	
    @miShieldField = MI_SelectField.new($spr_selectfield, 120, 120, "Shield", 400, 180);
    @miShieldField.add("None", 0, "", false, false);
    @miShieldField.add("0.5 Seconds", 31, "", false, false);
    @miShieldField.add("1.0 Seconds", 62, "", false, false);
    @miShieldField.add("1.5 Seconds", 93, "", false, false);
    @miShieldField.add("2.0 Seconds", 124, "", false, false);
    @miShieldField.add("2.5 Seconds", 155, "", false, false);
    @miShieldField.add("3.0 Seconds", 186, "", false, false);
    @miShieldField.add("3.5 Seconds", 217, "", false, false);
    @miShieldField.add("4.0 Seconds", 248, "", false, false);
    @miShieldField.add("4.5 Seconds", 279, "", false, false);
    @miShieldField.add("5.0 Seconds", 310, "", false, false);
    @miShieldField.setData($game_values.spawninvincibility, nil, nil);
    @miShieldField.setKey(game_values.spawninvincibility);
	
    @miBoundsTimeField = MI_SelectField.new($spr_selectfield, 120, 160, "Bounds Time", 400, 180);
    @miBoundsTimeField.add("Infinite", 0, "", false, false);
    @miBoundsTimeField.add("1 Second", 1, "", false, false);
    @miBoundsTimeField.add("2 Seconds", 2, "", false, false);
    @miBoundsTimeField.add("3 Seconds", 3, "", false, false);
    @miBoundsTimeField.add("4 Seconds", 4, "", false, false);
    @miBoundsTimeField.add("5 Seconds", 5, "", false, false);
    @miBoundsTimeField.add("6 Seconds", 6, "", false, false);
    @miBoundsTimeField.add("7 Seconds", 7, "", false, false);
    @miBoundsTimeField.add("8 Seconds", 8, "", false, false);
    @miBoundsTimeField.add("9 Seconds", 9, "", false, false);
    @miBoundsTimeField.add("10 Seconds", 10, "", false, false);
    @miBoundsTimeField.setData($game_values.outofboundstime, nil, nil);
    @miBoundsTimeField.setKey(game_values.outofboundstime);
	
    @miWarpLocksField = MI_SelectField.new($spr_selectfield, 120, 200, "Warp Locks", 400, 180);
    @miWarpLocksField.add("Off", 0, "", false, false);
    @miWarpLocksField.add("1 Second", 62, "", false, false);
    @miWarpLocksField.add("2 Seconds", 124, "", false, false);
    @miWarpLocksField.add("3 Seconds", 186, "", false, false);
    @miWarpLocksField.add("4 Seconds", 248, "", false, false);
    @miWarpLocksField.add("5 Seconds", 310, "", false, false);
    @miWarpLocksField.add("6 Seconds", 372, "", false, false);
    @miWarpLocksField.add("7 Seconds", 434, "", false, false);
    @miWarpLocksField.add("8 Seconds", 496, "", false, false);
    @miWarpLocksField.add("9 Seconds", 558, "", false, false);
    @miWarpLocksField.add("10 Seconds", 620, "", false, false);
    @miWarpLocksField.setData($game_values.warplocks, nil, nil);
    @miWarpLocksField.setKey(game_values.warplocks);
	
    @miBotsField = MI_SelectField.new($spr_selectfield, 120, 240, "Bots", 400, 180);
    @miBotsField.add("Very Easy", 0, "", false, false);
    @miBotsField.add("Easy", 1, "", false, false);
    @miBotsField.add("Moderate", 2, "", false, false);
    @miBotsField.add("Hard", 3, "", false, false);
    @miBotsField.add("Very Hard", 4, "", false, false);
    @miBotsField.setData($game_values.cpudifficulty, nil, nil);
    @miBotsField.setKey(game_values.cpudifficulty);
	
    @miFrameLimiterField = MI_SelectField.new($spr_selectfield, 120, 280, "Frame Limit", 400, 180);
    @miFrameLimiterField.add("10 FPS", 100, "", false, false);
    @miFrameLimiterField.add("15 FPS", 67, "", false, false);
    @miFrameLimiterField.add("20 FPS", 50, "", false, false);
    @miFrameLimiterField.add("25 FPS", 40, "", false, false);
    @miFrameLimiterField.add("30 FPS", 33, "", false, false);
    @miFrameLimiterField.add("35 FPS", 28, "", false, false);
    @miFrameLimiterField.add("40 FPS", 25, "", false, false);
    @miFrameLimiterField.add("45 FPS", 22, "", false, false);
    @miFrameLimiterField.add("50 FPS", 20, "", false, false);
    @miFrameLimiterField.add("55 FPS", 18, "", false, false);
    @miFrameLimiterField.add("62 FPS (Normal)", 16, "", false, false);
    @miFrameLimiterField.add("66 FPS", 15, "", false, false);
    @miFrameLimiterField.add("71 FPS", 14, "", false, false);
    @miFrameLimiterField.add("77 FPS", 13, "", false, false);
    @miFrameLimiterField.add("83 FPS", 12, "", false, false);
    @miFrameLimiterField.add("90 FPS", 11, "", false, false);
    @miFrameLimiterField.add("100 FPS", 10, "", false, false);
    @miFrameLimiterField.add("111 FPS", 9, "", false, false);
    @miFrameLimiterField.add("125 FPS", 8, "", false, false);
    @miFrameLimiterField.add("142 FPS", 7, "", false, false);
    @miFrameLimiterField.add("166 FPS", 6, "", false, false);
    @miFrameLimiterField.add("200 FPS", 5, "", false, false);
    @miFrameLimiterField.add("250 FPS", 4, "", false, false);
    @miFrameLimiterField.add("333 FPS", 3, "", false, false);
    @miFrameLimiterField.add("500 FPS", 2, "", false, false);
    @miFrameLimiterField.add("No Limit", 0, "", false, false);
    @miFrameLimiterField.setData($game_values.framelimiter, nil, nil);
    @miFrameLimiterField.setKey(game_values.framelimiter);
	
    @miPointSpeedField = MI_SelectField.new($spr_selectfield, 120, 320, "Point Speed", 400, 180);
    @miPointSpeedField.add("Very Slow", 60, "", false, false);
    @miPointSpeedField.add("Slow", 40, "", false, false);
    @miPointSpeedField.add("Moderate", 20, "", false, false);
    @miPointSpeedField.add("Fast", 10, "", false, false);
    @miPointSpeedField.add("Very Fast", 5, "", false, false);
    @miPointSpeedField.setData($game_values.pointspeed, nil, nil);
    @miPointSpeedField.setKey(game_values.pointspeed);
		
    @miSecretsField = MI_SelectField.new($spr_selectfield, 120, 360, "Secrets", 400, 180);
    @miSecretsField.add("Off", 0, "", false, false);
    @miSecretsField.add("On", 1, "", true, false);
    @miSecretsField.setData(nil, nil, $game_values.secrets);
    @miSecretsField.setKey(game_values.secrets ? 1 : 0);
    @miSecretsField.setAutoAdvance(true);
	
    @miGameplayOptionsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miGameplayOptionsMenuBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
	
    @miGameplayOptionsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miGameplayOptionsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miGameplayOptionsMenuHeaderText = MI_Text.new("Gameplay Options Menu", 320, 5, 0, 2, 1);
	
    @mGameplayOptionsMenu = UI_Menu.new
    @mGameplayOptionsMenu.addControl(@miRespawnField, @miGameplayOptionsMenuBackButton, @miShieldField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miShieldField, @miRespawnField, @miBoundsTimeField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miBoundsTimeField, @miShieldField, @miWarpLocksField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miWarpLocksField, @miBoundsTimeField, @miBotsField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miBotsField, @miWarpLocksField, @miFrameLimiterField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miFrameLimiterField, @miBotsField, @miPointSpeedField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miPointSpeedField, @miFrameLimiterField, @miSecretsField, nil, @miGameplayOptionsMenuBackButton);
    @mGameplayOptionsMenu.addControl(@miSecretsField, @miPointSpeedField, @miGameplayOptionsMenuBackButton, nil, @miGameplayOptionsMenuBackButton);
		
    @mGameplayOptionsMenu.addControl(@miGameplayOptionsMenuBackButton, @miSecretsField, @miRespawnField, @miSecretsField, nil);
		
    @mGameplayOptionsMenu.addNonControl(@miGameplayOptionsMenuLeftHeaderBar);
    @mGameplayOptionsMenu.addNonControl(@miGameplayOptionsMenuRightHeaderBar);
    @mGameplayOptionsMenu.addNonControl(@miGameplayOptionsMenuHeaderText);
		
    @mGameplayOptionsMenu.setHeadControl(@miRespawnField);
    @mGameplayOptionsMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
		
    #***********************
    # Sound Options
    #***********************
		
    @miSoundVolumeField = MI_SliderField.new($spr_selectfield, $menu_slider_bar, 120, 120, "Sound", 400, 150, 384);
    @miSoundVolumeField.add("Off", 0, "", false, false);
    @miSoundVolumeField.add("1", 16, "", false, false);
    @miSoundVolumeField.add("2", 32, "", false, false);
    @miSoundVolumeField.add("3", 48, "", false, false);
    @miSoundVolumeField.add("4", 64, "", false, false);
    @miSoundVolumeField.add("5", 80, "", false, false);
    @miSoundVolumeField.add("6", 96, "", false, false);
    @miSoundVolumeField.add("7", 112, "", false, false);
    @miSoundVolumeField.add("Max", 128, "", false, false);
    @miSoundVolumeField.setData("$game_values.soundvolume", nil, nil);
    @miSoundVolumeField.setKey(game_values.soundvolume);
    @miSoundVolumeField.setNoWrap(true);
    @miSoundVolumeField.setItemChangedCode(MENU_CODE_SOUND_VOLUME_CHANGED);
			
    @miMusicVolumeField = MI_SliderField.new($spr_selectfield, $menu_slider_bar, 120, 160, "Music", 400, 150, 384);
    @miMusicVolumeField.add("Off", 0, "", false, false);
    @miMusicVolumeField.add("1", 16, "", false, false);
    @miMusicVolumeField.add("2", 32, "", false, false);
    @miMusicVolumeField.add("3", 48, "", false, false);
    @miMusicVolumeField.add("4", 64, "", false, false);
    @miMusicVolumeField.add("5", 80, "", false, false);
    @miMusicVolumeField.add("6", 96, "", false, false);
    @miMusicVolumeField.add("7", 112, "", false, false);
    @miMusicVolumeField.add("Max", 128, "", false, false);
    @miMusicVolumeField.setData("$game_values.musicvolume", nil, nil);
    @miMusicVolumeField.setKey(game_values.musicvolume);
    @miMusicVolumeField.setNoWrap(true);
    @miMusicVolumeField.setItemChangedCode(MENU_CODE_MUSIC_VOLUME_CHANGED);
		
    @miPlayNextMusicField = MI_SelectField.new($spr_selectfield, 120, 200, "Next Music", 400, 150);
    @miPlayNextMusicField.add("Off", 0, "", false, false);
    @miPlayNextMusicField.add("On", 1, "", true, false);
    @miPlayNextMusicField.setData(nil, nil, "$game_values.playnextmusic");
    @miPlayNextMusicField.setKey(game_values.playnextmusic ? 1 : 0);
    @miPlayNextMusicField.setAutoAdvance(true);
		
    @miAnnouncerField = MI_AnnouncerField.new($spr_selectfield, 120, 240, "Announcer", 400, 150, $announcerlist);
    @miPlaylistField = MI_PlaylistField.new($spr_selectfield, 120, 280, "Playlist", 400, 150);
    @miSoundPackField = MI_PacksField.new($spr_selectfield, 120, 320, "Sfx Pack", 400, 150, $soundpacklist, MENU_CODE_SOUND_PACK_CHANGED);
		
    @miSoundOptionsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miSoundOptionsMenuBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
		
    @miSoundOptionsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miSoundOptionsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miSoundOptionsMenuHeaderText = MI_Text.new("Sound Options Menu", 320, 5, 0, 2, 1);
		
    @mSoundOptionsMenu = UI_Menu.new
    @mSoundOptionsMenu.addControl(@miSoundVolumeField, @miSoundOptionsMenuBackButton, @miMusicVolumeField, nil, @miSoundOptionsMenuBackButton);
    @mSoundOptionsMenu.addControl(@miMusicVolumeField, @miSoundVolumeField, @miPlayNextMusicField, nil, @miSoundOptionsMenuBackButton);
    @mSoundOptionsMenu.addControl(@miPlayNextMusicField, @miMusicVolumeField, @miAnnouncerField, nil, @miSoundOptionsMenuBackButton);
    @mSoundOptionsMenu.addControl(@miAnnouncerField, @miPlayNextMusicField, @miPlaylistField, nil, @miSoundOptionsMenuBackButton);
    @mSoundOptionsMenu.addControl(@miPlaylistField, @miAnnouncerField, @miSoundPackField, nil, @miSoundOptionsMenuBackButton);
    @mSoundOptionsMenu.addControl(@miSoundPackField, @miPlaylistField, @miSoundOptionsMenuBackButton, nil, @miSoundOptionsMenuBackButton);
    @mSoundOptionsMenu.addControl(@miSoundOptionsMenuBackButton, @miSoundPackField, @miSoundVolumeField, @miSoundPackField, nil);
			
    @mSoundOptionsMenu.addNonControl(@miSoundOptionsMenuLeftHeaderBar);
    @mSoundOptionsMenu.addNonControl(@miSoundOptionsMenuRightHeaderBar);
    @mSoundOptionsMenu.addNonControl(@miSoundOptionsMenuHeaderText);
		
    @mSoundOptionsMenu.setHeadControl(@miSoundVolumeField);
    @mSoundOptionsMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
		
		
    #***********************
    # Projectile Options
    #***********************
		
    @miFireballLifeField = MI_SelectField.new($spr_selectfield, 10, 80, "Life", 305, 105);
    @miFireballLifeField.add("1 Second", 62, "", false, false);
    @miFireballLifeField.add("2 Seconds", 124, "", false, false);
    @miFireballLifeField.add("3 Seconds", 186, "", false, false);
    @miFireballLifeField.add("4 Seconds", 248, "", false, false);
    @miFireballLifeField.add("5 Seconds", 310, "", false, false);
    @miFireballLifeField.add("6 Seconds", 372, "", false, false);
    @miFireballLifeField.add("7 Seconds", 434, "", false, false);
    @miFireballLifeField.add("8 Seconds", 496, "", false, false);
    @miFireballLifeField.add("9 Seconds", 558, "", false, false);
    @miFireballLifeField.add("10 Seconds", 620, "", false, false);
    @miFireballLifeField.setData($game_values.fireballttl, nil, nil);
    @miFireballLifeField.setKey(game_values.fireballttl);
		
    @miFireballLimitField = MI_SelectField.new($spr_selectfield, 10, 120, "Limit", 305, 105);
    @miFireballLimitField.add("Unlimited", 0, "", false, false);
    @miFireballLimitField.add("2", 2, "", false, false);
    @miFireballLimitField.add("5", 5, "", false, false);
    @miFireballLimitField.add("8", 8, "", false, false);
    @miFireballLimitField.add("10", 10, "", false, false);
    @miFireballLimitField.add("12", 12, "", false, false);
    @miFireballLimitField.add("15", 15, "", false, false);
    @miFireballLimitField.add("20", 20, "", false, false);
    @miFireballLimitField.add("25", 25, "", false, false);
    @miFireballLimitField.add("30", 30, "", false, false);
    @miFireballLimitField.add("40", 40, "", false, false);
    @miFireballLimitField.add("50", 50, "", false, false);
    @miFireballLimitField.setData($game_values.fireballlimit, nil, nil);
    @miFireballLimitField.setKey(game_values.fireballlimit);
		
    @miFeatherJumpsField = MI_SelectField.new($spr_selectfield, 10, 200, "Jumps", 305, 105);
    @miFeatherJumpsField.add("1", 1, "", false, false);
    @miFeatherJumpsField.add("2", 2, "", false, false);
    @miFeatherJumpsField.add("3", 3, "", false, false);
    @miFeatherJumpsField.add("4", 4, "", false, false);
    @miFeatherJumpsField.add("5", 5, "", false, false);
    @miFeatherJumpsField.setData($game_values.featherjumps, nil, nil);
    @miFeatherJumpsField.setKey(game_values.featherjumps);
		
    @miFeatherLimitField = MI_SelectField.new($spr_selectfield, 10, 240, "Limit", 305, 105);
    @miFeatherLimitField.add("Unlimited", 0, "", false, false);
    @miFeatherLimitField.add("2", 2, "", false, false);
    @miFeatherLimitField.add("5", 5, "", false, false);
    @miFeatherLimitField.add("8", 8, "", false, false);
    @miFeatherLimitField.add("10", 10, "", false, false);
    @miFeatherLimitField.add("12", 12, "", false, false);
    @miFeatherLimitField.add("15", 15, "", false, false);
    @miFeatherLimitField.add("20", 20, "", false, false);
    @miFeatherLimitField.add("25", 25, "", false, false);
    @miFeatherLimitField.add("30", 30, "", false, false);
    @miFeatherLimitField.add("40", 40, "", false, false);
    @miFeatherLimitField.add("50", 50, "", false, false);
    @miFeatherLimitField.setData($game_values.featherlimit, nil, nil);
    @miFeatherLimitField.setKey(game_values.featherlimit);
		
    @miBoomerangStyleField = MI_SelectField.new($spr_selectfield, 10, 320, "Style", 305, 105);
    @miBoomerangStyleField.add("Flat", 0, "", false, false);
    @miBoomerangStyleField.add("SMB3", 1, "", false, false);
    @miBoomerangStyleField.add("Zelda", 2, "", false, false);
    @miBoomerangStyleField.add("Random", 3, "", false, false);
    @miBoomerangStyleField.setData($game_values.boomerangstyle, nil, nil);
    @miBoomerangStyleField.setKey(game_values.boomerangstyle);
		
    @miBoomerangLifeField = MI_SelectField.new($spr_selectfield, 10, 360, "Life", 305, 105);
    @miBoomerangLifeField.add("1 Second", 62, "", false, false);
    @miBoomerangLifeField.add("2 Seconds", 124, "", false, false);
    @miBoomerangLifeField.add("3 Seconds", 186, "", false, false);
    @miBoomerangLifeField.add("4 Seconds", 248, "", false, false);
    @miBoomerangLifeField.add("5 Seconds", 310, "", false, false);
    @miBoomerangLifeField.add("6 Seconds", 372, "", false, false);
    @miBoomerangLifeField.add("7 Seconds", 434, "", false, false);
    @miBoomerangLifeField.add("8 Seconds", 496, "", false, false);
    @miBoomerangLifeField.add("9 Seconds", 558, "", false, false);
    @miBoomerangLifeField.add("10 Seconds", 620, "", false, false);
    @miBoomerangLifeField.setData($game_values.boomeranglife, nil, nil);
    @miBoomerangLifeField.setKey(game_values.boomeranglife);
		
    @miBoomerangLimitField = MI_SelectField.new($spr_selectfield, 10, 400, "Limit", 305, 105);
    @miBoomerangLimitField.add("Unlimited", 0, "", false, false);
    @miBoomerangLimitField.add("2", 2, "", false, false);
    @miBoomerangLimitField.add("5", 5, "", false, false);
    @miBoomerangLimitField.add("8", 8, "", false, false);
    @miBoomerangLimitField.add("10", 10, "", false, false);
    @miBoomerangLimitField.add("12", 12, "", false, false);
    @miBoomerangLimitField.add("15", 15, "", false, false);
    @miBoomerangLimitField.add("20", 20, "", false, false);
    @miBoomerangLimitField.add("25", 25, "", false, false);
    @miBoomerangLimitField.add("30", 30, "", false, false);
    @miBoomerangLimitField.add("40", 40, "", false, false);
    @miBoomerangLimitField.add("50", 50, "", false, false);
    @miBoomerangLimitField.setData($game_values.boomeranglimit, nil, nil);
    @miBoomerangLimitField.setKey(game_values.boomeranglimit);
		
    @miHammerLifeField = MI_SelectField.new($spr_selectfield, 325, 80, "Life", 305, 105);
    @miHammerLifeField.add("No Limit", 310, "", false, false);
    @miHammerLifeField.add("0.5 Seconds", 31, "", false, false);
    @miHammerLifeField.add("0.6 Seconds", 37, "", false, false);
    @miHammerLifeField.add("0.7 Seconds", 43, "", false, false);
    @miHammerLifeField.add("0.8 Seconds", 49, "", false, false);
    @miHammerLifeField.add("0.9 Seconds", 55, "", false, false);
    @miHammerLifeField.add("1.0 Seconds", 62, "", false, false);
    @miHammerLifeField.add("1.1 Seconds", 68, "", false, false);
    @miHammerLifeField.add("1.2 Seconds", 74, "", false, false);
    @miHammerLifeField.setData($game_values.hammerttl, nil, nil);
    @miHammerLifeField.setKey(game_values.hammerttl);
		
    @miHammerDelayField = MI_SelectField.new($spr_selectfield, 325, 120, "Delay", 305, 105);
    @miHammerDelayField.add("None", 0, "", false, false);
    @miHammerDelayField.add("0.1 Seconds", 6, "", false, false);
    @miHammerDelayField.add("0.2 Seconds", 12, "", false, false);
    @miHammerDelayField.add("0.3 Seconds", 19, "", false, false);
    @miHammerDelayField.add("0.4 Seconds", 25, "", false, false);
    @miHammerDelayField.add("0.5 Seconds", 31, "", false, false);
    @miHammerDelayField.add("0.6 Seconds", 37, "", false, false);
    @miHammerDelayField.add("0.7 Seconds", 43, "", false, false);
    @miHammerDelayField.add("0.8 Seconds", 49, "", false, false);
    @miHammerDelayField.add("0.9 Seconds", 55, "", false, false);
    @miHammerDelayField.add("1.0 Seconds", 62, "", false, false);
    @miHammerDelayField.setData($game_values.hammerdelay, nil, nil);
    @miHammerDelayField.setKey(game_values.hammerdelay);
		
    @miHammerOneKillField = MI_SelectField.new($spr_selectfield, 325, 160, "Power", 305, 105);
    @miHammerOneKillField.add("One Kill", 0, "", true, false);
    @miHammerOneKillField.add("Multiple Kills", 1, "", false, false);
    @miHammerOneKillField.setData(nil, nil, $game_values.hammerpower);
    @miHammerOneKillField.setKey(game_values.hammerpower ? 0 : 1);
    @miHammerOneKillField.setAutoAdvance(true);
		
    @miHammerLimitField = MI_SelectField.new($spr_selectfield, 325, 200, "Limit", 305, 105);
    @miHammerLimitField.add("Unlimited", 0, "", false, false);
    @miHammerLimitField.add("2", 2, "", false, false);
    @miHammerLimitField.add("5", 5, "", false, false);
    @miHammerLimitField.add("8", 8, "", false, false);
    @miHammerLimitField.add("10", 10, "", false, false);
    @miHammerLimitField.add("12", 12, "", false, false);
    @miHammerLimitField.add("15", 15, "", false, false);
    @miHammerLimitField.add("20", 20, "", false, false);
    @miHammerLimitField.add("25", 25, "", false, false);
    @miHammerLimitField.add("30", 30, "", false, false);
    @miHammerLimitField.add("40", 40, "", false, false);
    @miHammerLimitField.add("50", 50, "", false, false);
    @miHammerLimitField.setData($game_values.hammerlimit, nil, nil);
    @miHammerLimitField.setKey(game_values.hammerlimit);
		
    @miShellLifeField = MI_SelectField.new($spr_selectfield, 325, 280, "Life", 305, 105);
    @miShellLifeField.add("Unlimited", 0, "", false, false);
    @miShellLifeField.add("1 Second", 62, "", false, false);
    @miShellLifeField.add("2 Seconds", 124, "", false, false);
    @miShellLifeField.add("3 Seconds", 186, "", false, false);
    @miShellLifeField.add("4 Seconds", 248, "", false, false);
    @miShellLifeField.add("5 Seconds", 310, "", false, false);
    @miShellLifeField.add("6 Seconds", 372, "", false, false);
    @miShellLifeField.add("7 Seconds", 434, "", false, false);
    @miShellLifeField.add("8 Seconds", 496, "", false, false);
    @miShellLifeField.add("9 Seconds", 558, "", false, false);
    @miShellLifeField.add("10 Seconds", 620, "", false, false);
    @miShellLifeField.add("15 Seconds", 930, "", false, false);
    @miShellLifeField.add("20 Seconds", 1240, "", false, false);
    @miShellLifeField.add("25 Seconds", 1550, "", false, false);
    @miShellLifeField.add("30 Seconds", 1860, "", false, false);
    @miShellLifeField.setData($game_values.shellttl, nil, nil);
    @miShellLifeField.setKey(game_values.shellttl);
		
    @miBlueBlockLifeField = MI_SelectField.new($spr_selectfield, 325, 360, "Life", 305, 105);
    @miBlueBlockLifeField.add("Unlimited", 0, "", false, false);
    @miBlueBlockLifeField.add("1 Second", 62, "", false, false);
    @miBlueBlockLifeField.add("2 Seconds", 124, "", false, false);
    @miBlueBlockLifeField.add("3 Seconds", 186, "", false, false);
    @miBlueBlockLifeField.add("4 Seconds", 248, "", false, false);
    @miBlueBlockLifeField.add("5 Seconds", 310, "", false, false);
    @miBlueBlockLifeField.add("6 Seconds", 372, "", false, false);
    @miBlueBlockLifeField.add("7 Seconds", 434, "", false, false);
    @miBlueBlockLifeField.add("8 Seconds", 496, "", false, false);
    @miBlueBlockLifeField.add("9 Seconds", 558, "", false, false);
    @miBlueBlockLifeField.add("10 Seconds", 620, "", false, false);
    @miBlueBlockLifeField.add("15 Seconds", 930, "", false, false);
    @miBlueBlockLifeField.add("20 Seconds", 1240, "", false, false);
    @miBlueBlockLifeField.add("25 Seconds", 1550, "", false, false);
    @miBlueBlockLifeField.add("30 Seconds", 1860, "", false, false);
    @miBlueBlockLifeField.setData($game_values.blueblockttl, nil, nil);
    @miBlueBlockLifeField.setKey(game_values.blueblockttl);
		
    @miProjectilesOptionsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miProjectilesOptionsMenuBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
		
    @miProjectilesOptionsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miProjectilesOptionsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miProjectilesOptionsMenuHeaderText = MI_Text.new("Projectile $ Weapon Options Menu", 320, 5, 0, 2, 1);
		
    @miFireballText = MI_Text.new("Fireball", 10, 50, 0, 2, 0);
    @miFeatherText = MI_Text.new("Feather", 10, 170, 0, 2, 0);
    @miBoomerangText = MI_Text.new("Boomerang", 10, 290, 0, 2, 0);
    @miHammerText = MI_Text.new("Hammer", 325, 50, 0, 2, 0);
    @miShellText = MI_Text.new("Shell", 325, 250, 0, 2, 0);
    @miBlueBlockText = MI_Text.new("Blue Block", 325, 330, 0, 2, 0);
		
    @mProjectilesOptionsMenu = UI_Menu.new
    @mProjectilesOptionsMenu.addControl(@miFireballLifeField, @miProjectilesOptionsMenuBackButton, @miFireballLimitField, nil, @miHammerLifeField);
    @mProjectilesOptionsMenu.addControl(@miFireballLimitField, @miFireballLifeField, @miFeatherJumpsField, nil, @miHammerDelayField);
			
    @mProjectilesOptionsMenu.addControl(@miFeatherJumpsField, @miFireballLimitField, @miFeatherLimitField, nil, @miHammerLimitField);
    @mProjectilesOptionsMenu.addControl(@miFeatherLimitField, @miFeatherJumpsField, @miBoomerangStyleField, nil, @miShellLifeField);
			
    @mProjectilesOptionsMenu.addControl(@miBoomerangStyleField, @miFeatherLimitField, @miBoomerangLifeField, nil, @miBlueBlockLifeField);
    @mProjectilesOptionsMenu.addControl(@miBoomerangLifeField, @miBoomerangStyleField, @miBoomerangLimitField, nil, @miBlueBlockLifeField);
    @mProjectilesOptionsMenu.addControl(@miBoomerangLimitField, @miBoomerangLifeField, @miHammerLifeField, nil, @miBlueBlockLifeField);
		
    @mProjectilesOptionsMenu.addControl(@miHammerLifeField, @miBoomerangLimitField, @miHammerDelayField, @miFireballLifeField, nil);
    @mProjectilesOptionsMenu.addControl(@miHammerDelayField, @miHammerLifeField, @miHammerOneKillField, @miFireballLimitField, nil);
    @mProjectilesOptionsMenu.addControl(@miHammerOneKillField, @miHammerDelayField, @miHammerLimitField, @miFireballLimitField, nil);
    @mProjectilesOptionsMenu.addControl(@miHammerLimitField, @miHammerOneKillField, @miShellLifeField, @miFeatherJumpsField, nil);
			
    @mProjectilesOptionsMenu.addControl(@miShellLifeField, @miHammerLimitField, @miBlueBlockLifeField, @miFeatherLimitField, nil);
    @mProjectilesOptionsMenu.addControl(@miBlueBlockLifeField, @miShellLifeField, @miProjectilesOptionsMenuBackButton, @miBoomerangLifeField, nil);
		
    @mProjectilesOptionsMenu.addControl(@miProjectilesOptionsMenuBackButton, @miBlueBlockLifeField, @miFireballLifeField, @miBlueBlockLifeField, nil);
		
    @mProjectilesOptionsMenu.addNonControl(@miFireballText);
    @mProjectilesOptionsMenu.addNonControl(@miFeatherText);
    @mProjectilesOptionsMenu.addNonControl(@miBoomerangText);
    @mProjectilesOptionsMenu.addNonControl(@miHammerText);
    @mProjectilesOptionsMenu.addNonControl(@miShellText);
    @mProjectilesOptionsMenu.addNonControl(@miBlueBlockText);
		
    @mProjectilesOptionsMenu.addNonControl(@miProjectilesOptionsMenuLeftHeaderBar);
    @mProjectilesOptionsMenu.addNonControl(@miProjectilesOptionsMenuRightHeaderBar);
    @mProjectilesOptionsMenu.addNonControl(@miProjectilesOptionsMenuHeaderText);
		
    @mProjectilesOptionsMenu.setHeadControl(@miFireballLifeField);
    @mProjectilesOptionsMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
		
		
    #ifdef _XBOX
    #***********************
    # Screen Settings
    #***********************
		
    #@miScreenResizeButton ;
    # 			@miScreenResizeButton = MI_Button.new($spr_selectfield, 120, 160, "Resize Screen", 400, 0);
    # 			@miScreenResizeButton.setCode(MENU_CODE_TO_SCREEN_RESIZE);
    # 		
    # 			@miScreenHardwareFilterField = MI_SelectField.new($spr_selectfield, 120, 200, "Screen Filter", 400, 180);
    # 			#miScreenHardwareFilterField.add("None", 0, "", false, false);
    # 			@miScreenHardwareFilterField.add("Point", 1, "", false, false);
    # 			@miScreenHardwareFilterField.add("Bilinear", 2, "", false, false);
    # 			@miScreenHardwareFilterField.add("Trilinear", 3, "", false, false);
    # 			@miScreenHardwareFilterField.add("Anisotrpoic", 4, "", false, false);
    # 			@miScreenHardwareFilterField.add("Quincunx", 5, "", false, false);
    # 			@miScreenHardwareFilterField.add("Gaussian Cubic", 6, "", false, false);
    # 			@miScreenHardwareFilterField.setData($game_values.hardwarefilter, nil, nil);
    # 			@miScreenHardwareFilterField.setKey(game_values.hardwarefilter);
    # 			@miScreenHardwareFilterField.setItemChangedCode(MENU_CODE_SCREEN_FILTER_CHANGED);
    # 		
    # 			@miScreenFlickerFilterField = MI_SliderField.new($spr_selectfield, $menu_slider_bar, 120, 240, "Flicker Filter", 400, 180, 380);
    # 			@miScreenFlickerFilterField.add("0", 0, "", false, false);
    # 			@miScreenFlickerFilterField.add("1", 1, "", false, false);
    # 			@miScreenFlickerFilterField.add("2", 2, "", false, false);
    # 			@miScreenFlickerFilterField.add("3", 3, "", false, false);
    # 			@miScreenFlickerFilterField.add("4", 4, "", false, false);
    # 			@miScreenFlickerFilterField.add("5", 5, "", false, false);
    # 			@miScreenFlickerFilterField.setData($game_values.flickerfilter, nil, nil);
    # 			@miScreenFlickerFilterField.setKey(game_values.flickerfilter);
    # 			@miScreenFlickerFilterField.setNoWrap(true);
    # 			@miScreenFlickerFilterField.setItemChangedCode(MENU_CODE_SCREEN_SETTINGS_CHANGED);
    # 		
    # 			@miScreenSoftFilterField = MI_SelectField.new($spr_selectfield, 120, 280, "Soften Filter", 400, 180);
    # 			@miScreenSoftFilterField.add("Off", 0, "", false, false);
    # 			@miScreenSoftFilterField.add("On", 1, "", true, false);
    # 			@miScreenSoftFilterField.setData($game_values.softfilter, nil, nil);
    # 			@miScreenSoftFilterField.setKey(game_values.softfilter);
    # 			@miScreenSoftFilterField.setAutoAdvance(true);
    # 			@miScreenSoftFilterField.setItemChangedCode(MENU_CODE_SCREEN_SETTINGS_CHANGED);
    # 		
    # 			
    # # 			@miScreenAspectRatioField = MI_SelectField.new($spr_selectfield, 120, 300, "10x11 Aspect", 400, 180);
    # # 			@miScreenAspectRatioField.add("Off", 0, "", false, false);
    # # 			@miScreenAspectRatioField.add("On", 1, "", true, false);
    # # 			@miScreenAspectRatioField.setData(nil, nil, $game_values.aspectratio10x11);
    # # 			@miScreenAspectRatioField.setKey(game_values.aspectratio10x11 ? 1 : 0);
    # # 			@miScreenAspectRatioField.setAutoAdvance(true);
    # # 			@miScreenAspectRatioField.setItemChangedCode(MENU_CODE_SCREEN_SETTINGS_CHANGED);
    # 			
    # 		
    # 			@miScreenSettingsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    # 			@miScreenSettingsMenuBackButton.setCode(MENU_CODE_BACK_TO_GRAPHIC_OPTIONS_MENU);
    # 		
    # 			@miScreenSettingsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    # 			@miScreenSettingsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    # 			@miScreenSettingsMenuHeaderText = MI_Text.new("Screen Settings Menu", 320, 5, 0, 2, 1);
    # 		
    # 			@mScreenSettingsMenu.addControl(@miScreenResizeButton, @miScreenSettingsMenuBackButton, @miScreenHardwareFilterField, nil, @miScreenSettingsMenuBackButton);
    # 			@mScreenSettingsMenu.addControl(@miScreenHardwareFilterField, @miScreenResizeButton, @miScreenFlickerFilterField, nil, @miScreenSettingsMenuBackButton);
    # 			@mScreenSettingsMenu.addControl(@miScreenFlickerFilterField, @miScreenHardwareFilterField, @miScreenSoftFilterField, nil, @miScreenSettingsMenuBackButton);
    # 			@mScreenSettingsMenu.addControl(@miScreenSoftFilterField, @miScreenFlickerFilterField, @miScreenSettingsMenuBackButton, nil, @miScreenSettingsMenuBackButton);
    # 			#mScreenSettingsMenu.addControl(@miScreenAspectRatioField, @miScreenSoftFilterField, @miScreenSettingsMenuBackButton, nil, @miScreenSettingsMenuBackButton);
    # 			@mScreenSettingsMenu.addControl(@miScreenSettingsMenuBackButton, @miScreenSoftFilterField, @miScreenResizeButton, @miScreenSoftFilterField, nil);
    # 		
    # 			@mScreenSettingsMenu.setHeadControl(@miScreenResizeButton);
    # 			@mScreenSettingsMenu.setCancelCode(MENU_CODE_BACK_TO_GRAPHIC_OPTIONS_MENU);
    # 		
    # 			#***********************
    # 			# Screen Resize
    # 			#***********************
    # 		
    # 			@miScreenResize = new MI_ScreenResize();
    # 		
    # 			@mScreenResizeMenu.addControl(@miScreenResize, nil, nil, nil, nil);
    # 			@mScreenResizeMenu.setHeadControl(@miScreenResize);
    # 			@mScreenResizeMenu.setCancelCode(MENU_CODE_BACK_TO_SCREEN_SETTINGS_MENU);
    #endif
			
    #***********************
    # Game Settings
    #***********************
			
    @miSettingsStartButton = MI_Button.new($spr_selectfield, 70, 45, "Start", 500, 0);
    @miSettingsStartButton.setCode(MENU_CODE_START_GAME);
		
    @miModeField = MI_ImageSelectField.new($spr_selectfield, $menu_mode_small, 70, 85, "Mode", 500, 120, 16, 16);
			
    GAMEMODE_LAST.times do |iGameMode|
      @miModeField.add($gamemodes[iGameMode].getModeName(), iGameMode, "", false, false);
    end
    @miModeField.setData($currentgamemode, nil, nil);
    @miModeField.setKey(0);
    @miModeField.setItemChangedCode(MENU_CODE_MODE_CHANGED);
    gamemodes = $gamemodes
    @miGoalField = []
    GAMEMODE_LAST.times do |iGameMode|
      @miGoalField[iGameMode] = MI_SelectField.new($spr_selectfield, 70, 125, gamemodes[iGameMode].getGoalName(), 352, 120);
				
      @miGoalField[iGameMode].show(iGameMode == 0);
				
      GAMEMODE_NUM_OPTIONS.times do |iGameModeOption|
        option = $gamemodes[iGameMode].getOptions()[iGameModeOption];
					
        @miGoalField[iGameMode].add(option.szName, option.iValue, "", false, false);
      end
		
      @miGoalField[iGameMode].setData("$gamemodes[#{iGameMode}].goal", nil, nil);
      @miGoalField[iGameMode].setKey(gamemodes[iGameMode].goal);
    end
		
    @miModeSettingsButton = MI_Button.new($spr_selectfield, 430, 125, "Settings", 140, 0);
    @miModeSettingsButton.setCode(MENU_CODE_TO_MODE_SETTINGS_MENU);
		
    @miMapField = MI_MapField.new($spr_selectfield, 70, 165, "Map", 500, 120, true);
    szCurrentMapName = @miMapField.getMapName();
		
    @miMapFiltersButton = MI_Button.new($spr_selectfield, 430, 205, "Filters", 140, 0);
    @miMapFiltersButton.setCode(MENU_CODE_TO_MAP_FILTERS);
		
    @miMapFiltersOnImage = MI_Image.new($menu_map_filter, 530, 213, 0, 48, 16, 16, 1, 1, 0);
    @miMapFiltersOnImage.show(false);
		
    @miMapThumbnailsButton = MI_Button.new($spr_selectfield, 430, 245, "Thumbs", 140, 0);
    @miMapThumbnailsButton.setCode(MENU_CODE_TO_MAP_BROWSER_THUMBNAILS);
		
    @miMapFilterScroll = MI_MapFilterScroll.new($menu_plain_field, 120, 72, 400, 9);
    @miMapFilterScroll.setAutoModify(true);
    @miMapFilterScroll.show(false);
			
    #Add auto @map filters
    NUM_AUTO_FILTERS.times do |iFilter|
      @miMapFilterScroll.add($g_szAutoFilterNames[iFilter], $g_iAutoFilterIcons[iFilter]);
    end
		
    
    $filterslist.getCount().times do |iFilter|
      szTemp = getNameFromFileName($filterslist.getIndex(iFilter));
      @miMapFilterScroll.add(szTemp, game_values.piFilterIcons[NUM_AUTO_FILTERS + iFilter]);
      
    end
    
    #    $filterslist.getCount().times do |iFilter|
    #      szTemp = getNameFromFileName($filterslist.getIndex(iFilter));
    #      @miMapFilterScroll.add(szTemp, game_values.piFilterIcons[NUM_AUTO_FILTERS + iFilter]);
    #      
    #    end
    
			
		
    @miGameSettingsLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miGameSettingsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miGameSettingsMenuHeaderText = MI_Text.new("Single Game Menu", 320, 5, 0, 2, 1);
		
		
    #Exit tournament dialog box
    @miGameSettingsExitDialogImage = MI_Image.new($spr_dialog, 224, 176, 0, 0, 192, 128, 1, 1, 0);
    @miGameSettingsExitDialogExitText = MI_Text.new("Exit", 320, 195, 0, 2, 1);
    @miGameSettingsExitDialogTournamentText = MI_Text.new("Tournament", 320, 220, 0, 2, 1);
    @miGameSettingsExitDialogYesButton = MI_Button.new($spr_selectfield, 235, 250, "Yes", 80, 1);
    @miGameSettingsExitDialogNoButton = MI_Button.new($spr_selectfield, 325, 250, "No", 80, 1);
			
    @miGameSettingsExitDialogYesButton.setCode(MENU_CODE_EXIT_TOURNAMENT_YES);
    @miGameSettingsExitDialogNoButton.setCode(MENU_CODE_EXIT_TOURNAMENT_NO);
		
    @miGameSettingsExitDialogImage.show(false);
    @miGameSettingsExitDialogTournamentText.show(false);
    @miGameSettingsExitDialogExitText.show(false);
    @miGameSettingsExitDialogYesButton.show(false);
    @miGameSettingsExitDialogNoButton.show(false);
			
    @mGameSettingsMenu = UI_Menu.new
    @mGameSettingsMenu.addControl(@miSettingsStartButton, @miMapThumbnailsButton, @miModeField, nil, nil);
    @mGameSettingsMenu.addControl(@miModeField, @miSettingsStartButton, @miGoalField[0], nil, nil);
    @mGameSettingsMenu.addControl(@miGoalField[0], @miModeField, @miGoalField[1], nil, @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[1], @miGoalField[0], @miGoalField[2], @miGoalField[0], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[2], @miGoalField[1], @miGoalField[3], @miGoalField[1], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[3], @miGoalField[2], @miGoalField[4], @miGoalField[2], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[4], @miGoalField[3], @miGoalField[5], @miGoalField[3], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[5], @miGoalField[4], @miGoalField[6], @miGoalField[4], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[6], @miGoalField[5], @miGoalField[7], @miGoalField[5], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[7], @miGoalField[6], @miGoalField[8], @miGoalField[6], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[8], @miGoalField[7], @miGoalField[9], @miGoalField[7], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[9], @miGoalField[8], @miGoalField[10], @miGoalField[8], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[10], @miGoalField[9], @miGoalField[11], @miGoalField[9], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[11], @miGoalField[10], @miGoalField[12], @miGoalField[10], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[12], @miGoalField[11], @miGoalField[13], @miGoalField[11], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[13], @miGoalField[12], @miGoalField[14], @miGoalField[12], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[14], @miGoalField[13], @miGoalField[15], @miGoalField[13], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[15], @miGoalField[14], @miGoalField[16], @miGoalField[14], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miGoalField[16], @miGoalField[15], @miMapField, @miGoalField[15], @miModeSettingsButton);
    @mGameSettingsMenu.addControl(@miModeSettingsButton, @miModeField, @miMapField, @miGoalField[16], nil);
    @mGameSettingsMenu.addControl(@miMapField, @miGoalField[16], @miMapFiltersButton, nil, nil);
    @mGameSettingsMenu.addControl(@miMapFiltersButton, @miMapField, @miMapThumbnailsButton, nil, nil);
    @mGameSettingsMenu.addControl(@miMapThumbnailsButton, @miMapFiltersButton, @miSettingsStartButton, nil, nil);
		
    @mGameSettingsMenu.addControl(@miMapFilterScroll, nil, nil, nil, nil);
			
    @mGameSettingsMenu.addNonControl(@miGameSettingsLeftHeaderBar);
    @mGameSettingsMenu.addNonControl(@miGameSettingsMenuRightHeaderBar);
    @mGameSettingsMenu.addNonControl(@miGameSettingsMenuHeaderText);
			
    @mGameSettingsMenu.addNonControl(@miGameSettingsExitDialogImage);
    @mGameSettingsMenu.addNonControl(@miGameSettingsExitDialogExitText);
    @mGameSettingsMenu.addNonControl(@miGameSettingsExitDialogTournamentText);
		
    @mGameSettingsMenu.addNonControl(@miMapFiltersOnImage);
		
    @mGameSettingsMenu.addControl(@miGameSettingsExitDialogYesButton, nil, nil, nil, @miGameSettingsExitDialogNoButton);
    @mGameSettingsMenu.addControl(@miGameSettingsExitDialogNoButton, nil, nil, @miGameSettingsExitDialogYesButton, nil);
		
    @mGameSettingsMenu.setHeadControl(@miSettingsStartButton);
			
    @mGameSettingsMenu.setCancelCode(MENU_CODE_BACK_TEAM_SELECT_MENU);
		
    #***********************
    # Map Filter Edit
    #***********************
		
    @miMapBrowser = MI_MapBrowser.new;
    @miMapBrowser.setAutoModify(true);
		
    @mMapFilterEditMenu = UI_Menu.new
    @mMapFilterEditMenu.addControl(@miMapBrowser, nil, nil, nil, nil);
    @mMapFilterEditMenu.setHeadControl(@miMapBrowser);
    @mMapFilterEditMenu.setCancelCode(MENU_CODE_MAP_BROWSER_EXIT);
		
    #***********************
    # Tour Stop
    #***********************
			
    @miTourStop = MI_TourStop.new(70, 45);
			
    #Exit tour dialog box
    @miTourStopExitDialogImage = MI_Image.new($spr_dialog, 224, 176, 0, 0, 192, 128, 1, 1, 0);
    @miTourStopExitDialogExitTourText = MI_Text.new("Exit Tour", 320, 205, 0, 2, 1);
		
    @miTourStopExitDialogYesButton = MI_Button.new($spr_selectfield, 235, 250, "Yes", 80, 1);
    @miTourStopExitDialogNoButton = MI_Button.new($spr_selectfield, 325, 250, "No", 80, 1);
			
    @miTourStopExitDialogYesButton.setCode(MENU_CODE_EXIT_TOUR_YES);
    @miTourStopExitDialogNoButton.setCode(MENU_CODE_EXIT_TOUR_NO);
		
    @miTourStopExitDialogImage.show(false);
    @miTourStopExitDialogExitTourText.show(false);
    @miTourStopExitDialogYesButton.show(false);
    @miTourStopExitDialogNoButton.show(false);
			
    @mTourStopMenu = UI_Menu.new
    @mTourStopMenu.addControl(@miTourStop, nil, nil, nil, nil);
		
    @mTourStopMenu.addNonControl(@miTourStopExitDialogImage);
    @mTourStopMenu.addNonControl(@miTourStopExitDialogExitTourText);
		
    @mTourStopMenu.addControl(@miTourStopExitDialogYesButton, nil, nil, nil, @miTourStopExitDialogNoButton);
    @mTourStopMenu.addControl(@miTourStopExitDialogNoButton, nil, nil, @miTourStopExitDialogYesButton, nil);
		
    @mTourStopMenu.setHeadControl(@miTourStop);
    @mTourStopMenu.setCancelCode(MENU_CODE_BACK_TEAM_SELECT_MENU);
		
		
    #***********************
    # Jail Mode Settings
    #***********************
		
    @miJailModeTimeFreeField = MI_SelectField.new($spr_selectfield, 120, 200, "Free Timer", 400, 180);
    @miJailModeTimeFreeField.add("None", 1, "", false, false);
    @miJailModeTimeFreeField.add("5 Seconds", 310, "", false, false);
    @miJailModeTimeFreeField.add("10 Seconds", 620, "", false, false);
    @miJailModeTimeFreeField.add("15 Seconds", 930, "", false, false);
    @miJailModeTimeFreeField.add("20 Seconds", 1240, "", false, false);
    @miJailModeTimeFreeField.add("25 Seconds", 1550, "", false, false);
    @miJailModeTimeFreeField.add("30 Seconds", 1860, "", false, false);
    @miJailModeTimeFreeField.add("35 Seconds", 2170, "", false, false);
    @miJailModeTimeFreeField.add("40 Seconds", 2480, "", false, false);
    @miJailModeTimeFreeField.add("45 Seconds", 2790, "", false, false);
    @miJailModeTimeFreeField.add("50 Seconds", 3100, "", false, false);
    @miJailModeTimeFreeField.add("55 Seconds", 3410, "", false, false);
    @miJailModeTimeFreeField.add("60 Seconds", 3720, "", false, false);
    @miJailModeTimeFreeField.setData($game_values.gamemodesettings.jail.timetofree, nil, nil);
    @miJailModeTimeFreeField.setKey(game_values.gamemodesettings.jail.timetofree);
		
    @miJailModeTagFreeField = MI_SelectField.new($spr_selectfield, 120, 240, "Tag Free", 400, 180);
    @miJailModeTagFreeField.add("Off", 0, "", false, false);
    @miJailModeTagFreeField.add("On", 1, "", true, false);
    @miJailModeTagFreeField.setData(nil, nil, $game_values.gamemodesettings.jail.tagfree);
    @miJailModeTagFreeField.setKey(game_values.gamemodesettings.jail.tagfree ? 1 : 0);
    @miJailModeTagFreeField.setAutoAdvance(true);
		
    @miJailModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miJailModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miJailModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miJailModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miJailModeHeaderText = MI_Text.new("Jail Mode Menu", 320, 5, 0, 2, 1);
    @mModeSettingsMenu = []
    17.times do |i|
      @mModeSettingsMenu[i] = UI_Menu.new
    end
		   
    @mModeSettingsMenu[3].addControl(@miJailModeTimeFreeField, @miJailModeBackButton, @miJailModeTagFreeField, nil, @miJailModeBackButton);
    @mModeSettingsMenu[3].addControl(@miJailModeTagFreeField, @miJailModeTimeFreeField, @miJailModeBackButton, nil, @miJailModeBackButton);
    @mModeSettingsMenu[3].addControl(@miJailModeBackButton, @miJailModeTagFreeField, @miJailModeTimeFreeField, @miJailModeTagFreeField, nil);
			
    @mModeSettingsMenu[3].addNonControl(@miJailModeLeftHeaderBar);
    @mModeSettingsMenu[3].addNonControl(@miJailModeRightHeaderBar);
    @mModeSettingsMenu[3].addNonControl(@miJailModeHeaderText);
			
    @mModeSettingsMenu[3].setHeadControl(@miJailModeTimeFreeField);
    @mModeSettingsMenu[3].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
			
    #***********************
    # Coins Mode Settings
    #***********************
		
    @miCoinModePenaltyField = MI_SelectField.new($spr_selectfield, 120, 200, "Penalty", 400, 180);
    @miCoinModePenaltyField.add("Off", 0, "", false, false);
    @miCoinModePenaltyField.add("On", 1, "", true, false);
    @miCoinModePenaltyField.setData(nil, nil, $game_values.gamemodesettings.coins.penalty);
    @miCoinModePenaltyField.setKey(game_values.gamemodesettings.coins.penalty ? 1 : 0);
    @miCoinModePenaltyField.setAutoAdvance(true);
		
    @miCoinModeQuantityField = MI_SelectField.new($spr_selectfield, 120, 240, "Quantity", 400, 180);
    @miCoinModeQuantityField.add("1", 1, "", false, false);
    @miCoinModeQuantityField.add("2", 2, "", false, false);
    @miCoinModeQuantityField.add("3", 3, "", false, false);
    @miCoinModeQuantityField.add("4", 4, "", false, false);
    @miCoinModeQuantityField.add("5", 5, "", false, false);
    @miCoinModeQuantityField.setData($game_values.gamemodesettings.coins.quantity, nil, nil);
    @miCoinModeQuantityField.setKey(game_values.gamemodesettings.coins.quantity);
		
    @miCoinModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miCoinModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miCoinModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miCoinModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miCoinModeHeaderText = MI_Text.new("Coin Collection Mode Menu", 320, 5, 0, 2, 1);
		  
    @mModeSettingsMenu[4].addControl(@miCoinModePenaltyField, @miCoinModeBackButton, @miCoinModeQuantityField, nil, @miCoinModeBackButton);
    @mModeSettingsMenu[4].addControl(@miCoinModeQuantityField, @miCoinModePenaltyField, @miCoinModeBackButton, nil, @miCoinModeBackButton);
    @mModeSettingsMenu[4].addControl(@miCoinModeBackButton, @miCoinModeQuantityField, @miCoinModePenaltyField, @miCoinModeQuantityField, nil);
			
    @mModeSettingsMenu[4].addNonControl(@miCoinModeLeftHeaderBar);
    @mModeSettingsMenu[4].addNonControl(@miCoinModeRightHeaderBar);
    @mModeSettingsMenu[4].addNonControl(@miCoinModeHeaderText);
			
    @mModeSettingsMenu[4].setHeadControl(@miCoinModePenaltyField);
    @mModeSettingsMenu[4].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
			
    #***********************
    # Flag Mode Settings
    #***********************
		
    @miFlagModeSpeedField = MI_SliderField.new($spr_selectfield, $menu_slider_bar, 120, 140, "Speed", 400, 180, 380);
    @miFlagModeSpeedField.add("0", 0, "", false, false);
    @miFlagModeSpeedField.add("1", 1, "", false, false);
    @miFlagModeSpeedField.add("2", 2, "", false, false);
    @miFlagModeSpeedField.add("3", 3, "", false, false);
    @miFlagModeSpeedField.add("4", 4, "", false, false);
    @miFlagModeSpeedField.add("5", 5, "", false, false);
    @miFlagModeSpeedField.add("6", 6, "", false, false);
    @miFlagModeSpeedField.add("7", 7, "", false, false);
    @miFlagModeSpeedField.add("8", 8, "", false, false);
    @miFlagModeSpeedField.setData($game_values.gamemodesettings.flag.speed, nil, nil);
    @miFlagModeSpeedField.setKey(game_values.gamemodesettings.flag.speed);
    @miFlagModeSpeedField.setNoWrap(true);
		
    @miFlagModeTouchReturnField = MI_SelectField.new($spr_selectfield, 120, 180, "Touch Return", 400, 180);
    @miFlagModeTouchReturnField.add("Off", 0, "", false, false);
    @miFlagModeTouchReturnField.add("On", 1, "", true, false);
    @miFlagModeTouchReturnField.setData(nil, nil, $game_values.gamemodesettings.flag.touchreturn);
    @miFlagModeTouchReturnField.setKey(game_values.gamemodesettings.flag.touchreturn ? 1 : 0);
    @miFlagModeTouchReturnField.setAutoAdvance(true);
		
    @miFlagModePointMoveField = MI_SelectField.new($spr_selectfield, 120, 220, "Point Move", 400, 180);
    @miFlagModePointMoveField.add("Off", 0, "", false, false);
    @miFlagModePointMoveField.add("On", 1, "", true, false);
    @miFlagModePointMoveField.setData(nil, nil, $game_values.gamemodesettings.flag.pointmove);
    @miFlagModePointMoveField.setKey(game_values.gamemodesettings.flag.pointmove ? 1 : 0);
    @miFlagModePointMoveField.setAutoAdvance(true);
		
    @miFlagModeAutoReturnField = MI_SelectField.new($spr_selectfield, 120, 260, "Auto Return", 400, 180);
    @miFlagModeAutoReturnField.add("None", 0, "", false, false);
    @miFlagModeAutoReturnField.add("5 Seconds", 310, "", false, false);
    @miFlagModeAutoReturnField.add("10 Seconds", 620, "", false, false);
    @miFlagModeAutoReturnField.add("15 Seconds", 930, "", false, false);
    @miFlagModeAutoReturnField.add("20 Seconds", 1240, "", false, false);
    @miFlagModeAutoReturnField.add("25 Seconds", 1550, "", false, false);
    @miFlagModeAutoReturnField.add("30 Seconds", 1860, "", false, false);
    @miFlagModeAutoReturnField.add("35 Seconds", 2170, "", false, false);
    @miFlagModeAutoReturnField.add("40 Seconds", 2480, "", false, false);
    @miFlagModeAutoReturnField.add("45 Seconds", 2790, "", false, false);
    @miFlagModeAutoReturnField.add("50 Seconds", 3100, "", false, false);
    @miFlagModeAutoReturnField.add("55 Seconds", 3410, "", false, false);
    @miFlagModeAutoReturnField.add("60 Seconds", 3720, "", false, false);
    @miFlagModeAutoReturnField.setData($game_values.gamemodesettings.flag.autoreturn, nil, nil);
    @miFlagModeAutoReturnField.setKey(game_values.gamemodesettings.flag.autoreturn);
		
    @miFlagModeHomeScoreField = MI_SelectField.new($spr_selectfield, 120, 300, "Need Home", 400, 180);
    @miFlagModeHomeScoreField.add("Off", 0, "", false, false);
    @miFlagModeHomeScoreField.add("On", 1, "", true, false);
    @miFlagModeHomeScoreField.setData(nil, nil, $game_values.gamemodesettings.flag.homescore);
    @miFlagModeHomeScoreField.setKey(game_values.gamemodesettings.flag.homescore ? 1 : 0);
    @miFlagModeHomeScoreField.setAutoAdvance(true);
			
    @miFlagModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miFlagModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miFlagModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miFlagModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miFlagModeHeaderText = MI_Text.new("Capture The Flag Mode Menu", 320, 5, 0, 2, 1);
		
		  
    @mModeSettingsMenu[7].addControl(@miFlagModeSpeedField, @miFlagModeBackButton, @miFlagModeTouchReturnField, nil, @miFlagModeBackButton);
    @mModeSettingsMenu[7].addControl(@miFlagModeTouchReturnField, @miFlagModeSpeedField, @miFlagModePointMoveField, nil, @miFlagModeBackButton);
    @mModeSettingsMenu[7].addControl(@miFlagModePointMoveField, @miFlagModeTouchReturnField, @miFlagModeAutoReturnField, nil, @miFlagModeBackButton);
    @mModeSettingsMenu[7].addControl(@miFlagModeAutoReturnField, @miFlagModePointMoveField, @miFlagModeHomeScoreField, nil, @miFlagModeBackButton);
    @mModeSettingsMenu[7].addControl(@miFlagModeHomeScoreField, @miFlagModeAutoReturnField, @miFlagModeBackButton, nil, @miFlagModeBackButton);
			
    @mModeSettingsMenu[7].addControl(@miFlagModeBackButton, @miFlagModeHomeScoreField, @miFlagModeSpeedField, @miFlagModeHomeScoreField, nil);
			
    @mModeSettingsMenu[7].addNonControl(@miFlagModeLeftHeaderBar);
    @mModeSettingsMenu[7].addNonControl(@miFlagModeRightHeaderBar);
    @mModeSettingsMenu[7].addNonControl(@miFlagModeHeaderText);
			
    @mModeSettingsMenu[7].setHeadControl(@miFlagModeSpeedField);
    @mModeSettingsMenu[7].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
		
    #***********************
    # Chicken Mode Settings
    #***********************
		
    @miChickenModeTagOnTouchField = MI_SelectField.new($spr_selectfield, 120, 220, "Show Target", 400, 180);
    @miChickenModeTagOnTouchField.add("Off", 0, "", false, false);
    @miChickenModeTagOnTouchField.add("On", 1, "", true, false);
    @miChickenModeTagOnTouchField.setData(nil, nil, $game_values.gamemodesettings.chicken.usetarget);
    @miChickenModeTagOnTouchField.setKey(game_values.gamemodesettings.chicken.usetarget ? 1 : 0);
    @miChickenModeTagOnTouchField.setAutoAdvance(true);
		
    @miChickenModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miChickenModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miChickenModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miChickenModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miChickenModeHeaderText = MI_Text.new("Chicken Mode Menu", 320, 5, 0, 2, 1);
		
		
    @mModeSettingsMenu[8].addControl(@miChickenModeTagOnTouchField, @miChickenModeBackButton, @miChickenModeBackButton, nil, @miChickenModeBackButton);
    @mModeSettingsMenu[8].addControl(@miChickenModeBackButton, @miChickenModeTagOnTouchField, @miChickenModeTagOnTouchField, @miChickenModeTagOnTouchField, nil);
			
    @mModeSettingsMenu[8].addNonControl(@miChickenModeLeftHeaderBar);
    @mModeSettingsMenu[8].addNonControl(@miChickenModeRightHeaderBar);
    @mModeSettingsMenu[8].addNonControl(@miChickenModeHeaderText);
			
    @mModeSettingsMenu[8].setHeadControl(@miChickenModeTagOnTouchField);
    @mModeSettingsMenu[8].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
    #***********************
    # Tag Mode Settings
    #***********************
		
    @miTagModeTagOnTouchField = MI_SelectField.new($spr_selectfield, 120, 220, "Touch Tag", 400, 180);
    @miTagModeTagOnTouchField.add("Off", 0, "", false, false);
    @miTagModeTagOnTouchField.add("On", 1, "", true, false);
    @miTagModeTagOnTouchField.setData(nil, nil, $game_values.gamemodesettings.tag.tagontouch);
    @miTagModeTagOnTouchField.setKey(game_values.gamemodesettings.tag.tagontouch ? 1 : 0);
    @miTagModeTagOnTouchField.setAutoAdvance(true);
		
    @miTagModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miTagModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miTagModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miTagModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miTagModeHeaderText = MI_Text.new("Tag Mode Menu", 320, 5, 0, 2, 1);
		
		
    @mModeSettingsMenu[9].addControl(@miTagModeTagOnTouchField, @miTagModeBackButton, @miTagModeBackButton, nil, @miTagModeBackButton);
    @mModeSettingsMenu[9].addControl(@miTagModeBackButton, @miTagModeTagOnTouchField, @miTagModeTagOnTouchField, @miTagModeTagOnTouchField, nil);
			
    @mModeSettingsMenu[9].addNonControl(@miTagModeLeftHeaderBar);
    @mModeSettingsMenu[9].addNonControl(@miTagModeRightHeaderBar);
    @mModeSettingsMenu[9].addNonControl(@miTagModeHeaderText);
			
    @mModeSettingsMenu[9].setHeadControl(@miTagModeTagOnTouchField);
    @mModeSettingsMenu[9].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
		
    #***********************
    # Star Mode Settings
    #***********************
		
    @miStarModeTimeField = MI_SelectField.new($spr_selectfield, 120, 200, "Time", 400, 180);
    @miStarModeTimeField.add("5 Seconds", 5, "", false, false);
    @miStarModeTimeField.add("10 Seconds", 10, "", false, false);
    @miStarModeTimeField.add("15 Seconds", 15, "", false, false);
    @miStarModeTimeField.add("20 Seconds", 20, "", false, false);
    @miStarModeTimeField.add("25 Seconds", 25, "", false, false);
    @miStarModeTimeField.add("30 Seconds", 30, "", false, false);
    @miStarModeTimeField.add("35 Seconds", 35, "", false, false);
    @miStarModeTimeField.add("40 Seconds", 40, "", false, false);
    @miStarModeTimeField.add("45 Seconds", 45, "", false, false);
    @miStarModeTimeField.add("50 Seconds", 50, "", false, false);
    @miStarModeTimeField.add("55 Seconds", 55, "", false, false);
    @miStarModeTimeField.add("60 Seconds", 60, "", false, false);
    @miStarModeTimeField.setData($game_values.gamemodesettings.star.time, nil, nil);
    @miStarModeTimeField.setKey(game_values.gamemodesettings.star.time);
		
    @miStarModeShineField = MI_SelectField.new($spr_selectfield, 120, 240, "Star Type", 400, 180);
    @miStarModeShineField.add("Ztar", 0, "", false, false);
    @miStarModeShineField.add("Shine", 1, "", true, false);
    @miStarModeShineField.setData(nil, nil, $game_values.gamemodesettings.star.shine);
    @miStarModeShineField.setKey(game_values.gamemodesettings.star.shine ? 1 : 0);
    @miStarModeShineField.setAutoAdvance(true);
		
    @miStarModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miStarModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miStarModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miStarModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miStarModeHeaderText = MI_Text.new("Star Mode Menu", 320, 5, 0, 2, 1);
		
    @mModeSettingsMenu[10].addControl(@miStarModeTimeField, @miStarModeBackButton, @miStarModeShineField, nil, @miStarModeBackButton);
    @mModeSettingsMenu[10].addControl(@miStarModeShineField, @miStarModeTimeField, @miStarModeBackButton, nil, @miStarModeBackButton);
    @mModeSettingsMenu[10].addControl(@miStarModeBackButton, @miStarModeShineField, @miStarModeTimeField, @miStarModeShineField, nil);
			
    @mModeSettingsMenu[10].addNonControl(@miStarModeLeftHeaderBar);
    @mModeSettingsMenu[10].addNonControl(@miStarModeRightHeaderBar);
    @mModeSettingsMenu[10].addNonControl(@miStarModeHeaderText);
			
    @mModeSettingsMenu[10].setHeadControl(@miStarModeTimeField);
    @mModeSettingsMenu[10].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
			
		
    #***********************
    # Domination Mode Settings
    #***********************
		
    @miDominationModeQuantityField = MI_SelectField.new($spr_selectfield, 120, 120, "Quantity", 400, 180);
    @miDominationModeQuantityField.add("1 Base", 1, "", false, false);
    @miDominationModeQuantityField.add("2 Bases", 2, "", false, false);
    @miDominationModeQuantityField.add("3 Bases", 3, "", false, false);
    @miDominationModeQuantityField.add("4 Bases", 4, "", false, false);
    @miDominationModeQuantityField.add("5 Bases", 5, "", false, false);
    @miDominationModeQuantityField.add("6 Bases", 6, "", false, false);
    @miDominationModeQuantityField.add("7 Bases", 7, "", false, false);
    @miDominationModeQuantityField.add("8 Bases", 8, "", false, false);
    @miDominationModeQuantityField.add("9 Bases", 9, "", false, false);
    @miDominationModeQuantityField.add("10 Bases", 10, "", false, false);
    @miDominationModeQuantityField.add("# Players - 1", 11, "", false, false);
    @miDominationModeQuantityField.add("# Players", 12, "", false, false);
    @miDominationModeQuantityField.add("# Players + 1", 13, "", false, false);
    @miDominationModeQuantityField.add("# Players + 2", 14, "", false, false);
    @miDominationModeQuantityField.add("# Players + 3", 15, "", false, false);
    @miDominationModeQuantityField.add("# Players + 4", 16, "", false, false);
    @miDominationModeQuantityField.add("# Players + 5", 17, "", false, false);
    @miDominationModeQuantityField.add("# Players + 6", 18, "", false, false);
    @miDominationModeQuantityField.add("2x Players - 3", 19, "", false, false);
    @miDominationModeQuantityField.add("2x Players - 2", 20, "", false, false);
    @miDominationModeQuantityField.add("2x Players - 1", 21, "", false, false);
    @miDominationModeQuantityField.add("2x Players", 22, "", false, false);
    @miDominationModeQuantityField.add("2x Players + 1", 23, "", false, false);
    @miDominationModeQuantityField.add("2x Players + 2", 24, "", false, false);
    @miDominationModeQuantityField.setData($game_values.gamemodesettings.domination.quantity, nil, nil);
    @miDominationModeQuantityField.setKey(game_values.gamemodesettings.domination.quantity);
		
    @miDominationModeRelocateFrequencyField = MI_SelectField.new($spr_selectfield, 120, 160, "Relocate", 400, 180);
    @miDominationModeRelocateFrequencyField.add("Never", 0, "", false, false);
    @miDominationModeRelocateFrequencyField.add("5 Seconds", 310, "", false, false);
    @miDominationModeRelocateFrequencyField.add("10 Seconds", 620, "", false, false);
    @miDominationModeRelocateFrequencyField.add("15 Seconds", 930, "", false, false);
    @miDominationModeRelocateFrequencyField.add("20 Seconds", 1240, "", false, false);
    @miDominationModeRelocateFrequencyField.add("30 Seconds", 1860, "", false, false);
    @miDominationModeRelocateFrequencyField.add("45 Seconds", 2790, "", false, false);
    @miDominationModeRelocateFrequencyField.add("1 Minute", 3720, "", false, false);
    @miDominationModeRelocateFrequencyField.add("1.5 Minutes", 5580, "", false, false);
    @miDominationModeRelocateFrequencyField.add("2 Minutes", 7440, "", false, false);
    @miDominationModeRelocateFrequencyField.add("2.5 Minutes", 9300, "", false, false);
    @miDominationModeRelocateFrequencyField.add("3 Minutes", 11160, "", false, false);
    @miDominationModeRelocateFrequencyField.setData($game_values.gamemodesettings.domination.relocationfrequency, nil, nil);
    @miDominationModeRelocateFrequencyField.setKey(game_values.gamemodesettings.domination.relocationfrequency);
		
    @miDominationModeDeathText = MI_Text.new("On Death", 120, 210, 0, 2, 0);
		
    @miDominationModeLoseOnDeathField = MI_SelectField.new($spr_selectfield, 120, 240, "Lose Bases", 400, 180);
    @miDominationModeLoseOnDeathField.add("Off", 0, "", false, false);
    @miDominationModeLoseOnDeathField.add("On", 1, "", true, false);
    @miDominationModeLoseOnDeathField.setData(nil, nil, $game_values.gamemodesettings.domination.loseondeath);
    @miDominationModeLoseOnDeathField.setKey(game_values.gamemodesettings.domination.loseondeath ? 1 : 0);
    @miDominationModeLoseOnDeathField.setAutoAdvance(true);
		
    @miDominationModeRelocateOnDeathField = MI_SelectField.new($spr_selectfield, 120, 280, "Move Bases", 400, 180);
    @miDominationModeRelocateOnDeathField.add("Off", 0, "", false, false);
    @miDominationModeRelocateOnDeathField.add("On", 1, "", true, false);
    @miDominationModeRelocateOnDeathField.setData(nil, nil, $game_values.gamemodesettings.domination.relocateondeath);
    @miDominationModeRelocateOnDeathField.setKey(game_values.gamemodesettings.domination.relocateondeath ? 1 : 0);
    @miDominationModeRelocateOnDeathField.setAutoAdvance(true);
		
    @miDominationModeStealOnDeathField = MI_SelectField.new($spr_selectfield, 120, 320, "Steal Bases", 400, 180);
    @miDominationModeStealOnDeathField.add("Off", 0, "", false, false);
    @miDominationModeStealOnDeathField.add("On", 1, "", true, false);
    @miDominationModeStealOnDeathField.setData(nil, nil, $game_values.gamemodesettings.domination.stealondeath);
    @miDominationModeStealOnDeathField.setKey(game_values.gamemodesettings.domination.stealondeath ? 1 : 0);
    @miDominationModeStealOnDeathField.setAutoAdvance(true);
		
		
    @miDominationModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miDominationModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miDominationModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miDominationModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miDominationModeHeaderText = MI_Text.new("Domination Mode Menu", 320, 5, 0, 2, 1);
		
    @mModeSettingsMenu[11].addControl(@miDominationModeQuantityField, @miDominationModeBackButton, @miDominationModeRelocateFrequencyField, nil, @miDominationModeBackButton);
    @mModeSettingsMenu[11].addControl(@miDominationModeRelocateFrequencyField, @miDominationModeQuantityField, @miDominationModeLoseOnDeathField, nil, @miDominationModeBackButton);
    @mModeSettingsMenu[11].addControl(@miDominationModeLoseOnDeathField, @miDominationModeRelocateFrequencyField, @miDominationModeRelocateOnDeathField, nil, @miDominationModeBackButton);
    @mModeSettingsMenu[11].addControl(@miDominationModeRelocateOnDeathField, @miDominationModeLoseOnDeathField, @miDominationModeStealOnDeathField, nil, @miDominationModeBackButton);
    @mModeSettingsMenu[11].addControl(@miDominationModeStealOnDeathField, @miDominationModeRelocateOnDeathField, @miDominationModeBackButton, nil, @miDominationModeBackButton);
			
    @mModeSettingsMenu[11].addControl(@miDominationModeBackButton, @miDominationModeStealOnDeathField, @miDominationModeQuantityField, @miDominationModeStealOnDeathField, nil);
			
    @mModeSettingsMenu[11].addNonControl(@miDominationModeLeftHeaderBar);
    @mModeSettingsMenu[11].addNonControl(@miDominationModeRightHeaderBar);
    @mModeSettingsMenu[11].addNonControl(@miDominationModeHeaderText);
    @mModeSettingsMenu[11].addNonControl(@miDominationModeDeathText);
			
    @mModeSettingsMenu[11].setHeadControl(@miDominationModeQuantityField);
    @mModeSettingsMenu[11].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
		
    #***********************
    # King of the Hill Mode Settings
    #***********************
		
    @miKingOfTheHillModeSizeField = MI_SelectField.new($spr_selectfield, 120, 200, "Size", 400, 180);
    @miKingOfTheHillModeSizeField.add("2 x 2", 2, "", false, false);
    @miKingOfTheHillModeSizeField.add("3 x 3", 3, "", false, false);
    @miKingOfTheHillModeSizeField.add("4 x 4", 4, "", false, false);
    @miKingOfTheHillModeSizeField.add("5 x 5", 5, "", false, false);
    @miKingOfTheHillModeSizeField.setData($game_values.gamemodesettings.kingofthehill.areasize, nil, nil);
    @miKingOfTheHillModeSizeField.setKey(game_values.gamemodesettings.kingofthehill.areasize);
		
    @miKingOfTheHillModeRelocateFrequencyField = MI_SelectField.new($spr_selectfield, 120, 240, "Relocate", 400, 180);
    @miKingOfTheHillModeRelocateFrequencyField.add("Never", 0, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("5 Seconds", 310, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("10 Seconds", 620, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("15 Seconds", 930, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("20 Seconds", 1240, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("30 Seconds", 1860, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("45 Seconds", 2790, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("1 Minute", 3720, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("1.5 Minutes", 5580, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("2 Minutes", 7440, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("2.5 Minutes", 9300, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.add("3 Minutes", 11160, "", false, false);
    @miKingOfTheHillModeRelocateFrequencyField.setData($game_values.gamemodesettings.kingofthehill.relocationfrequency, nil, nil);
    @miKingOfTheHillModeRelocateFrequencyField.setKey(game_values.gamemodesettings.kingofthehill.relocationfrequency);
		
    @miKingOfTheHillModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miKingOfTheHillModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miKingOfTheHillModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miKingOfTheHillModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miKingOfTheHillModeHeaderText = MI_Text.new("King of the Hill Mode Menu", 320, 5, 0, 2, 1);
		
    @mModeSettingsMenu[12].addControl(@miKingOfTheHillModeSizeField, @miKingOfTheHillModeBackButton, @miKingOfTheHillModeRelocateFrequencyField, nil, @miKingOfTheHillModeBackButton);
    @mModeSettingsMenu[12].addControl(@miKingOfTheHillModeRelocateFrequencyField, @miKingOfTheHillModeSizeField, @miKingOfTheHillModeBackButton, nil, @miKingOfTheHillModeBackButton);
			
    @mModeSettingsMenu[12].addControl(@miKingOfTheHillModeBackButton, @miKingOfTheHillModeRelocateFrequencyField, @miKingOfTheHillModeSizeField, @miKingOfTheHillModeRelocateFrequencyField, nil);
			
    @mModeSettingsMenu[12].addNonControl(@miKingOfTheHillModeLeftHeaderBar);
    @mModeSettingsMenu[12].addNonControl(@miKingOfTheHillModeRightHeaderBar);
    @mModeSettingsMenu[12].addNonControl(@miKingOfTheHillModeHeaderText);
			
    @mModeSettingsMenu[12].setHeadControl(@miKingOfTheHillModeSizeField);
    @mModeSettingsMenu[12].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
					
    #***********************
    # Race Mode Settings
    #***********************
		
    @miRaceModeQuantityField = MI_SelectField.new($spr_selectfield, 120, 180, "Quantity", 400, 180);
    @miRaceModeQuantityField.add("2", 2, "", false, false);
    @miRaceModeQuantityField.add("3", 3, "", false, false);
    @miRaceModeQuantityField.add("4", 4, "", false, false);
    @miRaceModeQuantityField.add("5", 5, "", false, false);
    @miRaceModeQuantityField.add("6", 6, "", false, false);
    @miRaceModeQuantityField.add("7", 7, "", false, false);
    @miRaceModeQuantityField.add("8", 8, "", false, false);
    @miRaceModeQuantityField.setData($game_values.gamemodesettings.race.quantity, nil, nil);
    @miRaceModeQuantityField.setKey(game_values.gamemodesettings.race.quantity);
		
    @miRaceModeSpeedField = MI_SelectField.new($spr_selectfield, 120, 220, "Speed", 400, 180);
    @miRaceModeSpeedField.add("Very Slow", 2, "", false, false);
    @miRaceModeSpeedField.add("Slow", 3, "", false, false);
    @miRaceModeSpeedField.add("Moderate", 4, "", false, false);
    @miRaceModeSpeedField.add("Fast", 6, "", false, false);
    @miRaceModeSpeedField.add("Very Fast", 8, "", false, false);
    @miRaceModeSpeedField.setData($game_values.gamemodesettings.race.speed, nil, nil);
    @miRaceModeSpeedField.setKey(game_values.gamemodesettings.race.speed);
		
    @miRaceModePenaltyField = MI_SelectField.new($spr_selectfield, 120, 260, "Penalty", 400, 180);
    @miRaceModePenaltyField.add("None", 0, "", false, false);
    @miRaceModePenaltyField.add("One Goal", 1, "", false, false);
    @miRaceModePenaltyField.add("All Goals", 2, "", false, false);
    @miRaceModePenaltyField.setData($game_values.gamemodesettings.race.penalty, nil, nil);
    @miRaceModePenaltyField.setKey(game_values.gamemodesettings.race.penalty);
			
    @miRaceModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miRaceModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miRaceModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miRaceModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miRaceModeHeaderText = MI_Text.new("Race Mode Menu", 320, 5, 0, 2, 1);
		
    @mModeSettingsMenu[13].addControl(@miRaceModeQuantityField, @miRaceModeBackButton, @miRaceModeSpeedField, nil, @miRaceModeBackButton);
    @mModeSettingsMenu[13].addControl(@miRaceModeSpeedField, @miRaceModeQuantityField, @miRaceModePenaltyField, nil, @miRaceModeBackButton);
    @mModeSettingsMenu[13].addControl(@miRaceModePenaltyField, @miRaceModeSpeedField, @miRaceModeBackButton, nil, @miRaceModeBackButton);
		
    @mModeSettingsMenu[13].addControl(@miRaceModeBackButton, @miRaceModePenaltyField, @miRaceModeQuantityField, @miRaceModePenaltyField, nil);
			
    @mModeSettingsMenu[13].addNonControl(@miRaceModeLeftHeaderBar);
    @mModeSettingsMenu[13].addNonControl(@miRaceModeRightHeaderBar);
    @mModeSettingsMenu[13].addNonControl(@miRaceModeHeaderText);
			
    @mModeSettingsMenu[13].setHeadControl(@miRaceModeQuantityField);
    @mModeSettingsMenu[13].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
		
    #***********************
    # Stomp Mode Settings
    #***********************
		
    @miStompModeRateField = MI_SelectField.new($spr_selectfield, 120, 160, "Rate", 400, 180);
    @miStompModeRateField.add("Very Slow", 150, "", false, false);
    @miStompModeRateField.add("Slow", 120, "", false, false);
    @miStompModeRateField.add("Moderate", 90, "", false, false);
    @miStompModeRateField.add("Fast", 60, "", false, false);
    @miStompModeRateField.add("Very Fast", 30, "", false, false);
    @miStompModeRateField.setData($game_values.gamemodesettings.stomp.rate, nil, nil);
    @miStompModeRateField.setKey(game_values.gamemodesettings.stomp.rate);
		
    @miStompModeEnemySlider  = []
    3.times do |iEnemy|
      @miStompModeEnemySlider[iEnemy] = MI_PowerupSlider.new($spr_selectfield, $menu_slider_bar, $menu_stomp, 120, 200 + 40 * iEnemy, 400, iEnemy);
      @miStompModeEnemySlider[iEnemy].add("", 0, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 1, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 2, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 3, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 4, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 5, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 6, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 7, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 8, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 9, "", false, false);
      @miStompModeEnemySlider[iEnemy].add("", 10, "", false, false);
      @miStompModeEnemySlider[iEnemy].setNoWrap(true);
      @miStompModeEnemySlider[iEnemy].setData($game_values.gamemodesettings.stomp.enemyweight[iEnemy], nil, nil);
      @miStompModeEnemySlider[iEnemy].setKey(game_values.gamemodesettings.stomp.enemyweight[iEnemy]);
    end
		
    @miStompModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miStompModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miStompModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miStompModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miStompModeHeaderText = MI_Text.new("Stomp Mode Menu", 320, 5, 0, 2, 1);
		
		
    @mModeSettingsMenu[5].addControl(@miStompModeRateField, @miStompModeBackButton, @miStompModeEnemySlider[0], nil, @miStompModeBackButton);
			
    @mModeSettingsMenu[5].addControl(@miStompModeEnemySlider[0], @miStompModeRateField,      @miStompModeEnemySlider[1], nil, @miStompModeBackButton);
    @mModeSettingsMenu[5].addControl(@miStompModeEnemySlider[1], @miStompModeEnemySlider[0], @miStompModeEnemySlider[2], nil, @miStompModeBackButton);
    @mModeSettingsMenu[5].addControl(@miStompModeEnemySlider[2], @miStompModeEnemySlider[1], @miStompModeBackButton,     nil, @miStompModeBackButton);
		
    @mModeSettingsMenu[5].addControl(@miStompModeBackButton, @miStompModeEnemySlider[2], @miStompModeRateField, @miStompModeEnemySlider[2], nil);
			
    @mModeSettingsMenu[5].addNonControl(@miStompModeLeftHeaderBar);
    @mModeSettingsMenu[5].addNonControl(@miStompModeRightHeaderBar);
    @mModeSettingsMenu[5].addNonControl(@miStompModeHeaderText);
			
    @mModeSettingsMenu[5].setHeadControl(@miStompModeRateField);
    @mModeSettingsMenu[5].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
    #***********************
    # Frenzy Mode Settings
    #***********************
		
    @miFrenzyModeQuantityField = MI_SelectField.new($spr_selectfield, 120, 60, "Limit", 400, 180);
    @miFrenzyModeQuantityField.add("Single Powerup", 0, "", false, false);
    @miFrenzyModeQuantityField.add("1 Powerup", 1, "", false, false);
    @miFrenzyModeQuantityField.add("2 Powerups", 2, "", false, false);
    @miFrenzyModeQuantityField.add("3 Powerups", 3, "", false, false);
    @miFrenzyModeQuantityField.add("4 Powerups", 4, "", false, false);
    @miFrenzyModeQuantityField.add("5 Powerups", 5, "", false, false);
    @miFrenzyModeQuantityField.add("# Players - 1", 6, "", false, false);
    @miFrenzyModeQuantityField.add("# Players", 7, "", false, false);
    @miFrenzyModeQuantityField.add("# Players + 1", 8, "", false, false);
    @miFrenzyModeQuantityField.add("# Players + 2", 9, "", false, false);
    @miFrenzyModeQuantityField.add("# Players + 3", 10, "", false, false);
    @miFrenzyModeQuantityField.setData($game_values.gamemodesettings.frenzy.quantity, nil, nil);
    @miFrenzyModeQuantityField.setKey(game_values.gamemodesettings.frenzy.quantity);
		
    @miFrenzyModeRateField = MI_SelectField.new($spr_selectfield, 120, 100, "Rate", 400, 180);
    @miFrenzyModeRateField.add("Instant", 0, "", false, false);
    @miFrenzyModeRateField.add("1 Second", 62, "", false, false);
    @miFrenzyModeRateField.add("2 Seconds", 124, "", false, false);
    @miFrenzyModeRateField.add("3 Seconds", 186, "", false, false);
    @miFrenzyModeRateField.add("5 Seconds", 310, "", false, false);
    @miFrenzyModeRateField.add("10 Seconds", 620, "", false, false);
    @miFrenzyModeRateField.add("15 Seconds", 930, "", false, false);
    @miFrenzyModeRateField.add("20 Seconds", 1240, "", false, false);
    @miFrenzyModeRateField.add("25 Seconds", 1550, "", false, false);
    @miFrenzyModeRateField.add("30 Seconds", 1860, "", false, false);
    @miFrenzyModeRateField.setData($game_values.gamemodesettings.frenzy.rate, nil, nil);
    @miFrenzyModeRateField.setKey(game_values.gamemodesettings.frenzy.rate);
		
    @miFrenzyModeStoredShellsField = MI_SelectField.new($spr_selectfield, 120, 140, "Store Shells", 400, 180);
    @miFrenzyModeStoredShellsField.add("Off", 0, "", false, false);
    @miFrenzyModeStoredShellsField.add("On", 1, "", true, false);
    @miFrenzyModeStoredShellsField.setData(nil, nil, $game_values.gamemodesettings.frenzy.storedshells);
    @miFrenzyModeStoredShellsField.setKey(game_values.gamemodesettings.frenzy.storedshells ? 1 : 0);
    @miFrenzyModeStoredShellsField.setAutoAdvance(true);
		
    iPowerupMap = [8, 5, 11, 17, 19, 9, 16, 10, 12, 13, 14, 15]
    @miFrenzyModePowerupSlider = []
    12.times do |iPowerup|
      @miFrenzyModePowerupSlider[iPowerup] = MI_PowerupSlider.new($spr_selectfield, $menu_slider_bar, $spr_storedpoweruplarge, iPowerup < 6 ? 65 : 330, 180 + 40 * iPowerup - (iPowerup < 6 ? 0 : 240), 245, iPowerupMap[iPowerup]);
      @miFrenzyModePowerupSlider[iPowerup].add("", 0, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 1, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 2, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 3, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 4, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 5, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 6, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 7, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 8, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 9, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].add("", 10, "", false, false);
      @miFrenzyModePowerupSlider[iPowerup].setNoWrap(true);
      @miFrenzyModePowerupSlider[iPowerup].setData($game_values.gamemodesettings.frenzy.powerupweight[iPowerup], nil, nil);
      @miFrenzyModePowerupSlider[iPowerup].setKey(game_values.gamemodesettings.frenzy.powerupweight[iPowerup]);
    end
		
    @miFrenzyModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miFrenzyModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miFrenzyModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miFrenzyModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miFrenzyModeHeaderText = MI_Text.new("Frenzy Mode Menu", 320, 5, 0, 2, 1);
		
		
    @mModeSettingsMenu[15].addControl(@miFrenzyModeQuantityField, @miFrenzyModeBackButton, @miFrenzyModeRateField, nil, @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModeRateField, @miFrenzyModeQuantityField, @miFrenzyModeStoredShellsField, nil, @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModeStoredShellsField, @miFrenzyModeRateField, @miFrenzyModePowerupSlider[0], nil, @miFrenzyModeBackButton);
		
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[0], @miFrenzyModeStoredShellsField, @miFrenzyModePowerupSlider[1], nil, @miFrenzyModePowerupSlider[6]);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[1], @miFrenzyModePowerupSlider[0], @miFrenzyModePowerupSlider[2], nil, @miFrenzyModePowerupSlider[7]);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[2], @miFrenzyModePowerupSlider[1], @miFrenzyModePowerupSlider[3], nil, @miFrenzyModePowerupSlider[8]);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[3], @miFrenzyModePowerupSlider[2], @miFrenzyModePowerupSlider[4], nil, @miFrenzyModePowerupSlider[9]);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[4], @miFrenzyModePowerupSlider[3], @miFrenzyModePowerupSlider[5], nil, @miFrenzyModePowerupSlider[10]);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[5], @miFrenzyModePowerupSlider[4], @miFrenzyModePowerupSlider[6], nil, @miFrenzyModePowerupSlider[11]);
			
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[6], @miFrenzyModePowerupSlider[5], @miFrenzyModePowerupSlider[7], @miFrenzyModePowerupSlider[0], @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[7], @miFrenzyModePowerupSlider[6], @miFrenzyModePowerupSlider[8], @miFrenzyModePowerupSlider[1], @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[8], @miFrenzyModePowerupSlider[7], @miFrenzyModePowerupSlider[9], @miFrenzyModePowerupSlider[2], @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[9], @miFrenzyModePowerupSlider[8], @miFrenzyModePowerupSlider[10], @miFrenzyModePowerupSlider[3], @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[10], @miFrenzyModePowerupSlider[9], @miFrenzyModePowerupSlider[11], @miFrenzyModePowerupSlider[4], @miFrenzyModeBackButton);
    @mModeSettingsMenu[15].addControl(@miFrenzyModePowerupSlider[11], @miFrenzyModePowerupSlider[10], @miFrenzyModeBackButton,       @miFrenzyModePowerupSlider[5], @miFrenzyModeBackButton);
		
    @mModeSettingsMenu[15].addControl(@miFrenzyModeBackButton, @miFrenzyModePowerupSlider[11], @miFrenzyModeQuantityField, @miFrenzyModePowerupSlider[11], nil);
			
    @mModeSettingsMenu[15].addNonControl(@miFrenzyModeLeftHeaderBar);
    @mModeSettingsMenu[15].addNonControl(@miFrenzyModeRightHeaderBar);
    @mModeSettingsMenu[15].addNonControl(@miFrenzyModeHeaderText);
			
    @mModeSettingsMenu[15].setHeadControl(@miFrenzyModeQuantityField);
    @mModeSettingsMenu[15].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
    #***********************
    # Survival Mode Settings
    #***********************
    @miSurvivalModeEnemySlider = []
    3.times do |iEnemy|
      @miSurvivalModeEnemySlider[iEnemy] = MI_PowerupSlider.new($spr_selectfield, $menu_slider_bar, $menu_survival, 120, 120 + 40 * iEnemy, 400, iEnemy);
      @miSurvivalModeEnemySlider[iEnemy].add("", 0, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 1, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 2, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 3, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 4, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 5, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 6, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 7, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 8, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 9, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].add("", 10, "", false, false);
      @miSurvivalModeEnemySlider[iEnemy].setNoWrap(true);
      @miSurvivalModeEnemySlider[iEnemy].setData($game_values.gamemodesettings.survival.enemyweight[iEnemy], nil, nil);
      @miSurvivalModeEnemySlider[iEnemy].setKey(game_values.gamemodesettings.survival.enemyweight[iEnemy]);
    end
		
    @miSurvivalModeDensityField = MI_SelectField.new($spr_selectfield, 120, 240, "Density", 400, 180);
    @miSurvivalModeDensityField.add("Very Low", 40, "", false, false);
    @miSurvivalModeDensityField.add("Low", 30, "", false, false);
    @miSurvivalModeDensityField.add("Medium", 20, "", false, false);
    @miSurvivalModeDensityField.add("High", 15, "", false, false);
    @miSurvivalModeDensityField.add("Very High", 10, "", false, false);
    @miSurvivalModeDensityField.setData($game_values.gamemodesettings.survival.density, nil, nil);
    @miSurvivalModeDensityField.setKey(game_values.gamemodesettings.survival.density);
		
    @miSurvivalModeSpeedField = MI_SelectField.new($spr_selectfield, 120, 280, "Speed", 400, 180);
    @miSurvivalModeSpeedField.add("Very Slow", 2, "", false, false);
    @miSurvivalModeSpeedField.add("Slow", 3, "", false, false);
    @miSurvivalModeSpeedField.add("Moderate", 4, "", false, false);
    @miSurvivalModeSpeedField.add("Fast", 6, "", false, false);
    @miSurvivalModeSpeedField.add("Very Fast", 8, "", false, false);
    @miSurvivalModeSpeedField.setData($game_values.gamemodesettings.survival.speed, nil, nil);
    @miSurvivalModeSpeedField.setKey(game_values.gamemodesettings.survival.speed);
			
    @miSurvivalModeShieldField = MI_SelectField.new($spr_selectfield, 120, 320, "Shield", 400, 180);
    @miSurvivalModeShieldField.add("Off", 0, "", false, false);
    @miSurvivalModeShieldField.add("On", 1, "", true, false);
    @miSurvivalModeShieldField.setData(nil, nil, $game_values.gamemodesettings.survival.shield);
    @miSurvivalModeShieldField.setKey(game_values.gamemodesettings.survival.shield ? 1 : 0);
    @miSurvivalModeShieldField.setAutoAdvance(true);
		
    @miSurvivalModeBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miSurvivalModeBackButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
    @miSurvivalModeLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miSurvivalModeRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miSurvivalModeHeaderText = MI_Text.new("Survival Mode Menu", 320, 5, 0, 2, 1);
		
    @mModeSettingsMenu[16].addControl(@miSurvivalModeEnemySlider[0], @miSurvivalModeBackButton, @miSurvivalModeEnemySlider[1], nil, @miSurvivalModeBackButton);
    @mModeSettingsMenu[16].addControl(@miSurvivalModeEnemySlider[1], @miSurvivalModeEnemySlider[0], @miSurvivalModeEnemySlider[2], nil, @miSurvivalModeBackButton);
    @mModeSettingsMenu[16].addControl(@miSurvivalModeEnemySlider[2], @miSurvivalModeEnemySlider[1], @miSurvivalModeDensityField, nil, @miSurvivalModeBackButton);
    @mModeSettingsMenu[16].addControl(@miSurvivalModeDensityField, @miSurvivalModeEnemySlider[2], @miSurvivalModeSpeedField, nil, @miSurvivalModeBackButton);
    @mModeSettingsMenu[16].addControl(@miSurvivalModeSpeedField, @miSurvivalModeDensityField, @miSurvivalModeShieldField, nil, @miSurvivalModeBackButton);
    @mModeSettingsMenu[16].addControl(@miSurvivalModeShieldField, @miSurvivalModeSpeedField, @miSurvivalModeBackButton, nil, @miSurvivalModeBackButton);
    @mModeSettingsMenu[16].addControl(@miSurvivalModeBackButton, @miSurvivalModeShieldField, @miSurvivalModeEnemySlider[0], @miSurvivalModeShieldField, nil);
			
    @mModeSettingsMenu[16].addNonControl(@miSurvivalModeLeftHeaderBar);
    @mModeSettingsMenu[16].addNonControl(@miSurvivalModeRightHeaderBar);
    @mModeSettingsMenu[16].addNonControl(@miSurvivalModeHeaderText);
			
    @mModeSettingsMenu[16].setHeadControl(@miSurvivalModeEnemySlider[0]);
    @mModeSettingsMenu[16].setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS);
		
		
    #***********************
    # Team Select Settings
    #***********************
			
    @miTeamSelect = MI_TeamSelect.new($spr_player_select_background, 112, 96);
    puts "setting @miTeamSelect automodify to true"
    @miTeamSelect.setAutoModify(true);
				
    @miTeamSelectLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miTeamSelectRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miTeamSelectHeaderText = MI_Text.new("Team and Character Selection", 320, 5, 0, 2, 1);
		
    @mTeamSelectMenu = UI_Menu.new
    @mTeamSelectMenu.addControl(@miTeamSelect, nil, nil, nil, nil);
			
    @mTeamSelectMenu.addNonControl(@miTeamSelectLeftHeaderBar);
    @mTeamSelectMenu.addNonControl(@miTeamSelectRightHeaderBar);
    @mTeamSelectMenu.addNonControl(@miTeamSelectHeaderText);
			
    @mTeamSelectMenu.setHeadControl(@miTeamSelect);
    @mTeamSelectMenu.setCancelCode(MENU_CODE_TO_MAIN_MENU);
		
    #***********************
    # Tournament Scoreboard
    #***********************
		
    @miTournamentScoreboard = MI_TournamentScoreboard.new($spr_tournament_background, 70, 98);
			
    @miTournamentScoreboardNextButton = MI_Button.new($spr_selectfield, 220, 416, "Next", 200, 1);
    @miTournamentScoreboardNextButton.setCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU);
		
    @miTournamentScoreboardImage = MI_Image.new($spr_scoreboard, 124, 12, 0, 0, 386, 59, 1, 1, 0);
		
    @mTournamentScoreboardMenu = UI_Menu.new
    @mTournamentScoreboardMenu.addNonControl(@miTournamentScoreboard);
    @mTournamentScoreboardMenu.addNonControl(@miTournamentScoreboardImage);
    @mTournamentScoreboardMenu.addControl(@miTournamentScoreboardNextButton, nil, nil, nil, nil);
    @mTournamentScoreboardMenu.setHeadControl(@miTournamentScoreboardNextButton);
    @mTournamentScoreboardMenu.setCancelCode(MENU_CODE_BACK_TO_GAME_SETUP_MENU);
		
    #***********************
    # Bonus Wheel
    #***********************
		
    @miBonusWheel = MI_BonusWheel.new($spr_tournament_powerup_splash, $spr_storedpoweruplarge, 144, 38);
    @mBonusWheelMenu = UI_Menu.new
    @mBonusWheelMenu.addControl(@miBonusWheel, nil, nil, nil, nil);
    @mBonusWheelMenu.setHeadControl(@miBonusWheel);
    @mBonusWheelMenu.setCancelCode(MENU_CODE_BONUS_DONE);
		
    #***********************
    # Powerup Selection Menu
    #***********************
    @miPowerupSlider = []
    NUM_POWERUPS.times do|iPowerup|
      @miPowerupSlider[iPowerup] = MI_PowerupSlider.new() #MI_PowerupSlider.new($spr_selectfield, $menu_slider_bar, $spr_storedpoweruplarge, 50 + (iPowerupDisplayMap[iPowerup] < 10 ? 0 : 295), 44 + 38 * (iPowerupDisplayMap[iPowerup] < 10 ? iPowerupDisplayMap[iPowerup] : iPowerupDisplayMap[iPowerup] - 10), 245, iPowerup);
      @miPowerupSlider[iPowerup].add("", 0, "", false, false);
      @miPowerupSlider[iPowerup].add("", 1, "", false, false);
      @miPowerupSlider[iPowerup].add("", 2, "", false, false);
      @miPowerupSlider[iPowerup].add("", 3, "", false, false);
      @miPowerupSlider[iPowerup].add("", 4, "", false, false);
      @miPowerupSlider[iPowerup].add("", 5, "", false, false);
      @miPowerupSlider[iPowerup].add("", 6, "", false, false);
      @miPowerupSlider[iPowerup].add("", 7, "", false, false);
      @miPowerupSlider[iPowerup].add("", 8, "", false, false);
      @miPowerupSlider[iPowerup].add("", 9, "", false, false);
      @miPowerupSlider[iPowerup].add("", 10, "", false, false);
      @miPowerupSlider[iPowerup].setNoWrap(true);
      @miPowerupSlider[iPowerup].setData($game_values.powerupweights[iPowerup], nil, nil);
      @miPowerupSlider[iPowerup].setKey(game_values.powerupweights[iPowerup]);
    end
		
    @miPowerupSelectionBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miPowerupSelectionBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
			
    @miPowerupSelectionRestoreDefaultsButton = MI_Button.new($spr_selectfield, 220, 432, "Restore Defaults", 245, 1);
    @miPowerupSelectionRestoreDefaultsButton.setCode(MENU_CODE_RESTORE_DEFAULT_POWERUP_WEIGHTS);
		
    @miPowerupSelectionLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miPowerupSelectionMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miPowerupSelectionMenuHeaderText = MI_Text.new("Item Selection Menu", 320, 5, 0, 2, 1);
		
    #Are You Sure dialog box
    @miPowerupSelectionDialogImage = MI_Image.new($spr_dialog, 224, 176, 0, 0, 192, 128, 1, 1, 0);
    @miPowerupSelectionDialogExitText = MI_Text.new("Are You", 320, 195, 0, 2, 1);
    @miPowerupSelectionDialogTournamentText = MI_Text.new("Sure?", 320, 220, 0, 2, 1);
    @miPowerupSelectionDialogYesButton = MI_Button.new($spr_selectfield, 235, 250, "Yes", 80, 1);
    @miPowerupSelectionDialogNoButton = MI_Button.new($spr_selectfield, 325, 250, "No", 80, 1);
			
    @miPowerupSelectionDialogYesButton.setCode(MENU_CODE_POWERUP_RESET_YES);
    @miPowerupSelectionDialogNoButton.setCode(MENU_CODE_POWERUP_RESET_NO);
		
    @miPowerupSelectionDialogImage.show(false);
    @miPowerupSelectionDialogTournamentText.show(false);
    @miPowerupSelectionDialogExitText.show(false);
    @miPowerupSelectionDialogYesButton.show(false);
    @miPowerupSelectionDialogNoButton.show(false);
		
    @mPowerupSelectionMenu = UI_Menu.new
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[0]], @miPowerupSelectionBackButton, @miPowerupSlider[iPowerupPositionMap[1]], nil, @miPowerupSlider[iPowerupPositionMap[10]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[1]], @miPowerupSlider[iPowerupPositionMap[0]], @miPowerupSlider[iPowerupPositionMap[2]], nil, @miPowerupSlider[iPowerupPositionMap[11]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[2]], @miPowerupSlider[iPowerupPositionMap[1]], @miPowerupSlider[iPowerupPositionMap[3]], nil, @miPowerupSlider[iPowerupPositionMap[12]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[3]], @miPowerupSlider[iPowerupPositionMap[2]], @miPowerupSlider[iPowerupPositionMap[4]], nil, @miPowerupSlider[iPowerupPositionMap[13]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[4]], @miPowerupSlider[iPowerupPositionMap[3]], @miPowerupSlider[iPowerupPositionMap[5]], nil, @miPowerupSlider[iPowerupPositionMap[14]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[5]], @miPowerupSlider[iPowerupPositionMap[4]], @miPowerupSlider[iPowerupPositionMap[6]], nil, @miPowerupSlider[iPowerupPositionMap[15]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[6]], @miPowerupSlider[iPowerupPositionMap[5]], @miPowerupSlider[iPowerupPositionMap[7]], nil, @miPowerupSlider[iPowerupPositionMap[16]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[7]], @miPowerupSlider[iPowerupPositionMap[6]], @miPowerupSlider[iPowerupPositionMap[8]], nil, @miPowerupSlider[iPowerupPositionMap[17]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[8]], @miPowerupSlider[iPowerupPositionMap[7]], @miPowerupSlider[iPowerupPositionMap[9]], nil, @miPowerupSlider[iPowerupPositionMap[18]]);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[9]], @miPowerupSlider[iPowerupPositionMap[8]], @miPowerupSelectionRestoreDefaultsButton, nil, @miPowerupSlider[iPowerupPositionMap[19]]);
    # 			
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[10]], @miPowerupSelectionRestoreDefaultsButton, @miPowerupSlider[iPowerupPositionMap[11]], @miPowerupSlider[iPowerupPositionMap[0]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[11]], @miPowerupSlider[iPowerupPositionMap[10]], @miPowerupSlider[iPowerupPositionMap[12]], @miPowerupSlider[iPowerupPositionMap[1]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[12]], @miPowerupSlider[iPowerupPositionMap[11]], @miPowerupSlider[iPowerupPositionMap[13]], @miPowerupSlider[iPowerupPositionMap[2]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[13]], @miPowerupSlider[iPowerupPositionMap[12]], @miPowerupSlider[iPowerupPositionMap[14]], @miPowerupSlider[iPowerupPositionMap[3]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[14]], @miPowerupSlider[iPowerupPositionMap[13]], @miPowerupSlider[iPowerupPositionMap[15]], @miPowerupSlider[iPowerupPositionMap[4]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[15]], @miPowerupSlider[iPowerupPositionMap[14]], @miPowerupSlider[iPowerupPositionMap[16]], @miPowerupSlider[iPowerupPositionMap[5]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[16]], @miPowerupSlider[iPowerupPositionMap[15]], @miPowerupSlider[iPowerupPositionMap[17]], @miPowerupSlider[iPowerupPositionMap[6]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[17]], @miPowerupSlider[iPowerupPositionMap[16]], @miPowerupSlider[iPowerupPositionMap[18]], @miPowerupSlider[iPowerupPositionMap[7]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[18]], @miPowerupSlider[iPowerupPositionMap[17]], @miPowerupSlider[iPowerupPositionMap[19]], @miPowerupSlider[iPowerupPositionMap[8]], nil);
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSlider[iPowerupPositionMap[19]], @miPowerupSlider[iPowerupPositionMap[18]], @miPowerupSelectionBackButton, @miPowerupSlider[iPowerupPositionMap[9]], nil);
			
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSelectionRestoreDefaultsButton, @miPowerupSlider[iPowerupPositionMap[9]], @miPowerupSlider[iPowerupPositionMap[10]], nil, @miPowerupSelectionBackButton);
    # 		
    # 			@mPowerupSelectionMenu.addControl(@miPowerupSelectionBackButton, @miPowerupSlider[iPowerupPositionMap[19]], @miPowerupSlider[iPowerupPositionMap[0]], @miPowerupSelectionRestoreDefaultsButton, nil);
		
    @mPowerupSelectionMenu.addNonControl(@miPowerupSelectionLeftHeaderBar);
    @mPowerupSelectionMenu.addNonControl(@miPowerupSelectionMenuRightHeaderBar);
    @mPowerupSelectionMenu.addNonControl(@miPowerupSelectionMenuHeaderText);
			
    @mPowerupSelectionMenu.addNonControl(@miPowerupSelectionDialogImage);
    @mPowerupSelectionMenu.addNonControl(@miPowerupSelectionDialogTournamentText);
    @mPowerupSelectionMenu.addNonControl(@miPowerupSelectionDialogExitText);
		
    @mPowerupSelectionMenu.addControl(@miPowerupSelectionDialogYesButton, nil, nil, nil, @miPowerupSelectionDialogNoButton);
    @mPowerupSelectionMenu.addControl(@miPowerupSelectionDialogNoButton, nil, nil, @miPowerupSelectionDialogYesButton, nil);
		
    #@mPowerupSelectionMenu.setHeadControl(@miPowerupSlider[iPowerupPositionMap[0]]);
    @mPowerupSelectionMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
		
		
    #***********************
    # Powerup Settings Menu
    #***********************
			
    @miStoredPowerupDelayField = MI_SelectField.new($spr_selectfield, 120, 120, "Stored Use", 400, 180);
    @miStoredPowerupDelayField.add("Very Slow", 2, "", false, false);
    @miStoredPowerupDelayField.add("Slow", 3, "", false, false);
    @miStoredPowerupDelayField.add("Moderate", 4, "", false, false);
    @miStoredPowerupDelayField.add("Fast", 5, "", false, false);
    @miStoredPowerupDelayField.add("Very Fast", 6, "", false, false);
    @miStoredPowerupDelayField.setData($game_values.storedpowerupdelay, nil, nil);
    @miStoredPowerupDelayField.setKey(game_values.storedpowerupdelay);
		
    @miItemRespawnField = MI_SelectField.new($spr_selectfield, 120, 160, "Item Spawn", 400, 180);
    @miItemRespawnField.add("5 Seconds", 310, "", false, false);
    @miItemRespawnField.add("10 Seconds", 620, "", false, false);
    @miItemRespawnField.add("15 Seconds", 930, "", false, false);
    @miItemRespawnField.add("20 Seconds", 1240, "", false, false);
    @miItemRespawnField.add("25 Seconds", 1550, "", false, false);
    @miItemRespawnField.add("30 Seconds", 1860, "", false, false);
    @miItemRespawnField.add("35 Seconds", 2170, "", false, false);
    @miItemRespawnField.add("40 Seconds", 2480, "", false, false);
    @miItemRespawnField.add("45 Seconds", 2790, "", false, false);
    @miItemRespawnField.add("50 Seconds", 3100, "", false, false);
    @miItemRespawnField.add("55 Seconds", 3410, "", false, false);
    @miItemRespawnField.add("60 Seconds", 3720, "", false, false);
    @miItemRespawnField.setData($game_values.itemrespawntime, nil, nil);
    @miItemRespawnField.setKey(game_values.itemrespawntime);
		
    @miSwapStyleField = MI_SelectField.new($spr_selectfield, 120, 200, "Swap Style", 400, 180);
    @miSwapStyleField.add("Walk", 0, "", false, false);
    @miSwapStyleField.add("Blink", 1, "", false, false);
    @miSwapStyleField.add("Instant", 2, "", false, false);
    @miSwapStyleField.setData($game_values.swapstyle, nil, nil);
    @miSwapStyleField.setKey(game_values.swapstyle);
		
    @miBonusWheelField = MI_SelectField.new($spr_selectfield, 120, 240, "Bonus Wheel", 400, 180);
    @miBonusWheelField.add("Off", 0, "", false, false);
    @miBonusWheelField.add("Tournament Win", 1, "", false, false);
    @miBonusWheelField.add("Every Game", 2, "", false, false);
    @miBonusWheelField.setData($game_values.bonuswheel, nil, nil);
    @miBonusWheelField.setKey(game_values.bonuswheel);
		
    @miKeepPowerupField = MI_SelectField.new($spr_selectfield, 120, 280, "Bonus Item", 400, 180);
    @miKeepPowerupField.add("Until Next Spin", 0, "", false, false);
    @miKeepPowerupField.add("Keep Always", 1, "", true, false);
    @miKeepPowerupField.setData(nil, nil, $game_values.keeppowerup);
    @miKeepPowerupField.setKey(game_values.keeppowerup ? 1 : 0);
    @miKeepPowerupField.setAutoAdvance(true);
		
    @miStoredPowerupResetButton = MI_StoredPowerupResetButton.new($spr_selectfield, 120, 320, "Reset Stored Items", 400, 0);
    @miStoredPowerupResetButton.setCode(MENU_CODE_RESET_STORED_POWERUPS);
		
    @miPowerupSettingsMenuBackButton = MI_Button.new($spr_selectfield, 544, 432, "Back", 80, 1);
    @miPowerupSettingsMenuBackButton.setCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
			
    @miPowerupSettingsMenuLeftHeaderBar = MI_Image.new($menu_plain_field, 0, 0, 0, 0, 320, 32, 1, 1, 0);
    @miPowerupSettingsMenuRightHeaderBar = MI_Image.new($menu_plain_field, 320, 0, 192, 0, 320, 32, 1, 1, 0);
    @miPowerupSettingsMenuHeaderText = MI_Text.new("Item Settings Menu", 320, 5, 0, 2, 1);
		
    @mPowerupSettingsMenu = UI_Menu.new
    @mPowerupSettingsMenu.addControl(@miStoredPowerupDelayField, @miPowerupSettingsMenuBackButton, @miItemRespawnField, nil, @miPowerupSettingsMenuBackButton);
    @mPowerupSettingsMenu.addControl(@miItemRespawnField, @miStoredPowerupDelayField, @miSwapStyleField, nil, @miPowerupSettingsMenuBackButton);
    @mPowerupSettingsMenu.addControl(@miSwapStyleField, @miItemRespawnField, @miBonusWheelField, nil, @miPowerupSettingsMenuBackButton);
    @mPowerupSettingsMenu.addControl(@miBonusWheelField, @miSwapStyleField, @miKeepPowerupField, nil, @miPowerupSettingsMenuBackButton);
    @mPowerupSettingsMenu.addControl(@miKeepPowerupField, @miBonusWheelField, @miStoredPowerupResetButton, nil, @miPowerupSettingsMenuBackButton);
    @mPowerupSettingsMenu.addControl(@miStoredPowerupResetButton, @miKeepPowerupField, @miPowerupSettingsMenuBackButton, nil, @miPowerupSettingsMenuBackButton);
			
    @mPowerupSettingsMenu.addControl(@miPowerupSettingsMenuBackButton, @miStoredPowerupResetButton, @miStoredPowerupDelayField, @miStoredPowerupResetButton, nil);
		
    @mPowerupSettingsMenu.addNonControl(@miPowerupSettingsMenuLeftHeaderBar);
    @mPowerupSettingsMenu.addNonControl(@miPowerupSettingsMenuRightHeaderBar);
    @mPowerupSettingsMenu.addNonControl(@miPowerupSettingsMenuHeaderText);
			
    @mPowerupSettingsMenu.setHeadControl(@miStoredPowerupDelayField);
    @mPowerupSettingsMenu.setCancelCode(MENU_CODE_BACK_TO_OPTIONS_MENU);
			
    @mCurrentMenu = @mMainMenu
    #@mCurrentMenu = @mPlayerControlsSelectMenu
  end
  def writeGameOptions
    fp = File.open("options.bin", "wb")
    fp.syswrite($g_iVersion.pack("s4"))
    game_values = $game_values
    abyte = [];
    abyte[0] =  game_values.spawnstyle;
    abyte[1] =  game_values.awardstyle; #well, this is symbol..
    abyte[2] =  $announcerlist.getCurrentIndex();
    abyte[3] =  game_values.friendlyfire ? 1:0;
    abyte[4] =  game_values.screencrunch ? 1:0;
    abyte[5] =  game_values.toplayer ? 1:0;
    abyte[6] =  game_values.scoreboardstyle;
    abyte[7] =  game_values.teamcolors ? 1:0;
    abyte[8] =  game_values.sound ? 1:0;
    abyte[9] =  game_values.music ? 1:0;
    abyte[10] =  game_values.musicvolume;
    abyte[11] =  game_values.soundvolume;
    abyte[12] =  game_values.respawn;
    abyte[13] =  $musiclist.getCurrentIndex();
    abyte[14] =  game_values.outofboundstime;
    abyte[15] =  game_values.cpudifficulty;
    abyte[16] =  0 #$menugraphicspacklist.getCurrentIndex();
    abyte[17] =  0 #$soundpacklist.getCurrentIndex();
    abyte[18] =  game_values.framelimiter;
    abyte[18] =  62 if game_values.framelimiter.nil?
    abyte[19] =  game_values.bonuswheel;
    abyte[20] =  game_values.keeppowerup ? 1:0;
    abyte[21] =  game_values.showwinningcrown ? 1:0;
    abyte[22] =  game_values.playnextmusic ? 1:0;
    abyte[23] =  game_values.pointspeed;
    abyte[24] =  game_values.swapstyle;
    abyte[25] =  0 #$gamegraphicspacklist.getCurrentIndex();
    abyte[26] =  game_values.secrets ? 1:0;
    #p game_values.framelimiter
    # 		abyte.each_with_index do |x,i|
    # 			print "#{i}:#{x}"
    # 			puts
    # 		end
    fp.syswrite(abyte.pack("c*")); 

    fp.syswrite([game_values.spawninvincibility].pack("s"));
    fp.syswrite([game_values.itemrespawntime].pack("s"));
    fp.syswrite([game_values.fireballttl].pack("s"));
    fp.syswrite([game_values.fireballlimit].pack("s"));
    fp.syswrite([game_values.hammerdelay].pack("s"));
    fp.syswrite([game_values.hammerttl].pack("s"));
    fp.syswrite([game_values.hammerpower ? 1: 0].pack("c"));
    fp.syswrite([game_values.hammerlimit].pack("s"));
    fp.syswrite([game_values.boomerangstyle].pack("s"));
    fp.syswrite([game_values.boomeranglife].pack("s"));
    fp.syswrite([game_values.boomeranglimit].pack("s"));
    fp.syswrite([game_values.featherjumps].pack("s"));
    fp.syswrite([game_values.featherlimit].pack("s"));
    fp.syswrite([game_values.shellttl].pack("s"));
    fp.syswrite([game_values.blueblockttl].pack("s"));
    fp.syswrite([game_values.storedpowerupdelay].pack("s"));
    fp.syswrite([game_values.warplocks].pack("s"));

    4.times do |i|
      2.times do |j|
		
        fp.syswrite([game_values.inputConfiguration[i][j].iDevice].pack("s"))
        fp.syswrite(game_values.inputConfiguration[i][j].inputGameControls[0].keys.pack("s*"))
        fp.syswrite(game_values.inputConfiguration[i][j].inputGameControls[1].keys.pack("s*"))
      end
    end

    4.times do |iPlayer|
      fp.syswrite([game_values.playerInput.inputControls[iPlayer].iDevice].pack("s"))
    end
    
    fp.syswrite([game_values.fullscreen ? 1:0].pack("c"))
      
    GAMEMODE_LAST.times do |k|
      iGoal = @miGoalField[k].getShortValue();
      fp.syswrite([iGoal].pack("s"));
    end
    
    NUM_POWERUPS.times do|iPowerup|
      fp.syswrite([game_values.powerupweights[iPowerup]].pack("s"));
    end
		
    #game_values.gamemodesettings
    	
    fp.syswrite(@miTeamSelect.iTeamCounts.pack("s*"));
    4.times do |iTeam|
    	#p @miTeamSelect.iTeamIDs[iTeam]
    	#puts "iteam is #{iTeam}"
    	#p @miTeamSelect.iTeamIDs[iTeam]
    	@miTeamSelect.iTeamIDs[iTeam] #must be 3 element
    	3.times do |iSlot|
    		@miTeamSelect.iTeamIDs[iTeam][iSlot] = -2 if @miTeamSelect.iTeamIDs[iTeam][iSlot].nil?
    	end
      fp.syswrite(@miTeamSelect.iTeamIDs[iTeam].pack("s3"))
      
#       .collect {|x|
#       	if !x
#       	  0
#       	else
#       	  x
#       	end}.pack("s*"));
    end
    fp.syswrite(game_values.skinids.pack("s4"));
    p game_values.randomskin
    fp.syswrite(game_values.randomskin.collect {|x|
        if x
           1
        else
           0
        end}.pack("c4")); #bool
    fp.syswrite(game_values.playercontrol.pack("s4"));

    fp.close
    
    #$maplist.writeFilters();
    #$maplist.writeMapSummaryCache();
  end
  def startGame
    @iScriptState = 2 if $debug
    @fScriptRunPreGameOptions = false if $debug
    game_values = $game_values
	  
    puts "start Game"
    game_values.gamestate = :GS_START_GAME;
	  
    #backgroundonly = false;
    #fastmap = false;
    writeGameOptions();
    #Load skins for players
    #puts "$spr_player:#$spr_player"
    #puts "#{game_values.skinids}, #{game_values.colorids}"
    4.times do |k|
      if(game_values.playercontrol[k] > 0)
        if(game_values.randomskin[k])
          begin
            game_values.skinids[k] = rand($skinlist.getCount());
          end while(!loadFullSkin($spr_player[k], game_values.skinids[k], game_values.colorids[k]));
        else
          loadFullSkin($spr_player[k], game_values.skinids[k], game_values.colorids[k]);
        end
      end
    end
    
    #Load announcer sounds if changed
    if(game_values.loadedannouncer != $announcerlist.getCurrentIndex())
      game_values.loadedannouncer = $announcerlist.getCurrentIndex();
      #Delete the old sounds
      $sfx_announcer.each do |sound|
        sound.reset()
      end
      
      announcerfile = File.open($announcerlist.current_name(), "r");
      announcerfile.each do |line|
        next if line[0] == ?# or line[0] == ' '[0] or line[0] == ?\t or line[0] == ?\n or line[0] == ?\r
        line.delete!("\r\n") #delete both \r and \n
        sound = SfxSound.new
        $sfx_announcer << sound
        if line == "[none]"
          #do nothing
        else
          sound.init(convertPath(line))
        end
      
      end
      announcerfile.close

    end
    
    #Load soundtrack music if changed
    if(game_values.loadedmusic != $musiclist.getCurrentIndex())
      game_values.loadedmusic = $musiclist.getCurrentIndex();
      #$backgroundmusic[1].load($musiclist.getMusic(0));
      #$backgroundmusic[3].load($musiclist.getMusic(2));
      #$backgroundmusic[4].load($musiclist.getMusic(3));
    end
    
    
    
    game_values.screenfade = 8;
    game_values.screenfadespeed = 8;
  end
  def menuExit
    $game_values.gamestate = :GS_QUIT;
    writeGameOptions();
  end
  def runMenu
    puts "runMenu"
    game_values = $game_values
    #Reset the keys each time we switch from menu to game and back
    game_values.playerInput.resetKeys();

    @fNeedMenuMusicReset = false;
    if(game_values.gamemode.winningteam > -1 && game_values.tournamentwinner == -1 && 
          ((!game_values.tour && game_values.bonuswheel == 2) || (game_values.tour && game_values.tourstops[game_values.tourstopcurrent - 1].fBonusWheel)))
      @miBonusWheel.reset(false);
      @mCurrentMenu = @mBonusWheelMenu;
    elsif(game_values.tour || game_values.tournament)
      @mCurrentMenu = @mTournamentScoreboardMenu;
    end
    #--------------- draw everything ----------------------
		
    realfps = 0
    flipfps = 0;
		
    #unsigned int framestart, ticks;
    #int delay;
    while true
      framestart = Timer.ticks
      #sample network code
      game_values.playerInput.clearPressedKeys(1);
		  
      while event = EventQueue.poll
        case event
        when QuitEvent
          menuExit()
          return
        when KeyDownEvent
          if event.key == K_F1
            game_values.showfps = !game_values.showfps;
          end
          if (event.mod & (0x100|0x200)) != 0
            if event.key == K_F4
              menuExit()
              return
            elsif event.key == K_RETURN
		            
              game_values.fullscreen = !game_values.fullscreen;
              $window.toggle_fullscreen 
              #gfx_setresolution(640, 480, game_values.fullscreen);
              $blitdest = $screen;
              next;
            end
          end
          if event.key == K_INSERT #...
            $g_fAutoTest = !$g_fAutoTest;
            if($g_fAutoTest)
              @mCurrentMenu = @mMainMenu
              @mCurrentMenu.resetMenu
              loadScript("Scripts/StartMenuAutomation.txt");
            end
          end if $debug
          if event.key == K_HOME
            $g_fRecordTest = !$g_fRecordTest;
		          
            if(g_fRecordTest)
              startRecordScript();
            else
              saveScript("Scripts/SavedScript.txt");
            end
          end if $debug
          if event.key == K_END
            addEmtpyLineToScript()
          end if $debug
        end
        game_values.playerInput.update(event, 1);
      end #end poll
		  
		  

      if($g_fAutoTest)
        getNextScriptOperation() 
      end if $debug
  
      if($g_fRecordTest)
        setNextScriptOperation() 
      end if $debug

      fGenerateMapThumbs = false
      if(:GS_MENU == game_values.gamestate)
        code = @mCurrentMenu.sendInput(game_values.playerInput);
        puts "code:#{code}" if code!=0
        fShowSettingsButton = [false, false, false, true, true, true, false, true, true, true, true, true, true, true, false, true, true]
        if(MENU_CODE_EXIT_APPLICATION == code)
          menuExit();
          return;
				  
        elsif(MENU_CODE_TO_MAIN_MENU == code)
          @iDisplayError = DISPLAY_ERROR_NONE;
          @iDisplayErrorTimer = 0;

          @mCurrentMenu = @mMainMenu;
        elsif(MENU_CODE_TO_OPTIONS_MENU == code)
          @mCurrentMenu = @mOptionsMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_BACK_TO_OPTIONS_MENU == code)
          @mCurrentMenu = @mOptionsMenu;
        elsif(MENU_CODE_BACK_TO_GRAPHIC_OPTIONS_MENU == code)
          @mCurrentMenu = @mGraphicsOptionsMenu;
        elsif(MENU_CODE_TO_CONTROLS_MENU == code)
          puts "select controls menu"
          @mCurrentMenu = @mPlayerControlsSelectMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_BACK_TO_CONTROLS_MENU == code)
          @mCurrentMenu = @mPlayerControlsSelectMenu;
        elsif(MENU_CODE_TO_PLAYER_1_CONTROLS == code)
          @miInputContainer.setPlayer(0);
          @mCurrentMenu = @mPlayerControlsMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_TO_PLAYER_2_CONTROLS == code)
          @miInputContainer.setPlayer(1);
          @mCurrentMenu = @mPlayerControlsMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_TO_PLAYER_3_CONTROLS == code)
          @miInputContainer.setPlayer(2);
          @mCurrentMenu = @mPlayerControlsMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_TO_PLAYER_4_CONTROLS == code)
          @miInputContainer.setPlayer(3);
          @mCurrentMenu = @mPlayerControlsMenu;
          @mCurrentMenu.resetMenu();
        elsif MENU_CODE_TO_TEAM_SELECT_MENU == code
          #require 'debug'
          @miTeamSelect.reset();
          @mCurrentMenu = @mTeamSelectMenu;
          @mCurrentMenu.resetMenu();
        elsif MENU_CODE_TO_GAME_SETUP_MENU == code
          $score_cnt = @miTeamSelect.organizeTeams();
          game_values.tour = false;
          @iDisplayError = DISPLAY_ERROR_NONE;
          @iDisplayErrorTimer = 0;
				  
          fErrorReadingTourFile = false
          if(game_values.tournamentgames > 10)
            game_values.tour = true;
            #if(!ReadTourFile())
            #  game_values.tour = false;
            #	@iDisplayError = DISPLAY_ERROR_READ_TOUR_FILE;
            #	@iDisplayErrorTimer = 120;
            #	fErrorReadingTourFile = true;
            #else
            #@miTournamentScoreboard->CreateScoreboard(score_cnt, game_values.tourstoptotal, &spr_tour_markers, true);
            #end
          else
            #@miTournamentScoreboard->CreateScoreboard(score_cnt, game_values.tournamentgames, &menu_mode_large, false);
          end
          if(!fErrorReadingTourFile)
            if(game_values.tour)
              @mCurrentMenu = @mTourStopMenu;
              @mCurrentMenu.resetMenu();
            else
              #$maplist.findexact(@szCurrentMapName);
              #@miMapField->LoadCurrentMap();
				      
              #game_values.gamemode = $gamemodes[@miModeField->GetShortValue()];
              GAMEMODE_LAST.times do |iMode|
                #$gamemodes[iMode]->goal = @miGoalField[iMode]->GetShortValue();
              end
              #@miModeSettingsButton->Show(fShowSettingsButton[@miModeField->GetShortValue()]);
				      
              @mCurrentMenu = @mGameSettingsMenu;
              @mCurrentMenu.resetMenu();
            end
          end
        elsif(MENU_CODE_BACK_TO_GAME_SETUP_MENU == code)  
          #todo
        elsif(MENU_CODE_BACK_TO_GAME_SETUP_MENU_FROM_MODE_SETTINGS == code)
          @mCurrentMenu = @mGameSettingsMenu;
        elsif(MENU_CODE_TOURNAMENT_CHANGED == code)
          #todo
        elsif(MENU_CODE_BACK_TEAM_SELECT_MENU == code)
          #todo: more handling for tour/tournaments
          @mCurrentMenu = @mTeamSelectMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_START_GAME == code)
          startGame();
        elsif(MENU_CODE_MODE_CHANGED == code)
          game_values.gamemode = $gamemodes[@miModeField.getShortValue()];
          @miModeSettingsButton.show(fShowSettingsButton[@miModeField.getShortValue()]);
  
          GAMEMODE_LAST.times do |iMode|
            @miGoalField[iMode].show(@miModeField.getShortValue() == iMode);
          end
        elsif (MENU_CODE_MAP_FILTER_EXIT == code)
          
          puts "MENU_CODE_MAP_FILTER_EXIT"
          
          $maplist.applyFilters(game_values.pfFilters);
          #If the filtered map list has at least 1 map in it, then allow exiting the filter menu
          if($maplist.mapInFilteredSet())
          
            @miMapField.loadCurrentMap();
            @szCurrentMapName = @miMapField.getMapName();
	
            @miMapFilterScroll.show(false);
					
            @mGameSettingsMenu.setHeadControl(@miSettingsStartButton);
            @mGameSettingsMenu.setCancelCode(MENU_CODE_BACK_TEAM_SELECT_MENU);
	
            @mGameSettingsMenu.restoreCurrent();
	
            @iDisplayError = DISPLAY_ERROR_NONE;
	
            @miMapFiltersOnImage.show(game_values.fFiltersOn);
          else  #otherwise display a message
            @iDisplayError = DISPLAY_ERROR_MAP_FILTER;
            @iDisplayErrorTimer = 120;
          end
          
        elsif(MENU_CODE_TO_MAP_FILTERS == code)
          @miMapFilterScroll.show(true);
          @mGameSettingsMenu.rememberCurrent();
	
          @mGameSettingsMenu.setHeadControl(@miMapFilterScroll);
          @mGameSettingsMenu.setCancelCode(MENU_CODE_NONE);
          @mGameSettingsMenu.resetMenu();
        elsif(MENU_CODE_TO_MAP_FILTER_EDIT == code)
          @miMapBrowser.reset(0);
					
          @mCurrentMenu = @mMapFilterEditMenu;
          @mCurrentMenu.resetMenu();
        elsif(MENU_CODE_MAP_BROWSER_EXIT == code)
          @miMapField.loadCurrentMap();
          @szCurrentMapName = @miMapField.getMapName();
	
          @mCurrentMenu = @mGameSettingsMenu;
          #mCurrentMenu->ResetMenu();
        elsif(MENU_CODE_TO_MAP_BROWSER_THUMBNAILS == code)
          @miMapBrowser.reset(1);
	
          @mCurrentMenu = @mMapFilterEditMenu;
          @mCurrentMenu.resetMenu();
        elsif (MENU_CODE_TO_SOUND_OPTIONS_MENU == code)
          @mCurrentMenu = @mSoundOptionsMenu;
          @mCurrentMenu.resetMenu();
        end
      end #end game.state = :GS_MENU
		  
      $window.fill([0,0,0,0])
      $menu_backdrop.draw(0,0);
      
      @mCurrentMenu.update();
      @mCurrentMenu.draw();
  		
      if(@iDisplayError > DISPLAY_ERROR_NONE)
        $spr_selectfield.draw(70, 400, 0, 0, 484, 32);
        $spr_selectfield.draw(554, 400, 496, 0, 16, 32);
			  
        if(@iDisplayError == DISPLAY_ERROR_READ_TOUR_FILE)
          $menu_font_large.drawCentered(320, 405, "Error Reading Tour File!");
        elsif(@iDisplayError == DISPLAY_ERROR_MAP_FILTER)
          $menu_font_large.drawCentered(320, 405, "No Maps Meet All Filter Conditions!");
        end
        @iDisplayErrorTimer -=1
        if(@iDisplayErrorTimer == 0)
          @iDisplayError = DISPLAY_ERROR_NONE;
        end
      end
  	  
      if(game_values.screenfadespeed != 0)
        game_values.screenfade += game_values.screenfadespeed;
        if(game_values.screenfade <= 0)
          game_values.screenfadespeed = 0;
          game_values.screenfade = 0;
        elsif(game_values.screenfade >= 255)
          game_values.screenfadespeed = 0;
          game_values.screenfade = 255;
        end
      end
  	  
      if(game_values.screenfade > 0)
        $menu_shade.set_alpha(game_values.screenfade);
        $menu_shade.draw(0, 0);
      end
  		
      if (:GS_START_GAME == game_values.gamestate && game_values.screenfade == 255)
        game_values.gamestate = :GS_GAME;
  		  
  		  
        $g_map.loadMap($maplist.currentFilename(), read_type_full);
        $g_map.predrawbackground($spr_background, $spr_backmap);
        $g_map.predrawforeground($spr_frontmap);
        loadMapObjects();
        #require 'debug'
        if(game_values.music)
          #$musiclist.setRandomMusic($g_map.musicCategoryID, $maplist.currentShortmapname(), $g_map.szBackgroundFile);
          $musiclist.setRandomMusic(1, $maplist.currentShortmapname(), $g_map.szBackgroundFile);
          $backgroundmusic[0].load($musiclist.getCurrentMusic());
          $backgroundmusic[0].play(game_values.playnextmusic, false);
        end
  
        return;
      end
  	  
      if(@fGenerateMapThumbs)
        $menu_font_large.drawCentered(320, 405, "Refreshing Map Thumbnails");
        $menu_font_large.drawCentered(320, 430, "Please Wait...");
      end
  		
      ticks = Timer.ticks - framestart;
      if(ticks == 0)
        ticks = 1;
      end
			
      if(game_values.showfps) 
        $menu_font_large.drawf(0, 480 - $menu_font_large.getHeight(), "Actual:%.1f/%.1f, Flip:%.1f, Potential:%.1f", realfps, 1000.0 / WAITTIME, flipfps, 1000.0 / ticks);
      end
			
      if($g_fAutoTest)
        $menu_font_small.drawRightJustified(635, 5, "Auto") 
      end if $debug

      if($g_fRecordTest)
        $menu_font_small.drawRightJustified(635, 5, "Recording...")
      end if $debug
  		
      $window.flip
  		
      flipfps = 1000.0 / ticks;
  		
      delay = WAITTIME - (Timer.ticks - framestart);
      if(delay < 0)
        delay = 0;
      elsif(delay > WAITTIME)
        delay = WAITTIME;
      end
      Timer.delay(delay)
  		
      realfps = 1000.0 / ticks;
    end
  end
  
  def loadScript(filename)
  end
  
  def startRecordScript()
  end
  def saveScript(filename)
  end
  
  def addEmtpyLineToScript()
    
  end
  
  def getNextScriptOperation
    
  end
  
  def setNextScriptOperation
  end
  
  

		
end


#end