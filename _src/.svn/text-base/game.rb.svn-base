$list_players = []
$list_players_cnt = 0
require 'player'
def runGame
  
  
  game_values = $game_values
  #unsigned int	framestart, ticks;
  #SDL_Event		event;
  #short			i, j;
  realfps = 0
  flipfps = 0;

  #Reset the keys each time we switch from menu to game and back
  game_values.playerInput.resetKeys();
	
  $y_shake = 0;
  $x_shake = 0;
  
  projectiles = []
  $respawncounter = []
  4.times do |iPlayer|
    projectiles[iPlayer] = 0;
    
    if(game_values.playercontrol[iPlayer] > 0)
      #short teamid, subteamid;
      teamid,subteamid = lookupTeamID(iPlayer);

      ai = CPlayerAI.new if(game_values.playercontrol[iPlayer] == 2)

      $list_players[$list_players_cnt] = CPlayer.new(iPlayer, $list_players_cnt, teamid, subteamid, game_values.colorids[iPlayer], $spr_player[iPlayer], $score[teamid], iPlayer, ai);
      $list_players_cnt+=1;
    elsif(!game_values.keeppowerup)
      #Reset off players stored powerups
      game_values.storedpowerups[iPlayer] = -1;
    end
		
    game_values.gamepowerups[iPlayer] = (game_values.gamemode.gamemode == game_mode_boss ? -1 : game_values.storedpowerups[iPlayer]);
    game_values.bulletbilltimer[iPlayer] = 0;
    game_values.bulletbillhoming[iPlayer] = false;
    game_values.bulletbillspawntimer[iPlayer] = 0;
  end
	
  game_values.gamemode.init();
  game_values.pausegame = false;
  game_values.exitinggame = false;
  game_values.exityes = false;
  game_values.teamdeadcounter = 0;
  game_values.screenshaketimer = 0;
  game_values.slowdownon = -1;
  game_values.slowdowncounter	= 0;
  game_values.slowdownfreeze	= false;
  game_values.showscoreboard = false;
  game_values.scorepercentmove = 0.0
  game_values.playskidsound = false;
  game_values.playinvinciblesound = false;
  game_values.swapplayers = false;
  game_values.swapplayersposition = 0.0
  game_values.swapplayersblink = false;
  game_values.swapplayersblinkcount = 0;
  game_values.screenfade = 255;
  game_values.screenfadespeed = -8;
  game_values.redkoopas = false;
  game_values.redthrowblocks = false;
  game_values.viewblocks = false;
  game_values.bosspeeking = -1;
  game_values.noexit = false;
  game_values.enemyhammerkills = 0;
	
  totalspace = 0;
  $score_cnt.times do |i|
    totalspace += 56 + game_values.teamcounts[i] * 34;
  end
  totalspace += 20 * ($score_cnt - 1);
  score = $score
  $score_cnt.times do |i|
    if(game_values.scoreboardstyle == 0 || game_values.scoreboardstyle == 1)
      score[i].x = ((640 - totalspace) >> 1);

      i.times do |k|
        score[i].x += 76 + game_values.teamcounts[k] * 34;
      end

      score[i].y = 5 + (game_values.scoreboardstyle == 1 ? 429 : 0);
    else
      score[i].x = 5 + (574 - (34 * game_values.teamcounts[i])) * (i % 2);
      score[i].y = 5 + 429 * (i > 1 ? 1 : 0);
    end
    score[i].fromx = score[i].x;
    score[i].fromy = score[i].y;
    score[i].place = i;
    score[i].order = -1;
  end
  g_map = $g_map
  eyecandyfront = $eyecandyfront
  eyecandyback =  $eyecandyback
  
  if(g_map.eyecandyID == 1)
    4.times do |i|
      c = rand(2);	#cloud type (0... small cloud, 1... big cloud)
      #float velx;			#speed of cloud, small clouds are slower than big ones
      if(c == 0)
        velx = (rand(51)-25)/10.0;	#big clouds: -3 - +3 pixel/frame
      else
        velx = (rand(41)-20)/10.0;	#small clouds: -2 - +2 pixel/frame
      end
			
      velx = velx < 0.5 && velx > -0.5 ? 1 : velx;	#no static clouds please

      #add cloud to eyecandy array
      eyecandyfront.add(EC_Cloud.new($spr_clouds[c], rand(640), rand(100), velx));
    end
  elsif(g_map.eyecandyID == 2)
    12.times do |i|
      c = rand(3) ;	#ghost type
      velx = (rand()%51-25)/10.0;	#big clouds: -3 - +3 pixel/frame
			
      velx = velx < 0.5 && velx > -0.5 ? (rand(2) % 1 ? 1.0 : -1.0) : velx;	#no static clouds please

      #add cloud to eyecandy array
      eyecandyfront.add(EC_Ghost.new($spr_ghosts[c], rand(640), rand(100), velx, 8, 2));
    end
  end
  
  iScoreTextOffset = [];
  $score_cnt.times do |iTeam|
    iScoreTextOffset[iTeam] = 34 * game_values.teamcounts[iTeam] + 1;
  end
  list_players_cnt = $list_players_cnt
  list_players = $list_players
  while (true)
    framestart = Timer.ticks();
    endgametimer = rand(200);
		
    if($g_fAutoTest && !game_values.swapplayers)
      $list_players_cnt.times do |k|
        if list_players[k].isready()
        end
      end
    end
	  
    game_values.playerInput.clearPressedKeys(game_values.exitinggame ? 1 : 0);
	  
    while event = EventQueue.poll
      case event
      when QuitEvent
        cleanUp()
        game_values.gamestate = :GS_QUIT;
        return
      when KeyDownEvent
        if event.key == K_F1
          game_values.showfps = !game_values.showfps;
        end
        if (event.mod & (0x100|0x200)) != 0
          if event.key == K_F4
            cleanUp();
            game_values.gamestate = :GS_QUIT;
            return
          elsif event.key == K_RETURN
			            
            game_values.fullscreen = !game_values.fullscreen;
            $window.toggle_fullscreen 
            #gfx_setresolution(640, 480, game_values.fullscreen);
            $blitdest = $screen;
            next;
          end
        end
        if(event.key == K_ESCAPE)
          game_values.playerInput.outputControls[0].game_cancel.fPressed = true;
        elsif(event.key == K_TAB)
          #playNextMusicTrack();
        end
        if $debug
          if(event.key == K_F2)
            game_values.frameadvance = !game_values.frameadvance;
          elsif(event.key == K_F5)
            game_values.autokill = !game_values.autokill;
          elsif(event.key == K_z)
            $list_players_cnt.times do |k|
              #list_players[k].deathAwards();
	
              #if(!game_values.gamemode.playerkilledself(*(list_players[k])))
              #	list_players[k].die(0, false);
              #end
            end
            #todo: a lot of more keys to insert here
          elsif(event.key.keysym.sym == SDLK_INSERT)
            $g_fAutoTest = !$g_fAutoTest;
          end
        end
       
      end #end case condition
      game_values.playerInput.update(event, (game_values.exitinggame ? 1 : 0));
      
    end #end poll
    
    #pretty much start here
    sfx_invinciblemusic = $sfx_invinciblemusic
    sfx_slowdownmusic = $sfx_slowdownmusic
    sfx_secret = $sfx_secret
    sfx_bowserlaugh = $sfx_bowserlaugh
    sfx_timewarning = $sfx_timewarning
    sfx_pause = $sfx_pause
    
    if(game_values.screenfade == 0)
      #$g_index ||= 0
     
      
      #$g_index+=1
      4.times do |iPlayer|
      	playerKeys = game_values.playerInput.outputControls[iPlayer];
      	#If the start key is pressed (pause key)
      	if(playerKeys.game_start.fPressed)
      	  if(!game_values.showscoreboard && !game_values.exitinggame)
      	    game_values.pausegame = !game_values.pausegame;
      	    if(game_values.pausegame)
              $menu_shade.set_alpha(getScreenBackgroundFade());
              $menu_shade.draw(0, 0);
            end
            ifsoundonpause(sfx_invinciblemusic);
            ifsoundonpause(sfx_slowdownmusic);
            ifsoundonplay(sfx_pause);
      	  end
        end
        
        #If the cancel button is pressed
        if((playerKeys.game_cancel.fPressed || (playerKeys.game_start.fPressed && game_values.gamemode.gameover)) && isExitAllowed())
          if(game_values.gamemode.gameover)
            if(game_values.tournament)
              updateScoreBoard();
            end
            cleanUp();
            game_values.gamestate = :GS_MENU;

            return;
          else
            if(!game_values.pausegame && !game_values.exitinggame)
              $menu_shade.set_alpha(getScreenBackgroundFade());
              $menu_shade.draw(0, 0);
              game_values.exitinggame = true;
              ifsoundonpause(sfx_invinciblemusic);
              ifsoundonpause(sfx_slowdownmusic);

              #Reset the keys each time we switch from menu to game and back
              game_values.playerInput.resetKeys();
            end
          end
        end #if game_cancel
        #Deal with input to game exit dialog box
        if(game_values.exitinggame)
          if(playerKeys.menu_left.fPressed)
            game_values.exityes = true;
          elsif(playerKeys.menu_right.fPressed)
            game_values.exityes = false;
          end
          if(playerKeys.menu_select.fPressed)
            if(game_values.exityes)
              cleanUp();
              game_values.exitinggame = false;
              game_values.exityes = false;
              game_values.gamestate = :GS_MENU;
              return;
            else
              game_values.exitinggame = false;
              ifsoundonpause(sfx_invinciblemusic);
              ifsoundonpause(sfx_slowdownmusic);

              #Reset the keys each time we switch from menu to game and back
              game_values.playerInput.resetKeys();
            end
          end
        end #end if exitinggame
      end
    end #end if game screenfade == 0
    
    objectblocks = $objectblocks
    objectcollisionitems = $objectcollisionitems
    objectsfront = $objectsfront
    objectsplayer = $objectsplayer
    
    if(!game_values.pausegame && !game_values.exitinggame)
      
      if(!game_values.swapplayers && game_values.screenfade == 0)
        shakekiller
        
        4.times do |iPlayer|
          if(game_values.bulletbilltimer[iPlayer] > 0)
            game_values.bulletbilltimer[iPlayer]-= 1
            game_values.bulletbillspawntimer[iPlayer] -= 1
            if(game_values.bulletbillspawntimer[iPlayer] <= 0)
              game_values.bulletbillspawntimer[iPlayer] = rand(20) + 25;
              speed = (rand(21) + 20) / 10.0;
              objectsfront.add(OMO_BulletBill.new($spr_bulletbill, rand(448), (rand(2) == 0 ? speed : -speed), iPlayer, game_values.bulletbillhoming[iPlayer]));
              ifsoundonplay($sfx_bulletbillsound);
            end
          end
        end
        
        #------------- update objects -----------------------
        if(game_values.autokill)
          $list_players_cnt.times do |k|
            list_players[k].deathAwards();
            if(!game_values.gamemode.playerkilledself(list_players[k]))
              list_players[k].die(0, false);
            end
          end
        end if $debug
        
        game_values.cputurn += 1
        if(game_values.cputurn > 3)
          game_values.cputurn = 0
        end
        
        #Player to player collisions
        $list_players_cnt.times do |i|
          if(list_players[i].state > player_dead)
            (i+1).upto($list_players_cnt - 1) do |j|
              if(list_players[j].state > player_dead)
                if(coldec_player2player(list_players[i], list_players[j]))
                  #puts "coldec_player2player player"
                  collisionhandler_p2p(list_players[i], list_players[j])
        	  	    
                  #if player was killed by another player, continue with next player for collision detection
                  break if list_players[i].state <= player_dead
                end
              end
            end
          end
        end
        
        g_map.updatePlatforms();
        
        game_values.playskidsound = false;
        game_values.playinvinciblesound = false;
				
        $list_players_cnt.times do |i|
          list_players[i].move(); #move all objects before doing object-object collision detection in
          #->think(), so we test against the new position after object-map collision detection
        end
				
        #todo:remove this
        $eyecandyfront.cleandeadobjects();
        $eyecandyback.cleandeadobjects();
        $objectsfront.cleandeadobjects();
        $objectsplayer.cleandeadobjects();
        $objectcollisionitems.cleandeadobjects();
        $objectblocks.cleandeadobjects();
        #cleanDeadPlayers();
				
        $eyecandyfront.update();
        $eyecandyback.update();
        game_values.gamemode.think();
        
        if(game_values.slowdownon != -1)
          if(!$sfx_slowdownmusic.isplaying())
								ifsoundonplay($sfx_slowdownmusic);
					end
					game_values.slowdowncounter += 1
					if(game_values.slowdowncounter > 580)
						game_values.slowdownon = -1;
						game_values.slowdowncounter = 0;
						game_values.slowdownfreeze = false;
					end
			  else
			    if($sfx_slowdownmusic.isplaying())
						ifsoundonstop($sfx_slowdownmusic);
					end
        end
        
        g_map.update();
        
        if($y_shake > 0)
							$y_shake -= CRUNCHVELOCITY;

							if($y_shake < 0)
								$y_shake = 0;
							end
				end
				
				if(game_values.showscoreboard)
				  if(game_values.scorepercentmove < 1.0)
				    game_values.scorepercentmove += 0.01;
				    
				    if(game_values.scorepercentmove >= 1.0)
							game_values.scorepercentmove = 1.0;
						end
					else
					  game_values.scorepercentmove = 1.0;
				  end
				  
				  $score_cnt.times do |i|
						$score[i].x = ((score[i].destx - score[i].fromx) * game_values.scorepercentmove).to_i + score[i].fromx;
						$score[i].y = ((score[i].desty - score[i].fromy) * game_values.scorepercentmove).to_i + score[i].fromy;
					end
			  end
        
        #todo
        if(!game_values.swapplayers)
          if(game_values.playskidsound)
            if(!$sfx_skid.isplaying())
              ifsoundonplay($sfx_skid);
            end
          else
            if($sfx_skid.isplaying())
              ifsoundonstop($sfx_skid);
            end
          end
          objectblocks.update();
          objectcollisionitems.update();
          objectsfront.update();
          objectsplayer.update();
          
          $list_players_cnt.times do |i|
            next if(list_players[i].state != player_ready)
            #Collide with collision detected objects
            $objectcollisionitems.each do |item|
              #require'debug'
              if(!item.dead && item.getState() >= 1)
                if(coldec_player2obj(list_players[i], item))
                  puts "coldec_player with object"
                  if(collisionhandler_p2o(list_players[i], item))
                    break
                  end
                end
              end
          	  
            end
          	
            next if(list_players[i].state != player_ready)
          	
            break if (game_values.swapplayers)
          	
            #Collide with player objects
            objectsplayer.each do |item|
              if(!item.dead)
                if(coldec_player2obj(list_players[i], item))
                  break if collisionhandler_p2o(list_players[i], item)
                end
              end
            end
          	
            next if(list_players[i].state != player_ready)
          	
            #Collide with front objects
            objectsfront.each do |item|
              if(!item.dead)
                if(coldec_player2obj(list_players[i], item))
                  break if collisionhandler_p2o(list_players[i], item)
                end
              end
            end
          	
          end #end of $list_players_cnt
          
          if(!game_values.swapplayers) #still a lot of logic
            #moving object to moving object collisions
          end
        end #the first time !game_values.swapplayers
      end #the outer !game_values.swapplayers
      if(game_values.swapplayers)
        $list_players_cnt.times do |i|
          $list_players[i].updateswap();
        end
      end
      if(game_values.gamestate == :GS_START_GAME && game_values.screenfade == 255)
        cleanUp()
        
        game_values.gamestate = :GS_GAME;
        game_values.gamemode = bossgamemode;  #boss type has already been set at this point
				
        if(bossgamemode.getBossType() == 0)
          g_map.loadMap(convertPath("maps/special/dungeon.map"), read_type_full);
        elsif(bossgamemode.getBossType() == 1)
          g_map.loadMap(convertPath("maps/special/hills.map"), read_type_full);
        elsif(bossgamemode.getBossType() == 2)
          g_map.loadMap(convertPath("maps/special/volcano.map"), read_type_full);
        end
        filename = "gfx/packs/backgrounds/#{g_map.szBackgroundFile}"
        #$gamegraphicspacklist.current_name()
        gamegraphicspacklist_current_name = "Classic"
        path = convertPath(filename, gamegraphicspacklist_current_name);
        
        #if the background file doesnt exist, use the classic background
        if(!File.exist?(path))
          path = convertPath("gfx/packs/backgrounds/Land_Classic.png", gamegraphicspacklist_current_name);
        end
        puts "loading $spr_background, #$spr_background"
        __load_gfx($spr_background, path);
				
        g_map.predrawbackground(spr_background, spr_backmap);
        g_map.predrawforeground(spr_frontmap);
        loadMapObjects();
	
        if(game_values.music)
          
          $musiclist.setRandomMusic(g_map.musicCategoryID, "", "");
          $backgroundmusic[0].load($musiclist.getCurrentMusic());
          $backgroundmusic[0].play(game_values.playnextmusic, false);
        end
        return
      end
      if(game_values.playinvinciblesound)
        #         if(!sfx_secret.isplaying() && !sfx_bowserlaugh.isplaying() && !sfx_invinciblemusic.isplaying() && !sfx_timewarning.isplaying() && !backgroundmusic[0].isplaying())
        # 					ifsoundonplay(sfx_invinciblemusic);
        # 				end
      else
        # 			  if(sfx_invinciblemusic.isplaying())
        # 					ifsoundonstop(sfx_invinciblemusic);
        # 				end
      end
      backgroundmusic = $backgroundmusic
      musiclist = $musiclist
      #If no background music is playing, then play some
      if(!backgroundmusic[0].isplaying() && !sfx_invinciblemusic.isplaying() && !sfx_secret.isplaying() && !sfx_bowserlaugh.isplaying() && !sfx_timewarning.isplaying() && !game_values.gamemode.gameover)

        if(game_values.playnextmusic)
          musiclist.setNextMusic(g_map.musicCategoryID, $maplist.currentShortmapname(), $g_map.szBackgroundFile);
          backgroundmusic[0].load(musiclist.getCurrentMusic());
        end
       
        backgroundmusic[0].play(game_values.playnextmusic, false);
      end
      
      #draw everything
      if($y_shake > 0)
        $window.fill([0,0,0], [0, 0, 640, $y_shake]);		#fill empty area with black
      end
      
      $spr_backmap.draw(0, 0);
      $g_map.drawbackanimations();
      
      #require 'TextInput'
      
      #draw back eyecandy behind players
      $objectblocks.draw();
      eyecandyback.draw();
			
      $objectcollisionitems.draw();
			
      if(!game_values.swapplayers)
        $list_players_cnt.times do|i|
          list_players[i].draw();
        end
      end
      $objectsplayer.draw();

      $g_map.drawPlatforms();
			
      if(game_values.toplayer)
        $g_map.drawfrontlayer();
        $g_map.drawfrontanimations();
      end
			
      $g_map.drawWarpLocks();
      # 			
      objectsfront.draw();
      
      eyecandyfront.draw();
      game_values.gamemode.draw();

      $g_iWinningPlayer = -1;
      mostkills = 0;
			
      fReverseScoring = game_values.gamemode.getReverseScoring();
      if(fReverseScoring)
        mostkills = 32000;
      end
			
      $score_cnt.times do|i|
        if(($score[i].score > mostkills && !fReverseScoring) || ($score[i].score < mostkills && fReverseScoring))
          mostkills = $score[i].score;
          $g_iWinningPlayer = i;
        elsif($score[i].score == mostkills)
          $g_iWinningPlayer = -1;
        end
      end

      #big end game scoreboard (sorted)
      if(game_values.showscoreboard)
        gameovertext = "";
        if(game_values.gamemode.winningteam > -1)
          if(game_values.teamcounts[game_values.gamemode.winningteam] == 1)
            gameovertext = "Player %d Wins!" % game_values.teamids[game_values.gamemode.winningteam][0] + 1;
          else
            gameovertext = "Team %d Wins!" % game_values.gamemode.winningteam + 1;
          end
        else
          gameovertext = "Tie Game";
        end
 					
        game_font_large.drawCentered(320, 100, gameovertext);
      end
      #in game scoreboards
      $score_cnt.times do |i|
        #$spr_shade.each {|x| x.set_alpha(255)}; #not work
        $spr_shade[game_values.teamcounts[i] - 1].draw(score[i].x, score[i].y);
           
        game_values.teamcounts[i].times do |k|

          globalID = game_values.teamids[i][k];
           
          #If player is respawning, draw the egg
          if($respawn[globalID] > 0 && !game_values.gamemode.gameover)
            $spr_spawneggs.draw(score[i].x + $scoreoffsets[k], score[i].y + 2, (($respawn[globalID] - 1) >> 1) * 32, game_values.colorids[@globalID] * 32, 32, 32);
          else  #otherwise draw the players skin in the scoreboard
          
            if(game_values.gamemode.gameover)
              if($g_iWinningPlayer != i)
                iScoreboardSprite = PGFX_DEADFLYING;
              else
                iScoreboardSprite = PGFX_JUMPING_R;
              end
            else
              iScoreboardSprite = PGFX_STANDING_R;
            end
           						
            #Search for player state to display
            player = getPlayerFromGlobalID(globalID);
           						
            if(player && !game_values.gamemode.gameover)
              iScoreOffsetX = score[i].x + $scoreoffsets[k];
              iScoreOffsetY = score[i].y + 2;
           
              if(player.ownerPlayerID > -1)
                $spr_ownedtags.draw(iScoreOffsetX - 8, iScoreOffsetY - 8, player.ownerColorOffsetX, 0, 48, 48);
              end
           	
              player.getScoreboardSprite()[iScoreboardSprite].draw(iScoreOffsetX, iScoreOffsetY, player.iSrcOffsetX, 0, 32, 32);
           
              if(player.jailed > 0)
                $spr_jail.draw(iScoreOffsetX - 6, iScoreOffsetY - 6);
              end	
           
              if(player.powerup > 0)
                $spr_storedpowerupsmall.draw(iScoreOffsetX, iScoreOffsetY + 16, $g_iPowerupToIcon[player.powerup - 1], 0, 16, 16);
              else
                $spr_player[globalID][iScoreboardSprite].draw(score[i].x + $scoreoffsets[k], score[i].y + 2, 0, 0, 32, 32);
              end
           					
              #give crown to player(s) with most kills
              if($g_iWinningPlayer == i)
                $spr_crown.draw(score[i].x + $scoreoffsets[k] + 12, score[i].y - 4);
              end
           					  
              storedpowerupid = game_values.gamepowerups[globalID];
           
              if(storedpowerupid != -1)
                if(!game_values.swapplayers)
                  $spr_storedpowerupsmall.draw(score[i].x + $scorepowerupoffsets[game_values.teamcounts[i] - 1][k], score[i].y + 25, storedpowerupid * 16, 0, 16, 16);
                end
              end
            end
          end            
          iScoreX = score[i].x + iScoreTextOffset[i];
          iScoreY = score[i].y + 4;

          $spr_scoretext.draw(iScoreX, iScoreY, score[i].iDigitLeft, (score[i].iDigitLeft == 0 ? 16 : 0), 16, 16);
          $spr_scoretext.draw(iScoreX + 18, iScoreY, score[i].iDigitMiddle, (score[i].iDigitLeft == 0 && score[i].iDigitMiddle == 0 ? 16 : 0), 16, 16);
          $spr_scoretext.draw(iScoreX + 36, iScoreY, score[i].iDigitRight, 0, 16, 16);
        end #end draw in game scoreboard
      end
      #draw arrows for being above the top of the screen
      $list_players_cnt.times do|i|
        $list_players[i].drawarrows();
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
			
      # 			if(game_values.swapplayers)
      # 			{
      # 				for(i = 0; i < list_players_cnt; i++)
      # 				{
      # 					list_players[i]->drawswap();
      # 
      # 					short storedpowerupid = game_values.gamepowerups[list_players[i]->getGlobalID()];
      # 
      # 					if(storedpowerupid != -1)
      # 					{
      # 						short iPowerupX, iPowerupY;
      # 
      # 						if(game_values.swapstyle == 1)
      # 						{
      # 							iPowerupX = game_values.swapplayersblink ? list_players[i]->iOldPowerupX : list_players[i]->iNewPowerupX;
      # 							iPowerupY = game_values.swapplayersblink ? list_players[i]->iOldPowerupY : list_players[i]->iNewPowerupY;
      # 						}
      # 						else
      # 						{
      # 							iPowerupX = (short)((float)(list_players[i]->iNewPowerupX - list_players[i]->iOldPowerupX) * game_values.swapplayersposition) + list_players[i]->iOldPowerupX;
      # 							iPowerupY = (short)((float)(list_players[i]->iNewPowerupY - list_players[i]->iOldPowerupY) * game_values.swapplayersposition) + list_players[i]->iOldPowerupY;
      # 						}
      # 
      # 						spr_storedpowerupsmall.draw(iPowerupX, iPowerupY, storedpowerupid * 16, 0, 16, 16);
      # 					}
      # 				}
      # 
      # 				if(game_values.swapstyle == 0)
      # 				{
      # 					if(!sfx_skid.isplaying())
      # 						ifsoundonplay(sfx_skid);
      # 				}
      # 
      # 				if(++game_values.swapplayersblinkcount > 10)
      # 				{
      # 					game_values.swapplayersblinkcount = 0;
      # 					game_values.swapplayersblink = !game_values.swapplayersblink;
      # 				}
      # 
      # 				game_values.swapplayersposition += 0.02f;
      # 				if(game_values.swapplayersposition >= 1.0f)
      # 				{
      # 					game_values.swapplayersposition = 0.0f;
      # 					game_values.swapplayers = false;
      # 					game_values.screenfade = 0;
      # 					
      # 					if(game_values.swapstyle == 0)
      # 						ifsoundonstop(sfx_skid);
      # 
      # 					ifsoundonplay(sfx_transform);
      # 
      # 					if(game_values.swapstyle == 1)
      # 					{
      # 						for(i = 0; i < list_players_cnt; i++)
      # 							eyecandyfront.add(new EC_SingleAnimation(&spr_fireballexplosion, list_players[i]->ix + (HALFPW) - 16, list_players[i]->iy + (HALFPH) - 16, 3, 8));
      # 					}
      # 				}
      # 			}
    else
      if(game_values.pausegame)
        
        $spr_dialog.draw(224, 176);
        $menu_font_large.drawCentered(320, 240 - ($menu_font_large.getHeight() >> 1), "Pause");
      end

      if(game_values.exitinggame)
        $spr_dialog.draw(224, 176);
        $menu_font_large.drawCentered(320, 220 - ($menu_font_large.getHeight() >> 1), "Exit Game");

        $spr_dialogbutton.draw(235, 250, 0, (game_values.exityes ? 34 : 0), 80, 34);
        $spr_dialogbutton.draw(325, 250, 0, (game_values.exityes ? 0 : 34), 80, 34);
			
        $menu_font_large.draw(275 - ($menu_font_large.getWidth("Yes") >> 1),  269 - ($menu_font_large.getHeight() >> 1), "Yes");
        $menu_font_large.draw(365 - ($menu_font_large.getWidth("No") >> 1),  269 - ($menu_font_large.getHeight() >> 1), "No");
      end
			
			
    end
		
    ticks = Timer.ticks - framestart;
    if(ticks == 0)
      ticks = 1;
    end
		
    if(game_values.showfps)
      potentialFps = 1000.0 / (game_values.framelimiter == 0 ? 1 : game_values.framelimiter);
      $menu_font_large.drawf(0, 480-$menu_font_large.getHeight(), "Actual:%.1f/%.1f, Flip:%.1f, Potential:%.1f", realfps, potentialFps, flipfps, 1000.0 / ticks);
    end
		
    if($g_fAutoTest)
      $menu_font_small.drawRightJustified(635, 5, "Auto");
    end
    $window.flip
    
    flipfps = 1000.0 / ticks;
    
    delay = (game_values.framelimiter - Timer.ticks + framestart - 2);
    
    if(delay > 0)
      if(delay > game_values.framelimiter)
        delay = game_values.framelimiter;
      end
      Timer.delay(delay);
    end
		
    while(Timer.ticks() - framestart < game_values.framelimiter)
      Timer.delay(0);   #keep framerate constant at 1000/game_values.framelimiter fps
    end
		
    ticks = Timer.ticks() - framestart;
    if(ticks == 0)
      ticks = game_values.framelimiter;
    end
    realfps = 1000.0 / ticks;

    
  end
  #we never get here
  raise "we should never get here"
  #game_values.gamestate = :GS_QUIT
