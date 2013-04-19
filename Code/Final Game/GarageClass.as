﻿package  {
	
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
	
	import LevelGenerationClass
	
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
		
		private var currentLevel1:int
		private var myGrace=new MyGrace
		private var l=new Loader
		private var panoramaWait
		
		
		
		
		public function GarageClass(currentLevel) 
		{
			trace("GarageClass Constructor")
			currentLevel1=currentLevel
			trace(currentLevel1)
			
			
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
			
			leftArrow.x=28
			leftArrow.y=343.2
			leftArrow.rotation=-90
			
			rightArrow.x=428
			rightArrow.y=343.2
			rightArrow.rotation=90
			
			myGrace.x=545
			myGrace.y=20
			myGrace.scaleX=0.6
			myGrace.scaleY=0.6
			myGrace.scaleX *= -1;
			
			
			
			var buttonArray:Array=[goButton,upgradeButton,leftArrow,rightArrow,myGrace]
						
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
				
				_reusableTip.tipWidth =250
				_reusableTip.show( upgradeButton, "UpgradeButton!","This button is used to, get upgrades for your bike!");
			}
			
			if (event.target==leftArrow)
			{
				_reusableTip.show( leftArrow, "Left Arrow!","");
			}
			
			if (event.target==rightArrow)
			{
				_reusableTip.show( rightArrow, "Right Arrow!","");
			}
			if (event.target==myGrace)
			{
				_reusableTip.show( myGrace, "Click Grace!","To preview the next level");
			}
			
		}
		
		public function ClickItem(event:MouseEvent)
		{
			if (event.target==goButton)
			{	
				MovieClip(root).gotoAndStop(3)
			}
			
			if (event.target==upgradeButton)
			{	
				MovieClip(root).gotoAndStop(8)
			}
			
			
			if (event.target==myGrace)
			{	
				trace("Play Preview")
				
				if (currentLevel1==0)
				{
					l.load(new URLRequest("Panoramas/TweenCamera_Lv1.swf"));
					addChild(l)
					panoramaWait=setInterval(showMessage,3000);
					
				}
				
				if (currentLevel1==1)
				{
					l.load(new URLRequest("Panoramas/TweenCamera_Lv2.swf"));
					addChild(l)
					panoramaWait=setInterval(showMessage,3000);
					
				}
				
				if (currentLevel1==2)
				{
					//l.load(new URLRequest("Panoramas/TweenCamera_Lv3.swf"));
//					addChild(l)
//					panoramaWait=setInterval(showMessage,3000);
					
				}
				
				if (currentLevel1==3)
				{
					//l.load(new URLRequest("Panoramas/TweenCamera_Lv4.swf"));
//					addChild(l)
//					panoramaWait=setInterval(showMessage,3000);
				}
				
				
				
				
			}
			
			
			
			
			
		}
		
		

		public function showMessage()
		{
			trace("hello");
			removeChild(l)
			clearInterval(panoramaWait)
		}
		
		
		public function CreateToolTip()
		{
			var tf:TextFormat = new TextFormat();
			
			tf.font =project_Font.fontName 
			tf.size = 25;
			tf.color = 0x000000;
			
			var tf1:TextFormat = new TextFormat();
			
			tf1.font =project_Font.fontName 
			tf1.size = 15;
			tf1.color = 0x000000;
			tf1.bold =false
			
			_reusableTip = new ToolTip();
			_reusableTip.titleEmbed = true;
			_reusableTip.contentEmbed = true;
			_reusableTip.titleFormat =tf
			_reusableTip.contentFormat = tf1
			
			
			_reusableTip.hook = true;
			_reusableTip.cornerRadius = 0;
			_reusableTip.tipWidth=200
			_reusableTip.autoSize = false;
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
