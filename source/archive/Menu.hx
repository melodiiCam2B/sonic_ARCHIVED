package archive;

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
import utils.utilities.WinUtils;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import flixel.addons.display.FlxBackdrop;
import backend.WeekData;
import backend.Highscore;
import backend.Song;
import states.PlayState;
import archive.backend.*;
import archive.backend.utils.*;
import archive.obj.*;
import archive.shaders.*;
import archive.shaders.SncTypedef.SongList;
import archive.shaders.SncTypedef.CreditDef;
import archive.shaders.SncTypedef.Version;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
class Menu extends MusicBeatState{
	public static var menuMusic:String = 'kamiOni';
	var creditsStuff:Array<Array<String>> = [];
    var emptyDesc:String = ':< wompity womp womp >:\n(this means there\'s nothing there)';
    var songs:Array<Array<String>> = [];
	var select:Array<String> = [#if debug 'test', #end'Stage Select', 'Settings', 'Credits', 'Exit'];
	var options:Array<String> = ['Controls', 'Graphics', 'Visuals', 'Gameplay'];
    var curDifficulty:Int = -1;
    var curSelected:Int = 0;
   	var curOption:Int = 0;
	var storeGroupY:Float = -1;
	var cardGroup:FlxTypedSpriteGroup<Plate>;
	var txtGroup:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
	var selected = new FlxSprite();
	private static var curCredit:Int = 0;
    private var camGame:FlxCamera;
    private var camNorm:FlxCamera;
    private var camText:FlxCamera;
    private var camDesc:FlxCamera;
    private var camErro:FlxCamera;
	private var cardCam:FlxCamera;
	var grid:FlxBackdrop;
	var camFollow:FlxObject;
	var credTxtGroup:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
	var curCredSelect = new FlxSprite();
    var bg = new FlxSprite();
    var descBox = new FlxSprite();
    var descTxt = new FlxText();
    var descJob = new FlxText();
	var mousey:Float = 0;
	var ogTexty:Float = 0;
	var wheely:Float = 0;
	var isdrag:Bool = false;
	var freePlay:Bool = false;
	var settings:Bool = false;
	var credits:Bool = false;
	var __songs:SongList;
	var __credits:CreditDef;
	var missingTextBG:FlxSprite;
	var missingText:FlxText;
	var filters:Array<BitmapFilter> = [];
	var __fisheye = new FishEye();
	public static function startMusic(){ 
		// FlxG.sound.playMusic(Paths.music(menuMusic));
	}
	function init(){
		__credits = Json.parse(getText('assets/archive/data/credits.json'));
		for(i in __credits.credits)
			creditsStuff.push(i);

		__songs = Json.parse(getText('assets/archive/data/songList.json'));
		for(i in __songs.songs)
			songs.push(i);

		camGame = new FlxCamera();

		camNorm = new FlxCamera();
		camNorm.bgColor.alpha = 0;
		camNorm.filtersEnabled = false;

		camText = new FlxCamera();
		camText.bgColor.alpha = 0;
		camText.filtersEnabled = false;

		cardCam = new FlxCamera();
		cardCam.bgColor.alpha = 0;
		cardCam.filtersEnabled = true;

		camDesc = new FlxCamera();
		camDesc.bgColor.alpha = 0;
		camDesc.filtersEnabled = false;

		camErro = new FlxCamera();
		camErro.bgColor.alpha = 0;
		camErro.filtersEnabled = false;

        camFollow = new FlxObject(0, 0, 1, 1);
	    add(camFollow);

		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);
	    filters.push(new ShaderFilter(__fisheye));
        FlxG.camera.filters = filters;

		FlxG.cameras.add(camNorm, false);
		FlxG.cameras.add(camText, false);
		FlxG.cameras.add(cardCam, false);
        FlxG.cameras.add(camDesc, false);
		FlxG.cameras.add(camErro, false);
        camText.follow(camFollow, null, 0.10);

		PlayState.isStoryMode = false;

		trace(Log_.green('Finished Setup!'));
	}

	function outDated():Void{
		openSubState(new archive.backend.UpdateSub(CheckVer.webVERSION));
	}

