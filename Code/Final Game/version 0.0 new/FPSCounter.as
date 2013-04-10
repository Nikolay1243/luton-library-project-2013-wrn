package 
{
	import flash.display.Stage;
	import flash.events. *;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	//
	public class FPSCounter extends TextField
	{
		private var fontSize : Number; //the font size for the field
 
		private var lastUpdate : Number; // the results of getTimer() from the last update
 
		private var frameCount : Number; //stores the count of frames passed this second
 
		private static const UPDATE_INTERVAL : Number = 1000; //the interval at which the frame count will be be posted
 
		public function FPSCounter (textColor : Number = 0xFF0000, fontSize : Number = 25) : void
		{
			this.textColor = textColor;
			this.fontSize = fontSize;
 
			//set the field to autosize from the left
			autoSize = TextFieldAutoSize.LEFT;
 
			//make the text unselecteable and disable mouse events
			selectable = false;
			mouseEnabled = false;
 
			addEventListener (Event.ADDED_TO_STAGE, setFPSUpdate);
			addEventListener (Event.REMOVED_FROM_STAGE, clearFPSUpdate);
		}
 
		//called when the instance is added to a Display Object
		private function setFPSUpdate (event : Event) : void
		{
			addEventListener (Event.ENTER_FRAME, updateFPS);
			frameCount = 0;
			updateText (frameCount);
			lastUpdate = getTimer ();
		}
 
		//called when the instance is removed from a Display Object
		private function clearFPSUpdate (event : Event) : void
		{
			removeEventListener (Event.ENTER_FRAME, updateFPS);
		}
 
		//update the frame counter
		private function updateFPS (event : Event) : void
		{
			//get the current time and increment the frame counter
			var currentTime : Number = getTimer ();
			frameCount ++;
 
			//post the frame count if more then a second has passed
			if (currentTime >= lastUpdate + UPDATE_INTERVAL)
			{
				lastUpdate = currentTime;
				updateText (frameCount);
				frameCount = 0;
			}
		}
 
		//update the display text
		private function updateText (frameNum : Number) : void 
		{
			htmlText = "<b></b><font size='" + fontSize + "'>" + frameNum + " fps</font></b>";
		}
 
	}
}