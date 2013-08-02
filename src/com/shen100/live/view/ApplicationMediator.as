package com.shen100.live.view
{	
	import com.shen100.live.model.LivePlayerProxy;
	
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ApplicationMediator";
		
		private var playerProxy:LivePlayerProxy;
		
		public function ApplicationMediator(viewComponent:LivePlayer) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			playerProxy = facade.retrieveProxy( LivePlayerProxy.NAME) as LivePlayerProxy;
			addRightMenuItem(playerProxy.version);
		}
		
		private function addRightMenuItem(text:String):void {
			var menu:ContextMenu = app.contextMenu;
			if(!menu) {
				menu = new ContextMenu();
			}
			var menuItem:ContextMenuItem = new ContextMenuItem(text, false, false);
			menu.customItems.push(menuItem);
			menu.hideBuiltInItems();
			app.contextMenu = menu;
		}
		
		override public function listNotificationInterests():Array {
			return [
			
			];
		}
		
		override public function handleNotification(note:INotification):void {

		}
		
		public function createControlBar():void {
			app.createControlBar();
		}
		
		private function get app():LivePlayer {
			return viewComponent as LivePlayer;
		}
	}
}


