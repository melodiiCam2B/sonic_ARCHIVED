package archive.opt;

import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepadManager;
import archive.obj.*;

class OptBase extends MusicBeatSubstate{
    private var curOption:OptOpt = null;
	private var curSelected:Int = 0;
	private var optionsArray:Array<OptOpt>;

	private var grpOptions:FlxTypedGroup<OpTxt>;
	private var checkboxGroup:FlxTypedGroup<OpChk>;
	private var grpTexts:FlxTypedGroup<OpTxtAtt>;

	private var descBox:FlxSprite;
	private var descText:FlxText;

	public var title:String;
	public var rpcTitle:String;

	public var bg:FlxSprite;
    private var baseCam:FlxCamera;
	public function new()
	{

		baseCam = new FlxCamera();
		baseCam.bgColor.alpha = 0;
		baseCam.filtersEnabled = false;
		FlxG.cameras.add(baseCam, false);
		super();

		if(title == null) title = 'Options';
		if(rpcTitle == null) rpcTitle = 'Options Menu';
		
		#if DISCORD_ALLOWED
		DiscordClient.changePresence(rpcTitle, null);
		#end
		
		bg = new FlxSprite().loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		add(bg);
		bg.camera = baseCam;
		bg.screenCenter(); 

		// avoids lagspikes while scrolling through menus!
		grpOptions = new FlxTypedGroup<OpTxt>();
		grpOptions.camera = baseCam;
		add(grpOptions);

		grpTexts = new FlxTypedGroup<OpTxtAtt>();
		grpTexts.camera = baseCam;
		add(grpTexts);

		checkboxGroup = new FlxTypedGroup<OpChk>();
		checkboxGroup.camera = baseCam;
		add(checkboxGroup);

		descBox = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		descBox.alpha = 0.6;
		descBox.camera = baseCam;
		add(descBox);

		descText = new FlxText(50, 600, FlxG.width- 30, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		descText.camera = baseCam;
		add(descText);

		for (i in 0...optionsArray.length)
		{
			var optionText:OpTxt = new OpTxt(220, 960, optionsArray[i].name, false);
			optionText.isMenuItem = true;
			/*optionText.forceX = 300;
			optionText.yMult = 90;*/
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(optionsArray[i].type == BOOL)
			{
				var checkbox:OpChk = new OpChk(optionText.x - 105, optionText.y, Std.string(optionsArray[i].getValue()) == 'true');
				checkbox.sprTracker = optionText;
				checkbox.ID = i;
				checkboxGroup.add(checkbox);
			}
			else
			{
				optionText.x -= 80;
				optionText.startPosition.x -= 80;
				//optionText.xAdd -= 80;
				var valueText:OpTxtAtt = new OpTxtAtt('' + optionsArray[i].getValue(), optionText.width + 60);
				valueText.sprTracker = optionText;
				valueText.copyAlpha = true;
				valueText.ID = i;
				grpTexts.add(valueText);
				optionsArray[i].child = valueText;
			}
			//optionText.snapToPosition(); //Don't ignore me when i ask for not making a fucking pull request to uncomment this line ok
			updateTextFrom(optionsArray[i]);
		}

		changeSelection();
		reloadCheckboxes();
	}

	public function addOption(option:OptOpt) {
		if(optionsArray == null || optionsArray.length < 1) optionsArray = [];
		optionsArray.push(option);
		return option;
	}

	var nextAccept:Int = 5;
	var holdTime:Float = 0;
	var holdValue:Float = 0;

	var bindingKey:Bool = false;
	var holdingEsc:Float = 0;
	var bindingBlack:FlxSprite;
	var bindingText:OpTxt;
	var bindingText2:OpTxt;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UI_UP_P){
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P){
			changeSelection(1);
		}

		if (controls.BACK) {
			close();
		}

