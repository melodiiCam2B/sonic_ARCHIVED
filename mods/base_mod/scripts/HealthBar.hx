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

function onCountdownStarted(){
    
    switch(songName){
        default:
            hpbar(getModSetting('healthbarskin'));
        case 'destruction-protocol':
            createSplitBar(songName);
    }

}

function hpbar(file:String){
    game.healthBar.bg.loadGraphic(Paths.image('hud/healthBar/' + file +'-base'));
    game.healthBar.rightBar.loadGraphic(Paths.image('hud/healthBar/'+ file +'-right'));
    game.healthBar.leftBar.loadGraphic(Paths.image('hud/healthBar/'+ file +'-left'));

    game.healthBar.barWidth = game.healthBar.bg.width;
    game.healthBar.barHeight = game.healthBar.bg.height;

    game.healthBar.bg.updateHitbox();

    game.healthBar.screenCenter();
    switch(file){
        case 'supersonicracing':
            game.healthBar.scale.set(3.1,3,1);
        case 'metronome':
            game.healthBar.scale.set(2.1,2,1);
    }

    switch(file){
        case 'metronome':
            game.healthBar.y += 320;
        default: 
            if(callOnLuas('getMidScrole') == true){
                game.healthBar.y -= 300;
            }else{
                game.healthBar.y += 300;
            }
    }

    game.scoreTxt.visible = false;
    // game.iconP2.visible = false;
    // game.iconP1.visible = false;

    game.healthBar.bg.visible = true;
    game.healthBar.rightBar.visible = true;
    game.healthBar.leftBar.visible = true;


    game.healthBar.bg.antialiasing = false;
    game.healthBar.rightBar.antialiasing = false;
    game.healthBar.leftBar.antialiasing = false;
}