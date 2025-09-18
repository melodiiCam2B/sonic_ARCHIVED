package utils.utilities;

import openfl.Lib;
import flixel.FlxG.*;
import sys.FileSystem;


class FunkinSaveUtils {
    public static function getUtil(variable:String){
        trace(ClientPrefs.data.util.get(variable));
        return ClientPrefs.data.util.get(variable);
    }

    public static function saveUtil(variable:String,value:Dynamic){
  		ClientPrefs.data.util.set(variable, value);
		ClientPrefs.saveSettings();
        trace(ClientPrefs.data.util.get(variable));
    }
}