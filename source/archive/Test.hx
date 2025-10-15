package archive;
import archive.obj.*;
import utils.utilities.*;
import archive.cpp.*;
import archive.backend.*;
import archive.shaders.*;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
import flixel.addons.display.FlxRuntimeShader;
class Test extends MusicBeatState{
	var descJob = new FlxText();
	var __shader = new FishEye();
   	override public function create(){
		var virtuabg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF571900);
		virtuabg.setGraphicSize(Std.int(virtuabg.width * 10));
		virtuabg.scrollFactor.set(0, 0);
		add(virtuabg);

        finishTransition();
        var bg = new FlxSprite().loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.alpha = 0.5;
		// add(bg);
		bg.screenCenter();

        descJob.setFormat(Paths.font('Sonic Advanced 2.ttf'), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descJob.text = 'this is here for testing\nif you see this state... um\n\noopsies?';
        descJob.screenCenter();
        add(descJob);
        CppAPI.setTransparency(Lib.application.window.title, 0x001957);
		// var relPath:String = FileSystem.absolutePath("assets\\archive\\images\\doorlol.jpeg");
		// relPath = relPath.replace("/", "\\");
		// CppAPI.setWallpaper(relPath);

        FlxG.stage.window.x -= 150;
        FlxG.stage.window.y -= 50;
        FlxTween.tween(FlxG.stage.window, {x: FlxG.stage.window.x + 300}, 1.4, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.35});
        FlxTween.tween(FlxG.stage.window, {y: FlxG.stage.window.y + 100}, 0.7, {ease: FlxEase.quadInOut, type: PINGPONG});
	    filters.push(new ShaderFilter(__shader));
        FlxG.camera.filters = filters;
    }
	var filters:Array<BitmapFilter> = [];

    override public function update(elapsed:Float){
		__centerPoint(descJob);

        if (controls.BACK) {
			Init.reset();
			centerInstant();
            MusicBeatState.switchState(new archive.Menu());
        }
    }
    public static function centerInstant() {
		FlxTween.cancelTweensOf(FlxG.stage.window, ['x', 'y']);
        var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
        var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);
        var xCos = (resolutionX - Lib.application.window.width)/2;
        var yCos = (resolutionY - Lib.application.window.height)/2;

        Lib.application.window.x = Std.int(xCos);
        Lib.application.window.y = Std.int(yCos);
    }
    public static function __centerPoint(target:FlxObject) {
        /**
         * centers target to center of the display screen, target can't be cam
         */
        var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
        var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);
        var xCos = Lib.application.window.x - (resolutionX - target.width)/2;
        var yCos = Lib.application.window.y - (resolutionY - target.height)/2;

        target.x = -Std.int(xCos);
		target.y = -Std.int(yCos);
    }

    /**
 * ...
 * @author Jack Bass
 */
    private static var hexCodes = "0123456789ABCDEF";

	public static function rgbToHex(r:Int, g:Int, b:Int):Int
	{
		var hexString = "0x";
		//Red
		hexString += hexCodes.charAt(Math.floor(r/16));
		hexString += hexCodes.charAt(r%16);
		//Green
		hexString += hexCodes.charAt(Math.floor(g/16));
		hexString += hexCodes.charAt(g%16);
		//Blue
		hexString += hexCodes.charAt(Math.floor(b/16));
		hexString += hexCodes.charAt(b%16);
		
		return Std.parseInt(hexString);
	}
	
	public static function rgbaToHex(r:Int, g:Int, b:Int, a:Int):Int
	{
		var hexString = "0x";
		//Red
		hexString += hexCodes.charAt(Math.floor(r/16));
		hexString += hexCodes.charAt(r%16);
		//Green
		hexString += hexCodes.charAt(Math.floor(g/16));
		hexString += hexCodes.charAt(g%16);
		//Blue
		hexString += hexCodes.charAt(Math.floor(b/16));
		hexString += hexCodes.charAt(b%16);
		//Alpha
		hexString += hexCodes.charAt(Math.floor(a/16));
		hexString += hexCodes.charAt(a%16);
		
		
		return Std.parseInt(hexString);
	}
}