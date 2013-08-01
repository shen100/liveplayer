package com.shen.live.model.constant
{	
	public class PlayerState {
		
		public static const PENDING:String     	= "playerStatePending";	//未准备好(即加载视频信息之前)
		public static const READY:String		= "playerStateReady";	//准备好了(视频信息加载之后)，可以播视频
		public static const PRELOAD:String		= "playerStatePreload";	//预加载
		public static const PLAYING:String 		= "playerStatePlaying";	//正在播放
		public static const PAUSE:String 		= "playerStatePause";	//暂停
		public static const STOP:String			= "playerStateStop";	//停止
		
		public function PlayerState() {
			throw new TypeError("PlayerState 不是构造函数。");	
		}
		
	}
}