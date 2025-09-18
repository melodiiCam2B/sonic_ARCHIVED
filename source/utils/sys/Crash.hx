package utils.sys;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.app.Application;
import flixel.util.FlxTimer;

class Crash extends FlxState
{
	var _bg = new FlxSprite();
	var _birder = new FlxSprite();

	public var error:String;
	public var errorName:String;
	public var report:FlxText = new FlxText(0, 0, FlxG.width / 1.5);

	public function new(prevState:FlxState, error:String, errorName:String):Void{
		this.error = error;
		this.errorName = errorName;

		super();
	}

	override public function create(){
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
	}

	override function update(elapsed:Float){
		if (FlxG.keys.justPressed.SPACE)MusicBeatState.switchState(new states.sillys.WoManState());
		super.update(elapsed);
		mouseLook();
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
