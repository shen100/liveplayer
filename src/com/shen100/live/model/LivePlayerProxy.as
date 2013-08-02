package com.shen100.live.model {
	
	import com.adobe.serialization.json.JSON;
	import com.shen.core.net.HttpService;
	import com.shen100.live.model.constant.PlayerState;
	import com.shen100.live.model.vo.VideoInfoVO;
	
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class LivePlayerProxy extends Proxy {
		
		public static const NAME:String = "LivePlayerProxy";
		
		public static const PLAYER_STATE_CHANGED:String 		= "playerStateChanged";
		public static const VIDEO_INFO_RESULT:String 			= "videoInfoResult";
		public static const VIDEO_INFO_FAULT:String 			= "videoInfoFault";
		public static const VIDEO_CONNECT_SUCCESS:String 		= "videoConnectSuccess";
		public static const VIDEO_META_DATA:String 				= "videoMetaData";
//		public static const VIDEO_BUFFER_EMPTY:String 			= "videoBufferEmpty";
//		public static const VIDEO_BUFFER_FULL:String 			= "videoBufferFull";
		
		private static const PLAYER_NAME:String 	= "LivePlayer";
		private static const MAJOR:int 				= 1;
		private static const MINOR:int 				= 1;
		private static const REVISION:int 			= 5;
		
		public var debugServerUrl:String;
		public var channel:String;	//频道id
		
		private var _playerState:String = PlayerState.PENDING;	//播放器的状态
		
		private var videoInfoVec:Vector.<VideoInfoVO>; //所有的视频流, 其实就是同一视频的多个备份地址
		private var index:int;	//当前要播放的视频流索引
		
		private var _conn:NetConnection;
		private var _netStream:NetStream;
		private var _reconnTime:Number = 5000;	//断开连接时，5秒后重连
		private var _timeoutTime:Number = 5000; //5秒钟还没连上，就认为超时
		private var _timeoutId:uint;
		private var _bufferTime:Number = 2;
		private var _volume:Number = 1;
		private var _metaData:Object;
		
		public function LivePlayerProxy() {
			super(NAME);	
		}
		
		public function loadVideoInfo(url:String):void {
			playerState = PlayerState.PENDING;
			var httpService:HttpService = new HttpService();
			httpService.addResponder(onVideoInfoResult, onVideoInfoFault);
			httpService.send(url);
		}
		
		/**
		 *  {
		 *    "Level":"1",
		 *    "Gone":"137001",
		 *    "Location":"http://61.147.115.150/broadcast/sub?channel=910&id=ku6_live",
		 *    "MultiURL":"152001;http://183.60.130.140/broadcast/sub?channel=910&id=ku6_live|152002;http://183.60.130.261/broadcast/sub?channel=910&id=ku6_live"
		 *  }
		 */
		public function onVideoInfoResult(data:Object):void {
			index = 0;
			videoInfoVec = new Vector.<VideoInfoVO>();
			var result:Object = com.adobe.serialization.json.JSON.decode(data as String);
			var videoInfoData:Object = new Object();
			videoInfoData.gone 		= result.Gone;
			videoInfoData.location 	= debugServerUrl ? debugServerUrl : result.Location;
			var videoInfo:VideoInfoVO = new VideoInfoVO(videoInfoData);
			videoInfoVec.push(videoInfo);
			
			var backup:String = result.MultiURL;
			if(backup) {
				var backupArr:Array = backup.split("|");	
				for each (var goneAndLocation:String in backupArr) {
					var goneAndLocArr:Array = goneAndLocation.split(";");
					videoInfoData = new Object();
					videoInfoData.gone 		= goneAndLocArr[0];
					videoInfoData.location 	= debugServerUrl ? debugServerUrl : goneAndLocArr[1];
					videoInfo = new VideoInfoVO(videoInfoData);
					videoInfoVec.push(videoInfo);
				}
			}
			playerState = PlayerState.READY;
			sendNotification(LivePlayerProxy.VIDEO_INFO_RESULT);
		}
		
		public function onVideoInfoFault(info:Object):void {
			sendNotification(LivePlayerProxy.VIDEO_INFO_FAULT);	
		}
		
		public function play():void {
			disconnect();
			connect();	
		}
		
		private function connect():void {
			_conn = new NetConnection();
			_conn.client = this;
			_conn.addEventListener(NetStatusEvent.NET_STATUS, onNetConnStatus);
			_timeoutId = setTimeout(reconnect, _timeoutTime);
			_conn.connect(netConnUrl);	
		}
		
		private function reconnect():void {
			disconnect();
			index++;
			if(index >= videoInfoVec.length) {
				index = 0;	
			}
			setTimeout(connect, _reconnTime);
		}
		
		private function disconnect():void {
			if(_conn) {
				_conn.removeEventListener(NetStatusEvent.NET_STATUS, onNetConnStatus);
				_conn.close();
				_conn = null;
			}
			if(_netStream) {
				_netStream.removeEventListener(NetStatusEvent.NET_STATUS, onStreamStatus);
				_netStream.close();
				_netStream = null;	
			}	
		}
		
		public function onBWDone(... rest):Boolean {
			return true;
		}
		
		private function onNetConnStatus(event:NetStatusEvent):void {
			trace(event.info.code);
			if(_timeoutId) {
				clearTimeout(_timeoutId);
			}
			switch( event.info.code ) {
				case "NetConnection.Connect.Success": {
					_netStream = new NetStream(_conn);
					if(this.protocol == VideoInfoVO.HTTP) {
						_netStream.bufferTime = _bufferTime;	
					}else {
						_netStream.bufferTime = 0;	
					}
					_netStream.client = this;
					volume = _volume;
					_netStream.addEventListener(NetStatusEvent.NET_STATUS, onStreamStatus);
					_timeoutId = setTimeout(reconnect, _timeoutTime);
					_netStream.play(streamPath);
					sendNotification(LivePlayerProxy.VIDEO_CONNECT_SUCCESS);
					break;	
				}
				case "NetConnection.Connect.Failed": {
					reconnect();	
					break;
				}
				case "NetConnection.Connect.Closed": {
					reconnect();	
					break;
				}
			}
		}
		
		public function onMetaData(infoObject:Object):void {
			_metaData = infoObject; 	
			sendNotification(LivePlayerProxy.VIDEO_META_DATA);
		}
		
		private function onStreamStatus(event:NetStatusEvent):void {
			trace(event.info.code);
			if(_timeoutId) {
				clearTimeout(_timeoutId);
			}
			switch( event.info.code ) {
				case "NetStream.Play.StreamNotFound": {
					reconnect();
					break;
				}
			}
		}
	
		private function get protocol():String {
			return videoInfoVec[index].protocol;
		}
		
		private function get netConnUrl():String {
			return videoInfoVec[index].netConnUrl;
		}
		
		private function get streamPath():String {
			return videoInfoVec[index].streamPath;
		}

		public function pause():void {
			_netStream.pause();	
		}
		
		public function resume():void {
			_netStream.resume();
		}
		
		public function get netStream():NetStream {
			return _netStream;
		}
		
		public function set volume(value:Number):void {
			if(_volume != value) {
				_volume = value;
				if(_netStream) {
					var sound:SoundTransform = new SoundTransform();
					sound.volume = _volume;
					_netStream.soundTransform = sound;
				}
			}
		}
		
		public function get volume():Number {
			return _volume;
		}
		
		public function set playerState(value:String):void {
			_playerState = value;
			sendNotification(LivePlayerProxy.PLAYER_STATE_CHANGED);
		}
		
		public function get playerState():String {
			return _playerState;
		}
		
		public function get metaDataWidth():Number {
			return _metaData ? _metaData.width : 0;
		}
		
		public function get metaDataHeight():Number {
			return _metaData ? _metaData.height : 0;
		}
		
		public function get version():String {
			return PLAYER_NAME + " " + MAJOR + "." + MINOR + "." + REVISION;
		}
		
	}
}