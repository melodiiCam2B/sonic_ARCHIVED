package utils.sys;

import haxe.Timer;
import lime.app.Application;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.FlxG;
import utils.track.Info;

using flixel.util.FlxStringUtil;

class Display extends TextField{
    var times:Array<Float> = [];
	var memPeak:UInt = 0;
	var debug:Bool = true;
	// display info

	public function new(x:Float, y:Float, ?debug:Bool){
		super();

		this.x = x;
		this.y = x;
		this.debug = debug;

		autoSize = LEFT;
		selectable = false;

		defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 14, 0x8A0000);
		text = "";

		addEventListener(Event.ENTER_FRAME, update);
	}

	function update(_:Event)
	{
		var now:Float = Timer.stamp();
		times.push(now);
		while (times[0] < now - 1)
			times.shift();

		var mem = System.totalMemory;
		if (mem > memPeak)
			memPeak = mem;

		if (visible)
		{
			text = ''; 
			text += times.length + " FPS - ";
			text += 'MEMORY: ${FlxStringUtil.formatBytes(mem)} / ${FlxStringUtil.formatBytes(memPeak)}';
			text += '\nCompilation Info:\n${Info.getGit()}\n'+'';
			text += (debug ? '\n>State: ${Type.getClass(FlxG.state)}' +
							'\n> Object Count: ${FlxG.state.members.length}' +
	        				'\n> Camera Count: ${FlxG.cameras.list.length}' +
            				'\n> Sounds Count: ${FlxG.sound.list.length}'+
		    				'\n> FlxG.game Childs Count: ${FlxG.game.numChildren}' +
							'\n> Game Size: ${FlxG.width}, ${FlxG.height}': '');
		}
	}
}