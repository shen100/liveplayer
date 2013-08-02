package com.shen100.live.model
{	
	import com.shen.core.geom.Size;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class LayoutProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "LayoutProxy";
		
		public var ifControlBar:Boolean;
		public var videoScaleMode:String;
		public var aspectRatio:Size;	//页面设置的视频宽高比
		
		public function LayoutProxy() {
			super(NAME);
		}
		
	}
}

