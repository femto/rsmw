game_values = $game_values

def _load_gfxck(g,f)			
  if(!__load_gfxck(g,f))
    _load_waitforkey();return false;
  end
end
def _load_gfxa(g,f,a)			
  if(!__load_gfxa(g,f,a))
    _load_waitforkey();return false;
end
end
def _load_gfx(g,f)				
  if(!__load_gfx(g,f))
    _load_waitforkey();return false;
  end
end
def _load_sfx(s,f)				
  if(!__load_sfx(s,f))
    _load_waitforkey();
    return false
  end
end

def _load_sfx(s,f)				
  if(!__load_sfx(s,f))
    _load_waitforkey();
    return false;
  end
end

def __load_gfxck(g,f)
  if(! g.init(f, [255,0,255,255]))
		msg = "error loading sprite #{f}: #{SDLError}\n";
		_load_drawmsg(msg);
		return false;
  end

	return true;
end

def __load_gfxa(g, f, alpha)
  if(! g.init(f, [255,0,255,255], alpha))
		msg = "error loading sprite #{f}: #{SDLError}\n";
		_load_drawmsg(msg);
		return false;
  end

	return true;
end
def __load_gfx(g, f)
	if(! g.init(f))
		msg = "error loading sprite #{f}: #{SDLError}\n";
		_load_drawmsg(msg);
		return false;
  end

	return true;
end

def __load_sfx(s, f)
	if(! s.init(f) )
		msg = "error loading sound #{f}";
		_load_drawmsg(msg);
		return false;
	end

	return true;
end
def loadStartGraphics
  
  loadok = true
  
  $menu_font_small = GfxFont.new
  $menu_font_large = GfxFont.new

	loadok &&= $menu_font_small.init("gfx/packs/Classic/menu/menu_font_small.png");
	loadok &&= $menu_font_large.init("gfx/packs/Classic/menu/menu_font_large.png");
	#$menu_font_small.draw(5,5,"We are here!")
	if(!loadok)
		_load_drawmsg("ERROR: error loading the fonts!\n");
		_load_waitforkey();
		return false;
	end

	#load basic stuff
        $menu_backdrop = GfxSprite.new
        $menu_smw = GfxSprite.new
        $menu_version = GfxSprite.new
	_load_gfx($menu_backdrop, "gfx/packs/Classic/menu/menu_background.png");
	_load_gfxck($menu_smw, "gfx/packs/Classic/menu/menu_smw.png");
	_load_gfxck($menu_version, "gfx/packs/Classic/menu/menu_version.png");

	return true;
end

def loadMenuGraphics
  graphicspack = "Classic";
  _load_gfx($menu_shade=GfxSprite.new, convertPath("gfx/packs/menu/menu_shade.png", graphicspack));
  $menu_shade.set_alpha(getScreenBackgroundFade());
  
  _load_gfxck($spr_scoreboard=GfxSprite.new, convertPath("gfx/packs/menu/scoreboard.png", graphicspack));
	_load_gfxck($menu_slider_bar=GfxSprite.new, convertPath("gfx/packs/menu/menu_slider_bar.png", graphicspack));
	_load_gfxck($menu_plain_field=GfxSprite.new, convertPath("gfx/packs/menu/menu_plain_field.png", graphicspack));
	_load_gfxck($menu_player_select=GfxSprite.new, convertPath("gfx/packs/menu/menu_player_select.png", graphicspack));
	_load_gfxck($menu_dialog=GfxSprite.new, convertPath("gfx/packs/menu/menu_dialog.png", graphicspack));
	_load_gfxck($menu_map_filter=GfxSprite.new, convertPath("gfx/packs/menu/menu_map_filter.png", graphicspack));

	_load_gfxck($menu_mode_small=GfxSprite.new, convertPath("gfx/packs/menu/menu_mode_small.png", graphicspack));
	_load_gfxck($menu_mode_large=GfxSprite.new, convertPath("gfx/packs/menu/menu_mode_large.png", graphicspack));

	_load_gfxck($spr_dialog=GfxSprite.new, convertPath("gfx/packs/menu/dialog.png", graphicspack));
	_load_gfxck($spr_dialogbutton=GfxSprite.new, convertPath("gfx/packs/menu/dialog_button.png", graphicspack));
	_load_gfxck($spr_tournament_background=GfxSprite.new, convertPath("gfx/packs/menu/tournament_background.png", graphicspack));
	_load_gfxck($spr_tournament_powerup_splash=GfxSprite.new, convertPath("gfx/packs/menu/tournament_powerup_splash.png", graphicspack));
	_load_gfxck($spr_player_select_background=GfxSprite.new, convertPath("gfx/packs/menu/player_select_background.png", graphicspack));
	_load_gfxck($spr_player_select_ready=GfxSprite.new, convertPath("gfx/packs/menu/player_select_ready.png", graphicspack));
	_load_gfxck($spr_ipfield=GfxSprite.new, convertPath("gfx/packs/menu/menu_ipfield.png", graphicspack));
	_load_gfxck($spr_selectfield=GfxSprite.new, convertPath("gfx/packs/menu/menu_selectfield.png", graphicspack));
	_load_gfxck($spr_selectfielddisabled=GfxSprite.new, convertPath("gfx/packs/menu/menu_selectfield_disabled.png", graphicspack));
	_load_gfxck($spr_map_filter_icons=GfxSprite.new, convertPath("gfx/packs/menu/menu_map_flags.png", graphicspack));
	_load_gfxck($spr_tour_markers=GfxSprite.new, convertPath("gfx/packs/menu/tour_markers.png", graphicspack)); 
	_load_gfxck($spr_menu_boxed_numbers=GfxSprite.new, convertPath("gfx/packs/menu/menu_boxed_numbers.png", graphicspack));
	_load_gfxa($spr_thumbnail_platformarrows=GfxSprite.new, convertPath("gfx/packs/menu/menu_platform_arrows.png", graphicspack), 128);
	$spr_thumbnail_warps = []
	_load_gfxck($spr_thumbnail_warps[0]=GfxSprite.new, convertPath("gfx/packs/menu/menu_warp_preview.png", graphicspack));
	_load_gfxck($spr_thumbnail_warps[1]=GfxSprite.new, convertPath("gfx/packs/menu/menu_warp_thumbnail.png", graphicspack));

	return true;
