package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextFormat;
	import flash.text.Font;
	
	public class GameTimer extends MovieClip
	{
		//these 3 variables will hold the necessary elements to show the timer in the game
		public var textTime:TextField;
		public var timer:Timer;
		public var time:Date;
		
		//these 3 vaiables will be used outside the GameTimer class (such as in the end game screen)
		public static var min = 0;
		public static var sec = 0;
		public static var mil = 0;
		
		//this function sets up the timer
		public function GameTimer()
		{
			// constructor code
			
			time = new Date(0,0,0,0,0,0,0);
			timer = new Timer(100);
			
			textTime = new TextField();
			addChild(textTime);
			textTime.selectable = false;
			
			//Text format to match the font and style of the game
			var project_Font:Font=new Project_Font();
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = project_Font.fontName;
			textFormat.size = 20;
			textFormat.color = 0x000000
			textTime.defaultTextFormat = textFormat;
			
			//starts the timer
			timer.addEventListener(TimerEvent.TIMER, startTimer);
			timer.start();
			
			addEventListener(Event.ENTER_FRAME, update)
		}
		
		//if this function is called to properly format the time shown in the End Game scree
		public function getTime()
		{
			min += time.minutes;
			sec += (time.seconds + 1);
			
			while(sec >= 60)
			{
				min += 1;
				sec -= 60;
			}
			
		}
		
		//this function is called every frame to make sure the timer stays up to date
		function update(e:Event):void
		{
			textTime.text = time.minutes + " : " + time.seconds + " : " + time.milliseconds / 100 + int(Math.random() * 10);
		}
		
		//this function kickstarts the timer 
		function startTimer(e:TimerEvent):void
		{
			time.milliseconds += 100;
		}

	}
	
}
