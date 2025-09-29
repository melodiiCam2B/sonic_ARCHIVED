package archive;
import sys.thread.Thread;// multi threading, needed solely for updating! -- uneffecred by by ClientPrefs util
import flixel.ui.FlxBar;
class Update extends MusicBeatState{
    // // var updater:AsyncUpdater;
	// var progressBar:FlxBar;
    // var updateThreads:Array<Thread> = [];
	// var __threadCycle:Int = 0;
	// function execute(func:Void->Void) {
	// 	var thread = updateThreads[(__threadCycle++) % updateThreads.length];
	// 	thread.events.run(func);
	// }
	// //we're going to run an Async thread for the update download using Zip.uncompressZipAsync()
	// //this may make it slower for some, but it's easier on my end

   	// override public function create(){
	// 	//adding new threads for each, will be destroyed at a later date
	// 	for(i in 0...4)
	// 		updateThreads.push(Thread.createWithEventLoop(function() {Thread.current().events.promise();}));

	// 	finishTransition();

    //     progressBar = new FlxBar(0, FlxG.height - 75, LEFT_TO_RIGHT, FlxG.width, 75);
	// 	progressBar.createGradientBar([0xFF000000], [0xFF000000, 0xFF111111, 0xFF222222, 0xFF444444, 0xFF888888, -1], 1, 90);
	// 	progressBar.setRange(0, 4);
	// 	add(progressBar);
    // }

	// public function downloadFiles() {
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
	// }
}