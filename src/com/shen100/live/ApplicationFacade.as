package com.shen100.live
{	
	import com.shen100.live.controller.ChangeVolumeCommand;
	import com.shen100.live.controller.LoadVideoInfoCommand;
	import com.shen100.live.controller.PauseCommand;
	import com.shen100.live.controller.PlayCommand;
	import com.shen100.live.controller.ResumeCommand;
	import com.shen100.live.controller.StartupCommand;
	import com.shen100.live.model.LivePlayerProxy;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade {
		
		public static const STARTUP:String  			= "startup";
		public static const LOAD_VIDEOINFO:String  		= "loadVideoInfo";
		public static const PLAY:String  				= "play";
		public static const PAUSE:String 				= "pause";
		public static const RESUME:String 				= "resume";
		public static const CHANGE_VOLUME:String 		= "changeVolume";
		
		public function ApplicationFacade(key:String) {
			super(key);    
		}
		
		public static function getInstance(key:String):ApplicationFacade {
			if ( instanceMap[key] == null ){
				instanceMap[key] = new ApplicationFacade(key);
			}
			return instanceMap[key] as ApplicationFacade;
		}
		
		override protected function initializeController() : void {
			super.initializeController();            
			registerCommand( STARTUP, 								StartupCommand );
			registerCommand( LOAD_VIDEOINFO, 						LoadVideoInfoCommand );
			registerCommand( LivePlayerProxy.VIDEO_INFO_RESULT, 	PlayCommand );
			registerCommand( PAUSE, 								PauseCommand );
			registerCommand( RESUME, 								ResumeCommand );
			registerCommand( CHANGE_VOLUME, 						ChangeVolumeCommand );
		}
		
		public function startup( app:LivePlayer ):void {
			sendNotification( STARTUP, app );
		}
		
	}
}