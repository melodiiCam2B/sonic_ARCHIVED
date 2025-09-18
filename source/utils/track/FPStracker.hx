package utils.track;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.system.System;

import flixel.FlxG;
class FPStracker extends Sprite{
	var na_e:TextField;
	var text:TextField;
	var info:TextField;
	var underlay:Bitmap;
	var border:Bitmap;
	var deltaTimeout:Float = 0.0;

	public var currentFPS(default, null):Int;
	@:noCompletion private var times:Array<Float>;
	public var memPeak:UInt = 0;

    public function new(?x:Float = 10, ?y:Float = 10){
    	super();
		
		this.x = x;
		this.y = y;
        
        border = new Bitmap();
		border.bitmapData = new BitmapData(1, 1, true, 0xFF4A4A4A);
		addChild(border);

        underlay = new Bitmap();
		underlay.bitmapData = new BitmapData(1, 1, true, 0xFF696969);
		addChild(underlay);

    	na_e = new TextField();
		addChild(na_e);

    	text = new TextField();
		addChild(text);

    	info = new TextField();
		addChild(info);

        currentFPS = 0;
        na_e.y -=1;
		na_e.selectable = false;
		na_e.mouseEnabled = false;
		na_e.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 18, 0xE1E1E1);
		na_e.autoSize = LEFT;
		na_e.multiline = true;
		na_e.text = "Performance";

		text.selectable = false;
		text.mouseEnabled = false;
		text.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 14, 0xAEAEAE);
		text.autoSize = LEFT;
		text.multiline = true;
		text.text = "\nFPS:\nMemory:";

        info.x += text.width +1;
		info.selectable = false;
		info.mouseEnabled = false;
		info.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 14, 0xAEAEAE);
		info.autoSize = LEFT;
		info.multiline = true;
		info.text = "nil\nnil";
		
		times = [];
		
		FlxG.signals.postStateSwitch.add(() -> updateText = __updateTxt);
    }

	
	private override function __enterFrame(deltaTime:Float):Void{
		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000)
			times.shift();
			
		// prevents the overlay from updating every frame, why would you need to anyways @crowplexus
		if (deltaTimeout < 100){
			deltaTimeout += deltaTime;
			return;
		}
		
		if (System.totalMemory > memPeak)
			memPeak = System.totalMemory;

		currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate;
		updateText();
		underlay.width = info.width + text.width + 3;
		underlay.height = text.height;

		border.width = info.width + text.width + 7.5;
		border.height = text.height + 4.5;
		border.x = underlay.x + (underlay.width - border.width) / 2;
		border.y = underlay.y + (underlay.height - border.height) / 2;
		
		deltaTimeout = 0.0;
	}
	
	dynamic function updateText():Void{
	    __updateTxt();
	}
	
	function __updateTxt(){
		info.text = '\n$currentFPS \n${flixel.util.FlxStringUtil.formatBytes(System.totalMemory)}/${flixel.util.FlxStringUtil.formatBytes(memPeak)}';
		info.textColor = currentFPS < FlxG.drawFramerate * 0.5 ? 0xFFFF0000 : 0xFFFFFFFF ;
	}
}