package com.shen100.live.events {
	
	import flash.events.Event;
	
	public class MouseSleepEvent extends Event {
		
		public static const SLEEP:String 			= "sleep";
		public static const WAKE:String 			= "wake";
	
		public function MouseSleepEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			var event:MouseSleepEvent = new MouseSleepEvent(type, bubbles, cancelable);
			return event;
		}
	}
}


