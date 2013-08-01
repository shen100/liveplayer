package com.shen100.live.controller {
	
	import com.shen100.live.model.LivePlayerProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ResumeCommand extends SimpleCommand{
		
		override public function execute( note:INotification ) : void {
			var playerProxy:LivePlayerProxy = facade.retrieveProxy(LivePlayerProxy.NAME) as LivePlayerProxy;
			playerProxy.resume();
		}
	}
}