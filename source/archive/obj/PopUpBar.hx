package archive.obj;
import flash.geom.Rectangle;
import flixel.ui.FlxBar;
class PopUpBar extends FlxSpriteGroup {
    var body = new FlxSprite();
    var inside = new FlxSprite();
    var handle = new FlxSprite();
    var x__box = new FlxSprite();
    var x__txt = new FlxText();
    var name = new FlxText();
    
    var boxColor = FlxColor.PINK;

    public var __name:String = '__';

    var onClose:Void->Void;
    var onDone:Void->Void;

    var barRange:Int = 1;

    public var proggressBar:FlxBar;
    //if onClick is null use onClose
    var cornerSize:Int = 11;
	var _draggingPos:FlxPoint;
	var _draggingPoint:FlxPoint;
    public function new(__name:String = 'I\'m waking up',barRange:Int, onDone:Void->Void, ?onClose:Void->Void) {
        this.__name = __name;
        this.onDone = onDone;
        this.onClose = onClose;
        this.barRange = barRange;

        super();
        __create();
    }
    function __create(){
		body.makeGraphic(Std.int(FlxG.width/4.5), Std.int(FlxG.height/4.7), boxColor);
		body.pixels.fillRect(new Rectangle(0, 190, body.width, 5), 0x0);
		body.pixels.fillRect(new Rectangle(0, 0, cornerSize, cornerSize), 0x0);	
		roundCorner(body, false, false);
		body.pixels.fillRect(new Rectangle(body.width - cornerSize, 0, cornerSize, cornerSize), 0x0);		
		roundCorner(body, true, false);
        body.updateHitbox();
        add(body);

        handle.makeGraphic(Std.int(body.width), 30, FlxColor.TRANSPARENT);
        add(handle);

        inside.makeGraphic(Std.int(body.width - 10), Std.int(body.height - 30), FlxColor.WHITE);
        centerToMidpoint(inside, body);
        inside.y = 25;
        add(inside);

        x__box.makeGraphic(20, 20, FlxColor.BLACK);
        centerToMidpoint(x__box, handle);
        x__box.alpha = 0;
        x__box.x = inside.width - 25;
        add(x__box);

        x__txt.text = 'X';
        x__txt.setFormat(Paths.font('pixel.otf'), 14, FlxColor.BLACK);
        centerToMidpoint(x__txt, x__box);
        add(x__txt);

        x__box.y -= 2;

        name.text = __name;
        name.setFormat(Paths.font('pixel.otf'), 14, FlxColor.BLACK);
        name.y = handle.y + (handle.height - name.height) / 2;
        name.x = inside.x + 4;
        name.y -= 2;
        add(name);

        proggressBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 180, 60);
        proggressBar.createFilledBar(FlxColor.PINK, FlxColor.BLACK);
        proggressBar.filledCallback = onDone;
        proggressBar.setRange(0, 4);
        add(proggressBar);

        centerToMidpoint(proggressBar,inside);

        fillBar(1.9);

	}
    public function fillBar(v:Float) proggressBar.value = v;
    public function fitToBar(){
        body.makeGraphic(Std.int(proggressBar.width + 10), Std.int(proggressBar.height + 50), boxColor);
		body.pixels.fillRect(new Rectangle(0, 190, body.width, 5), 0x0);
		body.pixels.fillRect(new Rectangle(0, 0, cornerSize, cornerSize), 0x0);	
		roundCorner(body, false, false);
		body.pixels.fillRect(new Rectangle(body.width - cornerSize, 0, cornerSize, cornerSize), 0x0);		
		roundCorner(body, true, false);
        body.updateHitbox();
        handle.makeGraphic(Std.int(body.width), 30, FlxColor.TRANSPARENT);
        inside.makeGraphic(Std.int(body.width - 10), Std.int(body.height - 30), FlxColor.WHITE);
        centerToMidpoint(inside, body);
        inside.y = 25;

        centerToMidpoint(x__box, handle);
        x__box.x = inside.width - 25;
        centerToMidpoint(x__txt, x__box);
        x__box.y -= 2;

        name.y = handle.y + (handle.height - name.height) / 2;
        name.x = inside.x + 4;
        name.y -= 2;

        centerToMidpoint(proggressBar,inside);
    }
	override function update(elapsed:Float){
		super.update(elapsed);
        if(FlxG.mouse.overlaps(x__box)) x__box.alpha = 0.5; else x__box.alpha = 0;
        if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(x__box)) onClose();
		if(FlxG.mouse.pressed && FlxG.mouse.overlaps(handle)){
			var newPoint:FlxPoint = FlxG.mouse.getPositionInCameraView(camera);
			setPosition(_draggingPos.x - (_draggingPoint.x - newPoint.x), _draggingPos.y - (_draggingPoint.y - newPoint.y));
		}else{
		    _draggingPos = FlxPoint.weak(x, y);
		    _draggingPoint = FlxG.mouse.getPositionInCameraView(camera);
        }
    }

    function centerToMidpoint(target:FlxObject, midPoint:FlxObject){
        target.x = midPoint.x + (midPoint.width - target.width) / 2;
        target.y = midPoint.y + (midPoint.height - target.height) / 2;
    }

	function roundCorner(effected:FlxSprite, flipX:Bool, flipY:Bool){
		var antiX:Float = (effected.width - cornerSize);
		var antiY:Float = flipY ? (effected.height - 1) : 0;
		if(flipY) antiY -= 2;
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 1), Std.int(Math.abs(antiY - 8)), 10, 3), boxColor);
		if(flipY) antiY += 1;
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 2), Std.int(Math.abs(antiY - 6)),  9, 2), boxColor);
		if(flipY) antiY += 1;
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 3), Std.int(Math.abs(antiY - 5)),  8, 1), boxColor);
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 4), Std.int(Math.abs(antiY - 4)),  7, 1), boxColor);
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 5), Std.int(Math.abs(antiY - 3)),  6, 1), boxColor);
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 6), Std.int(Math.abs(antiY - 2)),  5, 1), boxColor);
		effected.pixels.fillRect(new Rectangle((flipX ? antiX : 8), Std.int(Math.abs(antiY - 1)),  3, 1), boxColor);
	}
}