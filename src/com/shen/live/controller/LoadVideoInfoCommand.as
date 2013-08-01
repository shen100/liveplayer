package com.shen.live.controller {
	
	import com.shen.live.conf.ApplicationConfig;
	import com.shen.live.model.LivePlayerProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class LoadVideoInfoCommand extends SimpleCommand {
		
		override public function execute( note:INotification ) : void {
			var playerProxy:LivePlayerProxy = facade.retrieveProxy(LivePlayerProxy.NAME) as LivePlayerProxy;
			var url:String = ApplicationConfig.MAIN_GSLB_URL.replace("{channel}", playerProxy.channel);
			playerProxy.loadVideoInfo(url);
		}
		
	}
}