   	override public function create(){
		finishTransition();
		grid = new FlxBackdrop(Paths.image('GRID', 'archive'));
		grid.velocity.set(40, 40);
		add(grid);

		init();

		CheckVer.check(outDated);
		
		bg.loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.alpha = 0.5;
		add(bg);
		bg.screenCenter();

		for(i in 0...select.length){
			var options = new FlxText();
        	options.text = select[i];
        	options.setFormat(Paths.font('Sonic Advanced 2.ttf'), 60, FlxColor.WHITE);
        	options.y = 50 + i * options.height;
        	options.x = 40;
			options.ID = i;
			options.camera = camNorm;
        	txtGroup.add(options);
		}

		selected.camera = camNorm;
		changeOption();
		add(selected);
		add(txtGroup);

		cardGroup = new FlxTypedSpriteGroup<Plate>();
		for(i in 0...songs.length){
			var newCard = new Plate(songs[i][0],songs[i][1],songs[i][2]);
			newCard.x += i * 380;
			cardGroup.add(newCard);
		}
		cardGroup.screenCenter();
		storeGroupY = cardGroup.y;
		cardGroup.y += 720;
		cardGroup.camera = camNorm;
		add(cardGroup);

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
        
        changeCredit();
		updateCredits(false);

		missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		missingTextBG.camera = camErro;
		add(missingTextBG);
		
		missingText = new FlxText(50, 0, FlxG.width, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		missingText.camera = camErro;
		add(missingText);
    }
    override public function update(elapsed:Float){
		if(freePlay){
			if (FlxG.mouse.justPressed){
				mousey = FlxG.mouse.screenX;
				ogTexty = cardGroup.x;
			}
			if(FlxG.mouse.pressed){
				wheely = ogTexty - (mousey - FlxG.mouse.x);
				var lerpVal:Float = boundTo(elapsed * 9, 0, 1);
				cardGroup.x = FlxMath.lerp(cardGroup.x, wheely, lerpVal);
				isdrag = true;
			}
			if(isdrag){
				if(cardGroup.x > (FlxG.width- 30)) cardGroup.x = FlxG.width - 40;
				else if(cardGroup.x < (-FlxG.width- 30)) cardGroup.x = -FlxG.width - 40;	
			}
			if(FlxG.mouse.justReleased)isdrag = false;
			if (controls.BACK) {
				FlxTween.tween(cardGroup, {y: storeGroupY + 720}, 0.5, {onComplete: function(twn:FlxTween){
				freePlay = false;
				isdrag = false;
        		}});
			}
        	for (i in 0...cardGroup.members.length){
				var memb:Plate = cardGroup.members[i];
   		    	if(FlxG.mouse.overlaps(memb)){
					if(FlxG.mouse.justPressed){
						var songLowercase:String = Paths.formatToSongPath(memb.title);
						var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
						trace(poop);
						Song.loadFromJson(poop, songLowercase);
						PlayState.storyDifficulty = curDifficulty;

						try{
							Song.loadFromJson(poop, songLowercase);
							PlayState.isStoryMode = false;
							PlayState.storyDifficulty = curDifficulty;
						}catch(e:haxe.Exception){
							trace('ERROR! ${e.message}');

							var errorStr:String = e.message;
							if(errorStr.contains('There is no TEXT asset with an ID of')) errorStr = 'Missing file: ' + errorStr.substring(errorStr.indexOf(songLowercase), errorStr.length-1); //Missing chart
							else errorStr += '\n\n' + e.stack;

							missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
							missingText.screenCenter(Y);
							missingText.visible = true;
							missingTextBG.visible = true;

							super.update(elapsed);
							
							return;
						}
						if(FlxG.mouse.justPressed){
							 FlxG.camera.filters = [];
							LoadingState.prepareToSong();
							LoadingState.loadAndSwitchState(new PlayState());
						}
						
					}
				}
			};
			txtGroup.forEach(function(spr:FlxText){spr.alpha = 0.5;});
		}else if(settings){
			if(FlxG.keys.justPressed.LEFT ||FlxG.keys.justPressed.RIGHT) changeSub(FlxG.keys.justPressed.LEFT? -1 : 1);
			if (controls.ACCEPT) openSelectedSubstate(options[curOption]);
			if (controls.BACK){
				var curMember:FlxText = txtGroup.members[curSelected];
				curMember.text = 'Settings';
				changeOption();
				settings = false;
			}
		}else if(credits){
			txtGroup.forEach(function(spr:FlxText){spr.alpha = 0.5;});
            if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN) changeCredit(FlxG.keys.justPressed.UP? -1 : 1);
            if (controls.BACK) updateCredits(false);
		    if(controls.ACCEPT && creditsStuff[curCredit][3] != null) CoolUtil.browserLoad(creditsStuff[curCredit][3]);	
		}else{
        	for (i in 0...select.length){
				var distItem:Int = -1;
				var memb:FlxSprite = txtGroup.members[i];
   		    	if(FlxG.mouse.overlaps(memb)){
					distItem = i;
					curSelected = distItem;
                	changeOption();
				}
			};
			txtGroup.forEach(function(spr:FlxText){spr.alpha = 1;});
        	if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN)changeOption(FlxG.keys.justPressed.UP? -1 : 1);
			if (controls.ACCEPT || FlxG.mouse.justPressed && FlxG.mouse.overlaps(txtGroup.members[curSelected])){
				switch(select[curSelected]){
					case 'Stage Select':
						FlxTween.tween(cardGroup, {y: storeGroupY}, 0.5, {onComplete: function(twn:FlxTween){
							freePlay = true;
        				}});
					case 'Settings': 
						changeSub();
						settings = true;
					case 'Credits': 
						updateCredits(true);
					case 'Exit': 
						Sys.exit(0);
					case 'test':
						MusicBeatState.switchState(new archive.Test());
				}
			}
		}
    }
	function updateCredits(_i:Bool){
		camText.visible = _i;
		camDesc.visible = _i;
		credits = _i;
	}
	function setBack(){
		new FlxTimer().start(0.04, function(tmr:FlxTimer) {
  			missingText.visible = false;
			missingTextBG.visible = false;
			missingText.text = '';
        });
	}
	function changeSub(?i:Int = 0){
		curOption = FlxMath.wrap(curOption + i, 0, select.length - 1);

		var curMember:FlxText = txtGroup.members[curSelected];
		curMember.text = 'Settings > ';
		setText(options[curOption], curMember);
	}
    public function setText(txt:String, txtSpr:FlxText) {
        var toInt:Int = txt.length;

        var i:Int = 0;
        new FlxTimer().start(0.04, function(tmr:FlxTimer) {
            txtSpr.text += txt.charAt(i);

			selected.makeGraphic(Std.int(txtSpr.width + 20),Std.int(txtSpr.height) , FlxColor.BLACK);
			selected.x = txtSpr.x + (txtSpr.width - selected.width) / 2;
        	selected.y = txtSpr.y + (txtSpr.height - selected.height) / 2;
            i+=1;
            if (i >= toInt) {
                tmr.cancel();

            }
        }, toInt);
    }
	function openSelectedSubstate(label:String) {
		switch(label){
			case 'Controls':
				// openSubState(new options.snc.opt.subs.Control());
			case 'Graphics':
				openSubState(new archive.opt.subs.Graphic());
			case 'Visuals':
				openSubState(new archive.opt.subs.Visual());
			case 'Gameplay':
				openSubState(new archive.opt.subs.Gameplay());
		}
	}
	function changeOption(?i:Int = 0){
		curSelected = FlxMath.wrap(curSelected + i, 0, select.length - 1);

		var curMember:FlxText = txtGroup.members[curSelected];
		selected.makeGraphic(Std.int(curMember.width + 20),Std.int(curMember.height) , FlxColor.BLACK);
		selected.x = curMember.x + (curMember.width - selected.width) / 2;
        selected.y = curMember.y + (curMember.height - selected.height) / 2;
	}
	public static function boundTo(value:Float, min:Float, max:Float):Float {
		var newValue:Float = value;
		if (newValue < min)
			newValue = min;
		else if (newValue > max)
			newValue = max;
		return newValue;
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

        camFollow.setPosition(450, curMember.y);
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
	public static function path(path:String){
		if (!FileSystem.exists(path)){
			trace('could not find $path');
			return null;
        }
		return path;
    }
	inline static public function getText(key:String):String{
		var path:String = path(key);
		return (FileSystem.exists(path)) ? File.getContent(path) : null;
	}
}