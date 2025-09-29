package archive.backend.utils;

class Mouse {
    /**
     * [TODO]
     * @param loading - during transitions initiate throbber
     * @param blocked - when holding right or/and left down denie any other interactions
     * @param cliking - when holding right or/and left down chnage sprite for visual indication
     */
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