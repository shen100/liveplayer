package com.shen100.live.model.vo {
	
	public class VideoInfoVO {
		
		public static const HTTP:String = "http";
		public static const RTMP:String = "rtmp";
		
		public var protocol:String;
		public var gone:String;
		public var netConnUrl:String;
		public var streamPath:String;

		/**
		 *  {
		 *    "Level":"1",
		 *    "Gone":"137001",
		 *    "Location":"http://61.147.115.150/broadcast/sub?channel=910&id=ku6_live",
		 *    "MultiURL":"152001;http://183.60.130.140/broadcast/sub?channel=910&id=ku6_live|
		 *                152002;http://183.60.130.261/broadcast/sub?channel=910&id=ku6_live"
		 *  }
		 */
		public function VideoInfoVO(data:Object) {
			gone = data.gone;
			if(data.location.indexOf("rtmp://") != -1) {
				protocol 	= RTMP;
				var tempUrl:String = data.location;
				var index:int 	= tempUrl.lastIndexOf("/") + 1;
				netConnUrl 		= tempUrl.substring( 0, index );
				streamPath 	  	= tempUrl.substring( index, tempUrl.length);
			}else {
				protocol = HTTP;
				netConnUrl = null;
				streamPath = data.location;
			}
		}
	}
}









