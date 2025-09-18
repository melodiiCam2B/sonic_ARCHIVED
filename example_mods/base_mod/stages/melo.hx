import openfl.Lib;
var stage = {
	x: -1700,
	y: -800,
	_: true
}

var sky:FlxSprite = new FlxSprite(stage.x,stage.y);
var clouds:FlxSprite = new FlxSprite(stage.x,stage.y);
var rocks:FlxSprite = new FlxSprite(stage.x,stage.y);
var floor:FlxSprite = new FlxSprite(stage.x,stage.y);
var mt:FlxSprite = new FlxSprite(stage.x,stage.y);
var light:FlxSprite = new FlxSprite(0,stage.y);
var vignette:FlxSprite = new FlxSprite(stage.x,stage.y);

function onCreatePost(){
	sky.loadGraphic(Paths.image('stages/melo/sky'));
	clouds.loadGraphic(Paths.image('stages/melo/clouds'));
	rocks.loadGraphic(Paths.image('stages/melo/rocks'));
	mt.loadGraphic(Paths.image('stages/melo/mt'));
	floor.loadGraphic(Paths.image('stages/melo/floor'));
	light.loadGraphic(Paths.image('stages/melo/light'));
	light.alpha = 0.5;
	vignette.loadGraphic(Paths.image('stages/melo/vignette'));
	vignette.scale.set(5,5);

	insert(gfGroup, floor);
	insert(gfGroup, mt);
	insert(gfGroup, rocks);
	insert(gfGroup, clouds);
	insert(gfGroup, sky);
	add(light);
	add(vignette);

	callOnScripts('window43');


}

function onUpdate(){
	stage._ = callOnLuas('getMustHit');
	switch(stage._){
		case true:
			FlxTween.tween(light, {x: stage.x + 2265}, 0.3, {ease: FlxEase.quadInOut});
		case false:
			FlxTween.tween(light, {x: stage.x + 350}, 0.3, {ease: FlxEase.quadInOut});
	}
}