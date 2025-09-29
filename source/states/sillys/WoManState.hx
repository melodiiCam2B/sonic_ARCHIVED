package states.sillys;
class WoManState extends MusicBeatState{
	override public function create(){
		MusicBeatState.switchState(new archive.Menu());
	}
}