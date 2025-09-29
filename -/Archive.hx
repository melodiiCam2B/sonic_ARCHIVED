package states.snc;
import states.snc.obj.*;
import states.snc.shaders.*;
import utils.utilities.*;
/**
 * test state for modding :DDD 
**/
class Archive extends MusicBeatState{
    var bg = new FlxSprite();
    var pussy:PopUp;
   	override public function create(){
		// bg.loadGraphic(Paths.image('MENU', 'archive'));
		// bg.setGraphicSize(FlxG.width, FlxG.height);
		// add(bg);
		// bg.screenCenter();
        FlxG.camera.bgColor = 0xFF131313;
        FlxG.camera.bgColor.alpha = 0;
        SncTrans.pleasebroplease();

        pussy = new PopUp('I\'m waking up','to ash and dust\nI wipe my ass\nand slap my nuts',kills,infi);
        pussy.screenCenter();
        add(pussy);

    }
    function kills():Void{
        pussy.kill();
    }
    function infi():Void{
        pussy.x -= 150;
        pussy.y -= 50;
        FlxTween.tween(pussy, {x: pussy.x + 300}, 1.4, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.35});
        FlxTween.tween(pussy, {y: pussy.y + 100}, 0.7, {ease: FlxEase.quadInOut, type: PINGPONG});
    }
	override function update(elapsed:Float){
		super.update(elapsed);
        if(FlxG.keys.justPressed.F5) pussy.revive();
    }
}