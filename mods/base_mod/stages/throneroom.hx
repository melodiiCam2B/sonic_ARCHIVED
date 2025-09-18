import openfl.Lib;

var tree1:FlxSprite = new FlxSprite();
var floor:FlxSprite = new FlxSprite();
var tree2:FlxSprite = new FlxSprite();
var front:FlxSprite = new FlxSprite();
var back:FlxSprite = new FlxSprite();
function onCreatePost(){
	triggerEvent('Change Character','gf','df_gf');
	game.gf.scrollFactor.set(0.99,0.99);

	tree1.loadGraphic(Paths.image('stages/throne_room_fell/behind_part_1'));
	tree1.screenCenter();
	tree1.scrollFactor.set(0.8,0.8);

	floor.loadGraphic(Paths.image('stages/throne_room_fell/throne_room'));
	floor.screenCenter();

	tree2.loadGraphic(Paths.image('stages/ruinsthrone_room_fell_exit/background_front'));
	tree2.screenCenter();
	tree2.scrollFactor.set(0.9,0.9);

	front.loadGraphic(Paths.image('stages/throne_room_fell/candles'));
	front.screenCenter();
	front.y += 180;

	back.loadGraphic(Paths.image('stages/throne_room_fell/rest_of_bg'));
	back.screenCenter();
	back.scrollFactor.set(0.7,0.7);

	insert(gfGroup, front);
	insert(gfGroup, floor);
	insert(gfGroup, tree2);
	insert(gfGroup, tree1);
	insert(gfGroup, back);
}