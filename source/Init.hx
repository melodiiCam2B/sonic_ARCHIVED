package;

#if LUA_ALLOWED
import psychlua.*;
#else
import psychlua.LuaUtils;
import psychlua.HScript;
#end

#if HSCRIPT_ALLOWED
import psychlua.HScript.HScriptInfos;
import crowplexus.iris.Iris;
import crowplexus.hscript.Expr.Error as IrisError;
import crowplexus.hscript.Printer;
#end


import utils.*;
import utils.shaders.*;

import backend.WeekData;

import flixel.input.keyboard.FlxKey;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import shaders.ColorSwap;
import states.StoryMenuState;
import psychlua.*;
import psychlua.hscript_new.*;
import states.editors.MasterEditorMenu;

class Init extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	override public function create():Void{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		if (FlxG.sound.music == null)FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

		ClientPrefs.loadPrefs();
		Language.reloadPhrases();

		if(FlxG.save.data != null && FlxG.save.data.fullscreen)FlxG.fullscreen = FlxG.save.data.fullscreen;
		
		persistentUpdate = true;
		persistentDraw = true;
		
		if (FlxG.save.data.weekCompleted != null)StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 1);

		for (folder in Mods.directoriesWithFile(Paths.getSharedPath(), 'scripts/Global.hx')){
			for (file in FileSystem.readDirectory(folder)){
				initGlobal(folder + file);
			}
		}

		//below system would be changed

		if(FlxG.save.data.seenWarning == null)
			openSubState(new substates.WarningSubState());
		else
			FlxG.switchState(new states.snc.Menu());
		
	}

	public function initGlobal(file:String){
		var newScript:HScript = null;
		try{
			newScript = new HScript(null, file);
			if (newScript.exists('init')) newScript.call('init');
			trace('initialized global interp successfully: $file');
		}
		catch(e:IrisError){
			var pos:HScriptInfos = cast {fileName: file, showLine: false};
			Iris.error(Printer.errorToString(e, false), pos);
			var newScript:HScript = cast (Iris.instances.get(file), HScript);
			if(newScript != null)
				newScript.destroy();
		}
	}

	override function update(elapsed:Float){
		if (FlxG.sound.music != null)Conductor.songPosition = FlxG.sound.music.time;

		if (FlxG.keys.justPressed.ENTER) FlxG.switchState(new states.snc.Menu());

		super.update(elapsed);
	}
	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
}
