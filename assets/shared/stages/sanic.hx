var bg = new FlxSprite();
function onCreate(){
	bg.loadGraphic(Paths.image('stages/sanicbg'));
	bg.setGraphicSize(FlxG.width*3, FlxG.height*3);
	addBehindGF(bg);
	bg.screenCenter();
}

function addBehindGF(obj:FlxBasic) return insert(members.indexOf(game.gfGroup), obj);