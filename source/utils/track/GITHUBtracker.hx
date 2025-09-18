package utils.track;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.system.System;

import flixel.FlxG;
class GITHUBtracker extends Sprite{
	var na_e:TextField;
	var text:TextField;
	var info:TextField;
	var underlay:Bitmap;
	var border:Bitmap;
	var deltaTimeout:Float = 0.0;

    public function new(?x:Float = 10, ?y:Float = 80){
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

        na_e.y -=1;
		na_e.selectable = false;
		na_e.mouseEnabled = false;
		na_e.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 18, 0xE1E1E1);
		na_e.autoSize = LEFT;
		na_e.multiline = true;
		na_e.text = "Github Info";

		text.selectable = false;
		text.mouseEnabled = false;
		text.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 14, 0xAEAEAE);
		text.autoSize = LEFT;
		text.multiline = true;
		text.text = "\nCommit Number:\nCommit ID:\nCommit Branch:";

        info.x += text.width +1;
		info.selectable = false;
		info.mouseEnabled = false;
		info.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 14, 0xFFFFFFFF);
		info.autoSize = LEFT;
		info.multiline = true;
		info.text = '\n${Info.getNum()}\n${Info.getHash()}\n${Info.getBranch()}';


		underlay.width = info.width + text.width + 3;
		underlay.height = text.height;

		border.width = info.width + text.width + 7.5;
		border.height = text.height + 4.5;
		border.x = underlay.x + (underlay.width - border.width) / 2;
		border.y = underlay.y + (underlay.height - border.height) / 2;
    }
}