end
#trace_var :$game_values, proc {puts "tracing game_values.teamcounts #{$game_values.teamcounts.inspect}"}
#Must only be called after organizeteams() is called 
def lookupTeamID(id)
  game_values = $game_values
  $score_cnt.times do |i|
    game_values.teamcounts[i].times do |j|
      if game_values.teamids[i][j] == id
        return [i,j]
      end
    end
  end
  raise "should never get here"
  return [-1,-1]
end

def getPlayerFromGlobalID(iGlobalID)
  $list_players_cnt.times do|i|
    if($list_players[i].globalID == iGlobalID)
      return $list_players[i];
    end
  end

  return nil;
end

def cleanUp()
  #short i;
  #delete object list
	
  $list_players_cnt = 0;

   	$eyecandyfront.clean();
   	$eyecandyback.clean();
   	$objectsfront.clean();
   	$objectsplayer.clean();
   	$objectcollisionitems.clean();
   	$objectblocks.clean();
   	loadMapObjects();
   	$g_map.clearWarpLocks();
   	#$g_map.resetPlatforms();
   	#$g_map.clearAnimations();
   
   	#Stop all game sounds
   	#sfx_stopallsounds();
   	$sfx_invinciblemusic.resetpause();
   	$sfx_slowdownmusic.resetpause();
   
   	$x_shake = 0;
   	$y_shake = 0;
