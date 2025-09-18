package utils.obj;

import flixel.*;
import openfl.*;
import haxe.*;
import sys.*;
import lime.*;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;
import utils.Path;
import flixel.text.FlxText;
import utils.utilities.UtilFont;

class ListDisplay extends FlxTypedGroup<FlxText>{
	var curSelected:Int = 0;
	public var allowMouse:Bool = true;
    public var list:Array<String> = ['crash','prevention','penis'];
    public var y:Int;
    public var x:Int;
    public var font:String;

    public function new(x:Int = 50,y:Int = 92,list:Array<String>, ?font:String='DTM-Mono.otf') {
        super();
        this.list=list;
        this.x=x;
        this.y=y;
        this.font=font;

        for (num => option in list){
            var txt = new UtilFont(0, 0, option, false);
            txt.scrollFactor.set(0,0);
			txt.screenCenter();
            txt.font = Paths.font(font);
			txt.x = x;
			txt.y += (92 * (num - (list.length / 2))) + 45;
            txt.ID = num;
            add(txt);
        }
    }

    override public function update(elapsed:Float){
        if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN){
            changeItem(FlxG.keys.justPressed.UP? -1 : 1);
        }
        for (i in 0...list.length){
			var distItem:Int = -1;
			var memb:FlxText = members[i];
   		    if(FlxG.mouse.overlaps(memb)){
				distItem = i;
				curSelected = distItem;
                changeItem();
			}
		};
	}

    function changeItem(change:Int = 0){
		curSelected = FlxMath.wrap(curSelected + change, 0, list.length - 1);
		forEach(function(spr:FlxText){
            spr.x = x;
            spr.color = FlxColor.WHITE;
			if (spr.ID == curSelected){
                spr.x = x + 20;
                spr.color = FlxColor.YELLOW;
            }
		});
    }
}