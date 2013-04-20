package  {
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	
	public class LevelGenerationClass extends MovieClip
	{
		private var background1:Background1;
		private var background2:Background2;
		private var background3:Background3;
		
		private var gameTimer:GameTimer;
		
		private var level:Level;
		private var level_Visible:Level_Visible;
		private var player:Player;
		static var kart:Karts;
		
		//public var container:Container = new Container();
		public var container:MovieClip;
		
		
		private var l:Loader = new Loader()
		private var panoramaWait;
		
		public function LevelGenerationClass() 
		{
			trace("LevelGenerationClass constructor")
		}
		
		public function SetUpLevel(whichLevel)
		{
			background3 = new Background3();
			addChild(background3);
			
			background2 = new Background2();
			addChild(background2);
			
			background1 = new Background1();
			addChild(background1);
			
			level = new Level;
			level.gotoAndStop(whichLevel)
			addChild(level);
			
			level_Visible = new Level_Visible;
			level_Visible.gotoAndStop(whichLevel)
			addChild(level_Visible);
			
			background3.y = 400;
			background3.scaleX = 0.5;
			background3.scaleY = 0.5;
			
			
			//background2.y = 500;
			background2.scaleX = 0.5;
			background2.scaleY = 0.5;
			

			background1.scaleX = 0.5;
			background1.scaleY = 0.5;
			
			if (whichLevel==1)
			{
				background2.y=level_Visible.y+250
				background1.y = level_Visible.y+180;
			}
			
			if (whichLevel==2)
			{
				background2.y=level_Visible.y+330
				background1.y = level_Visible.y+270;
			}
			
			if (whichLevel==3)
			{
				background2.y=level_Visible.y+360
				background1.y = level_Visible.y+300;
			}
			
			
			
			
			level.y = 50;
			level.scaleX = 0.8;
			level.scaleY = 0.5;
			
			
			level_Visible.y = 50;
			level_Visible.scaleX = 0.8;
			level_Visible.scaleY = 0.5;
			
			container = new MovieClip();
			
			//if(whichLevel == 1)
			{
				kart = new Karts();
			}
			
			kart.scaleX = 0.5;
			kart.scaleY = 0.5;
			kart.alpha = 1;

			Player.kart = kart;
			Player.container = container;
			Player.level = level;
			Player.level_Visible = level_Visible;
			Player.background1 = background1;
			Player.background2 = background2;
			Player.background3 = background3;

			panorama(whichLevel);
			
		}
		
		public function startTheGame()
		{
			removeChild(l)
			clearInterval(panoramaWait)

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
			addEventListener(Event.ENTER_FRAME ,MoveToNextLevel);
		}
		
		public function panorama(whichLevel)
		{
			
			if (whichLevel==1)
			{
				l.load(new URLRequest("Panoramas/TweenCamera_Lv1.swf"));
				addChild(l)
				panoramaWait=setInterval(startTheGame,2500);
			}
			if (whichLevel==2)
			{
				l.load(new URLRequest("Panoramas/TweenCamera_Lv2.swf"));
				addChild(l)
				panoramaWait=setInterval(startTheGame,2500);
			}
			if (whichLevel==3)
			{
				l.load(new URLRequest("Panoramas/TweenCamera_Lv3.swf"));
				addChild(l)
				panoramaWait=setInterval(startTheGame,2500);
			}
			if (whichLevel==4)
			{
				l.load(new URLRequest("Panoramas/TweenCamera_Lv4.swf"));
				addChild(l)
				panoramaWait=setInterval(startTheGame,2500);
			}
		}
		
		public function MoveToNextLevel(e:Event)
		{
			
			if (player.hitTestObject(level_Visible.endLevel))
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
