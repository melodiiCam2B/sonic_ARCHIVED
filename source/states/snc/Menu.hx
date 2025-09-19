package states.snc;

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

class Menu extends MusicBeatState{
    var songs:Array<Array<String>> = [//row 1
		['too-fest', 'Original: Punkett\nRemix: Melodii2b\nArt: ???\nChart: KitKat', 'sanic'], 
		['milk', 'Original: Squeaks\nRemix: KitKat\nArt: ???\nChart: KitKat', 'sunky']
	];
	var select:Array<String> = ['Stage Select', 'Settings', 'Credits', 'Exit'];
	var options:Array<String> = ['Controls', 'Graphics', 'Visuals', 'Gameplay'];
    var curDifficulty:Int = -1;
    var curSelected:Int = 0;
   	var curOption:Int = 0;
	var storeGroupY:Float = -1;
	var cardGroup:FlxSpriteGroup;
	var txtGroup:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
	var selected = new FlxSprite();
   	override public function create(){
		PlayState.isStoryMode = false;
		var bg = new FlxSprite().loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		add(bg);
		bg.screenCenter();

		for(i in 0...select.length){
			var options = new FlxText();
        	options.text = select[i];
        	options.setFormat(Paths.font('Sonic Advanced 2.ttf'), 60, FlxColor.WHITE);
        	options.y = 50 + i * options.height;
        	options.x = 40;
        	txtGroup.add(options);
		}

		changeOption();
		add(selected);
		add(txtGroup);

		cardGroup = new FlxSpriteGroup();
		for(i in 0...songs.length){
			var newCard = new Plate(songs[i][0],songs[i][1]/**,songs[i][2]**/);
			newCard.x += i * 380;
			cardGroup.add(newCard);
		}
		cardGroup.screenCenter();
		storeGroupY = cardGroup.y;
		cardGroup.y += 720;
		add(cardGroup);
    }

	var mousey:Float = 0;
	var ogTexty:Float = 0;
	var wheely:Float = 0;
	var isdrag:Bool = false;
	var freePlay:Bool = false;
	var settings:Bool = false;
    override public function update(elapsed:Float){
		if(freePlay){
			if (FlxG.mouse.justPressed){
				mousey = FlxG.mouse.screenX;
				ogTexty = cardGroup.x;
			}

			if(FlxG.mouse.pressed){
				wheely = ogTexty - (mousey - FlxG.mouse.x);
				var lerpVal:Float = boundTo(elapsed * 9, 0, 1);
				cardGroup.x = FlxMath.lerp(cardGroup.x, wheely, lerpVal);
				isdrag = true;
			}

			if(isdrag){
				if(cardGroup.x > (FlxG.width- 30)) cardGroup.x = FlxG.width - 40;
				else if(cardGroup.x < (-FlxG.width- 30)) cardGroup.x = -FlxG.width - 40;	
			}

			if(FlxG.mouse.justReleased)isdrag = false;
			
			if (controls.BACK) {
				FlxTween.tween(cardGroup, {y: storeGroupY + 720}, 0.5, {onComplete: function(twn:FlxTween){
				freePlay = false;
				isdrag = false;
        		}});
			}

			// if (controls.ACCEPT){
			// 	persistentUpdate = false;
			// 	var songLowercase:String = Paths.formatToSongPath(songs[curSelected]);
			// 	var poop:String = Highscore.formatSong(songLowercase, curDifficulty);

			// 	Song.loadFromJson(poop, songLowercase);
			// 	PlayState.storyDifficulty = curDifficulty;

			// 	LoadingState.prepareToSong();
			// 	LoadingState.loadAndSwitchState(new PlayState());
			// }

			txtGroup.forEach(function(spr:FlxText){
				spr.alpha = 0.5;
			});
		}else if(settings){
			if(FlxG.keys.justPressed.LEFT ||FlxG.keys.justPressed.RIGHT) changeSub(FlxG.keys.justPressed.LEFT? -1 : 1);
			if (controls.ACCEPT) openSelectedSubstate(options[curOption]);
			
			if (controls.BACK){
				var curMember:FlxText = txtGroup.members[curSelected];
				curMember.text = 'Settings';
				changeOption();
				settings = false;
			}
		}else{
			txtGroup.forEach(function(spr:FlxText){
				spr.alpha = 1;
			});

        	if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN){
            	changeOption(FlxG.keys.justPressed.UP? -1 : 1);
        	}
			
			if (controls.ACCEPT){
				switch(select[curSelected]){
					case 'Stage Select':
						FlxTween.tween(cardGroup, {y: storeGroupY}, 0.5, {onComplete: function(twn:FlxTween){
							freePlay = true;
        				}});
					case 'Settings': 
						changeSub();
						settings = true;
					case 'Credits': 
						MusicBeatState.switchState(new states.snc.Credits());
					case 'Exit': 
						Sys.exit(0);
				}
			}
		}
    }
	function changeSub(?i:Int = 0){
		curOption = FlxMath.wrap(curOption + i, 0, select.length - 1);

		var curMember:FlxText = txtGroup.members[curSelected];
		curMember.text = 'Settings > ';
		setText(options[curOption], curMember);
	}

    public function setText(txt:String, txtSpr:FlxText) {
        var toInt:Int = txt.length;

        var i:Int = 0;
        new FlxTimer().start(0.04, function(tmr:FlxTimer) {
            txtSpr.text += txt.charAt(i);

			selected.makeGraphic(Std.int(txtSpr.width + 20),Std.int(txtSpr.height) , FlxColor.BLACK);
			selected.x = txtSpr.x + (txtSpr.width - selected.width) / 2;
        	selected.y = txtSpr.y + (txtSpr.height - selected.height) / 2;
            i+=1;
            if (i >= toInt) {
                tmr.cancel();

            }
        }, toInt);
    }

	function openSelectedSubstate(label:String) {
		switch(label){
			case 'Controls':
				// openSubState(new options.snc.opt.subs.Control());
			case 'Graphics':
				openSubState(new states.snc.opt.subs.Graphic());
			case 'Visuals':
				openSubState(new states.snc.opt.subs.Visual());
			case 'Gameplay':
				openSubState(new states.snc.opt.subs.Gameplay());
		}
	}

	function changeOption(?i:Int = 0){
		curSelected = FlxMath.wrap(curSelected + i, 0, select.length - 1);

		var curMember:FlxText = txtGroup.members[curSelected];
		selected.makeGraphic(Std.int(curMember.width + 20),Std.int(curMember.height) , FlxColor.BLACK);
		selected.x = curMember.x + (curMember.width - selected.width) / 2;
        selected.y = curMember.y + (curMember.height - selected.height) / 2;
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float {
		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
	}
}