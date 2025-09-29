package archive.obj;

class OptCon extends FlxTypedGroup<FlxText>{
    var __Width:Float;
    var __Height:Float;
    var __X:Float;
    var __Y:Float;
    public function new(_i:Int, __key:String, _bind1:String, _bind2:String) {
		var options = new FlxText();
        options.text = text;
        options.setFormat(Paths.font('Sonic Advanced 2.ttf'), 60, FlxColor.WHITE);
        options.y = 50 + i * options.height;
        options.x = 40;
        add(options);
    }
}