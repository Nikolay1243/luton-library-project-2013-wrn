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
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*
	
	
	public class LevelGenerationClass extends MovieClip
	{
		private var background1:Background1;
		private var background2:Background2;
		private var background3:Background3;
		
		private var gameTimer:GameTimer;
		private var myTotalTime:String
		private var progressLevel:ProgressLevel;
		private var gameSound:GameSound;
		
		private var level:Level;
		private var level_Visible:Level_Visible;
		private var player:Player;
		static var kart:Karts;
		
		private var myGuiBar:guiBar
		
		public var whichLevel:int
		
		//public var container:Container = new Container();
		public var container:MovieClip;
		public var garage:GarageMovieclip = new GarageMovieclip();
		
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
			background3.gotoAndStop(whichLevel)
			
			background2 = new Background2();
			addChild(background2);
			background2.gotoAndStop(whichLevel)
			
			background1 = new Background1();
			addChild(background1);
			background1.gotoAndStop(whichLevel)
			
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
			
			if (whichLevel==4)
			{
				background3.y = 0
				background2.y = 50
				background1.y = 25;
				level_Visible.y = 65;
				//level.scaleX = 0.6;
			}
			if (whichLevel==5)
			{
				/*background3.y = 0
				background2.y = 50
				background1.y = 25;*/
				
				background3.y = 0
				background2.y -= 150
				background1.y -= 50;
				
				level_Visible.y += 15;
				level.y+=25
				//level.scaleX = 0.6;
			}
			
			container = new MovieClip();
			
			if(whichLevel == 1)
			{
				kart = new Karts();
				
			}
			
			
			
			kart.scaleX = 0.5;
			kart.scaleY = 0.5;
			kart.alpha = 1;

			Player.whichLevel = whichLevel;
			Player.kart = kart;
			Player.container = container;
			Player.level = level;
			Player.garage = garage;
			Player.level_Visible = level_Visible;
			Player.background1 = background1;
			Player.background2 = background2;
			Player.background3 = background3;

			panorama(whichLevel);
			
		}
		
		/*public function helpScreen(whichLevel)
		{
			if(whichLevel == 1)
			{
				l.load(new URLRequest("Panoramas/HelpScreen.swf"));
				addChild(l)
				panoramaWait=setInterval(wait,3000);
			}
			else
			{
				panorama(whichLevel)
			}
			
		}
		
		public function wait()
		{
			removeChild(l)
			clearInterval(panoramaWait)
			panorama(1);
		}*/
		
		public function startTheGame()
		{
			removeChild(l)
			clearInterval(panoramaWait)
			
			l.unload();
			player = new Player();
			addChild(player)
				
			addChild(container);
			container.addChild(kart);
			
			addChild(garage)
			garage.scaleX *= 0.8;
			garage.scaleY *= 0.5;
			level_Visible.garage.alpha=-0.5
			garage.x = level_Visible.garage.x * 0.8 + level_Visible.x;
			garage.y = level_Visible.garage.y * 0.5 + level_Visible.y;
			
			//trace("Garage x ",garage.x,"Garage y ", garage.y,"level vis width ", level_Visible.width,"level vis x " level_Visible.x)
				
			container.x=30
			container.y=120
				
			kart.y=3
				
			player.x=30
			player.y=120
			kart.x=player.x
				
			player.scaleX = 0.5;
			player.scaleY = 0.5;
			player.alpha=0.5
			kart.alpha = 1;
			

			myGuiBar=new guiBar()
			addChild(myGuiBar)
			myGuiBar.x=0
			myGuiBar.y=0
			myGuiBar.scaleX=1.5
			myGuiBar.scaleY=0.8
			
			gameTimer = new GameTimer();
			addChild(gameTimer)
			gameTimer.x=15;
			gameTimer.y=10
			
			ProgressLevel.level = level_Visible;
			ProgressLevel.player = player;
			progressLevel = new ProgressLevel();
			addChild(progressLevel)
			progressLevel.x = 120;
			progressLevel.y = 25;

			GameSound.player = player;
			gameSound = new GameSound();
			addChild(gameSound);
			
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
			if (whichLevel==5)
			{
				l.load(new URLRequest("Panoramas/TweenCamera_Lv5.swf"));
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
					//gameSound.removeEventListener(Event.ENTER_FRAME, gameSound.playLevelSounds)
					progressLevel.removeEventListener(Event.ENTER_FRAME, progressLevel.statePlayer)
					player.removeEventListener(Event.ENTER_FRAME, player.updateStage);
					gameTimer.getTime();
					//trace("currentLevel: "MovieClip(root).currentLevel)
					
					
					//trace(myTotalTime)
					//myTotalTime=gameTimer.textTime.text
      				//trace(myTotalTime)
					
					
					removeEventListener(Event.ENTER_FRAME ,MoveToNextLevel)
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, player.keyboardDown);
					stage.removeEventListener(KeyboardEvent.KEY_UP, player.keyboardUp);
					stage.removeEventListener(Event.ENTER_FRAME, player.updateStage)
					
					
					if (MovieClip(root).currentLevel>0 && MovieClip(root).currentLevel<5)
						{
							//trace("curentLevel: "MovieClip(root).currentLevel)
							MovieClip(root).gotoAndStop(4)
						}else MovieClip(root).gotoAndStop(7)
						
					//this.SetUpLevel(level.currentFrame+1) 
				}
			}//end of if player hits endlevel object
			
			
			
		}//end of move to next level function
	}//end of class
}//end of package
