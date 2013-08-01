package com.shen.live.model.constant
{	
	public class VideoScaleMode {
		
		public static const FIT:String 		= "fit";   //等比缩放,在显示区域内
		public static const CLIP:String 	= "clip";  //等比缩放，超出显示区域的部分被裁剪
		public static const FILL:String 	= "fill";  //填充显示区域,　视频会被拉伸
		
		public function VideoScaleMode() {
			throw new TypeError("VideoScaleMode 不是构造函数。");	
		}
		
	}
}