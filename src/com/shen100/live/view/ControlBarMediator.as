package com.shen100.live.view
{	
	import com.shen.uicomps.components.ToggleButton;
	import com.shen100.live.ApplicationFacade;
	import com.shen100.live.model.LivePlayerProxy;
	import com.shen100.live.view.ui.control.ControlBar;
	import com.shen100.live.view.ui.control.VolumeBox;
	
	import flash.display.StageDisplayState;
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ControlBarMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ControlBarMediator";
		
		private var playerProxy:LivePlayerProxy;
		
		public function ControlBarMediator(viewComponent:ControlBar) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			playerProxy = facade.retrieveProxy(LivePlayerProxy.NAME) as LivePlayerProxy;
			controlBar.volumeBox.value = playerProxy.volume;
			controlBar.playOrPause.addEventListener(ToggleButton.TOGGLE, 			onPlayOrPauseToggle);
			controlBar.volumeBox.addEventListener(VolumeBox.VOLUME_CHANGED, 		onChangeVolume);
			controlBar.enterOrExitFullScreen.addEventListener(ToggleButton.TOGGLE, 	onFullScreenToggle);
		}
		
		private function onPlayOrPauseToggle(event:Event):void {
			if(controlBar.playOrPause.isOn) {
				sendNotification(ApplicationFacade.PAUSE);	
			}else {
				sendNotification(ApplicationFacade.RESUME);
			}
		}
	
		private function onFullScreenToggle(event:Event):void {
			if(controlBar.stage.displayState == StageDisplayState.FULL_SCREEN) {
				controlBar.stage.displayState = StageDisplayState.NORMAL;
			}else {
				controlBar.stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}

		private function onChangeVolume(event:Event):void {
			var volume:Number = controlBar.volumeBox.value;
			sendNotification(ApplicationFacade.CHANGE_VOLUME, volume);
		}
		
		override public function listNotificationInterests():Array {
			return [
				LivePlayerProxy.PLAYER_STATE_CHANGED
			];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case LivePlayerProxy.PLAYER_STATE_CHANGED: {
//					if(playerProxy.playerState == PlayerState.PLAYING) {
//						controlBar.playOrPause.isOn = false;	
//					}else {
//						controlBar.playOrPause.isOn = true;	
//					}
					break;
				}
			}
		}
	
		private function get controlBar():ControlBar {
			return viewComponent as ControlBar;
		}
		
	}
}