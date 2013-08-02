package com.shen100.live.controller
{
	import com.shen.core.geom.Size;
	import com.shen100.live.model.LayoutProxy;
	import com.shen100.live.model.LivePlayerProxy;
	import com.shen100.live.model.SystemProxy;
	import com.shen100.live.model.constant.VideoScaleMode;
	
	import flash.system.Capabilities;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand  {
		
		override public function execute( note:INotification ) : void {
			var app:LivePlayer = note.getBody() as LivePlayer;
	
			var playerProxy:LivePlayerProxy  		= new LivePlayerProxy();
			var systemProxy:SystemProxy  			= new SystemProxy();
			var layoutProxy:LayoutProxy  			= new LayoutProxy();
			
			facade.registerProxy( systemProxy );
			facade.registerProxy( layoutProxy );
			facade.registerProxy( playerProxy );

			var data:Object = app.data;
			playerProxy.channel			= data.p;
			playerProxy.debugServerUrl	= data.url;
			layoutProxy.ifControlBar 	= data.controlBar  == "0" ? false : true;
			layoutProxy.videoScaleMode 	= data.scaleMode == "clip"    ? VideoScaleMode.CLIP
										    : (data.scaleMode == "fill" ? VideoScaleMode.FILL 
										    : VideoScaleMode.FIT);
			layoutProxy.aspectRatio		= data.wRatio && data.hRatio ? new Size(data.wRatio, data.hRatio) : null;
			systemProxy.flashVersion 	= Capabilities.version;
			systemProxy.ifDebug 		= data.ifDebug	== "1" ? true : false;
		}
	}
}
























