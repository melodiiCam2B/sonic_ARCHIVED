package states.snc;

import flixel.group.FlxSpriteContainer;

class Plate extends FlxSpriteContainer {
    var body = new FlxSprite();
    var tile = new FlxSprite();
    var name = new FlxText();
    var desc = new FlxText();
    var port = new FlxSprite();

    var title:String;
    var credits:String;

    public function new(title:String, credits:String) {
        
    }

    function setBody(spr:FlxSprite) spr.setGraphicSize(FlxG.width/4, FlxG.height/3);
    function returnSong() return title;
}

