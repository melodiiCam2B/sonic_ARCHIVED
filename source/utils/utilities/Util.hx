package utils.utilities;

import utils.utilities.CppUtils;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Format;
import haxe.Json;

using StringTools;
using Lambda;

/**
 * [Util]
 * @param Util extends @param CppUtils
 * when using CPP Functions please call from Util instead of CppUtils.
 * CppUtils holds all sort of code while Util is more streamlined.
 */
class Util {

    // public static function getNDLLS(ndll:String, name:String, args:Int):Dynamic{
    //     CppUtils.getFunction(ndll, name, args);
    // }

    public static function getRAM(){
        return CppUtils.obtainRAM();
    }

    public static function setIcons(y_n:Bool) {
        if(y_n == true) CppUtils.delMinMax() else CppUtils.addMinMax();
    }

    public static function setWallpaper(path:String){
        CppUtils.changeWallpaper(path);
    }

    public static function showMsgBox(caption:String, message:String) {
        CppUtils.showMessageBox(caption, message); 
    }

	public static function setHeaderColor(set:Bool,r:Int, g:Int, b:Int){
        if (set == true ) CppUtils.setWindowBorderColor(r,g,b) else CppUtils._setWindowColorMode(1);
    }

    public static function setWinAlpha(alpha:Float = 1) {
        CppUtils.setWindowLayeredMode(MathUtils.int(alpha));
        CppUtils.setWindowAlpha(alpha);
    }

    public static function getOSVer(){
        return CppUtils.getOSVersion();
    }

    public static function headerFunc(set:Bool){
        if (set == true ) CppUtils.delMinMax(); else CppUtils.addMinMax();
    }

    public static function getWinAlpha():Float{
        return CppUtils.getWindowAlpha();
    }

    public static function winScreenShot(path:String) {
       /* CppUtils.windowsScreenShot(path);*/ trace('nah gng');
    }

    public static function setTaskbar(hide:Bool) {
        CppUtils.hideTaskbar(hide);
    }

    public static function setWindowLayeredMode(?numberMode:Int = 0) {
        CppUtils.setWindowLayeredMode(numberMode);
    }

    public static function transparentWindow(){
        CppUtils.setTransparentBackground();
    }
    // public static function toExpr(v:Dynamic) {
    //     return Context.makeExpr(v, Context.currentPos());}
}