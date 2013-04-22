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
		
		private var displayKart=LevelGenerationClass.kart
		//private var displayKart=new Karts()
		
		private var myItems:Array
		
		public function GarageClass(currentLevel) 
		{
			trace("GarageClass Constructor")
			currentLevel1=currentLevel
			trace(currentLevel1)
			
			
			CreateToolTip()
			MakeButtons()
			
			SetupKart()
			SetupItems()
			
			//addEventListener(Event.ENTER_FRAME,getMouseCo)
		}
		
		public function getMouseCo(e:Event)
		{
			trace (stage.mouseX)
			trace (stage.mouseY)
		}//get mouse coord
		
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
			myGrace.scaleX *= -1;//rotates grace horizontally
	
			var buttonArray:Array=[goButton,upgradeButton,leftArrow,rightArrow,myGrace]
						
			for (var i:int=0 ;i<(buttonArray.length);i++)
			{
				addChild(buttonArray[i])
				buttonArray[i].buttonMode = true;
				buttonArray[i].addEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem) 
				
			}
		}//end of make buttons
		
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
			
			_reusableTip.autoSize = true;
			_reusableTip.align = "left";
			
			_reusableTip.border = 0x000000;
			_reusableTip.borderSize = 2;
		}//end of setup tooltip
		
		public function CustomizeToolTip(event:MouseEvent )
		{
			//Button tooltips
			
			_reusableTip.align = "left";
			
			if (event.target==goButton){_reusableTip.show( goButton, "Go!","");}
			if (event.target==upgradeButton)
				{
					
					_reusableTip.show( upgradeButton, "UpgradeButton!","This button is used to get upgrades for your bike!")
				}
				
			if (event.target==leftArrow)
				{	
					_reusableTip.align = "right";
					_reusableTip.show( leftArrow, "Left Arrow!","")
					
				}
			if (event.target==rightArrow){_reusableTip.show( rightArrow, "Right Arrow!","")}
			if (event.target==myGrace){_reusableTip.show( myGrace, "Click Grace!","To preview the next level")}
			
			
			
			//item tooltips
			if (event.target ==myItems[0])
			{
				if (myItems[0].currentFrame==1){_reusableTip.show(myItems[0], "wheel 1","")}
				if (myItems[0].currentFrame==2){_reusableTip.show(myItems[0], "wheel 2","")}
				if (myItems[0].currentFrame==3){_reusableTip.show(myItems[0], "wheel 3","")}
			}
			
			if (event.target ==myItems[1])
			{
				if (myItems[1].currentFrame==2){_reusableTip.show(myItems[1], "wheel 2","")}
				if (myItems[1].currentFrame==3){_reusableTip.show(myItems[1], "wheel 3","")}
				if (myItems[1].currentFrame==4){_reusableTip.show(myItems[1], "wheel 4","")}
			}
			if (event.target ==myItems[2])
			{
				if (myItems[2].currentFrame==3){_reusableTip.show(myItems[2], "wheel 3","")}
				if (myItems[2].currentFrame==4){_reusableTip.show(myItems[2], "wheel 4","")}
				if (myItems[2].currentFrame==5){_reusableTip.show(myItems[2], "wheel 5","")}
			}
			
			
		}//end of customize tooltip
		
		public function ClickItem(event:MouseEvent)
		{
			if (event.target==goButton)
			{	
				displayKart.Grace.visible=true
				LevelGenerationClass.kart=displayKart
				MovieClip(root).gotoAndStop(3)
			}
			
			if (event.target==upgradeButton)
			{	
				while (numChildren > 0) {removeChildAt(0)}
				
				if (numChildren==0){MovieClip(root).gotoAndStop(8)}
				
			}
			
			if (event.target==leftArrow)
			{
				if (myItems[0].currentFrame>1){myItems[0].gotoAndStop(myItems[0].currentFrame-1)}
				if (myItems[1].currentFrame>2){myItems[1].gotoAndStop(myItems[1].currentFrame-1)}
				if (myItems[2].currentFrame>3){myItems[2].gotoAndStop(myItems[2].currentFrame-1)}
			}
			
			if (event.target==rightArrow)
			{
				if (myItems[0].currentFrame<3){myItems[0].gotoAndStop(myItems[0].currentFrame+1)} 
				if (myItems[1].currentFrame<4){myItems[1].gotoAndStop(myItems[1].currentFrame+1)}
				if (myItems[2].currentFrame<5){myItems[2].gotoAndStop(myItems[2].currentFrame+1)}
			}
			
			if (event.target ==myItems[0])
			{
				if (myItems[0].currentFrame==1)
				{
					trace("Clicked wheel 1")
					displayKart.wheel1.gotoAndStop(1)
					displayKart.wheel2.gotoAndStop(1)
				}
				
				if (myItems[0].currentFrame==2)
				{
					trace("Clicked wheel 2")
					displayKart.wheel1.gotoAndStop(2)
					displayKart.wheel2.gotoAndStop(2)
				}
				
				if (myItems[0].currentFrame==3)
				{
					trace("Clicked wheel 3")
					displayKart.wheel1.gotoAndStop(3)
					displayKart.wheel2.gotoAndStop(3)
				}
				
			}//end of if target is item [0]
			
			if (event.target ==myItems[1])
			{
				if (myItems[1].currentFrame==2)
				{
					trace("Clicked wheel 2")
					displayKart.wheel1.gotoAndStop(2)
					displayKart.wheel2.gotoAndStop(2)
				}
				
				if (myItems[1].currentFrame==3)
				{
					trace("Clicked wheel 3")
					displayKart.wheel1.gotoAndStop(3)
					displayKart.wheel2.gotoAndStop(3)
				}
				
				if (myItems[1].currentFrame==4)
				{
					trace("Clicked wheel 4")
					displayKart.wheel1.gotoAndStop(4)
					displayKart.wheel2.gotoAndStop(4)
				}
				
			}//end of if target is item [1]
			
			if (event.target ==myItems[2])
			{
				if (myItems[2].currentFrame==3)
				{
					trace("Clicked wheel 3")
					displayKart.wheel1.gotoAndStop(3)
					displayKart.wheel2.gotoAndStop(3)
				}
				
				if (myItems[2].currentFrame==4)
				{
					trace("Clicked wheel 4")
					displayKart.wheel1.gotoAndStop(4)
					displayKart.wheel2.gotoAndStop(4)
				}
				
				if (myItems[2].currentFrame==5)
				{
					trace("Clicked wheel 5")
					displayKart.wheel1.gotoAndStop(5)
					displayKart.wheel2.gotoAndStop(5)
				}
				
			}//end of if target is item [2]
			
			
			
			
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
  					//addChild(l)
  					//panoramaWait=setInterval(showMessage,3000);
				}
				
				if (currentLevel1==3)
				{
					//l.load(new URLRequest("Panoramas/TweenCamera_Lv4.swf"));
					//addChild(l)
					//panoramaWait=setInterval(showMessage,3000);
				}
				
			}//end of show preview
			
		}//click item event
		
		public function showMessage()
		{
			trace("hello");
			removeChild(l)
			clearInterval(panoramaWait)
		}//end of panorama showmessage
		
		
		
		public function SetupKart()
		{
			
			addChild(displayKart)
			displayKart.scaleX=1.5
			displayKart.scaleY=1.5
			displayKart.x=215
			displayKart.y=230
		
			displayKart.Grace.visible=false
			
		}//end of setup kart
		
		public function SetupItems()
		{
			
			myItems=[new KartWheel(),new KartWheel(),new KartWheel()]

			//trace("Items",myItems.length)
						
			for (var i:int=0 ;i<(myItems.length);i++)
			{
				trace("i is ",i)
				addChild(myItems[i])
				myItems[(i)].gotoAndStop(i+1)
				
				myItems[i].x=(i+1)*110
				myItems[i].y=340
				
				myItems[i].buttonMode = true;
				myItems[i].addEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
				myItems[i].addEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem)
				
			}//end of for loop to add items to stage
			
		}//end of setup items
		
	}
	
}
