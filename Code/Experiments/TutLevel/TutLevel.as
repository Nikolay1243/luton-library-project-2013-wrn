package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*
	
	public class TutLevel extends MovieClip {
		
		
		private var background1:Background1;
		private var background2:Background2;
		private var background3:Background3;
		
		private var level:Level;
		private var level_Visible:Level_Visible;
		private var player:Player;
		static var kart:Karts;
		
		public var container:MovieClip;
		public var garage:GarageMovieclip = new GarageMovieclip();
		
		public var whichLevel:int = 1;
		
		public var question:UpgradeQuestion = new UpgradeQuestion();
		
		public function TutLevel() {
			// constructor code
			
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
			
			background2.scaleX = 0.5;
			background2.scaleY = 0.5;
			
			background1.scaleX = 0.5;
			background1.scaleY = 0.5;
			
			if (whichLevel==1)
			{
				background2.y=level_Visible.y+250
				background1.y = level_Visible.y+180;
			}
			
			level.y = 50;
			level.scaleX = 0.8;
			level.scaleY = 0.5;
			
			
			level_Visible.y = 50;
			level_Visible.scaleX = 0.8;
			level_Visible.scaleY = 0.5;
			
			container = new MovieClip();
			
			if(whichLevel == 1)
			{
				kart = new Karts();
				
			}
			
			kart.scaleX = 0.5;
			kart.scaleY = 0.5;
			kart.alpha = 1;

			Player.kart = kart;
			Player.container = container;
			Player.level = level;
			Player.garage = garage;
			Player.level_Visible = level_Visible;
			Player.background1 = background1;
			Player.background2 = background2;
			Player.background3 = background3;
			
			
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
			
			container.x=30
			container.y=140
				
			kart.y=3
				
			player.x=30
			player.y=140
			kart.x=player.x
				
			player.scaleX = 0.5;
			player.scaleY = 0.5;
			player.alpha=0.01;
			kart.alpha = 1;
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, player.keyboardDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, player.keyboardUp);
			
			addEventListener(Event.ENTER_FRAME, updateStage);
		}
		
		
		public function updateStage(e:Event)
		{
			if(player.carStop == true)
			{
				addChild(question)
				question.visible = true;
				question.alpha = 0.8;
				question.x = stage.stageWidth / 2;
				question.y = 10;
				question.CheckCorrect.addEventListener(MouseEvent.MOUSE_DOWN, doSomething);
			}
			
		}
		
		public function doSomething(e:MouseEvent)
		{
			player.FinishTutLevel();
			question.visible = false;
			this.removeEventListener(Event.ENTER_FRAME, updateStage);
		}
	}
	
}
