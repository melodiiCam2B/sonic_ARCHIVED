import openfl.Lib;

var bg:FlxSprite = new FlxSprite();
var rock:FlxSprite = new FlxSprite();
var gf:FlxSprite = new FlxSprite();
var lava1:FlxSprite = new FlxSprite();
var lava2:FlxSprite = new FlxSprite();
var core:FlxSprite = new FlxSprite();

function onCreatePost(){
	bg.loadGraphic(Paths.image('stages/hotland/bg'));
	bg.screenCenter();

	rock.loadGraphic(Paths.image('stages/hotland/moutains'));
	rock.screenCenter();
	rock.y += 150;

	lava1.frames = Paths.getSparrowAtlas('stages/hotland/Lava_part_1');
	lava1.animation.addByPrefix('idle', 'lava part 1', 24, true);
	lava1.animation.play('idle');
	lava1.screenCenter();
	lava1.y += 490;
	lava2.frames = Paths.getSparrowAtlas('stages/hotland/Lava_part_2');
	lava2.animation.addByPrefix('idle', 'lava part 2', 24, true);
	lava2.animation.play('idle');
	lava2.screenCenter();
	lava2.y += 750;

	gf.loadGraphic(Paths.image('stages/hotland/BG_forward_part'));
	gf.screenCenter();
	gf.y += 670;

	core.frames = Paths.getSparrowAtlas('stages/hotland/Core_part');
	core.animation.addByPrefix('idle', 'machine part', 24, true);
	core.animation.play('idle');
	core.screenCenter();
	core.y += 70;


	insert(gfGroup, gf);
	insert(gfGroup, lava1);
	insert(gfGroup, core);
	insert(gfGroup, lava2);
	insert(gfGroup, rock);
	insert(gfGroup, bg);
}