package com.shen100.live.view.ui.control
{	
	import com.shen.uicomps.components.Button;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.ButtonSkin;
	import com.shen.uicomps.components.skin.Skin;
	import com.shen100.live.view.skin.VolumeIconSkin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class VolumeBox extends Sprite {
		
		public static const VOLUME_CHANGED:String 	= "volumeChanged";
		
		private var leftPadding:Number = 5;
		private var rightPadding:Number = 5;
		private var gap:Number = 5;
		private var background:SkinnableComponent;
		private var volumeIcon:VolumeIcon;
		private var thumb:Button;
		private var track:SkinnableComponent;
		
		private var _value:Number = 1;
		private var volumeBefore:Number;	//点击VolumeIcon时，先保存音量的大小，然后静音
		
		public function VolumeBox() {
			background = new SkinnableComponent();
			background.skin = new Skin(new VolumeBgAsset());
			addChild(background);
			
			volumeIcon = new VolumeIcon();
			volumeIcon.skin = new VolumeIconSkin(new VolumeIconAsset());
			addChild(volumeIcon);
			volumeIcon.x = leftPadding;
			volumeIcon.y = (background.height - volumeIcon.height) / 2;
			
			track = new SkinnableComponent();
			track.skin = new Skin(new VolumeTrackAsset());
			addChild(track);
			track.buttonMode = true;
			track.x = background.width - track.width - rightPadding;
			track.y = (background.height - track.height) / 2;
			
			thumb = new Button();
			thumb.skin = new ButtonSkin(new VolumeThumbAsset());
			addChild(thumb);
		
			thumb.x = track.x;
			thumb.y = (background.height - thumb.height) / 2;
		
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, 	onMouseDownThumb);
			track.addEventListener(MouseEvent.CLICK,		onTrackClick);
			volumeIcon.addEventListener(MouseEvent.CLICK,	onVolumeIconClick);
		}
		
		private function onVolumeIconClick(event:MouseEvent):void {
			if(!isNaN(volumeBefore)) {
				value = volumeBefore;
				volumeBefore = NaN;
			}else {
				volumeBefore = value;
				value = 0;
			}
			var e:Event = new Event(VolumeBox.VOLUME_CHANGED);
			dispatchEvent(e);
		}
		
		private function onTrackClick(event:MouseEvent):void {
			volumeBefore = NaN;
			var theX:Number = mouseX - thumb.width / 2;
			if(theX < track.x) {
				theX = track.x;	
			}else if(theX > track.x + track.width - thumb.width) {
				theX = track.x + track.width - thumb.width;	
			}
			var theVolume:Number = (theX - track.x) / (track.width - thumb.width);
			value = theVolume;
			var e:Event = new Event(VolumeBox.VOLUME_CHANGED);
			dispatchEvent(e);
		}
		
		private function onMouseDownThumb(event:MouseEvent):void {
			volumeBefore = NaN;
			var bounds:Rectangle = new Rectangle(track.x, thumb.y, track.width - thumb.width, 0);
			thumb.startDrag(false, bounds);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void {
			var theVolume:Number = (thumb.x - track.x) / (track.width - thumb.width);
			value = theVolume;
			var e:Event = new Event(VolumeBox.VOLUME_CHANGED);
			dispatchEvent(e);
		}
		
		private function onMouseUpStage(event:MouseEvent):void {
			thumb.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpStage);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}	
		
		public function get value():Number {
			return _value;
		}
		
		public function set value(value:Number):void {
			if(value < 0) {
				value = 0;	
			}
			_value = value;
			thumb.x = track.x + (track.width - thumb.width) * value;
			if(thumb.x > track.x + track.width - thumb.width) {
				thumb.x = track.x + track.width - thumb.width;	
			}
			volumeIcon.volume = _value;
		}
	}
}






















