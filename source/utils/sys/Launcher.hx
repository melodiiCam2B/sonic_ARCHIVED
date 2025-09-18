package utils.sys;

import lime.app.Application;
import flixel.FlxG;
import lime.ui.Window;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import flixel.text.FlxText;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.events.Event;

import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.net.URLRequest;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.text.AntiAliasType;
   
class Launcher {
    public var window:Window;
    private var onClose:Void->Void;
    private var content:Sprite;
    private var launch:String = "assets/system/sounds/mus_create.wav";
    private var credit:TextField;

    var sound:Sound;
    var soundChannel:SoundChannel;

    public function new(title:String, width:Int, height:Int, ?alwaysOnTop:Bool = false, ?border:Bool = false, ?onClose:Void->Void) {
        var display = Application.current.window.display.currentMode;
        this.onClose = onClose;

        trace("Launcher Init..");
        window = Application.current.createWindow({
            title: title,
            width: width,
            height: height,
            alwaysOnTop: alwaysOnTop,
            borderless: border,
            resizable: false
        });

        window.x = Std.int((display.width - width) / 2);
        window.y = Std.int((display.height - height) / 2);

        window.stage.color = 0x202020; // 0xFF010101
        content = new Sprite();
        window.stage.addChild(content);
        window.onClose.add(handleClose);
        mr_chaoss(); // my best credit
    }

    var bmp:Bitmap;

    public function setContent(pixels:BitmapData, ?scale:Float = 1.0, ?x:Float = 0.0, ?y:Float = 0.0, ?center:Bool = false) {
        if (pixels == null) {
            trace("Error: BitmapData is null.");
            return;
        }
    
        if (bmp != null) {
            content.removeChild(bmp);
            bmp = null;
        }
    
        bmp = new Bitmap(pixels);
        bmp.smoothing = true;
        bmp.scaleX = scale;
        bmp.scaleY = scale;
        bmp.alpha = 1;

        if (sound == null) {
            sound = new Sound();
            sound.load(new URLRequest(launch));
        }
        soundChannel = sound.play();


        if (!center) {
            bmp.x = x;
            bmp.y = y;
        }
        content.addChild(bmp);
    }

    private function handleClose() {
        if (onClose != null) onClose();
        trace("Game Starting..");
        close();
    }

    public function close() {
        if (window != null) {
            window.close();
            window = null;
        }
    }

    private function mr_chaoss() {
        credit = new TextField();
        credit.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF, false);
        credit.autoSize = TextFieldAutoSize.LEFT;
        credit.mouseEnabled = false;
        credit.antiAliasType = AntiAliasType.ADVANCED;
        credit.text = "made by mr_chaoss";
        credit.alpha = 0.75;
        content.addChild(credit);
        centerText();
    }

    private function centerText() {
        if (credit == null || window == null) return;
        var sw = window.stage.stageWidth;
        var sh = window.stage.stageHeight;
        credit.x = sw - credit.width - 8;
        credit.y = sh - credit.height - 2;
    }
}