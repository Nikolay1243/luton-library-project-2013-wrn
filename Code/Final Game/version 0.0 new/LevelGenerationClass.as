package  {
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.*
	import MessageBox
	
	public class LevelGenerationClass extends MovieClip
	{
		private var background1:Background1;
		private var background2:Background2;
		private var background3:Background3;
		
		private var gameTimer:GameTimer;
		
		private var level:Level;
		private var level_Visible:Level_Visible;
		private var player:Player;
		private var kart:Karts;
		
		//public var container:Container = new Container();
		public var container:MovieClip;
		
		public function LevelGenerationClass() 
		{
			trace("LevelGenerationClass constructor")
		}
		
		public function SetUpLevel(whichLevel)
		{
			background3 = new Background3();
			addChild(background3);
			background3.y = 400;
			background3.scaleX = 0.5;
			background3.scaleY = 0.5;
			
			background2 = new Background2();
			addChild(background2);
			background2.y = 500;
			background2.scaleX = 0.5;
			background3.scaleY = 0.5;
			
			background1 = new Background1();
			addChild(background1);
			background1.y = 300;
			background1.scaleX = 0.5;
			background1.scaleY = 0.5;
			
			level = new Level;
			level.gotoAndStop(whichLevel)
			addChild(level);
			level.y = 50;
			level.scaleX = 0.8;
			level.scaleY = 0.5;
			
			level_Visible = new Level_Visible;
			level_Visible.gotoAndStop(whichLevel)
			addChild(level_Visible);
			level_Visible.y = 50;
			level_Visible.scaleX = 0.8;
			level_Visible.scaleY = 0.5;
			
			level.x = (stage.stageWidth - level.width);
			level_Visible.x = level.x;
			background1.x = level.x / 2;
			background2.x = level.x / 4;
			background3.x = level.x / 8;
			
			container = new MovieClip();
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

			addEventListener(Event.ENTER_FRAME, panorama);
			
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
				
				container.x=30
				container.y=120
				
				kart.y=3
				
				player.x=30
				player.y=120
				
				player.scaleX = 0.5;
				player.scaleY = 0.5;
				player.alpha=0.5
				kart.alpha = 1;
				
				gameTimer = new GameTimer();
				addChild(gameTimer)
				gameTimer.x=20;
			
				stage.addEventListener(KeyboardEvent.KEY_DOWN, player.keyboardDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, player.keyboardUp);
				addEventListener(Event.ENTER_FRAME ,MoveToNextLevel)
				
				this.removeEventListener(Event.ENTER_FRAME, panorama);
			}
			
			level.x += 10;
			level_Visible.x += 10;
			background1.x += 10 / 2;
			background2.x += 10 / 4;
			background3.x += 10 / 8;
		}
		
		public function MoveToNextLevel(e:Event)
		{
			
			if (player.x>400)
			{
				while (numChildren > 0) {removeChildAt(0)}
				
				if (numChildren==0)
				{
					
					
					player.removeEventListener(Event.ENTER_FRAME, player.updateStage);
					removeEventListener(Event.ENTER_FRAME ,MoveToNextLevel)
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, player.keyboardDown);
					stage.removeEventListener(KeyboardEvent.KEY_UP, player.keyboardUp);
					stage.removeEventListener(Event.ENTER_FRAME, player.updateStage)
					MovieClip(root).gotoAndStop(4)
					//this.SetUpLevel(level.currentFrame+1) 
				}
			}
		}
	}
}
