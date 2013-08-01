package com.shen.live.controller
{	
	import com.shen.live.ApplicationFacade;
	import com.shen.live.model.LayoutProxy;
	import com.shen.live.view.ApplicationMediator;
	import com.shen.live.view.ControlBarMediator;
	import com.shen.live.view.VideoBoxMediator;
	
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







