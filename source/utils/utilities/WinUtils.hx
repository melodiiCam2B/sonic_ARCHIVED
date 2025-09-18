package utils.utilities;

import openfl.Lib;
import openfl.display.Stage;
import flixel.FlxG.*;
import flixel.tweens.FlxTween;
import lime.app.Application;
import lime.ui.Window;
import lime.app.Application;
import sys.FileSystem;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;


class WinUtils {
    public static function checkName() {
        return (Application.current.window.title == "Funkin' Underground" ? 'sans!':'fag');
    }

    public static function centerWindowOnPoint(time:Float = 0.6) {
        var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
        var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);

        var xCos = (resolutionX - Lib.application.window.width)/2;
        var yCos = (resolutionY - Lib.application.window.height)/2;

	    tweenWin(xCos, yCos, time);
    }

    public static function centerInstant() {
        var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
        var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);
        var xCos = (resolutionX - Lib.application.window.width)/2;
        var yCos = (resolutionY - Lib.application.window.height)/2;

        Lib.application.window.x = Std.int(xCos);
        Lib.application.window.y = Std.int(yCos);
    }
    
    public static function tweenWin(_x:Float, _y:Float, time:Float = 0.6){
	    FlxTween.tween(Lib.application.window, {x: _x}, time, {ease: FlxEase.quadInOut});
	    FlxTween.tween(Lib.application.window, {y: _y}, time, {ease: FlxEase.quadInOut});
    }

    public static function tweenXWin(_x:Int, time:Float = 0.3){
	    FlxTween.tween(Lib.application.window, {x: _x}, time, {ease: FlxEase.quadInOut});
    }

    public static function tweenYWin(_y:Int, time:Float = 0.3){
	    FlxTween.tween(Lib.application.window, {y: _y}, time, {ease: FlxEase.quadInOut});
    }

    

    public static function resizeWindow(width:Int, height:Int, time:Float = 0.3){
        var windowRes = FlxPoint.get(Lib.application.window.width, Lib.application.window.height);

        FlxTween.tween(windowRes, {x: 1280, y: 720}, 0.3 * 4, {ease: FlxEase.circInOut, onUpdate: (_) -> {
	        FlxG.resizeWindow(Std.int(windowRes.x), Std.int(windowRes.y));
            centerInstant();
        }, onComplete: function(twn:FlxTween){
	        centerInstant();
        }});
    }
}
