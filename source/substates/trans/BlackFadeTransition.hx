package substates.trans;

class BlackFadeTransition extends MusicBeatSubstate {
    public static var finishCallback:Void->Void; // Callback for when the transition finishes
    private var fadeSprite:FlxSprite;
    private var leTween:FlxTween = null;
    private var isTransIn:Bool;                  // Determines fade direction
    public static var nextCamera:FlxCamera;

    public function new(duration:Float, isTransIn:Bool) {
        super();

        this.isTransIn = isTransIn;

        var width:Int = FlxG.width;
        var height:Int = FlxG.height;
        fadeSprite = new FlxSprite(0, 0).makeGraphic(width, height, FlxColor.BLACK);
        fadeSprite.alpha = isTransIn ? 1 : 0;
        fadeSprite.scrollFactor.set();
        add(fadeSprite);

        if(isTransIn) {
            FlxTween.tween(fadeSprite, {alpha: 0}, duration, {
                onComplete: function(twn:FlxTween) {
                    if(finishCallback != null)
                        {
                            finishCallback();
                            finishCallback = null;
                        }
                },
            ease: FlxEase.linear});
        } else {
            leTween = FlxTween.tween(fadeSprite, {alpha: 1}, duration, {
                onComplete: function(twn:FlxTween) {
                    if(finishCallback != null)
                        {
                            finishCallback();
                            finishCallback = null;
                        }
                },
            ease: FlxEase.linear});
        }

        if (nextCamera != null) {
            fadeSprite.cameras = [nextCamera];
        }
        nextCamera = null;
    }
}