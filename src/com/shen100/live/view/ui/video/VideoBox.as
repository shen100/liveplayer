package com.shen100.live.view.ui.video
{	
	import com.shen.core.geom.Size;
	import com.shen.core.util.Util;
	import com.shen100.live.model.constant.VideoScaleMode;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.net.NetStream;
	
	public class VideoBox extends Sprite {
	
		private var bgColor:uint = 0x000000;
		private var bg:Shape;
		private var _video:Video;
		private var _metaDataVideoSize:Size;
		private var _videoScaleMode:String;
		
		public function VideoBox() {
			bg = new Shape();
			addChild(bg);
			_video = new Video();
			_video.smoothing = true;
			addChild(_video);
		}
		
		public function set videoStream(value:NetStream):void {
			_video.attachNetStream(value);
			scaleVideo(width, height);
		}

		public function set metaDataVideoSize(size:Size):void {
			_metaDataVideoSize = size;
			scaleVideo(width, height);	
		}
		
		public function set videoScaleMode(value:String):void {
			_videoScaleMode = value;
			scaleVideo(width, height);
		}

		private function scaleVideo(width:Number, height:Number):void {
			var x:Number;
			var y:Number;
			var size:Size;
			if(_metaDataVideoSize) {
				switch(_videoScaleMode) {
					case VideoScaleMode.FIT:{
						size = Util.scaleToMax(_metaDataVideoSize.width, _metaDataVideoSize.height, width, height);
						x = (width - size.width) / 2;
						y = (height - size.height) / 2;
						break;
					}
					case VideoScaleMode.FILL:{
						x = y = 0;
						size = new Size(width, height);
						break;	
					}
					case VideoScaleMode.CLIP:{
						size = Util.scaleToClip(_metaDataVideoSize.width, _metaDataVideoSize.height, width, height);
						x = (width - size.width) / 2;
						y = (height - size.height) / 2;
						break;
					}
				}
				_video.width = size.width;
				_video.height = size.height;
				_video.x = x;
				_video.y = y;
			}else {
				_video.width = width;
				_video.height = height;
				_video.x = 0;
				_video.y = 0;	
			}
		}
		
		private function drawBackground(width:Number, height:Number):void {
			bg.graphics.clear();
			bg.graphics.beginFill(bgColor);
			bg.graphics.drawRect(0, 0, width, height);
			bg.graphics.endFill();	
		}
	
		override public function get width():Number {
			return bg.width;
		}
		
		override public function get height():Number {
			return bg.height;
		}
		
		public function setSize(width:Number, height:Number):void {
			drawBackground(width, height);
			scaleVideo(width, height);
		}
		
	}
}















