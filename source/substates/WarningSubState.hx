package substates;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

import states.MainMenuState;
import states.TitleState;

class WarningSubState extends MusicBeatSubstate
{
	var leftState:Bool = false;

	var bg:FlxSprite;
	var warnText:FlxText;
	var redText:FlxText;
	override function create(){
		super.create();
		ClientPrefs.data.seenWarning = true;
		ClientPrefs.saveSettings();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.alpha = 0.0;
		add(bg);

		redText = new FlxText(0, -50, FlxG.width,'!WARNING!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',32);
		redText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.RED, CENTER);
		redText.scrollFactor.set();
		redText.screenCenter(Y);
		redText.alpha = 0.0;
		add(redText);

		warnText = new FlxText(0, 0, FlxG.width,'',16);
		warnText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		warnText.text=
			'\n
			-----------------------------------------------\n
			This application may contain flashing lights, loud sounds and graphic imagery\n
			If you\'re sensitive to any of these these, player/viewer discretion is adviced!\n\n
			If you experience nausea, dizziness, sore/dry eyes or disorientation please stop playing and seek help or take a break! 
		  \n-----------------------------------------------\n
			Thank you for playing!';
		warnText.scrollFactor.set();
		warnText.screenCenter(Y);
		warnText.alpha = 0.0;
		add(warnText);

		FlxTween.tween(bg, { alpha: 0.8 }, 0.6, { ease: FlxEase.sineIn });
		FlxTween.tween(warnText, { alpha: 1.0 }, 0.6, { ease: FlxEase.sineIn });
		FlxTween.tween(redText, { alpha: 1.0 }, 0.6, { ease: FlxEase.sineIn });
	}

	override function update(elapsed:Float){
		if (controls.ACCEPT) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxTween.tween(bg, { alpha: 0.0 }, 0.9, { ease: FlxEase.sineOut });
			FlxTween.tween(warnText, {alpha: 0}, 1, {ease: FlxEase.sineOut,
				onComplete: function (twn:FlxTween) {
				FlxG.state.persistentUpdate = true;
					close();
				}
				
			});
			
		}
		super.update(elapsed);
	}
}
