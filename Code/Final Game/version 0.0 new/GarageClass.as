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
	import mx.core.ButtonAsset;
	
	
	public class GarageClass extends MovieClip {
		
		private var _tf:TextField;
		private var _timer:Timer;
		private var _reusableTip:ToolTip;
			
			
		private var goButton=new Button()
		private var upgradeButton=new Button()
		
		private var leftArrow=new MyArrow()
		private var rightArrow=new MyArrow()
		
		private var myTextFormat=new TextFormat()
		private var project_Font:Font=new Project_Font()
		
		
		
		
		public function GarageClass() 
		{
			trace("GarageClass Constructor")
			
			CreateToolTip()
			MakeButtons()
			//addEventListener(Event.ENTER_FRAME,getMouseCo)
		}
		
		public function getMouseCo(e:Event)
		{
			trace (stage.mouseX)
			trace (stage.mouseY)
		}
		
		public function MakeButtons()
		{
						
			myTextFormat.font=project_Font.fontName 
			myTextFormat.size=30
			myTextFormat.color = 0xFFFFFF
			
			upgradeButton.move(469.20,255)
			upgradeButton.setSize(153,51)
			
			upgradeButton.label="Upgrade"
			upgradeButton.setStyle("embedFonts", true);
			upgradeButton.setStyle("textFormat", myTextFormat)
			
			goButton.move(454.30,324.05)
			goButton.setSize(184,63)
			
			goButton.label="GO!"
			goButton.setStyle("embedFonts", true);
			goButton.setStyle("textFormat", myTextFormat)
			
			leftArrow.x=32
			leftArrow.y=359
			leftArrow.width=30
			leftArrow.height=20
			leftArrow.rotation=-90
			
			rightArrow.x=423
			rightArrow.y=330
			rightArrow.width=30
			rightArrow.height=20
			rightArrow.rotation=90
			
			var buttonArray:Array=[goButton,upgradeButton,leftArrow,rightArrow]
						
			for (var i:int=0 ;i<(buttonArray.length);i++)
			{
				addChild(buttonArray[i])
				buttonArray[i].buttonMode = true;
				buttonArray[i].addEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem) 
			}
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
			if (event.target==goButton)
			{
				_reusableTip.show( goButton, "Go!","");
			}
			
			if (event.target==upgradeButton)
			{
				_reusableTip.show( upgradeButton, "UpgradeButton!","This button is used to get upgrades for your bike!");
			}
			
			if (event.target==leftArrow)
			{
				_reusableTip.show( leftArrow, "Left Arrow!","");
			}
			
			if (event.target==rightArrow)
			{
				_reusableTip.show( rightArrow, "Right Arrow!","");
			}
			
		}
		
		public function ClickItem(event:MouseEvent)
		{
			if (event.target==goButton)
			{	
				trace("Move to next level")
				MovieClip(root).gotoAndStop(3)
			}
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
