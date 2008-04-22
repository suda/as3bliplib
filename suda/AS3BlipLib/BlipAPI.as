package com.suda.AS3BlipLib
{
	  
	import com.adobe.serialization.json.*;
	import com.arc90.rpc.*;
	import com.arc90.rpc.events.ResultEvent;
	import com.arc90.rpc.rest.*;
	
	import flash.events.*;

	public class BlipAPI
	{
		public static const UPDATE_TYPE_STATUS:String = "Status";
		public static const UPDATE_TYPE_DM:String = "DirectedMessage";
		
		private var AppName:String;
		private var Service:RESTService;
		
		private var limit:int = 50;
		private var login:String = '';
		private var passwd:String = '';
		
		public function BlipAPI(AppName:String="AS3BlipLib")
		{
			this.AppName = AppName;
  
			this.Service = new RESTService('http://api.blip.pl');
			 	
			this.Service.resultFormat = RESTService.RESULT_FORMAT_JSON;
			this.Service.contentType = RESTService.CONTENT_TYPE_JSON;
		 	this.Service.userAgent = this.AppName;
		 	this.Service.headers = {'X-Blip-API': '0.02'};
		}
		
		public function LogIn(login:String, passwd:String):void {
			this.login = login;
			this.passwd = passwd;
			this.Service.setCredentials(this.login, this.passwd);
			
			// Pobranie jednego statusu dla sprawdzenia poprawności loginu i hasła
			this.GetDashboard(1);
		}
 
 		/***************************************************
		 * Bliposphere
		 ***************************************************/
		public function GetBliposphere():void
		{			
			this.GetResource('/bliposphere', BlipAPIResultEvent.GET_BLIPOSPHERE);
		}
		
		/***************************************************
		 * Dashboard
		 ***************************************************/
		public function GetDashboard(since:int = -1):void
		{
			if (since < 1) {
				this.GetResource('/dashboard', BlipAPIResultEvent.GET_DASHBOARD);
			} else {
				this.GetResource('/dashboard/since/'+since, BlipAPIResultEvent.GET_DASHBOARD);
			}					
		}
		
		public function GetUserDashboard(login:String, since:int = -1):void
		{
			if (-1 == since) {
				this.GetResource('/users/'+login+'/dashboard', BlipAPIResultEvent.GET_USER_DASHBOARD);
			} else {
				this.GetResource('/users/'+login+'/dashboard/since/'+since, BlipAPIResultEvent.GET_USER_DASHBOARD);
			}					
		}
		
		/***************************************************
		 * Users
		 ***************************************************/
		public function GetUser(login:String):void
		{
			this.GetUserByPath('/users/'+login);
		}
		
		public function GetUserByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_USER);
		}
		
		/***************************************************
		 * Statuses
		 ***************************************************/
		public function GetStatuses(limit:int = -1, since:int = -1, all:Boolean = false):void
		{
			var limitStr:String = '';
			var sinceStr:String = '';
			
			if (-1 < limit) {
				limitStr = '?limit='+limit;
			}
			
			if (-1 < since) {
				sinceStr = '/'+since+'/';
				if (all) {
					sinceStr += 'all_since';
				} else {
					sinceStr += 'since';
				}
			}	
	
			this.GetResource('/statuses'+sinceStr+limitStr, BlipAPIResultEvent.GET_STATUSES);
		}
		
		public function GetUserStatuses(login:String, limit:int = -1, since:int = -1):void
		{
			if (-1 != since) {
				this.GetResource('/users/'+login+'/statuses/'+since+'/since', BlipAPIResultEvent.GET_USER_STATUSES);
			} else if (-1 != limit) {
				this.GetResource('/users/'+login+'/statuses?limit='+limit, BlipAPIResultEvent.GET_USER_STATUSES);
			}					
		}
		
		public function GetStatus(id:int):void
		{
			this.GetStatusByPath('/statuses/'+id);
		}
		
		public function GetStatusByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_STATUS);
		}
		
		public function SetStatus(text:String):void
		{
			if (text.length > 160) {
				text = text.substr(0, 160);
			}
			this.Service.method = RESTServiceMethod.POST;
			this.Service.resource = '/statuses';
			this.Service.request = {"status" : {"body" : text}};
			this.Service.eventName = BlipAPIResultEvent.SET_STATUS;
			this.Service.send();		
		}
		
		public function DelStatus(id:int):void
		{
			this.Service.method = RESTServiceMethod.DELETE;
			this.Service.resource = '/statuses/'+id;
			this.Service.eventName = BlipAPIResultEvent.DEL_STATUS;
			this.Service.send();		
		}
		
		/***************************************************
		 * Avatar
		 ***************************************************/
		public function GetAvatar(login:String):void
		{
			this.GetAvatarByPath('/users/'+login+'/avatar');
		}
		
		public function GetAvatarByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_AVATAR);
		}
		
		/***************************************************
		 * Background
		 ***************************************************/
		public function GetBackground(login:String):void
		{
			this.GetResource('/users/'+login+'/background', BlipAPIResultEvent.GET_BACKGROUND);
		}
		
		/***************************************************
		 * Updates
		 ***************************************************/
		public function GetUpdates(limit:int = -1, since:int = -1, all:Boolean = false):void
		{
			var limitStr:String = '';
			var sinceStr:String = '';
			
			if (-1 < limit) {
				limitStr = '?limit='+limit;
			}
			
			if (-1 < since) {
				sinceStr = '/'+since+'/';
				if (all) {
					sinceStr += 'all_since';
				} else {
					sinceStr += 'since';
				}
			}	
	
			this.GetResource('/updates'+sinceStr+limitStr, BlipAPIResultEvent.GET_UPDATES);
		}
		
		public function GetUserUpdates(login:String, limit:int = -1, since:int = -1):void
		{
			if (-1 != since) {
				this.GetResource('/users/'+login+'/updates/'+since+'/since', BlipAPIResultEvent.GET_USER_UPDATES);
			} else if (-1 != limit) {
				this.GetResource('/users/'+login+'/updates?limit='+limit, BlipAPIResultEvent.GET_USER_UPDATES);
			}					
		}
		
		public function GetUpdate(id:int):void
		{
			this.GetUpdateByPath('/updates/'+id);
		}
		
		public function GetUpdateByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_UPDATE);
		}
		
		public function SendUpdate(text:String):void
		{
			if (text.length > 160) {
				text = text.substr(0, 160);
			}
			this.Service.method = RESTServiceMethod.POST;
			this.Service.resource = '/updates';
			this.Service.request = {"update" : {"body" : text}};
			this.Service.eventName = BlipAPIResultEvent.SEND_UPDATE;
			this.Service.send();		
		}
		
		public function DelUpdate(id:int):void
		{
			this.Service.method = RESTServiceMethod.DELETE;
			this.Service.resource = '/updates/'+id;
			this.Service.eventName = BlipAPIResultEvent.DEL_UPDATE;
			this.Service.send();		
		}
		
		/***************************************************
		 * Directed Messages
		 ***************************************************/
		public function GetDms(limit:int = -1, since:int = -1, all:Boolean = false):void
		{
			var limitStr:String = '';
			var sinceStr:String = '';
			
			if (-1 < limit) {
				limitStr = '?limit='+limit;
			}
			
			if (-1 < since) {
				sinceStr = '/'+since+'/';
				if (all) {
					sinceStr += 'all_since';
				} else {
					sinceStr += 'since';
				}
			}	
	
			this.GetResource('/directed_messages'+sinceStr+limitStr, BlipAPIResultEvent.GET_DMS);
		}
		
		public function GetUserDms(login:String, limit:int = -1, since:int = -1):void
		{
			if (-1 != since) {
				this.GetResource('/users/'+login+'/directed_messages/'+since+'/since', BlipAPIResultEvent.GET_USER_DMS);
			} else if (-1 != limit) {
				this.GetResource('/users/'+login+'/directed_messages?limit='+limit, BlipAPIResultEvent.GET_USER_DMS);
			}					
		}
		
		public function GetDm(id:int):void
		{
			this.GetDmByPath('/directed_messages/'+id);
		}
		
		public function GetDmByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_DM);
		}
		
		public function SendDm(recipient:String, text:String):void
		{
			if (text.length > 160) {
				text = text.substr(0, 160);
			}
			this.Service.method = RESTServiceMethod.POST;
			this.Service.resource = '/directed_messages';
			this.Service.request = {"directed_message" : {"body" : text, "recipient" : recipient}};
			this.Service.eventName = BlipAPIResultEvent.SEND_DM;
			this.Service.send();		
		}
		
		public function DelDm(id:int):void
		{
			this.Service.method = RESTServiceMethod.DELETE;
			this.Service.resource = '/directed_messages/'+id;
			this.Service.eventName = BlipAPIResultEvent.DEL_DM;
			this.Service.send();		
		}
		
		/***************************************************
		 * Movie
		 ***************************************************/
		public function GetMovie(id:int):void
		{
			this.GetMovieByPath('/updates/'+id+'/movie');
		}
		
		public function GetMovieByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_MOVIE);
		}
		
		/***************************************************
		 * Recording
		 ***************************************************/
		public function GetRecording(id:int):void
		{
			this.GetRecordingByPath('/updates/'+id+'/recording');
		}
		
		public function GetRecordingByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_RECORDING);
		}
		
		/***************************************************
		 * Pictures
		 ***************************************************/
		public function GetUpdatePictures(id:int):void
		{
			this.GetUpdatePicturesByPath('/updates/'+id+'/pictures');
		}
		
		public function GetUpdatePicturesByPath(path: String):void
		{
			this.GetResource(path, BlipAPIResultEvent.GET_UPDATE_PICTURES);
		}
		
		public function GetPictures(limit:int = 20, since:int = -1):void
		{
			var limitStr:String = '';
			var sinceStr:String = '';
			
			limitStr = '?limit='+limit;
			
			if (-1 < since) {
				sinceStr = since+'/all_since';
			} else {
				sinceStr = 'all';
			}	
			
			this.GetResource('/pictures/'+sinceStr+limitStr, BlipAPIResultEvent.GET_PICTURES);				
		}
		
		/***************************************************
		 * Pictures
		 ***************************************************/
		public function GetShortlinks(limit:int = 20, since:int = -1):void
		{
			var limitStr:String = '';
			var sinceStr:String = '';
			
			limitStr = '?limit='+limit;
			
			if (-1 < since) {
				sinceStr = since+'/all_since';
			} else {
				sinceStr = 'all';
			}	
			
			this.GetResource('/shortlinks/'+sinceStr+limitStr, BlipAPIResultEvent.GET_SHORTLINKS);				
		}
		/***************************************************
		 * Subscriptions
		 ***************************************************/
		public function GetSubs():void
		{			
			this.GetResource('/subscriptions', BlipAPIResultEvent.GET_SUBS);
		}
		
		public function GetSubsFrom():void
		{			
			this.GetResource('/subscriptions/from', BlipAPIResultEvent.GET_SUBS_FROM);
		}
		
		public function GetSubsTo():void
		{			
			this.GetResource('/subscriptions/to', BlipAPIResultEvent.GET_SUBS_TO);
		}
		
		public function GetUserSubs(login:String):void
		{			
			this.GetResource('/users/'+login+'/subscriptions', BlipAPIResultEvent.GET_USER_SUBS);
		}
		
		public function GetUserSubsFrom(login:String):void
		{			
			this.GetResource('/users/'+login+'/subscriptions/from', BlipAPIResultEvent.GET_USER_SUBS_FROM);
		}
		
		public function GetUserSubsTo(login:String):void
		{			
			this.GetResource('/users/'+login+'/subscriptions/to', BlipAPIResultEvent.GET_USER_SUBS_TO);
		}
		
		public function SetSub(login:String, www:Boolean = true, im:Boolean = true):void
		{			
			this.Service.method = RESTServiceMethod.PUT;
			this.Service.resource = '/subscriptions/'+login;
			this.Service.request = {"subscription" : {"www" : (www) ? 1 : 0 , "im" : (im) ? 1 : 0}};
			this.Service.eventName = BlipAPIResultEvent.SET_SUB;
			this.Service.send();
		}
		
		public function DelSub(login:String):void
		{
			this.Service.method = RESTServiceMethod.DELETE;
			this.Service.resource = '/subscriptions/'+login;
			this.Service.eventName = BlipAPIResultEvent.DEL_SUB;
			this.Service.send();		
		}
		
		/*
			FUNKCJE POMOCNICZE
		*/
		
		public function LoginFromPath(path: String):String
		{
			return path.split('/')[2];
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			this.Service.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		private function GetResource(resource:String, eventName:String = ''):void
		{
			this.Service.method = RESTServiceMethod.GET;
			this.Service.resource = resource;
			this.Service.eventName = eventName;
			this.Service.send();	
		}
	  
	}
}