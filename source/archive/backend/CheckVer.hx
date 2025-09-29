package archive.backend;
import archive.obj.*;
import archive.backend.utils.*;
class CheckVer {
    // public static var execute:Void -> Void;
    public static var update_:String;
    public static function check(execute:Void -> Void) {
        // \execute = execute;
		getData();
        if(checkNull(curVERSION) != null || checkNull(webVERSION) != null){
		    if(compare(curVERSION,webVERSION)){
			    update_ = 'your version of sonic ARCHIVED is outdated!
				(your version ${curVERSION}, new version ${webVERSION})
				Press OK to update, close this popup to ignore!';
                execute();
		    } 
        }
    }
    //Update Uniform Resource Locator
    static var uurl:String = "https://raw.githubusercontent.com/melodiiCam2B/sonic_ARCHIVED/main/assets/archive/data/data.json";
    private static  var __curVERSION:Version;
	private static  var __webVERSION:Version;
	public static  var curVERSION:Dynamic;
	public static var webVERSION:Dynamic;
	static function compare(local:Dynamic, github:Dynamic) if(local < github) return true; else return false;
    static function checkNull(nullable:Dynamic) if(nullable == null) return null; else return nullable;
	static function getData() {
		__curVERSION = Json.parse(getText('assets/archive/data/data.json'));
		curVERSION = __curVERSION.version;

        var new_ = new Http(uurl);
		new_.onData = function(data:String) {
			__webVERSION = Json.parse(data);
			webVERSION = __webVERSION.version;
		}
		new_.request();
	}
	static function path(path:String){
		if (!FileSystem.exists(path)){
			trace(Log_.red('could not find $path'));
			return null;
        }
		return path;
    }
	static function getText(key:String):String{
		var path:String = path(key);
		return (FileSystem.exists(path)) ? File.getContent(path) : null;
	}
}
typedef Version = {
	var version:Int;
}