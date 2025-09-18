package utils.obj;
// 
// import openfl.display.BitmapData;
// import openfl.display.Bitmap;
// import openfl.text.TextField;
// import openfl.text.TextFormat;
// import openfl.display.Sprite;
// import openfl.system.System;

// import flixel.FlxG;
// class FuncButton extends Sprite {
// 	var info:TextField;
// 	var underlay:Bitmap;
// 	var border:Bitmap;
//     private var onClose:Void->Void;

//     public function new(?x:Float =0, ?y:Float = 0, ?name:String = 'Button',onClose:Void->Void){
//     	super();
		
// 		this.x = x;
// 		this.y = y;
//         this.onClose = onClose;
        
//         border = new Bitmap();
// 		border.bitmapData = new BitmapData(1, 1, true, 0xFFAAAAAA);
// 		addChild(border);

//         underlay = new Bitmap();
// 		underlay.bitmapData = new BitmapData(1, 1, true, 0xFFD1D1D1);
// 		addChild(underlay);

//     	info = new TextField();
// 		addChild(info);

//         info.x += text.width +1;
// 		info.selectable = false;
// 		info.mouseEnabled = false;
// 		info.defaultTextFormat = new TextFormat(Path.font('NovaMono.ttf'), 14, 0xFFFFFFFF);
// 		info.autoSize = LEFT;
// 		info.multiline = true;
// 		info.text = name;


// 		underlay.width = info.width + text.width + 3;
// 		underlay.height = text.height;
// 		underlay.x = info.x + (info.width - underlay.width) / 2;
// 		underlay.y = info.y + (info.height - underlay.height) / 2;

// 		border.width = info.width + text.width + 7.5;
// 		border.height = text.height + 4.5;
// 		border.x = underlay.x + (underlay.width - border.width) / 2;
// 		border.y = underlay.y + (underlay.height - border.height) / 2;
//     }
// }