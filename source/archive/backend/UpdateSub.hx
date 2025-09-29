package archive.backend;
import sys.thread.Thread;// multi threading, needed solely for updating! -- uneffecred by by ClientPrefs util
import flixel.ui.FlxBar;
import archive.obj.*;
import archive.backend.utils.*;
class UpdateSub extends MusicBeatSubstate{
    var windowMsg:PopUp;
    var bg = new FlxSprite();
    private var updateCam:FlxCamera;
    var ver:String;
    override public function new(ver:String){
        super();
        this.ver = ver;
		updateCam = new FlxCamera();
		updateCam.bgColor.alpha = 0;
		updateCam.filtersEnabled = false;
		FlxG.cameras.add(updateCam, true);

        bg.loadGraphic(Paths.image('MENU', 'archive'));
		bg.setGraphicSize(FlxG.width, FlxG.height);
		add(bg);
        bg.camera = updateCam;
		bg.screenCenter();

        
		

        //adding new threads for each, will be destroyed at a later date
    	// for(i in 0...4)
		// 	updateThreads.push(Thread.createWithEventLoop(function(){Thread.current().events.promise();}));

        //show progressBar if the update was accepted
        // progressBar = new FlxBar(0, FlxG.height - 75, LEFT_TO_RIGHT, FlxG.width, 75);
		// progressBar.createGradientBar([0xFF000000], [0xFF000000, 0xFF111111, 0xFF222222, 0xFF444444, 0xFF888888, -1], 1, 90);
		// progressBar.setRange(0, 4);
		// add(progressBar);



        windowMsg = new PopUp('WARNING!', CheckVer.update_, updateIGNORE, updateACCEPT);
		windowMsg.camera = updateCam;
		windowMsg.screenCenter();
		add(windowMsg);
		trace(Log_.red('A difference in the local and github versions was found'));
    }
	function updateIGNORE():Void{
        FlxG.cameras.remove(updateCam, true);
        close();
		windowMsg.kill();
	}
	function updateACCEPT():Void{
		windowMsg.kill();
        //might swap out to non mutli thread
        //execute((_)->{Zip_.uncompressZipAsync(reader, './', null, progress.curZipProgress);});
	    //we're going to run an Async thread for the update download using Zip.uncompressZipAsync()
	    //this may make it slower for some, but it's easier on my end
	}
   // var updater:AsyncUpdater;
	var progressBar:FlxBar;
    var updateThreads:Array<Thread> = [];
	var __threadCycle:Int = 0;

	function execute(func:Void->Void) {
		var thread = updateThreads[(__threadCycle++) % updateThreads.length];
		thread.events.run(func);
	}

	public function downloadFiles() {
	// 	var files:Array<String> = [];
	// 	var fileNames:Array<String> = [];
	// 	var exePath:String = "";
	// 	for(r in releases) {
	// 		for(e in r.assets) {
	// 			if (e.name.toLowerCase() == "update-assets.zip") {
	// 				files.push(e.browser_download_url);
	// 				fileNames.push('${Path.withoutExtension(e.name)}-${r.tag_name}.${Path.extension(e.name)}');
	// 			} else if (e.name.toLowerCase() == executableGitHubName) {
	// 				exePath = e.browser_download_url;
	// 			}
	// 		}
	// 	}
	// 	progress.curFile = -1;
	// 	progress.curFileName = null;
	// 	progress.files = files.length;
	// 	progress.step = DOWNLOADING_ASSETS;
	// 	trace('starting assets download');
	// 	doFile(files.copy(), fileNames.copy(), function() {
	// 		progress.curFile = -1;
	// 		progress.curFileName = null;
	// 		progress.files = 1;
	// 		progress.step = DOWNLOADING_EXECUTABLE;
	// 		trace('starting exe download');
	// 		doFile([exePath], [executableName], function() {
	// 			trace('done, starting installation');
	// 			installFiles(fileNames);
	// 			progress.done = true;
	// 		});
	// 	});
	}
}