end

def isExitAllowed()
  game_values = $game_values
  if(!game_values.noexit || $list_players_cnt == 0)
    return true;
  end
  
  $list_players_cnt.times do |iPlayer|
    if(game_values.playercontrol[$list_players[iPlayer].getGlobalID()] == 1)
      return false;
    end
  end

  return true;
end
def updateScoreBoard
  #todo
  raise "not implemented"
end

def loadMapObjects
  $objectblocks.clean();
  
  8.times do |iSwitch|
    $g_map.switchBlocks[iSwitch] = [];
  end
  g_map = $g_map
  objectblocks = $objectblocks
  MAPWIDTH.times do |x|
    MAPHEIGHT.times do |y|
			
      if(g_map.objectdata[x][y] == 0)
        g_map.blockdata[x][y] = B_BreakableBlock.new($spr_breakableblock, x * TILESIZE, y * TILESIZE, 4, 10);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] == 1)
        g_map.blockdata[x][y] = B_PowerupBlock.new($spr_powerupblock, x * TILESIZE, y * TILESIZE, 4, 10);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] == 2)
        g_map.blockdata[x][y] = B_DonutBlock.new($spr_donutblock, x * TILESIZE, y * TILESIZE);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] == 3)
        g_map.blockdata[x][y] = B_FlipBlock.new($spr_flipblock, x * TILESIZE, y * TILESIZE);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] == 4)
        g_map.blockdata[x][y] = B_BounceBlock.new($spr_bounceblock, x * TILESIZE, y * TILESIZE);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] == 5)
        g_map.blockdata[x][y] = B_NoteBlock.new($spr_noteblock, x * TILESIZE, y * TILESIZE, 4, 10);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] == 6)
        g_map.blockdata[x][y] = B_ThrowBlock.new($spr_throwblock, x * TILESIZE, y * TILESIZE, 4, 10);
        objectblocks.add(g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] >= 7 && g_map.objectdata[x][y] <= 10)
        iSwitchType = g_map.objectdata[x][y] - 7;
        #g_map.blockdata[x][y] = B_OnOffSwitchBlock.new($spr_switchblocks, x * TILESIZE, y * TILESIZE, iSwitchType, g_map.iSwitches[iSwitchType]);
        #objectblocks.add(g_map.blockdata[x][y]);
        #g_map.switchBlocks[iSwitchType] << (g_map.blockdata[x][y]);
      elsif(g_map.objectdata[x][y] >= 11 && g_map.objectdata[x][y] <= 14)
        iSwitchType = g_map.objectdata[x][y] - 11;

        #g_map.blockdata[x][y] = B_SwitchBlock.new($spr_switchblocks, x * TILESIZE, y * TILESIZE, iSwitchType, g_map.iSwitches[iSwitchType]);
        #objectblocks.add(g_map.blockdata[x][y]);
        #g_map.switchBlocks[iSwitchType + 4] << (g_map.blockdata[x][y]);
      else
        g_map.blockdata[x][y] = nil;
      end
    end
  end
