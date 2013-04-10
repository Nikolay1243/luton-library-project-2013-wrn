package  {
	
	import com.hybrid.ui.ToolTip;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import flash.text.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.system.*;
	
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	
	import fl.controls.Button;
	
	
	public class GarageClass extends MovieClip {
		
		private var _tf:TextField;
		private var _timer:Timer;
		private var _reusableTip:ToolTip;
			
			
		private var goButton=new Button()
		private var myTextFormat=new TextFormat()
		private var project_Font:Font=new Project_Font()
			
		
		
		public function GarageClass() 
		{
			trace("GarageClass Constructor")
			
			CreateToolTip()
			MakeButtons()
		}
		public function MakeButtons()
		{
						
			myTextFormat.font=project_Font.fontName 
			myTextFormat.size=30
			myTextFormat.color = 0xFFFFFF
			
			goButton.move(480,350)
			goButton.setSize(164,44)
			goButton.label="GO!"
			goButton.setStyle("embedFonts", true);
			goButton.setStyle("textFormat", myTextFormat)
			
			addChild(goButton)
			
			goButton.buttonMode = true;
			goButton.addEventListener( MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
			
		}
		
		public function SetupGarage()
		{
			trace("SetUpGarage")
		}
		
		public function NextInList(e:Event,WhichList)
		{
			trace("NextInList")
		}
		
		public function CustomizeToolTip(event:MouseEvent )
		{
			if (event.target ==goButton)
			{
				trace("hello goButton")
				_reusableTip.show( goButton, "Go!");
			}else trace("You are not the droid we are looking for")
				   
			
		}
		
		public function CreateToolTip()
		{
			var tf:TextFormat = new TextFormat();
			
			tf.font =project_Font.fontName 
			tf.size = 30;
			tf.color = 0x000000;
			
			_reusableTip = new ToolTip();
			_reusableTip.titleEmbed = true;
			_reusableTip.contentEmbed = true;
			_reusableTip.titleFormat =tf
			_reusableTip.contentFormat = tf
			
			_reusableTip.hook = true;
			_reusableTip.cornerRadius = 0;
			_reusableTip.autoSize = true;
			_reusableTip.align = "center";
			
			_reusableTip.border = 0x000000;
			_reusableTip.borderSize = 2;
			
			
		}
		
		public function NextLevel(e:Event)
		{
			trace("NextLevel")
		}
	}
	
}
