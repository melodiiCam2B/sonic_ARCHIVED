package options;

class OpChk extends FlxSprite{
	public var sprTracker:FlxSprite;
	public var daValue(default, set):Bool;
	public var copyAlpha:Bool = true;
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public function new(x:Float = 0, y:Float = 0, ?checked = false) {
		super(x, y);

        loadGraphic(Paths.image('ui/false', 'archive'));

		setGraphicSize(Std.int(0.9 * width));
		updateHitbox();

		daValue = checked;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null) {
			setPosition(sprTracker.x - 65 + offsetX, sprTracker.y);
			if(copyAlpha) {alpha = sprTracker.alpha;}
		}
		super.update(elapsed);
	}

	private function set_daValue(check:Bool):Bool {
		if (check) {
			loadGraphic(Paths.image('ui/true', 'archive'));
		} else {
			loadGraphic(Paths.image('ui/false', 'archive'));
		}
		return check;
	}
}