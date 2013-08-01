package com.shen100.live.model
{	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class LayoutProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "LayoutProxy";
		
		public var ifControlBar:Boolean;
		public var videoScaleMode:String;
		
		public function LayoutProxy() {
			super(NAME);
		}
		
	}
}

