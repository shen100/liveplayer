package com.shen100.live.controller
{	
	import com.shen100.live.ApplicationFacade;
	import com.shen100.live.model.LayoutProxy;
	import com.shen100.live.view.ApplicationMediator;
	import com.shen100.live.view.ControlBarMediator;
	import com.shen100.live.view.VideoBoxMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand {
		
		override public function execute( note:INotification ) : void {
			var app:LivePlayer = note.getBody() as LivePlayer;
			var appMediator:ApplicationMediator = new ApplicationMediator(app);
			facade.registerMediator( appMediator );
			facade.registerMediator( new VideoBoxMediator(app.videoBox) );
	
			var layoutProxy:LayoutProxy = facade.retrieveProxy(LayoutProxy.NAME) as LayoutProxy;
			if(layoutProxy.ifControlBar) {
				appMediator.createControlBar();
				facade.registerMediator( new ControlBarMediator(app.controlBar) );
			}
			sendNotification(ApplicationFacade.LOAD_VIDEOINFO);
		}
		
	}
}







