package archive.backend;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import flixel.util.FlxStringUtil;

class Pause extends MusicBeatSubstate{
    private var bot = new FlxSprite();
    private var top = new FlxSprite();

	var options:Array<String> = ['Resume', 'Controls','Exit to menu'];
    var curOption:Int = 0;
    var allow = false;
	var txtGroup:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
	var selected = new FlxSprite();
    var descBox = new FlxSprite();
    var descTxt = new FlxText();
    override function create() {
        allow = false;
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		super.create();
        top.loadGraphic(Paths.image('TRANSIT', 'archive'));
		top.setGraphicSize(FlxG.width, FlxG.height/2);
		top.updateHitbox();
		top.scrollFactor.set();
		top.screenCenter(X);
		top.flipX = true;

        bot.loadGraphic(Paths.image('TRANSIT', 'archive'));
		bot.setGraphicSize(FlxG.width, FlxG.height/2);
		bot.updateHitbox();
		bot.scrollFactor.set();
		bot.screenCenter(X);
        bot.flipY = true;

        top.y = -FlxG.height/2;
        bot.y = FlxG.height;

        add(top);
        add(bot);

		for(i in 0...options.length){
			var txt = new FlxText();
        	txt.text = options[i];
        	txt.setFormat(Paths.font('Sonic Advanced 2.ttf'), 60, FlxColor.WHITE);
        	txt.y = 50 + i * txt.height;
        	txt.x = 40;
			txt.ID = i;
            txt.alpha = 0;
        	txtGroup.add(txt);
		}

		changeOption();
        selected.alpha = 0;
		add(selected);
		add(txtGroup);
        
        descTxt.setFormat(Paths.font('Sonic Advanced 2.ttf'), 35, FlxColor.WHITE);
		descTxt.screenCenter(X);
        descTxt.y = -40;
        descTxt.text = '${PlayState.SONG.song} - ${Difficulty.getString().toUpperCase()} - Lives lost: ${PlayState.deathCounter}';
        descBox.makeGraphic(Std.int(descTxt.width + 20),Std.int(descTxt.height) , FlxColor.BLACK);
		descBox.screenCenter();
		descBox.x = descTxt.x + (descTxt.width - descBox.width) / 2;
        descBox.y = descTxt.y + (descTxt.height - descBox.height) / 2;
        descBox.alpha = 0.6;
        add(descBox);
        add(descTxt);

        FlxTween.tween(top,{y: 0},0.5,{ease: FlxEase.circInOut});
		FlxTween.tween(bot,{y: FlxG.height/2},0.5,{ease: FlxEase.circInOut,onComplete:
			function(t:FlxTween) {
                new FlxTimer().start(0.2, function(tmr:FlxTimer) {
                    FlxTween.tween(descTxt,{y: 50},0.55,{ease: FlxEase.circInOut, onUpdate: (_)->{
                            descBox.x = descTxt.x + (descTxt.width - descBox.width) / 2;
                            descBox.y = descTxt.y + (descTxt.height - descBox.height) / 2;
                        },onComplete: function(t:FlxTween){
                            allow = true;
                        }
                    });
                    txtGroup.forEach(function(spr:FlxText){
                        FlxTween.tween(spr,{alpha: 1},0.4,{ease: FlxEase.circInOut});
                    });
                    FlxTween.tween(selected,{alpha: 1},0.4,{ease: FlxEase.circInOut});
                });
			}
		});
    }
    override function update(elapsed:Float){
        if(allow){
        	for (i in 0...options.length){
				var distItem:Int = -1;
				var memb:FlxSprite = txtGroup.members[i];
   		    	if(FlxG.mouse.overlaps(memb)){
					distItem = i;
					curOption = distItem;
                	changeOption();
				}
			};
            if(FlxG.keys.justPressed.UP ||FlxG.keys.justPressed.DOWN)changeOption(FlxG.keys.justPressed.UP? -1 : 1);
            if(controls.ACCEPT || FlxG.mouse.justPressed){
                switch(options[curOption]){
                    case 'Resume':
                        FlxTween.tween(top,{x: -FlxG.width},0.5,{ease: FlxEase.circInOut});
			            FlxTween.tween(bot,{x: FlxG.width},0.5,{ease: FlxEase.circInOut,onComplete:
				            function(t:FlxTween) {
                                close();
				            }
			            });         
                    case 'Controls':
                        FlxTween.tween(top,{x: -FlxG.width},0.5,{ease: FlxEase.circInOut});
			            FlxTween.tween(bot,{x: FlxG.width},0.5,{ease: FlxEase.circInOut,onComplete:
				            function(t:FlxTween) {
                                // would not use transition - instead port settings substate to pause substate
                                trace('code the fucking menu dipshit');
                                close();
				            }
			            });  
                                
                    case 'Exit to menu':
                        PlayState.deathCounter = 0;
					    PlayState.seenCutscene = false;

					    PlayState.instance.canResync = false;
					    Mods.loadTopMod();
					    FlxG.switchState(new archive.Menu());
					    archive.Menu.startMusic();
					    PlayState.changedDifficulty = false;
					    PlayState.chartingMode = false;
					    FlxG.camera.followLerp = 0;
                }
            }
        }
    }
	function changeOption(?i:Int = 0){
		curOption = FlxMath.wrap(curOption + i, 0, options.length - 1);

		var curMember:FlxText = txtGroup.members[curOption];
		selected.makeGraphic(Std.int(curMember.width + 20),Std.int(curMember.height) , FlxColor.BLACK);
		selected.x = curMember.x + (curMember.width - selected.width) / 2;
        selected.y = curMember.y + (curMember.height - selected.height) / 2;
	}
}