import openfl.Lib;
import flixel.FlxG;
import backend.Paths;
import states.PlayState;
import objects.Bar;
import flixel.tweens.FlxTween;
import lime.app.Application;
import flixel.text.FlxText;
import backend.Mods;

import utils.utilities.FunkinSaveUtils;

import utils.obj.ListDisplay;

var act:FlxSprite = new FlxSprite();
var itm:FlxSprite = new FlxSprite();
var hrt:FlxSprite = new FlxSprite();
var box:FlxSprite = new FlxSprite();
var brd:FlxSprite = new FlxSprite();
var listDis:ListDisplay = new FlxSprite(0,0,['Monster Candy','Monster Candy','Pie']);
//get item array fixed
/**
 * A = act
 * D = item
 * X = cancel
 * Z = confirm
 */

/**
 * ACT: * check
 * ITEM: b. pie, 2 mstr candy - save data
 */

/**
 * HP = 20, miss = 1
 */

var _i = {    
    multi: 1.4,
    pos_Y: 300,
    pos_X: 100,
    curBt: null,
    men_i: false,
    mOpen: false,
    debug: false
}

var check_directory = callOnHScript('checkDirectory');
function onCountdownStarted(){
    itemGet();
    game.scoreTxt.visible = false;
    game.iconP2.visible = false;
    game.iconP1.visible = false;
    game.timeTxt.visible = false;
    game.timeBar.visible = false;
    game.healthBar.bg.visible = false;
    game.healthBar.rightBar.visible = false;
    game.healthBar.leftBar.visible = false;
        createMenu();

}

function createMenu(){
    brd.makeGraphic(820, 170, FlxColor.WHITE);
    brd.camera = camHUD;
    brd.screenCenter();
    brd.y += 140;
    brd.alpha = _i.debug? 1:0;
    add(brd);

    box.makeGraphic(800, 150, FlxColor.BLACK);
    box.camera = camHUD;
    box.screenCenter();
    box.y += 140;
    box.alpha =_i.debug? 1:0;
    add(box);

    act.loadGraphic(Paths.image('ui/actbt_0'));
    act.antialiasing = false;
    act.scale.set(1*_i.multi,1*_i.multi);
    act.camera = camHUD;
    act.screenCenter();
    act.y += _i.pos_Y;
    act.x -= _i.pos_X;
    add(act);

    itm.loadGraphic(Paths.image('ui/itembt_0'));
    itm.antialiasing = false;
    itm.scale.set(1*_i.multi,1*_i.multi);
    itm.camera = camHUD;
    itm.screenCenter();
    itm.y += _i.pos_Y;
    itm.x += _i.pos_X;
    add(itm);

    hrt.loadGraphic(Paths.image('ui/spr_heart_0'));
    hrt.antialiasing = false;
    hrt.scale.set(1.4*_i.multi,1.4*_i.multi);
    hrt.camera = camHUD;
    hrt.screenCenter();
    hrt.y += _i.pos_Y;
    hrt.visible = false;
    add(hrt);

    listDis.camera = camHUD;
    listDis.x = (box.x + (box.width - listDis.width) / 2);
    listDis.y = (box.y + (box.height - listDis.height) / 2);
    add(listDis);
}

function onUpdate(){
    if(FlxG.keys.justPressed.A && _i.debug == false ||FlxG.keys.justPressed.D  && _i.debug == false){
        updateSpr(FlxG.keys.justPressed.A? 'act' : 'itm');}
    if(FlxG.keys.justPressed.DELETE && _i.debug == true){game.health =0;}//does debug stuff
    if(FlxG.keys.justPressed.Z && _i.debug == false){updateBoxes(_i.men_i);}//oppens menu if menu is closed
    if(FlxG.keys.justPressed.X && _i.debug == false && _i.mOpen == true){updateSpr('del');updateBoxes(false);}//closes menu if menu is open
    listDis.x = (box.x + (box.width - listDis.width) / 2);
    listDis.y = (box.y + (box.height - listDis.height) / 2);
}

function updateSpr(_bt:String){
    hrt.visible = _i.men_i = _i.mOpen = _bt=='del' ? false : true;
    _i.curBt = _bt;
    switch(_bt){
        case 'itm':
            itm.loadGraphic(Paths.image('ui/itembt_1'));
            act.loadGraphic(Paths.image('ui/actbt_0'));
            heartPos(itm);
        case 'act':
            itm.loadGraphic(Paths.image('ui/itembt_0'));
            act.loadGraphic(Paths.image('ui/actbt_1'));
            heartPos(act);
        case 'del':
            itm.loadGraphic(Paths.image('ui/itembt_0'));
            act.loadGraphic(Paths.image('ui/actbt_0'));
    }
}

function heartPos(spr:FlxSprite){
    hrt.x = (spr.x + (spr.width - hrt.width) / 2) -  53;
}

function updateBoxes(_:Bool){
    FlxTween.tween(box, {alpha: _ ? 1 : 0 },0.7, {ease: FlxEase.quadInOut});
    FlxTween.tween(brd, {alpha: _ ? 1 : 0 },0.7, {ease: FlxEase.quadInOut});
    if(_i.mOpen){
        switch(_i.curBt){
            case 'itm':

            case 'act':

            case 'del':

        }
    }
}

function onDestroy(){
    itemSave();
}

function itemSave(){
    FunkinSaveUtils.saveUtil('save_1', itmCon);
}
function itemGet(){
    itmCon = FunkinSaveUtils.saveUtil('save_1');
}