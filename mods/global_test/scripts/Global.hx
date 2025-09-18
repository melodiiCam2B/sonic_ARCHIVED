import openfl.Lib;
import lime.app.Application;

var curStage = Lib.current.stage.window.display.currentMode;
var FNF_FACTOR:{width:Float, height:Float} = {width: curStage.width/2, height: curStage.height/2};
var MIKU_STAGE:{width:Float, height:Float} = {width: 960, height:  720};

function onSpawnNote(note) if(note.isSustainNote) note.alpha = 1;

function init() __resizeGame(MIKU_STAGE.width, MIKU_STAGE.height, 1.5);
function exit() __resizeGame(FNF_FACTOR.width, FNF_FACTOR.height, 1.5);


function __resizeGame(width:Float, height:Float, ?windowScale:Float) {
    FlxG.width = width; FlxG.height = height;
    FlxG.initialWidth = width; FlxG.initialHeight = height;

    FlxG.resizeWindow(width * windowScale, height * windowScale);
    FlxG.resizeGame(width, height);

	__toCenter();

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
