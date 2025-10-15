package archive.cpp;

class CppAPI
{
	#if cpp
	public static function obtainRAM():Int
	{
		return archive.cpp.WindowsData.obtainRAM();
	}

	public static function darkMode()
	{
		archive.cpp.WindowsData.setWindowColorMode(DARK);
	}

	public static function lightMode()
	{
		archive.cpp.WindowsData.setWindowColorMode(LIGHT);
	}

	public static function setWindowOppacity(a:Float)
	{
		archive.cpp.WindowsData.setWindowAlpha(a);
	}

	public static function _setWindowLayered()
	{
		archive.cpp.WindowsData._setWindowLayered();
	}

	public static function setWallpaper(path:String)
	{
		if(path == 'old') {
			if(Wallpaper.oldWallpaper != null) {
			path = Wallpaper.oldWallpaper;
			}else{
				return;
			}}
		archive.cpp.Wallpaper.setWallpaper(path);
	}

	public static function setOld()
	{
		archive.cpp.Wallpaper.setOld();
	}

	public static function hideTaskbar()
	{
		archive.cpp.WindowsData.hideTaskbar();
	}

	public static function restoreTaskbar()
	{
		archive.cpp.WindowsData.restoreTaskbar();
	}

	public static function hideWindows()
	{
		archive.cpp.WindowsData.hideWindows();
	}

	public static function restoreWindows()
	{
		archive.cpp.WindowsData.restoreWindows();
	}

	public static function setTransparency(winName:String, color:Int)
	{
		archive.cpp.Transparency.setTransparency(winName, color);
	}
	
	public static function removeWindowIcon()
	{
		archive.cpp.WindowsData.removeWindowIcon();
	}

	public static function reset()
	{
		archive.cpp.Transparency.reset();
	}
	public static function allowHighDPI() {
		archive.cpp.WindowsData.registerHighDpi();
	}
	#end
}
