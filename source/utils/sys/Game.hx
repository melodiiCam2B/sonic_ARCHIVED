package utils.sys;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.typeLimit.NextState;
import flixel.system.FlxSplash;


class Game extends FlxGame
{
	private static function crashGame()
	{
		null
		.draw();
	}

	private static function toggleDebug(){
		Main.fps_.visible = !Main.fps_.visible;
		Main.dbg_.visible = !Main.dbg_.visible;
		Main.git_.visible = !Main.git_.visible;
	}

	/**
	 * Used to instantiate the guts of the flixel game object once we have a valid reference to the root.
	 */
	override function create(_):Void
	{
		try
			super.create(_)
		catch (e)
			onCrash(e);
	}

	override function onFocus(_):Void
	{
		try
			super.onFocus(_)
		catch (e)
			onCrash(e);
	}

	override function onFocusLost(_):Void
	{
		try
			super.onFocusLost(_)
		catch (e)
			onCrash(e);
	}

	/**
	 * Handles the `onEnterFrame` call and figures out how many updates and draw calls to do.
	 */
	override function onEnterFrame(_):Void
	{
		try
			super.onEnterFrame(_)
		catch (e)
			onCrash(e);
	}

    public static function centerInstant() {
        var resolutionX = Math.ceil(Lib.current.stage.window.display.currentMode.width * Lib.current.stage.window.scale);
        var resolutionY = Math.ceil(Lib.current.stage.window.display.currentMode.height * Lib.current.stage.window.scale);
        var xCos = (resolutionX - Lib.application.window.width)/2;
        var yCos = (resolutionY - Lib.application.window.height)/2;

        Lib.application.window.x = Std.int(xCos);
        Lib.application.window.y = Std.int(yCos);
    }
	/**
	 * This function is called by `step()` and updates the actual game state.
	 * May be called multiple times per "frame" or draw call.
	 */
	var pressed = false;
	var debug = #if debug true #else false #end;
	override function update():Void{
		if (FlxG.keys.justPressed.Y){
            FlxTween.cancelTweensOf(FlxG.stage.window, ['x', 'y']);
            centerInstant();
            FlxG.stage.window.x -= 150;
            FlxG.stage.window.y -= 50;
            FlxTween.tween(FlxG.stage.window, {x: FlxG.stage.window.x + 300}, 1.4, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.35});
            FlxTween.tween(FlxG.stage.window, {y: FlxG.stage.window.y + 100}, 0.7, {ease: FlxEase.quadInOut, type: PINGPONG});
        }

		if (FlxG.keys.justPressed.F1 && debug)
			crashGame();	

		if (FlxG.keys.justPressed.F4 && debug)
			toggleDebug();

		try
			super.update()
		catch (e)
			onCrash(e);
	}

	/**
	 * Goes through the game state and draws all the game objects and special effects.
	 */
	override function draw():Void
	{
		try
			super.draw()
		catch (e)
			onCrash(e);
	}

	private final function onCrash(e:haxe.Exception):Void
	{
		var emsg:String = "";
		for (stackItem in haxe.CallStack.exceptionStack(true))
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					emsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
					trace(stackItem);
			}
		}

		FlxG.switchState(() -> new utils.sys.Crash(FlxG.state, emsg, e.message));
	}
}