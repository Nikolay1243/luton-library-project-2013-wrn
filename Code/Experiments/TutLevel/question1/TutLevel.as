package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class TutLevel extends MovieClip {
		
		
		private var background1:Background1X;
		private var background2:Background2X;
		private var background3:Background3X;
		
		private var level:LevelX;
		private var level_Visible:Level_VisibleX;
		private var player:PlayerX;
		static var kart:KartsX;
		
		private var container:MovieClip;
		private var garage:GarageMovieclipX = new GarageMovieclipX();
		
		public var whichLevel:int = 1;
		
		private var question:UpgradeQuestionX = new UpgradeQuestionX();
		
		private var timer:Timer = new Timer(3000);
		
		public function TutLevel() {
			// constructor code
			
			background3 = new Background3X();
			addChild(background3);
			background3.gotoAndStop(whichLevel)
			
			background2 = new Background2X();
			addChild(background2);
			background2.gotoAndStop(whichLevel)
			
			background1 = new Background1X();
			addChild(background1);
			background1.gotoAndStop(whichLevel)
			
			level = new LevelX;
			level.gotoAndStop(whichLevel)
			addChild(level);
			
			level_Visible = new Level_VisibleX;
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
				kart = new KartsX();
				
			}
			
			kart.scaleX = 0.5;
			kart.scaleY = 0.5;
			kart.alpha = 1;

			PlayerX.kart = kart;
			PlayerX.container = container;
			PlayerX.level = level;
			PlayerX.garage = garage;
			PlayerX.level_Visible = level_Visible;
			PlayerX.background1 = background1;
			PlayerX.background2 = background2;
			PlayerX.background3 = background3;
			
			
			player = new PlayerX();
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
			container.y=180
				
			kart.y=3
				
			player.x=30
			player.y=180
			kart.x=player.x
				
			player.scaleX = 0.5;
			player.scaleY = 0.5;
			player.alpha=0.01;
			kart.alpha = 1;
			
			addEventListener(Event.ENTER_FRAME, updateStage);
			addEventListener(Event.ENTER_FRAME, movieClipComplete)
		}
		
		private function movieClipComplete(e:Event)
		{
			if(player.hitTestObject(level_Visible.endLevel))
			{
				player.removeEventListener(Event.ENTER_FRAME, player.updateStage);
				MovieClip(root).completeMovieClip = true;
				this.removeEventListener(Event.ENTER_FRAME, movieClipComplete);
			}
		}
		
		private function updateStage(e:Event)
		{
			if(PlayerX.carStop == true)
			{
				addChild(question)
				question.visible = true;
				question.alpha = 0.8;
				question.x = stage.stageWidth / 2;
				question.y = 10;
				
				question.AnsAText.selectable = false;
				question.AnsBText.selectable = false;
				question.AnsCText.selectable = false;
				
				question.AnsA.selectable = false;
				question.AnsB.selectable = false;
				question.AnsC.selectable = false;
				
				question.QuestionBox.selectable = false;
				question.CheckCorrect.selectable = false;
				
				question.AnsAText.addEventListener(MouseEvent.MOUSE_DOWN, doSomethingA);
				question.AnsBText.addEventListener(MouseEvent.MOUSE_DOWN, doSomethingB);
				question.AnsCText.addEventListener(MouseEvent.MOUSE_DOWN, doSomethingC);
				
				question.AnsB.addEventListener(MouseEvent.MOUSE_DOWN, doSomethingA);
				question.AnsB.addEventListener(MouseEvent.MOUSE_DOWN, doSomethingB);
				question.AnsC.addEventListener(MouseEvent.MOUSE_DOWN, doSomethingC);
				
				question.CheckCorrect.addEventListener(MouseEvent.MOUSE_DOWN, doSomething);
			}
			
		}
		
		private function startTimer(e:TimerEvent)
		{
			
			player.FinishTutLevel();
			question.visible = false;
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, startTimer);
		}
		
		private function doSomething(e:MouseEvent)
		{
			timer.addEventListener(TimerEvent.TIMER, startTimer);
			timer.start();
			
			question.AnsAText.alpha = 0.3;
			question.AnsBText.alpha = 1;
			question.AnsCText.alpha = 0.3;
			
			question.AnsA.alpha = 0.3;
			question.AnsB.alpha = 1;
			question.AnsC.alpha = 0.3;
			
			question.AnsAText.removeEventListener(MouseEvent.MOUSE_DOWN, doSomethingA);
			question.AnsBText.removeEventListener(MouseEvent.MOUSE_DOWN, doSomethingB);
			question.AnsCText.removeEventListener(MouseEvent.MOUSE_DOWN, doSomethingC);
				
			question.AnsB.removeEventListener(MouseEvent.MOUSE_DOWN, doSomethingA);
			question.AnsB.removeEventListener(MouseEvent.MOUSE_DOWN, doSomethingB);
			question.AnsC.removeEventListener(MouseEvent.MOUSE_DOWN, doSomethingC);
			
			this.removeEventListener(Event.ENTER_FRAME, updateStage);
			question.CheckCorrect.removeEventListener(MouseEvent.MOUSE_DOWN, doSomething);
		}
		
		
		private function doSomethingA(e:MouseEvent)
		{
			question.AnsAText.alpha = 1;
			question.AnsBText.alpha = 0.7;
			question.AnsCText.alpha = 0.7;
			
			question.AnsA.alpha = 1;
			question.AnsB.alpha = 0.7;
			question.AnsC.alpha = 0.7;
		}
		private function doSomethingB(e:MouseEvent)
		{
			question.AnsAText.alpha = 0.7;
			question.AnsBText.alpha = 1;
			question.AnsCText.alpha = 0.7;
			
			question.AnsA.alpha = 0.7;
			question.AnsB.alpha = 1;
			question.AnsC.alpha = 0.7;
		}
		private function doSomethingC(e:MouseEvent)
		{
			question.AnsAText.alpha = 0.7;
			question.AnsBText.alpha = 0.7;
			question.AnsCText.alpha = 1;
			
			question.AnsA.alpha = 0.7;
			question.AnsB.alpha = 0.7;
			question.AnsC.alpha = 1;
		}

		
	}

	
}
