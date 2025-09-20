package states.snc.obj;

class Mouse {
    var mouse = FlxSprite();
    var proxy = FlxG.mouse;
    var hoverGroup:FlxSpriteGroup;
    public function new(path:String) {
        mouse.loadGraphic(Paths.image(path, 'archive'));
		FlxG.mouse.load(mouse.pixels, 2);
		FlxG.mouse.useSystemCursor = true;
    }

    function update(){
        if(proxy.wheel != 0){
            
        }
    }
}