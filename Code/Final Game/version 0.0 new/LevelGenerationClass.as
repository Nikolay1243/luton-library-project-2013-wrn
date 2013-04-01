package  {
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	 
	public class LevelGenerationClass extends MovieClip{
		
		private var background1:Background1;
		private var background2:Background2;
		private var background3:Background3;
		
		private var level:Level_1;
		private var level_Visible:Level1_Visible;
		private var player:Player;
		private var kart:Karts;
		public var container:MovieClip = new MovieClip();
		
		
		public function LevelGenerationClass() 
		{
			// constructor code
		}
		
		public  function SetUpLevel1()
		{
			// constructor code
			
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
			
			addChild(container);
			
			kart = new Karts();
			container.addChild(kart);

			Player.kart = kart;
			Player.container = container;
			Player.level = level;
			Player.level_Visible = level_Visible;
			Player.background1 = background1;
			Player.background2 = background2;
			Player.background3 = background3;
			
			player = new Player();
			addChild(player);
			player.x = 40;
			player.scaleX = 0.5;
			player.scaleY = 0.5;
			player.alpha=1
			
			kart.x = player.x;
			kart.y = player.y;
			kart.scaleX = 0.5;
			kart.scaleY = 0.5;
			
			//Start all the event
			stage.addEventListener(KeyboardEvent.KEY_DOWN, player.keyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, player.keyboardUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, player.mouseDownEvent);
		}

	}
	
}
