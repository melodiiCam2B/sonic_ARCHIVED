package states.snc.opt.subs;

class Controls extends MusicBeatSubstate{
	var options:Array<Dynamic> = [
		['NOTES'],
		['Left', 'note_left', 'Note Left'],
		['Down', 'note_down', 'Note Down'],
		['Up', 'note_up', 'Note Up'],
		['Right', 'note_right', 'Note Right'],
        ['OTHER'],
		['Reset', 'reset', 'Reset'],
		['Accept', 'accept', 'Accept'],
		['Back', 'back', 'Back'],
		['Pause', 'pause', 'Pause'],
	];
	var curSelected:Int = 0;
	var curAlt:Bool = false;
    var settingKeybind = false;
    var keybindGroup:FlxSpriteGroup = new FlxSpriteGroup();
	var selected = new FlxSprite();
    var optCAM:FlxCamera;
	public function new(){
		optCAM = new FlxCamera();
		optCAM.bgColor.alpha = 0;

        camFollow = new FlxObject(0, 0, 1, 1);
	    add(camFollow);

        FlxG.cameras.add(optCAM, false);
        optCAM.follow(camFollow, null, 0.10);

        for (i => option in options){
            var txtGroup:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
            var isReal:Bool = !unselectableCheck(i);
            var textSPR = new FlxText();

            if(isReal){

            }else{

            }
            options.y = 50 + i * 100;
            options.camera = optCAM;
            keybindGroup.add(options);

        }
    }
	function changeCredit(?i:Int = 0){
        curCredit = FlxMath.wrap(curCredit + i, 0, creditsStuff.length - 1);
        if(unselectableCheck(curCredit)){ 
            curCredit += i;
            curCredit = FlxMath.wrap(curCredit, 0, creditsStuff.length - 1);
        }

        var curMember:FlxTypedGroup = keybindGroup.members[curCredit];
		curCredSelect.makeGraphic(Std.int(curMember.width + 20),Std.int(curMember.height) , FlxColor.BLACK);
		curCredSelect.x = curMember.x + (curMember.width - curCredSelect.width) / 2;
        curCredSelect.y = curMember.y + (curMember.height - curCredSelect.height) / 2;

        camFollow.setPosition(450, curMember.y);
    }
	private function unselectableCheck(num:Int):Bool {
		return options[num].length <= 1;
	}
	override function update(elapsed:Float){
		super.update(elapsed);
        if(settingKeybind){

        }else{

        }
    }
}