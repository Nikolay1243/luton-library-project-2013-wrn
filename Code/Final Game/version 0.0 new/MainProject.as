package 
{
	import flash.display.*
	
	

	public class MainProject extends MovieClip{
	
		public function MainProject()
		{
			trace("MainProject Constructor")
			var myFPS=new FPSCounter()
			
			addChild(myFPS)
			myFPS.x=800


			
			
			
			
		}
	}
}