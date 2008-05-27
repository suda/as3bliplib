package com.suda.AS3BlipLib.objects
{
	public class BlipAvatar
	{
		public var id:int;
		public var url:String;
		public var url15:String;
		public var url30:String;
		public var url50:String;
		public var url90:String;
		public var url120:String;
		
		public function BlipAvatar(data:Object = null)
		{
			if (null != data) {
				this.id = data.id;
				this.url = data.url;
				/*
				   Skąd brać podstawowy adres url tego nie wiadomo. 
				   Robić jakiś diff url i url_x?
				   Przydało by się coś a'la url_base ;)
				   Na razie ustawione na sztywno.  
				*/
				var urlBase = 'http://www.blip.pl';
				this.url15 = urlBase+data.url_15;
				this.url30 = urlBase+data.url_30;
				this.url50 = urlBase+data.url_50;
				this.url90 = urlBase+data.url_90;
				this.url120 = urlBase+data.url_120;
			}
		}

	}
}