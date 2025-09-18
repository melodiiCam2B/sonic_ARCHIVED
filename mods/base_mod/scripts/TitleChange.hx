import openfl.Lib;
import flixel.FlxG;
import lime.app.Application;
import states.MainMenuState;
import backend.Mods;
import states.PlayState;
import lime.graphics.Image;
import backend.Difficulty;

var ogTitle = Application.current.window.title;
var path:String = 'mods/'+ Mods.currentModDirectory + '/images/hud/gameIcon/';
var titleDiff:String = Difficulty.getString().toLowerCase();
var tl:String = ogTitle+' | Now Playing: [ '+songName+'-'+titleDiff+' | ';
var lt:String = '';
var rt:String = '';
var debug:String = '';
var end:String =' ]';
function onCountdownStarted(){
    Application.current.window.setIcon(
        Image.fromFile(path + getModSetting('iconskinstuff')+'.png')
    );
}

function onDestroy(){
    Application.current.window.title = ogTitle;
}

function onUpdate(){
    rt = changeRating(game.ratingName);
    // lt= ' ] Score:'+game.songScore+'! Rating: '+rt+'! ['+game.ratingFC+'] Misses: '+game.songMisses+'...';
    // debug = 'Must Hit Section? ' + callOnLuas('getMustHit');
    Application.current.window.title = (tl+game.timeTxt.text+lt+debug+end);
}

function onEvent(name, value1, value2){
    if (name == 'TitleChange'){
        Application.current.window.title = (
           value1
        );
        
        Application.current.window.setIcon(
            Image.fromFile(path + value2+'.png')
        );
    }
}
function changeRating(i_:String){
    switch(i_){
        case 'You Suck!':   return 'errr you suck err';
        case 'Shit':        return 'bloodpasta...';
        case 'Bad':         return 'you\'re genocides';
        case 'Bruh':        return 'you feel your backs cralling on your sin';
        case 'Meh':         return 'sans undertale is dead';
        case 'Nice':        return '69';
        case 'Good':        return 'MID AF';
        case 'Great':       return 'not tilted';
        case 'Sick!':       return 'locked in';
        case 'Perfect!!':   return 'lowkey goated';
    }
}