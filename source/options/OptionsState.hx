package options;

import states.MainMenuState;
import backend.StageData;
import utils.Path;
import utils.utilities.UtilFont;
import flixel.addons.display.FlxBackdrop;
class OptionsState extends MusicBeatState
{
	var options:Array<String> = [
		// 'Note Colors',
		'Controls',
		'Adjust Delay and Combo',
		'Graphics',
		'Visuals',
		'Gameplay'
		// #if TRANSLATIONS_ALLOWED , 'Language' #end
	];
	private var grpOptions:FlxTypedGroup<UtilFont>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;

	function openSelectedSubstate(label:String) {
		switch(label)
		{
			case 'Note Colors':
				openSubState(new options.NotesColorSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals':
				openSubState(new options.VisualsSettingsSubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
			case 'Language':
				openSubState(new options.LanguageSubState());
		}
	}

	var selectorLeft:UtilFont;
	var selectorRight:UtilFont;

	override function create()
	{
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Options Menu", null);
		#end

		var grid:FlxBackdrop = new FlxBackdrop(Path.image('system/images/fogBG.png'));
		grid.velocity.set(40, 40);
		add(grid);

		grpOptions = new FlxTypedGroup<UtilFont>();
		add(grpOptions);

		for (num => option in options)
		{
			var optionText:UtilFont = new UtilFont(0, 0, Language.getPhrase('options_$option', option), true);
			optionText.scrollFactor.set(0,0);
			optionText.screenCenter();
			optionText.x = 50;
			optionText.y += (92 * (num - (options.length / 2))) + 45;
			grpOptions.add(optionText);
		}

		selectorLeft = new UtilFont(0, 0, '>', true);
				selectorLeft.scrollFactor.set(0,0);
		add(selectorLeft);
		selectorRight = new UtilFont(0, 0, '<', true);
		// add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState()
	{
		super.closeSubState();
		ClientPrefs.saveSettings();
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Options Menu", null);
		#end
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P)
			changeSelection(-1);
		if (controls.UI_DOWN_P)
			changeSelection(1);

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new states.sillys.WoManState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
		mouseLook();
	}

	var xx:Float = 0;
	var yy:Float = 0;
	var mx:Float = 0;
	var my:Float = 0;
	var lerpVal = 0.04;

	function mouseLook() {
		mx = (FlxG.mouse.screenX - 640) / 10;
		my = (FlxG.mouse.screenY - 480) / 10;

		xx = FlxMath.lerp(xx, mx, lerpVal);
		yy = FlxMath.lerp(yy, my, lerpVal);

		FlxG.camera.scroll.x = xx;
		FlxG.camera.scroll.y = yy;
	}
	
	function changeSelection(change:Int = 0)
	{
		curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);

		for (num => item in grpOptions.members)
		{
			item.targetY = num - curSelected;
			item.alpha = 0.6;
			if (item.targetY == 0)
			{
				item.alpha = 1;
				selectorLeft.x = item.x - 33;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}