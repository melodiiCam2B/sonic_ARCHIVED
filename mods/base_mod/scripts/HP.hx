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

import utils.utilities.MathUtils;

import utils.utilities.Util;

var leftBar:FlxSprite = new FlxSprite();
var rightBar:FlxSprite = new FlxSprite();
var healthSpr:FlxSprite = new FlxSprite();
var percent:Float = 0;

var healthTracker:FlxText = new FlxText();

/**
 * HP = 20, miss = 1
 */
var cd = (Mods.currentModDirectory ==  'base_mod' ? true : false);
var _i = {
    multi: 1.4,
    width: 10,
    height: 30,
    posy: 307,
    curHP: 20,
    maxHP: 20,
    hpDiv: 0.020 // here to correctly measure out the hp bar until I can find a more reliable way
}

function noteMiss(){
    _i.curHP -= 1;
    leftBar.scale.x -=(_i.hpDiv*(_i.maxHP/_i.maxHP));
    leftBar.updateHitbox();
    barPos();
}
function _check(_:Float,point:Float,r:Float, max:Bool){
    if(!max) return _ < point ? 0 : r;
    else return _ > point ? 0 : r;
}
function onUpdate(){
    healthTracker.text = _i.curHP +'/'+_i.maxHP;
    // healthTracker.text = game.health +'/'+_i.curHP ;
    // game.health = _i.curHP < 0 ? 0 : 1;
}
function onCountdownStarted(){
    game.scoreTxt.visible = false;
    game.iconP2.visible = false;
    game.iconP1.visible = false;
    game.timeTxt.visible = false;
    game.timeBar.visible = false;
    game.healthBar.bg.visible = false;
    game.healthBar.rightBar.visible = false;
    game.healthBar.leftBar.visible = false;
    if(cd){
        checkHP();
        createUThp();
    }
}
function checkHP(){
    _i.curHP = _i.maxHP = getHP();
    _i.width = _i.width*_i.maxHP;
}
function getHP(){
    return 50 ;
}
function createUThp(){

	leftBar.makeGraphic(_i.width, _i.height, FlxColor.WHITE);
	leftBar.color = FlxColor.YELLOW;
	leftBar.camera = camHUD;
    leftBar.screenCenter();
    leftBar.y += _i.posy;

	rightBar.makeGraphic(_i.width, _i.height, FlxColor.WHITE);
	rightBar.color = FlxColor.RED;
	rightBar.camera = camHUD;
    rightBar.screenCenter();
    rightBar.y += _i.posy;

    healthSpr.loadGraphic(Paths.image('hud/ui/spr_hpname_0'));
    healthSpr.antialiasing = false;
    healthSpr.scale.set(1.4*_i.multi,1.4*_i.multi);
    healthSpr.camera = camHUD;
    healthSpr.screenCenter();
    healthSpr.y = (rightBar.y + (rightBar.height - healthSpr.height) / 2);
    healthSpr.x = rightBar.x - 40;

    healthTracker.text = 'nil';
	healthTracker.camera = camHUD;
    healthTracker.screenCenter();
    healthTracker.borderStyle = FlxTextBorderStyle.OUTLINE;
	healthTracker.color = FlxColor.WHITE;
    healthTracker.borderSize = 1;
    healthTracker.borderQuality = 0.5;
    healthTracker.borderColor = FlxColor.BLACK;
    healthTracker.size = 25;
    healthTracker.antialiasing = false;
    healthTracker.y = (rightBar.y + (rightBar.height - healthTracker.height) / 2) +2;
    healthTracker.x = rightBar.x + rightBar.width + 20;
    
    add(healthTracker);
	add(rightBar);
	add(leftBar);
    add(healthSpr);
}

function barPos(){
    rightBar.screenCenter();
    rightBar.y += _i.posy;
    leftBar.screenCenter();
    leftBar.x = rightBar.x;
    leftBar.y += _i.posy;
}