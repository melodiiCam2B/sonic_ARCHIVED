import openfl.Lib;

var bg:FlxSprite = new FlxSprite();
var floor:FlxSprite = new FlxSprite();
var core:FlxSprite = new FlxSprite();
var lights:FlxSprite = new FlxSprite();
var tube:FlxSprite = new FlxSprite();

function onCreatePost(){
	bg.loadGraphic(Paths.image('stages/core/back'));
	bg.screenCenter();
	bg.scrollFactor.set(0.7,0.7);

	floor.loadGraphic(Paths.image('stages/core/floor'));
	floor.screenCenter();

	core.loadGraphic(Paths.image('stages/core/core'));
	core.screenCenter();
	core.y += 350;
	core.scrollFactor.set(0.8,0.8);

	lights.loadGraphic(Paths.image('stages/core/lights'));
	lights.screenCenter();
	lights.y += 250;
	
	tube.loadGraphic(Paths.image('stages/core/tube'));
	tube.screenCenter();

	insert(gfGroup, tube);
	insert(gfGroup, lights);
	insert(gfGroup, floor);
	insert(gfGroup, core);
	insert(gfGroup, bg);
}