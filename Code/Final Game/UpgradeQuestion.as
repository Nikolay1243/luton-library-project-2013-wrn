package  {
	
	
	import flash.events.AsyncErrorEvent;
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	
	import fl.controls.Button;
	import mx.core.ButtonAsset;
	import flashx.textLayout.accessibility.TextAccImpl;
	
	
	public class UpgradeQuestion extends MovieClip 
	{
		private var questionsArray:Array=[]
		private var answersArray:Array=[]
		private var buttonArray:Array=[]
		
		private var myTextFormat=new TextFormat()
		private var project_Font:Font=new Project_Font()
		
		private var currentQuestion:int
		private var correctAnswer:int
		
		public function UpgradeQuestion() {
			trace("UpgradeQuestion constructor")
			
			var n:int = Math.round( Math.random() * 3 );
			SetupQuestions()
			SetupAnswers(n)
			SetupAnswerButtons()
			
			//currentQuestion=0
			
		}
		
		public function SetupQuestions()
		{
			trace("SetupQuestions")
			questionsArray=["Question1",
						   "Question2",
						   "Question3"
						   ]
						   
						   
		}
		
		public function SetupAnswerButtons()
		{
			trace("SetupAnswerButtons")
			buttonArray=[new Button(),new Button(),new Button()]
			
			myTextFormat.font=project_Font.fontName 
			myTextFormat.size=25
			myTextFormat.color = 0xFFFFFF
			
			
			
			for (var i:int=0 ;i<(buttonArray.length);i++)
			{
				addChild(buttonArray[i])
				buttonArray[i].setStyle("embedFonts", true);
				buttonArray[i].setStyle("textFormat", myTextFormat)
				
				if (i==0)
				{
					buttonArray[i].label="A"
					buttonArray[i].move(AnsA.x,AnsA.y)
					buttonArray[i].setSize(AnsA.width,AnsA.height)
				}
				
				if (i==1)
				{
					buttonArray[i].label="B"
					buttonArray[i].move(AnsB.x,AnsB.y)
					buttonArray[i].setSize(AnsB.width,AnsB.height)
				}
				
				if (i==2)
				{
					buttonArray[i].label="C"
					buttonArray[i].move(AnsC.x,AnsC.y)
					buttonArray[i].setSize(AnsC.width,AnsC.height)
				}
				
				
				
				
				buttonArray[i].buttonMode = true;
				
				
				//buttonArray[i].addEventListener(MouseEvent.MOUSE_OVER, this.CustomizeToolTip );
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, this.ClickItem) 
				
			}
		}
		
		public function ClickItem(event:MouseEvent)
		{
			if (event.target==buttonArray[0])
			{
				trace("Button 1")
				if (correctAnswer==0)
				{
					CheckCorrect.text="yes"
					trace ("Yay")
				}else {
				CheckCorrect.text="noo"
				trace ("Boo")
				}
			}
			if (event.target==buttonArray[1])
			{
				trace("Button 2")
				if (correctAnswer==1)
				{
					CheckCorrect.text="yes"
					trace ("Yay")
				}else{ 
				CheckCorrect.text="noo"
				trace ("Boo")
				}
			}
			if (event.target==buttonArray[2])
			{
				trace("Button 3")
				if (correctAnswer==2)
				{
					CheckCorrect.text="yes"
					trace ("Yay")
				}else {
				CheckCorrect.text="noo"
				trace ("Boo")
				}
				
				
			}
		}
		
		public function SetupAnswers(CurrentQuestion)
		{
			trace("SetupAnswers")
			
			
			
			
			
			
			//answersArray=[]
			answersArray.length=0
			if (CurrentQuestion==0)
			{
				this.QuestionBox.text=questionsArray[0]
				answersArray=["Q1 A",
							  "Q1 B",
							  "Q1 C",
							  ]
				correctAnswer=0
			}
			
			if (CurrentQuestion==1)
			{
				this.QuestionBox.text=questionsArray[1]
				answersArray=["Q2 A",
							  "Q2 B",
							  "Q2 C",
							  ] 
				correctAnswer=1
			}
			
			if (CurrentQuestion==2)
			{
				this.QuestionBox.text=questionsArray[2]
				answersArray=["Q3 A",
							  "Q3 B",
							  "Q3 C",
							  ]
							  
				correctAnswer=2
			}
			this.AnsAText.text=answersArray[0]
			this.AnsBText.text=answersArray[1]
			this.AnsCText.text=answersArray[2]
			
			
			
		}
		public function ChangeQuestion()
		{
			trace("ChangeQuestion")
			//this.QuestionBox.text="ChangeQuestion code"
		}
		
		public function randomRange(minNum:Number, maxNum:Number):Number   
		{  
    		return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);  
		}  
  
		//trace(randomRange(10, 20)); //A number between 10 and 20  
	}
	
}
