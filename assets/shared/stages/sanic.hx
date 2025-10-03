var bg = new FlxSprite();
var porn = new FlxSprite();
function onCreate(){
	bg.loadGraphic(Paths.image('stages/sanicbg'));
	bg.setGraphicSize(FlxG.width*3, FlxG.height*3);
	addBehindGF(bg);
	bg.screenCenter();

	porn.loadGraphic(Paths.image('stages/white'));
	porn.setGraphicSize(FlxG.width, FlxG.height);
	porn.alpha = 0;
	porn.camera = game.camHUD;
	add(porn);
	porn.screenCenter();	
}
function eventCalled(eventName:String, value1:String, value2:String){
	switch(eventName){
		case "sexualHarassment":
			porn.alpha = 1;
			FlxTween.tween(porn,{alpha: 0},Std.parseFloat(value1),{ease: FlxEase.circInOut});
	}
}
function addBehindGF(obj:FlxBasic) return insert(members.indexOf(game.gfGroup), obj);