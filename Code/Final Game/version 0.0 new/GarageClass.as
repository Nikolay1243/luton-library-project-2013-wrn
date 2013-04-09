package  {
	
	
	import fl.controls.Button;
	
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import flash.text.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.system.*;
	import com.hybrid.ui.ToolTip;
	
	
	public class GarageClass extends MovieClip {
		
		private var _tf:TextField;
	 	private var _timer:Timer;
		private var _reusableTip:ToolTip;
		
		
		private var myTextFormat=new TextFormat()
		private var project_Font=new Project_Font()
		
		private var goButton=new Button()
		private var upgradeButton=new Button()
		
		public function GarageClass() 
		{
			trace("GarageClass Constructor")
			
			this.MakeButtons ()
			
			
			
			
			
			
			
			//goButton.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOverTwo );
			 
			
			
		}
		
		public function MakeButtons()
		{
			
			trace("Button start")
			
			
						
			myTextFormat.font=project_Font.fontName 
			myTextFormat.size=30
			myTextFormat.color = 0xFFFFFF
						
			
			
			
			goButton.label="Go!"
			goButton.setStyle("embedFonts", true);
			goButton.setStyle("textFormat", myTextFormat)
			goButton.move(454.30,324.05)
			goButton.setSize(183.60,62.90)
			
			
			
			upgradeButton.label="Upgrade"
			upgradeButton.setStyle("embedFonts", true);
			upgradeButton.setStyle("textFormat", myTextFormat)
			upgradeButton.move(469.20,254.5)
			upgradeButton.setSize(152.45,50.55)
			
			
			addChild(goButton)
			addChild(upgradeButton)
			
			
			
			goButton.buttonMode = true;
			goButton.addEventListener( MouseEvent.MOUSE_OVER, this.CustomToolTip);
			
			//upgradeButton.buttonMode = true;
//			upgradeButton.addEventListener( MouseEvent.MOUSE_OVER, CustomToolTip);
			
			
			trace("Button end")
		}
		
		public function SetupGarage()
		{
			trace("SetUpGarage")
		}
		
		public function NextInList(e:Event,WhichList)
		{
			trace("NextInList")
		}
		
		public function ToolTip(event:MouseEvent)
		{
			trace(event.target )
		}
		
		public function CustomToolTip(event:MouseEvent)
		{
			trace("HelpTool")
			
			var tt:ToolTip = new ToolTip();
			tt.align = "center";
			tt.hook = true;
			tt.cornerRadius = 0;
			tt.show( goButton, "Hello" );
			//tt.show( upgradeButton, "Bbye" );
			
		}
		
		public function NextLevel(e:Event)
		{
			trace("NextLevel")
		}
		
		public function EnableTip()
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