end

def coldec_player2player(o1, o2)
  #Special cases to deal with players overlapping the right and left sides of the screen
  if(o1.ix + PW < o2.ix)
    if (o1.ix + 640 >= o2.ix + PW || o1.ix + PW + 640 < o2.ix || o1.iy > o2.iy + PH || o1.iy + PH < o2.iy) 
      return false;
    else 
      return true;
    end
  elsif(o2.ix + PW < o1.ix)
    if (o1.ix >= o2.ix + PW + 640 || o1.ix + PW < o2.ix + 640 || o1.iy > o2.iy + PH || o1.iy + PH < o2.iy) 
      return false;
    else 
      return true;
    end
  else
    if (o1.ix >= o2.ix + PW || o1.ix + PW < o2.ix || o1.iy > o2.iy + PH || o1.iy + PH < o2.iy) 
      return false;
    else 
      return true;
    end
  end
end

def collisionhandler_p2p(o1, o2)
  game_values = $game_values
  #If teams tag each other  
  if(o1.teamID == o2.teamID)
    if(game_values.gamemode.gamemode == game_mode_jail && game_values.gamemodesettings.jail.tagfree)
      if(o1.jailed > 0)
        $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, o1.ix + HALFPW - 16, o1.iy + HALFPH - 16, 3, 8));
        ifsoundonplay($sfx_transform);
        o1.jailed = 0;
      end
      
      if(o2.jailed > 0)
        $eyecandyfront.add(EC_SingleAnimation.new($spr_fireballexplosion, o2.ix + HALFPW - 16, o2.iy + HALFPH - 16, 3, 8));
        ifsoundonplay($sfx_transform);
        o2.jailed = 0;
      end
    end
    
    #Dont collision detect players on same team if friendly fire is turned off
    if(!game_values.friendlyfire)
      return;
    end
  end
  
  #--- 1. is player invincible? ---
  if(o1.invincible && !o2.invincible && !o2.spawninvincible)
    puts "player1 invincible Killed Player2"
    playerKilledPlayer(o1, o2, death_style_jump, kill_style_star);
    return;
  end
	
  if(!o1.invincible && !o1.spawninvincible && o2.invincible)
    playerKilledPlayer(o2, o1, death_style_jump, kill_style_star);
    return;
  end
	
  #If neither can touch each other, then return
  if((o1.invincible && o2.invincible) || (o1.spawninvincible && o2.spawninvincible) ||
        (o1.iswarping() && o2.iswarping()))
    return;
  end
	
  #--- 2. stomping other player? ---
  if(!o2.spawninvincible && !o2.invincible && o1.isstomping(o2))
    return;
  end
  if(!o1.spawninvincible && !o1.invincible && o2.isstomping(o1))
    return;
  end
	
  #If either is shielded return because there is no pushback collision detection
  if((o1.spawninvincible && (game_values.gamemode.tagged != o1 || !game_values.gamemodesettings.tag.tagontouch)) || 
        (o2.spawninvincible && (game_values.gamemode.tagged != o2 || !game_values.gamemodesettings.tag.tagontouch)))
    return;
  end
	
  #--- 3. push back (horizontal) ---
  if(o1.ix < o2.ix)				#o1 is left -> o1 pushback left, o2 pushback right
    #_collisionhandler_p2p_pushback(o1, o2);
  else
    #_collisionhandler_p2p_pushback(o2, o1);
  end
	
