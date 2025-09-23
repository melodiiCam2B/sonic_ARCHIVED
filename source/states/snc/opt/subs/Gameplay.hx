package states.snc.opt.subs;
import states.snc.obj.*;
class Gameplay extends OptBase
{
	public function new(){
		var option:OptOpt = new OptOpt('PC Info', //Name
			'If checked, allows the game to show info from your PC', //Description
			'pcINFO', //Save data variable name
			BOOL); //Variable type
		addOption(option);
		var option:OptOpt = new OptOpt('PC Mechanics', //Name
			'If checked, allows the game mess with your PC', //Description
			'pcFuckery', //Save data variable name
			BOOL); //Variable type
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:OptOpt = new OptOpt('Downscroll', //Name
			'If checked, notes go Down instead of Up, simple enough.', //Description
			'downScroll', //Save data variable name
			BOOL); //Variable type
		addOption(option);

		var option:OptOpt = new OptOpt('Ghost TOptOptOptOptapping',
			"If checked, you won't get misses from pressing keys\nwhile there are no notes able to be hit.",
			'ghostTapping',
			BOOL);
		addOption(option);
		
		var option:OptOpt = new OptOpt('Auto Pause',
			"If checked, the game automatically pauses if the screen isn't on focus.",
			'autoPause',
			BOOL);
		addOption(option);
		option.onChange = onChangeAutoPause;

		var option:OptOpt = new OptOpt('Disable Reset Button',
			"If checked, pressing Reset won't do anything.",
			'noReset',
			BOOL);
		addOption(option);

		var option:OptOpt = new OptOpt('Sustains as One Note',
			"If checked, Hold Notes can't be pressed if you miss,\nand count as a single Hit/Miss.\nUncheck this if you prefer the old Input System.",
			'guitarHeroSustains',
			BOOL);
		addOption(option);

		var option:OptOpt = new OptOpt('Hitsound Volume',
			'Funny notes does \"Tick!\" when you hit them.',
			'hitsoundVolume',
			PERCENT);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:OptOpt = new OptOpt('Rating Offset',
			'Changes how late/early you have to hit for a "Sick!"\nHigher values mean you have to hit later.',
			'ratingOffset',
			INT);
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:OptOpt = new OptOpt('Sick! Hit Window',
			'Changes the amount of time you have\nfor hitting a "Sick!" in milliseconds.',
			'sickWindow',
			FLOAT);
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15.0;
		option.maxValue = 45.0;
		option.changeValue = 0.1;
		addOption(option);

		var option:OptOpt = new OptOpt('Good Hit Window',
			'Changes the amount of time you have\nfor hitting a "Good" in milliseconds.',
			'goodWindow',
			FLOAT);
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15.0;
		option.maxValue = 90.0;
		option.changeValue = 0.1;
		addOption(option);

		var option:OptOpt = new OptOpt('Bad Hit Window',
			'Changes the amount of time you have\nfor hitting a "Bad" in milliseconds.',
			'badWindow',
			FLOAT);
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15.0;
		option.maxValue = 135.0;
		option.changeValue = 0.1;
		addOption(option);

		var option:OptOpt = new OptOpt('Safe Frames',
			'Changes how many frames you have for\nhitting a note earlier or late.',
			'safeFrames',
			FLOAT);
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		super();
	}

	function onChangeHitsoundVolume()
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);

	function onChangeAutoPause()
		FlxG.autoPause = ClientPrefs.data.autoPause;
}
