import openfl.Lib;

var tree1:FlxSprite = new FlxSprite();
var floor:FlxSprite = new FlxSprite();
var tree2:FlxSprite = new FlxSprite();
var front:FlxSprite = new FlxSprite();
function onCreatePost(){
	triggerEvent('Change Character','gf','dt_gf');
	game.gf.scrollFactor.set(0.99,0.99);

	tree1.loadGraphic(Paths.image('stages/ruins_exit/background_back'));
	tree1.screenCenter();
	tree1.scrollFactor.set(0.8,0.8);

	floor.loadGraphic(Paths.image('stages/ruins_exit/middleground'));
	floor.screenCenter();

	tree2.loadGraphic(Paths.image('stages/ruins_exit/background_front'));
	tree2.screenCenter();
	tree2.scrollFactor.set(0.7,0.7);

	front.loadGraphic(Paths.image('stages/ruins_exit/foreground'));
	front.screenCenter();
	front.scrollFactor.set(0.99,0.99);

	add(front);
	insert(gfGroup, floor);
	insert(gfGroup, tree2);
	insert(gfGroup, tree1);
}