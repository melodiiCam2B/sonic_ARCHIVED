import openfl.Lib;

var bg:FlxSprite = new FlxSprite();
var rock:FlxSprite = new FlxSprite();
var gf:FlxSprite = new FlxSprite();
var tv:FlxSprite = new FlxSprite();

function onCreatePost(){
	game.boyfriend.alpha = 0;
	game.uiGroup.visible = false;

	bg.loadGraphic(Paths.image('stages/youare/bg_player'));
	bg.screenCenter();

	rock.loadGraphic(Paths.image('stages/youare/ground_player'));
	rock.screenCenter();
	rock.y += 150;

	tv.loadGraphic(Paths.image('stages/youare/tv_player'));
	tv.screenCenter();
	tv.y -= 450;

	gf.loadGraphic(Paths.image('stages/youare/light_player'));
	gf.screenCenter();
	// gf.y += 670;




	add(gf);
	insert(gfGroup, rock);
	insert(gfGroup, tv);
	insert(gfGroup, bg);
}