package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextFormat;
	import flash.text.Font;
	
	public class GameTimer extends MovieClip{

		public var time:Date;
		public var timer:Timer;
		public var textTime:TextField;
		
		public function GameTimer(){
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
			textTime.defaultTextFormat = textFormat;
			
			timer.addEventListener(TimerEvent.TIMER, startTimer);
			timer.start();
			
			addEventListener(Event.ENTER_FRAME, update)
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
