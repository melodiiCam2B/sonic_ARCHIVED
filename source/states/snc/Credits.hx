package states.snc;
import utils.Path;
import flixel.addons.display.FlxBackdrop;
import states.snc.obj.*;
class Credits extends MusicBeatState{
	private static var curCredit:Int = 0;
	var creditsStuff:Array<Array<String>> = [
    //  ['name', 'what they did', 'extra stuff', 'social link']
        ['Sonic ARCHIVED team'],
        ['Melodii2b', 'Made the Too Fest remix and Coded the mod', 'chiptune = bitcrush', 'https://www.youtube.com/@melodiilesbien'],
        ['Kit', 'Made the Milk remix and charted the mod', 'insert insane midi guitar solo here', 'https://www.youtube.com/@kit-017'],

        ['Psych Engine Team'],
        ['Shadow Mario', 'Main Programmer and Head of Psych Engine', 'psychtard', 'https://ko-fi.com/shadowmario'],
        ['Riveren', 'Main Artist/Animator of Psych Engine', 'psych art', 'https://x.com/riverennn'],

        ['Former Engine Members'],
        ['bb-panzu', 'Ex-Programmer of Psych Engine', 'fnf sex mod', 'https://x.com/bbsub3'],

        ['Engine Contributors'],
        ['crowplexus', 'Linux Support, HScript Iris, Input System v3, and Other PRs', 'HScript :p', 'https://twitter.com/IamMorwen'],
        ['Kamizeta', 'Creator of Pessy, Psych Engine\'s mascot', 'Pessy creator', 'https://www.instagram.com/cewweey/'],
        ['MaxNeton', 'Loading Screen Easter Egg Artist/Animator', 'Pessy Loading Animation', 'https://bsky.app/profile/maxneton.bsky.social'],
        ['Keoiki', 'Note Splash Animations and Latin Alphabet', 'A, B, C, D, E, F, G-', 'https://x.com/Keoiki_'],
        ['SqirraRNG', 'Chart Editor\'s Waveform', '', 'https://x.com/gedehari'],
        ['EliteMasterEric', 'Runtime Shaders support and Other PRs', 'that one dude that works on funkin now', 'https://x.com/EliteMasterEric'],
        ['MAJigsaw77', '.MP4 Video Loader Library (hxvlc)', 'Videos', 'https://x.com/MAJigsaw77'],
        ['iFlicky', 'Composer of Psync and Tea Time and some sound effects', 'Pause music', 'https://x.com/flicky_i'],
        ['KadeDev', 'Fixed some issues on Chart Editor and Other PRs', 'outdated engine motherfucker','https://x.com/kade0912'],
        ['superpowers04', 'LUA JIT Fork', 'Lua','https://x.com/superpowers04'],
        ['CheemsAndFriends', 'Creator of FlxAnimate', 'FlxAnimate','https://x.com/CheemsnFriendos'],

        ["Funkin' Crew"],
        ['ninjamuffin99', "Programmer of Friday Night Funkin'", 'newgrounds resident','https://x.com/ninja_muffin99'],
        ['PhantomArcade', "Animator of Friday Night Funkin'", 'newgrounds resident','https://x.com/PhantomArcade3K'],
        ['evilsk8r', "Artist of Friday Night Funkin'", 'newgrounds resident','https://x.com/evilsk8r'],
        ['kawaisprite', "Composer of Friday Night Funkin'", 'newgrounds resident','https://x.com/kawaisprite'],
    ];
    private var camGame:FlxCamera;
    private var camText:FlxCamera;
    private var camDesc:FlxCamera;
	var camFollow:FlxObject;
	var credTxtGroup:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
	var curCredSelect = new FlxSprite();
    var bg = new FlxSprite();

    var descBox = new FlxSprite();
    var descTxt = new FlxText();
    var descJob = new FlxText();
    var emptyDesc:String = ':< wompity womp womp >:\n(this means there\'s nothing there)';
    override public function create(){
		camGame = new FlxCamera();

		camText = new FlxCamera();
		camText.bgColor.alpha = 0;

		camDesc = new FlxCamera();
		camDesc.bgColor.alpha = 0;

        camFollow = new FlxObject(0, 0, 1, 1);
	    add(camFollow);

		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);
		FlxG.cameras.add(camText, false);
        FlxG.cameras.add(camDesc, false);
        camText.follow(camFollow, null, 0.10);

