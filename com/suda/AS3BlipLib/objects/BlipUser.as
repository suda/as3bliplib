package com.suda.AS3BlipLib.objects
{
	public class BlipUser
	{
		public var id:int;
		public var login:String;
		public var currentStatusPath:String;
		public var backgroundPath:String;
		public var avatarPath:String;
		public var location:String;
		public var userPath:String;
		
		public var currentStatus:BlipStatus;
		public var background:BlipBackground;
		public var avatar:BlipAvatar;		
		
		public function BlipUser(data:Object = null)
		{
			if (null != data) {
				this.id = data.id;
				this.login = data.login;
				this.currentStatusPath = data.current_status_path;
				this.backgroundPath = data.background_path;				
				this.avatarPath = data.avatar_path;
				this.location = data.location;
				this.userPath = '/users/'+this.login;
			}
		}

	}
}