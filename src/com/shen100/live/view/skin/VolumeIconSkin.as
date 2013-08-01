package com.shen100.live.view.skin
{	
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.MovieClip;
	
	public class VolumeIconSkin extends Skin {
		
		private var _asset:MovieClip;
		
		public function VolumeIconSkin(asset:MovieClip = null) {
			mouseChildren = false;
			if(asset) {
				_asset = asset;
				addChild(_asset);
				value = 100;
			}
		}
		
		public function set value(value:int):void {
			switch(value) {
				case 100:{
					_asset.gotoAndStop("v100");
					break;
				}
				case 75:{
					_asset.gotoAndStop("v75");
					break;
				}
				case 50:{
					_asset.gotoAndStop("v50");
					break;
				}
				case 25:{
					_asset.gotoAndStop("v25");
					break;
				}
				case 0:{
					_asset.gotoAndStop("v0");
					break;
				}
			}
		}
	}
}



