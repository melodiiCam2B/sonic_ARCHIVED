package states.snc;
import states.snc.obj.*;
class Test extends MusicBeatState{
   	override public function create(){
        finishTransition();
        var bg = new FlxSprite().loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		add(bg);
		bg.screenCenter();

        var descJob = new FlxText();
        descJob.setFormat(Paths.font('Sonic Advanced 2.ttf'), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descJob.text = 'this is here for testing\nif you see this state... um\n\noopsies?';
        descJob.screenCenter();
        add(descJob);

    }
    override public function update(elapsed:Float){
        if (controls.BACK) MusicBeatState.switchState(new states.snc.Menu());
    }
}