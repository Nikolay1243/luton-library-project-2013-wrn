package  {
	import flash.display.MovieClip;
	import flash.text.*
	import fl.controls.Button;
	import flash.events.*
	import LevelGenerationClass

	public class MenuScreen extends MovieClip {
		
		
		
		public var mainMenuButton = new Button();
		public var startButton = new Button();
		public var helpButton = new Button();
		public var leaderboardsButton = new Button();
		
		public var startLevel= new LevelGenerationClass()
		
		public var project_Font:Font=new Project_Font()
		
		public var myTextFormat=new TextFormat()
		
		
		public function MenuScreen() 
		{
			
			MakeButtons()
			
			//SetUpButtons()
		}
		
		
		public function MakeButtons()
		{
			addChild(startLevel)
			
			addChild(mainMenuButton)
			
			
			
			startButton.label="Start Game"
			
			startButton.move(100,0)
			startButton.setSize(200,50)
			
			myTextFormat.font=project_Font.fontName 
			myTextFormat.size=30
			myTextFormat.color = 0xFF0000
		
			startButton.setStyle("embedFonts", true);
			startButton.setStyle("textFormat", myTextFormat)
			
			addChild(startButton)
			
			
			
			startButton.addEventListener(MouseEvent.CLICK,ClickStartGame);
			mainMenuButton.addEventListener(MouseEvent.CLICK,ClickMainMenu);
			
			
		}
		
		public function ClickStartGame(e:Event)
		{
			startLevel.SetUpLevel1()
			startButton.enabled=false
			
			
		}
		
		public function ClickMainMenu(e:Event)
		{
			
			
			
		}
		
		
		
		
	}
	
}
