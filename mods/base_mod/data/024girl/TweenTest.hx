import openfl.Lib;
import flixel.FlxG.*;
import lime.ui.Window;
import lime.app.Application;


var win = Lib.application.window;
var stage = Lib.current.stage;
var display = stage.window.display;
var ogWinY = 0;
var ogHUDy = 0;

var ogWinX = 0;
var ogHUDx = 0;

var tweenAmount = 70;
var tweenSpeed = 0.5;
var mustHit = null;
var canTween = true;
var tweenWinY = null;
var tweenHudY = null;
// function onCreatePost(){

// }
function startWinTween(){
    win.y += tweenAmount+20;
    camHUD.y-=tweenAmount/2;
    tweenWinY = FlxTween.tween(win, {y: ogWinY + tweenAmount}, tweenSpeed*2, {type:4});
    tweenHudY = FlxTween.tween(camHUD, {y: ogHUDy + (tweenAmount/2)}, tweenSpeed*2, {type:4});
}
function stopWinTween(){
    tweenWinY.cancel();
    tweenHudY.cancel();
}

function onBeatHit(){
	if (curBeat == 1){
        ogWinY = win.y; 
        ogWinX = win.x;
        ogHUDx = camHUD.x;
        ogHUDy = camHUD.y;
        startWinTween();
    }
    mustHit = callOnLuas('getMustHit');

    if(canTween){
        FlxTween.tween(win, {x:(mustHit? ogWinX+tweenAmount*2:ogWinX-tweenAmount*2)}, tweenSpeed/2);
        FlxTween.tween(camHUD, {x: ogHUDx + (mustHit? -(tweenAmount*2):(tweenAmount*2))}, tweenSpeed/2);
    }

}
function onEvent(_i, _1, _2){
    if(_i == 'tweenStuff_hud'){
        if(_1 == null){
            canTween = false;
            tweenWinY.cancel();
            tweenHudY.cancel();
            quickCenter();
        }else{
            canTween = true;
            // onCreate();
        }
    }
}
function onDestroy(){
    centerWindowOnPoint();
}
function quickCenter() {
    resolutionX = Math.ceil(display.currentMode.width * stage.window.scale);
    resolutionY = Math.ceil(display.currentMode.height * stage.window.scale);

    xCos = (resolutionX - Lib.application.window.width)/2;
    yCos = (resolutionY - Lib.application.window.height)/2;

	Lib.application.window.x = xCos;
    Lib.application.window.y = yCos;
}

function centerWindowOnPoint() {
    resolutionX = Math.ceil(display.currentMode.width * stage.window.scale);
    resolutionY = Math.ceil(display.currentMode.height * stage.window.scale);

    xCos = (resolutionX - Lib.application.window.width)/2;
    yCos = (resolutionY - Lib.application.window.height)/2;

	tweenWin(xCos, yCos);
}

function tweenWin(_x:Int, _y:Int){
    ogWinY = win.y; 
    ogWinX = win.x;
    ogHUDx = camHUD.x;
    ogHUDy = camHUD.y;
	FlxTween.tween(win, {x: _x}, 0.3, {ease: FlxEase.quadInOut});
	FlxTween.tween(win, {y: _y},  0.3, {ease: FlxEase.quadInOut});
}