		bg.loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		add(bg);
		bg.screenCenter(); 

		for(i in 0...creditsStuff.length){
            var isReal:Bool = !unselectableCheck(i);
            var options = new FlxText();
        	options.text = creditsStuff[i][0];
            if(isReal){
                options.setFormat(Paths.font('Sonic Advanced 2.ttf'), 40, FlxColor.WHITE);
        	    options.x = 40;
            }else{
                options.setFormat(Paths.font('Sonic Advanced 2.ttf'), 60, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        	    options.screenCenter(X);
            }
            options.y = 50 + i * 100;
            options.camera = camText;
            credTxtGroup.add(options);
		}
        curCredSelect.camera = camText;
		add(curCredSelect);
		add(credTxtGroup);
        
		descBox.makeGraphic(Std.int(FlxG.width- 30),Std.int(FlxG.height/4) , FlxColor.BLACK);
		descBox.screenCenter();
        descBox.y += 210;
        descBox.alpha = 0.6;
        descBox.camera = camDesc;
        add(descBox);

        descJob.setFormat(Paths.font('Sonic Advanced 2.ttf'), 40, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descJob.y = descBox.y + 1;
        descJob.x = descBox.x + 6;
        descJob.camera = camDesc;
        add(descJob);

        descTxt.setFormat(Paths.font('Sonic Advanced 2.ttf'), 20, FlxColor.WHITE);
        descTxt.y = descBox.y + descJob.height + 4;
        descTxt.x = descBox.x + 4;
        descTxt.camera = camDesc;
        add(descTxt);
        
        changeCredit(1);
	}
    override public function update(elapsed:Float){
        if(credits){
            if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN) changeCredit(FlxG.keys.justPressed.UP? -1 : 1);
            if (controls.BACK) MusicBeatState.switchState(new states.snc.Menu());
		    if(controls.ACCEPT && creditsStuff[curCredit][3] != null) CoolUtil.browserLoad(creditsStuff[curCredit][3]);
        }
    }
	function changeCredit(?i:Int = 0){
        curCredit = FlxMath.wrap(curCredit + i, 0, creditsStuff.length - 1);
        if(unselectableCheck(curCredit)){ 
            curCredit += i;
            curCredit = FlxMath.wrap(curCredit, 0, creditsStuff.length - 1);
        }

        setDescJob(creditsStuff[curCredit][1], descJob);
        setDescTxt(creditsStuff[curCredit][2], descTxt);
        var curMember:FlxText = credTxtGroup.members[curCredit];
		curCredSelect.makeGraphic(Std.int(curMember.width + 20),Std.int(curMember.height) , FlxColor.BLACK);
		curCredSelect.x = curMember.x + (curMember.width - curCredSelect.width) / 2;
        curCredSelect.y = curMember.y + (curMember.height - curCredSelect.height) / 2;

        camFollow.setPosition(400, curMember.y);
    }
	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
    public function setDescJob(txt:String, txtSpr:FlxText) {
        txtSpr.text = '';
        var toInt:Int = txt.length;
        var storeTxt:String = '';
        var i:Int = 0;
        new FlxTimer().start(0.01, function(tmr:FlxTimer) {
            storeTxt += txt.charAt(i);
            txtSpr.text = storeTxt;
            i+=1;
            if (i >= toInt) {
                tmr.cancel();
            }
        }, toInt);
    }
    public function setDescTxt(txt:String, txtSpr:FlxText) {
        if(txt == '')txt = emptyDesc;
        txtSpr.text = '';
        var toInt:Int = txt.length;
        var storeTxt:String = '';
        var i:Int = 0;
        new FlxTimer().start(0.01, function(tmr:FlxTimer) {
            storeTxt += txt.charAt(i);
            txtSpr.text = storeTxt;
            i+=1;
            if (i >= toInt) {
                tmr.cancel();
            }
        }, toInt);
    }
}