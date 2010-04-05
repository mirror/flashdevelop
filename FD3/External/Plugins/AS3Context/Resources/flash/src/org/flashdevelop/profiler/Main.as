package org.flashdevelop.profiler
{
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Philippe
	 */
	public class Main extends Sprite 
	{
		private var sampler:SampleRunner;
		private var update:Timer;
		private var id:int;
		
		public function Main():void 
		{
			addEventListener("allComplete", loadComplete);
		}
		
		private function loadComplete(e:Event):void 
		{
			removeEventListener("allComplete", loadComplete);
			
			var info:LoaderInfo = e.target as LoaderInfo;
			FlashConnect.trace("[Profiling: " + info.url + "]");
			
			id = getTimer();
			FlashConnect.onReturnData = onReturn;
			
			update = new Timer(1000, 1);
			update.addEventListener(TimerEvent.TIMER, update_timer);
			update.start();
			
			sampler = new SampleRunner();
		}
		
		private function onReturn(status:String):void
		{
			var res:XML = XML(status);
			if (res.@status == "0") // continue
			{
				update.start();
			}
			else if (res.@status == "1") // invalid: stop profiling
			{
				FlashConnect.onReturnData = null;
				sampler.cleanup();
			}
			else if (res.@status == "4") // run GC
			{
				System.gc();
			}
		}
		
		private function update_timer(e:TimerEvent):void 
		{
			sampler.pause();
			
			var out:Array = [ id + "/" + System.totalMemory ];
			sampler.liveObjectsCount(out);
			
			var msg:XML = <flashconnect cmd="notify" guid="ccf2c534-db6b-4c58-b90e-cd0b837e61c4">
				{ out.join("|") }
			</flashconnect>;
			FlashConnect.send(msg);
			
			sampler.resume();
		}
		
	}
	
}