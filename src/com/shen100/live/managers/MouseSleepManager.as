package com.shen100.live.managers
{
	import com.shen100.live.events.MouseSleepEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class MouseSleepManager
	{
		public function MouseSleepManager()
		{
			throw new TypeError("MouseSleepManager 不是构造函数。");
		}
		
		private static var display:DisplayObject;
		private static var runtime:int;
		private static var interval:int = 2000;
		private static var timeoutId:uint;
		
		public static function listenMouseSleep(target:DisplayObject):void {
			display = target;
			display.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			runtime = getTimer();
			timeoutId = setTimeout(onSleep, interval);
		}
		
		private static function onMouseMove(event:Event):void {
			var curTime:int = getTimer();
			if(curTime - runtime >= interval) {
				display.dispatchEvent(new MouseSleepEvent(MouseSleepEvent.WAKE));	
			}
			runtime = curTime;
			if(timeoutId) {
				clearTimeout(timeoutId);	
			}
			timeoutId = setTimeout(onSleep, interval);
		}
		
		private static function onSleep():void {
			timeoutId = 0;
			display.dispatchEvent(new MouseSleepEvent(MouseSleepEvent.SLEEP));
		}
	}
}






