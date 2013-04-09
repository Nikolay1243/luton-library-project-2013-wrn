package  {
	
	import flash.events.Event;
	
	
	public class GarageClass extends MovieClip {
		
		private var _tf:TextField;
	 	private var _timer:Timer;
		private var _reusableTip:ToolTip;
		
		
		public function GarageClass() 
		{
			trace("GarageClass Constructor")
		}
		
		public function SetupGarage()
		{
			trace("SetUpGarage")
		}
		
		public function NextInList(e:Event,WhichList)
		{
			trace("NextInList")
		}
		
		public function HelpTool(e:Event)
		{
			trace("HelpTool")
		}
		
		public function NextLevel(e:Event)
		{
			trace("NextLevel")
		}
		
		public function EnableTip(e:Event)
		{
			_reusableTip = new ToolTip();
			_reusableTip.hook = true;
			_reusableTip.cornerRadius = 20;
			_reusableTip.tipWidth = 260; 
			_reusableTip.align = "right";
			_reusableTip.border = 0xFF0000;
			_reusableTip.borderSize = 5;
		}
		
	}
	
}
