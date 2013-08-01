package com.shen.live.controller {
	
	import com.shen.live.model.LivePlayerProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class PauseCommand extends SimpleCommand  {
		
		override public function execute( note:INotification ) : void {
			var playerProxy:LivePlayerProxy = facade.retrieveProxy(LivePlayerProxy.NAME) as LivePlayerProxy;
			playerProxy.pause();
		}
	}
	
}