package com.shen100.live.view.ui.control
{	
	import com.shen.uicomps.components.ToggleButton;
	
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	
	public class FullScreenButton extends ToggleButton {
	
		public function FullScreenButton() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);		
		}
		
		private function onFullScreen(event:FullScreenEvent):void {
			if(stage.displayState == StageDisplayState.NORMAL) {	
				if(!isOn) {
					isOn = true;	
				}
				if(mouseX < 0 || mouseX > width || mouseY < 0 || mouseY > height) {
					currentState = "up";	
				}
			}
		}
	}
}













