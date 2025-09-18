import Main;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.graphics.tile.FlxGraphicsShader;
import flixel.FlxObject;
import openfl.filters.ShaderFilter;
import openfl.Lib;

var FNF_RESOLUTION:{width:Float, height:Float} = {width: 1280, height: 720};
var UT_RESOLUTION:{width:Float, height:Float} = {width: 640, height: 480};
var OW_RESOLUTION:{width:Float, height:Float} = {width: 1280/2, height: 720/2};
var TEST_RESOLUTION:{width:Float, height:Float} = {width: 640, height:  720};
var __resizedTo:Int = 0;  // 0 fnf, 1 undertale, 2 overworld  - Nex
var __utScaleMode:RatioScaleMode = new RatioScaleMode();

var __oldFNFFramerate:Float = FlxG.updateFramerate;
var UT_FRAMERATE:Int = 30;


function onCreate(){
    __undertaleResize();
}

function __fnfResize() {
    if (__resizedTo == 0) return;
    __resizedTo = 0;

    __resizeGame(FNF_RESOLUTION.width, FNF_RESOLUTION.height, 1.5);
    // FlxG.scaleMode = Main.scaleMode;

    // __pixelPerfect(false);
}

function __undertaleResize() {
    if (__resizedTo == 1) return;
    __resizedTo = 1;

    __resizeGame(TEST_RESOLUTION.width, TEST_RESOLUTION.height, 1);
    // FlxG.scaleMode = __utScaleMode;

    // __pixelPerfect(true);
}

function __resizeGame(width:Float, height:Float, ?windowScale:Float) {

    FlxG.width = width; FlxG.height = height;
    FlxG.initialWidth = width; FlxG.initialHeight = height;

    FlxTween.tween(Lib.application.window, {width:width*windowScale, height:height*windowScale},0.5, {onUpdate: (_) -> {
        FlxG.resizeWindow(width, height);
        FlxG.resizeGame(width, height);
        __toCenter();
    },onComplete: function (twn:FlxTween) {
	    __toCenter();
	}});

    for (camera in FlxG.cameras.list) {
        camera.width = FlxG.width;
        camera.height = FlxG.height;
    }
}


function __toCenter(){
    var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
    var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);

    Lib.application.window.x = (resolutionX - Lib.application.window.width) / 2;
    Lib.application.window.y = (resolutionY - Lib.application.window.height) / 2;
}

function __onCameraAdd(camera:FlxCamera)
    if (camera != null) camera.pixelPerfectRender = __resizedTo != 0;
function __pixelPerfect(pixelPerfect:Bool) {
    FlxG.game.stage.quality = pixelPerfect ? 2 /*LOW*/ : 0 /*BEST*/;
    FlxG.forceNoAntialiasing = pixelPerfect ? true : null;

    // Makes every pixel render properly
    FlxG.game.setFilters(pixelPerfect ? [new ShaderFilter(new FlxGraphicsShader())] : []);

    if (pixelPerfect)
        FlxG.cameras.cameraAdded.add(__onCameraAdd);
    else
        FlxG.cameras.cameraAdded.remove(__onCameraAdd);

    for (camera in FlxG.cameras.list) __onCameraAdd(camera);
    FlxObject.defaultPixelPerfectPosition = pixelPerfect;
}

function onDestroy(){
    __fnfResize();
}