end

def loadGameGraphics
  graphicspack = "Classic";
  loadok = true;
  $game_font_small = GfxFont.new
  $game_font_large = GfxFont.new
	loadok &= $game_font_small.init(convertPath("gfx/packs/fonts/font_small.png", graphicspack));
	loadok &= $game_font_large.init(convertPath("gfx/packs/fonts/font_large.png", graphicspack));
	
	if(!loadok)
		_load_drawmsg("ERROR: error loading the fonts!\n");
		_load_waitforkey();
		return false;
	end
	#todo: load skin slow
	#Thread.fork {
	4.times do |k|
		#loadFullSkin($spr_chocobo[k], convertPath("gfx/packs/modeskins/chicken.bmp", graphicspack), k);
		#loadFullSkin($spr_bobomb[k], convertPath("gfx/packs/modeskins/bobomb.bmp", graphicspack), k);
	end
  #}
	
	_load_gfxck($menu_survival=GfxSprite.new, convertPath("gfx/packs/modeobjects/menu_survival.png", graphicspack));
	_load_gfxck($menu_stomp=GfxSprite.new, convertPath("gfx/packs/modeobjects/menu_stomp.png", graphicspack));
  $spr_clouds = []
	_load_gfxa($spr_clouds[0]=GfxSprite.new, convertPath("gfx/packs/eyecandy/cloud1.png", graphicspack), 255);
	_load_gfxa($spr_clouds[1]=GfxSprite.new, convertPath("gfx/packs/eyecandy/cloud2.png", graphicspack), 255);
	$spr_clouds[0].wrap = true;
	$spr_clouds[1].wrap = true;
	
  $spr_ghosts = []
	_load_gfxa($spr_ghosts[0]=GfxSprite.new, convertPath("gfx/packs/eyecandy/ghost1.png", graphicspack), 128);
	_load_gfxa($spr_ghosts[1]=GfxSprite.new, convertPath("gfx/packs/eyecandy/ghost2.png", graphicspack), 128);
	_load_gfxa($spr_ghosts[2]=GfxSprite.new, convertPath("gfx/packs/eyecandy/ghost3.png", graphicspack), 128);
	$spr_ghosts[0].wrap = true;
	$spr_ghosts[1].wrap = true;
	$spr_ghosts[2].wrap = true;

	_load_gfxck($spr_noteblock=GfxSprite.new, convertPath("gfx/packs/blocks/noteblock.png", graphicspack));
	_load_gfxck($spr_breakableblock=GfxSprite.new, convertPath("gfx/packs/blocks/breakableblock.png", graphicspack));
	_load_gfxck($spr_powerupblock=GfxSprite.new, convertPath("gfx/packs/blocks/powerupblock.png", graphicspack));
	_load_gfxck($spr_donutblock=GfxSprite.new, convertPath("gfx/packs/blocks/donutblock.png", graphicspack));
	_load_gfxck($spr_flipblock=GfxSprite.new, convertPath("gfx/packs/blocks/flipblock.png", graphicspack));
	_load_gfxck($spr_bounceblock=GfxSprite.new, convertPath("gfx/packs/blocks/bounceblock.png", graphicspack));
	_load_gfxck($spr_throwblock=GfxSprite.new, convertPath("gfx/packs/blocks/throwblock.png", graphicspack));
	_load_gfxck($spr_switchblocks=GfxSprite.new, convertPath("gfx/packs/blocks/switchblock.png", graphicspack));
	_load_gfxck($spr_viewblock=GfxSprite.new, convertPath("gfx/packs/blocks/viewblock.png", graphicspack));
	_load_gfxck($spr_spring=GfxSprite.new, convertPath("gfx/packs/powerups/spring.png", graphicspack));
	_load_gfxck($spr_spike=GfxSprite.new, convertPath("gfx/packs/powerups/spike.png", graphicspack));
	$spr_spring.wrap = true;
	$spr_spike.wrap = true;

	_load_gfxck($spr_maplava=GfxSprite.new, convertPath("gfx/packs/map/lava.png", graphicspack));
	_load_gfxck($spr_mapwater=GfxSprite.new, convertPath("gfx/packs/map/water.png", graphicspack));
	_load_gfxck($spr_mapwaterfall=GfxSprite.new, convertPath("gfx/packs/map/waterfall.png", graphicspack));
	_load_gfxck($spr_maplamp=GfxSprite.new, convertPath("gfx/packs/map/lamp.png", graphicspack));

	_load_gfxck($spr_brokenyellowblock=GfxSprite.new, convertPath("gfx/packs/eyecandy/brokenyellowblock.png", graphicspack));
	_load_gfxck($spr_brokenflipblock=GfxSprite.new, convertPath("gfx/packs/eyecandy/brokenflipblock.png", graphicspack));
	_load_gfxck($spr_brokenblueblock=GfxSprite.new, convertPath("gfx/packs/eyecandy/brokenblueblock.png", graphicspack));
	$spr_brokenyellowblock.wrap = true;
	$spr_brokenflipblock.wrap = true;
	$spr_brokenblueblock.wrap = true;

	_load_gfxck($spr_tanooki=GfxSprite.new, convertPath("gfx/packs/powerups/tanooki.png", graphicspack));
	_load_gfxck($spr_statue=GfxSprite.new, convertPath("gfx/packs/projectiles/statue.png", graphicspack));
	_load_gfxck($spr_starpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/starpowerup.png", graphicspack));
	_load_gfxck($spr_1uppowerup=GfxSprite.new, convertPath("gfx/packs/powerups/1uppowerup.png", graphicspack));
	_load_gfxck($spr_2uppowerup=GfxSprite.new, convertPath("gfx/packs/powerups/2uppowerup.png", graphicspack));
	_load_gfxck($spr_3uppowerup=GfxSprite.new, convertPath("gfx/packs/powerups/3uppowerup.png", graphicspack));
	_load_gfxck($spr_5uppowerup=GfxSprite.new, convertPath("gfx/packs/powerups/5uppowerup.png", graphicspack));
	_load_gfxck($spr_firepowerup=GfxSprite.new, convertPath("gfx/packs/powerups/fireflower.png", graphicspack));
	_load_gfxck($spr_hammerpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/hammerpowerup.png", graphicspack));
	_load_gfxck($spr_sledgehammerpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/sledgehammerpowerup.png", graphicspack));
	_load_gfxck($spr_podobopowerup=GfxSprite.new, convertPath("gfx/packs/powerups/podobopowerup.png", graphicspack));
	_load_gfxck($spr_poisonpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/poisonpowerup.png", graphicspack));
	_load_gfxck($spr_mysterymushroompowerup=GfxSprite.new, convertPath("gfx/packs/powerups/mysterymushroom.png", graphicspack));
	_load_gfxck($spr_boomerangpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/boomerangpowerup.png", graphicspack));
	_load_gfxck($spr_clockpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/clockpowerup.png", graphicspack));
	_load_gfxck($spr_bobombpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/bobombpowerup.png", graphicspack));
	_load_gfxck($spr_powpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/powpowerup.png", graphicspack));
	_load_gfxck($spr_modpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/modpowerup.png", graphicspack));
	_load_gfxck($spr_bulletbillpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/bulletbillpowerup.png", graphicspack));
	_load_gfxck($spr_featherpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/featherpowerup.png", graphicspack));
	_load_gfxck($spr_bombpowerup=GfxSprite.new, convertPath("gfx/packs/powerups/bombpowerup.png", graphicspack));
	$spr_tanooki.wrap = true;
	$spr_statue.wrap = true;
	$spr_starpowerup.wrap = true;
	$spr_1uppowerup.wrap = true;
	$spr_2uppowerup.wrap = true;
	$spr_3uppowerup.wrap = true;
	$spr_5uppowerup.wrap = true;
	$spr_firepowerup.wrap = true;
	$spr_hammerpowerup.wrap = true;
	$spr_sledgehammerpowerup.wrap = true;
	$spr_podobopowerup.wrap = true;
	$spr_poisonpowerup.wrap = true;
	$spr_clockpowerup.wrap = true;
	$spr_bobombpowerup.wrap = true;
	$spr_powpowerup.wrap = true;
	$spr_modpowerup.wrap = true;
	$spr_bulletbillpowerup.wrap = true;
	$spr_featherpowerup.wrap = true;
	$spr_mysterymushroompowerup.wrap = true;
	$spr_boomerangpowerup.wrap = true;
 
  $spr_shade = []
	_load_gfxa($spr_shade[0]=GfxSprite.new, convertPath("gfx/packs/eyecandy/shade1.png", graphicspack), 64);
	_load_gfxa($spr_shade[1]=GfxSprite.new, convertPath("gfx/packs/eyecandy/shade2.png", graphicspack), 64);
	_load_gfxa($spr_shade[2]=GfxSprite.new, convertPath("gfx/packs/eyecandy/shade3.png", graphicspack), 64);
	_load_gfxa($spr_timershade=GfxSprite.new, convertPath("gfx/packs/eyecandy/timershade.png", graphicspack), 64);
	_load_gfxck($spr_spawneggs=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawneggs.png", graphicspack));
	_load_gfxck($spr_scoretext=GfxSprite.new, convertPath("gfx/packs/fonts/score.png", graphicspack));
	_load_gfxck($spr_racetext=GfxSprite.new, convertPath("gfx/packs/fonts/race.png", graphicspack));

	_load_gfxck($spr_crown=GfxSprite.new, convertPath("gfx/packs/eyecandy/crown.png", graphicspack));
	_load_gfxck($spr_cape=GfxSprite.new, convertPath("gfx/packs/eyecandy/cape.png", graphicspack));
	_load_gfxck($spr_warplock=GfxSprite.new, convertPath("gfx/packs/eyecandy/warplock.png", graphicspack));
	_load_gfxck($spr_coinsparkle=GfxSprite.new, convertPath("gfx/packs/eyecandy/coinsparks.png", graphicspack));
	_load_gfxck($spr_shinesparkle=GfxSprite.new, convertPath("gfx/packs/eyecandy/shinesparks.png", graphicspack));
	_load_gfxck($spr_shellbounce=GfxSprite.new, convertPath("gfx/packs/eyecandy/shellbounce.png", graphicspack));
	$spr_crown.wrap = true; # Wrap crown for players wearing crown during game
	$spr_shellbounce.wrap = true;

	_load_gfxck($spr_egg=GfxSprite.new, convertPath("gfx/packs/modeobjects/egg.png", graphicspack));
	_load_gfxck($spr_star=GfxSprite.new, convertPath("gfx/packs/modeobjects/star.png", graphicspack));
	_load_gfxck($spr_flags=GfxSprite.new, convertPath("gfx/packs/modeobjects/flags.png", graphicspack));
	_load_gfxck($spr_frenzycards=GfxSprite.new, convertPath("gfx/packs/modeobjects/frenzycards.png", graphicspack));
	$spr_egg.wrap = true;
	$spr_star.wrap = true;
	$spr_flags.wrap = true;
	$spr_frenzycards.wrap = true;
	
	_load_gfxck($spr_yoshi=GfxSprite.new, convertPath("gfx/packs/modeobjects/yoshi.png", graphicspack));
	_load_gfxck($spr_coin=GfxSprite.new, convertPath("gfx/packs/modeobjects/coin.png", graphicspack));
	_load_gfxck($spr_thwomp=GfxSprite.new, convertPath("gfx/packs/modeobjects/thwomp.png", graphicspack));
	_load_gfxck($spr_podobo=GfxSprite.new, convertPath("gfx/packs/modeobjects/podobo.png", graphicspack));
	_load_gfxck($spr_bowserfire=GfxSprite.new, convertPath("gfx/packs/modeobjects/bowserfire.png", graphicspack));
	_load_gfxck($spr_areas=GfxSprite.new, convertPath("gfx/packs/modeobjects/areas.png", graphicspack));
	_load_gfxa($spr_kingofthehillarea=GfxSprite.new, convertPath("gfx/packs/modeobjects/kingofthehill.png", graphicspack), 128);
	_load_gfxa($spr_jail=GfxSprite.new, convertPath("gfx/packs/modeobjects/jail.png", graphicspack), 160);
	_load_gfxck($spr_goomba=GfxSprite.new, convertPath("gfx/packs/modeobjects/goomba.png", graphicspack));
	_load_gfxck($spr_goombadead=GfxSprite.new, convertPath("gfx/packs/eyecandy/goombadead.png", graphicspack));
	_load_gfxck($spr_goombadeadflying=GfxSprite.new, convertPath("gfx/packs/eyecandy/goombadeadflying.png", graphicspack));
	_load_gfxck($spr_koopa=GfxSprite.new, convertPath("gfx/packs/modeobjects/koopa.png", graphicspack));
	_load_gfxck($spr_sledgebrothers=GfxSprite.new, convertPath("gfx/packs/modeobjects/sledgebrothers.png", graphicspack));
	_load_gfxck($spr_sledgebrothersdead=GfxSprite.new, convertPath("gfx/packs/eyecandy/sledgebrothersdead.png", graphicspack));
	_load_gfxck($spr_redkoopa=GfxSprite.new, convertPath("gfx/packs/modeobjects/redkoopa.png", graphicspack));
	_load_gfxck($spr_cheepcheep=GfxSprite.new, convertPath("gfx/packs/modeobjects/cheepcheep.png", graphicspack));
	_load_gfxck($spr_cheepcheepdead=GfxSprite.new, convertPath("gfx/packs/eyecandy/cheepcheepdead.png", graphicspack));
	_load_gfxck($spr_bulletbill=GfxSprite.new, convertPath("gfx/packs/projectiles/bulletbill.png", graphicspack));
	_load_gfxck($spr_bulletbilldead=GfxSprite.new, convertPath("gfx/packs/eyecandy/bulletbilldead.png", graphicspack));
	_load_gfxa($spr_chicken=GfxSprite.new, convertPath("gfx/packs/modeobjects/chicken.png", graphicspack), 160);
	_load_gfxck($spr_racegoal=GfxSprite.new, convertPath("gfx/packs/modeobjects/racegoal.png", graphicspack));

	$spr_yoshi.wrap = true;
	$spr_coin.wrap = true;
	$spr_thwomp.wrap = true;
	$spr_jail.wrap = true;
	$spr_goomba.wrap = true;
	$spr_goombadead.wrap = true;
	$spr_goombadeadflying.wrap = true;
	$spr_koopa.wrap = true;
	$spr_sledgebrothers.wrap = true;
	$spr_sledgebrothersdead.wrap = true;
	$spr_cheepcheep.wrap = true;
	$spr_cheepcheepdead.wrap = true;
	$spr_chicken.wrap = true;
	
	_load_gfxck($spr_fireball=GfxSprite.new, convertPath("gfx/packs/projectiles/fireball.png", graphicspack));
	_load_gfxck($spr_superfireball=GfxSprite.new, convertPath("gfx/packs/projectiles/superfire.png", graphicspack));
	_load_gfxck($spr_hammer=GfxSprite.new, convertPath("gfx/packs/projectiles/hammer.png", graphicspack));
	_load_gfxck($spr_sledgehammer=GfxSprite.new, convertPath("gfx/packs/projectiles/sledgehammer.png", graphicspack));
	_load_gfxck($spr_boomerang=GfxSprite.new, convertPath("gfx/packs/projectiles/boomerang.png", graphicspack));
	_load_gfxck($spr_shell=GfxSprite.new, convertPath("gfx/packs/projectiles/shell.png", graphicspack));
	_load_gfxck($spr_shelldead=GfxSprite.new, convertPath("gfx/packs/eyecandy/shelldead.png", graphicspack));
	_load_gfxck($spr_blueblock=GfxSprite.new, convertPath("gfx/packs/projectiles/throwblock.png", graphicspack));
	_load_gfxck($spr_bomb=GfxSprite.new, convertPath("gfx/packs/projectiles/bomb.png", graphicspack));
	$spr_fireball.wrap = true;
	$spr_superfireball.wrap = true;
	$spr_hammer.wrap = true;
	$spr_sledgehammer.wrap = true;
	$spr_boomerang.wrap = true;
	$spr_shell.wrap = true;
	$spr_shelldead.wrap = true;
	$spr_blueblock.wrap = true;
	$spr_bomb.wrap = true;
	
	_load_gfxa($spr_fireballexplosion=GfxSprite.new, convertPath("gfx/packs/eyecandy/fireballexplosion.png", graphicspack), 160);
	_load_gfxa($spr_frictionsmoke=GfxSprite.new, convertPath("gfx/packs/eyecandy/frictionsmoke.png", graphicspack), 160);
	_load_gfxa($spr_bobombsmoke=GfxSprite.new, convertPath("gfx/packs/eyecandy/bobombsmoke.png", graphicspack), 160);
	_load_gfxck($spr_explosion=GfxSprite.new, convertPath("gfx/packs/eyecandy/explosion.png", graphicspack));
	_load_gfxa($spr_burnup=GfxSprite.new, convertPath("gfx/packs/eyecandy/burnup.png", graphicspack), 192);

	$spr_fireballexplosion.wrap = true;
	$spr_frictionsmoke.wrap = true;
	$spr_bobombsmoke.wrap = true;
	$spr_explosion.wrap = true;
	$spr_burnup.wrap = true;

  $spr_spawnsmoke = []
	_load_gfxa($spr_spawnsmoke[0]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawnsmoke1.png", graphicspack), 128);
	_load_gfxa($spr_spawnsmoke[1]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawnsmoke2.png", graphicspack), 128);
	_load_gfxa($spr_spawnsmoke[2]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawnsmoke3.png", graphicspack), 128);
	_load_gfxa($spr_spawnsmoke[3]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawnsmoke4.png", graphicspack), 128);

	$spr_spawnsmoke[0].wrap = true;
	$spr_spawnsmoke[1].wrap = true;
	$spr_spawnsmoke[2].wrap = true;
	$spr_spawnsmoke[3].wrap = true;

  $spr_spawndoor = []
	_load_gfxck($spr_spawndoor[0]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawndoor1.png", graphicspack));
	_load_gfxck($spr_spawndoor[1]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawndoor2.png", graphicspack));
	_load_gfxck($spr_spawndoor[2]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawndoor3.png", graphicspack));
	_load_gfxck($spr_spawndoor[3]=GfxSprite.new, convertPath("gfx/packs/eyecandy/spawndoor4.png", graphicspack));

	$spr_spawndoor[0].wrap = true;
	$spr_spawndoor[1].wrap = true;
	$spr_spawndoor[2].wrap = true;
	$spr_spawndoor[3].wrap = true;

	_load_gfxck($spr_bonus=GfxSprite.new, convertPath("gfx/packs/eyecandy/bonus.png", graphicspack));
	_load_gfxck($spr_extralife=GfxSprite.new, convertPath("gfx/packs/eyecandy/extralife.png", graphicspack));
	$spr_bonus.wrap = true;
	$spr_extralife.wrap = true;

	_load_gfxa($spr_award=GfxSprite.new, convertPath("gfx/packs/awards/killsinrow.png", graphicspack), 128);
	_load_gfxck($spr_awardsolid=GfxSprite.new, convertPath("gfx/packs/awards/killsinrow.png", graphicspack));
	_load_gfxck($spr_awardsouls=GfxSprite.new, convertPath("gfx/packs/awards/souls.png", graphicspack));
	_load_gfxck($spr_awardsoulspawn=GfxSprite.new, convertPath("gfx/packs/awards/soulspawn.png", graphicspack));

	$spr_award.wrap = true;
	$spr_awardsolid.wrap = true;
	$spr_awardsouls.wrap = true;
	$spr_awardsoulspawn.wrap = true;

  $spr_awardkillsinrow = []
	_load_gfxck($spr_awardkillsinrow[0]=GfxSprite.new, convertPath("gfx/packs/awards/killsinrownumbers1.png", graphicspack));
	_load_gfxck($spr_awardkillsinrow[1]=GfxSprite.new, convertPath("gfx/packs/awards/killsinrownumbers2.png", graphicspack));
	_load_gfxck($spr_awardkillsinrow[2]=GfxSprite.new, convertPath("gfx/packs/awards/killsinrownumbers3.png", graphicspack));
	_load_gfxck($spr_awardkillsinrow[3]=GfxSprite.new, convertPath("gfx/packs/awards/killsinrownumbers4.png", graphicspack));

	$spr_awardkillsinrow[0].wrap = true;
	$spr_awardkillsinrow[1].wrap = true;
	$spr_awardkillsinrow[2].wrap = true;
	$spr_awardkillsinrow[3].wrap = true;

	_load_gfxa($spr_flagbases=GfxSprite.new, convertPath("gfx/packs/modeobjects/flagbases.png", graphicspack), 160);
	_load_gfxa($spr_ownedtags=GfxSprite.new, convertPath("gfx/packs/modeobjects/ownedtags.png", graphicspack), 160);
	$spr_flagbases.wrap = true;
	$spr_ownedtags.wrap = true;

	_load_gfxck($spr_storedpowerupsmall=GfxSprite.new, convertPath("gfx/packs/powerups/small.png", graphicspack));
	_load_gfxck($spr_storedpoweruplarge=GfxSprite.new, convertPath("gfx/packs/powerups/large.png", graphicspack));
	_load_gfxck($spr_powerupselector=GfxSprite.new, convertPath("gfx/packs/awards/award.png", graphicspack));
	$spr_storedpowerupsmall.wrap = true;

	_load_gfxck($spr_abovearrows=GfxSprite.new, convertPath("gfx/packs/eyecandy/abovearrows.png", graphicspack));
	$spr_abovearrows.wrap = true;

	tileSetTLS = "maps/tileset.tls";
	tileSetPNG = [];
	tileSetPNG[0] = convertPath("gfx/packs/tileset.png", graphicspack);
	tileSetPNG[1] = convertPath("gfx/packs/tileset_medium.png", graphicspack);
	tileSetPNG[2] = convertPath("gfx/packs/tileset_small.png", graphicspack);

	$g_map.loadTileSet(tileSetTLS, tileSetPNG);

	return true;
end
def loadGameSounds
  game_values = $game_values
  #use Mixer.format to query format
  #   if(0 == Mix_QuerySpec(&frequency, &format, &channels))
  # 		return false;
  soundpack = "Classic"
  _load_sfx($sfx_mip=SfxSound.new, convertPath("sfx/packs/mip.wav", soundpack));
	_load_sfx($sfx_deathsound=SfxSound.new, convertPath("sfx/packs/death.wav", soundpack));
	_load_sfx($sfx_jump=SfxSound.new, convertPath("sfx/packs/jump.wav", soundpack));
	_load_sfx($sfx_skid=SfxSound.new, convertPath("sfx/packs/skid.wav", soundpack));
	_load_sfx($sfx_capejump=SfxSound.new, convertPath("sfx/packs/capejump.wav", soundpack));
	_load_sfx($sfx_invinciblemusic=SfxSound.new, convertPath("sfx/packs/invincible.wav", soundpack));
	_load_sfx($sfx_extraguysound=SfxSound.new, convertPath("sfx/packs/1up.wav", soundpack));
	_load_sfx($sfx_sprout=SfxSound.new, convertPath("sfx/packs/sprout.wav", soundpack));
	_load_sfx($sfx_collectpowerup=SfxSound.new, convertPath("sfx/packs/collectpowerup.wav", soundpack));
	_load_sfx($sfx_collectfeather=SfxSound.new, convertPath("sfx/packs/feather.wav", soundpack));
	_load_sfx($sfx_storepowerup=SfxSound.new, convertPath("sfx/packs/storeitem.wav", soundpack));
	_load_sfx($sfx_breakblock=SfxSound.new, convertPath("sfx/packs/breakblock.wav", soundpack));
	_load_sfx($sfx_bump=SfxSound.new, convertPath("sfx/packs/bump.wav", soundpack));
	_load_sfx($sfx_coin=SfxSound.new, convertPath("sfx/packs/coin.wav", soundpack));
	_load_sfx($sfx_fireball=SfxSound.new, convertPath("sfx/packs/fireball.wav", soundpack));
	_load_sfx($sfx_springjump=SfxSound.new, convertPath("sfx/packs/springjump.wav", soundpack));
	_load_sfx($sfx_timewarning=SfxSound.new, convertPath("sfx/packs/timewarning.wav", soundpack));
	_load_sfx($sfx_hit=SfxSound.new, convertPath("sfx/packs/hit.wav", soundpack));
	_load_sfx($sfx_chicken=SfxSound.new, convertPath("sfx/packs/chicken.wav", soundpack));
	_load_sfx($sfx_transform=SfxSound.new, convertPath("sfx/packs/transform.wav", soundpack));
	_load_sfx($sfx_yoshi=SfxSound.new, convertPath("sfx/packs/yoshi.wav", soundpack));
	_load_sfx($sfx_pause=SfxSound.new, convertPath("sfx/packs/pause.wav", soundpack));
	_load_sfx($sfx_bobombsound=SfxSound.new, convertPath("sfx/packs/bob-omb.wav", soundpack));
	_load_sfx($sfx_areatag=SfxSound.new, convertPath("sfx/packs/dcoin.wav", soundpack));
	_load_sfx($sfx_cannon=SfxSound.new, convertPath("sfx/packs/cannon.wav", soundpack));
	_load_sfx($sfx_burnup=SfxSound.new, convertPath("sfx/packs/burnup.wav", soundpack));
	_load_sfx($sfx_pipe=SfxSound.new, convertPath("sfx/packs/warp.wav", soundpack));
	_load_sfx($sfx_thunder=SfxSound.new, convertPath("sfx/packs/thunder.wav", soundpack));
	_load_sfx($sfx_slowdownmusic=SfxSound.new, convertPath("sfx/packs/clock.wav", soundpack));
	_load_sfx($sfx_storedpowerupsound=SfxSound.new, convertPath("sfx/packs/storedpowerup.wav", soundpack));
	_load_sfx($sfx_kicksound=SfxSound.new, convertPath("sfx/packs/kick.wav", soundpack));
	_load_sfx($sfx_racesound=SfxSound.new, convertPath("sfx/packs/race.wav", soundpack));
	_load_sfx($sfx_bulletbillsound=SfxSound.new, convertPath("sfx/packs/bulletbill.wav", soundpack));
	_load_sfx($sfx_boomerang=SfxSound.new, convertPath("sfx/packs/boomerang.wav", soundpack));
	_load_sfx($sfx_spit=SfxSound.new, convertPath("sfx/packs/spit.wav", soundpack));
	_load_sfx($sfx_starwarning=SfxSound.new, convertPath("sfx/packs/starwarning.wav", soundpack));
	_load_sfx($sfx_powerdown=SfxSound.new, convertPath("sfx/packs/powerdown.wav", soundpack));
	_load_sfx($sfx_switchpress=SfxSound.new, convertPath("sfx/packs/switchpress.wav", soundpack));
	_load_sfx($sfx_superspring=SfxSound.new, convertPath("sfx/packs/superspring.wav", soundpack));
	_load_sfx($sfx_secret=SfxSound.new, convertPath("sfx/packs/secret.wav", soundpack));
	_load_sfx($sfx_bowserlaugh=SfxSound.new, convertPath("sfx/packs/bowserlaugh.wav", soundpack));
	_load_sfx($sfx_gameover=SfxSound.new, convertPath("sfx/packs/gameover.wav", soundpack));
	_load_sfx($sfx_stun=SfxSound.new, convertPath("sfx/packs/stun.wav", soundpack));
  
  game_values.soundcapable = true;
  return true;
end
$fLoadMessages = true;
def _load_drawmsg(f)
	if($fLoadMessages)
# 		/*
# 		static SDL_Rect r;
# 		r.x = 0;
# 		r.y = 0;
# 		r.w = 500;
# 		r.h = (Uint16)menu_font_small.getHeight();
# 		Uint32 col = SDL_MapRGB(screen->format, 189, 251, 255);
# 		SDL_FillRect(screen, &r, col);		//fill empty area */

		$menu_font_small.draw(0, 0, f);
	end
end

def _load_waitforkey

	while true
		case EventQueue.poll
		
			when KeyDownEvent
				return
			when JoyButtonDownEvent
				return
		end

		Timer.delay(10)
	end
end

def loadAndSplashScreen
  loadStartGraphics
  menu_dpi_logo = Surface.load_new("gfx/packs/Classic/menu/splash_72dpi.png")
  menu_credits = Surface.load_new("gfx/packs/Classic/menu/splash_credits.png")
  game_values = $game_values
  alpha = 0;
  state = 0;
  timer = 120;
        
  #$window.blit(menu_dpi_logo,[195,186])
  #$window.flip
  #Timer.delay(1000)
  
  while true
    framestart = Timer.ticks
    #game_values.playerInput.ClearPressedKeys(1);
    while event = EventQueue.poll
      case event
        when QuitEvent #if !xbox
          return false
        when KeyDownEvent
          #puts event.key
          case event.key
            when ?\r
              if event.mod & (0x100|0x200) !=0 #left alt and right alts
              	$game_values.fullscreen = !$game_values.fullscreen;
              	$window.toggle_fullscreen
              	$blitdest = $screen
              end
            when K_F4
              if event.mod & (0x100|0x200) #left alt and right alts
              	return false
              end 
          end
        
      end  #end of event type
      
      #game_values.playerInput.Update(event, 1);
      
    end #end while event poll
   4.times do |iPlayer|
     if(game_values.playerInput.outputControls[iPlayer].menu_select.fPressed || 
				game_values.playerInput.outputControls[iPlayer].menu_cancel.fPressed ||
				game_values.playerInput.outputControls[iPlayer].menu_random.fPressed || true)
				if(state <= 3)
					state = 3;
					alpha = 255;
				else
					$blitdest = $menu_backdrop.surface;
					#$menu_shade.setalpha(getScreenBackgroundFade());
					#$menu_shade.draw(0, 0);
					$blitdest = $screen;

					$g_fLoadMessages = false;
					#eyecandyfront.clean();

					#game_values.playerInput.ResetKeys();

					return true;
				end
			end
   end #end 4.times
    
    if(state == 0)
      
			alpha += 4;
			if(alpha >= 255)
			
				alpha = 255;
				state+=1;
			end
		elsif(state == 1)
		  #timer -= 1
		  timer=0
			if(timer <= 0)
				state+=1;
			end
		elsif(state == 2)
			alpha -= 4;
			if(alpha <= 0)
				alpha = 0;
				state+=1;
			end
		elsif(state == 3)
			alpha += 5;
			if(alpha >= 255)
				alpha = 255;
				state+=1;
			end
		end
                puts "filling..."
                $window.fill([0,0,0,0])
                #$window.flip
                if state == 0 || state == 1 || state == 2
                  #menu_dpi_logo.alpha = alpha
                  menu_dpi_logo.set_alpha(alpha)
                  #menu_dpi_logo.draw([195,186])
                  $window.blit(menu_dpi_logo, [195,186])
                  puts "drawing menu_dpi_logo with alpha:#{alpha}"
                  #menu_dpi_logo.x=3
                  $window.flip
                  
                  
                elsif(state == 3 || state == 4 || state == 5)
                	puts "setting alpha to #{alpha}"
									$menu_backdrop.set_alpha(alpha);
								  $menu_backdrop.draw(0,0)
									
									$menu_smw.set_alpha(alpha);
									puts "draw menu_smw at #{$menu_smw.width >> 1}, 30"
									$menu_smw.draw($menu_smw.width >> 1, 30);	#smw logo
						
									$menu_version.set_alpha(alpha);
									$menu_version.draw(570, 10);	#smw logo
						
									#$menu_font_large.set_alpha(alpha);
									#menu_font_large.drawRightJustified(630, 45, "RC2");
						
									menu_credits.set_alpha(alpha);
									$window.blit(menu_credits,[227, 200]);
									
                end
                
                if(state == 4)
									_load_drawmsg("Loading...");
									#$menu_font_large.drawCentered(320, 420, "Loading...");
                                                                        #state = 5
								elsif(state == 5)
									_load_drawmsg("Press Any Key To Continue");
						
									#eyecandyfront.cleandeadobjects();
									#eyecandyfront.update();
									#eyecandyfront.draw();
						
									#static int timer = 60;
									#static int index = 0;
									#if(++timer >= 60)
									#{
									#	eyecandyfront.add(new EC_GravText(&menu_font_large, 320, 480, contributors[contributorOrder[index]], -8.2f));
									#	timer = 0;
						      #
									#	if(++index >= NUM_CONTRIBUTORS)
									#		index = 0;
									#}
								end
                $window.flip
                
                if state == 4
                  #backgroundmusic[2].load(musiclist.GetMusic(1));
                  $backgroundmusic[2].load('music/Standard/Menu/menu.ogg');
                  #$backgroundmusic[2].play(false,false)
                  #short k, j;
                  spr_player = []
                  spr_chocobo = []
                  spr_bobomb = []
                  $spr_player = spr_player
                  $spr_chocobo = spr_chocobo
                  $spr_bobomb = spr_bobomb
									4.times do |k|
										spr_player[k] = Array.new(PGFX_LAST);
										spr_chocobo[k] = Array.new(PGFX_LAST);
										spr_bobomb[k] = Array.new(PGFX_LAST);
						
										PGFX_LAST.times do |j|
											spr_player[k][j] = GfxSprite.new;
											spr_chocobo[k][j] = GfxSprite.new;
											spr_bobomb[k][j] = GfxSprite.new;
						
											spr_player[k][j].wrap = true;
											spr_chocobo[k][j].wrap = true;
											spr_bobomb[k][j].wrap = true;
										end
									end
									#puts "$spr_player:#$spr_player"
									loadMenuGraphics();
			            loadGameGraphics();
			            _load_gfx($spr_backmap, "gfx/packs/Classic/backgrounds/Land_Classic.png");
									_load_gfx($spr_frontmap, "gfx/packs/Classic/backgrounds/Land_Classic.png");
			            loadGameSounds();
			            
			            if(!game_values.soundcapable)
										game_values.sound = false;
										game_values.music = false;
										game_values.soundvolume = 0;
										game_values.musicvolume = 0;
									end
									#$maplist.ReadFilters();
			            #$maplist.ApplyFilters(game_values.pfFilters);
			            #ifsoundonplay($sfx_coin);
                  state += 1
                end
                delay = WAITTIME - Timer.ticks + framestart - 2
                
                if delay > 0
                  if delay > WAITTIME
                    delay = WAITTIME
                  end
                  Timer.delay(delay)
                end
                while Timer.ticks - framestart < WAITTIME
                  Timer.delay(0)
                end
                
  end
end


def loadFullSkin(sprites, filename, colorID)
  if filename.is_a? Fixnum
    filename = $skinlist.getIndex(filename)
  end
	return __load_gfxfullskin(sprites, filename, colorID);
end

#def loadFullSkin(sprites, short skinID, colorID)
#{
#	return LoadFullSkin(sprites, skinlist.GetIndex(skinID), colorID);
#}

def __load_gfxfullskin(g, f, colorscheme)
	if(! gfx_createfullskin(g, f, 255, 0, 255, colorscheme) )
		msg = "error loading color keyed sprite %s" % f;
		_load_drawmsg(msg);
		return false;
  end

	return true;
end

def loadMenuSkin(playerID, skinID, colorID)
  puts "loading Menu skin for #{playerID},#{skinID},#{colorID}"
  return __load_gfxmenuskin($spr_player[playerID], $skinlist.getIndex(skinID), colorID);
end

def __load_gfxmenuskin(g, f, colorscheme)
  if(! gfx_createmenuskin(g, f, 255, 0, 255, colorscheme) )
		msg = "error loading color keyed sprite %s" % f;
		_load_drawmsg(msg);
		return false;
	end

	return true;
end
