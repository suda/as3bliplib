package com.suda.AS3BlipLib.objects
{
	public class BlipUpdate
	{
		public var id:int;
		public var type:String;
		public var createdAt:String;
		public var transport:BlipTransport;
		public var body:String;
		public var userPath:String;
		
		public var picturesPath:String;
		public var recordingPath:String;
		public var moviePath:String;
		
		public var user:BlipUser;
		
		public static const UPDATE_TYPE_STATUS:String = "Status";
		public static const UPDATE_TYPE_DM:String = "DirectedMessage";
		
		public function BlipUpdate(data:Object = null)
		{
			if (null != data) {
				this.id = data.id;
				this.type = data.type;
				this.createdAt = data.created_at;
				this.transport = new BlipTransport(data.transport);				
				this.body = data.body;
				this.userPath = data.user_path;
				
				this.picturesPath = (data.hasOwnProperty('pictures_path')) ? data.pictures_path : '';
				this.recordingPath = (data.hasOwnProperty('recording_path')) ? data.recording_path : '';
				this.moviePath = (data.hasOwnProperty('movie_path')) ? data.movie_path : '';
			}
		}

	}
}