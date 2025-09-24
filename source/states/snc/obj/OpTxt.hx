package states.snc.obj;

import flixel.*;
import openfl.*;
import haxe.*;
import sys.*;
import lime.*;

class OpTxt extends FlxText {
	public var isMenuItem:Bool = false;
	public var targetY:Int = 0;
	public var changeX:Bool = true;
	public var changeY:Bool = true;

	public var distancePerItem:FlxPoint = new FlxPoint(20, 60);
	public var startPosition:FlxPoint = new FlxPoint(0, 120); //for the calculations

	public var scaleX:Float = 1;
	public var scaleY:Float = 1;
	public var rows:Int = 0;

	public function new(x:Float = 0, y:Float = 0, text:String, ?bold:Bool = false) {
		super(x, y);
		
		this.text = bold? text.toUpperCase() : text.toLowerCase();
		borderSize = 5;
		setFormat(Paths.font("vcr.ttf"), 46, (bold? FlxColor.WHITE : FlxColor.WHITE), LEFT, FlxTextBorderStyle.OUTLINE,(bold? FlxColor.BLACK : FlxColor.TRANSPARENT));
	}

	override function update(elapsed:Float){
		if (isMenuItem){
			var lerpVal:Float = Math.exp(-elapsed * 9.6);
			// if(changeX)
			// 	x = FlxMath.lerp((targetY * distancePerItem.x) + startPosition.x, x, lerpVal);
			if(changeY)
				y = FlxMath.lerp((targetY * 1.3 * distancePerItem.y) + startPosition.y, y, lerpVal);
		}
		super.update(elapsed);
	}

	public function snapToPosition(){
		if (isMenuItem){
			// if(changeX)
			// 	x = (targetY * distancePerItem.x) + startPosition.x;
			if(changeY)
				y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
		}
	}
}