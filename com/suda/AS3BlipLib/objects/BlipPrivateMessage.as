package com.suda.AS3BlipLib.objects
{
	public class BlipPrivateMessage extends BlipUpdate
	{
		[Bindable]
		public var recipientPath:String;

		[Bindable]
		public var recipient:BlipUser;
		
		public function BlipPrivateMessage(data:Object = null)
		{
			super(data);
			
			if (null != data) {
				this.recipientPath = data.recipient_path;
			}
		}

	}
}