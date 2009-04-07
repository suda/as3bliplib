package com.suda.AS3BlipLib.objects
{
	import com.suda.*;

	public class BlipLog extends CustomArrayCollection
	{
		public var login:String;
		public var tag:String;
		public var lastId:int;
		
		public function BlipLog(source:Object = null)
		{
			super(null);
			for each (var item:Object in source) {
				var update:*;				
				if (BlipUpdate.UPDATE_TYPE_STATUS == item.type) {
					update = new BlipStatus(item);
				} else if (BlipUpdate.UPDATE_TYPE_DM == item.type) {
					update = new BlipDirectedMessage(item);
				} else if (BlipUpdate.UPDATE_TYPE_PM == item.type) {
					update = new BlipPrivateMessage(item);
				} else if (BlipUpdate.UPDATE_TYPE_NOTICE == item.type) {
					update = new BlipNotice(item);
				}
				
				if (item.hasOwnProperty('user')) {
					update.user = new BlipUser(item.user);
					update.userPath = update.user.userPath;			
				}				
				
				if (this.lastId < item.id) {
					this.lastId = item.id;	
				}				
				this.addItem(update);
			}
		}
		
		private function htmlspecialchars(str:String):String {
			str = str.replace(/\</g, "&lt;");
			str = str.replace(/\>/g, "&gt;");
			return str;
		}
		
		public function AddUpdates(data:*):void {		
			if (0 < data.length) {	
				
				for (var i:int = data.length; i > 0; i--) {
					if (data[i-1].id > this.lastId) {
						data[i-1].body = htmlspecialchars(data[i-1].body);
						this.addItemAt(data[i-1], 0);
					}
				}
				
				this.lastId = data.lastId;
			}
		}
		
	}
}