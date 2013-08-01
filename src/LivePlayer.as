package 
{	
	import com.shen.live.ApplicationFacade;
	import com.shen.live.managers.MouseSleepManager;
	import com.shen.live.events.MouseSleepEvent;
	import com.shen.live.view.ui.control.ControlBar;
	import com.shen.live.view.ui.video.VideoBox;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import caurina.transitions.Tweener;
	
	//[SWF(width="600", height="400", backgroundColor="#999999", frameRate="30")]
	public class LivePlayer extends Sprite {
		
		private static const APP_FACADE_NAME:String = "LivePlayer_Runtime_" + getTimer();
		
		private var facade:ApplicationFacade = ApplicationFacade.getInstance( APP_FACADE_NAME );
		
		private var _playerWidth:Number 	= 0;  //播放器的宽度
		private var _playerHeight:Number 	= 0;  //播放器的高度
		
		public var data:Object;  //外部传来的数据
		
		public var videoBox:VideoBox;  			//视频容器
		public var controlBar:ControlBar;  		//控制条
	
		public function LivePlayer() {
			videoBox = new VideoBox();
			addChild(videoBox);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			MouseSleepManager.listenMouseSleep(stage);
			data = loaderInfo.parameters;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, onResize);
			setSize(stage.stageWidth, stage.stageHeight);
			facade.startup(this);
		}
		
		private function onResize(event:Event):void {
			setSize(stage.stageWidth, stage.stageHeight);
		}
		
		public function setSize(width:Number, height:Number):void {
			_playerWidth = width;
			_playerHeight = height;	
			if(stage) {
				var videoBoxHeight:Number = height;
				if(controlBar) {
					if(stage.displayState != StageDisplayState.FULL_SCREEN) {
						videoBoxHeight -= controlBar.height;
						if(videoBoxHeight <= 0) {
							videoBoxHeight += controlBar.height;
							controlBar.visible = false;
						}else {
							controlBar.visible = true;	
						}
					}		
					videoBox.setSize(width, videoBoxHeight);
					controlBar.width = width;
					controlBar.y = height - controlBar.height;
				}else {
					videoBox.setSize(width, height);	
				}	
			}
		}
		
		public function createControlBar():void {
			controlBar = new ControlBar();
			addChild(controlBar);
			setSize(_playerWidth, _playerHeight);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
		}
		
		private function onFullScreen(event:FullScreenEvent):void {
			if(stage.displayState == StageDisplayState.FULL_SCREEN) {
				stage.addEventListener(MouseSleepEvent.SLEEP, 			onSleep);
				stage.addEventListener(MouseSleepEvent.WAKE, 			onWake);	
			}else if(controlBar.stage.displayState == StageDisplayState.NORMAL) {
				Mouse.show();
				Tweener.removeTweens(controlBar);
				controlBar.y = _playerHeight - controlBar.height;
				stage.removeEventListener(MouseSleepEvent.SLEEP, 		onSleep);
				stage.removeEventListener(MouseSleepEvent.WAKE, 		onWake);	
			}
		}
		
		private function onSleep(event:Event):void {
			Mouse.hide();
			Tweener.addTween(controlBar, {y:_playerHeight, time:0.8});
		}
		
		private function onWake(event:Event):void {
			Mouse.show();
			Tweener.addTween(controlBar, {y:_playerHeight - controlBar.height, time:0.5});	
		}
		
	}
}



