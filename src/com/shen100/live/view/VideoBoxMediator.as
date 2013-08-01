package com.shen100.live.view
{	
	import com.shen.core.geom.Size;
	import com.shen100.live.model.LayoutProxy;
	import com.shen100.live.model.LivePlayerProxy;
	import com.shen100.live.model.constant.PlayerState;
	import com.shen100.live.view.ui.video.VideoBox;
	
	import flash.utils.Timer;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class VideoBoxMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "VideoBoxMediator";
	
		private var layoutProxy:LayoutProxy;
		private var playerProxy:LivePlayerProxy;
		
		private var bufferTimer:Timer;
		
		public function VideoBoxMediator(viewComponent:VideoBox) {
			super(NAME, viewComponent);	
		}
		
		override public function onRegister():void {
			layoutProxy  = facade.retrieveProxy(LayoutProxy.NAME) 		as LayoutProxy;
			playerProxy  = facade.retrieveProxy(LivePlayerProxy.NAME) 	as LivePlayerProxy;
			videoBox.videoScaleMode = layoutProxy.videoScaleMode;
		}
		
		override public function listNotificationInterests():Array {
			return [
						LivePlayerProxy.VIDEO_INFO_RESULT,
						LivePlayerProxy.VIDEO_META_DATA,
						LivePlayerProxy.VIDEO_CONNECT_SUCCESS
//						LivePlayerProxy.VIDEO_BUFFER_EMPTY,
//						LivePlayerProxy.VIDEO_BUFFER_FULL,
				];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case LivePlayerProxy.VIDEO_CONNECT_SUCCESS: {
						videoBox.videoStream = playerProxy.netStream;
					break;
				}
				case LivePlayerProxy.VIDEO_META_DATA: {
					videoBox.videoSize = new Size(playerProxy.videoWidth, playerProxy.videoHeight);
					break;
				}
//				case LivePlayerProxy.VIDEO_BUFFER_EMPTY: {
//					listenBuffer();
//					break;
//				}
//				case LivePlayerProxy.VIDEO_BUFFER_FULL: {
//					stopListenBuffer();
//					break;
//				}
			}
		}
		
		private function get videoBox():VideoBox {
			return viewComponent as VideoBox;
		}
	}
}










