import openfl.Lib;
var stage = {
	x: -80,
	y: -260,
	s: 1,
	f: 0
}

var wall:FlxSprite = new FlxSprite(stage.x,stage.y);
var prt1:FlxSprite = new FlxSprite(stage.x,stage.y);
var prt2:FlxSprite = new FlxSprite(stage.x,stage.y);
var prt3:FlxSprite = new FlxSprite(stage.x,stage.y);
var prt4:FlxSprite = new FlxSprite(stage.x,stage.y);

function onCreatePost(){
	triggerEvent('Change Character','gf','b3_gf');
	game.gf.scrollFactor.set(0.99,0.99);

	wall.loadGraphic(Paths.image('stages/yolo/BG1'));
	wall.scale.set(stage.s,stage.s);

	prt1.loadGraphic(Paths.image('stages/yolo/BG2_0'));
	prt1.scale.set(stage.s,stage.s);

	prt2.loadGraphic(Paths.image('stages/yolo/BG2_1'));
	prt2.scale.set(stage.s,stage.s);

	prt3.loadGraphic(Paths.image('stages/yolo/BG2_2'));
	prt3.scale.set(stage.s,stage.s);

	prt4.loadGraphic(Paths.image('stages/yolo/BG2_3'));
	prt4.scale.set(stage.s,stage.s);

	insert(gfGroup, prt1);
	insert(gfGroup, prt2);
	insert(gfGroup, prt3);
	insert(gfGroup, prt4);
	insert(gfGroup, wall);
}

function onBeatHit(){
	if (curBeat % 4 == 0){
		curRandom = randomInt(0,3);
		switch(curRandom){
			case 0:
				prt1.visible = true;
				prt2.visible = false;
				prt3.visible = false;
				prt4.visible = false;
			case 1:
				prt1.visible = false;
				prt2.visible = true;
				prt3.visible = false;
				prt4.visible = false;
			case 2:
				prt1.visible = false;
				prt2.visible = false;
				prt3.visible = true;
				prt4.visible = false;
			case 3:
				prt1.visible = false;
				prt2.visible = false;
				prt3.visible = false;
				prt4.visible = true;
		}
	}
}

function randomInt(from:Int, to:Int){
	return from + Math.floor(((to - from + 1) * Math.random()));
}
