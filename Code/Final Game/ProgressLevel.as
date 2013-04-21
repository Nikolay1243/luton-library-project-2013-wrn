package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class ProgressLevel extends MovieClip {
		
		public static var level:MovieClip;
		public static var player:Player;
		
		public function ProgressLevel() {
			// constructor code
			
			addEventListener(Event.ENTER_FRAME, statePlayer)
		}
		
		
		public function statePlayer(e:Event)
		{
			var levelSize:int = (-level.x + player.x) * 100 / (level.width);
			this.progressState.x = ((levelSize / 100) * this.width);
		}
	}
	
}
