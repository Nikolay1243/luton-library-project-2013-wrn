package  {
	
	import flash.events .*
	import flash.display.MovieClip;
	import flash.display .*
	
	public class ButtonClass extends SimpleButton  {

		public function ButtonClass() 
		{
			
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler)
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler)
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler)
			
		}
		
		public function mouseDownHandler(e:Event)
		{
			trace("Down Start")
		}
		public function mouseUpHandler(e:Event)
		{
			trace("Up Start")
		}
		public function mouseOverHandler(e:Event)
		{
			trace("Over Start")
		}
	}
	
}
