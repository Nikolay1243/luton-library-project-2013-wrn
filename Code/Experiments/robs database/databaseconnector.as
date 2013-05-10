package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.controls.Button;
	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	import flash.system.Security;

	public class databaseconnector extends MovieClip {
	
	private var bVariables = true;
	private var txtID:TextField;
	private var txtData:TextField;
	private var txtStatus:TextField;
	private var updateBtn:Button;
	private var selectBtn:Button;
	
		public function databaseconnector()
		{
			Security.allowDomain("http://www.cispdp.com") ;
			
			updateBtn = new Button();
			addChild(updateBtn);
			updateBtn.x=300;
			updateBtn.y=150;
			updateBtn.label="update";
			
			selectBtn = new Button();
			addChild(selectBtn);
			selectBtn.x=100;
			selectBtn.y=150;
			selectBtn.label="select";
			
			txtID = new TextField;
			addChild(txtID);
			txtID.x=100;
			txtID.y=60;
			txtID.width=100;
			txtID.height=60;
			txtID.text="id";
			txtID.border=true;
			txtID.selectable=true;
			txtID.type = TextFieldType.INPUT; 

			
			txtData = new TextField;
			addChild(txtData);
			txtData.x=210;
			txtData.y=60;
			txtData.width=300;
			txtData.height=60;
			txtData.text="data";
			txtData.border=true;
			txtData.selectable=true;
			txtData.type = TextFieldType.INPUT; 
			
			txtStatus = new TextField;
			addChild(txtStatus);
			txtStatus.x=100;
			txtStatus.y=250;
			txtStatus.width=410;
			txtStatus.height=30;
			txtStatus.text="status information will appear here";
			txtStatus.border=true;
			txtStatus.selectable=true;
			
			
			
			selectBtn.addEventListener(MouseEvent.CLICK, handleSelectClick,false,0,true);
			updateBtn.addEventListener(MouseEvent.CLICK, handleUpdateClick,false,0,true);
			

		}
	
		protected function handleSelectClick(event:MouseEvent):void {
			txtStatus.text="attempting to retrieve data from web";
			
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url="http://www.cispdp.com/fbgamedb/getdata.asp?user_name="+ txtID.text;
			request.method= URLRequestMethod.GET;

			loader.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.load(request);
		}
		
		protected function loadCompleteHandler(event:Event):void 
		{
			txtStatus.text="data retrieved from web";
            var loader:URLLoader = URLLoader(event.target);
            txtData.text=loader.data;

	
		}
		
		protected function handleUpdateClick(event:MouseEvent):void {
			txtStatus.text="attempting to update data to web";
			
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest();
			request.url="http://www.cispdp.com/fbgamedb/submitscore2.asp?user_name="+ txtID.text+"&data=" + txtData.text;
			request.method= URLRequestMethod.GET;

			loader.addEventListener(Event.COMPLETE, updateCompleteHandler);
			loader.load(request);
		}


		protected function updateCompleteHandler(event:Event):void 
		{
			txtStatus.text="data uploaded to web";

		}
		
	}
	
}