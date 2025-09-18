import openfl.Lib;
import flixel.FlxG;
import backend.Paths;
import backend.Mods;
import states.PlayState;
import lime.graphics.Image;
import objects.Bar;
import flixel.tweens.FlxTween;
import lime.app.Application;
import states.MainMenuState;
import backend.Difficulty;
import flixel.text.FlxText;

var file = 'avulsion';
var storeX = 0;
function onCountdownStarted(){
    
    // game.timeBar.
    game.timeBar.bg.loadGraphic(Paths.image('hud/timeBar/' + file +'_base'));
    game.timeBar.rightBar.loadGraphic(Paths.image('hud/timeBar/'+ file +'_fill'));
    game.timeBar.leftBar.loadGraphic(Paths.image('hud/timeBar/'+ file +'_fill'));
    game.timeBar.barWidth = game.timeBar.bg.width;
    game.timeBar.barHeight = game.timeBar.bg.height;
    game.timeBar.scale.set(1.2,1,2);
    storeX = game.timeBar.y;
    game.timeBar.screenCenter();
    game.timeBar.y = storeX-10;
}