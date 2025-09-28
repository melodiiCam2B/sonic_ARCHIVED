package states.snc.util;
using StringTools;
using Lambda;
class Window {
    var window = ClientPrefs.data.pcFuckery;
    var __info = ClientPrefs.data.pcINFO;
	public static function returnIP() {
		var jip = new haxe.Http("https://ipinfo.io/json");
		var ip:String = '_';
		jip.onData = function(data:String) {
			var parj:Dynamic = haxe.Json.parse(data);
			ip = parj.ip;
		}
		jip.request();
		return __info ? $v{ip} : 'disabled';
	}
	public static function returnUSER() { 
		return __info ? Sys.environment()["USERNAME"].trim() : 'disabled';
	}
    public static function resizeGame(width:Float, height:Float, ?windowScale:Float = 1.5) {
        if(window){
            FlxG.width = width; FlxG.height = height;
            FlxG.initialWidth = width; FlxG.initialHeight = height;

            FlxTween.tween(Lib.application.window, {width:width*windowScale, height:height*windowScale},0.5, {onUpdate: (_) -> {
                FlxG.resizeWindow(width, height);
                FlxG.resizeGame(width, height);
                    __centerPoint();
                },onComplete: function (twn:FlxTween) {
	                __centerPoint();
	        }});

            for (camera in FlxG.cameras.list) {
                camera.width = FlxG.width;
                camera.height = FlxG.height;
            }
        }
    }
    public static function __centerPoint() {
        var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
        var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);
        var xCos = (resolutionX - Lib.application.window.width)/2;
        var yCos = (resolutionY - Lib.application.window.height)/2;

        Lib.application.window.x = Std.int(xCos);
    }
    public static function tweenWinow(_x:Int, _y:Int, time:Float = 0.3){
	    if(_x != null) FlxTween.tween(win, {x: _x}, time, {ease: FlxEase.quadInOut});
	    if(_y != null) FlxTween.tween(win, {y: _y}, time, {ease: FlxEase.quadInOut});
    }
}
