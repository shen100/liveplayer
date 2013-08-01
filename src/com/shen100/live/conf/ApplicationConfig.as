package com.shen100.live.conf {
	
	public class ApplicationConfig {
		
		public static const MAIN_GSLB_URL:String = "http://main.gslb.ku6.com/broadcast/sub?channel={channel}&ref=out";
		public static const BACK_GSLB_URL:String = "http://back.gslb.ku6.com/broadcast/sub?channel={channel}&ref=out";
		
		public function ApplicationConfig() {
			throw new TypeError("ApplicationConfig 不是构造函数。");
		}
	}
}