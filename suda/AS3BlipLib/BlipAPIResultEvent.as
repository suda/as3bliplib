package com.suda.AS3BlipLib
{
	import flash.events.Event;
	import com.arc90.rpc.events.FaultEvent;
	import com.arc90.rpc.events.ResultEvent;

	public class BlipAPIResultEvent extends ResultEvent
	{
		public static const GET_BLIPOSPHERE:String = "getBliposphere";
		
		public static const GET_DASHBOARD:String = "getDashboard";
		public static const GET_USER_DASHBOARD:String = "getUserDashboard";
		
		public static const GET_USER:String = "getUser";
		
		public static const GET_STATUSES:String = "getStatuses";
		public static const GET_USER_STATUSES:String = "getUserStatuses";		
		public static const GET_STATUS:String = "getStatus";
		public static const SET_STATUS:String = "setStatus";
		public static const DEL_STATUS:String = "delStatus";
		
		public static const GET_AVATAR:String = "getAvatar";
		public static const GET_BACKGROUND:String = "getBackground";
		
		public static const GET_UPDATES:String = "getUpdates";
		public static const GET_USER_UPDATES:String = "getUserUpdates";
		public static const GET_UPDATE:String = "getUpdate";
		public static const SEND_UPDATE:String = "sendUpdate";
		public static const DEL_UPDATE:String = "delUpdate";
		
		public static const GET_DMS:String = "getDms";
		public static const GET_USER_DMS:String = "getUserDms";
		public static const GET_DM:String = "getDm";
		public static const SEND_DM:String = "sendDm";
		public static const DEL_DM:String = "delDm";
		
		public static const GET_MOVIE:String = "getMovie";
		public static const GET_RECORDING:String = "getRecording";
		
		public static const GET_UPDATE_PICTURES:String = "getUpdatePictures";
		public static const GET_PICTURES:String = "getPictures";
		
		public static const GET_SHORTLINKS:String = "getShortlinks";
		
		public static const GET_SUBS:String = "getSubs";
		public static const GET_SUBS_FROM:String = "getSubsFrom";
		public static const GET_SUBS_TO:String = "getSubsTo";
		public static const GET_USER_SUBS:String = "getUserSubs";
		public static const GET_USER_SUBS_FROM:String = "getUserSubsFrom";
		public static const GET_USER_SUBS_TO:String = "getUserSubsTo";
		public static const SET_SUB:String = "setSub";
		public static const DEL_SUB:String = "delSub";
		
		public function BlipAPIResultEvent(type:String, statusCode:Number, statusMessage:String, headers:Object, result:Object=null)
		{
			super(type, statusCode, statusMessage, headers, result);
		}
		
	}
}