end

def coldec_player2obj(o1,o2)
      
  if (o1.ix >= o2.ix + o2.collisionWidth || o2.ix > o1.ix + PW || o1.iy >= o2.iy + o2.collisionHeight || o2.iy > o1.iy + PH) 
    return false;
  else 
    return true;
  end
end

def collisionhandler_p2o(o1, o2)
  #o1 is player, o2 is obj
  return o2.collide(o1);
end

def shakekiller
  game_values = $game_values
  #Shake screen
  if(game_values.screenshaketimer > 0)
    game_values.screenshaketimer-=1;
				  
				  
    if($shakeleft)
      $x_shake -= 2;
      if($x_shake <= -2)
        $shakeleft = false;
      end
    else
      $x_shake += 2;
      if($x_shake >= 2)
        $shakeleft = true;
      end
    end
				  
    #Kill things touching the ground
    #short k;
    list_players = $list_players
    $list_players_cnt.times do |k|
    	
      next if(list_players[k].globalID == game_values.screenshakeplayerid)
      next if(!game_values.friendlyfire && game_values.screenshaketeamid == list_players[k].teamID)
      if(!list_players[k].invincible && !list_players[k].spawninvincible && list_players[k].isready())
        if(game_values.screenshakekillinair == list_players[k].inair)
          killer = getPlayerFromGlobalID(game_values.screenshakeplayerid);
          if(killer)
            playerKilledPlayer(killer, list_players[k], death_style_jump, kill_style_pow);
            game_values.screenshakekillscount+=1
						      
            if(killer.inair)
              killer.killsinrowinair-=1;  #Dont want to give both shake and in air award
            end
          else
            #list_players[k].deathAwards();
						      
            if(!game_values.gamemode.playerkilledself(list_players[k]))
              list_players[k].die(0, false);
            end
            ifsoundonplay(sfx_deathsound);
						      
          end
        end
      end
    end
    $objectcollisionitems.each do |item|
						
    end
    $objectsplayer.each do |item|
    end
					
    # 					if(game_values.screenshakekillscount > 1 && game_values.awardstyle != award_style_none)
    # 					{
    # 						game_values.screenshakekillscount = 0;
    # 
    # 						CPlayer * killer = GetPlayerFromGlobalID(game_values.screenshakeplayerid);
    # 
    # 						if(killer)
    # 							killer->AddKillsInRowInAirAward();
    # 					}
  else
    $x_shake = 0
  end #end game value screenshaketimer
end