package states.stages;

import states.stages.objects.*;

class SANIC extends BaseStage{
	var bg = new FlxSprite();
	var porn = new FlxSprite();
	override function create(){
		bg.loadGraphic(Paths.image('stages/sanicbg', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		add(bg);
		bg.screenCenter();
	}
	
	override function createPost(){
		porn.loadGraphic(Paths.image('stages/white', 'archive'));
		porn.setGraphicSize(FlxG.width, FlxG.height);
		porn.alpha = 0;
		add(porn);
		porn.screenCenter();
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float){
		switch(eventName){
			case "sexualHarassment":
				porn.alpha = 1;
				// something something value 1 to float Std float no existy
				FlxTween.tween(porn,{alpha: 0},Std.parseFloat(value1),{ease: FlxEase.circInOut});
		}
	}
}