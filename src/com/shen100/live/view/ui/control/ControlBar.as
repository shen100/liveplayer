package com.shen100.live.view.ui.control {
	
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.ToggleButton;
	import com.shen.uicomps.components.skin.Skin;
	import com.shen.uicomps.components.skin.ToggleButtonSkin;
	
	import flash.display.Sprite;
	
	public class ControlBar extends Sprite {
	
		private var gap:Number = 6;
		private var bg:SkinnableComponent;
	
		public var enterOrExitFullScreen:FullScreenButton;
		public var playOrPause:ToggleButton;
		public var volumeBox:VolumeBox;
		
		public function ControlBar() {
			bg = new SkinnableComponent();
			bg.skin = new Skin(new ControlBarBgAsset());
			addChild(bg);
			
			playOrPause = new ToggleButton();
			var playOrPauseSkin:ToggleButtonSkin = new ToggleButtonSkin(new PlayOrPauseToggleButtonAsset()); 
			playOrPause.skin = playOrPauseSkin;
			addChild(playOrPause);	
			playOrPause.isOn = false;
			playOrPause.y = (bg.height - playOrPause.height) / 2;
			playOrPause.x = playOrPause.y;
			
			enterOrExitFullScreen = new FullScreenButton();
			var enterOrExitSkin:ToggleButtonSkin = new ToggleButtonSkin(new EnterOrExitFullScreenToggleButtonAsset());                            
			enterOrExitFullScreen.skin = enterOrExitSkin;
			addChild(enterOrExitFullScreen);
			enterOrExitFullScreen.x = bg.width - enterOrExitFullScreen.width - gap;
			enterOrExitFullScreen.y = (bg.height - enterOrExitFullScreen.height) / 2;
			
			volumeBox = new VolumeBox();
			addChild(volumeBox);
			volumeBox.x = enterOrExitFullScreen.x - volumeBox.width - gap;
			volumeBox.y = (bg.height - volumeBox.height) / 2;
		}
		
		override public function set width(value:Number):void {
			bg.width = value;
			enterOrExitFullScreen.x = bg.width - enterOrExitFullScreen.width - gap;
			volumeBox.x = enterOrExitFullScreen.x - volumeBox.width - gap;
		}
	}
}