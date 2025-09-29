package archive.obj;

class Plate extends FlxSpriteGroup {
    var body = new FlxSprite();
    var tile = new FlxSprite();
    var port = new FlxSprite();
    var txbg = new FlxSprite();

    var name = new FlxText();
    var desc = new FlxText();
    var cred = new FlxText();

    public var title:String = 'Place Holder';
    public var credits:String = 'not added yet';
    public var portrait:String = 'port_temp';

    public function new(?title:String = 'Place Holder', ?credits:String = 'not added yet',?portrait:String = 'port_temp') {
        this.title = title;
        this.credits = credits;
        if(fileCheck(portrait)) this.portrait = portrait;
        super();
        __create();
    }
    function fileCheck(path:String)return FileSystem.exists('assets/archive/images/cards/$path.png');
    function __create(){
        body.loadGraphic(Paths.image('BACK', 'archive'));
        body.setGraphicSize(1280/5, 720/2*1.2);
        body.updateHitbox();
        add(body);

        tile.makeGraphic(Std.int(body.width - 20), 40, FlxColor.BLACK);
		tile.x = body.x + (body.width - tile.width) / 2;
        tile.y = body.y + 5;
        tile.alpha = 0.6;
		add(tile);

        name.text = title;
        name.setFormat(Paths.font('Sonic Advanced 2.ttf'), 30, FlxColor.WHITE);
        name.y = tile.y + (tile.height - name.height) / 2;
        name.x = tile.x + 2;
        add(name);

        port.loadGraphic(Paths.image('cards/'+portrait, 'archive'));
        port.setGraphicSize(body.width - 20, 720/4);
        port.updateHitbox();
		port.x = body.x + (body.width - port.width) / 2;
		port.y = body.y + (body.height - port.height) / 2;
        port.y -= 68;
        add(port);

        txbg.makeGraphic(Std.int(body.width - 20),Std.int(port.height) , FlxColor.BLACK);
		txbg.x = body.x + (body.width - txbg.width) / 2;
        txbg.y = port.y + port.height + 10;
        txbg.alpha = 0.6;
		add(txbg);
        
        cred.text = 'CREDITS';
        cred.setFormat(Paths.font('Sonic Advanced 2.ttf'), 30, FlxColor.WHITE);
        cred.y = txbg.y + 2;
        cred.x = txbg.x + 2;
        add(cred);

        desc.text = credits;
        desc.setFormat(Paths.font('Sonic Advanced 2.ttf'), 25, FlxColor.WHITE);
        desc.fieldWidth = txbg.width-4;
        desc.y = txbg.y + cred.height + 2;
        desc.x = txbg.x + 2;
        add(desc);
    }
}

