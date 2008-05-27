package com.suda.AS3BlipLib.objects
{
	public class BlipSubscription
	{
		public var trackingUserPath:String;
		public var trackedUserPath:String;
		public var transport:BlipTransport;
		
		public function BlipSubscription(data:Object = null)
		{
			if (null != data) {
				this.trackingUserPath = data.tracking_user_path;
				this.trackedUserPath = data.tracked_user_path;
				this.transport = new BlipTransport(data.transport);
			}
		}

	}
}