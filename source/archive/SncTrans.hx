package archive;

@:cppFileCode('#include <windows.h>\n#include <dwmapi.h>\n\n#pragma comment(lib, "Dwmapi")')
class SncTrans{
	@:functionCode('
        HWND hWnd = GetActiveWindow();
        res = SetWindowLong(hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) | WS_EX_LAYERED);
        if (res)
        {
            SetLayeredWindowAttributes(hWnd, RGB(1, 1, 1), 0, LWA_COLORKEY);
        }
    ')
	static public function getWindowsTransparent(res:Int = 0){
		return res;
	}

	@:functionCode('
        HWND hWnd = GetActiveWindow();
        res = SetWindowLong(hWnd, GWL_EXSTYLE, GetWindowLong(hWnd, GWL_EXSTYLE) ^ WS_EX_LAYERED);
        if (res)
        {
            SetLayeredWindowAttributes(hWnd, RGB(1, 1, 1), 1, LWA_COLORKEY);
        }
    ')
	static public function getWindowsbackward(res:Int = 0){
		return res;
	}


    @:functionCode('
        HWND window = GetActiveWindow();
        enum{
            COLOR_REF = 0x131313
        };

        SetWindowLong(window, -20, 0x00080000);
        SetLayeredWindowAttributes(window, 0x131313, 0, 0x00000001);
    ')
    public static function pleasebroplease() {}
}