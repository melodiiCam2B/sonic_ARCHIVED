package utils.sys;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.app.Application;
import flixel.util.FlxTimer;
import openfl.media.Sound;
import openfl.system.System;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import sys.FileSystem;
import sys.io.File;
class Crash extends FlxState{	
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;
	var _bg = new FlxSprite();
	var _birder = new FlxSprite();

	public var error:String;
	public var errorName:String;
	public var report:FlxText = new FlxText(0, 0, FlxG.width / 1.5);
	public static var trackSound:Map<String, Sound> = [];
	public function new(prevState:FlxState, error:String, errorName:String):Void{
		this.error = error;
		this.errorName = errorName;

		super();
	}

	override public function create(){
		FlxG.sound.playMusic(sounds('archive/music/crash'));
		super.create();

		DiscordClient.changePresence("Crash Handler", 'utils.sys.Crash','silly', null, null, 'crash');

		_bg.loadGraphic(Path.image('system/images/crashBg.png'));
		_bg.scale.set(0.7,0.7);
		_bg.scrollFactor.set(.75, .75);
		_bg.screenCenter();
		add(_bg);

		var msg:String = 'Whoops! Something went wrong...\n\n';
		var error:String = 'Error caught: ${errorName}\n${error}\nPress [space] to go back to the MainMenu\nPlease message [melodiicam2b.vbs] if this issue persists!';

		report.text = msg + error;
		report.setFormat(Path.font('NovaMono.ttf'), 16, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
		report.screenCenter(XY);
		report.borderSize = 1.5;
		report.scrollFactor.set(0, 0);
		add(report);
		trace(report.text);
	}

	override function update(elapsed:Float){
		if (FlxG.keys.justPressed.SPACE) goswitch();
		super.update(elapsed);
		mouseLook();
	}

	function goswitch(){
		MusicBeatState.switchState(new archive.Menu());
		archive.Menu.startMusic();
	}

	function path(path:String){
		if (!FileSystem.exists(path)){
			trace('could not find $path');
			return null;
		}
		return path;
	}

	function sounds(file:String){
		trackSound.set(file, OpenFlAssets.getSound(path('assets/'+file+'.'+SOUND_EXT)));
		return trackSound.get(file);
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
}
