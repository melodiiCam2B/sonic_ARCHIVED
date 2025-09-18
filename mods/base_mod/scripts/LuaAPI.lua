local ffi = require("ffi")
ffi.cdef([[
    enum{
        COLOR_REF = 0x131313
    };

    typedef void* HWND;
    typedef int BOOL;

    typedef unsigned char BYTE;
    typedef unsigned long DWORD;
    typedef DWORD COLORREF;

    HWND GetActiveWindow();
    long SetWindowLongA(HWND hWnd, int nIndex, long dwNewLong);

    bool SetLayeredWindowAttributes(HWND hWnd, int crKey, BYTE bAlpha, int dwFlags);
    int GWL_EXSTYLE;
    int WS_EX_LAYERED;
    int LWA_ALPHA;
]])

local SPI_SETDESKWALLPAPER = 0x0014
local SPIF_UPDATEINIFILE = 0x01
local HWND_TOPMOST = ffi.cast("HWND", -1)
local SWP_NOMOVE = 0x0002
local SWP_NOSIZE = 0x0001
local wideScreen = 0
local widescreen = false
local widescreentog = false

local check = 0

function transparentON()
    runHaxeCode([[
        FlxG.camera.bgColor = 0xFF131313;
    ]])
    local hwnd = ffi.C.GetActiveWindow()
    ffi.C.SetWindowLongA(hwnd, -20, 0x00080000)
    ffi.C.SetLayeredWindowAttributes(hwnd, ffi.C.COLOR_REF, 0, 0x00000001)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
end

function transparentOFF()
    local hwnd = ffi.C.GetActiveWindow()
    ffi.C.SetWindowLongA(hwnd, -20, 0x00000000)
    runHaxeCode([[
        FlxG.camera.bgColor = 0xFF000000;
    ]])
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
end

function changeRatio()
	addHaxeLibrary("Lib", "openfl");

	setPropertyFromClass("flixel.FlxG", "width", 1070)
	setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 1070)
	setPropertyFromClass("openfl.Lib", "application.window.width", 1070)
	setPropertyFromClass("openfl.Lib", "application.window.height", 1070)
	setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
	setProperty("camGame.x", -wideScreen)
	setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
    callOnHScript('centerWindowOnPoint')
end

function resetRatio()
	setPropertyFromClass("flixel.FlxG", "width", 1280)
	setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 1280)
	setPropertyFromClass("openfl.Lib", "application.window.width", 1280)
	setPropertyFromClass("openfl.Lib", "application.window.height", 720)
	setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
	setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
    callOnHScript('centerWindow')
end

function shuffle(list)
	ShuffleInPlace(list)
	return table.concat(list)
end

function ShuffleInPlace(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- function onCountdownStarted()
--     changeRatio()
--     transparentON()
-- end

