package  {
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	 
	public class LevelGenerationClass extends MovieClip
	{
		private var background1:Background1;
		private var background2:Background2;
		private var background3:Background3;
		private var endOfLevel=new EndOfLevel()
		
		private var level:Level_1;
		private var level_Visible:Level1_Visible;
		private var player:Player;
		private var kart:Karts;
		
		//public var container:Container = new Container();
		public var container:MovieClip = new MovieClip();
		
		public function LevelGenerationClass() 
		{
			trace("LevelGenerationClass constructor")
		}
		
		public  function SetUpLevel()
		{
			background3 = new Background3();
			addChild(background3);
			background3.y = 400;
			background3.scaleX = 0.5;
			background3.scaleY = 0.5;
			
			background2 = new Background2();
			addChild(background2);
			background2.y = 580;
			background2.scaleX = 0.5;
			background3.scaleY = 0.5;
			
			background1 = new Background1();
			addChild(background1);
			background1.y = 350;
			background1.scaleX = 0.5;
			background1.scaleY = 0.5;
			
			level = new Level_1();
			addChild(level);
			level.y = 50;
			level.scaleX = 0.8;
			level.scaleY = 0.5;
			
			level_Visible = new Level1_Visible();
			addChild(level_Visible);
			level_Visible.y = 50;
			level_Visible.scaleX = 0.8;
			level_Visible.scaleY = 0.5;
			
			level.x = (stage.stageWidth - level.width);
			level_Visible.x = level.x;
			background1.x = level.x / 2;
			background2.x = level.x / 4;
			background3.x = level.x / 8;
			
			//addChild(endOfLevel)
			//endOfLevel.x=200
			//endOfLevel.y=200
			
			
			
			kart = new Karts();
			
			kart.scaleX = 0.5;
			kart.scaleY = 0.5;
			kart.alpha = 0;

			Player.kart = kart;
			Player.container = container;
			Player.level = level;
			Player.level_Visible = level_Visible;
			Player.background1 = background1;
			Player.background2 = background2;
			Player.background3 = background3;
			
			//Start all the event
			addEventListener(Event.ENTER_FRAME, panorama);
			
		}
		public function MoveToNextLevel()
		{
			trace("Next Level function")
		}
		
		public function panorama(e:Event)
		{
			var levelSize:int = (-level.x) * 100 / level.width;
			
			if(levelSize == 0)
			{
				player = new Player();
				
				addChild(player)
				addChild(container);
				container.addChild(kart);
				//container.addChild(player);
				
				
				container.x=30
				container.y=120
				
				kart.y=3
				
				player.x=30
				player.y=120
				
				
				player.scaleX = 0.5;
				player.scaleY = 0.5;
				player.alpha=0.5
				kart.alpha = 1;
				
				
				
				
				stage.addEventListener(KeyboardEvent.KEY_DOWN, player.keyboardDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, player.keyboardUp);
				
				this.removeEventListener(Event.ENTER_FRAME, panorama);
			}
			
			level.x += 10;
			level_Visible.x += 10;
			background1.x += 10 / 2;
			background2.x += 10 / 4;
			background3.x += 10 / 8;
		}

	}
	
}
