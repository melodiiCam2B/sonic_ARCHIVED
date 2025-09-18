import openfl.Lib;
import flixel.FlxG;
import utils.Path;
import lime.app.Application;
import backend.DiscordClient;
import Sys;
import lime.graphics.Image;
import openfl.utils.Assets as OpenFlAssets;
import backend.Mods;

var isTrue = false;
var checkReturn = null;
function onCountdownStarted(){
	checkDirectory();
	if(!Path.fileCheck('mods/funkin_underground/thisfolderdoesnothing/pasta.png') && checkReturn){
		isTrue = true;
		FlxG.sound.music.pause();
		FlxG.sound.music.volume = 0;


		var pastaBox = new FlxSprite();
    	pastaBox.makeGraphic(3000, 3000, FlxColor.BLACK);
    	pastaBox.camera = camHUD;
    	pastaBox.screenCenter();
    	add(pastaBox);

		var pastaSpr = new FlxSprite();
    	pastaSpr.loadGraphic(Paths.cacheBitmap('scripts/pasta.png'));
    	pastaSpr.camera = camHUD;
		pastaSpr.scale.set(0.6,0.6);
    	pastaSpr.screenCenter();
    	pastaSpr.alpha = 0;
    	add(pastaSpr);
		DiscordClient.shutdown();
		FlxTween.tween(pastaSpr, { alpha: 1.0 }, 0.6, {onComplete: function (twn:FlxTween){Sys.exit(1);}});
		Application.current.window.alert('Bloodpasta, hear it\'s cries!', "Sans!");
	}
}
function checkDirectory(){

	return checkReturn = Mods.currentModDirectory ==  'funkin_underground' ? true : false;
}
function onCountdownTick(counter){
	if(isTrue){return Function_Stop;}
}