		if(nextAccept <= 0)
		{
			switch(curOption.type)
			{
				case BOOL:
					if(controls.ACCEPT){
						curOption.setValue((curOption.getValue() == true) ? false : true);
						curOption.change();
						reloadCheckboxes();
					}

				default:
					if(controls.UI_LEFT || controls.UI_RIGHT)
					{
						var pressed = (controls.UI_LEFT_P || controls.UI_RIGHT_P);
						if(holdTime > 0.5 || pressed)
						{
							if(pressed)
							{
								var add:Dynamic = null;
								if(curOption.type != STRING)
									add = controls.UI_LEFT ? -curOption.changeValue : curOption.changeValue;
		
								switch(curOption.type)
								{
									case INT, FLOAT, PERCENT:
										holdValue = curOption.getValue() + add;
										if(holdValue < curOption.minValue) holdValue = curOption.minValue;
										else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;
		
										if(curOption.type == INT)
										{
											holdValue = Math.round(holdValue);
											curOption.setValue(holdValue);
										}
										else
										{
											holdValue = FlxMath.roundDecimal(holdValue, curOption.decimals);
											curOption.setValue(holdValue);
										}
		
									case STRING:
										var num:Int = curOption.curOption; //lol
										if(controls.UI_LEFT_P) --num;
										else num++;
		
										if(num < 0)
											num = curOption.options.length - 1;
										else if(num >= curOption.options.length)
											num = 0;
		
										curOption.curOption = num;
										curOption.setValue(curOption.options[num]);
										//trace(curOption.options[num]);

									default:
								}
								updateTextFrom(curOption);
								curOption.change();
							}
							else if(curOption.type != STRING)
							{
								holdValue += curOption.scrollSpeed * elapsed * (controls.UI_LEFT ? -1 : 1);
								if(holdValue < curOption.minValue) holdValue = curOption.minValue;
								else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;
		
								switch(curOption.type)
								{
									case INT:
										curOption.setValue(Math.round(holdValue));
									
									case PERCENT:
										curOption.setValue(FlxMath.roundDecimal(holdValue, curOption.decimals));

									default:
								}
								updateTextFrom(curOption);
								curOption.change();
							}
						}
		
						if(curOption.type != STRING)
							holdTime += elapsed;
					}
					else if(controls.UI_LEFT_R || controls.UI_RIGHT_R){
						holdTime = 0;
					}
			}

			if(controls.RESET){
				var leOption:OptOpt = optionsArray[curSelected];

				leOption.setValue(!Controls.instance.controllerMode ? leOption.defaultKeys.keyboard : leOption.defaultKeys.gamepad);
				leOption.change();
				reloadCheckboxes();
			}
		}

		if(nextAccept > 0) {
			nextAccept -= 1;
		}
	}

	function updateTextFrom(option:OptOpt) {

		var text:String = option.displayFormat;
		var val:Dynamic = option.getValue();
		if(option.type == PERCENT) val *= 100;
		var def:Dynamic = option.defaultValue;
		option.text = text.replace('%v', val).replace('%d', def);
	}
	
	function changeSelection(change:Int = 0)
	{
		curSelected = FlxMath.wrap(curSelected + change, 0, optionsArray.length - 1);

		descText.text = optionsArray[curSelected].description;
		descText.screenCenter();
		descText.y += 270;

		for (num => item in grpOptions.members)
		{
			item.targetY = num - curSelected;
			item.alpha = 0.6;
			if (item.targetY == 0) item.alpha = 1;
		}
		for (text in grpTexts)
		{
			text.alpha = 0.6;
			if(text.ID == curSelected) text.alpha = 1;
		}

		descBox.makeGraphic(Std.int(descText.width + 20),Std.int(descText.height) , FlxColor.BLACK);
		descBox.x = descText.x + (descText.width - descBox.width) / 2;
        descBox.y = descText.y + (descText.height - descBox.height) / 2;
		descBox.alpha = 0.6;
		
		curOption = optionsArray[curSelected]; //shorter lol
	}

	function reloadCheckboxes()
		for (checkbox in checkboxGroup)
			checkbox.daValue = Std.string(optionsArray[checkbox.ID].getValue()) == 'true'; //Do not take off the Std.string() from this, it will break a thing in Mod Settings Menu
}