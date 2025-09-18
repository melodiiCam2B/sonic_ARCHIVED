import openfl.Lib;

var tree1:FlxSprite = new FlxSprite();
var floor:FlxSprite = new FlxSprite();
var tree2:FlxSprite = new FlxSprite();
var back:FlxSprite = new FlxSprite();
function onCreatePost(){
	tree1.loadGraphic(Paths.image('stages/snowdin_river/cliff'));
	tree1.screenCenter();
	// tree1.scrollFactor.set(0.8,0.8);

	floor.loadGraphic(Paths.image('stages/snowdin_river/front'));
	floor.screenCenter();

	tree2.loadGraphic(Paths.image('stages/snowdin_river/trees'));
	tree2.screenCenter();
	// tree2.scrollFactor.set(0.9,0.9);

	back.loadGraphic(Paths.image('stages/snowdin_river/back'));
	back.screenCenter();
	// back.scrollFactor.set(0.7,0.7);

	insert(gfGroup, floor);
	insert(gfGroup, tree2);
	insert(gfGroup, tree1);
	insert(gfGroup, back);
}