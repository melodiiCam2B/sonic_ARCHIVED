package archive.opt.subs;

import objects.Note;
import objects.StrumNote;
import objects.NoteSplash;
import objects.Alphabet;
import archive.obj.*;
class Visual extends OptBase
{
	var noteOptionID:Int = -1;
	var notes:FlxTypedGroup<StrumNote>;
	var splashes:FlxTypedGroup<NoteSplash>;
	var noteY:Float = 90;
	public function new()
	{
		var option:OptOpt = new OptOpt('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			BOOL);
		addOption(option);
		
		var option:OptOpt = new OptOpt('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			STRING,
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:OptOpt = new OptOpt('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			BOOL);
		addOption(option);

		var option:OptOpt = new OptOpt('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			BOOL);
		addOption(option);

		var option:OptOpt = new OptOpt('Score Text Grow on Hit',
			"If unchecked, disables the Score text growing\neverytime you hit a note.",
			'scoreZoom',
			BOOL);
		addOption(option);

		var option:OptOpt = new OptOpt('Health Bar Opacity',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			PERCENT);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:OptOpt = new OptOpt('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			BOOL);
		addOption(option);
		option.onChange = onChangeFPSCounter;
        #if debug
		var option:OptOpt = new OptOpt('GITHUB Counter',
			'If unchecked, hides GITHUB Counter.',
			'showGIT',
			BOOL);
		addOption(option);
		option.onChange = onChangeGITCounter;

		var option:OptOpt = new OptOpt('DEBUG Counter',
			'If unchecked, hides DEBUG Counter.',
			'showDBG',
		BOOL);
		addOption(option);
		option.onChange = onChangeDBGCounter;

		var option:OptOpt = new OptOpt('Script Counter',
			'If unchecked, hides Script Counter.',
			'showSCP',
			BOOL);
		addOption(option);
		option.onChange = onChangeSCPCounter;

		var option:OptOpt = new OptOpt('All Counters',
			'If unchecked, hides all Counters.',
			'showALL',
			BOOL);
		addOption(option);
		option.onChange = onChangeALL;
        #end
		#end
		
		#if CHECK_FOR_UPDATES
		var option:OptOpt = new OptOpt('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			BOOL);
		addOption(option);
		#end

		#if DISCORD_ALLOWED
		var option:OptOpt = new OptOpt('Discord Rich Presence',
			"Uncheck this to prevent accidental leaks, it will hide the Application from your \"Playing\" box on Discord",
			'discordRPC',
			BOOL);
		addOption(option);
		#end

		var option:OptOpt = new OptOpt('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			BOOL);
		addOption(option);

		super();
	}


	var changedMusic:Bool = false;

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fps_ != null)
			Main.fps_.visible = ClientPrefs.data.showFPS;
	}
	function onChangeDBGCounter()
	{
		if(Main.dbg_ != null)
			Main.dbg_.visible = ClientPrefs.data.showDBG;
	}
	function onChangeSCPCounter()
	{
		if(Main.scp_ != null)
			Main.scp_.visible = ClientPrefs.data.showSCP;
	}
	function onChangeGITCounter()
	{
		if(Main.git_ != null)
			Main.git_.visible = ClientPrefs.data.showGIT;
	}
	function onChangeALL(){
		ClientPrefs.data.showGIT = ClientPrefs.data.showFPS = ClientPrefs.data.showDBG  = ClientPrefs.data.showSCP = ClientPrefs.data.showALL;
		onChangeGITCounter();
		onChangeDBGCounter();
		onChangeFPSCounter();
		onChangeSCPCounter();
	}
	#end
}
