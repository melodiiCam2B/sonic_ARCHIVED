package states.sillys;

import flixel.*;
import openfl.*;
import haxe.*;
import sys.*;
import lime.*;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;
import utils.Path;

import utils.utilities.WinUtils;

import states.editors.MasterEditorMenu;
import options.OptionsState;

import backend.WeekData;
import backend.Highscore;
import backend.Song;
import states.PlayState;

typedef CoolShitNGL = {}
class WoManState extends MusicBeatState{
	var selectGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var selectables:Array<String> = ['story_mode','freeplay','options','credits'];
	var curSelected = 0;
	var camFollow:FlxObject;

	var curDifficulty:Int = 1;

	override public function create(){

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		FlxG.camera.follow(camFollow, null, 0.10);


		var grid:FlxBackdrop = new FlxBackdrop(Path.image('system/images/fogBG.png'));
		grid.velocity.set(40, 40);
		add(grid);
		
		add(selectGroup);
		for (i in 0...selectables.length){
			var spr:FlxSprite = new FlxSprite(30, -50 + (i * 180));
			spr.scale.set(0.4,0.4);
			spr.loadGraphic(Path.image('system/images/selectors/${selectables[i]}.png'));
			spr.ID = i;
			// spr.screenCenter(Y);
			spr.scrollFactor.set(0,0);
			selectGroup.add(spr);
		}

        itemI();

		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Press [debug 3] to show mods!", 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat(Paths.font("DTM-Mono.otf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
	}

	override public function update(elapsed:Float){
		super.update(elapsed);

        if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN){
            itemI(FlxG.keys.justPressed.UP? -1 : 1);
        }

        for (i in 0...selectables.length){
			var distItem:Int = -1;
			var memb:FlxSprite = selectGroup.members[i];
   		    if(FlxG.mouse.overlaps(memb)){
				distItem = i;
				curSelected = distItem;
                itemI();
			}
		};


		if (controls.ACCEPT || FlxG.mouse.justPressed){
			switch (selectables[curSelected]){
				case 'story_mode':
					FlxG.sound.play(Paths.sound('confirmMenu'));
					MusicBeatState.switchState(new StoryMenuState());
				case 'freeplay':
					FlxG.sound.play(Paths.sound('confirmMenu'));
					MusicBeatState.switchState(new FreeplayState());
				case 'credits':
					FlxG.sound.play(Paths.sound('confirmMenu'));
					MusicBeatState.switchState(new CreditsState());
				case 'options':
					FlxG.sound.play(Paths.sound('confirmMenu'));
					MusicBeatState.switchState(new OptionsState());
					OptionsState.onPlayState = false;
					if (PlayState.SONG != null){
						PlayState.SONG.arrowSkin = null;
						PlayState.SONG.splashSkin = null;
						PlayState.stageUI = 'normal';
					}
			}
		}
		


		if (controls.justPressed('debug_1')){
			MusicBeatState.switchState(new MasterEditorMenu());
		}

		if (controls.justPressed('debug_3')){
			MusicBeatState.switchState(new ModsMenuState());
		}
		mouseLook();
	}


	
	function songMode(?caseSwitch:String){
		switch(caseSwitch){
			case 'sans!':
				PlayState.storyPlaylist = ['tears'];
				PlayState.isStoryMode = true;
				PlayState.storyDifficulty = 1;
			
				Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0].toLowerCase());
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
			default:
				MusicBeatState.switchState(new StoryMenuState());
		}
	}

	var xx:Float = 0;
	var yy:Float = 0;
	var mx:Float = 0;
	var my:Float = 0;
	var lerpVal = 0.04;

	function mouseLook() {
		mx = (FlxG.mouse.screenX - 640) / 10;
		my = (FlxG.mouse.screenY - 480) / 10;

		xx = FlxMath.lerp(xx, mx, lerpVal);
		yy = FlxMath.lerp(yy, my, lerpVal);

		FlxG.camera.scroll.x = xx;
		FlxG.camera.scroll.y = yy;
	}

	function itemI(?i:Int = 0){
		curSelected = FlxMath.wrap(curSelected + i, 0, selectables.length - 1);
		selectGroup.forEach(function(spr:FlxSprite){
			spr.updateHitbox();
			spr.centerOffsets();
			spr.alpha = 0.5;

			if (spr.ID == curSelected){
				spr.alpha = 1;
				// camFollow.y = spr.getGraphicMidpoint().y;
			}

		});
	}
}
/**
 
  		Lua_helper.add_callback(lua, "loadSong", function(?name:String = null, ?difficultyNum:Int = -1) {
			if(name == null || name.length < 1)
				name = Song.loadedSongName;
			if (difficultyNum == -1)
				difficultyNum = PlayState.storyDifficulty;

			var poop = Highscore.formatSong(name, difficultyNum);
			Song.loadFromJson(poop, name);
			PlayState.storyDifficulty = difficultyNum;
			FlxG.state.persistentUpdate = false;
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.pause();
			FlxG.sound.music.volume = 0;
			if(game != null && game.vocals != null)
			{
				game.vocals.pause();
				game.vocals.volume = 0;
			}
			FlxG.camera.followLerp = 0;
		});
 */