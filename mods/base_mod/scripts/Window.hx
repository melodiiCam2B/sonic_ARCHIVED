import openfl.Lib;
import flixel.FlxG.*;
import lime.ui.Window;
import lime.app.Application;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.BaseScaleMode;
import Main;

var maxWidth:Int;
var maxHeight:Int;
var win = Lib.application.window;
var stage = Lib.current.stage;
var display = stage.window.display;
var scaleMode:BaseScaleMode = new BaseScaleMode();

var winScaleM = 1.2;

var winPos = {
    x: 0,
    y: 0
}

function onCreate(){
    winPos.x = Lib.application.window.x;
    winPos.y = Lib.application.window.y;
    // resizeWindow(1030,600,0.3);
    // windowShake(2);
    // fullScreenForced();
}
function onDestroy(){
    resetWindowSize();
}
function fullScreenForced(){
    maxWidth = Lib.application.window.stage.fullScreenWidth;
    maxHeight = Lib.application.window.stage.fullScreenHeight;

    Lib.application.window.width = maxWidth;
    Lib.application.window.height = maxHeight;
    FlxG.resizeGame(maxWidth, maxHeight);
    centerTweenless();
}

function winResizeNT(){
    resizeWindow(1280*1.4,720 *1.4,0.3);
}

function resizeWindow(width:Int, height:Int, time:Float = 0.3,?ease:String){
    FlxTween.tween(Lib.application.window, {width:width, height:height},time, {ease: swapEase(ease),onUpdate: (_) -> {
        FlxG.resizeGame(Lib.application.window.width*winScaleM, Lib.application.window.height*winScaleM);
        centerTweenless();
    },onComplete: function (twn:FlxTween) {
	    centerWindowOnPoint(time);
	}});
}

function winResizeNT(width:Int, height:Int){
    FlxG.resizeWindow(width*winScaleM, height*winScaleM);
    FlxG.resizeGame(width*winScaleM, height*winScaleM);
    centerTweenless();
}

function centerTweenless(){
    var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
    var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);

    Lib.application.window.x = (resolutionX - Lib.application.window.width) / 2;
    Lib.application.window.y = (resolutionY - Lib.application.window.height) / 2;
}

function centerWindowOnPoint( time:Float = 0.3) {
    resolutionX = Math.ceil(display.currentMode.width * stage.window.scale);
    resolutionY = Math.ceil(display.currentMode.height * stage.window.scale);

    xCos = (resolutionX - Lib.application.window.width)/2;
    yCos = (resolutionY - Lib.application.window.height)/2;

	tweenWin(xCos, yCos, time);
}

function tweenWin(_x:Int, _y:Int, time:Float = 0.3,?ease:String){
	FlxTween.tween(win, {x: _x}, time, {ease: swapEase(ease)});
	FlxTween.tween(win, {y: _y}, time, {ease: swapEase(ease)});
}

function tweenXWin(_x:Int, time:Float = 0.3,?ease:String){
    FlxTween.tween(Lib.application.window, {x: _x}, time, {ease: swapEase(ease)});
}

function tweenYWin(_y:Int, time:Float = 0.3,ease:String){
    FlxTween.tween(Lib.application.window, {y: _y}, time, {ease: swapEase(ease)});
}

function getMidPoint(_:Bool){
    resolutionX = Math.ceil(display.currentMode.width * stage.window.scale);
    resolutionY = Math.ceil(display.currentMode.height * stage.window.scale);

    xCos = (resolutionX - Lib.application.window.width)/2;
    yCos = (resolutionY - Lib.application.window.height)/2;
    return _ ? xCos : yCos;
}

var tweenShake:FlxText = new FlxText();
function windowShake(amount:Int){
    FlxTween.tween(tweenShake, {alpha: 0}, amount, {onComplete:function (twn:FlxTween){
        centerTweenless();
    }, onUpdate: (_)->{
        Lib.application.window.y = winPos.y + (-20 + Math.floor(((20 - -20 + 1) * Math.random())));
        Lib.application.window.x = winPos.x + (-20 + Math.floor(((20 - -20 + 1) * Math.random())));
    }});
}

function swapEase(ease:String){
    switch(ease){
        default: return FlxEase.linear;
        case 'linear': return FlxEase.linear;
        case 'quadIn': return FlxEase.quadIn;
        case 'quadOut': return FlxEase.quadOut;
        case 'quadInOut': return FlxEase.quadInOut;
        case 'cubeIn': return FlxEase.cubeIn;
        case 'cubeOut': return FlxEase.cubeOut;
        case 'cubeInOut': return FlxEase.cubeInOut;
        case 'quartIn': return FlxEase.quartIn;
        case 'quartOut': return FlxEase.quartOut;
        case 'quartInOut': return FlxEase.quartInOut;
        case 'quintIn': return FlxEase.quintIn;
        case 'quintOut': return FlxEase.quintOut;
        case 'quintInOut': return FlxEase.quintInOut;
        case 'smoothStepIn': return FlxEase.smoothStepIn;
        case 'smoothStepOut': return FlxEase.smoothStepOut;
        case 'smoothStepInOut': return FlxEase.smoothStepInOut;
        case 'smootherStepIn': return FlxEase.smootherStepIn;
        case 'smootherStepOut': return FlxEase.smootherStepOut;
        case 'smootherStepInOut': return FlxEase.smootherStepInOut;
        case 'sineIn': return FlxEase.sineIn;
        case 'sineOut': return FlxEase.sineOut;
        case 'sineInOut': return FlxEase.sineInOut;
        case 'bounceIn': return FlxEase.bounceIn;
        case 'bounceOut': return FlxEase.bounceOut;
        case 'bounceInOut': return FlxEase.bounceInOut;
        case 'circIn': return FlxEase.circIn;
        case 'circOut': return FlxEase.circOut;
        case 'circInOut': return FlxEase.circInOut;
        case 'expoIn': return FlxEase.expoIn;
        case 'expoOut': return FlxEase.expoOut;
        case 'expoInOut': return FlxEase.expoInOut;
        case 'backIn': return FlxEase.backIn;
        case 'backOut': return FlxEase.backOut;
        case 'backInOut': return FlxEase.backInOut;
        case 'elasticIn': return FlxEase.elasticIn;
        case 'elasticOut': return FlxEase.elasticOut;
        case 'elasticInOut': return FlxEase.elasticInOut;
    }
}
