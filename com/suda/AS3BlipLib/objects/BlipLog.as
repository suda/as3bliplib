package com.suda.AS3BlipLib.objects
{
	import com.suda.AS3BlipLib.objects.*;

	public class BlipLog extends BlipArrayCollection
	{
		public var login:String;
		public var tag:String;
		public var lastId:int;
		
		public function BlipLog(source:Object = null)
		{
			super(null);
			for each (var item:Object in source) {
				var update:*;				
				if ('Status' == item.type) {
					update = new BlipStatus(item);
				} else if ('DirectedMessage' == item.type) {
					update = new BlipDirectedMessage(item);
				}
				if (this.lastId < item.id) {
					this.lastId = item.id	
				}				
				this.addItemAt(update, 0);
			}
		}
		
	}
}