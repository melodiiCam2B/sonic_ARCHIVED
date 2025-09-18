package utils.utilities;

import flixel.*;
import openfl.*;
import haxe.*;
import sys.*;
import lime.*;

class UtilAttachedFont extends UtilFont {

	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var sprTracker:FlxText;
	public var copyVisible:Bool = true;
	public var copyAlpha:Bool = false;

	public function new(text:String = "", ?offsetX:Float = 0, ?offsetY:Float = 0, ?bold = false, ?scale:Float = 1) {
		super(x, y, text, bold);
		
		this.isMenuItem = false;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null) {
			setPosition(sprTracker.x + offsetX, sprTracker.y + offsetY);
			if(copyVisible)
				visible = sprTracker.visible;

			if(copyAlpha)
				alpha = sprTracker.alpha;
		}

		super.update(elapsed);
	}
}