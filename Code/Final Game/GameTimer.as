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
		
		public var textTime:TextField;
		public var timer:Timer;
		public var time:Date;
		
		
		public static var min = 0;
		public static var sec = 0;
		public static var mil = 0;
		
		public function GameTimer()
		{
			// constructor code
			
			time = new Date(0,0,0,0,0,0,0);
			timer = new Timer(100);
			
			textTime = new TextField();
			addChild(textTime);
			textTime.selectable = false;
			
			var project_Font:Font=new Project_Font();
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = project_Font.fontName;
			textFormat.size = 20;
			textFormat.color = 0x000000
			textTime.defaultTextFormat = textFormat;
			
			timer.addEventListener(TimerEvent.TIMER, startTimer);
			timer.start();
			
			addEventListener(Event.ENTER_FRAME, update)
		}
		
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
		
		function update(e:Event):void
		{
			textTime.text = time.minutes + " : " + time.seconds + " : " + time.milliseconds / 100 + int(Math.random() * 10);
		}
		
		function startTimer(e:TimerEvent):void
		{
			time.milliseconds += 100;
		}

	}
	
}
