class CPlayerAI
  def setPlayer(player) 
    @pPlayer = player;
  end
  def think(playerKeys)
#     playerKeys.game_left.fDown = false;
# 		playerKeys.game_right.fDown = false;
# 		
# 		playerKeys.game_down.fDown = false;
# 		playerKeys.game_turbo.fDown = false;
# 		playerKeys.game_powerup.fDown = false;
# 	
# 		if(@pPlayer.isdead() || @pPlayer.isspawning())
# 			return;
# 		end
# 	
# 		#Hold down jump until player starts moving down again, then release jump button
# 		if(@pPlayer.inair)
# 			if(@pPlayer.vely > 0.0)
# 				playerKeys.game_jump.fDown = false;
# 			else
# 				playerKeys.game_jump.fDown = true;
# 			end
# 		else
# 			#Try to jump 1 out of 50 chances when on ground
# 			if(rand(50) == 0)
# 				playerKeys.game_jump.fDown = true;
# 			else
# 				playerKeys.game_jump.fDown = true; #false;
# 			end
# 		end
  end
end