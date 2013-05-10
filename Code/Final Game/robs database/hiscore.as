package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;

	

	public class hiscore extends MovieClip {
	
	private var bVariables = true;
	
		public function hiscore()
		{
			trace ("hello");
			submitBtn.addEventListener(MouseEvent.CLICK, handleSubmitClick,false,0,true);
			
			showHighScores();

		}
	
	//this version uses data formatted as an array
	private function loadCompleteHandlerA(event:Event):void{
			var loader:URLLoader = URLLoader(event.target);
			
			//tbHighscores.text=loader.data;
			
			var rawdata:String =loader.data;
			trace (rawdata);
			var scores:Array = new Array();
			scores = rawdata.split("}");
			trace ("splitting now");
			trace (scores[0]);
			return;
			
			
			trace (scores[0].username);
			trace (scores[0].score);
			
			var length:int = scores.length;
			for (var i:int=0;i<length;i++)
			{
				for (var item in scores[i]) {
						trace(item +" "+ scores[i][item]); 
				}
			}
		}

		//this version uses variables encoding
		private function loadCompleteHandler(event:Event):void {
			//tbHighscores.appendText("load complete");
            var loader:URLLoader = URLLoader(event.target);
			//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
            trace(loader.data);
    
			tbHighscores.text="";
			
			for (var i:int=1;i<20;i++)
			{
				var varname:String = "username" + i;
				var varscore:String = "score" + i;
				//tbHighscores.appendText(varname);
				if (!loader.data[varname]) continue;
				
				tbHighscores.appendText(loader.data[varname])
				tbHighscores.appendText(" ");
				tbHighscores.appendText(loader.data[varscore])
				tbHighscores.appendText("\n");
			}
        }

		protected function handleSubmitClick(event:MouseEvent):void {
			
			var variables:URLVariables = new URLVariables();
			var varSend:URLRequest = new URLRequest("submitscore.asp");
			var varLoader:URLLoader = new URLLoader();
			varSend.method = URLRequestMethod.GET;

			variables.user_name = tfUsername.text;
			variables.score=tfScore.text;;
			
			varSend.data = variables;
			varLoader.addEventListener(Event.COMPLETE, submitCompleteHandler);
			varLoader.load(varSend);
		}
		
		protected function showHighScores()
		{
			//attempt to load existing hi score list
			var loader:URLLoader = new URLLoader();
			var request:URLRequest;
			if (bVariables)
			{
				request = new URLRequest("ShowHighScores.asp");
				loader.dataFormat = URLLoaderDataFormat.VARIABLES;
				loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			}
			else
			{
				request = new URLRequest("paramsA.txt");//gethiscoresA.asp");
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.addEventListener(Event.COMPLETE,loadCompleteHandlerA);
			}
			
			loader.load(request);
		}
		
		protected function submitCompleteHandler(event:Event):void 
		{
			showHighScores();
		}
		
	}
	
}