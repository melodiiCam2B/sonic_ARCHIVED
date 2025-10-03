import openfl.Lib;
import flixel.FlxG;
import backend.Paths;
import states.PlayState;
import objects.Bar;
import flixel.tweens.FlxTween;
import lime.app.Application;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import backend.Mods;

var black:FlxSprite = new FlxSprite();
var blue:FlxSprite = new FlxSprite();
var circle:FlxSprite = new FlxSprite();
var title:FlxText = new FlxText();
var _pixel = null;
var posSave = {
    __x: 0,
    __y: 0
};
function getFont(){
    return Paths.font('sonic-classic-open-c');
}
function isPixel(){
    return game.stageUI == 'pixel' ? true : false;
}
function getColor(){
    return FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]);
}
function onCreate(){
    game.skipCountdown = true;
    _pixel = isPixel();

    black.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    black.screenCenter();
    black.visible = _pixel ? false : true;
    black.camera = camOther;

    blue.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
    blue.screenCenter();
    blue.visible = _pixel ? true : false;
    blue.camera = camOther;

    circle.loadGraphic(Paths.image('hud/intro/'+(_pixel ? 'pixel':'normal')));
    circle.y = (FlxG.height / 2) - (circle.height / 2);
	circle.antialiasing = false;
    circle.x = 517 + FlxG.width;
    circle.color = getColor();
    circle.camera = camOther;

    title.setFormat(getFont(), 100, 0xFFFFFFFF, "center");
    title.text = songName.toUpperCase();
	title.y = (FlxG.height / 2) - (title.height / 2)-40;
	title.x = -FlxG.width - 698;
    title.camera = camOther;
    
    add(blue);
    add(black);
    add(circle);
    add(title);
    FlxTween.tween(circle, {x: (FlxG.width / 2) - (circle.width / 2) + 60}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.quadOut});

    FlxTween.tween(title, {x: (FlxG.width / 2) - (title.width / 2)}, (Conductor.crochet / 1000) * 3, {ease: FlxEase.quadOut,onComplete: function(twn:FlxTween){
        new FlxTimer().start((Conductor.crochet / 1000) * 1.25, function(tmr:FlxTimer) {
            FlxTween.tween(blue, {alpha: 0}, 1, {ease: FlxEase.sineOut});
            FlxTween.tween(black, {alpha: 0}, 1, {ease: FlxEase.sineOut});
            FlxTween.tween(circle, {alpha: 0}, 1, {ease: FlxEase.sineOut});
            FlxTween.tween(title, {alpha:0}, 1, {ease: FlxEase.sineOut,onComplete: function(twn:FlxTween){
				blue.destroy();
                black.destroy();
				circle.destroy();
				title.destroy();
            }});
            
        });
    }});
}
