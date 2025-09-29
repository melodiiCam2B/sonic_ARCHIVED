package archive.backend;

class Transit extends MusicBeatSubstate{
    public static var finishCallback:Void->Void;
    private var bot = new FlxSprite();
    private var top = new FlxSprite();
    private var isTransIn:Bool;
    private var duration:Float;       
    public static var nextCamera:FlxCamera;
    private var transCam:FlxCamera;
    public function new(duration:Float, isTransIn:Bool) {
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
        super();
        this.duration = duration;
        this.isTransIn = isTransIn;

        top.loadGraphic(Paths.image('TRANSIT', 'archive'));
		top.setGraphicSize(FlxG.width, FlxG.height/2);
		top.updateHitbox();
		top.scrollFactor.set();
		top.screenCenter(X);
		top.flipX = true;
        // top.camera = transCam;

        bot.loadGraphic(Paths.image('TRANSIT', 'archive'));
		bot.setGraphicSize(FlxG.width, FlxG.height/2);
		bot.updateHitbox();
		bot.scrollFactor.set();
		bot.screenCenter(X);
        bot.flipY = true;
        // bot.camera = transCam;

        if(isTransIn){
            top.y = -FlxG.height/2;
            bot.y = FlxG.height;
        }else{     
            top.y = 0;
            bot.y = FlxG.height/2;
        }
        
        add(top);
        add(bot);

        if(isTransIn){
			FlxTween.tween(top,{y: 0},duration,{ease: FlxEase.circInOut});
			FlxTween.tween(bot,{y: FlxG.height/2},duration,{ease: FlxEase.circInOut,onComplete:
				function(t:FlxTween) {
                    new FlxTimer().start(0.5, function(tmr:FlxTimer) {
                        if(finishCallback != null){
                            finishCallback();
                            finishCallback = null;
                        }
                    });
				}
			});
        }else{     
			FlxTween.tween(top,{x: -FlxG.width},duration,{ease: FlxEase.circInOut});
			FlxTween.tween(bot,{x: FlxG.width},duration,{ease: FlxEase.circInOut,onComplete:
				function(t:FlxTween) {
                    close();
				}
			});
        }
    }
}