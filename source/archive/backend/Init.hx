package archive.backend;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import utils.*;
import utils.shaders.*;

import backend.WeekData;

import flixel.input.keyboard.FlxKey;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

class Init extends MusicBeatState{
	public static var move = false;
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	var bot = new FlxSprite();
    var top = new FlxSprite();
	override public function create():Void{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
        top.loadGraphic(Paths.image('TRANSIT', 'archive'));
		top.setGraphicSize(FlxG.width, FlxG.height/2);
		top.updateHitbox();
		top.scrollFactor.set();
		top.screenCenter(X);
		top.flipX = true;
		top.y = 0;
		add(top);

        bot.loadGraphic(Paths.image('TRANSIT', 'archive'));
		bot.setGraphicSize(FlxG.width, FlxG.height/2);
		bot.updateHitbox();
		bot.scrollFactor.set();
		bot.screenCenter(X);
        bot.flipY = true;
        bot.y = FlxG.height/2;
        add(bot);

		if (FlxG.sound.music == null) archive.Menu.startMusic();

		ClientPrefs.loadPrefs();
		Language.reloadPhrases();

		if(FlxG.save.data != null && FlxG.save.data.fullscreen)FlxG.fullscreen = FlxG.save.data.fullscreen;
		persistentUpdate = true;
		persistentDraw = true;

		//below system would be changed
		if(FlxG.save.data.seenWarning == null)
			openSubState(new WarningSubState());
		else move = true;
	}

	override function update(elapsed:Float){
		if (move) FlxG.switchState(new archive.Menu());

		super.update(elapsed);
	}
	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
}

class WarningSubState extends MusicBeatSubstate
{
	var finT:Bool = false;

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

		redText = new FlxText(0, -70, FlxG.width,'!WARNING!',32);
		redText.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.RED, CENTER);
		redText.scrollFactor.set();
		redText.alpha = 1;
		add(redText);

		warnText = new FlxText(0, -70, FlxG.width,'',16);
		warnText.setFormat(Paths.font("vcr.ttf"), 25, FlxColor.WHITE, CENTER);
		warnText.text=
	   '\n\n----------------------------------------------\n
			This application may contain flashing lights, loud sounds and graphic imagery\n
			If you\'re sensitive to any of these these, player/viewer discretion is adviced!\n\n
			If you experience nausea, dizziness, sore/dry eyes or disorientation\n
			please stop playing and seek medical help\n
			Remember that staying safe is more important!
		  \n----------------------------------------------\n
			Thank you for playing!';
		warnText.scrollFactor.set();
		warnText.y += redText.height + 2;
		warnText.alpha = 0.0;
		add(warnText);


		FlxTween.tween(bg, { alpha: 0.8 }, 0.6, { ease: FlxEase.sineIn });
		FlxTween.tween(warnText, { alpha: 1.0 }, 0.6, { ease: FlxEase.sineIn });
		FlxTween.tween(redText, {y: warnText.y - redText.height }, 0.8, { ease: FlxEase.sineIn, onComplete: (_) -> {finT = true;} });
	}

	override function update(elapsed:Float){
		if(finT){
			if (controls.ACCEPT) {
				FlxTween.tween(redText, {y: -redText.height }, 0.6, { ease: FlxEase.sineIn });
				FlxTween.tween(bg, { alpha: 0.0 }, 0.9, { ease: FlxEase.sineOut });
				FlxTween.tween(warnText, {alpha: 0}, 1, {ease: FlxEase.sineOut,
				onComplete: function (twn:FlxTween) {
					Init.move = true;
					close();
				}});
			}
		}

		super.update(elapsed);
	}
}
