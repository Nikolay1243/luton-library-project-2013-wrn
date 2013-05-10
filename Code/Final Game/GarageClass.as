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
			
			
		private var playButton=new Button()
		private var upgradeButton=new Button()
		
		private var leftArrow=new MyArrow()
		private var rightArrow=new MyArrow()
		
		private var myTextFormat=new TextFormat()
		private var project_Font:Font=new Project_Font()
		
		private var currentLevel1:int
		private var myGrace=new MyGrace
		private var l=new Loader
		private var panoramaWait
		
		//private var displayKart=LevelGenerationClass.kart
		private var displayKart=new Karts()
		
		private var myItems:Array
		private var mySelectors:Array
		
		
		
		public function GarageClass(currentLevel) 
		{
			trace("GarageClass Constructor")
			currentLevel1=currentLevel
			
			
			
			CreateToolTip()
			MakeButtons()
			
			SetupKart()
			SetupItems("Wheels")
			SetupSelectors()
			
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
			
			playButton.move(454.30,324.05)
			playButton.setSize(184,63)
			
			playButton.label="Play!"
			playButton.setStyle("embedFonts", true);
			playButton.setStyle("textFormat", myTextFormat)
			
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
	
			var buttonArray:Array=[playButton,upgradeButton,leftArrow,rightArrow,myGrace]
						
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
			
			if (event.target==playButton){_reusableTip.show( playButton, "Play!","");}
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
				if (myItems[0] is KartWheel)
				{
				if (myItems[0].currentFrame==1){_reusableTip.show(myItems[0], "wheel 1","")}
				if (myItems[0].currentFrame==2){_reusableTip.show(myItems[0], "wheel 2","")}
				if (myItems[0].currentFrame==3){_reusableTip.show(myItems[0], "wheel 3","")}
				}
				
				if (myItems[0] is KartBody)
				{
				if (myItems[0].currentFrame==1){_reusableTip.show(myItems[0], "body 1","")}
				if (myItems[0].currentFrame==2){_reusableTip.show(myItems[0], "body 2","")}
				if (myItems[0].currentFrame==3){_reusableTip.show(myItems[0], "body 3","")}
				}
			}
			
			if (event.target ==myItems[1])
			{
				if (myItems[0] is KartWheel)
				{
				if (myItems[1].currentFrame==2){_reusableTip.show(myItems[1], "wheel 2","")}
				if (myItems[1].currentFrame==3){_reusableTip.show(myItems[1], "wheel 3","")}
				if (myItems[1].currentFrame==4){_reusableTip.show(myItems[1], "wheel 4","")}
				}
				if (myItems[0] is KartBody)
				{
				if (myItems[1].currentFrame==2){_reusableTip.show(myItems[1], "body 2","")}
				if (myItems[1].currentFrame==3){_reusableTip.show(myItems[1], "body 3","")}
				if (myItems[1].currentFrame==4){_reusableTip.show(myItems[1], "body 4","")}
				}
			}
			if (event.target ==myItems[2])
			{
				if (myItems[0] is KartWheel)
				{
				if (myItems[2].currentFrame==3){_reusableTip.show(myItems[2], "wheel 3","")}
				if (myItems[2].currentFrame==4){_reusableTip.show(myItems[2], "wheel 4","")}
				if (myItems[2].currentFrame==5){_reusableTip.show(myItems[2], "wheel 5","")}
				}
				if (myItems[0] is KartBody)
				{
				if (myItems[2].currentFrame==3){_reusableTip.show(myItems[2], "body 3","")}
				if (myItems[2].currentFrame==4){_reusableTip.show(myItems[2], "body 4","")}
				if (myItems[2].currentFrame==5){_reusableTip.show(myItems[2], "body 5","")}
				}
			}
			
			//selector tooltips
			if (event.target==mySelectors[0])
			{
				_reusableTip.align = "right";
				_reusableTip.show(mySelectors[0], "Kart Wheels","")
			}
			
			if (event.target==mySelectors[1])
			{
				_reusableTip.align = "right";
				_reusableTip.show(mySelectors[1], "Kart Bodies","")
			}
			
			
			
			
		}//end of customize tooltip
		
		public function ClickItem(event:MouseEvent)
		{
			//trace (event.target)
			//MovieClip(root).clickSound.play()
			if (event.target==playButton)
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
				if (myItems[0] is KartWheel&& myItems.length>2)
				{
					if (myItems[0].currentFrame>1){myItems[0].gotoAndStop(myItems[0].currentFrame-1)}
					if (myItems[1].currentFrame>2){myItems[1].gotoAndStop(myItems[1].currentFrame-1)}
					if (myItems[2].currentFrame>3){myItems[2].gotoAndStop(myItems[2].currentFrame-1)}
				}
				if (myItems[0] is KartBody && myItems.length>2)
				{
					
					if (myItems[0].currentFrame>1){myItems[0].gotoAndStop(myItems[0].currentFrame-1)}
					if (myItems[1].currentFrame>2){myItems[1].gotoAndStop(myItems[1].currentFrame-1)}
					if (myItems[2].currentFrame>3){myItems[2].gotoAndStop(myItems[2].currentFrame-1)}
					
				}
				
				
			}
			
			if (event.target==rightArrow)
			{
				if (myItems[0] is KartWheel && myItems.length>2)
				{
					if (myItems[0].currentFrame<3){myItems[0].gotoAndStop(myItems[0].currentFrame+1)} 
					if (myItems[1].currentFrame<4){myItems[1].gotoAndStop(myItems[1].currentFrame+1)}
					if (myItems[2].currentFrame<5){myItems[2].gotoAndStop(myItems[2].currentFrame+1)}
				}
				
				
				if (myItems[0] is KartBody && myItems.length>2)
				{
					
					if (myItems[0].currentFrame<2){myItems[0].gotoAndStop(myItems[0].currentFrame+1)} 
					if (myItems[1].currentFrame<3){myItems[1].gotoAndStop(myItems[1].currentFrame+1)}
					if (myItems[2].currentFrame<4){myItems[2].gotoAndStop(myItems[2].currentFrame+1)}
				}
				
			}
			
			//if Kartwheel
			if (myItems[0] is KartWheel)
			{
				if (event.target ==myItems[0])
				{
					if (myItems[0].currentFrame==1)
					{
						//trace("Clicked wheel 1")
						displayKart.wheel1.gotoAndStop(1)
						displayKart.wheel2.gotoAndStop(1)
					}
					
					if (myItems[0].currentFrame==2)
					{
						//trace("Clicked wheel 2")
						
						displayKart.wheel1.gotoAndStop(2)
						displayKart.wheel2.gotoAndStop(2)
					}
					
					if (myItems[0].currentFrame==3)
					{
						//trace("Clicked wheel 3")
						displayKart.wheel1.gotoAndStop(3)
						displayKart.wheel2.gotoAndStop(3)
					}
					
				}//end of if target is item [0]
				
				if (event.target ==myItems[1])
				{
					if (myItems[1].currentFrame==2)
					{
						trace("Clicked wheel 2")
						Player.SpeedX = 0.4;
						Player.SpeedY = 0.4;
						//Player.GRAVITY = 0.2;
						displayKart.wheel1.gotoAndStop(2)
						displayKart.wheel2.gotoAndStop(2)
					}
					
					if (myItems[1].currentFrame==3)
					{
						//trace("Clicked wheel 3")
						displayKart.wheel1.gotoAndStop(3)
						displayKart.wheel2.gotoAndStop(3)
					}
					
					if (myItems[1].currentFrame==4)
					{
						//trace("Clicked wheel 4")
						displayKart.wheel1.gotoAndStop(4)
						displayKart.wheel2.gotoAndStop(4)
					}
					
				}//end of if target is item [1]
				
				if (event.target ==myItems[2])
				{
					if (myItems[2].currentFrame==3)
					{
						//trace("Clicked wheel 3")
						displayKart.wheel1.gotoAndStop(3)
						displayKart.wheel2.gotoAndStop(3)
					}
					
					if (myItems[2].currentFrame==4)
					{
						//trace("Clicked wheel 4")
						displayKart.wheel1.gotoAndStop(4)
						displayKart.wheel2.gotoAndStop(4)
					}
					
					if (myItems[2].currentFrame==5)
					{
						//trace("Clicked wheel 5")
						displayKart.wheel1.gotoAndStop(5)
						displayKart.wheel2.gotoAndStop(5)
					}
					
				}//end of if target is item [2] 
			}//end if target is KartWheel
			
			//if kart body
			if (myItems[0] is KartBody)
			{
				if (event.target ==myItems[0])
				{
					if (myItems[0].currentFrame==1)
					{
						//trace("Clicked body 1")
						displayKart.Body.gotoAndStop(1)
						
					}
					
					if (myItems[0].currentFrame==2)
					{
						//trace("Clicked body 2")
						displayKart.Body.gotoAndStop(2)
						
					}
					
					if (myItems[0].currentFrame==3)
					{
						//trace("Clicked body 3")
						displayKart.Body.gotoAndStop(3)
						
					}
					
				}//end of if target is item [0] 
				if (event.target ==myItems[1])
				{
					if (myItems[1].currentFrame==2)
					{
						//trace("Clicked body 2")
						displayKart.Body.gotoAndStop(2)
						
					}
					
					if (myItems[1].currentFrame==3)
					{
						//trace("Clicked body 3")
						displayKart.Body.gotoAndStop(3)
						
					}
					
					if (myItems[1].currentFrame==4)
					{
						//trace("Clicked body 4")
						displayKart.Body.gotoAndStop(4)
						
					}
					
				}//end of if target is item [1] 
				
				if (event.target ==myItems[2])
				{
					if (myItems[2].currentFrame==3)
					{
						//trace("Clicked body 3")
						displayKart.Body.gotoAndStop(3)
						
					}
					
					if (myItems[2].currentFrame==4)
					{
						//trace("Clicked body 4")
						displayKart.Body.gotoAndStop(4)
						
					}
					
					if (myItems[2].currentFrame==5)
					{
						//trace("Clicked body 5")
						displayKart.Body.gotoAndStop(5)
						
					}
					
				}//end of if target is item [2] 
				
				
				
			}//end of if kartbody
			
			
			if (event.target==mySelectors[0]||event.target==mySelectors[1])
			{
				
				try
				{
					for (var i:int=0 ;i<(myItems.length);i++)
						{
							myItems[i].removeEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
							myItems[i].removeEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem)
							removeChild(myItems[i])
						}
					myItems.length=0
					
				}catch (error:Error){trace("Whoops")}
				if (event.target==mySelectors[0])
				{
					SetupItems("Wheels")
				}
				if (event.target==mySelectors[1])
				{
					SetupItems("Bodies")
				}
				
				
			}//end of if selectors[0]||[1]
			
			
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
			trace("End of panorama");
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
		
		public function SetupItems(itemType)
		{
			
			if (itemType=="Wheels")
			{
				myItems=[new KartWheel(),new KartWheel(),new KartWheel()]
				
				
				for (var i:int=0 ;i<(myItems.length);i++)
				{
				
					addChild(myItems[i])
					
					
					myItems[i].x=(i+1)*110
					myItems[i].y=340
					
					
				}//end of for loop to add items to stage
				
				
			}
			if (itemType=="Bodies")
			{
				myItems=[new KartBody(),new KartBody(),new KartBody()]
				
				for (var j:int=0 ;j<(myItems.length);j++)
				{
				
					addChild(myItems[j])
						
						
						myItems[j].x=(j+1)*110
						myItems[j].y=365
						myItems[j].scaleX=0.5
						myItems[j].scaleY=0.5
				}
				
			}
			
			for (var k:int=0 ;k<(myItems.length);k++)
			{
				
				myItems[k].gotoAndStop(k+1)
				myItems[k].buttonMode = true;
				myItems[k].addEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
				myItems[k].addEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem)
				//trace("Item is ", myItems[k])
				
			}//end of for loop to add items to stage
			

			
						
			
		}//end of setup items
		
		public function SetupSelectors()
		{	
			mySelectors=[new partSelector,new partSelector]
			
			for (var j:int=0 ;j<(mySelectors.length);j++)
			{
				
				addChild(mySelectors[j])
				mySelectors[j].gotoAndStop(j+1)
				
				
				mySelectors[j].y=282.05
				
				
				mySelectors[j].buttonMode = true;
				mySelectors[j].addEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
				mySelectors[j].addEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem)
				
			}//end of for loop to add items to stage
			mySelectors[0].x=13
			mySelectors[1].x=13+36
			
			
		}//end of setup selectors
		
	}
	
}
