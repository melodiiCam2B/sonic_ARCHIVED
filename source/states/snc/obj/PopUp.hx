package states.snc.obj;
import flash.geom.Rectangle;
class PopUp extends FlxSpriteGroup {
    var body = new FlxSprite();
    var inside = new FlxSprite();
    var handle = new FlxSprite();

    var x__box = new FlxSprite();
    var x__txt = new FlxText();
    
    var ok_box = new FlxSprite();
    var ok_txt = new FlxText();

    var name = new FlxText();
    var desc = new FlxText();
    
    var boxColor = FlxColor.PINK;

    public var __name:String = '__';
    public var __desc:String = '__';

    var onClose:Void->Void;
    var onClick:Void->Void;
    //if onClick is null use onClose
    var cornerSize:Int = 11;
	var _draggingPos:FlxPoint;
	var _draggingPoint:FlxPoint;
    public function new(__name:String = 'I\'m waking up', __desc:String = 'to ash and dust', ?onClose:Void->Void, ?onClick:Void->Void) {
        this.__name = __name;
        this.__desc = __desc;
        this.onClose = onClose;
        if(onClick != null)
            this.onClick = onClick; 
        else 
            this.onClick = onClose;
        super();
        __create();
    }
    function __create(){
        // body.loadGraphic(Paths.image('popup/body', 'archive'));
        // body.setGraphicSize(FlxG.width/5, FlxG.height/5);
		body.makeGraphic(Std.int(FlxG.width/4.5), Std.int(FlxG.height/4.5), boxColor);
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

        ok_box.makeGraphic(30, 20, FlxColor.BLACK);
        centerToMidpoint(ok_box, inside);
        ok_box.alpha = 0;
        ok_box.y += inside.height/2 - 10;
        add(ok_box);

        ok_txt.text = 'ok';
        ok_txt.setFormat(Paths.font('pixel.otf'), 14, FlxColor.BLACK);
        centerToMidpoint(ok_txt, ok_box);
        add(ok_txt);

        ok_box.y -= 2;

        name.text = __name;
        name.setFormat(Paths.font('pixel.otf'), 14, FlxColor.BLACK);
        name.y = handle.y + (handle.height - name.height) / 2;
        name.x = inside.x + 4;
        name.y -= 2;
        add(name);

        desc.text = __desc;
        desc.setFormat(Paths.font('pixel.otf'), 10, FlxColor.BLACK);
        desc.x = inside.x + 4;
        desc.y = inside.y;
        add(desc);
	}

	override function update(elapsed:Float){
		super.update(elapsed);
        if(FlxG.mouse.overlaps(x__box)) x__box.alpha = 0.5; else x__box.alpha = 0;
        if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(x__box)) onClose();
        if(FlxG.mouse.overlaps(ok_box)) ok_box.alpha = 0.5; else ok_box.alpha = 0;
        if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(ok_box)) onClick();
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