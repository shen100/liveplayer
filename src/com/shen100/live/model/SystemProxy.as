package com.shen100.live.model
{	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class SystemProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "SystemProxy";
		
		public var ifDebug:Boolean;
		public var flashVersion:String;
		
		public function SystemProxy() {
			super(NAME);	
		}
		
	}
}